import { disableButton, enableButton } from '../../utilities/form-utilities.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

$(document).ready(function () {    
    $('#user_account_form').validate({
        rules: {
            file_as: {
                required: true
            },
            email: {
                required: true
            },
            phone: {
                required: true
            },
            password: {
                required: true,
                password_strength: true
            }
        },
        messages: {
            file_as: {
                required: 'Enter the full name'
            },
            email: {
                required: 'Enter the email'
            },
            password: {
                required: 'Enter the password'
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
            const transaction   = 'save user account';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/UserAccountController.php',
                data: $(form).serialize() + '&transaction=' + transaction,
                dataType: 'JSON',
                beforeSend: function() {
                    disableButton('submit-data');
                },
                success: function(response) {
                    if (response.success) {
                        setNotification(response.title, response.message, response.message_type);
                        window.location = page_link + '&id=' + response.user_account_id;
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
