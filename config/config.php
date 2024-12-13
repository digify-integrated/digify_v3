<?php

# -------------------------------------------------------------
# App Configuration
# -------------------------------------------------------------
define('APP_NAME', 'MyApp');                          // The name of your app
define('APP_URL', 'http://localhost/digify_v3');      // The base URL of your app
define('APP_ENV', 'development');                     // The environment ('development', 'production', etc.)
define('DEBUG_MODE', true);                           // Enable/disable error display

# -------------------------------------------------------------
# Database Configuration
# -------------------------------------------------------------
define('DB_HOST', 'localhost');                        // Database host
define('DB_NAME', 'myapp_db');                         // Database name
define('DB_USER', 'root');                             // Database username
define('DB_PASSWORD', '');                             // Database password
define('DB_CHARSET', 'utf8mb4');                       // Database charset (UTF-8MB4 is recommended)

# -------------------------------------------------------------
# Error Handling Configuration
# -------------------------------------------------------------
define('ERROR_LOG', __DIR__ . '/logs/app.log');        // Path to store application logs
define('DISPLAY_ERRORS', DEBUG_MODE);                  // Show errors in development environment
define('LOG_ERRORS', !DEBUG_MODE);                     // Log errors in production environment

# -------------------------------------------------------------
# Session Handling Configuration
# -------------------------------------------------------------
define('SESSION_LIFETIME', 3600);                      // Session lifetime in seconds (1 hour)
define('SESSION_NAME', 'DIGIFY_SESSION');               // Custom session name
define('SESSION_SECURE', true);                        // Secure session cookies (use HTTPS)
define('SESSION_HTTP_ONLY', true);                     // Prevent JavaScript access to session cookies

# -------------------------------------------------------------
# CSRF Token Configuration
# -------------------------------------------------------------
define('CSRF_TOKEN_NAME', 'csrf_token');               // CSRF token form field name
define('CSRF_TOKEN_LIFETIME', 3600);                   // CSRF token lifetime in seconds

# -------------------------------------------------------------
# File Upload Configuration
# -------------------------------------------------------------
define('UPLOAD_DIR', __DIR__ . '/storage/uploads');    // Directory to store uploaded files
define('MAX_FILE_SIZE', 10485760);                     // Maximum file upload size (10MB)

# -------------------------------------------------------------
# Mail Configuration
# -------------------------------------------------------------
define('MAIL_SMTP_SERVER', 'smtp.hostinger.com');        // SMTP server
define('MAIL_SMTP_PORT', 465);                         // SMTP port (usually 587 for TLS)
define('MAIL_USERNAME', 'cgmi-noreply@christianmotors.ph');           // SMTP username
define('MAIL_PASSWORD', 'P@ssw0rd');                   // SMTP password
define('MAIL_FROM_EMAIL', 'cgmi-noreply@christianmotors.ph');      // Email "from" address
define('MAIL_FROM_NAME', 'CGMI No-Reply');             // Name to show in "from" field

# -------------------------------------------------------------
# Google reCAPTCHA Configuration
# -------------------------------------------------------------
define('RECAPTCHA_SITE_KEY', 'your-site-key');          // reCAPTCHA site key
define('RECAPTCHA_SECRET_KEY', 'your-secret-key');      // reCAPTCHA secret key

?>