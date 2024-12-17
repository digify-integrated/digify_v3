import { disableButton, enableButton } from '../utilities/form-utilities.js';
import { handleSystemError } from '../modules/system-errors.js';
import { showNotification } from '../modules/notifications.js';
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
        submitHandler: async (form) => {
            const transaction = 'authenticate';
            const deviceInfo = getDeviceInfo();
            const formData = new URLSearchParams(new FormData(form));

            formData.append('transaction', transaction);
            formData.append('device_info', deviceInfo);

            try {
                disableButton('signin');
                const response = await fetch('./Modules/Settings/Authentication/Controller/AuthenticationController.php', {
                    method: 'POST',
                    body: formData,
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                });

                const data = await response.json();
                handleResponse(data);
            } catch (error) {
                handleError(error);
            }

            return false;
        }
    });
});

const handleResponse = (response) => {
    if (response.success) {
        window.location.href = response.redirectLink;
    } else {
        if (response.passwordExpired) {
            showNotification(response.title, response.message, response.messageType);
            window.location.href = response.redirectLink;
        } else {
            showNotification(response.title, response.message, response.messageType);
            enableButton('signin');
        }
    }
};

const handleError = (error) => {
    handleSystemError(null, null, error);
    enableButton('signin');
};