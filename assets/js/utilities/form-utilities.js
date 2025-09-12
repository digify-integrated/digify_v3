/**
 * Disables one or more buttons by ID.
 * @param {string|string[]} buttonIds - Single button ID string, or array of button ID strings
 */
export const disableButton = (buttonIds) => {
  // Normalize input: always a flat array of strings
  const ids = Array.isArray(buttonIds) ? buttonIds : [buttonIds];

  ids.forEach((id) => {
    const btn = document.getElementById(id);
    if (!btn) {
      console.warn(`disableButton: button with ID "${id}" not found`);
      return;
    }

    // Save original text if not already saved
    if (!btn.dataset.originalText) btn.dataset.originalText = btn.innerHTML;

    // Disable button and show spinner
    btn.disabled    = true;
    btn.innerHTML   = `<span><span class="spinner-border spinner-border-sm align-middle ms-0"></span></span>`;
  });
};

/**
 * Enables one or more buttons by ID.
 * @param {string|string[]} buttonIds - Single button ID string, or array of button ID strings
 */
export const enableButton = (buttonIds) => {
  const ids = Array.isArray(buttonIds) ? buttonIds : [buttonIds];

  ids.forEach((id) => {
    const btn = document.getElementById(id);
    if (!btn) {
      console.warn(`enableButton: button with ID "${id}" not found`);
      return;
    }

    // Enable button and restore original text
    btn.disabled = false;
    if (btn.dataset.originalText) {
      btn.innerHTML = btn.dataset.originalText;
      delete btn.dataset.originalText;
    }
  });
};

export const resetForm = (formId) => {
    const form = document.getElementById(formId);
    if (!form) return;

    // Reset Select2 fields
    $(form).find('.select2').val(null).trigger('change');

    // Remove validation classes
    form.querySelectorAll('.is-invalid').forEach(el => el.classList.remove('is-invalid'));

    // Reset the form
    form.reset();
};


export const generateDropdownOptions = ({url, dropdownSelector, data = {}}) => {
    $.ajax({
        url: url,
        method: 'POST',
        dataType: 'json',
        data: data,
        success: function (response) {
            const $dropdown = $(dropdownSelector);

            $dropdown
                .select2({ data: response })
                .on('change', function () {
                    $(this).valid();
                });
        },
        error: function (xhr, status, error) {
            handleSystemError(xhr, status, error);
        }
    });
}
