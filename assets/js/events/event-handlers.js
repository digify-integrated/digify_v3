// events/eventHandlers.js
import { discardCreate } from '../modules/dialogs.js';
import { passwordAddOn } from '../modules/password.js';
import { copyToClipboard } from '../utilities/helpers.js';

export function initializeEventHandlers() {
    $(document).on('click', '#discard-create', () => {
        const pageLink = document.getElementById('page-link').getAttribute('href');
        discardCreate(pageLink);
    });

    $(document).on('click', '#copy-error-message', () => {
        copyToClipboard('error-dialog');
    });

    passwordAddOn();
}