// events/eventHandlers.js
import { discardCreate } from '../modules/dialogs.js';
import { passwordAddOn } from '../modules/password.js';
import { copyToClipboard } from '../utilities/helpers.js';

/**
 * Initializes global event handlers for the application.
 *
 * - Handles "discard-create" button click and shows a confirmation dialog.
 * - Handles "copy-error-message" button click and copies error text to clipboard.
 * - Initializes password visibility toggle.
 *
 * @returns {void}
 */
export const initializeEventHandlers = () => {
    // Handle discard button clicks
    document.addEventListener('click', (event) => {
        if (event.target.id === 'discard-create') {
        const pageLink = document.getElementById('page-link')?.getAttribute('href');
            if (pageLink) {
                discardCreate(pageLink);
            }
        }
    });

    // Handle error message copy
    document.addEventListener('click', (event) => {
        if (event.target.id === 'copy-error-message') {
            copyToClipboard('error-dialog');
        }
    });

    // Initialize password toggle addon
    passwordAddOn();
};
