document.addEventListener("DOMContentLoaded", function () {
  const menuButton = document.querySelector(".menu-toggle");
  const navLinks = document.querySelector(".nav-links");
  if (menuButton && navLinks) {
    menuButton.addEventListener("click", function () {
      const open = navLinks.classList.toggle("is-open");
      menuButton.setAttribute("aria-expanded", String(open));
      menuButton.textContent = open ? "Close" : "Menu";
    });
    navLinks.querySelectorAll("a").forEach(function (link) {
      link.addEventListener("click", function () {
        navLinks.classList.remove("is-open");
        menuButton.setAttribute("aria-expanded", "false");
        menuButton.textContent = "Menu";
      });
    });
  }

  const expandButton = document.querySelector(".expand-all");
  const pathways = Array.from(document.querySelectorAll(".accordion details"));
  function syncExpandButton() {
    if (!expandButton) return;
    const allOpen = pathways.length > 0 && pathways.every(function (item) { return item.open; });
    expandButton.textContent = allOpen ? "Collapse all pathways" : "Expand all pathways";
    expandButton.setAttribute("aria-expanded", String(allOpen));
  }
  if (expandButton) {
    expandButton.addEventListener("click", function () {
      const shouldOpen = !pathways.every(function (item) { return item.open; });
      pathways.forEach(function (item) { item.open = shouldOpen; });
      syncExpandButton();
    });
    pathways.forEach(function (item) { item.addEventListener("toggle", syncExpandButton); });
    syncExpandButton();
  }
});
