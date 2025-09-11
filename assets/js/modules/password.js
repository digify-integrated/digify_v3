/**
 * Initializes password visibility toggle functionality.
 * 
 * Attaches a click listener to elements with the `.password-addon` class.
 * When clicked, it toggles the input field type between "password" and "text"
 * and updates the icon accordingly.
 *
 * @returns {void}
 */
export const passwordAddOn = () => {
  $('.password-addon')
    .on('click', function () {
      const $inputField = $(this).siblings('input');
      const $eyeIcon = $(this).find('i');

      const isPassword = $inputField.attr('type') === 'password';

      // Toggle input type
      $inputField.attr('type', isPassword ? 'text' : 'password');

      // Toggle eye/eye-slash icon
      $eyeIcon.toggleClass('ki-eye-slash ki-eye');
    })
    // Prevent accidental focus on the toggle button
    .attr('tabindex', -1);
};


