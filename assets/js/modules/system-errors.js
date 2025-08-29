import { showErrorDialog } from './notifications.js';

/**
 * Handles system-level errors (e.g., AJAX or fetch failures) and displays them in a dialog.
 *
 * @param {XMLHttpRequest|object} xhr - The XHR object or response object containing details.
 * @param {string} status - The status text of the request (e.g., "error", "timeout").
 * @param {string} error - The error message returned by the request.
 * @returns {void}
 */
export const handleSystemError = (xhr, status, error) => {
  const responseText = xhr?.responseText ?? 'No response text';

  const errorMessage = `
    Status: ${status}
    Error: ${error}
    Response: ${responseText}
  `.trim();

  showErrorDialog(errorMessage);
};
