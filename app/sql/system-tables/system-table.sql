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

INSERT INTO user_account (file_as, email, password, phone, active, two_factor_auth)
VALUES 
('Bot', 'bot@christianmotors.ph', '$2y$10$Qu3TEV2u0SBF1jdb2DzB6.OcMChTDStXHEOdX47Y01sOGkl4UnOaK', '123-456-7890', 'Yes', 'No'),
('Lawrence Agulto', 'l.agulto@christianmotors.ph', '$2y$10$Qu3TEV2u0SBF1jdb2DzB6.OcMChTDStXHEOdX47Y01sOGkl4UnOaK', '123-456-7890', 'Yes', 'No');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



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
  FOREIGN KEY (changed_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: AUDIT LOG
============================================================================================= */

CREATE INDEX idx_audit_log_table_name ON audit_log(table_name);
CREATE INDEX idx_audit_log_reference_id ON audit_log(reference_id);
CREATE INDEX idx_audit_log_changed_by ON audit_log(changed_by);
CREATE INDEX idx_audit_log_changed_at ON audit_log(changed_at);

/* =============================================================================================
  INITIAL VALUES: AUDIT LOG
============================================================================================= */

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
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: NOTIFICATION SETTING
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: NOTIFICATION SETTING
============================================================================================= */

INSERT INTO notification_setting (notification_setting_id, notification_setting_name, notification_setting_description, system_notification, email_notification, sms_notification) 
VALUES
    (1, 'Login OTP', 'Sent when a user receives a login OTP.', 0, 1, 0),
    (2, 'Forgot Password', 'Sent when a user requests a password reset.', 0, 1, 0);

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
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (notification_setting_id) REFERENCES notification_setting(notification_setting_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: NOTIFICATION SETTING EMAIL TEMPLATE
============================================================================================= */

CREATE INDEX idx_notification_email_setting_id ON notification_setting_email_template(notification_setting_id);

/* =============================================================================================
  INITIAL VALUES: NOTIFICATION SETTING EMAIL TEMPLATE
============================================================================================= */

INSERT INTO notification_setting_email_template (notification_setting_email_id, notification_setting_id, email_notification_subject, email_notification_body) 
VALUES
    (1, 1, 'Login OTP - Secure Access to Your Account',
     '<p>Your One-Time Password (OTP) is:</p><p><strong>#{OTP_CODE}</strong></p><p>This code is valid for <strong>#{OTP_CODE_VALIDITY}</strong>.</p><p>If you did not request this, please ignore.</p>'),
    (2, 2, 'Password Reset Request - Action Required',
     '<p>Click the link to reset your password:</p><p><a href="#{RESET_LINK}">Password Reset Link</a></p><p>Link expires after <strong>#{RESET_LINK_VALIDITY}</strong>.</p><p>If not requested, ignore this email.</p>');

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
  last_log_by INT UNSIGNED DEFAULT 1,
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
  last_log_by INT UNSIGNED DEFAULT 1,
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

INSERT INTO app_module (app_module_id, app_module_name, app_module_description, app_logo, menu_item_id, menu_item_name, order_sequence) 
VALUES
(1, 'Settings', 'Centralized management hub for comprehensive organizational oversight and control', './storage/uploads/app_module/1/Pboex.png', 1, 'App Module', 100);

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

INSERT INTO menu_item (menu_item_name, menu_item_url, menu_item_icon, app_module_id, app_module_name, parent_id, parent_name, table_name, order_sequence)
VALUES
('App Module', 'app-module.php', '', 1, 'Settings', 0, '', 'app_module', 1);

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

INSERT INTO role (role_name, role_description) 
VALUES 
('Super Admin', 'Super Admin is the highest-level system administrator in an application or platform.');

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

CREATE INDEX idx_role_permission_role_id ON role_permission(role_id);
CREATE INDEX idx_role_permission_menu_item_id ON role_permission(menu_item_id);

/* =============================================================================================
  INITIAL VALUES: ROLE PERMISSION
============================================================================================= */

INSERT INTO role_permission (role_permission_id, role_id, role_name, menu_item_id, menu_item_name, read_access, write_access, create_access, delete_access, import_access, export_access, log_notes_access)
VALUES
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

CREATE INDEX idx_role_system_action_permission_role_id ON role_system_action_permission(role_id);
CREATE INDEX idx_role_system_action_permission_system_action_id ON role_system_action_permission(system_action_id);

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

CREATE INDEX idx_role_user_account_role_id ON role_user_account(role_id);
CREATE INDEX idx_role_user_account_user_account_id ON role_user_account(user_account_id);

/* =============================================================================================
  INITIAL VALUES: ROLE USER ACCOUNT
============================================================================================= */

INSERT INTO role_user_account (role_id, role_name, user_account_id, file_as)
VALUES
(1, 'Super Admin', 1, 'Bot'),
(1, 'Super Admin', 2, 'Lawrence Agulto');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: FILE TYPE
============================================================================================= */

DROP TABLE IF EXISTS file_type;

CREATE TABLE file_type (
  file_type_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
  file_type_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: FILE TYPE
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: FILE TYPE
============================================================================================= */

INSERT INTO file_type (file_type_id, file_type_name, last_log_by) VALUES
(1, 'Audio', 1),
(2, 'Compressed', 1),
(3, 'Disk and Media', 1),
(4, 'Data and Database', 1),
(5, 'Email', 1),
(6, 'Executable', 1),
(7, 'Font', 1),
(8, 'Image', 1),
(9, 'Internet Related', 1),
(10, 'Presentation', 1),
(11, 'Spreadsheet', 1),
(12, 'System Related', 1),
(13, 'Video', 1),
(14, 'Word Processor', 1);

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: FILE EXTENSION
============================================================================================= */

DROP TABLE IF EXISTS file_extension;

CREATE TABLE file_extension (
  file_extension_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
  file_extension_name VARCHAR(100) NOT NULL,
  file_extension VARCHAR(10) NOT NULL,
  file_type_id INT UNSIGNED NOT NULL,
  file_type_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id),
  FOREIGN KEY (file_type_id) REFERENCES file_type(file_type_id)
);

/* =============================================================================================
  INDEX: FILE EXTENSION
============================================================================================= */

CREATE INDEX idx_file_extension_file_type_id ON file_extension(file_type_id);

/* =============================================================================================
  INITIAL VALUES: FILE EXTENSION
============================================================================================= */

INSERT INTO file_extension (file_extension_id, file_extension_name, file_extension, file_type_id, file_type_name) VALUES
(1, 'AIF', 'aif', 1, 'Audio'),
(2, 'CDA', 'cda', 1, 'Audio'),
(3, 'MID', 'mid', 1, 'Audio'),
(4, 'MIDI', 'midi', 1, 'Audio'),
(5, 'MP3', 'mp3', 1, 'Audio'),
(6, 'MPA', 'mpa', 1, 'Audio'),
(7, 'OGG', 'ogg', 1, 'Audio'),
(8, 'WAV', 'wav', 1, 'Audio'),
(9, 'WMA', 'wma', 1, 'Audio'),
(10, 'WPL', 'wpl', 1, 'Audio'),
(11, '7Z', '7z', 2, 'Compressed'),
(12, 'ARJ', 'arj', 2, 'Compressed'),
(13, 'DEB', 'deb', 2, 'Compressed'),
(14, 'PKG', 'pkg', 2, 'Compressed'),
(15, 'RAR', 'rar', 2, 'Compressed'),
(16, 'RPM', 'rpm', 2, 'Compressed'),
(17, 'TAR.GZ', 'tar.gz', 2, 'Compressed'),
(18, 'Z', 'z', 2, 'Compressed'),
(19, 'ZIP', 'zip', 2, 'Compressed'),
(20, 'BIN', 'bin', 3, 'Disk and Media'),
(21, 'DMG', 'dmg', 3, 'Disk and Media'),
(22, 'ISO', 'iso', 3, 'Disk and Media'),
(23, 'TOAST', 'toast', 3, 'Disk and Media'),
(24, 'VCD', 'vcd', 3, 'Disk and Media'),
(25, 'CSV', 'csv', 4, 'Data and Database'),
(26, 'DAT', 'dat', 4, 'Data and Database'),
(27, 'DB', 'db', 4, 'Data and Database'),
(28, 'DBF', 'dbf', 4, 'Data and Database'),
(29, 'LOG', 'log', 4, 'Data and Database'),
(30, 'MDB', 'mdb', 4, 'Data and Database'),
(31, 'SAV', 'sav', 4, 'Data and Database'),
(32, 'SQL', 'sql', 4, 'Data and Database'),
(33, 'TAR', 'tar', 4, 'Data and Database'),
(34, 'XML', 'xml', 4, 'Data and Database'),
(35, 'EMAIL', 'email', 5, 'Email'),
(36, 'EML', 'eml', 5, 'Email'),
(37, 'EMLX', 'emlx', 5, 'Email'),
(38, 'MSG', 'msg', 5, 'Email'),
(39, 'OFT', 'oft', 5, 'Email'),
(40, 'OST', 'ost', 5, 'Email'),
(41, 'PST', 'pst', 5, 'Email'),
(42, 'VCF', 'vcf', 5, 'Email'),
(43, 'APK', 'apk', 6, 'Executable'),
(44, 'BAT', 'bat', 6, 'Executable'),
(45, 'BIN', 'bin', 6, 'Executable'),
(46, 'CGI', 'cgi', 6, 'Executable'),
(47, 'PL', 'pl', 6, 'Executable'),
(48, 'COM', 'com', 6, 'Executable'),
(49, 'EXE', 'exe', 6, 'Executable'),
(50, 'GADGET', 'gadget', 6, 'Executable'),
(51, 'JAR', 'jar', 6, 'Executable'),
(52, 'WSF', 'wsf', 6, 'Executable'),
(53, 'FNT', 'fnt', 7, 'Font'),
(54, 'FON', 'fon', 7, 'Font'),
(55, 'OTF', 'otf', 7, 'Font'),
(56, 'TTF', 'ttf', 7, 'Font'),
(57, 'AI', 'ai', 8, 'Image'),
(58, 'BMP', 'bmp', 8, 'Image'),
(59, 'GIF', 'gif', 8, 'Image'),
(60, 'ICO', 'ico', 8, 'Image'),
(61, 'JPG', 'jpg', 8, 'Image'),
(62, 'JPEG', 'jpeg', 8, 'Image'),
(63, 'PNG', 'png', 8, 'Image'),
(64, 'PS', 'ps', 8, 'Image'),
(65, 'PSD', 'psd', 8, 'Image'),
(66, 'SVG', 'svg', 8, 'Image'),
(67, 'TIF', 'tif', 8, 'Image'),
(68, 'TIFF', 'tiff', 8, 'Image'),
(69, 'WEBP', 'webp', 8, 'Image'),
(70, 'ASP', 'asp', 9, 'Internet Related'),
(71, 'ASPX', 'aspx', 9, 'Internet Related'),
(72, 'CER', 'cer', 9, 'Internet Related'),
(73, 'CFM', 'cfm', 9, 'Internet Related'),
(74, 'CGI', 'cgi', 9, 'Internet Related'),
(75, 'PL', 'pl', 9, 'Internet Related'),
(76, 'CSS', 'css', 9, 'Internet Related'),
(77, 'HTM', 'htm', 9, 'Internet Related'),
(78, 'HTML', 'html', 9, 'Internet Related'),
(79, 'JS', 'js', 9, 'Internet Related'),
(80, 'JSP', 'jsp', 9, 'Internet Related'),
(81, 'PART', 'part', 9, 'Internet Related'),
(82, 'PHP', 'php', 9, 'Internet Related'),
(83, 'PY', 'py', 9, 'Internet Related'),
(84, 'RSS', 'rss', 9, 'Internet Related'),
(85, 'XHTML', 'xhtml', 9, 'Internet Related'),
(86, 'KEY', 'key', 10, 'Presentation'),
(87, 'ODP', 'odp', 10, 'Presentation'),
(88, 'PPS', 'pps', 10, 'Presentation'),
(89, 'PPT', 'ppt', 10, 'Presentation'),
(90, 'PPTX', 'pptx', 10, 'Presentation'),
(91, 'ODS', 'ods', 11, 'Spreadsheet'),
(92, 'XLS', 'xls', 11, 'Spreadsheet'),
(93, 'XLSM', 'xlsm', 11, 'Spreadsheet'),
(94, 'XLSX', 'xlsx', 11, 'Spreadsheet'),
(95, 'BAK', 'bak', 12, 'System Related'),
(96, 'CAB', 'cab', 12, 'System Related'),
(97, 'CFG', 'cfg', 12, 'System Related'),
(98, 'CPL', 'cpl', 12, 'System Related'),
(99, 'CUR', 'cur', 12, 'System Related'),
(100, 'DLL', 'dll', 12, 'System Related'),
(101, 'DMP', 'dmp', 12, 'System Related'),
(102, 'DRV', 'drv', 12, 'System Related'),
(103, 'ICNS', 'icns', 12, 'System Related'),
(104, 'INI', 'ini', 12, 'System Related'),
(105, 'LNK', 'lnk', 12, 'System Related'),
(106, 'MSI', 'msi', 12, 'System Related'),
(107, 'SYS', 'sys', 12, 'System Related'),
(108, 'TMP', 'tmp', 12, 'System Related'),
(109, '3G2', '3g2', 13, 'Video'),
(110, '3GP', '3gp', 13, 'Video'),
(111, 'AVI', 'avi', 13, 'Video'),
(112, 'FLV', 'flv', 13, 'Video'),
(113, 'H264', 'h264', 13, 'Video'),
(114, 'M4V', 'm4v', 13, 'Video'),
(115, 'MKV', 'mkv', 13, 'Video'),
(116, 'MOV', 'mov', 13, 'Video'),
(117, 'MP4', 'mp4', 13, 'Video'),
(118, 'MPG', 'mpg', 13, 'Video'),
(119, 'MPEG', 'mpeg', 13, 'Video'),
(120, 'RM', 'rm', 13, 'Video'),
(121, 'SWF', 'swf', 13, 'Video'),
(122, 'VOB', 'vob', 13, 'Video'),
(123, 'WEBM', 'webm', 13, 'Video'),
(124, 'WMV', 'wmv', 13, 'Video'),
(125, 'DOC', 'doc', 14, 'Word Processor'),
(126, 'DOCX', 'docx', 14, 'Word Processor'),
(127, 'PDF', 'pdf', 14, 'Word Processor'),
(128, 'RTF', 'rtf', 14, 'Word Processor'),
(129, 'TEX', 'tex', 14, 'Word Processor'),
(130, 'TXT', 'txt', 14, 'Word Processor'),
(131, 'WPD', 'wpd', 14, 'Word Processor');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: UPLOAD SETTING
============================================================================================= */

DROP TABLE IF EXISTS upload_setting;

CREATE TABLE upload_setting(
	upload_setting_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	upload_setting_name VARCHAR(100) NOT NULL,
	upload_setting_description VARCHAR(200) NOT NULL,
	max_file_size DOUBLE NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: UPLOAD SETTING
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: UPLOAD SETTING
============================================================================================= */

INSERT INTO upload_setting (upload_setting_id, upload_setting_name, upload_setting_description, max_file_size) VALUES
(1, 'App Logo', 'Sets the upload setting when uploading app logo.', 800),
(2, 'Internal Notes Attachment', 'Sets the upload setting when uploading internal notes attachement.', 800),
(3, 'Import File', 'Sets the upload setting when importing data.', 800),
(4, 'User Account Profile Picture', 'Sets the upload setting when uploading user account profile picture.', 800),
(5, 'Company Logo', 'Sets the upload setting when uploading company logo.', 800);

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: UPLOAD SETTING FILE EXTENSION
============================================================================================= */

DROP TABLE IF EXISTS upload_setting_file_extension;

CREATE TABLE upload_setting_file_extension(
  upload_setting_file_extension_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	upload_setting_id INT UNSIGNED NOT NULL,
	upload_setting_name VARCHAR(100) NOT NULL,
	file_extension_id INT UNSIGNED NOT NULL,
	file_extension_name VARCHAR(100) NOT NULL,
	file_extension VARCHAR(10) NOT NULL,
	date_assigned DATETIME DEFAULT CURRENT_TIMESTAMP,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (upload_setting_id) REFERENCES upload_setting(upload_setting_id),
  FOREIGN KEY (file_extension_id) REFERENCES file_extension(file_extension_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: UPLOAD SETTING FILE EXTENSION
============================================================================================= */

CREATE INDEX idx_upload_setting_file_ext_upload_setting_id ON upload_setting_file_extension(upload_setting_id);
CREATE INDEX idx_upload_setting_file_ext_file_extension_id ON upload_setting_file_extension(file_extension_id);

/* =============================================================================================
  INITIAL VALUES: UPLOAD SETTING FILE EXTENSION
============================================================================================= */

INSERT INTO upload_setting_file_extension (upload_setting_file_extension_id, upload_setting_id, upload_setting_name, file_extension_id, file_extension_name, file_extension) VALUES
(1, 1, 'App Logo', 63, 'PNG', 'png'),
(2, 1, 'App Logo', 61, 'JPG', 'jpg'),
(3, 1, 'App Logo', 62, 'JPEG', 'jpeg'),
(4, 2, 'Internal Notes Attachment', 63, 'PNG', 'png'),
(5, 2, 'Internal Notes Attachment', 61, 'JPG', 'jpg'),
(6, 2, 'Internal Notes Attachment', 62, 'JPEG', 'jpeg'),
(7, 2, 'Internal Notes Attachment', 127, 'PDF', 'pdf'),
(8, 2, 'Internal Notes Attachment', 125, 'DOC', 'doc'),
(9, 2, 'Internal Notes Attachment', 125, 'DOCX', 'docx'),
(10, 2, 'Internal Notes Attachment', 130, 'TXT', 'txt'),
(11, 2, 'Internal Notes Attachment', 92, 'XLS', 'xls'),
(12, 2, 'Internal Notes Attachment', 94, 'XLSX', 'xlsx'),
(13, 2, 'Internal Notes Attachment', 89, 'PPT', 'ppt'),
(14, 2, 'Internal Notes Attachment', 90, 'PPTX', 'pptx'),
(15, 3, 'Import File', 25, 'CSV', 'csv'),
(16, 4, 'User Account Profile Picture', 63, 'PNG', 'png'),
(17, 4, 'User Account Profile Picture', 61, 'JPG', 'jpg'),
(18, 4, 'User Account Profile Picture', 62, 'JPEG', 'jpeg'),
(19, 5, 'Company Logo', 63, 'PNG', 'png'),
(20, 5, 'Company Logo', 61, 'JPG', 'jpg'),
(21, 5, 'Company Logo', 62, 'JPEG', 'jpeg');

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