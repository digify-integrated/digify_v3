import { initializeDualListBoxIcon } from '../utilities/export.js';

export const disableButton = (buttonIds) => {
  const ids = Array.isArray(buttonIds) ? buttonIds : [buttonIds];

  ids.forEach((id) => {
    const btn = document.getElementById(id);
    if (!btn) {
      console.warn(`disableButton: button with ID "${id}" not found`);
      return;
    }

    if (!btn.dataset.originalText) btn.dataset.originalText = btn.innerHTML;

    btn.disabled = true;
    btn.innerHTML = `<span><span class="spinner-border spinner-border-sm align-middle ms-0"></span></span>`;
  });
};

export const enableButton = (buttonIds) => {
  const ids = Array.isArray(buttonIds) ? buttonIds : [buttonIds];

  ids.forEach((id) => {
    const btn = document.getElementById(id);
    if (!btn) {
      console.warn(`enableButton: button with ID "${id}" not found`);
      return;
    }

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

  $(form).find('.select2').val(null).trigger('change');
  form.querySelectorAll('.is-invalid').forEach(el => el.classList.remove('is-invalid'));
  form.reset();
};


export const generateDropdownOptions = async ({
  url,
  dropdownSelector,
  data = {},
  validateOnChange = false
}) => {
  try {
    const formData = new URLSearchParams();
    for (const key in data) {
      if (Object.prototype.hasOwnProperty.call(data, key)) {
        formData.append(key, data[key]);
      }
    }

    const response = await fetch(url, {
      method: 'POST',
      body: formData
    });

    if (!response.ok) {
      throw new Error(`Failed to fetch dropdown data. HTTP status: ${response.status}`);
    }

    const result = await response.json();

    const $dropdown = $(dropdownSelector);
    $dropdown.select2({ data: result });

    if (validateOnChange) {
      $dropdown.on('change', function () {
        $(this).valid();
      });
    }
  } catch (error) {
    handleSystemError(error, 'fetch_failed', `Dropdown generation failed: ${error.message}`);
  }
};
export const generateDualListBox = async ({ url, selectSelector, data = {} }) => {
  try {
    const formData = new URLSearchParams();
    for (const key in data) {
      if (Object.prototype.hasOwnProperty.call(data, key)) {
        formData.append(key, data[key]);
      }
    }

    const response = await fetch(url, {
      method: 'POST',
      body: formData
    });

    if (!response.ok) {
      throw new Error(`Failed to fetch dual list box data. HTTP status: ${response.status}`);
    }

    const result = await response.json();

    const select = document.getElementById(selectSelector);
    if (!select) {
      return;
    }

    select.options.length = 0;
    result.forEach(opt => {
      const option = new Option(opt.text, opt.id);
      select.appendChild(option);
    });

    if ($(`#${selectSelector}`).length) {
      $(`#${selectSelector}`).bootstrapDualListbox({
        nonSelectedListLabel: 'Non-selected',
        selectedListLabel: 'Selected',
        preserveSelectionOnMove: 'moved',
        moveOnSelect: false,
        helperSelectNamePostfix: false
      });

      $(`#${selectSelector}`).bootstrapDualListbox('refresh', true);
      initializeDualListBoxIcon();
    }
  } catch (error) {
    handleSystemError(error, 'fetch_failed', `Dual list box generation failed: ${error.message}`);
  }
};