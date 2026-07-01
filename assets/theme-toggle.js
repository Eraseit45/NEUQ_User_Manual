(function () {
  var key = "book-theme";
  var root = document.documentElement;
  var button = document.querySelector("[data-theme-toggle]");
  var icon = document.querySelector("[data-theme-toggle-icon]");

  function applyTheme(theme) {
    root.setAttribute("data-color-theme", theme);
    if (button) {
      button.setAttribute("aria-pressed", theme === "dark" ? "true" : "false");
      button.setAttribute("aria-label", theme === "dark" ? "切换浅色模式" : "切换夜间模式");
      button.setAttribute("title", theme === "dark" ? "切换浅色模式" : "切换夜间模式");
    }
    if (icon) {
      icon.textContent = theme === "dark" ? "☀" : "☾";
    }
  }

  function currentTheme() {
    return root.getAttribute("data-color-theme") || localStorage.getItem(key) || "light";
  }

  applyTheme(currentTheme());

  if (button) {
    button.addEventListener("click", function () {
      var next = currentTheme() === "dark" ? "light" : "dark";
      localStorage.setItem(key, next);
      applyTheme(next);
    });
  }
})();
