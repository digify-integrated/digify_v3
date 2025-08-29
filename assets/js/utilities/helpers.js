import { showNotification } from '../modules/notifications.js';

/**
 * Copies text content from a given element to the clipboard.
 *
 * @param {string} elementID - The ID of the DOM element containing the text to copy.
 * @returns {void}
 */
export const copyToClipboard = (elementID) => {
  const text = document.getElementById(elementID)?.textContent?.trim() || '';

  if (!text) {
    showNotification('Copy Error', 'No text to copy', 'error');
    return;
  }

  navigator.clipboard.writeText(text)
    .then(() => showNotification('Success', 'Copied to clipboard', 'success'))
    .catch(() => showNotification('Error', 'Failed to copy', 'error'));
};

/**
 * Resets a form by clearing fields, removing validation states,
 * and resetting Select2 dropdowns.
 *
 * @param {string} formId - The ID of the form element to reset.
 * @returns {void}
 */
export const resetForm = (formId) => {
  const form = document.getElementById(formId);
  if (!form) return;

  // Reset Select2 dropdowns if present (requires jQuery + Select2)
  $(form).find('.select2').val('').trigger('change');

  // Remove invalid state from form inputs
  form.querySelectorAll('.is-invalid').forEach((el) => el.classList.remove('is-invalid'));

  // Reset native form inputs
  form.reset();
};
