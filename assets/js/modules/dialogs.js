import { showNotification } from './notifications.js';

export function discardCreate(pageLink) {
    Swal.fire({
        title: 'Are you sure?',
        text: 'You will lose all unsaved changes!',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, discard it!',
        cancelButtonText: 'Cancel',
        reverseButtons: true,
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = pageLink;
        } else if (result.dismiss === Swal.DismissReason.cancel) {
            showNotification('Cancelled', 'Your changes are safe.', 'info');
        }
    });
}
