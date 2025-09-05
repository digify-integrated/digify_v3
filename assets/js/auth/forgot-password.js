import { disableButton, enableButton } from '../utilities/form-utilities.js';
import { handleSystemError } from '../modules/system-errors.js';
import { showNotification, setNotification } from '../modules/notifications.js';

$(document).ready(function () {
    $('#forgot_password_form').validate({
        rules: {
            email: {
                required: true,
            }
        },
        messages: {
            email: {
                required: 'Enter the email',
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

            const transaction = 'forgot password';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/AuthenticationController.php',
                data: $(form).serialize() + '&transaction=' + transaction,
                dataType: 'JSON',
                beforeSend: function() {
                    disableButton('forgot-password');
                },
                success: function(response) {
                    if (response.success) {
                        setNotification(response.title, response.message, response.message_type);
                        window.location.href = response.redirect_link;
                    }
                    else {
                        showNotification(response.title, response.message, response.message_type);
                        enableButton('forgot-password');
                    }
                },
                error: function(xhr, status, error) {
                    enableButton('forgot-password');
                    handleSystemError(xhr, status, error);
                }
            });

            return false;
        }
    });
});