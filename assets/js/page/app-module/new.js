import { disableButton, enableButton, generateDropdownOptions } from '../../utilities/form-utilities.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    generateDropdownOptions({
        url: './app/Controllers/MenuItemController.php',
        dropdownSelector: '#menu_item_id',
        data: { transaction: 'generate menu item options' },
        validateOnChange: true
    });
    
    $('#app_module_form').validate({
        rules: {
            app_module_name: {
                required: true
            },
            app_module_description: {
                required: true
            },
            menu_item_id: {
                required: true
            },
            order_sequence: {
                required: true
            }
        },
        messages: {
            app_module_name: {
                required: 'Enter the display name'
            },
            app_module_description: {
                required: 'Enter the description'
            },
            menu_item_id: {
                required: 'Select the default page'
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

            const page_link     = document.getElementById('page-link').getAttribute('href');
            const transaction   = 'save app module';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/AppModuleController.php',
                data: $(form).serialize() + '&transaction=' + transaction,
                dataType: 'JSON',
                beforeSend: function() {
                    disableButton('submit-data');
                },
                success: function(response) {
                    if (response.success) {
                        setNotification(response.title, response.message, response.message_type);
                        window.location = page_link + '&id=' + response.app_module_id;
                    }
                    else{
                        if(response.invalid_session){
                            setNotification(response.title, response.message, response.message_type);
                            window.location.href = response.redirect_link;
                        }
                        else{
                            showNotification(response.title, response.message, response.message_type);
                            enableButton('submit-data');
                        }
                    }
                },
                error: function(xhr, status, error) {
                    enableButton('submit-data');
                    handleSystemError(xhr, status, error);
                }
            });

            return false;
        }
    });
});
