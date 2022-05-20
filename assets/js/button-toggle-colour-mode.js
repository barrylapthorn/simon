var toggleColourMode = function toggleColourMode(e) {
  if (e.currentTarget.classList.contains("dark:hidden")) {
    document.documentElement.classList.add("dark");
    localStorage.setItem("theme", "dark");
    return;
  }
  document.documentElement.classList.remove("dark");
  localStorage.setItem("theme", "light");
};

// Export if you're using this in a build.
export function buttonColourMode() {
  var toggleButtons = document.querySelectorAll(".colour-mode__btn");
  toggleButtons.forEach(function (btn) {
    btn.addEventListener("click", toggleColourMode);
  });
  // set initial theme
  if (localStorage.getItem("theme") === "dark") {
    document.documentElement.classList.add("dark");
  }
}
