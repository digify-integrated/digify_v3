/**
 * Highlights the active menu item and its parent menu based on the current URL.
 *
 * - Adds `.active` to matching child links.
 * - Adds `.here` and `.show` to parent items if a child link matches.
 *
 * @param {string} menuContainerSelector - CSS selector for the menu container.
 * @param {string} menuSelector - CSS selector for the menu items inside the container.
 * @returns {void}
 */
export const setHereClassForMenu = (menuContainerSelector, menuSelector) => {
  const currentUrl = window.location.href.split('?')[0];
  const menuContainer = document.querySelector(menuContainerSelector);

  if (!menuContainer) return;

  const firstLevelMenuItems = menuContainer.querySelectorAll(menuSelector);

  firstLevelMenuItems.forEach((menuItem) => {
    let hasChildMatch = false;
    const childLinks = menuItem.querySelectorAll('.menu-sub .menu-link');

    if (childLinks.length > 0) {
      childLinks.forEach((childLink) => {
        if (childLink.href.split('?')[0] === currentUrl) {
          hasChildMatch = true;
          childLink.classList.add('active');
        }
      });

      if (hasChildMatch) {
        menuItem.classList.add('here', 'show');
      }
    } else {
      const menuLink = menuItem.querySelector('.menu-link');

      if (menuLink?.closest('a')?.href.split('?')[0] === currentUrl) {
        menuItem.classList.add('here');
      }
    }
  });
};
