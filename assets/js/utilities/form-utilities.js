/**
 * Disables a button by ID, replaces its text with a loading spinner,
 * and stores the original text for later restoration.
 *
 * @param {string} buttonId - The ID of the button element to disable.
 */
export const disableButton = (buttonId) => {
  const button = document.getElementById(buttonId);

  if (!button) return;

  // Save the original button text if not already stored
  if (!button.dataset.originalText) {
    button.dataset.originalText = button.innerHTML;
  }

  button.disabled = true;
  button.innerHTML = `
    <span>
      <span class="spinner-border spinner-border-sm align-middle ms-2"></span>
    </span>
  `;
};

/**
 * Enables a button by ID and restores its original text if available.
 *
 * @param {string} buttonId - The ID of the button element to enable.
 */
export const enableButton = (buttonId) => {
  const button = document.getElementById(buttonId);

  if (!button) return;

  button.disabled = false;

  // Restore original text if available
  if (button.dataset.originalText) {
    button.innerHTML = button.dataset.originalText;
    delete button.dataset.originalText;
  }
};
