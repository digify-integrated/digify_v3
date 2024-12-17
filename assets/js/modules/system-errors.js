import { showNotification } from './notifications.js';

export function handleSystemError(xhr, status, error) {
    const errorMessage = `Status: ${status}, Error: ${error}, Response: ${xhr.responseText || 'No response text'}`;
    console.error(errorMessage);
    showNotification('System Error', 'An unexpected error occurred. Please try again.', 'error');
}