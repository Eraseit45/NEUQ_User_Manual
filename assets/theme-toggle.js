(function () {
  var key = "book-theme";
  var root = document.documentElement;
  var button = document.querySelector("[data-theme-toggle]");

  function applyTheme(theme) {
    root.setAttribute("data-color-theme", theme);
    if (button) {
      button.setAttribute("aria-pressed", theme === "dark" ? "true" : "false");
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
