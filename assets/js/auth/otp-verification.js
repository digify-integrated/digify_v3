/**
 * Import utility functions for form handling, error handling, and notifications.
 */
import { disableButton, enableButton } from '../utilities/form-utilities.js';
import { handleSystemError } from '../modules/system-errors.js';
import { showNotification, setNotification } from '../modules/notifications.js';

$(document).ready(function () {
    /**
     * Automatically focus on the next OTP input field once the current one reaches its max length.
     */
    $('.otp-input').on('input', function () {
        let maxLength       = parseInt($(this).attr('maxlength'));
        let currentLength   = $(this).val().length;

        if (currentLength === maxLength) {
            $(this).next('.otp-input').focus();
        }
    });

    /**
     * Handle OTP pasting: only accept alphanumeric characters.
     * Automatically distributes pasted characters across OTP input fields.
     */
    $('.otp-input').on('paste', function (e) {
        e.preventDefault();

        let pastedData      = (e.originalEvent || e).clipboardData.getData('text/plain');
        let filteredData    = pastedData.replace(/[^a-zA-Z0-9]/g, ''); // Strip non-alphanumeric

        for (let i = 0; i < filteredData.length; i++) {
            if (i < 6) {
                $('#otp_code_' + (i + 1)).val(filteredData.charAt(i));
            }
        }
    });

    /**
     * Handle backspace navigation: when empty, move focus to the previous field.
     */
    $('.otp-input').on('keydown', function (e) {
        if (e.which === 8 && $(this).val().length === 0) {
            $(this).prev('.otp-input').focus();
        }
    });

    /**
     * Trigger OTP resend when user clicks the "Resend OTP" link.
     */
    $('#resend-link').on('click', function () {
        resendOTP(180); // Start a new 3-minute countdown
    });

    /**
     * Restore countdown state on page reload if still active.
     * Uses localStorage to persist countdown expiration time.
     */
    const expireTime = localStorage.getItem('otpExpireTime');
    if (expireTime) {
        const remaining = Math.floor((expireTime - Date.now()) / 1000);
        if (remaining > 0) {
            startCountdown(remaining);
        } else {
            localStorage.removeItem('otpExpireTime'); // cleanup if expired
        }
    }

    /**
     * Validate OTP form: all 6 fields are required.
     * Error handling is done via notifications instead of inline messages.
     */
    $('#otp_form').validate({
        rules: {
            otp_code_1: { required: true },
            otp_code_2: { required: true },
            otp_code_3: { required: true },
            otp_code_4: { required: true },
            otp_code_5: { required: true },
            otp_code_6: { required: true }
        },
        messages: {
            otp_code_1: { required: 'Enter the security code' },
            otp_code_2: { required: 'Enter the security code' },
            otp_code_3: { required: 'Enter the security code' },
            otp_code_4: { required: 'Enter the security code' },
            otp_code_5: { required: 'Enter the security code' },
            otp_code_6: { required: 'Enter the security code' }
        },
        /**
         * Display error messages using a notification popup.
         */
        errorPlacement: (error, element) => {
            showNotification('Action Needed: Issue Detected', error.text(), 'error', 2500);
        },
        /**
         * Highlight invalid inputs (Bootstrap class "is-invalid").
         */
        highlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.addClass('is-invalid');
        },
        /**
         * Remove highlight once field is valid again.
         */
        unhighlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.removeClass('is-invalid');
        },
        /**
         * Handle form submission via AJAX.
         * Prevents default behavior, disables button while processing,
         * verifies OTP, and redirects or shows error notifications accordingly.
         */
        submitHandler: async (form, event) => {
            event.preventDefault();

            const transaction = 'otp verification';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/AuthenticationController.php',
                data: $(form).serialize() + '&transaction=' + transaction,
                dataType: 'JSON',
                beforeSend: function () {
                    disableButton('verify');
                },
                success: function (response) {
                    if (response.success) {
                        window.location.href = response.redirect_link;
                    }
                    else {
                        showNotification(response.title, response.message, response.message_type);
                        enableButton('verify');
                    }
                },
                error: function (xhr, status, error) {
                    enableButton('verify');
                    handleSystemError(xhr, status, error);
                }
            });

            return false; // Prevent normal form submission
        }
    });
});

/**
 * Starts a countdown timer and saves its expiry in localStorage.
 * @param {number} duration - Countdown duration in seconds.
 */
function startCountdown(duration) {
    const $countdown    = $('#countdown');
    const $resendLink   = $('#resend-link');

    let remaining = duration;

    $countdown.removeClass('d-none').text(formatTime(remaining));
    $resendLink.addClass('d-none');

    // Save expiry timestamp
    const expireTime = Date.now() + duration * 1000;
    localStorage.setItem('otpExpireTime', expireTime);

    // Clear any existing timer before starting a new one
    if (window.otpCountdownTimer) {
        clearInterval(window.otpCountdownTimer);
    }

    window.otpCountdownTimer = setInterval(() => {
        remaining--;

        if (remaining >= 0) {
            $countdown.text(formatTime(remaining));
        } else {
            clearInterval(window.otpCountdownTimer);
            $countdown.addClass('d-none');
            $resendLink.removeClass('d-none');
            localStorage.removeItem('otpExpireTime'); // cleanup
        }
    }, 1000);
}

/**
 * Resets countdown and requests a new OTP from the backend.
 * @param {number} countdownValue - Countdown duration in seconds.
 */
function resendOTP(countdownValue) {
    const user_account_id = $('#user_account_id').val();
    const transaction = 'resend otp';

    $.ajax({
        type: 'POST',
        url: './app/Controllers/AuthenticationController.php',
        dataType: 'json',
        data: {
            user_account_id: user_account_id,
            transaction: transaction
        },
        beforeSend: function () {
            $('#countdown').removeClass('d-none');
            $('#resend-link').addClass('d-none');

            document.getElementById('countdown').innerHTML = formatTime(countdownValue);

            startCountdown(countdownValue);
        },
        success: function (response) {
            if (response.success) {
                showNotification(response.title, response.message, response.message_type);
            }
            else {
                window.location.href = 'index.php';
                setNotification(response.title, response.message, response.message_type);
            }
        },
        error: function (xhr, status, error) {
            handleSystemError(xhr, status, error);
        }
    });
}

/**
 * Converts seconds into MM:SS format.
 * @param {number} seconds - Time in seconds.
 * @returns {string} Formatted time (MM:SS).
 */
function formatTime(seconds) {
    const minutes = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${minutes}:${secs < 10 ? '0' : ''}${secs}`;
}
