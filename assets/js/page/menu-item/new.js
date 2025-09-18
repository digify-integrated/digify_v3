import { disableButton, enableButton, generateDropdownOptions } from '../../utilities/form-utilities.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    generateDropdownOptions({
        url: './app/Controllers/MenuItemController.php',
        dropdownSelector: '#parent_id',
        data: { 
            transaction: 'generate menu item options'
        }
    });

    generateDropdownOptions({
        url: './app/Controllers/AppModuleController.php',
        dropdownSelector: '#app_module_id',
        data: { 
            transaction: 'generate app module options'
        }
    });

    generateDropdownOptions({
        url: './app/Controllers/ExportController.php',
        dropdownSelector: '#table_name',
        data: { 
            transaction: 'generate export table options'
        }
    });
    
    $('#menu_item_form').validate({
        rules: {
            menu_item_name: {
                required: true
            },
            app_module_id: {
                required: true
            },
            order_sequence: {
                required: true
            }
        },
        messages: {
            menu_item_name: {
                required: 'Enter the display name'
            },
            app_module_id: {
                required: 'Choose the app module'
            },
            order_sequence: {
                required: 'Enter the order sequence'
            }
        },
        errorPlacement: (error, element) => {
            showNotification('Action Needed: Issue Detected', error.text(), 'error', 2500);
        },
        highlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.addClass('is-invalid');
        },
        unhighlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.removeClass('is-invalid');
        },
        submitHandler: async (form, event) => {
            event.preventDefault();

            const transaction   = 'save menu item';
            const page_link     = document.getElementById('page-link').getAttribute('href');

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);

            disableButton('submit-data');

            try {
                const response = await fetch('./app/Controllers/MenuItemController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save menu item failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location = `${page_link}&id=${data.menu_item_id}`;
                }
                else if(data.invalid_session){
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else{
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-data');
                }
            } catch (error) {
                enableButton('submit-data');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });
});
