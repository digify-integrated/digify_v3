/**
 * Shows a confirmation dialog before discarding unsaved changes.
 * - If confirmed, redirects to the given page.
 * - If canceled, shows a notification that changes are safe.
 *
 * @param {string} pageLink - The URL to navigate to if the user confirms.
 * @returns {void}
 */
export const discardCreate = (pageLink) => {
  Swal.fire({
    title: 'Are you sure?',
    text: 'You will lose all unsaved changes!',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonText: 'Yes, discard it!',
    cancelButtonText: 'Cancel',
    customClass: {
      confirmButton: 'btn btn-warning mt-2',
      cancelButton: 'btn btn-secondary ms-2 mt-2'
    },
    reverseButtons: true,
  }).then(({ isConfirmed, dismiss }) => {
    if (isConfirmed) {
      window.location.href = pageLink;
    }
  });
};
