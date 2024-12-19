import { showErrorDialog } from './notifications.js';

export function handleSystemError(xhr, status, error) {
    const errorMessage = `Status: ${status}, Error: ${error}, Response: ${xhr.responseText || 'No response text'}`;
    showErrorDialog(errorMessage);
}