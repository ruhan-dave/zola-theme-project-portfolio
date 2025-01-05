document.addEventListener("DOMContentLoaded", function() {
  // ---------------- Toggle Sidebar -------------------------
  document.getElementById('toggle-sidebar')?.addEventListener('click', toggleSidebar);

  // ---------------- Toggle Mobile menu -------------------------
  document.getElementById('toggle-mobile-menu')?.addEventListener('click', toggleMobileMenu);
});

function toggleSidebar() {
  let sidebar = document.getElementById('sidebar');
  if ([...sidebar.classList].includes('translate-x-0')) {
    document.body.style.removeProperty("overflow")
    sidebar.classList.remove('translate-x-0')
    sidebar.classList.add('-translate-x-full')
  } else {
    document.body.style.setProperty("overflow", "hidden")
    sidebar.classList.remove('-translate-x-full')
    sidebar.classList.add('translate-x-0')
  }
}

function toggleMobileMenu() {
  let menu = document.querySelector('#mobile-menu div.nav-links');
  let icon = document.querySelector('#toggle-mobile-menu i');
  if ([...menu.classList].includes('h-screen')) {
    document.body.classList.remove("overflow-hidden", "relative")
    document.documentElement.classList.remove("overscroll-none",)
    menu.classList.remove('h-screen')
    menu.classList.add('h-0')
    icon.classList.remove('bi-x-lg')
    icon.classList.add('bi-list')
  } else {
    document.body.classList.add("overflow-hidden", "relative")
    document.documentElement.classList.add("overscroll-none",)
    menu.classList.remove('h-0')
    menu.classList.add('h-screen')
    icon.classList.remove('bi-list')
    icon.classList.add('bi-x-lg')
  }
}
