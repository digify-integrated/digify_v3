<?php
# -------------------------------------------------------------
# Timezone Configuration
# -------------------------------------------------------------

date_default_timezone_set('Asia/Manila');

# -------------------------------------------------------------

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
# Encryption Configuration
# -------------------------------------------------------------

define('ENCRYPTION_KEY', '4b$Gy#89%q*aX@^p&cT!sPv6(5w)zSd+R');
define('SECRET_KEY', '9n6ui[N];T\?{Wju[@zq^7)y>gsz2ltMT');

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
define('MAIL_SMTP_SECURE', 'ssl');                      // Mail SMTP Secure

# -------------------------------------------------------------

# -------------------------------------------------------------
# Google reCAPTCHA Configuration
# -------------------------------------------------------------

define('RECAPTCHA_SITE_KEY', 'your-site-key');          // reCAPTCHA site key
define('RECAPTCHA_SECRET_KEY', 'your-secret-key');      // reCAPTCHA secret key

# -------------------------------------------------------------

# -------------------------------------------------------------
# Default User Interface Images
# -------------------------------------------------------------

define('DEFAULT_AVATAR_IMAGE', './assets/images/default/default-avatar.jpg');
define('DEFAULT_BG_IMAGE', './assets/images/default/default-bg.jpg');
define('DEFAULT_LOGIN_LOGO_IMAGE', './assets/images/default/default-logo-placeholder.png');
define('DEFAULT_MENU_LOGO_IMAGE', './assets/images/default/default-menu-logo.png');
define('DEFAULT_MODULE_ICON_IMAGE', './assets/images/default/default-module-icon.svg');
define('DEFAULT_FAVICON_IMAGE', './assets/images/default/default-favicon.svg');
define('DEFAULT_COMPANY_LOGO', './assets/images/default/default-company-logo.png');
define('DEFAULT_APP_MODULE_LOGO', './assets/images/default/app-module-logo.png');
define('DEFAULT_PLACEHOLDER_IMAGE', './assets/images/default/default-image-placeholder.png');
define('DEFAULT_ID_PLACEHOLDER_FRONT', './assets/images/default/id-placeholder-front.jpg');
define('DEFAULT_UPLOAD_PLACEHOLDER', './assets/images/default/upload-placeholder.png');

# -------------------------------------------------------------

# -------------------------------------------------------------
# Security Configuration
# -------------------------------------------------------------
define('DEFAULT_PASSWORD', 'P@ssw0rd');
define('MAX_FAILED_LOGIN_ATTEMPTS', 5);
define('RESET_PASSWORD_TOKEN_DURATION', 10);
define('REGISTRATION_VERIFICATION_TOKEN_DURATION', 180);
define('DEFAULT_PASSWORD_DURATION', 180);
define('MAX_FAILED_OTP_ATTEMPTS', 5);
define('DEFAULT_OTP_DURATION', 5);
define('DEFAULT_SESSION_INACTIVITY', 30);
define('BASE_LOCK_DURATION', 60);
define('DEFAULT_PASSWORD_RECOVERY_LINK', 'http:localhost/digify_v3/password-reset.php?id=');

# -------------------------------------------------------------

?>