#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

message="${1:-Update site}"
remote="${REMOTE:-origin}"
branch="${BRANCH:-master}"
repo="${GITHUB_REPOSITORY:-Eraseit45/NEUQ_User_Manual}"
pages_url="${PAGES_URL:-https://eraseit45.github.io/NEUQ_User_Manual/}"
workflow="${WORKFLOW:-hugo-deploy.yml}"

echo "Building Hugo site..."
hugo --minify

if [[ -z "$(git status --short)" ]]; then
  echo "No changes to deploy."
  exit 0
fi

echo "Staging changes..."
git add -A

echo "Creating commit: $message"
git commit -m "$message"

echo "Pushing to $remote/$branch..."
if ! git push "$remote" "$branch"; then
  echo "Default push failed; retrying with system SSH config disabled..."
  git -c core.sshCommand='ssh -F /dev/null' push "$remote" "$branch"
fi

head_sha="$(git rev-parse HEAD)"
echo "Waiting for GitHub Pages workflow..."
run_id=""
for _ in {1..40}; do
  run_id="$(gh run list --repo "$repo" --workflow "$workflow" --branch "$branch" --limit 20 --json databaseId,headSha --jq '.[] | select(.headSha == "'"$head_sha"'") | .databaseId' | head -n 1)"
  if [[ -n "$run_id" ]]; then
    break
  fi
  sleep 3
done

if [[ -z "$run_id" ]]; then
  echo "Could not find a workflow run for $workflow on $branch at $head_sha." >&2
  exit 1
fi

gh run watch "$run_id" --repo "$repo" --exit-status

echo "Verifying GitHub Pages URL..."
curl -fsSI "$pages_url" >/dev/null

echo "Deployment complete: $pages_url"
