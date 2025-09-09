/* =============================================================================================
  TABLE: AUDIT LOG
============================================================================================= */

DROP TABLE IF EXISTS audit_log;

CREATE TABLE audit_log (
    audit_log_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    table_name VARCHAR(100) NOT NULL,
    reference_id INT NOT NULL,
    log TEXT NOT NULL,
    changed_by INT UNSIGNED DEFAULT 1,
    changed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (changed_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: AUDIT LOG
============================================================================================= */

CREATE INDEX idx_audit_log_table_name ON audit_log(table_name);
CREATE INDEX idx_audit_log_reference_id ON audit_log(reference_id);
CREATE INDEX idx_audit_log_changed_by ON audit_log(changed_by);

/* =============================================================================================
  INITIAL VALUES: AUDIT LOG
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: USER ACCOUNT
============================================================================================= */

DROP TABLE IF EXISTS user_account;

CREATE TABLE user_account (
    user_account_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    file_as VARCHAR(300) NOT NULL,
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    profile_picture VARCHAR(500),
    active VARCHAR(5) DEFAULT 'No',
    two_factor_auth VARCHAR(5) DEFAULT 'Yes',
    multiple_session VARCHAR(5) DEFAULT 'No',
    last_connection_date DATETIME,
    last_failed_connection_date DATETIME,
    last_password_change DATETIME,
    last_password_reset_request DATETIME,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,     
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: USER ACCOUNT
============================================================================================= */

CREATE INDEX idx_user_account_email ON user_account(email);
CREATE INDEX idx_user_account_phone ON user_account(phone);

/* =============================================================================================
  INITIAL VALUES: USER ACCOUNT
============================================================================================= */

INSERT INTO user_account (
    file_as,
    email,
    password,
    phone,
    active,
    multiple_session
) VALUES (
    'Lawrence Agulto',
    'l.agulto@christianmotors.ph',
    '$2y$10$Qu3TEV2u0SBF1jdb2DzB6.OcMChTDStXHEOdX47Y01sOGkl4UnOaK',
    '123-456-7890',
    'Yes',
    'No'
);

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: LOGIN ATTEMPTS
============================================================================================= */

DROP TABLE IF EXISTS login_attempts;

CREATE TABLE login_attempts (
    login_attempts_id INT AUTO_INCREMENT PRIMARY KEY,
    user_account_id INT NULL,
    email VARCHAR(255) NULL,
    ip_address VARCHAR(45) NOT NULL,
    attempt_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    success TINYINT(1) NOT NULL DEFAULT 0,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: LOGIN ATTEMPTS
============================================================================================= */

CREATE INDEX idx_login_attempts_user_account_id ON login_attempts(user_account_id);
CREATE INDEX idx_login_attempts_email ON login_attempts(email);
CREATE INDEX idx_login_attempts_ip_address ON login_attempts(ip_address);
CREATE INDEX idx_login_attempts_success ON login_attempts(success);

/* =============================================================================================
  INITIAL VALUES: LOGIN ATTEMPTS
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: RESET TOKEN
============================================================================================= */

DROP TABLE IF EXISTS reset_token;

CREATE TABLE reset_token (
    reset_token_id INT AUTO_INCREMENT PRIMARY KEY,
    user_account_id INT UNSIGNED NOT NULL,
    reset_token VARCHAR(255),
    reset_token_expiry_date DATETIME,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (user_account_id) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: RESET TOKEN
============================================================================================= */

CREATE INDEX idx_reset_token_user_account_id ON reset_token(user_account_id);
CREATE INDEX idx_reset_token_value ON reset_token(reset_token);
CREATE INDEX idx_reset_token_expiry ON reset_token(reset_token_expiry_date);

/* =============================================================================================
  INITIAL VALUES: RESET TOKEN
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: OTP
============================================================================================= */

DROP TABLE IF EXISTS otp;

CREATE TABLE otp (
    otp_id INT AUTO_INCREMENT PRIMARY KEY,
    user_account_id INT UNSIGNED NOT NULL,
    otp VARCHAR(255),
    otp_expiry_date DATETIME,
    failed_otp_attempts TINYINT UNSIGNED DEFAULT 0,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (user_account_id) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: OTP
============================================================================================= */

CREATE INDEX idx_otp_user_account_id ON otp(user_account_id);
CREATE INDEX idx_otp_expiry ON otp(otp_expiry_date);

/* =============================================================================================
  INITIAL VALUES: OTP
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: SESSIONS
============================================================================================= */

DROP TABLE IF EXISTS sessions;

CREATE TABLE sessions (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    user_account_id INT UNSIGNED NOT NULL,
    session_token VARCHAR(255) NOT NULL,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (user_account_id) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: SESSIONS
============================================================================================= */

CREATE INDEX idx_sessions_user_account_id ON sessions(user_account_id);

/* =============================================================================================
  INITIAL VALUES: SESSIONS
============================================================================================= */

/* ====================================================================================================
   END OF TABLE DEFINITIONS
==================================================================================================== */



/* =============================================================================================
  TABLE: NOTIFICATION SETTING
============================================================================================= */

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

/* =============================================================================================
  INDEX: NOTIFICATION SETTING
============================================================================================= */

CREATE INDEX idx_notification_setting_id ON notification_setting(notification_setting_id);

/* =============================================================================================
  INITIAL VALUES: NOTIFICATION SETTING
============================================================================================= */

INSERT INTO notification_setting 
    (notification_setting_id, notification_setting_name, notification_setting_description, 
     system_notification, email_notification, sms_notification, last_log_by) 
VALUES
    (1, 'Login OTP', 'Sent when a user receives a login OTP.', 0, 1, 0, 1),
    (2, 'Forgot Password', 'Sent when a user requests a password reset.', 0, 1, 0, 1);

/* =============================================================================================
  TABLE: NOTIFICATION SETTING EMAIL TEMPLATE
============================================================================================= */

DROP TABLE IF EXISTS notification_setting_email_template;

CREATE TABLE notification_setting_email_template (
    notification_setting_email_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    notification_setting_id INT UNSIGNED NOT NULL,
    email_notification_subject VARCHAR(200) NOT NULL,
    email_notification_body LONGTEXT NOT NULL,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED NOT NULL,
    FOREIGN KEY (notification_setting_id) REFERENCES notification_setting(notification_setting_id),
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: NOTIFICATION SETTING EMAIL TEMPLATE
============================================================================================= */

CREATE INDEX idx_notification_email_setting_id ON notification_setting_email_template(notification_setting_id);
CREATE INDEX idx_notification_email_setting_id ON notification_setting_email_template(email_setting_id);

/* =============================================================================================
  INITIAL VALUES: NOTIFICATION SETTING EMAIL TEMPLATE
============================================================================================= */

INSERT INTO notification_setting_email_template 
    (notification_setting_email_id, notification_setting_id, email_notification_subject, 
     email_notification_body, last_log_by) 
VALUES
    (1, 1, 'Login OTP - Secure Access to Your Account',
     '<p>Your One-Time Password (OTP) is:</p><p><strong>#{OTP_CODE}</strong></p><p>This code is valid for <strong>#{OTP_CODE_VALIDITY}</strong>.</p><p>If you did not request this, please ignore.</p>', 1),
    (2, 2, 'Password Reset Request - Action Required',
     '<p>Click the link to reset your password:</p><p><a href="#{RESET_LINK}">Password Reset Link</a></p><p>Link expires after <strong>#{RESET_LINK_VALIDITY}</strong>.</p><p>If not requested, ignore this email.</p>', 1);

/* =============================================================================================
  TABLE: NOTIFICATION SETTING SYSTEM TEMPLATE
============================================================================================= */

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

/* =============================================================================================
  INDEX: NOTIFICATION SETTING SYSTEM TEMPLATE
============================================================================================= */

CREATE INDEX idx_notification_system_setting_id ON notification_setting_system_template(notification_setting_id);

/* =============================================================================================
  INITIAL VALUES: NOTIFICATION SETTING SYSTEM TEMPLATE
============================================================================================= */

/* =============================================================================================
  TABLE: NOTIFICATION SETTING SMS TEMPLATE
============================================================================================= */

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

/* =============================================================================================
  INDEX: NOTIFICATION SETTING SMS TEMPLATE
============================================================================================= */

CREATE INDEX idx_notification_sms_setting_id ON notification_setting_sms_template(notification_setting_id);

/* =============================================================================================
  INITIAL VALUES: NOTIFICATION SETTING SMS TEMPLATE
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: APP MODULE
============================================================================================= */

DROP TABLE IF EXISTS app_module;

CREATE TABLE app_module (
    app_module_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    app_module_name VARCHAR(100) NOT NULL,
    app_module_description VARCHAR(500) NOT NULL,
    app_logo VARCHAR(500),
    menu_item_id INT UNSIGNED NOT NULL,
    menu_item_name VARCHAR(100) NOT NULL,
    order_sequence TINYINT(10) NOT NULL,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: APP MODULE
============================================================================================= */

CREATE INDEX idx_app_module_menu_item_id ON app_module(menu_item_id);

/* =============================================================================================
  INITIAL VALUES: APP MODULE
============================================================================================= */

INSERT INTO app_module (app_module_id, app_module_name, app_module_description, app_logo, menu_item_id, menu_item_name, order_sequence, last_log_by) VALUES
(1, 'Settings', 'Centralized management hub for comprehensive organizational oversight and control', './storage/uploads/app_module/1/Pboex.png', 1, 'App Module', 100, 1);

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: ROLE
============================================================================================= */

DROP TABLE IF EXISTS role;

CREATE TABLE role(
	role_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	role_name VARCHAR(100) NOT NULL,
	role_description VARCHAR(200) NOT NULL,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: ROLE
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: ROLE
============================================================================================= */

INSERT INTO role (role_name, role_description) VALUES ('Super Admin', 'Super Admin is the highest-level system administrator in an application or platform.');

/* =============================================================================================
  TABLE: ROLE PERMISSION
============================================================================================= */

DROP TABLE IF EXISTS role_permission;

CREATE TABLE role_permission(
	role_permission_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	role_id INT UNSIGNED NOT NULL,
	role_name VARCHAR(100) NOT NULL,
	menu_item_id INT UNSIGNED NOT NULL,
	menu_item_name VARCHAR(100) NOT NULL,
	read_access TINYINT(1) NOT NULL DEFAULT 0,
    write_access TINYINT(1) NOT NULL DEFAULT 0,
    create_access TINYINT(1) NOT NULL DEFAULT 0,
    delete_access TINYINT(1) NOT NULL DEFAULT 0,
    import_access TINYINT(1) NOT NULL DEFAULT 0,
    export_access TINYINT(1) NOT NULL DEFAULT 0,
    log_notes_access TINYINT(1) NOT NULL DEFAULT 0,
    date_assigned DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (menu_item_id) REFERENCES menu_item(menu_item_id),
    FOREIGN KEY (role_id) REFERENCES role(role_id),
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: ROLE PERMISSION
============================================================================================= */

CREATE INDEX idx_role_permission_menu_item_id ON role_permission(menu_item_id);
CREATE INDEX idx_role_permission_role_id ON role_permission(role_id);

/* =============================================================================================
  INITIAL VALUES: ROLE PERMISSION
============================================================================================= */

INSERT INTO role_permission (role_permission_id, role_id, role_name, menu_item_id, menu_item_name, read_access, write_access, create_access, delete_access, import_access, export_access, log_notes_access) VALUES
(1, 1, 'Super Admin', 1, 'App Module', 1, 1, 1, 1, 1, 1, 1);

/* =============================================================================================
  TABLE: ROLE SYSTEM ACTION PERMISSION
============================================================================================= */

DROP TABLE IF EXISTS role_system_action_permission;

CREATE TABLE role_system_action_permission (
    role_system_action_permission_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    role_id INT UNSIGNED NOT NULL,
    role_name VARCHAR(100) NOT NULL,
    system_action_id INT UNSIGNED NOT NULL,
    system_action_name VARCHAR(100) NOT NULL,
    system_action_access TINYINT(1) NOT NULL DEFAULT 0,
    date_assigned DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT NULL,
    FOREIGN KEY (system_action_id) REFERENCES system_action(system_action_id),
    FOREIGN KEY (role_id) REFERENCES role(role_id),
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: ROLE SYSTEM ACTION PERMISSION
============================================================================================= */

CREATE INDEX idx_role_system_action_permission_system_action_id ON role_system_action_permission(system_action_id);
CREATE INDEX idx_role_system_action_permission_role_id ON role_system_action_permission(role_id);

/* =============================================================================================
  INITIAL VALUES: ROLE SYSTEM ACTION PERMISSION
============================================================================================= */

/* =============================================================================================
  TABLE: ROLE USER ACCOUNT
============================================================================================= */

DROP TABLE IF EXISTS role_user_account;
CREATE TABLE role_user_account(
	role_user_account_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	role_id INT UNSIGNED NOT NULL,
	role_name VARCHAR(100) NOT NULL,
	user_account_id INT UNSIGNED NOT NULL,
	file_as VARCHAR(300) NOT NULL,
    date_assigned DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (user_account_id) REFERENCES user_account(user_account_id),
    FOREIGN KEY (role_id) REFERENCES role(role_id),
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: ROLE USER ACCOUNT
============================================================================================= */

CREATE INDEX idx_role_user_account_user_account_id ON role_user_account(user_account_id);
CREATE INDEX idx_role_user_account_role_id ON role_user_account(role_id);

/* =============================================================================================
  INITIAL VALUES: ROLE USER ACCOUNT
============================================================================================= */

INSERT INTO role_user_account (role_id, role_name, user_account_id, file_as, last_log_by) VALUES (1, 'Super Admin', 2, 'Lawrence Agulto', 1);

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: MENU ITEM
============================================================================================= */

DROP TABLE IF EXISTS menu_item;

CREATE TABLE menu_item (
    menu_item_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    menu_item_name VARCHAR(100) NOT NULL,
    menu_item_url VARCHAR(50),
    menu_item_icon VARCHAR(50),
    app_module_id INT UNSIGNED NOT NULL,
    app_module_name VARCHAR(100) NOT NULL,
    parent_id INT UNSIGNED,
    parent_name VARCHAR(100),
    table_name VARCHAR(100),
    order_sequence TINYINT(10) NOT NULL,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: MENU ITEM
============================================================================================= */

CREATE INDEX idx_menu_item_app_module_id ON menu_item(app_module_id);
CREATE INDEX idx_menu_item_parent_id ON menu_item(parent_id);

/* =============================================================================================
  INITIAL VALUES: MENU ITEM
============================================================================================= */

INSERT INTO menu_item (menu_item_name, menu_item_url, menu_item_icon, app_module_id, app_module_name, parent_id, parent_name, table_name, order_sequence, last_log_by) VALUES
('App Module', 'app-module.php', '', 1, 'Settings', 0, '', 'app_module', 1, 1);

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: SYSTEM ACTION
============================================================================================= */

DROP TABLE IF EXISTS system_action;

CREATE TABLE system_action(
	system_action_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	system_action_name VARCHAR(100) NOT NULL,
	system_action_description VARCHAR(200) NOT NULL,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: SYSTEM ACTION
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: SYSTEM ACTION
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: 
============================================================================================= */

/* =============================================================================================
  INDEX: 
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: 
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */