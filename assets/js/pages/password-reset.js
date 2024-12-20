import { disableButton, enableButton } from '../utilities/form-utilities.js';
import { handleSystemError } from '../modules/system-errors.js';
import { showNotification, setNotification } from '../modules/notifications.js';
import { getDeviceInfo } from '../utilities/helpers.js';

$(document).ready(function () {
    $('#signin-form').validate({
        rules: {
            username: {
                required: true,
            },
            password: {
                required: true
            }
        },
        messages: {
            username: {
                required: 'Enter the username',
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

            const transaction = 'authenticate';
            const deviceInfo = getDeviceInfo();

            $.ajax({
                type: 'POST',
                url: './app/Controllers/AuthenticationController.php',
                data: $(form).serialize() + '&transaction=' + transaction + '&device_info=' + deviceInfo,
                dataType: 'JSON',
                beforeSend: function() {
                    disableButton('signin');
                },
                success: function(response) {
                    if (response.success) {
                        window.location.href = response.redirectLink;
                    }
                    else {
                        if (response.passwordExpired) {
                            setNotification(response.title, response.message, response.messageType);
                            window.location.href = response.redirectLink;
                        }
                        else {
                            showNotification(response.title, response.message, response.messageType);
                            enableButton('signin');
                        }
                    }
                },
                error: function(xhr, status, error) {
                    enableButton('signin');
                    handleSystemError(xhr, status, error);
                }
            });

            return false;
        }
    });
});