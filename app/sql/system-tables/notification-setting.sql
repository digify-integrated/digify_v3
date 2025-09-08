/* ====================================================================================================
   TABLE: notification_setting
   ----------------------------------------------------------------------------------------------------
   Purpose:
     Stores configuration flags for each type of notification, specifying whether system alerts, emails,
     or SMS messages are enabled.

   Key Columns:
     - system_notification : 1 = enabled, 0 = disabled
     - email_notification  : 1 = enabled, 0 = disabled
     - sms_notification    : 1 = enabled, 0 = disabled
==================================================================================================== */

DROP TABLE IF EXISTS notification_setting;

CREATE TABLE notification_setting (
    notification_setting_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    notification_setting_name VARCHAR(100) NOT NULL,
    notification_setting_description VARCHAR(200) NOT NULL,
    system_notification INT(1) NOT NULL DEFAULT 1,
    email_notification INT(1) NOT NULL DEFAULT 0,
    sms_notification INT(1) NOT NULL DEFAULT 0,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED NOT NULL,
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

CREATE INDEX idx_notification_setting_id ON notification_setting(notification_setting_id);

-- Default notification settings
INSERT INTO notification_setting 
    (notification_setting_id, notification_setting_name, notification_setting_description, 
     system_notification, email_notification, sms_notification, last_log_by) 
VALUES
    (1, 'Login OTP', 'Sent when a user receives a login OTP.', 0, 1, 0, 1),
    (2, 'Forgot Password', 'Sent when a user requests a password reset.', 0, 1, 0, 1);


/* ====================================================================================================
   TABLE: notification_setting_email_template
   ----------------------------------------------------------------------------------------------------
   Purpose:
     Stores email templates for notifications, including subject and HTML body.
     Supports dynamic placeholders (e.g., #{OTP_CODE}, #{RESET_LINK}).
==================================================================================================== */

DROP TABLE IF EXISTS notification_setting_email_template;

CREATE TABLE notification_setting_email_template (
    notification_setting_email_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    notification_setting_id INT UNSIGNED NOT NULL,
    email_notification_subject VARCHAR(200) NOT NULL,
    email_notification_body LONGTEXT NOT NULL,
    email_setting_id INT UNSIGNED NOT NULL,
    email_setting_name VARCHAR(100) NOT NULL,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED NOT NULL,
    FOREIGN KEY (notification_setting_id) REFERENCES notification_setting(notification_setting_id),
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

CREATE INDEX idx_notification_email_setting_id 
    ON notification_setting_email_template(notification_setting_id);

-- Default email templates
INSERT INTO notification_setting_email_template 
    (notification_setting_email_id, notification_setting_id, email_notification_subject, 
     email_notification_body, email_setting_id, email_setting_name, last_log_by) 
VALUES
    (1, 1, 'Login OTP - Secure Access to Your Account',
     '<p>Your One-Time Password (OTP) is:</p><p><strong>#{OTP_CODE}</strong></p><p>This code is valid for <strong>#{OTP_CODE_VALIDITY}</strong>.</p><p>If you did not request this, please ignore.</p>',
     1, 'Security Email Setting', 1),
    (2, 2, 'Password Reset Request - Action Required',
     '<p>Click the link to reset your password:</p><p><a href="#{RESET_LINK}">Password Reset Link</a></p><p>Link expires after <strong>#{RESET_LINK_VALIDITY}</strong>.</p><p>If not requested, ignore this email.</p>',
     1, 'Security Email Setting', 1);


/* ====================================================================================================
   TABLE: notification_setting_system_template
   ----------------------------------------------------------------------------------------------------
   Purpose:
     Stores in-app/system notification templates.
==================================================================================================== */

DROP TABLE IF EXISTS notification_setting_system_template;

CREATE TABLE notification_setting_system_template (
    notification_setting_system_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    notification_setting_id INT UNSIGNED NOT NULL,
    system_notification_title VARCHAR(200) NOT NULL,
    system_notification_message VARCHAR(500) NOT NULL,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED NOT NULL,
    FOREIGN KEY (notification_setting_id) REFERENCES notification_setting(notification_setting_id),
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

CREATE INDEX idx_notification_system_setting_id 
    ON notification_setting_system_template(notification_setting_id);


/* ====================================================================================================
   TABLE: notification_setting_sms_template
   ----------------------------------------------------------------------------------------------------
   Purpose:
     Stores SMS templates for notifications (short messages).
==================================================================================================== */

DROP TABLE IF EXISTS notification_setting_sms_template;

CREATE TABLE notification_setting_sms_template (
    notification_setting_sms_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    notification_setting_id INT UNSIGNED NOT NULL,
    sms_notification_message VARCHAR(500) NOT NULL,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED NOT NULL,
    FOREIGN KEY (notification_setting_id) REFERENCES notification_setting(notification_setting_id),
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

CREATE INDEX idx_notification_sms_setting_id 
    ON notification_setting_sms_template(notification_setting_id);


/* ====================================================================================================
   END OF NOTIFICATION SETTINGS & TEMPLATES
==================================================================================================== */
