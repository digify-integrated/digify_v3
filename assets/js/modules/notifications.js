/**
 * Displays a toast notification using Toastr.
 *
 * @param {string} title - The title of the notification.
 * @param {string} message - The body message of the notification.
 * @param {'success'|'info'|'warning'|'error'} type - The type of notification.
 * @param {number} [timeOut=2000] - Duration (in ms) before the toast disappears.
 * @returns {void}
 */
export const showNotification = (title, message, type, timeOut = 2000) => {
  toastr.options = {
    closeButton: true,
    progressBar: true,
    preventDuplicates: true,
    positionClass: 'toastr-top-right',
    timeOut,
  };

  toastr[type]?.(message, title) ?? console.error(`Invalid toastr type: ${type}`);
};

/**
 * Displays an error dialog with the given message.
 *
 * @param {string} error - The error message to display in the dialog.
 * @returns {void}
 */
export const showErrorDialog = (error) => {
  const errorDialogElement = document.getElementById('error-dialog');

  if (errorDialogElement) {
    errorDialogElement.innerHTML = error;
    $('#system-error-modal').modal('show'); // Bootstrap/jQuery dependency
  } else {
    console.error('Error dialog element not found.');
  }
};

/**
 * Saves a notification to session storage for later display.
 *
 * @param {string} title - The title of the notification.
 * @param {string} message - The body message of the notification.
 * @param {'success'|'info'|'warning'|'error'} type - The type of notification.
 * @returns {void}
 */
export const setNotification = (title, message, type) => {
  sessionStorage.setItem('notificationTitle', title);
  sessionStorage.setItem('notificationMessage', message);
  sessionStorage.setItem('notificationType', type);
};

/**
 * Checks session storage for a pending notification and displays it if found.
 * Clears the stored notification afterwards.
 *
 * @returns {void}
 */
export const checkNotification = () => {
  const notificationTitle     = sessionStorage.getItem('notificationTitle');
  const notificationMessage   = sessionStorage.getItem('notificationMessage');
  const notificationType      = sessionStorage.getItem('notificationType');

  if (notificationTitle && notificationMessage && notificationType) {
    sessionStorage.clear();
    showNotification(notificationTitle, notificationMessage, notificationType);
  }
};