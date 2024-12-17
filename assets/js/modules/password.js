export function passwordAddOn() {
    $('.password-addon').on('click', function () {
        const inputField = $(this).siblings('input');
        const eyeIcon = $(this).find('i');

        const isPassword = inputField.attr('type') === 'password';
        inputField.attr('type', isPassword ? 'text' : 'password');
        eyeIcon.toggleClass('ki-eye-slash ki-eye');
    }).attr('tabindex', -1);
}