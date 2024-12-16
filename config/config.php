<?php

# -------------------------------------------------------------
# App Configuration
# -------------------------------------------------------------

define('APP_NAME', 'Digify');                           // The name of your app
define('APP_URL', 'http://localhost/my_php_app');       // The base URL of your app
define('APP_ENV', 'development');                       // The environment ('development', 'production', etc.)
define('DEBUG_MODE', true);                             // Enable/disable error display

# -------------------------------------------------------------

# -------------------------------------------------------------
# Database Configuration
# -------------------------------------------------------------

define('DB_HOST', 'localhost');                         // Database host
define('DB_NAME', 'digifydb');                          // Database name
define('DB_USER', 'digify');                            // Database username
define('DB_PASS', 'qKHJpbkgC6t93nQr');                  // Database password
define('DB_CHARSET', 'utf8mb4');                        // Database charset (UTF-8MB4 is recommended)

# -------------------------------------------------------------

# -------------------------------------------------------------
# Error Handling Configuration
# -------------------------------------------------------------

define('ERROR_LOG', __DIR__ . '/../logs/app.log');      // Path to store application logs
define('DISPLAY_ERRORS', DEBUG_MODE);                   // Show errors in development environment
define('LOG_ERRORS', !DEBUG_MODE);                      // Log errors in production environment

if (DEBUG_MODE) {
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
} else {
    error_reporting(E_ALL);
    ini_set('display_errors', 0);
}

if (LOG_ERRORS) {
    ini_set('log_errors', 1);
    ini_set('error_log', ERROR_LOG);
}

# -------------------------------------------------------------

# -------------------------------------------------------------
# Session Handling Configuration
# -------------------------------------------------------------

define('SESSION_LIFETIME', 3600);                       // Session lifetime in seconds (1 hour)
define('SESSION_NAME', 'DIGIFY_SESSION');                // Custom session name
define('SESSION_SECURE', true);                         // Secure session cookies (use HTTPS)
define('SESSION_HTTP_ONLY', true);                      // Prevent JavaScript access to session cookies

# -------------------------------------------------------------

# -------------------------------------------------------------
# CSRF Token Configuration
# -------------------------------------------------------------

define('CSRF_TOKEN_NAME', 'csrf_token');                // CSRF token form field name
define('CSRF_TOKEN_LIFETIME', 3600);                    // CSRF token lifetime in seconds

# -------------------------------------------------------------

# -------------------------------------------------------------
# File Upload Configuration
# -------------------------------------------------------------

define('UPLOAD_DIR', __DIR__ . '/../uploads');          // Directory to store uploaded files
define('MAX_FILE_SIZE', 10485760);                      // Maximum file upload size (10MB)

# -------------------------------------------------------------

# -------------------------------------------------------------
# Mail Configuration
# -------------------------------------------------------------

define('MAIL_SMTP_SERVER', 'smtp.hostinger.com');       // SMTP server
define('MAIL_SMTP_PORT', 465);                          // SMTP port (usually 587 for TLS)
define('MAIL_USERNAME', 'your-email@example.com');      // SMTP username
define('MAIL_PASSWORD', 'your-email-password');         // SMTP password
define('MAIL_FROM_EMAIL', 'your-email@example.com');    // Email "from" address
define('MAIL_FROM_NAME', 'Your Name');                  // Name to show in "from" field

# -------------------------------------------------------------

# -------------------------------------------------------------
# Google reCAPTCHA Configuration
# -------------------------------------------------------------

define('RECAPTCHA_SITE_KEY', 'your-site-key');          // reCAPTCHA site key
define('RECAPTCHA_SECRET_KEY', 'your-secret-key');      // reCAPTCHA secret key

# -------------------------------------------------------------

?>