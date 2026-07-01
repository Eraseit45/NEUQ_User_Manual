# AGENTS.md

## Project

- This repository is a Hugo site using the `hugo-book` theme.
- Local path: `/home/erasemyself45/misc/blog`
- Hugo config: `hugo.yaml`
- Theme: `themes/hugo-book` as a Git submodule.
- Default branch: `master`

## Deployment Memory

- GitHub repository: `https://github.com/Eraseit45/NEUQ_User_Manual`
- Git remote: `git@github.com:Eraseit45/NEUQ_User_Manual.git`
- GitHub Pages URL: `https://eraseit45.github.io/NEUQ_User_Manual/`
- GitHub Pages build source: GitHub Actions workflow `.github/workflows/hugo-deploy.yml`
- Pages deployment was verified successful on 2026-07-01 with the public site returning HTTP 200.

## Local Commands

- Build: `hugo --minify`
- Run locally: `hugo server`

## Acceptance Criteria

- Changes are accepted only after they are pushed to `origin/master`.
- GitHub Actions must complete the Pages workflow successfully.
- The GitHub Pages URL `https://eraseit45.github.io/NEUQ_User_Manual/` must return HTTP 200 after deployment.

## Project Notes

- Generated output in `public/`, Hugo resources, and `.hugo_build.lock` should stay untracked.
- Prefer overriding theme files from project-level `layouts/` and `assets/` instead of editing the `themes/hugo-book` submodule.
- The sidebar file tree is customized to render sections only, not individual article pages.
- The mobile topbar includes a client-side light/dark theme toggle that stores its choice in `localStorage` under `book-theme`.
