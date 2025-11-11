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
  audit_log_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  table_name VARCHAR(100) NOT NULL,
  reference_id INT NOT NULL,
  log TEXT NOT NULL,
  changed_by INT UNSIGNED DEFAULT 1,
  changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
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
  attempt_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  success TINYINT(1) DEFAULT 0,
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
  notification_setting_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  notification_setting_name VARCHAR(100) NOT NULL,
  notification_setting_description VARCHAR(200) NOT NULL,
  system_notification INT(1) DEFAULT 1,
  email_notification INT(1) DEFAULT 0,
  sms_notification INT(1) DEFAULT 0,
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

INSERT INTO notification_setting (notification_setting_name, notification_setting_description, system_notification, email_notification, sms_notification) 
VALUES
    ('Login OTP', 'Sent when a user receives a login OTP.', 0, 1, 0),
    ('Forgot Password', 'Sent when a user requests a password reset.', 0, 1, 0);

/* =============================================================================================
  TABLE: NOTIFICATION SETTING EMAIL TEMPLATE
============================================================================================= */

DROP TABLE IF EXISTS notification_setting_email_template;

CREATE TABLE notification_setting_email_template (
  notification_setting_email_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
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

INSERT INTO notification_setting_email_template (notification_setting_id, email_notification_subject, email_notification_body) 
VALUES
    (1, 'Login OTP - Secure Access to Your Account',
     '<p>Your One-Time Password (OTP) is:</p><p><strong>#{OTP_CODE}</strong></p><p>This code is valid for <strong>#{OTP_CODE_VALIDITY}</strong>.</p><p>If you did not request this, please ignore.</p>'),
    (2, 'Password Reset Request - Action Required',
     '<p>Click the link to reset your password:</p><p><a href="#{RESET_LINK}">Password Reset Link</a></p><p>Link expires after <strong>#{RESET_LINK_VALIDITY}</strong>.</p><p>If not requested, ignore this email.</p>');

/* =============================================================================================
  TABLE: NOTIFICATION SETTING SYSTEM TEMPLATE
============================================================================================= */

DROP TABLE IF EXISTS notification_setting_system_template;

CREATE TABLE notification_setting_system_template (
  notification_setting_system_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
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
  notification_setting_sms_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
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
  TABLE: MENU ITEM
============================================================================================= */

DROP TABLE IF EXISTS menu_item;

CREATE TABLE menu_item (
  menu_item_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
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
('App Module', 'app-module.php', '', 1, 'Settings', 0, '', 'app_module', 1),
('Settings', '', '', 1, 'Settings', 0, '', '', 80),
('Users & Companies', '', '', 1, 'Settings', 0, '', '', 21),
('User Account', 'user-account.php', 'ki-outline ki-user', 1, 'Settings', 3, 'Users & Companies', 'user_account', 21),
('Company', 'company.php', 'ki-outline ki-shop', 1, 'Settings', 3, 'Users & Companies', 'company', 3),
('Role', 'role.php', '', 1, 'Settings', NULL, NULL, 'role', 3),
('User Interface', '', '', 1, 'Settings', NULL, NULL, '', 16),
('Menu Item', 'menu-item.php', 'ki-outline ki-data', 1, 'Settings', 7, 'User Interface', 'menu_item', 2),
('System Action', 'system-action.php', 'ki-outline ki-key-square', 1, 'Settings', 7, 'User Interface', 'system_action', 3),
('Account Settings', 'account-settings.php', '', 1, 'Settings', NULL, NULL, NULL, 127),
('Configurations', '', '', 1, 'Settings', 0, '', '', 50),
('Localization', '', 'ki-outline ki-compass', 1, 'Settings', 11, 'Configurations', '', 12),
('Country', 'country.php', '', 1, 'Settings', 12, 'Localization', 'country', 3),
('State', 'state.php', '', 1, 'Settings', 12, 'Localization', 'state', 19),
('City', 'city.php', '', 1, 'Settings', 12, 'Localization', 'city', 3),
('Currency', 'currency.php', '', 1, 'Settings', 12, 'Localization', 'currency', 3),
('Nationality', 'nationality.php', '', 1, 'Settings', 12, 'Localization', 'nationality', 20),
('Data Classification', '', 'ki-outline ki-file-up', 1, 'Settings', 11, 'Configurations', '', 4),
('File Type', 'file-type.php', '', 1, 'Settings', 18, 'Data Classification', 'file_type', 6),
('File Extension', 'file-extension.php', '', 1, 'Settings', 18, 'Data Classification', 'file_extension', 6),
('Upload Setting', 'upload-setting.php', 'ki-outline ki-exit-up', 1, 'Settings', 2, 'Settings', 'upload_setting', 21),
('Notification Setting', 'notification-setting.php', 'ki-outline ki-notification', 1, 'Settings', 2, 'Settings', 'notification_setting', 14),
('Banking', '', 'ki-outline ki-bank', 1, 'Settings', 11, 'Configurations', '', 2),
('Bank', 'bank.php', '', 1, 'Settings', 23, 'Banking', 'bank', 1),
('Bank Account Type', 'bank-account-type.php', '', 1, 'Settings', 23, 'Banking', 'bank_account_type', 2),
('Contact Information', '', 'ki-outline ki-address-book', 1, 'Settings', 11, 'Configurations', '', 3),
('Address Type', 'address-type.php', '', 1, 'Settings', 26, 'Contact Information', 'address_type', 1),
('Contact Information Type', 'contact-information-type.php', 'ki-outline ki-abstract', 1, 'Settings', 26, 'Contact Information', 'contact_information_type', 3),
('Language Settings', '', 'ki-outline ki-note-2', 1, 'Settings', 11, 'Configurations', '', 12),
('Language', 'language.php', '', 1, 'Settings', 29, 'Language Settings', 'language', 1),
('Language Proficiency', 'language-proficiency.php', '', 1, 'Settings', 29, 'Language Settings', 'language_proficiency', 2),
('Profile Attribute', '', 'ki-outline ki-people', 1, 'Settings', 11, 'Configurations', '', 16),
('Blood Type', 'blood-type.php', '', 1, 'Settings', 32, 'Profile Attribute', 'blood_type', 2),
('Civil Status', 'civil-status.php', '', 1, 'Settings', 32, 'Profile Attribute', 'civil_status', 3),
('Educational Stage', 'educational-stage.php', '', 1, 'Settings', 32, 'Profile Attribute', 'educational_stage', 5),
('Gender', 'gender.php', '', 1, 'Settings', 32, 'Profile Attribute', 'gender', 7),
('Credential Type', 'credential-type.php', '', 1, 'Settings', 32, 'Profile Attribute', 'credential_type', 3),
('Relationship', 'relationship.php', '', 1, 'Settings', 32, 'Profile Attribute', 'relationship', 18),
('Religion', 'religion.php', '', 1, 'Settings', 32, 'Profile Attribute', 'religion', 19),
('Employee', 'employee.php', '', 2, 'Employee', 0, '', '', 1),
('HR Configurations', '', '', 2, 'Employee', NULL, '', '', 99),
('Department', 'department.php', 'ki-outline ki-data', 2, 'Employee', 41, 'HR Configurations', 'department', 4),
('Departure Reason', 'departure-reason.php', 'ki-outline ki-user-square', 2, 'Employee', 41, 'HR Configurations', 'departure_reason', 4),
('Employment Location Type', 'employment-location-type.php', 'ki-outline ki-route', 2, 'Employee', 41, 'HR Configurations', 'employment_location_type', 5),
('Employment Type', 'employment-type.php', 'ki-outline ki-briefcase', 2, 'Employee', 41, 'HR Configurations', 'employment_type', 5),
('Job Position', 'job-position.php', 'ki-outline ki-questionnaire-tablet', 2, 'Employee', 41, 'HR Configurations', 'job_position', 10),
('Work Location', 'work-location.php', 'ki-outline ki-geolocation', 2, 'Employee', 41, 'HR Configurations', 'work_location', 23),
('Employee Document Type', 'employee-document-type.php', 'ki-outline ki-folder', 2, 'Employee', 41, 'HR Configurations', 'employee_document_type', 5),
('Inventory Configuration', '', '', 4, 'Inventory', 0, '', '', 99),
('Attribute', 'attribute.php', 'ki-outline ki-more-2', 4, 'Inventory', 49, 'Inventory Configuration', 'attribute', 1),
('Product Category', 'product-category.php', 'ki-outline ki-data', 4, 'Inventory', 49, 'Inventory Configuration', 'product_category', 16),
('Supplier', 'supplier.php', 'ki-outline ki-logistic', 4, 'Inventory', 49, 'Inventory Configuration', 'supplier', 19),
('Taxes', '', 'ki-outline ki-percentage', 1, 'Settings', 11, 'Configurations', '', 20),
('Tax', 'tax.php', '', 1, 'Settings', 53, 'Taxes', 'tax', 1),
('Product Measurement', '', 'ki-outline ki-graph', 4, 'Inventory', 49, 'Inventory Configuration', '', 16),
('Unit', 'unit.php', '', 4, 'Inventory', 55, 'Product Measurement', 'unit', 1),
('Unit Type', 'unit-type.php', '', 4, 'Inventory', 55, 'Product Measurement', 'unit_type', 2),
('Warehouse Management', '', 'ki-outline ki-home-3', 4, 'Inventory', 49, 'Inventory Configuration', '', 23),
('Warehouse', 'warehouse.php', '', 4, 'Inventory', 58, 'Warehouse Management', 'warehouse', 1),
('Warehouse Type', 'warehouse-type.php', '', 4, 'Inventory', 58, 'Warehouse Management', 'warehouse_type', 2),
('Products', '', '', 4, 'Inventory', 0, '', '', 1),
('Product', 'product.php', 'ki-outline ki-parcel', 4, 'Inventory', 61, 'Products', 'product', 1),
('Product Variant', 'product-variant.php', 'ki-outline ki-lots-shopping', 4, 'Inventory', 61, 'Products', 'product', 2),
('Pricelist', 'pricelist.php', 'ki-outline ki-tablet-text-down', 4, 'Inventory', 61, 'Products', 'product_pricelist', 3),
('Inventory Operations', '', '', 4, 'Inventory', 0, '', '', 2),
('Inventory Transfer', '', 'ki-outline ki-courier', 4, 'Inventory', 65, 'Inventory Operations', '', 1),
('Receipts', 'receipts.php', '', 4, 'Inventory', 66, 'Inventory Transfer', '', 18),
('Delivery', 'delivery.php', '', 4, 'Inventory', 66, 'Inventory Transfer', '', 4),
('Inventory Adjustments', '', 'ki-outline ki-setting-4', 4, 'Inventory', 65, 'Inventory Operations', '', 2),
('Physical Inventory', 'physical-inventory.php', '', 4, 'Inventory', 69, 'Inventory Adjustments', '', 16),
('Scrap', 'scrap.php', '', 4, 'Inventory', 69, 'Inventory Adjustments', '', 19),
('Inventory Procurement', '', 'ki-outline ki-cheque', 4, 'Inventory', 65, 'Inventory Operations', '', 3),
('Replenishment', 'replenishment.php', '', 4, 'Inventory', 72, 'Inventory Procurement', '', 18),
('Scrap Reason', 'scrap-reason.php', 'ki-outline ki-trash-square', 4, 'Inventory', 49, 'Inventory Configuration', 'scrap_reason', 1);

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: SYSTEM ACTION
============================================================================================= */

DROP TABLE IF EXISTS system_action;

CREATE TABLE system_action(
	system_action_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
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

INSERT INTO system_action (system_action_name, system_action_description) VALUES
('Activate User Account', 'Access to activate the user account.'),
('Deactivate User Account', 'Access to deactivate the user account.'),
('Add Role User Account', 'Access to assign roles to user account.'),
('Delete Role User Account', 'Access to delete roles to user account.'),
('Add Role Access', 'Access to add role access.'),
('Update Role Access', 'Access to update role access.'),
('Delete Role Access', 'Access to delete role access.'),
('Add Role System Action Access', 'Access to add the role system action access.'),
('Update Role System Action Access', 'Access to update the role system action access.'),
('Delete Role System Action Access', 'Access to delete the role system action access.'),
('Archive Employee', 'Access to archive an employee.'),
('Unarchive Employee', 'Access to unarchive an employee.'),
('Archive Supplier', 'Access to archive a supplier.'),
('Unarchive Supplier', 'Access to unarchive a supplier.'),
('Archive Tax', 'Access to archive a tax.'),
('Unarchive Tax', 'Access to unarchive a tax.'),
('Archive Warehouse', 'Access to archive a warehouse.'),
('Unarchive Warehouse', 'Access to unarchive a warehouse.'),
('Archive Product', 'Access to archive a product.'),
('Unarchive Product', 'Access to unarchive a product.');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: APP MODULE
============================================================================================= */

DROP TABLE IF EXISTS app_module;

CREATE TABLE app_module (
  app_module_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
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

INSERT INTO app_module (app_module_name, app_module_description, app_logo, menu_item_id, menu_item_name, order_sequence) VALUES
('Settings', 'Centralized management hub for comprehensive organizational oversight and control.', './storage/uploads/app_module/1/settings.png', 1, 'App Module', 100),
('Employee', 'Centralize employee information.', './storage/uploads/app_module/2/employees.png', 40, 'Employee', 5),
('Point of Sale', 'Handle checkouts and payments for shops and restaurants.', './storage/uploads/app_module/4/pos.png', 1, 'App Module', 10),
('Inventory', 'Manage your stocks and logistics activities.', './storage/uploads/app_module/3/inventory.png', 62, 'Product', 15);

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: ROLE
============================================================================================= */

DROP TABLE IF EXISTS role;

CREATE TABLE role(
	role_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
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
	role_permission_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	role_id INT UNSIGNED NOT NULL,
	role_name VARCHAR(100) NOT NULL,
	menu_item_id INT UNSIGNED NOT NULL,
	menu_item_name VARCHAR(100) NOT NULL,
	read_access TINYINT(1) DEFAULT 0,
  write_access TINYINT(1) DEFAULT 0,
  create_access TINYINT(1) DEFAULT 0,
  delete_access TINYINT(1) DEFAULT 0,
  import_access TINYINT(1) DEFAULT 0,
  export_access TINYINT(1) DEFAULT 0,
  log_notes_access TINYINT(1) DEFAULT 0,
  date_assigned DATETIME DEFAULT CURRENT_TIMESTAMP,
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

INSERT INTO role_permission (role_id, role_name, menu_item_id, menu_item_name, read_access, write_access, create_access, delete_access, import_access, export_access, log_notes_access)
VALUES
(1, 'Super Admin', 1, 'App Module', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 2, 'Settings', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 3, 'Users & Companies', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 4, 'User Account', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 5, 'Company', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 6, 'Role', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 7, 'User Interface', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 8, 'Menu Item', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 9, 'System Action', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 10, 'Account Settings', 1, 1, 0, 0, 0, 0, 1),
(1, 'Super Admin', 11, 'Configurations', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 12, 'Localization', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 13, 'Country', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 14, 'State', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 15, 'City', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 16, 'Currency', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 17, 'Nationality', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 18, 'Data Classification', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 19, 'File Type', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 20, 'File Extension', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 21, 'Upload Setting', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 22, 'Notification Setting', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 23, 'Banking', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 24, 'Bank', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 25, 'Bank Account Type', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 26, 'Contact Information', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 27, 'Address Type', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 28, 'Contact Information Type', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 29, 'Language Settings', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 30, 'Language', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 31, 'Language Proficiency', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 32, 'Profile Attribute', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 33, 'Blood Type', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 34, 'Civil Status', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 35, 'Educational Stage', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 36, 'Gender', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 37, 'Credential Type', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 38, 'Relationship', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 39, 'Religion', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 40, 'Employee', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 41, 'HR Configurations', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 42, 'Department', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 43, 'Departure Reason', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 44, 'Employment Location Type', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 45, 'Employment Type', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 46, 'Job Position', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 47, 'Work Location', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 48, 'Employee Document Type', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 49, 'Inventory Configuration', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 50, 'Attribute', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 51, 'Product Category', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 52, 'Supplier', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 53, 'Taxes', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 54, 'Tax', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 55, 'Product Measurement', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 56, 'Unit', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 57, 'Unit Type', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 58, 'Warehouse Management', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 59, 'Warehouse', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 60, 'Warehouse Type', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 61, 'Products', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 62, 'Product', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 63, 'Product Variant', 1, 1, 0, 1, 1, 1, 1),
(1, 'Super Admin', 64, 'Pricelist', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 65, 'Inventory Operations', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 66, 'Inventory Transfer', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 67, 'Receipts', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 68, 'Delivery', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 69, 'Inventory Adjustments', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 70, 'Physical Inventory', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 71, 'Scrap', 1, 1, 1, 1, 1, 1, 1),
(1, 'Super Admin', 72, 'Inventory Procurement', 1, 0, 0, 0, 0, 0, 0),
(1, 'Super Admin', 73, 'Replenishment', 1, 1, 1, 1, 1, 1, 1);

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
  system_action_access TINYINT(1) DEFAULT 0,
  date_assigned DATETIME DEFAULT CURRENT_TIMESTAMP,
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

INSERT INTO role_system_action_permission (role_id, role_name, system_action_id, system_action_name, system_action_access) VALUES
(1, 'Super Admin', 1, 'Activate User Account', 1),
(1, 'Super Admin', 2, 'Deactivate User Account', 1),
(1, 'Super Admin', 3, 'Add Role User Account', 1),
(1, 'Super Admin', 4, 'Delete Role User Account', 1),
(1, 'Super Admin', 5, 'Add Role Access', 1),
(1, 'Super Admin', 6, 'Update Role Access', 1),
(1, 'Super Admin', 7, 'Delete Role Access', 1),
(1, 'Super Admin', 8, 'Add Role System Action Access', 1),
(1, 'Super Admin', 9, 'Update Role System Action Access', 1),
(1, 'Super Admin', 10, 'Delete Role System Action Access', 1),
(1, 'Super Admin', 11, 'Archive Employee', 1),
(1, 'Super Admin', 12, 'Unarchive Employee', 1),
(1, 'Super Admin', 13, 'Archive Supplier', 1),
(1, 'Super Admin', 14, 'Unarchive Supplier', 1),
(1, 'Super Admin', 15, 'Archive Tax', 1),
(1, 'Super Admin', 16, 'Unarchive Tax', 1),
(1, 'Super Admin', 17, 'Archive Warehouse', 1),
(1, 'Super Admin', 18, 'Unarchive Warehouse', 1),
(1, 'Super Admin', 19, 'Archive Product', 1),
(1, 'Super Admin', 20, 'Unarchive Product', 1);

/* =============================================================================================
  TABLE: ROLE USER ACCOUNT
============================================================================================= */

DROP TABLE IF EXISTS role_user_account;
CREATE TABLE role_user_account(
	role_user_account_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	role_id INT UNSIGNED NOT NULL,
	role_name VARCHAR(100) NOT NULL,
	user_account_id INT UNSIGNED NOT NULL,
	file_as VARCHAR(300) NOT NULL,
  date_assigned DATETIME DEFAULT CURRENT_TIMESTAMP,
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
  file_type_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
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

INSERT INTO file_type (file_type_name) VALUES
('Audio'),
('Compressed'),
('Disk and Media'),
('Data and Database'),
('Email'),
('Executable'),
('Font'),
('Image'),
('Internet Related'),
('Presentation'),
('Spreadsheet'),
('System Related'),
('Video'),
('Word Processor');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: FILE EXTENSION
============================================================================================= */

DROP TABLE IF EXISTS file_extension;

CREATE TABLE file_extension (
  file_extension_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
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

INSERT INTO file_extension (file_extension_name, file_extension, file_type_id, file_type_name) VALUES
('AIF', 'aif', 1, 'Audio'),
('CDA', 'cda', 1, 'Audio'),
('MID', 'mid', 1, 'Audio'),
('MIDI', 'midi', 1, 'Audio'),
('MP3', 'mp3', 1, 'Audio'),
('MPA', 'mpa', 1, 'Audio'),
('OGG', 'ogg', 1, 'Audio'),
('WAV', 'wav', 1, 'Audio'),
('WMA', 'wma', 1, 'Audio'),
('WPL', 'wpl', 1, 'Audio'),
('7Z', '7z', 2, 'Compressed'),
('ARJ', 'arj', 2, 'Compressed'),
('DEB', 'deb', 2, 'Compressed'),
('PKG', 'pkg', 2, 'Compressed'),
('RAR', 'rar', 2, 'Compressed'),
('RPM', 'rpm', 2, 'Compressed'),
('TAR.GZ', 'tar.gz', 2, 'Compressed'),
('Z', 'z', 2, 'Compressed'),
('ZIP', 'zip', 2, 'Compressed'),
('BIN', 'bin', 3, 'Disk and Media'),
('DMG', 'dmg', 3, 'Disk and Media'),
('ISO', 'iso', 3, 'Disk and Media'),
('TOAST', 'toast', 3, 'Disk and Media'),
('VCD', 'vcd', 3, 'Disk and Media'),
('CSV', 'csv', 4, 'Data and Database'),
('DAT', 'dat', 4, 'Data and Database'),
('DB', 'db', 4, 'Data and Database'),
('DBF', 'dbf', 4, 'Data and Database'),
('LOG', 'log', 4, 'Data and Database'),
('MDB', 'mdb', 4, 'Data and Database'),
('SAV', 'sav', 4, 'Data and Database'),
('SQL', 'sql', 4, 'Data and Database'),
('TAR', 'tar', 4, 'Data and Database'),
('XML', 'xml', 4, 'Data and Database'),
('EMAIL', 'email', 5, 'Email'),
('EML', 'eml', 5, 'Email'),
('EMLX', 'emlx', 5, 'Email'),
('MSG', 'msg', 5, 'Email'),
('OFT', 'oft', 5, 'Email'),
('OST', 'ost', 5, 'Email'),
('PST', 'pst', 5, 'Email'),
('VCF', 'vcf', 5, 'Email'),
('APK', 'apk', 6, 'Executable'),
('BAT', 'bat', 6, 'Executable'),
('BIN', 'bin', 6, 'Executable'),
('CGI', 'cgi', 6, 'Executable'),
('PL', 'pl', 6, 'Executable'),
('COM', 'com', 6, 'Executable'),
('EXE', 'exe', 6, 'Executable'),
('GADGET', 'gadget', 6, 'Executable'),
('JAR', 'jar', 6, 'Executable'),
('WSF', 'wsf', 6, 'Executable'),
('FNT', 'fnt', 7, 'Font'),
('FON', 'fon', 7, 'Font'),
('OTF', 'otf', 7, 'Font'),
('TTF', 'ttf', 7, 'Font'),
('AI', 'ai', 8, 'Image'),
('BMP', 'bmp', 8, 'Image'),
('GIF', 'gif', 8, 'Image'),
('ICO', 'ico', 8, 'Image'),
('JPG', 'jpg', 8, 'Image'),
('JPEG', 'jpeg', 8, 'Image'),
('PNG', 'png', 8, 'Image'),
('PS', 'ps', 8, 'Image'),
('PSD', 'psd', 8, 'Image'),
('SVG', 'svg', 8, 'Image'),
('TIF', 'tif', 8, 'Image'),
('TIFF', 'tiff', 8, 'Image'),
('WEBP', 'webp', 8, 'Image'),
('ASP', 'asp', 9, 'Internet Related'),
('ASPX', 'aspx', 9, 'Internet Related'),
('CER', 'cer', 9, 'Internet Related'),
('CFM', 'cfm', 9, 'Internet Related'),
('CGI', 'cgi', 9, 'Internet Related'),
('PL', 'pl', 9, 'Internet Related'),
('CSS', 'css', 9, 'Internet Related'),
('HTM', 'htm', 9, 'Internet Related'),
('HTML', 'html', 9, 'Internet Related'),
('JS', 'js', 9, 'Internet Related'),
('JSP', 'jsp', 9, 'Internet Related'),
('PART', 'part', 9, 'Internet Related'),
('PHP', 'php', 9, 'Internet Related'),
('PY', 'py', 9, 'Internet Related'),
('RSS', 'rss', 9, 'Internet Related'),
('XHTML', 'xhtml', 9, 'Internet Related'),
('KEY', 'key', 10, 'Presentation'),
('ODP', 'odp', 10, 'Presentation'),
('PPS', 'pps', 10, 'Presentation'),
('PPT', 'ppt', 10, 'Presentation'),
('PPTX', 'pptx', 10, 'Presentation'),
('ODS', 'ods', 11, 'Spreadsheet'),
('XLS', 'xls', 11, 'Spreadsheet'),
('XLSM', 'xlsm', 11, 'Spreadsheet'),
('XLSX', 'xlsx', 11, 'Spreadsheet'),
('BAK', 'bak', 12, 'System Related'),
('CAB', 'cab', 12, 'System Related'),
('CFG', 'cfg', 12, 'System Related'),
('CPL', 'cpl', 12, 'System Related'),
('CUR', 'cur', 12, 'System Related'),
('DLL', 'dll', 12, 'System Related'),
('DMP', 'dmp', 12, 'System Related'),
('DRV', 'drv', 12, 'System Related'),
('ICNS', 'icns', 12, 'System Related'),
('INI', 'ini', 12, 'System Related'),
('LNK', 'lnk', 12, 'System Related'),
('MSI', 'msi', 12, 'System Related'),
('SYS', 'sys', 12, 'System Related'),
('TMP', 'tmp', 12, 'System Related'),
('3G2', '3g2', 13, 'Video'),
('3GP', '3gp', 13, 'Video'),
('AVI', 'avi', 13, 'Video'),
('FLV', 'flv', 13, 'Video'),
('H264', 'h264', 13, 'Video'),
('M4V', 'm4v', 13, 'Video'),
('MKV', 'mkv', 13, 'Video'),
('MOV', 'mov', 13, 'Video'),
('MP4', 'mp4', 13, 'Video'),
('MPG', 'mpg', 13, 'Video'),
('MPEG', 'mpeg', 13, 'Video'),
('RM', 'rm', 13, 'Video'),
('SWF', 'swf', 13, 'Video'),
('VOB', 'vob', 13, 'Video'),
('WEBM', 'webm', 13, 'Video'),
('WMV', 'wmv', 13, 'Video'),
('DOC', 'doc', 14, 'Word Processor'),
('DOCX', 'docx', 14, 'Word Processor'),
('PDF', 'pdf', 14, 'Word Processor'),
('RTF', 'rtf', 14, 'Word Processor'),
('TEX', 'tex', 14, 'Word Processor'),
('TXT', 'txt', 14, 'Word Processor'),
('WPD', 'wpd', 14, 'Word Processor');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: UPLOAD SETTING
============================================================================================= */

DROP TABLE IF EXISTS upload_setting;

CREATE TABLE upload_setting(
	upload_setting_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
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

INSERT INTO upload_setting (upload_setting_name, upload_setting_description, max_file_size) VALUES
('App Logo', 'Sets the upload setting when uploading app logo.', 800),
('Internal Notes Attachment', 'Sets the upload setting when uploading internal notes attachement.', 800),
('Import File', 'Sets the upload setting when importing data.', 800),
('User Account Profile Picture', 'Sets the upload setting when uploading user account profile picture.', 800),
('Company Logo', 'Sets the upload setting when uploading company logo.', 800),
('Employee Image', 'Sets the upload setting when uploading employee image.', 800),
('Employee Document', 'Sets the upload setting when uploading employee document.', 800),
('Product Image', 'Sets the upload setting when uploading product image.', 500);

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: UPLOAD SETTING FILE EXTENSION
============================================================================================= */

DROP TABLE IF EXISTS upload_setting_file_extension;

CREATE TABLE upload_setting_file_extension(
  upload_setting_file_extension_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
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

INSERT INTO upload_setting_file_extension (upload_setting_id, upload_setting_name, file_extension_id, file_extension_name, file_extension) VALUES
(1, 'App Logo', 63, 'PNG', 'png'),
(1, 'App Logo', 61, 'JPG', 'jpg'),
(1, 'App Logo', 62, 'JPEG', 'jpeg'),
(2, 'Internal Notes Attachment', 63, 'PNG', 'png'),
(2, 'Internal Notes Attachment', 61, 'JPG', 'jpg'),
(2, 'Internal Notes Attachment', 62, 'JPEG', 'jpeg'),
(2, 'Internal Notes Attachment', 127, 'PDF', 'pdf'),
(2, 'Internal Notes Attachment', 125, 'DOC', 'doc'),
(2, 'Internal Notes Attachment', 125, 'DOCX', 'docx'),
(2, 'Internal Notes Attachment', 130, 'TXT', 'txt'),
(2, 'Internal Notes Attachment', 92, 'XLS', 'xls'),
(2, 'Internal Notes Attachment', 94, 'XLSX', 'xlsx'),
(2, 'Internal Notes Attachment', 89, 'PPT', 'ppt'),
(2, 'Internal Notes Attachment', 90, 'PPTX', 'pptx'),
(3, 'Import File', 25, 'CSV', 'csv'),
(4, 'User Account Profile Picture', 63, 'PNG', 'png'),
(4, 'User Account Profile Picture', 61, 'JPG', 'jpg'),
(4, 'User Account Profile Picture', 62, 'JPEG', 'jpeg'),
(5, 'Company Logo', 63, 'PNG', 'png'),
(5, 'Company Logo', 61, 'JPG', 'jpg'),
(5, 'Company Logo', 62, 'JPEG', 'jpeg'),
(6, 'Employee Image', 63, 'PNG', 'png'),
(6, 'Employee Image', 61, 'JPG', 'jpg'),
(6, 'Employee Image', 62, 'JPEG', 'jpeg'),
(7, 'Employee Document', 63, 'PNG', 'png'),
(7, 'Employee Document', 61, 'JPG', 'jpg'),
(7, 'Employee Document', 62, 'JPEG', 'jpeg'),
(7, 'Employee Document', 127, 'PDF', 'pdf'),
(7, 'Employee Document', 125, 'DOC', 'doc'),
(7, 'Employee Document', 125, 'DOCX', 'docx'),
(7, 'Employee Document', 130, 'TXT', 'txt'),
(7, 'Employee Document', 92, 'XLS', 'xls'),
(7, 'Employee Document', 94, 'XLSX', 'xlsx'),
(7, 'Employee Document', 89, 'PPT', 'ppt'),
(7, 'Employee Document', 90, 'PPTX', 'pptx'),
(8, 'Product Image', 62, 'JPEG', 'jpeg'),
(8, 'Product Image', 61, 'JPG', 'jpg'),
(8, 'Product Image', 63, 'PNG', 'png');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: COUNTRY
============================================================================================= */

DROP TABLE IF EXISTS country;

CREATE TABLE country(
	country_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	country_name VARCHAR(100) NOT NULL,
	country_code VARCHAR(10) NOT NULL,
	phone_code VARCHAR(10) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: COUNTRY
============================================================================================= */

INSERT INTO country (country_name, country_code, phone_code)
VALUES
('Philippines', 'PH', '+63');

/* =============================================================================================
  INITIAL VALUES: COUNTRY
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: STATE
============================================================================================= */

DROP TABLE IF EXISTS state;

CREATE TABLE state(
	state_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	state_name VARCHAR(100) NOT NULL,
	country_id INT UNSIGNED NOT NULL,
	country_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id),
  FOREIGN KEY (country_id) REFERENCES country(country_id)
);

/* =============================================================================================
  INDEX: STATE
============================================================================================= */

CREATE INDEX idx_state_country_id ON state(country_id);

/* =============================================================================================
  INITIAL VALUES: STATE
============================================================================================= */

INSERT INTO state (state_name, country_id, country_name)
VALUES
('Abra', 1, 'Philippines'),
('Agusan del Norte', 1, 'Philippines'),
('Agusan del Sur', 1, 'Philippines'),
('Aklan', 1, 'Philippines'),
('Albay', 1, 'Philippines'),
('Antique', 1, 'Philippines'),
('Apayao', 1, 'Philippines'),
('Aurora', 1, 'Philippines'),
('Autonomous Region in Muslim Mindanao', 1, 'Philippines'),
('Basilan', 1, 'Philippines'),
('Bataan', 1, 'Philippines'),
('Batanes', 1, 'Philippines'),
('Batangas', 1, 'Philippines'),
('Benguet', 1, 'Philippines'),
('Bicol', 1, 'Philippines'),
('Biliran', 1, 'Philippines'),
('Bohol', 1, 'Philippines'),
('Bukidnon', 1, 'Philippines'),
('Bulacan', 1, 'Philippines'),
('Cagayan', 1, 'Philippines'),
('Cagayan Valley', 1, 'Philippines'),
('Calabarzon', 1, 'Philippines'),
('Camarines Norte', 1, 'Philippines'),
('Camarines Sur', 1, 'Philippines'),
('Camiguin', 1, 'Philippines'),
('Capiz', 1, 'Philippines'),
('Caraga', 1, 'Philippines'),
('Catanduanes', 1, 'Philippines'),
('Cavite', 1, 'Philippines'),
('Cebu', 1, 'Philippines'),
('Central Luzon', 1, 'Philippines'),
('Central Visayas', 1, 'Philippines'),
('Cordillera Administrative', 1, 'Philippines'),
('Cotabato', 1, 'Philippines'),
('Davao', 1, 'Philippines'),
('Davao de Oro', 1, 'Philippines'),
('Davao del Norte', 1, 'Philippines'),
('Davao del Sur', 1, 'Philippines'),
('Davao Occidental', 1, 'Philippines'),
('Davao Oriental', 1, 'Philippines'),
('Dinagat Islands', 1, 'Philippines'),
('Eastern Samar', 1, 'Philippines'),
('Eastern Visayas', 1, 'Philippines'),
('Guimaras', 1, 'Philippines'),
('Ifugao', 1, 'Philippines'),
('Ilocos', 1, 'Philippines'),
('Ilocos Norte', 1, 'Philippines'),
('Ilocos Sur', 1, 'Philippines'),
('Iloilo', 1, 'Philippines'),
('Isabela', 1, 'Philippines'),
('Kalinga', 1, 'Philippines'),
('La Union', 1, 'Philippines'),
('Laguna', 1, 'Philippines'),
('Lanao del Norte', 1, 'Philippines'),
('Lanao del Sur', 1, 'Philippines'),
('Leyte', 1, 'Philippines'),
('Maguindanao del Norte', 1, 'Philippines'),
('Maguindanao del Sur', 1, 'Philippines'),
('Marinduque', 1, 'Philippines'),
('Masbate', 1, 'Philippines'),
('Mimaropa', 1, 'Philippines'),
('Misamis Occidental', 1, 'Philippines'),
('Misamis Oriental', 1, 'Philippines'),
('Mountain Province', 1, 'Philippines'),
('National Capital Region (Metro Manila)', 1, 'Philippines'),
('Negros Occidental', 1, 'Philippines'),
('Negros Oriental', 1, 'Philippines'),
('Northern Mindanao', 1, 'Philippines'),
('Northern Samar', 1, 'Philippines'),
('Nueva Ecija', 1, 'Philippines'),
('Nueva Vizcaya', 1, 'Philippines'),
('Occidental Mindoro', 1, 'Philippines'),
('Oriental Mindoro', 1, 'Philippines'),
('Palawan', 1, 'Philippines'),
('Pampanga', 1, 'Philippines'),
('Pangasinan', 1, 'Philippines'),
('Quezon', 1, 'Philippines'),
('Quirino', 1, 'Philippines'),
('Rizal', 1, 'Philippines'),
('Romblon', 1, 'Philippines'),
('Sarangani', 1, 'Philippines'),
('Siquijor', 1, 'Philippines'),
('Soccsksargen', 1, 'Philippines'),
('Sorsogon', 1, 'Philippines'),
('South Cotabato', 1, 'Philippines'),
('Southern Leyte', 1, 'Philippines'),
('Sultan Kudarat', 1, 'Philippines'),
('Sulu', 1, 'Philippines'),
('Surigao del Norte', 1, 'Philippines'),
('Surigao del Sur', 1, 'Philippines'),
('Tarlac', 1, 'Philippines'),
('Tawi-Tawi', 1, 'Philippines'),
('Western Samar', 1, 'Philippines'),
('Western Visayas', 1, 'Philippines'),
('Zambales', 1, 'Philippines'),
('Zamboanga del Norte', 1, 'Philippines'),
('Zamboanga del Sur', 1, 'Philippines'),
('Zamboanga Peninsula', 1, 'Philippines'),
('Zamboanga Sibugay', 1, 'Philippines');


/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: CITY
============================================================================================= */

DROP TABLE IF EXISTS city;

CREATE TABLE city(
	city_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	city_name VARCHAR(100) NOT NULL,
	state_id INT UNSIGNED NOT NULL,
	state_name VARCHAR(100) NOT NULL,
	country_id INT UNSIGNED NOT NULL,
	country_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id),
  FOREIGN KEY (state_id) REFERENCES state(state_id),
  FOREIGN KEY (country_id) REFERENCES country(country_id)
);

/* =============================================================================================
  INDEX: CITY
============================================================================================= */

CREATE INDEX idx_city_state_id ON city(state_id);
CREATE INDEX idx_city_country_id ON city(country_id);

/* =============================================================================================
  INITIAL VALUES: CITY
============================================================================================= */

INSERT INTO city (city_name, state_id, state_name, country_id, country_name)
VALUES
('Alac', 1,  'Abra', 1,  'Philippines'),
('Allangigan Primero', 1,  'Abra', 1,  'Philippines'),
('Aloleng', 1,  'Abra', 1,  'Philippines'),
('Amagbagan', 1,  'Abra', 1,  'Philippines'),
('Anambongan', 1,  'Abra', 1,  'Philippines'),
('Angatel', 1,  'Abra', 1,  'Philippines'),
('Anulid', 1,  'Abra', 1,  'Philippines'),
('Baay', 1,  'Abra', 1,  'Philippines'),
('Bacag', 1,  'Abra', 1,  'Philippines'),
('Bacnar', 1,  'Abra', 1,  'Philippines'),
('Bactad Proper', 1,  'Abra', 1,  'Philippines'),
('Bacundao Weste', 1,  'Abra', 1,  'Philippines'),
('Bail', 1,  'Abra', 1,  'Philippines'),
('Balingasay', 1,  'Abra', 1,  'Philippines'),
('Balingueo', 1,  'Abra', 1,  'Philippines'),
('Balogo', 1,  'Abra', 1,  'Philippines'),
('Baluyot', 1,  'Abra', 1,  'Philippines'),
('Bangan-Oda', 1,  'Abra', 1,  'Philippines'),
('Banog Sur', 1,  'Abra', 1,  'Philippines'),
('Bantog', 1,  'Abra', 1,  'Philippines'),
('Barangobong', 1,  'Abra', 1,  'Philippines'),
('Baro', 1,  'Abra', 1,  'Philippines'),
('Barong', 1,  'Abra', 1,  'Philippines'),
('Basing', 1,  'Abra', 1,  'Philippines'),
('Bataquil', 1,  'Abra', 1,  'Philippines'),
('Bayaoas', 1,  'Abra', 1,  'Philippines'),
('Bical Norte', 1,  'Abra', 1,  'Philippines'),
('Bil-Loca', 1,  'Abra', 1,  'Philippines'),
('Binabalian', 1,  'Abra', 1,  'Philippines'),
('Binday', 1,  'Abra', 1,  'Philippines'),
('Bobonan', 1,  'Abra', 1,  'Philippines'),
('Bogtong', 1,  'Abra', 1,  'Philippines'),
('Bolaoit', 1,  'Abra', 1,  'Philippines'),
('Bolingit', 1,  'Abra', 1,  'Philippines'),
('Bolo', 1,  'Abra', 1,  'Philippines'),
('Boñgalon', 1,  'Abra', 1,  'Philippines'),
('Botao', 1,  'Abra', 1,  'Philippines'),
('Bued', 1,  'Abra', 1,  'Philippines'),
('Buenlag', 1,  'Abra', 1,  'Philippines'),
('Bulog', 1,  'Abra', 1,  'Philippines'),
('Butubut Norte', 1,  'Abra', 1,  'Philippines'),
('Caabiangan', 1,  'Abra', 1,  'Philippines'),
('Cabalaoangan', 1,  'Abra', 1,  'Philippines'),
('Cabalitian', 1,  'Abra', 1,  'Philippines'),
('Cabittaogan', 1,  'Abra', 1,  'Philippines'),
('Cabugao', 1,  'Abra', 1,  'Philippines'),
('Cabungan', 1,  'Abra', 1,  'Philippines'),
('Calepaan', 1,  'Abra', 1,  'Philippines'),
('Callaguip', 1,  'Abra', 1,  'Philippines'),
('Calomboyan', 1,  'Abra', 1,  'Philippines'),
('Calongbuyan', 1,  'Abra', 1,  'Philippines'),
('Calsib', 1,  'Abra', 1,  'Philippines'),
('Camaley', 1,  'Abra', 1,  'Philippines'),
('Canan Norte', 1,  'Abra', 1,  'Philippines'),
('Canaoalan', 1,  'Abra', 1,  'Philippines'),
('Cantoria', 1,  'Abra', 1,  'Philippines'),
('Capandanan', 1,  'Abra', 1,  'Philippines'),
('Capulaan', 1,  'Abra', 1,  'Philippines'),
('Caramutan', 1,  'Abra', 1,  'Philippines'),
('Caronoan West', 1,  'Abra', 1,  'Philippines'),
('Carot', 1,  'Abra', 1,  'Philippines'),
('Carriedo', 1,  'Abra', 1,  'Philippines'),
('Carusucan', 1,  'Abra', 1,  'Philippines'),
('Caterman', 1,  'Abra', 1,  'Philippines'),
('Cato', 1,  'Abra', 1,  'Philippines'),
('Catuday', 1,  'Abra', 1,  'Philippines'),
('Cayanga', 1,  'Abra', 1,  'Philippines'),
('Cayungnan', 1,  'Abra', 1,  'Philippines'),
('City of Batac', 1,  'Abra', 1,  'Philippines'),
('City of Candon', 1,  'Abra', 1,  'Philippines'),
('City of Urdaneta', 1,  'Abra', 1,  'Philippines'),
('City of Vigan', 1,  'Abra', 1,  'Philippines'),
('Comillas Norte', 1,  'Abra', 1,  'Philippines'),
('Corrooy', 1,  'Abra', 1,  'Philippines'),
('Dagup', 1,  'Abra', 1,  'Philippines'),
('Damortis', 1,  'Abra', 1,  'Philippines'),
('Darapidap', 1,  'Abra', 1,  'Philippines'),
('Davila', 1,  'Abra', 1,  'Philippines'),
('Diaz', 1,  'Abra', 1,  'Philippines'),
('Dilan', 1,  'Abra', 1,  'Philippines'),
('Domalanoan', 1,  'Abra', 1,  'Philippines'),
('Don Pedro', 1,  'Abra', 1,  'Philippines'),
('Dorongan Punta', 1,  'Abra', 1,  'Philippines'),
('Doyong', 1,  'Abra', 1,  'Philippines'),
('Dulig', 1,  'Abra', 1,  'Philippines'),
('Dumpay', 1,  'Abra', 1,  'Philippines'),
('Eguia', 1,  'Abra', 1,  'Philippines'),
('Esmeralda', 1,  'Abra', 1,  'Philippines'),
('Fuerte', 1,  'Abra', 1,  'Philippines'),
('Gayaman', 1,  'Abra', 1,  'Philippines'),
('Guiling', 1,  'Abra', 1,  'Philippines'),
('Guiset East', 1,  'Abra', 1,  'Philippines'),
('Hacienda', 1,  'Abra', 1,  'Philippines'),
('Halog West', 1,  'Abra', 1,  'Philippines'),
('Ilioilio', 1,  'Abra', 1,  'Philippines'),
('Inabaan Sur', 1,  'Abra', 1,  'Philippines'),
('Isla', 1,  'Abra', 1,  'Philippines'),
('Labayug', 1,  'Abra', 1,  'Philippines'),
('Labney', 1,  'Abra', 1,  'Philippines'),
('Lagasit', 1,  'Abra', 1,  'Philippines'),
('Laguit Centro', 1,  'Abra', 1,  'Philippines'),
('Leones East', 1,  'Abra', 1,  'Philippines'),
('Lepa', 1,  'Abra', 1,  'Philippines'),
('Libas', 1,  'Abra', 1,  'Philippines'),
('Linmansangan', 1,  'Abra', 1,  'Philippines'),
('Lloren', 1,  'Abra', 1,  'Philippines'),
('Lobong', 1,  'Abra', 1,  'Philippines'),
('Longos', 1,  'Abra', 1,  'Philippines'),
('Loqueb Este', 1,  'Abra', 1,  'Philippines'),
('Lucap', 1,  'Abra', 1,  'Philippines'),
('Lucero', 1,  'Abra', 1,  'Philippines'),
('Luna', 1,  'Abra', 1,  'Philippines'),
('Lunec', 1,  'Abra', 1,  'Philippines'),
('Lungog', 1,  'Abra', 1,  'Philippines'),
('Lusong', 1,  'Abra', 1,  'Philippines'),
('Mabilao', 1,  'Abra', 1,  'Philippines'),
('Mabilbila Sur', 1,  'Abra', 1,  'Philippines'),
('Mabusag', 1,  'Abra', 1,  'Philippines'),
('Macabuboni', 1,  'Abra', 1,  'Philippines'),
('Macalong', 1,  'Abra', 1,  'Philippines'),
('Macalva Norte', 1,  'Abra', 1,  'Philippines'),
('Macayug', 1,  'Abra', 1,  'Philippines'),
('Magtaking', 1,  'Abra', 1,  'Philippines'),
('Malabago', 1,  'Abra', 1,  'Philippines'),
('Malanay', 1,  'Abra', 1,  'Philippines'),
('Malawa', 1,  'Abra', 1,  'Philippines'),
('Malibong East', 1,  'Abra', 1,  'Philippines'),
('Mapolopolo', 1,  'Abra', 1,  'Philippines'),
('Maticmatic', 1,  'Abra', 1,  'Philippines'),
('Minien East', 1,  'Abra', 1,  'Philippines'),
('Nagbacalan', 1,  'Abra', 1,  'Philippines'),
('Nagsaing', 1,  'Abra', 1,  'Philippines'),
('Naguelguel', 1,  'Abra', 1,  'Philippines'),
('Naguilayan', 1,  'Abra', 1,  'Philippines'),
('Naguilian', 1,  'Abra', 1,  'Philippines'),
('Nalsian Norte', 1,  'Abra', 1,  'Philippines'),
('Nama', 1,  'Abra', 1,  'Philippines'),
('Namboongan', 1,  'Abra', 1,  'Philippines'),
('Nancalobasaan', 1,  'Abra', 1,  'Philippines'),
('Navatat', 1,  'Abra', 1,  'Philippines'),
('Nibaliw Central', 1,  'Abra', 1,  'Philippines'),
('Nilombot', 1,  'Abra', 1,  'Philippines'),
('Ninoy', 1,  'Abra', 1,  'Philippines'),
('Oaqui', 1,  'Abra', 1,  'Philippines'),
('Olea', 1,  'Abra', 1,  'Philippines'),
('Padong', 1,  'Abra', 1,  'Philippines'),
('Pagsanahan Norte', 1,  'Abra', 1,  'Philippines'),
('Paitan Este', 1,  'Abra', 1,  'Philippines'),
('Palacpalac', 1,  'Abra', 1,  'Philippines'),
('Palguyod', 1,  'Abra', 1,  'Philippines'),
('Pangapisan', 1,  'Abra', 1,  'Philippines'),
('Pangascasan', 1,  'Abra', 1,  'Philippines'),
('Pangpang', 1,  'Abra', 1,  'Philippines'),
('Paringao', 1,  'Abra', 1,  'Philippines'),
('Parioc Segundo', 1,  'Abra', 1,  'Philippines'),
('Pasibi West', 1,  'Abra', 1,  'Philippines'),
('Patayac', 1,  'Abra', 1,  'Philippines'),
('Patpata Segundo', 1,  'Abra', 1,  'Philippines'),
('Payocpoc Sur', 1,  'Abra', 1,  'Philippines'),
('Pindangan Centro', 1,  'Abra', 1,  'Philippines'),
('Pogonsili', 1,  'Abra', 1,  'Philippines'),
('Polo', 1,  'Abra', 1,  'Philippines'),
('Polong', 1,  'Abra', 1,  'Philippines'),
('Polong Norte', 1,  'Abra', 1,  'Philippines'),
('Pudoc', 1,  'Abra', 1,  'Philippines'),
('Pudoc North', 1,  'Abra', 1,  'Philippines'),
('Puelay', 1,  'Abra', 1,  'Philippines'),
('Puro Pinget', 1,  'Abra', 1,  'Philippines'),
('Quiling', 1,  'Abra', 1,  'Philippines'),
('Quinarayan', 1,  'Abra', 1,  'Philippines'),
('Quintong', 1,  'Abra', 1,  'Philippines'),
('Ranao', 1,  'Abra', 1,  'Philippines'),
('Rimus', 1,  'Abra', 1,  'Philippines'),
('Rissing', 1,  'Abra', 1,  'Philippines'),
('Sablig', 1,  'Abra', 1,  'Philippines'),
('Sagud-Bahley', 1,  'Abra', 1,  'Philippines'),
('Sagunto', 1,  'Abra', 1,  'Philippines'),
('Samon', 1,  'Abra', 1,  'Philippines'),
('San Eugenio', 1,  'Abra', 1,  'Philippines'),
('San Fernando Poblacion', 1,  'Abra', 1,  'Philippines'),
('San Gabriel First', 1,  'Abra', 1,  'Philippines'),
('San Juan', 1,  'Abra', 1,  'Philippines'),
('San Pedro Apartado', 1,  'Abra', 1,  'Philippines'),
('San Quintin', 1,  'Abra', 1,  'Philippines'),
('Sanlibo', 1,  'Abra', 1,  'Philippines'),
('Santo Tomas', 1,  'Abra', 1,  'Philippines'),
('Sonquil', 1,  'Abra', 1,  'Philippines'),
('Subusub', 1,  'Abra', 1,  'Philippines'),
('Sumabnit', 1,  'Abra', 1,  'Philippines'),
('Suso', 1,  'Abra', 1,  'Philippines'),
('Tablac', 1,  'Abra', 1,  'Philippines'),
('Tabug', 1,  'Abra', 1,  'Philippines'),
('Talospatang', 1,  'Abra', 1,  'Philippines'),
('Taloy', 1,  'Abra', 1,  'Philippines'),
('Tamayo', 1,  'Abra', 1,  'Philippines'),
('Tamorong', 1,  'Abra', 1,  'Philippines'),
('Tandoc', 1,  'Abra', 1,  'Philippines'),
('Tanolong', 1,  'Abra', 1,  'Philippines'),
('Tebag East', 1,  'Abra', 1,  'Philippines'),
('Telbang', 1,  'Abra', 1,  'Philippines'),
('Tiep', 1,  'Abra', 1,  'Philippines'),
('Toboy', 1,  'Abra', 1,  'Philippines'),
('Tobuan', 1,  'Abra', 1,  'Philippines'),
('Tococ East', 1,  'Abra', 1,  'Philippines'),
('Tombod', 1,  'Abra', 1,  'Philippines'),
('Tondol', 1,  'Abra', 1,  'Philippines'),
('Toritori', 1,  'Abra', 1,  'Philippines'),
('Umanday Centro', 1,  'Abra', 1,  'Philippines'),
('Unzad', 1,  'Abra', 1,  'Philippines'),
('Uyong', 1,  'Abra', 1,  'Philippines'),
('Abut', 2,  'Agusan del Norte', 1,  'Philippines'),
('Accusilian', 2,  'Agusan del Norte', 1,  'Philippines'),
('Afusing Centro', 2,  'Agusan del Norte', 1,  'Philippines'),
('Alabug', 2,  'Agusan del Norte', 1,  'Philippines'),
('Alannay', 2,  'Agusan del Norte', 1,  'Philippines'),
('Alicia', 2,  'Agusan del Norte', 1,  'Philippines'),
('Allacapan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Almaguer North', 2,  'Agusan del Norte', 1,  'Philippines'),
('Amulung', 2,  'Agusan del Norte', 1,  'Philippines'),
('Antagan Segunda', 2,  'Agusan del Norte', 1,  'Philippines'),
('Aparri', 2,  'Agusan del Norte', 1,  'Philippines'),
('Atulayan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Awallan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Bacnor East', 2,  'Agusan del Norte', 1,  'Philippines'),
('Baggabag B', 2,  'Agusan del Norte', 1,  'Philippines'),
('Baggao', 2,  'Agusan del Norte', 1,  'Philippines'),
('Bagong Tanza', 2,  'Agusan del Norte', 1,  'Philippines'),
('Bagu', 2,  'Agusan del Norte', 1,  'Philippines'),
('Ballesteros', 2,  'Agusan del Norte', 1,  'Philippines'),
('Bangad', 2,  'Agusan del Norte', 1,  'Philippines'),
('Banganan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Banquero', 2,  'Agusan del Norte', 1,  'Philippines'),
('Barucboc Norte', 2,  'Agusan del Norte', 1,  'Philippines'),
('Basco', 2,  'Agusan del Norte', 1,  'Philippines'),
('Battung', 2,  'Agusan del Norte', 1,  'Philippines'),
('Belance', 2,  'Agusan del Norte', 1,  'Philippines'),
('Binalan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Binguang', 2,  'Agusan del Norte', 1,  'Philippines'),
('Bintawan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Bitag Grande', 2,  'Agusan del Norte', 1,  'Philippines'),
('Bone South', 2,  'Agusan del Norte', 1,  'Philippines'),
('Buliwao', 2,  'Agusan del Norte', 1,  'Philippines'),
('Bulu', 2,  'Agusan del Norte', 1,  'Philippines'),
('Busilak', 2,  'Agusan del Norte', 1,  'Philippines'),
('Cabannungan Second', 2,  'Agusan del Norte', 1,  'Philippines'),
('Cabaritan East', 2,  'Agusan del Norte', 1,  'Philippines'),
('Cabiraoan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Calamagui East', 2,  'Agusan del Norte', 1,  'Philippines'),
('Calantac', 2,  'Agusan del Norte', 1,  'Philippines'),
('Calaoagan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Calayan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Calinaoan Malasin', 2,  'Agusan del Norte', 1,  'Philippines'),
('Calog Norte', 2,  'Agusan del Norte', 1,  'Philippines'),
('Camalaniugan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Capissayan Sur', 2,  'Agusan del Norte', 1,  'Philippines'),
('Carig', 2,  'Agusan del Norte', 1,  'Philippines'),
('Casambalangan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Catayauan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Cullalabo del Sur', 2,  'Agusan del Norte', 1,  'Philippines'),
('Dalaoig', 2,  'Agusan del Norte', 1,  'Philippines'),
('Daragutan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Dassun', 2,  'Agusan del Norte', 1,  'Philippines'),
('Diamantina', 2,  'Agusan del Norte', 1,  'Philippines'),
('Dibuluan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Dicabisagan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Dicamay', 2,  'Agusan del Norte', 1,  'Philippines'),
('Dinapigui', 2,  'Agusan del Norte', 1,  'Philippines'),
('Divilican', 2,  'Agusan del Norte', 1,  'Philippines'),
('Divisoria', 2,  'Agusan del Norte', 1,  'Philippines'),
('Dodan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Dumabato', 2,  'Agusan del Norte', 1,  'Philippines'),
('Echague (town)', 2,  'Agusan del Norte', 1,  'Philippines'),
('Eden', 2,  'Agusan del Norte', 1,  'Philippines'),
('Enrile', 2,  'Agusan del Norte', 1,  'Philippines'),
('Esperanza East', 2,  'Agusan del Norte', 1,  'Philippines'),
('Estefania', 2,  'Agusan del Norte', 1,  'Philippines'),
('Furao', 2,  'Agusan del Norte', 1,  'Philippines'),
('Gadu', 2,  'Agusan del Norte', 1,  'Philippines'),
('Gammad', 2,  'Agusan del Norte', 1,  'Philippines'),
('Ganapi', 2,  'Agusan del Norte', 1,  'Philippines'),
('Gappal', 2,  'Agusan del Norte', 1,  'Philippines'),
('Gattaran', 2,  'Agusan del Norte', 1,  'Philippines'),
('Gonzaga', 2,  'Agusan del Norte', 1,  'Philippines'),
('Guiddam', 2,  'Agusan del Norte', 1,  'Philippines'),
('Iguig', 2,  'Agusan del Norte', 1,  'Philippines'),
('Ineangan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Itbayat', 2,  'Agusan del Norte', 1,  'Philippines'),
('Ivana', 2,  'Agusan del Norte', 1,  'Philippines'),
('La Paz', 2,  'Agusan del Norte', 1,  'Philippines'),
('Lal-lo', 2,  'Agusan del Norte', 1,  'Philippines'),
('Lallayug', 2,  'Agusan del Norte', 1,  'Philippines'),
('Lanna', 2,  'Agusan del Norte', 1,  'Philippines'),
('Lapi', 2,  'Agusan del Norte', 1,  'Philippines'),
('Larion Alto', 2,  'Agusan del Norte', 1,  'Philippines'),
('Lasam', 2,  'Agusan del Norte', 1,  'Philippines'),
('Mabasa', 2,  'Agusan del Norte', 1,  'Philippines'),
('Mabuttal East', 2,  'Agusan del Norte', 1,  'Philippines'),
('Maddarulug Norte', 2,  'Agusan del Norte', 1,  'Philippines'),
('Magalalag', 2,  'Agusan del Norte', 1,  'Philippines'),
('Maguilling', 2,  'Agusan del Norte', 1,  'Philippines'),
('Mahatao', 2,  'Agusan del Norte', 1,  'Philippines'),
('Malasin', 2,  'Agusan del Norte', 1,  'Philippines'),
('Maluno Sur', 2,  'Agusan del Norte', 1,  'Philippines'),
('Manaring', 2,  'Agusan del Norte', 1,  'Philippines'),
('Manga', 2,  'Agusan del Norte', 1,  'Philippines'),
('Masaya Sur', 2,  'Agusan del Norte', 1,  'Philippines'),
('Masipi West', 2,  'Agusan del Norte', 1,  'Philippines'),
('Maxingal', 2,  'Agusan del Norte', 1,  'Philippines'),
('Minallo', 2,  'Agusan del Norte', 1,  'Philippines'),
('Minanga Norte', 2,  'Agusan del Norte', 1,  'Philippines'),
('Minante Segundo', 2,  'Agusan del Norte', 1,  'Philippines'),
('Minuri', 2,  'Agusan del Norte', 1,  'Philippines'),
('Mozzozzin Sur', 2,  'Agusan del Norte', 1,  'Philippines'),
('Mungo', 2,  'Agusan del Norte', 1,  'Philippines'),
('Municipality of Delfin Albano', 2,  'Agusan del Norte', 1,  'Philippines'),
('Muñoz East', 2,  'Agusan del Norte', 1,  'Philippines'),
('Nabannagan West', 2,  'Agusan del Norte', 1,  'Philippines'),
('Nagrumbuan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Namuac', 2,  'Agusan del Norte', 1,  'Philippines'),
('Nattapian', 2,  'Agusan del Norte', 1,  'Philippines'),
('Paddaya', 2,  'Agusan del Norte', 1,  'Philippines'),
('Palagao Norte', 2,  'Agusan del Norte', 1,  'Philippines'),
('Palanan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Pangal Sur', 2,  'Agusan del Norte', 1,  'Philippines'),
('Pattao', 2,  'Agusan del Norte', 1,  'Philippines'),
('Peñablanca', 2,  'Agusan del Norte', 1,  'Philippines'),
('Piat', 2,  'Agusan del Norte', 1,  'Philippines'),
('Pinoma', 2,  'Agusan del Norte', 1,  'Philippines'),
('Quibal', 2,  'Agusan del Norte', 1,  'Philippines'),
('Ragan Norte', 2,  'Agusan del Norte', 1,  'Philippines'),
('Ramon (municipal capital)', 2,  'Agusan del Norte', 1,  'Philippines'),
('Ramos West', 2,  'Agusan del Norte', 1,  'Philippines'),
('Rizal', 2,  'Agusan del Norte', 1,  'Philippines'),
('Sabtang', 2,  'Agusan del Norte', 1,  'Philippines'),
('Salinas', 2,  'Agusan del Norte', 1,  'Philippines'),
('Salinungan Proper', 2,  'Agusan del Norte', 1,  'Philippines'),
('San Agustin', 2,  'Agusan del Norte', 1,  'Philippines'),
('San Antonio', 2,  'Agusan del Norte', 1,  'Philippines'),
('San Bernardo', 2,  'Agusan del Norte', 1,  'Philippines'),
('San Isidro', 2,  'Agusan del Norte', 1,  'Philippines'),
('San Mateo', 2,  'Agusan del Norte', 1,  'Philippines'),
('San Pablo', 2,  'Agusan del Norte', 1,  'Philippines'),
('San Pedro', 2,  'Agusan del Norte', 1,  'Philippines'),
('San Vicente', 2,  'Agusan del Norte', 1,  'Philippines'),
('Sanchez Mira', 2,  'Agusan del Norte', 1,  'Philippines'),
('Sandiat Centro', 2,  'Agusan del Norte', 1,  'Philippines'),
('Santa Ana', 2,  'Agusan del Norte', 1,  'Philippines'),
('Santa Cruz', 2,  'Agusan del Norte', 1,  'Philippines'),
('Santa Praxedes', 2,  'Agusan del Norte', 1,  'Philippines'),
('Santiago', 2,  'Agusan del Norte', 1,  'Philippines'),
('Santo Niño', 2,  'Agusan del Norte', 1,  'Philippines'),
('Siempre Viva', 2,  'Agusan del Norte', 1,  'Philippines'),
('Sillawit', 2,  'Agusan del Norte', 1,  'Philippines'),
('Simanu Sur', 2,  'Agusan del Norte', 1,  'Philippines'),
('Simimbaan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Sinamar', 2,  'Agusan del Norte', 1,  'Philippines'),
('Sindon', 2,  'Agusan del Norte', 1,  'Philippines'),
('Solana', 2,  'Agusan del Norte', 1,  'Philippines'),
('Soyung', 2,  'Agusan del Norte', 1,  'Philippines'),
('Taguing', 2,  'Agusan del Norte', 1,  'Philippines'),
('Tapel', 2,  'Agusan del Norte', 1,  'Philippines'),
('Tuao', 2,  'Agusan del Norte', 1,  'Philippines'),
('Tupang', 2,  'Agusan del Norte', 1,  'Philippines'),
('Uddiawan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Ugac Sur', 2,  'Agusan del Norte', 1,  'Philippines'),
('Ugad', 2,  'Agusan del Norte', 1,  'Philippines'),
('Uyugan', 2,  'Agusan del Norte', 1,  'Philippines'),
('Yeban Norte', 2,  'Agusan del Norte', 1,  'Philippines'),
('Acli', 3,  'Agusan del Sur', 1,  'Philippines'),
('Agbannawag', 3,  'Agusan del Sur', 1,  'Philippines'),
('Akle', 3,  'Agusan del Sur', 1,  'Philippines'),
('Alua', 3,  'Agusan del Sur', 1,  'Philippines'),
('Amacalan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Amucao', 3,  'Agusan del Sur', 1,  'Philippines'),
('Amuñgan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Angat', 3,  'Agusan del Sur', 1,  'Philippines'),
('Angeles', 3,  'Agusan del Sur', 1,  'Philippines'),
('Arenas', 3,  'Agusan del Sur', 1,  'Philippines'),
('Arminia', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bacabac', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bacsay', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bagac', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bagong Barrio', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bagong-Sikat', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bahay Pare', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bakulong', 3,  'Agusan del Sur', 1,  'Philippines'),
('Balagtas', 3,  'Agusan del Sur', 1,  'Philippines'),
('Balanga', 3,  'Agusan del Sur', 1,  'Philippines'),
('Balaoang', 3,  'Agusan del Sur', 1,  'Philippines'),
('Balas', 3,  'Agusan del Sur', 1,  'Philippines'),
('Balasing', 3,  'Agusan del Sur', 1,  'Philippines'),
('Balayang', 3,  'Agusan del Sur', 1,  'Philippines'),
('Balingcanaway', 3,  'Agusan del Sur', 1,  'Philippines'),
('Balite', 3,  'Agusan del Sur', 1,  'Philippines'),
('Baliuag', 3,  'Agusan del Sur', 1,  'Philippines'),
('Baloc', 3,  'Agusan del Sur', 1,  'Philippines'),
('Baloy', 3,  'Agusan del Sur', 1,  'Philippines'),
('Balsic', 3,  'Agusan del Sur', 1,  'Philippines'),
('Balucuc', 3,  'Agusan del Sur', 1,  'Philippines'),
('Balut', 3,  'Agusan del Sur', 1,  'Philippines'),
('Balutu', 3,  'Agusan del Sur', 1,  'Philippines'),
('Banawang', 3,  'Agusan del Sur', 1,  'Philippines'),
('Baquero Norte', 3,  'Agusan del Sur', 1,  'Philippines'),
('Batasan Bata', 3,  'Agusan del Sur', 1,  'Philippines'),
('Batitang', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bayanan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Beddeng', 3,  'Agusan del Sur', 1,  'Philippines'),
('Biay', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bibiclat', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bicos', 3,  'Agusan del Sur', 1,  'Philippines'),
('Biga', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bilad', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bobon Second', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bodega', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bolitoc', 3,  'Agusan del Sur', 1,  'Philippines'),
('Buensuseso', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bulaon', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bularit', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bulawin', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bulihan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Buliran', 3,  'Agusan del Sur', 1,  'Philippines'),
('Buliran Segundo', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bulualto', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bundoc', 3,  'Agusan del Sur', 1,  'Philippines'),
('Bunol', 3,  'Agusan del Sur', 1,  'Philippines'),
('Cabayaoasan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Cabcaben', 3,  'Agusan del Sur', 1,  'Philippines'),
('Cabog', 3,  'Agusan del Sur', 1,  'Philippines'),
('Cafe', 3,  'Agusan del Sur', 1,  'Philippines'),
('Calaba', 3,  'Agusan del Sur', 1,  'Philippines'),
('Calancuasan Norte', 3,  'Agusan del Sur', 1,  'Philippines'),
('Calangain', 3,  'Agusan del Sur', 1,  'Philippines'),
('Calantas', 3,  'Agusan del Sur', 1,  'Philippines'),
('Calayaan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Calibungan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Calibutbut', 3,  'Agusan del Sur', 1,  'Philippines'),
('Calingcuan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Calumpang', 3,  'Agusan del Sur', 1,  'Philippines'),
('Calumpit', 3,  'Agusan del Sur', 1,  'Philippines'),
('Cama Juan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Camachile', 3,  'Agusan del Sur', 1,  'Philippines'),
('Camias', 3,  'Agusan del Sur', 1,  'Philippines'),
('Candating', 3,  'Agusan del Sur', 1,  'Philippines'),
('Carmen', 3,  'Agusan del Sur', 1,  'Philippines'),
('Cavite', 3,  'Agusan del Sur', 1,  'Philippines'),
('Cawayan Bugtong', 3,  'Agusan del Sur', 1,  'Philippines'),
('City of Balanga', 3,  'Agusan del Sur', 1,  'Philippines'),
('City of Gapan', 3,  'Agusan del Sur', 1,  'Philippines'),
('City of Malolos', 3,  'Agusan del Sur', 1,  'Philippines'),
('City of Meycauayan', 3,  'Agusan del Sur', 1,  'Philippines'),
('City of San Fernando', 3,  'Agusan del Sur', 1,  'Philippines'),
('City of San Jose del Monte', 3,  'Agusan del Sur', 1,  'Philippines'),
('Comillas', 3,  'Agusan del Sur', 1,  'Philippines'),
('Communal', 3,  'Agusan del Sur', 1,  'Philippines'),
('Concepcion', 3,  'Agusan del Sur', 1,  'Philippines'),
('Conversion', 3,  'Agusan del Sur', 1,  'Philippines'),
('Culianin', 3,  'Agusan del Sur', 1,  'Philippines'),
('Culubasa', 3,  'Agusan del Sur', 1,  'Philippines'),
('Cut-cut Primero', 3,  'Agusan del Sur', 1,  'Philippines'),
('Dampol', 3,  'Agusan del Sur', 1,  'Philippines'),
('Del Pilar', 3,  'Agusan del Sur', 1,  'Philippines'),
('Digdig', 3,  'Agusan del Sur', 1,  'Philippines'),
('Diliman Primero', 3,  'Agusan del Sur', 1,  'Philippines'),
('Dinalongan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Dinalupihan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Entablado', 3,  'Agusan del Sur', 1,  'Philippines'),
('Estipona', 3,  'Agusan del Sur', 1,  'Philippines'),
('Estrella', 3,  'Agusan del Sur', 1,  'Philippines'),
('Gueset', 3,  'Agusan del Sur', 1,  'Philippines'),
('Guiguinto', 3,  'Agusan del Sur', 1,  'Philippines'),
('Guisguis', 3,  'Agusan del Sur', 1,  'Philippines'),
('Guyong', 3,  'Agusan del Sur', 1,  'Philippines'),
('Hermosa', 3,  'Agusan del Sur', 1,  'Philippines'),
('Lambakin', 3,  'Agusan del Sur', 1,  'Philippines'),
('Lanat', 3,  'Agusan del Sur', 1,  'Philippines'),
('Laug', 3,  'Agusan del Sur', 1,  'Philippines'),
('Lawang Kupang', 3,  'Agusan del Sur', 1,  'Philippines'),
('Lennec', 3,  'Agusan del Sur', 1,  'Philippines'),
('Ligaya', 3,  'Agusan del Sur', 1,  'Philippines'),
('Liozon', 3,  'Agusan del Sur', 1,  'Philippines'),
('Lipay', 3,  'Agusan del Sur', 1,  'Philippines'),
('Lomboy', 3,  'Agusan del Sur', 1,  'Philippines'),
('Lourdes', 3,  'Agusan del Sur', 1,  'Philippines'),
('Lucapon', 3,  'Agusan del Sur', 1,  'Philippines'),
('Mabayo', 3,  'Agusan del Sur', 1,  'Philippines'),
('Mabilang', 3,  'Agusan del Sur', 1,  'Philippines'),
('Mabilog', 3,  'Agusan del Sur', 1,  'Philippines'),
('Macapsing', 3,  'Agusan del Sur', 1,  'Philippines'),
('Macarse', 3,  'Agusan del Sur', 1,  'Philippines'),
('Macatbong', 3,  'Agusan del Sur', 1,  'Philippines'),
('Magliman', 3,  'Agusan del Sur', 1,  'Philippines'),
('Magtangol', 3,  'Agusan del Sur', 1,  'Philippines'),
('Maguinao', 3,  'Agusan del Sur', 1,  'Philippines'),
('Malabon', 3,  'Agusan del Sur', 1,  'Philippines'),
('Malacampa', 3,  'Agusan del Sur', 1,  'Philippines'),
('Maligaya', 3,  'Agusan del Sur', 1,  'Philippines'),
('Malino', 3,  'Agusan del Sur', 1,  'Philippines'),
('Malolos', 3,  'Agusan del Sur', 1,  'Philippines'),
('Maloma', 3,  'Agusan del Sur', 1,  'Philippines'),
('Maluid', 3,  'Agusan del Sur', 1,  'Philippines'),
('Malusac', 3,  'Agusan del Sur', 1,  'Philippines'),
('Mambog', 3,  'Agusan del Sur', 1,  'Philippines'),
('Mamonit', 3,  'Agusan del Sur', 1,  'Philippines'),
('Manacsac', 3,  'Agusan del Sur', 1,  'Philippines'),
('Manatal', 3,  'Agusan del Sur', 1,  'Philippines'),
('Mandili', 3,  'Agusan del Sur', 1,  'Philippines'),
('Mangga', 3,  'Agusan del Sur', 1,  'Philippines'),
('Manibaug Pasig', 3,  'Agusan del Sur', 1,  'Philippines'),
('Manogpi', 3,  'Agusan del Sur', 1,  'Philippines'),
('Mapalacsiao', 3,  'Agusan del Sur', 1,  'Philippines'),
('Mapalad', 3,  'Agusan del Sur', 1,  'Philippines'),
('Mapaniqui', 3,  'Agusan del Sur', 1,  'Philippines'),
('Maquiapo', 3,  'Agusan del Sur', 1,  'Philippines'),
('Marawa', 3,  'Agusan del Sur', 1,  'Philippines'),
('Marilao', 3,  'Agusan del Sur', 1,  'Philippines'),
('Mariveles', 3,  'Agusan del Sur', 1,  'Philippines'),
('Masalipit', 3,  'Agusan del Sur', 1,  'Philippines'),
('Matayumtayum', 3,  'Agusan del Sur', 1,  'Philippines'),
('Maturanoc', 3,  'Agusan del Sur', 1,  'Philippines'),
('Meycauayan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Moriones', 3,  'Agusan del Sur', 1,  'Philippines'),
('Motrico', 3,  'Agusan del Sur', 1,  'Philippines'),
('Nagpandayan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Nambalan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Nancamarinan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Nieves', 3,  'Agusan del Sur', 1,  'Philippines'),
('Niugan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Norzagaray', 3,  'Agusan del Sur', 1,  'Philippines'),
('Obando', 3,  'Agusan del Sur', 1,  'Philippines'),
('Orani', 3,  'Agusan del Sur', 1,  'Philippines'),
('Paco Roman', 3,  'Agusan del Sur', 1,  'Philippines'),
('Padapada', 3,  'Agusan del Sur', 1,  'Philippines'),
('Paitan Norte', 3,  'Agusan del Sur', 1,  'Philippines'),
('Palusapis', 3,  'Agusan del Sur', 1,  'Philippines'),
('Pamatawan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Panabingan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Panan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Pance', 3,  'Agusan del Sur', 1,  'Philippines'),
('Pandacaqui', 3,  'Agusan del Sur', 1,  'Philippines'),
('Pandi', 3,  'Agusan del Sur', 1,  'Philippines'),
('Pando', 3,  'Agusan del Sur', 1,  'Philippines'),
('Pantubig', 3,  'Agusan del Sur', 1,  'Philippines'),
('Paombong', 3,  'Agusan del Sur', 1,  'Philippines'),
('Papaya', 3,  'Agusan del Sur', 1,  'Philippines'),
('Parista', 3,  'Agusan del Sur', 1,  'Philippines'),
('Pau', 3,  'Agusan del Sur', 1,  'Philippines'),
('Pias', 3,  'Agusan del Sur', 1,  'Philippines'),
('Piñahan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Pinambaran', 3,  'Agusan del Sur', 1,  'Philippines'),
('Pio', 3,  'Agusan del Sur', 1,  'Philippines'),
('Porais', 3,  'Agusan del Sur', 1,  'Philippines'),
('Prado Siongco', 3,  'Agusan del Sur', 1,  'Philippines'),
('Pulilan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Pulo', 3,  'Agusan del Sur', 1,  'Philippines'),
('Pulong Gubat', 3,  'Agusan del Sur', 1,  'Philippines'),
('Pulong Sampalok', 3,  'Agusan del Sur', 1,  'Philippines'),
('Pulung Santol', 3,  'Agusan del Sur', 1,  'Philippines'),
('Pulungmasle', 3,  'Agusan del Sur', 1,  'Philippines'),
('Puncan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Purac', 3,  'Agusan del Sur', 1,  'Philippines'),
('Putlod', 3,  'Agusan del Sur', 1,  'Philippines'),
('Rajal Norte', 3,  'Agusan del Sur', 1,  'Philippines'),
('Sabang', 3,  'Agusan del Sur', 1,  'Philippines'),
('Sagana', 3,  'Agusan del Sur', 1,  'Philippines'),
('Salapungan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Salaza', 3,  'Agusan del Sur', 1,  'Philippines'),
('Salvacion I', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Alejandro', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Andres', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Anton', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Basilio', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Casimiro', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Cristobal', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Felipe Old', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Francisco', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Jose del Monte', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Juan de Mata', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Lorenzo', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Luis', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Mariano', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Nicolas', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Patricio', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Rafael', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Roque', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Roque Dau First', 3,  'Agusan del Sur', 1,  'Philippines'),
('San Vincente', 3,  'Agusan del Sur', 1,  'Philippines'),
('Santa Fe', 3,  'Agusan del Sur', 1,  'Philippines'),
('Santa Ines West', 3,  'Agusan del Sur', 1,  'Philippines'),
('Santa Juliana', 3,  'Agusan del Sur', 1,  'Philippines'),
('Santa Maria', 3,  'Agusan del Sur', 1,  'Philippines'),
('Santa Monica', 3,  'Agusan del Sur', 1,  'Philippines'),
('Santa Rita', 3,  'Agusan del Sur', 1,  'Philippines'),
('Santa Teresa First', 3,  'Agusan del Sur', 1,  'Philippines'),
('Santo Cristo', 3,  'Agusan del Sur', 1,  'Philippines'),
('Santo Rosario', 3,  'Agusan del Sur', 1,  'Philippines'),
('Sapang', 3,  'Agusan del Sur', 1,  'Philippines'),
('Sapang Buho', 3,  'Agusan del Sur', 1,  'Philippines'),
('Sapol', 3,  'Agusan del Sur', 1,  'Philippines'),
('Saysain', 3,  'Agusan del Sur', 1,  'Philippines'),
('Sibul', 3,  'Agusan del Sur', 1,  'Philippines'),
('Siclong', 3,  'Agusan del Sur', 1,  'Philippines'),
('Sinilian First', 3,  'Agusan del Sur', 1,  'Philippines'),
('Soledad', 3,  'Agusan del Sur', 1,  'Philippines'),
('Suklayin', 3,  'Agusan del Sur', 1,  'Philippines'),
('Sula', 3,  'Agusan del Sur', 1,  'Philippines'),
('Sulucan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Tabacao', 3,  'Agusan del Sur', 1,  'Philippines'),
('Tabon', 3,  'Agusan del Sur', 1,  'Philippines'),
('Tabuating', 3,  'Agusan del Sur', 1,  'Philippines'),
('Tal I Mun Doc', 3,  'Agusan del Sur', 1,  'Philippines'),
('Talaga', 3,  'Agusan del Sur', 1,  'Philippines'),
('Talang', 3,  'Agusan del Sur', 1,  'Philippines'),
('Taltal', 3,  'Agusan del Sur', 1,  'Philippines'),
('Tariji', 3,  'Agusan del Sur', 1,  'Philippines'),
('Tayabo', 3,  'Agusan del Sur', 1,  'Philippines'),
('Telabastagan', 3,  'Agusan del Sur', 1,  'Philippines'),
('Tikiw', 3,  'Agusan del Sur', 1,  'Philippines'),
('Tinang', 3,  'Agusan del Sur', 1,  'Philippines'),
('Tondod', 3,  'Agusan del Sur', 1,  'Philippines'),
('Uacon', 3,  'Agusan del Sur', 1,  'Philippines'),
('Umiray', 3,  'Agusan del Sur', 1,  'Philippines'),
('Upig', 3,  'Agusan del Sur', 1,  'Philippines'),
('Vargas', 3,  'Agusan del Sur', 1,  'Philippines'),
('Villa Aglipay', 3,  'Agusan del Sur', 1,  'Philippines'),
('Villa Isla', 3,  'Agusan del Sur', 1,  'Philippines'),
('Vizal San Pablo', 3,  'Agusan del Sur', 1,  'Philippines'),
('Vizal Santo Niño', 3,  'Agusan del Sur', 1,  'Philippines'),
('Altavas', 4,  'Aklan', 1,  'Philippines'),
('Balete', 4,  'Aklan', 1,  'Philippines'),
('Banga', 4,  'Aklan', 1,  'Philippines'),
('Batan', 4,  'Aklan', 1,  'Philippines'),
('Buruanga', 4,  'Aklan', 1,  'Philippines'),
('Ibajay', 4,  'Aklan', 1,  'Philippines'),
('Kalibo', 4,  'Aklan', 1,  'Philippines'),
('Lezo', 4,  'Aklan', 1,  'Philippines'),
('Libacao', 4,  'Aklan', 1,  'Philippines'),
('Madalag', 4,  'Aklan', 1,  'Philippines'),
('Makato', 4,  'Aklan', 1,  'Philippines'),
('Malay', 4,  'Aklan', 1,  'Philippines'),
('Malinao', 4,  'Aklan', 1,  'Philippines'),
('Nabas', 4,  'Aklan', 1,  'Philippines'),
('New Washington', 4,  'Aklan', 1,  'Philippines'),
('Numancia', 4,  'Aklan', 1,  'Philippines'),
('Tangalan', 4,  'Aklan', 1,  'Philippines'),
('Aanislag', 5,  'Albay', 1,  'Philippines'),
('Abucay', 5,  'Albay', 1,  'Philippines'),
('Agos', 5,  'Albay', 1,  'Philippines'),
('Aguada', 5,  'Albay', 1,  'Philippines'),
('Agupit', 5,  'Albay', 1,  'Philippines'),
('Alayao', 5,  'Albay', 1,  'Philippines'),
('Anuling', 5,  'Albay', 1,  'Philippines'),
('Apad', 5,  'Albay', 1,  'Philippines'),
('Apud', 5,  'Albay', 1,  'Philippines'),
('Armenia', 5,  'Albay', 1,  'Philippines'),
('Ayugan', 5,  'Albay', 1,  'Philippines'),
('Bacacay', 5,  'Albay', 1,  'Philippines'),
('Bacolod', 5,  'Albay', 1,  'Philippines'),
('Bacon', 5,  'Albay', 1,  'Philippines'),
('Bagacay', 5,  'Albay', 1,  'Philippines'),
('Bagahanlad', 5,  'Albay', 1,  'Philippines'),
('Bagumbayan', 5,  'Albay', 1,  'Philippines'),
('Bahay', 5,  'Albay', 1,  'Philippines'),
('Balading', 5,  'Albay', 1,  'Philippines'),
('Balaogan', 5,  'Albay', 1,  'Philippines'),
('Baligang', 5,  'Albay', 1,  'Philippines'),
('Balinad', 5,  'Albay', 1,  'Philippines'),
('Baliuag Nuevo', 5,  'Albay', 1,  'Philippines'),
('Balucawi', 5,  'Albay', 1,  'Philippines'),
('Banag', 5,  'Albay', 1,  'Philippines'),
('Bangkirohan', 5,  'Albay', 1,  'Philippines'),
('Banocboc', 5,  'Albay', 1,  'Philippines'),
('Bao', 5,  'Albay', 1,  'Philippines'),
('Barayong', 5,  'Albay', 1,  'Philippines'),
('Bariw', 5,  'Albay', 1,  'Philippines'),
('Barra', 5,  'Albay', 1,  'Philippines'),
('Bascaron', 5,  'Albay', 1,  'Philippines'),
('Basiad', 5,  'Albay', 1,  'Philippines'),
('Basicao Coastal', 5,  'Albay', 1,  'Philippines'),
('Basud', 5,  'Albay', 1,  'Philippines'),
('Batana', 5,  'Albay', 1,  'Philippines'),
('Batobalane', 5,  'Albay', 1,  'Philippines'),
('Beberon', 5,  'Albay', 1,  'Philippines'),
('Bigaa', 5,  'Albay', 1,  'Philippines'),
('Binanwanaan', 5,  'Albay', 1,  'Philippines'),
('Binitayan', 5,  'Albay', 1,  'Philippines'),
('Binodegahan', 5,  'Albay', 1,  'Philippines'),
('Bonga', 5,  'Albay', 1,  'Philippines'),
('Boton', 5,  'Albay', 1,  'Philippines'),
('Buang', 5,  'Albay', 1,  'Philippines'),
('Buenavista', 5,  'Albay', 1,  'Philippines'),
('Buga', 5,  'Albay', 1,  'Philippines'),
('Buhatan', 5,  'Albay', 1,  'Philippines'),
('Bulo', 5,  'Albay', 1,  'Philippines'),
('Buluang', 5,  'Albay', 1,  'Philippines'),
('Burabod', 5,  'Albay', 1,  'Philippines'),
('Buracan', 5,  'Albay', 1,  'Philippines'),
('Busing', 5,  'Albay', 1,  'Philippines'),
('Butag', 5,  'Albay', 1,  'Philippines'),
('Buyo', 5,  'Albay', 1,  'Philippines'),
('Cabcab', 5,  'Albay', 1,  'Philippines'),
('Cabiguan', 5,  'Albay', 1,  'Philippines'),
('Cabitan', 5,  'Albay', 1,  'Philippines'),
('Cabognon', 5,  'Albay', 1,  'Philippines'),
('Caditaan', 5,  'Albay', 1,  'Philippines'),
('Cadlan', 5,  'Albay', 1,  'Philippines'),
('Cagmanaba', 5,  'Albay', 1,  'Philippines'),
('Calabaca', 5,  'Albay', 1,  'Philippines'),
('Calachuchi', 5,  'Albay', 1,  'Philippines'),
('Calasgasan', 5,  'Albay', 1,  'Philippines'),
('Calolbon', 5,  'Albay', 1,  'Philippines'),
('Camalig', 5,  'Albay', 1,  'Philippines'),
('Canomoy', 5,  'Albay', 1,  'Philippines'),
('Capalonga', 5,  'Albay', 1,  'Philippines'),
('Capucnasan', 5,  'Albay', 1,  'Philippines'),
('Capuy', 5,  'Albay', 1,  'Philippines'),
('Caranan', 5,  'Albay', 1,  'Philippines'),
('Caraycayon', 5,  'Albay', 1,  'Philippines'),
('Castillo', 5,  'Albay', 1,  'Philippines'),
('Catabangan', 5,  'Albay', 1,  'Philippines'),
('Causip', 5,  'Albay', 1,  'Philippines'),
('Cotmon', 5,  'Albay', 1,  'Philippines'),
('Culacling', 5,  'Albay', 1,  'Philippines'),
('Cumadcad', 5,  'Albay', 1,  'Philippines'),
('Curry', 5,  'Albay', 1,  'Philippines'),
('Daet', 5,  'Albay', 1,  'Philippines'),
('Daguit', 5,  'Albay', 1,  'Philippines'),
('Dalupaon', 5,  'Albay', 1,  'Philippines'),
('Dangcalan', 5,  'Albay', 1,  'Philippines'),
('Dapdap', 5,  'Albay', 1,  'Philippines'),
('Daraga', 5,  'Albay', 1,  'Philippines'),
('Del Rosario', 5,  'Albay', 1,  'Philippines'),
('Dugcal', 5,  'Albay', 1,  'Philippines'),
('Dugongan', 5,  'Albay', 1,  'Philippines'),
('Estancia', 5,  'Albay', 1,  'Philippines'),
('Fabrica', 5,  'Albay', 1,  'Philippines'),
('Gabao', 5,  'Albay', 1,  'Philippines'),
('Gambalidio', 5,  'Albay', 1,  'Philippines'),
('Gatbo', 5,  'Albay', 1,  'Philippines'),
('Gibgos', 5,  'Albay', 1,  'Philippines'),
('Guijalo', 5,  'Albay', 1,  'Philippines'),
('Guinacotan', 5,  'Albay', 1,  'Philippines'),
('Guinobatan', 5,  'Albay', 1,  'Philippines'),
('Gumaus', 5,  'Albay', 1,  'Philippines'),
('Guruyan', 5,  'Albay', 1,  'Philippines'),
('Hamoraon', 5,  'Albay', 1,  'Philippines'),
('Herrera', 5,  'Albay', 1,  'Philippines'),
('Himaao', 5,  'Albay', 1,  'Philippines'),
('Hobo', 5,  'Albay', 1,  'Philippines'),
('Imelda', 5,  'Albay', 1,  'Philippines'),
('Inapatan', 5,  'Albay', 1,  'Philippines'),
('Iraya', 5,  'Albay', 1,  'Philippines'),
('Joroan', 5,  'Albay', 1,  'Philippines'),
('Jose Pañganiban', 5,  'Albay', 1,  'Philippines'),
('Jovellar', 5,  'Albay', 1,  'Philippines'),
('Kaliliog', 5,  'Albay', 1,  'Philippines'),
('Kinalansan', 5,  'Albay', 1,  'Philippines'),
('Labnig', 5,  'Albay', 1,  'Philippines'),
('Labo', 5,  'Albay', 1,  'Philippines'),
('Lacag', 5,  'Albay', 1,  'Philippines'),
('Lajong', 5,  'Albay', 1,  'Philippines'),
('Lanigay', 5,  'Albay', 1,  'Philippines'),
('Lantangan', 5,  'Albay', 1,  'Philippines'),
('Larap', 5,  'Albay', 1,  'Philippines'),
('Legaspi', 5,  'Albay', 1,  'Philippines'),
('Libog', 5,  'Albay', 1,  'Philippines'),
('Libon', 5,  'Albay', 1,  'Philippines'),
('Liboro', 5,  'Albay', 1,  'Philippines'),
('Ligao', 5,  'Albay', 1,  'Philippines'),
('Limbuhan', 5,  'Albay', 1,  'Philippines'),
('Lubigan', 5,  'Albay', 1,  'Philippines'),
('Lugui', 5,  'Albay', 1,  'Philippines'),
('Luklukan', 5,  'Albay', 1,  'Philippines'),
('Lupi Viejo', 5,  'Albay', 1,  'Philippines'),
('Maagnas', 5,  'Albay', 1,  'Philippines'),
('Mabiton', 5,  'Albay', 1,  'Philippines'),
('Macabugos', 5,  'Albay', 1,  'Philippines'),
('Macalaya', 5,  'Albay', 1,  'Philippines'),
('Magsalangi', 5,  'Albay', 1,  'Philippines'),
('Mahaba', 5,  'Albay', 1,  'Philippines'),
('Malabog', 5,  'Albay', 1,  'Philippines'),
('Malasugui', 5,  'Albay', 1,  'Philippines'),
('Malatap', 5,  'Albay', 1,  'Philippines'),
('Malawag', 5,  'Albay', 1,  'Philippines'),
('Malbug', 5,  'Albay', 1,  'Philippines'),
('Malidong', 5,  'Albay', 1,  'Philippines'),
('Malilipot', 5,  'Albay', 1,  'Philippines'),
('Malinta', 5,  'Albay', 1,  'Philippines'),
('Mambulo', 5,  'Albay', 1,  'Philippines'),
('Mampurog', 5,  'Albay', 1,  'Philippines'),
('Manamrag', 5,  'Albay', 1,  'Philippines'),
('Manito', 5,  'Albay', 1,  'Philippines'),
('Manquiring', 5,  'Albay', 1,  'Philippines'),
('Maonon', 5,  'Albay', 1,  'Philippines'),
('Marintoc', 5,  'Albay', 1,  'Philippines'),
('Marupit', 5,  'Albay', 1,  'Philippines'),
('Masaraway', 5,  'Albay', 1,  'Philippines'),
('Maslog', 5,  'Albay', 1,  'Philippines'),
('Masoli', 5,  'Albay', 1,  'Philippines'),
('Matacon', 5,  'Albay', 1,  'Philippines'),
('Mauraro', 5,  'Albay', 1,  'Philippines'),
('Mayngaran', 5,  'Albay', 1,  'Philippines'),
('Mercedes', 5,  'Albay', 1,  'Philippines'),
('Miaga', 5,  'Albay', 1,  'Philippines'),
('Miliroc', 5,  'Albay', 1,  'Philippines'),
('Monbon', 5,  'Albay', 1,  'Philippines'),
('Muladbucad', 5,  'Albay', 1,  'Philippines'),
('Naagas', 5,  'Albay', 1,  'Philippines'),
('Nabangig', 5,  'Albay', 1,  'Philippines'),
('Naro', 5,  'Albay', 1,  'Philippines'),
('Nato', 5,  'Albay', 1,  'Philippines'),
('Odicon', 5,  'Albay', 1,  'Philippines'),
('Ogod', 5,  'Albay', 1,  'Philippines'),
('Osiao', 5,  'Albay', 1,  'Philippines'),
('Osmeña', 5,  'Albay', 1,  'Philippines'),
('Padang', 5,  'Albay', 1,  'Philippines'),
('Palali', 5,  'Albay', 1,  'Philippines'),
('Palestina', 5,  'Albay', 1,  'Philippines'),
('Palsong', 5,  'Albay', 1,  'Philippines'),
('Pambuhan', 5,  'Albay', 1,  'Philippines'),
('Pandan', 5,  'Albay', 1,  'Philippines'),
('Panguiranan', 5,  'Albay', 1,  'Philippines'),
('Pantao', 5,  'Albay', 1,  'Philippines'),
('Parabcan', 5,  'Albay', 1,  'Philippines'),
('Paracale', 5,  'Albay', 1,  'Philippines'),
('Paulba', 5,  'Albay', 1,  'Philippines'),
('Pawa', 5,  'Albay', 1,  'Philippines'),
('Pawican', 5,  'Albay', 1,  'Philippines'),
('Pawili', 5,  'Albay', 1,  'Philippines'),
('Peña', 5,  'Albay', 1,  'Philippines'),
('Pinit', 5,  'Albay', 1,  'Philippines'),
('Pio Duran', 5,  'Albay', 1,  'Philippines'),
('Polangui', 5,  'Albay', 1,  'Philippines'),
('Ponso', 5,  'Albay', 1,  'Philippines'),
('Potot', 5,  'Albay', 1,  'Philippines'),
('Puro', 5,  'Albay', 1,  'Philippines'),
('Putiao', 5,  'Albay', 1,  'Philippines'),
('Quitang', 5,  'Albay', 1,  'Philippines'),
('Rapu-Rapu', 5,  'Albay', 1,  'Philippines'),
('Recodo', 5,  'Albay', 1,  'Philippines'),
('Sabang Indan', 5,  'Albay', 1,  'Philippines'),
('Sagpon', 5,  'Albay', 1,  'Philippines'),
('Sagrada', 5,  'Albay', 1,  'Philippines'),
('Sagrada Familia', 5,  'Albay', 1,  'Philippines'),
('Sagurong', 5,  'Albay', 1,  'Philippines'),
('Salingogan', 5,  'Albay', 1,  'Philippines'),
('Salogon', 5,  'Albay', 1,  'Philippines'),
('Salvacion', 5,  'Albay', 1,  'Philippines'),
('San Lucas', 5,  'Albay', 1,  'Philippines'),
('San Pascual', 5,  'Albay', 1,  'Philippines'),
('San Ramon', 5,  'Albay', 1,  'Philippines'),
('Santa Elena', 5,  'Albay', 1,  'Philippines'),
('Santa Justina', 5,  'Albay', 1,  'Philippines'),
('Santa Rosa Sur', 5,  'Albay', 1,  'Philippines'),
('Santa Teresita', 5,  'Albay', 1,  'Philippines'),
('Santo Domingo', 5,  'Albay', 1,  'Philippines'),
('Sinuknipan', 5,  'Albay', 1,  'Philippines'),
('Sugcad', 5,  'Albay', 1,  'Philippines'),
('Sugod', 5,  'Albay', 1,  'Philippines'),
('Tabaco', 5,  'Albay', 1,  'Philippines'),
('Tagas', 5,  'Albay', 1,  'Philippines'),
('Tagoytoy', 5,  'Albay', 1,  'Philippines'),
('Talisay', 5,  'Albay', 1,  'Philippines'),
('Talubatib', 5,  'Albay', 1,  'Philippines'),
('Tambo', 5,  'Albay', 1,  'Philippines'),
('Tara', 5,  'Albay', 1,  'Philippines'),
('Tariric', 5,  'Albay', 1,  'Philippines'),
('Tigbaw', 5,  'Albay', 1,  'Philippines'),
('Tigbinan', 5,  'Albay', 1,  'Philippines'),
('Tinago', 5,  'Albay', 1,  'Philippines'),
('Tinalmud', 5,  'Albay', 1,  'Philippines'),
('Tinampo', 5,  'Albay', 1,  'Philippines'),
('Tinawagan', 5,  'Albay', 1,  'Philippines'),
('Tiwi', 5,  'Albay', 1,  'Philippines'),
('Tubli', 5,  'Albay', 1,  'Philippines'),
('Tugos', 5,  'Albay', 1,  'Philippines'),
('Tulay na Lupa', 5,  'Albay', 1,  'Philippines'),
('Tumalaytay', 5,  'Albay', 1,  'Philippines'),
('Umabay', 5,  'Albay', 1,  'Philippines'),
('Usab', 5,  'Albay', 1,  'Philippines'),
('Uson', 5,  'Albay', 1,  'Philippines'),
('Utabi', 5,  'Albay', 1,  'Philippines'),
('Villahermosa', 5,  'Albay', 1,  'Philippines'),
('Vinzons', 5,  'Albay', 1,  'Philippines'),
('Abaca', 6,  'Antique', 1,  'Philippines'),
('Abangay', 6,  'Antique', 1,  'Philippines'),
('Abiera', 6,  'Antique', 1,  'Philippines'),
('Abilay', 6,  'Antique', 1,  'Philippines'),
('Ag-ambulong', 6,  'Antique', 1,  'Philippines'),
('Aganan', 6,  'Antique', 1,  'Philippines'),
('Aglalana', 6,  'Antique', 1,  'Philippines'),
('Agpangi', 6,  'Antique', 1,  'Philippines'),
('Aguisan', 6,  'Antique', 1,  'Philippines'),
('Alacaygan', 6,  'Antique', 1,  'Philippines'),
('Alegria', 6,  'Antique', 1,  'Philippines'),
('Alibunan', 6,  'Antique', 1,  'Philippines'),
('Alicante', 6,  'Antique', 1,  'Philippines'),
('Alijis', 6,  'Antique', 1,  'Philippines'),
('Alim', 6,  'Antique', 1,  'Philippines'),
('Alimono', 6,  'Antique', 1,  'Philippines'),
('Ambulong', 6,  'Antique', 1,  'Philippines'),
('Andres Bonifacio', 6,  'Antique', 1,  'Philippines'),
('Anini-y', 6,  'Antique', 1,  'Philippines'),
('Anoring', 6,  'Antique', 1,  'Philippines'),
('Aquino', 6,  'Antique', 1,  'Philippines'),
('Araal', 6,  'Antique', 1,  'Philippines'),
('Aranas Sur', 6,  'Antique', 1,  'Philippines'),
('Aranda', 6,  'Antique', 1,  'Philippines'),
('Arcangel', 6,  'Antique', 1,  'Philippines'),
('Asia', 6,  'Antique', 1,  'Philippines'),
('Asturga', 6,  'Antique', 1,  'Philippines'),
('Atabayan', 6,  'Antique', 1,  'Philippines'),
('Atipuluhan', 6,  'Antique', 1,  'Philippines'),
('Aurelliana', 6,  'Antique', 1,  'Philippines'),
('Avila', 6,  'Antique', 1,  'Philippines'),
('Bacalan', 6,  'Antique', 1,  'Philippines'),
('Bacolod City', 6,  'Antique', 1,  'Philippines'),
('Bacuyangan', 6,  'Antique', 1,  'Philippines'),
('Badlan', 6,  'Antique', 1,  'Philippines'),
('Bago City', 6,  'Antique', 1,  'Philippines'),
('Bagroy', 6,  'Antique', 1,  'Philippines'),
('Bailan', 6,  'Antique', 1,  'Philippines'),
('Balabag', 6,  'Antique', 1,  'Philippines'),
('Balibagan Oeste', 6,  'Antique', 1,  'Philippines'),
('Baliwagan', 6,  'Antique', 1,  'Philippines'),
('Bancal', 6,  'Antique', 1,  'Philippines'),
('Barbaza', 6,  'Antique', 1,  'Philippines'),
('Basiao', 6,  'Antique', 1,  'Philippines'),
('Bay-ang', 6,  'Antique', 1,  'Philippines'),
('Bayas', 6,  'Antique', 1,  'Philippines'),
('Belison', 6,  'Antique', 1,  'Philippines'),
('Biao', 6,  'Antique', 1,  'Philippines'),
('Bilao', 6,  'Antique', 1,  'Philippines'),
('Binabaan', 6,  'Antique', 1,  'Philippines'),
('Binantocan', 6,  'Antique', 1,  'Philippines'),
('Binon-an', 6,  'Antique', 1,  'Philippines'),
('Binonga', 6,  'Antique', 1,  'Philippines'),
('Bitadtun', 6,  'Antique', 1,  'Philippines'),
('Bocana', 6,  'Antique', 1,  'Philippines'),
('Bolanon', 6,  'Antique', 1,  'Philippines'),
('Bolilao', 6,  'Antique', 1,  'Philippines'),
('Bolong', 6,  'Antique', 1,  'Philippines'),
('Brgy. Bachaw Norte Kalibo', 6,  'Antique', 1,  'Philippines'),
('Brgy. Bulwang Numancia', 6,  'Antique', 1,  'Philippines'),
('Brgy. Mabilo New Washington', 6,  'Antique', 1,  'Philippines'),
('Brgy. Nalook kalibo', 6,  'Antique', 1,  'Philippines'),
('Brgy. New Buswang Kalibo', 6,  'Antique', 1,  'Philippines'),
('Brgy. Tinigao Kalibo', 6,  'Antique', 1,  'Philippines'),
('Bugang', 6,  'Antique', 1,  'Philippines'),
('Bugasong', 6,  'Antique', 1,  'Philippines'),
('Bulad', 6,  'Antique', 1,  'Philippines'),
('Bulata', 6,  'Antique', 1,  'Philippines'),
('Buluangan', 6,  'Antique', 1,  'Philippines'),
('Bungsuan', 6,  'Antique', 1,  'Philippines'),
('Buray', 6,  'Antique', 1,  'Philippines'),
('Burias', 6,  'Antique', 1,  'Philippines'),
('Busay', 6,  'Antique', 1,  'Philippines'),
('Buyuan', 6,  'Antique', 1,  'Philippines'),
('Cabacungan', 6,  'Antique', 1,  'Philippines'),
('Cabadiangan', 6,  'Antique', 1,  'Philippines'),
('Cabanbanan', 6,  'Antique', 1,  'Philippines'),
('Cabano', 6,  'Antique', 1,  'Philippines'),
('Cabilao', 6,  'Antique', 1,  'Philippines'),
('Cabilauan', 6,  'Antique', 1,  'Philippines'),
('Cadagmayan Norte', 6,  'Antique', 1,  'Philippines'),
('Cagbang', 6,  'Antique', 1,  'Philippines'),
('Calampisauan', 6,  'Antique', 1,  'Philippines'),
('Calape', 6,  'Antique', 1,  'Philippines'),
('Calaya', 6,  'Antique', 1,  'Philippines'),
('Calizo', 6,  'Antique', 1,  'Philippines'),
('Caluya', 6,  'Antique', 1,  'Philippines'),
('Camalobalo', 6,  'Antique', 1,  'Philippines'),
('Camandag', 6,  'Antique', 1,  'Philippines'),
('Camangcamang', 6,  'Antique', 1,  'Philippines'),
('Camindangan', 6,  'Antique', 1,  'Philippines'),
('Camingawan', 6,  'Antique', 1,  'Philippines'),
('Caningay', 6,  'Antique', 1,  'Philippines'),
('Canroma', 6,  'Antique', 1,  'Philippines'),
('Cansilayan', 6,  'Antique', 1,  'Philippines'),
('Cansolungon', 6,  'Antique', 1,  'Philippines'),
('Canturay', 6,  'Antique', 1,  'Philippines'),
('Capaga', 6,  'Antique', 1,  'Philippines'),
('Capitan Ramon', 6,  'Antique', 1,  'Philippines'),
('Carabalan', 6,  'Antique', 1,  'Philippines'),
('Caridad', 6,  'Antique', 1,  'Philippines'),
('Carmelo', 6,  'Antique', 1,  'Philippines'),
('Carmen Grande', 6,  'Antique', 1,  'Philippines'),
('Cartagena', 6,  'Antique', 1,  'Philippines'),
('Cassanayan', 6,  'Antique', 1,  'Philippines'),
('Caticlan', 6,  'Antique', 1,  'Philippines'),
('Catungan', 6,  'Antique', 1,  'Philippines'),
('Cayanguan', 6,  'Antique', 1,  'Philippines'),
('Cayhagan', 6,  'Antique', 1,  'Philippines'),
('Cervantes', 6,  'Antique', 1,  'Philippines'),
('Chambrey', 6,  'Antique', 1,  'Philippines'),
('Codcod', 6,  'Antique', 1,  'Philippines'),
('Cogon', 6,  'Antique', 1,  'Philippines'),
('Colipapa', 6,  'Antique', 1,  'Philippines'),
('Concordia', 6,  'Antique', 1,  'Philippines'),
('Constancia', 6,  'Antique', 1,  'Philippines'),
('Consuelo', 6,  'Antique', 1,  'Philippines'),
('Cortez', 6,  'Antique', 1,  'Philippines'),
('Culasi', 6,  'Antique', 1,  'Philippines'),
('Da-an Sur', 6,  'Antique', 1,  'Philippines'),
('Daliciasao', 6,  'Antique', 1,  'Philippines'),
('Damayan', 6,  'Antique', 1,  'Philippines'),
('Dancalan', 6,  'Antique', 1,  'Philippines'),
('Dapdapan', 6,  'Antique', 1,  'Philippines'),
('De la Paz', 6,  'Antique', 1,  'Philippines'),
('Dian-ay', 6,  'Antique', 1,  'Philippines'),
('Dos Hermanas', 6,  'Antique', 1,  'Philippines'),
('Dulangan', 6,  'Antique', 1,  'Philippines'),
('Dulao', 6,  'Antique', 1,  'Philippines'),
('Dungon', 6,  'Antique', 1,  'Philippines'),
('Duran', 6,  'Antique', 1,  'Philippines'),
('East Valencia', 6,  'Antique', 1,  'Philippines'),
('Egaña', 6,  'Antique', 1,  'Philippines'),
('Ermita', 6,  'Antique', 1,  'Philippines'),
('Eustaquio Lopez', 6,  'Antique', 1,  'Philippines'),
('Feliciano', 6,  'Antique', 1,  'Philippines'),
('Gabi', 6,  'Antique', 1,  'Philippines'),
('Getulio', 6,  'Antique', 1,  'Philippines'),
('Gibato', 6,  'Antique', 1,  'Philippines'),
('Gibong', 6,  'Antique', 1,  'Philippines'),
('Gines-Patay', 6,  'Antique', 1,  'Philippines'),
('Granada', 6,  'Antique', 1,  'Philippines'),
('Guadalupe', 6,  'Antique', 1,  'Philippines'),
('Guiljungan', 6,  'Antique', 1,  'Philippines'),
('Guinoaliuan', 6,  'Antique', 1,  'Philippines'),
('Guinticgan', 6,  'Antique', 1,  'Philippines'),
('Guintubhan', 6,  'Antique', 1,  'Philippines'),
('Guisijan', 6,  'Antique', 1,  'Philippines'),
('Hacienda Refugio', 6,  'Antique', 1,  'Philippines'),
('Hacienda Santa Rosa', 6,  'Antique', 1,  'Philippines'),
('Haguimit', 6,  'Antique', 1,  'Philippines'),
('Hamtic', 6,  'Antique', 1,  'Philippines'),
('Himaya', 6,  'Antique', 1,  'Philippines'),
('Hipona', 6,  'Antique', 1,  'Philippines'),
('Idio', 6,  'Antique', 1,  'Philippines'),
('Igang', 6,  'Antique', 1,  'Philippines'),
('Igbon', 6,  'Antique', 1,  'Philippines'),
('Igcocolo', 6,  'Antique', 1,  'Philippines'),
('Igmaya-an', 6,  'Antique', 1,  'Philippines'),
('Imbang', 6,  'Antique', 1,  'Philippines'),
('Inayauan', 6,  'Antique', 1,  'Philippines'),
('Intampilan', 6,  'Antique', 1,  'Philippines'),
('Jaena', 6,  'Antique', 1,  'Philippines'),
('Jaguimitan', 6,  'Antique', 1,  'Philippines'),
('Jalaud', 6,  'Antique', 1,  'Philippines'),
('Jamabalod', 6,  'Antique', 1,  'Philippines'),
('Japitan', 6,  'Antique', 1,  'Philippines'),
('Jarigue', 6,  'Antique', 1,  'Philippines'),
('JayubÃ³', 6,  'Antique', 1,  'Philippines'),
('Jibao-an', 6,  'Antique', 1,  'Philippines'),
('Kabilauan', 6,  'Antique', 1,  'Philippines'),
('Kalibo (poblacion)', 6,  'Antique', 1,  'Philippines'),
('Kaliling', 6,  'Antique', 1,  'Philippines'),
('Kumalisquis', 6,  'Antique', 1,  'Philippines'),
('La Granja', 6,  'Antique', 1,  'Philippines'),
('Lacaron', 6,  'Antique', 1,  'Philippines'),
('Lalab', 6,  'Antique', 1,  'Philippines'),
('Lalagsan', 6,  'Antique', 1,  'Philippines'),
('Lañgub', 6,  'Antique', 1,  'Philippines'),
('Lanot', 6,  'Antique', 1,  'Philippines'),
('Lawigan', 6,  'Antique', 1,  'Philippines'),
('Libertad', 6,  'Antique', 1,  'Philippines'),
('Linabuan', 6,  'Antique', 1,  'Philippines'),
('Linabuan Sur', 6,  'Antique', 1,  'Philippines'),
('Linaon', 6,  'Antique', 1,  'Philippines'),
('Locmayan', 6,  'Antique', 1,  'Philippines'),
('Lono', 6,  'Antique', 1,  'Philippines'),
('Lonoy', 6,  'Antique', 1,  'Philippines'),
('Lupo', 6,  'Antique', 1,  'Philippines'),
('Maao', 6,  'Antique', 1,  'Philippines'),
('Maasin', 6,  'Antique', 1,  'Philippines'),
('Mabini', 6,  'Antique', 1,  'Philippines'),
('Magallon Cadre', 6,  'Antique', 1,  'Philippines'),
('Magdalena', 6,  'Antique', 1,  'Philippines'),
('Malabonot', 6,  'Antique', 1,  'Philippines'),
('Malabor', 6,  'Antique', 1,  'Philippines'),
('Malangabang', 6,  'Antique', 1,  'Philippines'),
('Malayo-an', 6,  'Antique', 1,  'Philippines'),
('Malocloc', 6,  'Antique', 1,  'Philippines'),
('Maloco', 6,  'Antique', 1,  'Philippines'),
('Mambagatan', 6,  'Antique', 1,  'Philippines'),
('Manalad', 6,  'Antique', 1,  'Philippines'),
('Mangoso', 6,  'Antique', 1,  'Philippines'),
('Manika', 6,  'Antique', 1,  'Philippines'),
('Manjoy', 6,  'Antique', 1,  'Philippines'),
('Manlucahoc', 6,  'Antique', 1,  'Philippines'),
('Manoc-Manoc', 6,  'Antique', 1,  'Philippines'),
('Mansilingan', 6,  'Antique', 1,  'Philippines'),
('Manup', 6,  'Antique', 1,  'Philippines'),
('Mapili', 6,  'Antique', 1,  'Philippines'),
('Maquiling', 6,  'Antique', 1,  'Philippines'),
('Marawis', 6,  'Antique', 1,  'Philippines'),
('Maribong', 6,  'Antique', 1,  'Philippines'),
('Maricalom', 6,  'Antique', 1,  'Philippines'),
('Masaling', 6,  'Antique', 1,  'Philippines'),
('Masonogan', 6,  'Antique', 1,  'Philippines'),
('Mianay', 6,  'Antique', 1,  'Philippines'),
('Minapasoc', 6,  'Antique', 1,  'Philippines'),
('Minuyan', 6,  'Antique', 1,  'Philippines'),
('Miranda', 6,  'Antique', 1,  'Philippines'),
('Monpon', 6,  'Antique', 1,  'Philippines'),
('Montilla', 6,  'Antique', 1,  'Philippines'),
('Morales', 6,  'Antique', 1,  'Philippines'),
('Morobuan', 6,  'Antique', 1,  'Philippines'),
('Nabulao', 6,  'Antique', 1,  'Philippines'),
('Naili', 6,  'Antique', 1,  'Philippines'),
('Naisud', 6,  'Antique', 1,  'Philippines'),
('Nangka', 6,  'Antique', 1,  'Philippines'),
('Napnapan', 6,  'Antique', 1,  'Philippines'),
('Napoles', 6,  'Antique', 1,  'Philippines'),
('New Pandanon', 6,  'Antique', 1,  'Philippines'),
('Ochanado', 6,  'Antique', 1,  'Philippines'),
('Odiong', 6,  'Antique', 1,  'Philippines'),
('Ogtongon', 6,  'Antique', 1,  'Philippines'),
('Ondoy', 6,  'Antique', 1,  'Philippines'),
('Oracon', 6,  'Antique', 1,  'Philippines'),
('Orong', 6,  'Antique', 1,  'Philippines'),
('Pacol', 6,  'Antique', 1,  'Philippines'),
('Pakiad', 6,  'Antique', 1,  'Philippines'),
('Palampas', 6,  'Antique', 1,  'Philippines'),
('Panayacan', 6,  'Antique', 1,  'Philippines'),
('Paraiso', 6,  'Antique', 1,  'Philippines'),
('Parion', 6,  'Antique', 1,  'Philippines'),
('Pasil', 6,  'Antique', 1,  'Philippines'),
('Patique', 6,  'Antique', 1,  'Philippines'),
('Patnongon', 6,  'Antique', 1,  'Philippines'),
('Patonan', 6,  'Antique', 1,  'Philippines'),
('Patria', 6,  'Antique', 1,  'Philippines'),
('Payao', 6,  'Antique', 1,  'Philippines'),
('Piape I', 6,  'Antique', 1,  'Philippines'),
('Piña', 6,  'Antique', 1,  'Philippines'),
('Platagata', 6,  'Antique', 1,  'Philippines'),
('Polopina', 6,  'Antique', 1,  'Philippines'),
('Ponong', 6,  'Antique', 1,  'Philippines'),
('Prosperidad', 6,  'Antique', 1,  'Philippines'),
('Punao', 6,  'Antique', 1,  'Philippines'),
('Quezon', 6,  'Antique', 1,  'Philippines'),
('Quinagaringan', 6,  'Antique', 1,  'Philippines'),
('Quipot', 6,  'Antique', 1,  'Philippines'),
('Sagang', 6,  'Antique', 1,  'Philippines'),
('Sagasa', 6,  'Antique', 1,  'Philippines'),
('Salamanca', 6,  'Antique', 1,  'Philippines'),
('San Joaquin', 6,  'Antique', 1,  'Philippines'),
('San Remigio', 6,  'Antique', 1,  'Philippines'),
('San Salvador', 6,  'Antique', 1,  'Philippines'),
('Santa Angel', 6,  'Antique', 1,  'Philippines'),
('Santa Teresa', 6,  'Antique', 1,  'Philippines'),
('Saravia', 6,  'Antique', 1,  'Philippines'),
('Sebaste', 6,  'Antique', 1,  'Philippines'),
('Semirara', 6,  'Antique', 1,  'Philippines'),
('Sibaguan', 6,  'Antique', 1,  'Philippines'),
('Sibalom', 6,  'Antique', 1,  'Philippines'),
('Sibucao', 6,  'Antique', 1,  'Philippines'),
('Suay', 6,  'Antique', 1,  'Philippines'),
('Sulangan', 6,  'Antique', 1,  'Philippines'),
('Sumag', 6,  'Antique', 1,  'Philippines'),
('Tabu', 6,  'Antique', 1,  'Philippines'),
('Tabuc Pontevedra', 6,  'Antique', 1,  'Philippines'),
('Talaban', 6,  'Antique', 1,  'Philippines'),
('Taloc', 6,  'Antique', 1,  'Philippines'),
('Talokgañgan', 6,  'Antique', 1,  'Philippines'),
('Talon', 6,  'Antique', 1,  'Philippines'),
('Tambac', 6,  'Antique', 1,  'Philippines'),
('Tambalisa', 6,  'Antique', 1,  'Philippines'),
('Tamlang', 6,  'Antique', 1,  'Philippines'),
('Tapas', 6,  'Antique', 1,  'Philippines'),
('Tarong', 6,  'Antique', 1,  'Philippines'),
('Tibiao', 6,  'Antique', 1,  'Philippines'),
('Tiglauigan', 6,  'Antique', 1,  'Philippines'),
('Tigum', 6,  'Antique', 1,  'Philippines'),
('Tiling', 6,  'Antique', 1,  'Philippines'),
('Timpas', 6,  'Antique', 1,  'Philippines'),
('Tinogboc', 6,  'Antique', 1,  'Philippines'),
('Tinongan', 6,  'Antique', 1,  'Philippines'),
('Tiring', 6,  'Antique', 1,  'Philippines'),
('Tobias Fornier', 6,  'Antique', 1,  'Philippines'),
('Tortosa', 6,  'Antique', 1,  'Philippines'),
('Trapiche', 6,  'Antique', 1,  'Philippines'),
('Tugas', 6,  'Antique', 1,  'Philippines'),
('Tumcon Ilawod', 6,  'Antique', 1,  'Philippines'),
('Tuyum', 6,  'Antique', 1,  'Philippines'),
('Ualog', 6,  'Antique', 1,  'Philippines'),
('Ungca', 6,  'Antique', 1,  'Philippines'),
('Unidos', 6,  'Antique', 1,  'Philippines'),
('Union', 6,  'Antique', 1,  'Philippines'),
('Valderrama', 6,  'Antique', 1,  'Philippines'),
('Viejo Daan Banua', 6,  'Antique', 1,  'Philippines'),
('Vista Alegre', 6,  'Antique', 1,  'Philippines'),
('Vito', 6,  'Antique', 1,  'Philippines'),
('Yapak', 6,  'Antique', 1,  'Philippines'),
('Yubo', 6,  'Antique', 1,  'Philippines'),
('Calanasan', 7,  'Apayao', 1,  'Philippines'),
('Conner', 7,  'Apayao', 1,  'Philippines'),
('Flora', 7,  'Apayao', 1,  'Philippines'),
('Kabugao', 7,  'Apayao', 1,  'Philippines'),
('Pudtol', 7,  'Apayao', 1,  'Philippines'),
('Santa Marcela', 7,  'Apayao', 1,  'Philippines'),
('Baler', 8,  'Aurora', 1,  'Philippines'),
('Casiguran', 8,  'Aurora', 1,  'Philippines'),
('Dilasag', 8,  'Aurora', 1,  'Philippines'),
('Dinalungan', 8,  'Aurora', 1,  'Philippines'),
('Dingalan', 8,  'Aurora', 1,  'Philippines'),
('Dipaculao', 8,  'Aurora', 1,  'Philippines'),
('Maria Aurora', 8,  'Aurora', 1,  'Philippines'),
('Andalan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Awang', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Bacayawan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Badak', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Bagan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Baka', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Bakung', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Balimbing', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Bangkal', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Bankaw', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Barurao', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Bato Bato', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Baunu-Timbangan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Bawison', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Bayanga', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Begang', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Binuang', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Blinsung', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Bongued', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Bualan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Buan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Buansa', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Budta', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Bugasan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Buliok', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Bulit', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Bumbaran', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('City of Isabela', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Colonia', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Cotabato', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Dado', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Dadus', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Dalican', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Dalumangcob', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Damabalas', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Damatulan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Digal', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Dinaig', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Dinganen', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Ebcor Town', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Gang', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Guiong', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Idtig', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Kabasalan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Kagay', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Kajatian', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Kalang', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Kalbugan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Kambing', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Kanlagay', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Kansipati', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Karungdong', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Katico', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Katidtuan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Katuli', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Kauran', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Kitango', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Kitapak', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Kolape', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Kulase', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Kulay-Kulay', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Kulempang', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Kungtad', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Labuñgan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Laminusa', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Lamitan City', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Langpas', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Latung', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Layog', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Ligayan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Limbo', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Litayan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Lookan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Lu-uk', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Lumbac', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Luuk Datan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Maganoy', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Mahala', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Makir', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Maluso', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Manubul', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Manuk Mangkaw', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Marawi City', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Marsada', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Mataya', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Mauboh', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Mileb', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('New Batu Batu', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Nuyo', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Pagatin', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Paitan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Panabuan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Panadtaban', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Pandakan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Pandan Niog', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Pang', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Parangan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Parian Dakula', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Pawak', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Payuhan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Pidsandawan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Pinaring', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Polloc', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Punay', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Ramain', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Rimpeso', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Sambuluan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Sanga-Sanga', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Santa Clara', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Sapa', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Sapadun', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Satan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Semut', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Simbahan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Simuay', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Sionogan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Tabiauan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Tablas', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Taganak', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Tairan Camp', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Talipaw', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Tapayan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Tapikan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Taungoh', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Taviran', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Tongouson', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Tumbagaan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Tunggol', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Tungol', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Ungus-Ungus', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Uyaan', 9,  'Autonomous Region in Muslim Mindanao', 1,  'Philippines'),
('Akbar', 10,  'Basilan', 1,  'Philippines'),
('Al-Barka', 10,  'Basilan', 1,  'Philippines'),
('Hadji Mohammad Ajul', 10,  'Basilan', 1,  'Philippines'),
('Hadji Muhtamad', 10,  'Basilan', 1,  'Philippines'),
('Isabela', 10,  'Basilan', 1,  'Philippines'),
('Lamitan', 10,  'Basilan', 1,  'Philippines'),
('Lantawan', 10,  'Basilan', 1,  'Philippines'),
('Sumisip', 10,  'Basilan', 1,  'Philippines'),
('Tabuan-Lasa', 10,  'Basilan', 1,  'Philippines'),
('Tipo-Tipo', 10,  'Basilan', 1,  'Philippines'),
('Tuburan', 10,  'Basilan', 1,  'Philippines'),
('Ungkaya Pukan', 10,  'Basilan', 1,  'Philippines'),
('Abis', 11,  'Bataan', 1,  'Philippines'),
('Abucayan', 11,  'Bataan', 1,  'Philippines'),
('Adlaon', 11,  'Bataan', 1,  'Philippines'),
('Agsungot', 11,  'Bataan', 1,  'Philippines'),
('Aguining', 11,  'Bataan', 1,  'Philippines'),
('Alangilan', 11,  'Bataan', 1,  'Philippines'),
('Alangilanan', 11,  'Bataan', 1,  'Philippines'),
('Alburquerque', 11,  'Bataan', 1,  'Philippines'),
('Alpaco', 11,  'Bataan', 1,  'Philippines'),
('Amdos', 11,  'Bataan', 1,  'Philippines'),
('Amio', 11,  'Bataan', 1,  'Philippines'),
('Anonang', 11,  'Bataan', 1,  'Philippines'),
('Anopog', 11,  'Bataan', 1,  'Philippines'),
('Antequera', 11,  'Bataan', 1,  'Philippines'),
('Apas', 11,  'Bataan', 1,  'Philippines'),
('Apoya', 11,  'Bataan', 1,  'Philippines'),
('Atop-atop', 11,  'Bataan', 1,  'Philippines'),
('Azagra', 11,  'Bataan', 1,  'Philippines'),
('Bachauan', 11,  'Bataan', 1,  'Philippines'),
('Baclayon', 11,  'Bataan', 1,  'Philippines'),
('Bagay', 11,  'Bataan', 1,  'Philippines'),
('Bagtic', 11,  'Bataan', 1,  'Philippines'),
('Bairan', 11,  'Bataan', 1,  'Philippines'),
('Bal-os', 11,  'Bataan', 1,  'Philippines'),
('Balayong', 11,  'Bataan', 1,  'Philippines'),
('Balilihan', 11,  'Bataan', 1,  'Philippines'),
('Banhigan', 11,  'Bataan', 1,  'Philippines'),
('Banilad', 11,  'Bataan', 1,  'Philippines'),
('Basak', 11,  'Bataan', 1,  'Philippines'),
('Basdiot', 11,  'Bataan', 1,  'Philippines'),
('Bateria', 11,  'Bataan', 1,  'Philippines'),
('Baud', 11,  'Bataan', 1,  'Philippines'),
('Baugo', 11,  'Bataan', 1,  'Philippines'),
('Becerril', 11,  'Bataan', 1,  'Philippines'),
('Biabas', 11,  'Bataan', 1,  'Philippines'),
('Biasong', 11,  'Bataan', 1,  'Philippines'),
('Bien Unido', 11,  'Bataan', 1,  'Philippines'),
('Biking', 11,  'Bataan', 1,  'Philippines'),
('Bilar', 11,  'Bataan', 1,  'Philippines'),
('Binlod', 11,  'Bataan', 1,  'Philippines'),
('Biton', 11,  'Bataan', 1,  'Philippines'),
('Bitoon', 11,  'Bataan', 1,  'Philippines'),
('Bohol', 11,  'Bataan', 1,  'Philippines'),
('Bolisong', 11,  'Bataan', 1,  'Philippines'),
('Bonawon', 11,  'Bataan', 1,  'Philippines'),
('Bonbon', 11,  'Bataan', 1,  'Philippines'),
('Bood', 11,  'Bataan', 1,  'Philippines'),
('Botigues', 11,  'Bataan', 1,  'Philippines'),
('Buagsong', 11,  'Bataan', 1,  'Philippines'),
('Buanoy', 11,  'Bataan', 1,  'Philippines'),
('Bugas', 11,  'Bataan', 1,  'Philippines'),
('Bugsoc', 11,  'Bataan', 1,  'Philippines'),
('Bulasa', 11,  'Bataan', 1,  'Philippines'),
('Bulod', 11,  'Bataan', 1,  'Philippines'),
('Cabalawan', 11,  'Bataan', 1,  'Philippines'),
('Cabangahan', 11,  'Bataan', 1,  'Philippines'),
('Cabul-an', 11,  'Bataan', 1,  'Philippines'),
('Calero', 11,  'Bataan', 1,  'Philippines'),
('Calidñgan', 11,  'Bataan', 1,  'Philippines'),
('Calituban', 11,  'Bataan', 1,  'Philippines'),
('Calumboyan', 11,  'Bataan', 1,  'Philippines'),
('Camambugan', 11,  'Bataan', 1,  'Philippines'),
('Cambanay', 11,  'Bataan', 1,  'Philippines'),
('Campoyo', 11,  'Bataan', 1,  'Philippines'),
('Campusong', 11,  'Bataan', 1,  'Philippines'),
('Can-asujan', 11,  'Bataan', 1,  'Philippines'),
('Canauay', 11,  'Bataan', 1,  'Philippines'),
('Candabong', 11,  'Bataan', 1,  'Philippines'),
('Candijay', 11,  'Bataan', 1,  'Philippines'),
('Canhaway', 11,  'Bataan', 1,  'Philippines'),
('Canjulao', 11,  'Bataan', 1,  'Philippines'),
('Canmaya Diot', 11,  'Bataan', 1,  'Philippines'),
('Cansuje', 11,  'Bataan', 1,  'Philippines'),
('Cantao-an', 11,  'Bataan', 1,  'Philippines'),
('Casala-an', 11,  'Bataan', 1,  'Philippines'),
('Casay', 11,  'Bataan', 1,  'Philippines'),
('Caticugan', 11,  'Bataan', 1,  'Philippines'),
('Catigbian', 11,  'Bataan', 1,  'Philippines'),
('Catmondaan', 11,  'Bataan', 1,  'Philippines'),
('Catungawan Sur', 11,  'Bataan', 1,  'Philippines'),
('Cayang', 11,  'Bataan', 1,  'Philippines'),
('Cogan', 11,  'Bataan', 1,  'Philippines'),
('Cogon Cruz', 11,  'Bataan', 1,  'Philippines'),
('Cogtong', 11,  'Bataan', 1,  'Philippines'),
('Corella', 11,  'Bataan', 1,  'Philippines'),
('Dagohoy', 11,  'Bataan', 1,  'Philippines'),
('Damolog', 11,  'Bataan', 1,  'Philippines'),
('Datagon', 11,  'Bataan', 1,  'Philippines'),
('Dauis', 11,  'Bataan', 1,  'Philippines'),
('Dimiao', 11,  'Bataan', 1,  'Philippines'),
('Doljo', 11,  'Bataan', 1,  'Philippines'),
('Doong', 11,  'Bataan', 1,  'Philippines'),
('Duero', 11,  'Bataan', 1,  'Philippines'),
('Dumanjog', 11,  'Bataan', 1,  'Philippines'),
('El Pardo', 11,  'Bataan', 1,  'Philippines'),
('Esperanza', 11,  'Bataan', 1,  'Philippines'),
('Estaca', 11,  'Bataan', 1,  'Philippines'),
('Garcia Hernandez', 11,  'Bataan', 1,  'Philippines'),
('Giawang', 11,  'Bataan', 1,  'Philippines'),
('Guba', 11,  'Bataan', 1,  'Philippines'),
('Guibodangan', 11,  'Bataan', 1,  'Philippines'),
('Guindarohan', 11,  'Bataan', 1,  'Philippines'),
('Guindulman', 11,  'Bataan', 1,  'Philippines'),
('Guiwanon', 11,  'Bataan', 1,  'Philippines'),
('Hagdan', 11,  'Bataan', 1,  'Philippines'),
('Hagnaya', 11,  'Bataan', 1,  'Philippines'),
('Hibaiyo', 11,  'Bataan', 1,  'Philippines'),
('Hilantagaan', 11,  'Bataan', 1,  'Philippines'),
('Hilotongan', 11,  'Bataan', 1,  'Philippines'),
('Himensulan', 11,  'Bataan', 1,  'Philippines'),
('Hinlayagan Ilaud', 11,  'Bataan', 1,  'Philippines'),
('Ilihan', 11,  'Bataan', 1,  'Philippines'),
('Inabanga', 11,  'Bataan', 1,  'Philippines'),
('Inayagan', 11,  'Bataan', 1,  'Philippines'),
('Jaclupan', 11,  'Bataan', 1,  'Philippines'),
('Jagna', 11,  'Bataan', 1,  'Philippines'),
('Jampang', 11,  'Bataan', 1,  'Philippines'),
('Jandayan Norte', 11,  'Bataan', 1,  'Philippines'),
('Jantianon', 11,  'Bataan', 1,  'Philippines'),
('Jetafe', 11,  'Bataan', 1,  'Philippines'),
('Jugno', 11,  'Bataan', 1,  'Philippines'),
('Kabac', 11,  'Bataan', 1,  'Philippines'),
('Kabungahan', 11,  'Bataan', 1,  'Philippines'),
('Kandabong', 11,  'Bataan', 1,  'Philippines'),
('Kaongkod', 11,  'Bataan', 1,  'Philippines'),
('Kauit', 11,  'Bataan', 1,  'Philippines'),
('Kotkot', 11,  'Bataan', 1,  'Philippines'),
('Kuanos', 11,  'Bataan', 1,  'Philippines'),
('La Hacienda', 11,  'Bataan', 1,  'Philippines'),
('Lanao', 11,  'Bataan', 1,  'Philippines'),
('Lanas', 11,  'Bataan', 1,  'Philippines'),
('Langob', 11,  'Bataan', 1,  'Philippines'),
('Langtad', 11,  'Bataan', 1,  'Philippines'),
('Lapaz', 11,  'Bataan', 1,  'Philippines'),
('Lepanto', 11,  'Bataan', 1,  'Philippines'),
('Lila', 11,  'Bataan', 1,  'Philippines'),
('Lipayran', 11,  'Bataan', 1,  'Philippines'),
('Loay', 11,  'Bataan', 1,  'Philippines'),
('Loboc', 11,  'Bataan', 1,  'Philippines'),
('Logon', 11,  'Bataan', 1,  'Philippines'),
('Lombog', 11,  'Bataan', 1,  'Philippines'),
('Loon', 11,  'Bataan', 1,  'Philippines'),
('Lugo', 11,  'Bataan', 1,  'Philippines'),
('Lunas', 11,  'Bataan', 1,  'Philippines'),
('Lut-od', 11,  'Bataan', 1,  'Philippines'),
('Maayong Tubig', 11,  'Bataan', 1,  'Philippines'),
('Mabinay', 11,  'Bataan', 1,  'Philippines'),
('Macaas', 11,  'Bataan', 1,  'Philippines'),
('Magay', 11,  'Bataan', 1,  'Philippines'),
('Malabugas', 11,  'Bataan', 1,  'Philippines'),
('Malaiba', 11,  'Bataan', 1,  'Philippines'),
('Malhiao', 11,  'Bataan', 1,  'Philippines'),
('Malingin', 11,  'Bataan', 1,  'Philippines'),
('Maloh', 11,  'Bataan', 1,  'Philippines'),
('Malusay', 11,  'Bataan', 1,  'Philippines'),
('Malway', 11,  'Bataan', 1,  'Philippines'),
('Manalongon', 11,  'Bataan', 1,  'Philippines'),
('Mancilang', 11,  'Bataan', 1,  'Philippines'),
('Mandaue City', 11,  'Bataan', 1,  'Philippines'),
('Maninihon', 11,  'Bataan', 1,  'Philippines'),
('Maño', 11,  'Bataan', 1,  'Philippines'),
('Mantalongon', 11,  'Bataan', 1,  'Philippines'),
('Mantiquil', 11,  'Bataan', 1,  'Philippines'),
('Maravilla', 11,  'Bataan', 1,  'Philippines'),
('Maribojoc', 11,  'Bataan', 1,  'Philippines'),
('Maricaban', 11,  'Bataan', 1,  'Philippines'),
('Masaba', 11,  'Bataan', 1,  'Philippines'),
('Maya', 11,  'Bataan', 1,  'Philippines'),
('Mayabon', 11,  'Bataan', 1,  'Philippines'),
('Mayana', 11,  'Bataan', 1,  'Philippines'),
('Mayapusi', 11,  'Bataan', 1,  'Philippines'),
('McKinley', 11,  'Bataan', 1,  'Philippines'),
('Minolos', 11,  'Bataan', 1,  'Philippines'),
('Montaneza', 11,  'Bataan', 1,  'Philippines'),
('Nagbalaye', 11,  'Bataan', 1,  'Philippines'),
('Nahawan', 11,  'Bataan', 1,  'Philippines'),
('Nailong', 11,  'Bataan', 1,  'Philippines'),
('Nalundan', 11,  'Bataan', 1,  'Philippines'),
('Novallas', 11,  'Bataan', 1,  'Philippines'),
('Nueva Fuerza', 11,  'Bataan', 1,  'Philippines'),
('Nueva Vida Sur', 11,  'Bataan', 1,  'Philippines'),
('Nugas', 11,  'Bataan', 1,  'Philippines'),
('Obong', 11,  'Bataan', 1,  'Philippines'),
('Ocaña', 11,  'Bataan', 1,  'Philippines'),
('Ocoy', 11,  'Bataan', 1,  'Philippines'),
('Okiot', 11,  'Bataan', 1,  'Philippines'),
('Owak', 11,  'Bataan', 1,  'Philippines'),
('Padre Zamora', 11,  'Bataan', 1,  'Philippines'),
('Pajo', 11,  'Bataan', 1,  'Philippines'),
('Panalipan', 11,  'Bataan', 1,  'Philippines'),
('Panaytayon', 11,  'Bataan', 1,  'Philippines'),
('Pangdan', 11,  'Bataan', 1,  'Philippines'),
('Panglao', 11,  'Bataan', 1,  'Philippines'),
('Panognawan', 11,  'Bataan', 1,  'Philippines'),
('Patao', 11,  'Bataan', 1,  'Philippines'),
('Payabon', 11,  'Bataan', 1,  'Philippines'),
('Paypay', 11,  'Bataan', 1,  'Philippines'),
('Perrelos', 11,  'Bataan', 1,  'Philippines'),
('Pinamungahan', 11,  'Bataan', 1,  'Philippines'),
('Pinayagan Norte', 11,  'Bataan', 1,  'Philippines'),
('Pinokawan', 11,  'Bataan', 1,  'Philippines'),
('Putat', 11,  'Bataan', 1,  'Philippines'),
('Saavedra', 11,  'Bataan', 1,  'Philippines'),
('Sagbayan', 11,  'Bataan', 1,  'Philippines'),
('Sandayong Sur', 11,  'Bataan', 1,  'Philippines'),
('Sandolot', 11,  'Bataan', 1,  'Philippines'),
('Sangat', 11,  'Bataan', 1,  'Philippines'),
('Santa Filomena', 11,  'Bataan', 1,  'Philippines'),
('Santa Nino', 11,  'Bataan', 1,  'Philippines'),
('Santander Poblacion', 11,  'Bataan', 1,  'Philippines'),
('Sevilla', 11,  'Bataan', 1,  'Philippines'),
('Sierra Bullones', 11,  'Bataan', 1,  'Philippines'),
('Sikatuna', 11,  'Bataan', 1,  'Philippines'),
('Silab', 11,  'Bataan', 1,  'Philippines'),
('Sillon', 11,  'Bataan', 1,  'Philippines'),
('Simala', 11,  'Bataan', 1,  'Philippines'),
('Songculan', 11,  'Bataan', 1,  'Philippines'),
('Tabalong', 11,  'Bataan', 1,  'Philippines'),
('Tabonok', 11,  'Bataan', 1,  'Philippines'),
('Tabuan', 11,  'Bataan', 1,  'Philippines'),
('Tabunok', 11,  'Bataan', 1,  'Philippines'),
('Tagbilaran City', 11,  'Bataan', 1,  'Philippines'),
('Tagum Norte', 11,  'Bataan', 1,  'Philippines'),
('Tajao', 11,  'Bataan', 1,  'Philippines'),
('Talangnan', 11,  'Bataan', 1,  'Philippines'),
('Talibon', 11,  'Bataan', 1,  'Philippines'),
('Tambalan', 11,  'Bataan', 1,  'Philippines'),
('Tambongon', 11,  'Bataan', 1,  'Philippines'),
('Tamiso', 11,  'Bataan', 1,  'Philippines'),
('Tampocon', 11,  'Bataan', 1,  'Philippines'),
('Tandayag', 11,  'Bataan', 1,  'Philippines'),
('Tangke', 11,  'Bataan', 1,  'Philippines'),
('Tangnan', 11,  'Bataan', 1,  'Philippines'),
('Tapilon', 11,  'Bataan', 1,  'Philippines'),
('Tapon', 11,  'Bataan', 1,  'Philippines'),
('Tawala', 11,  'Bataan', 1,  'Philippines'),
('Taytayan', 11,  'Bataan', 1,  'Philippines'),
('Tayud', 11,  'Bataan', 1,  'Philippines'),
('Tibigan', 11,  'Bataan', 1,  'Philippines'),
('Tiguib', 11,  'Bataan', 1,  'Philippines'),
('Tinaan', 11,  'Bataan', 1,  'Philippines'),
('Tinaogan', 11,  'Bataan', 1,  'Philippines'),
('Tindog', 11,  'Bataan', 1,  'Philippines'),
('Tinubuan', 11,  'Bataan', 1,  'Philippines'),
('Tipolo', 11,  'Bataan', 1,  'Philippines'),
('Tominhao', 11,  'Bataan', 1,  'Philippines'),
('Totolan', 11,  'Bataan', 1,  'Philippines'),
('Trinidad', 11,  'Bataan', 1,  'Philippines'),
('Tubigagmanoc', 11,  'Bataan', 1,  'Philippines'),
('Tubod-dugoan', 11,  'Bataan', 1,  'Philippines'),
('Tutay', 11,  'Bataan', 1,  'Philippines'),
('Ubay', 11,  'Bataan', 1,  'Philippines'),
('Uling', 11,  'Bataan', 1,  'Philippines'),
('Valle Hermoso', 11,  'Bataan', 1,  'Philippines'),
('Alugan', 12,  'Batanes', 1,  'Philippines'),
('Anito', 12,  'Batanes', 1,  'Philippines'),
('Balagui', 12,  'Batanes', 1,  'Philippines'),
('Balinsacayao', 12,  'Batanes', 1,  'Philippines'),
('Balocawehay', 12,  'Batanes', 1,  'Philippines'),
('Bantiqui', 12,  'Batanes', 1,  'Philippines'),
('Baras', 12,  'Batanes', 1,  'Philippines'),
('Bilwang', 12,  'Batanes', 1,  'Philippines'),
('Bitanjuan', 12,  'Batanes', 1,  'Philippines'),
('Bugho', 12,  'Batanes', 1,  'Philippines'),
('Bugko', 12,  'Batanes', 1,  'Philippines'),
('Bunga', 12,  'Batanes', 1,  'Philippines'),
('Butazon', 12,  'Batanes', 1,  'Philippines'),
('Cabacuñgan', 12,  'Batanes', 1,  'Philippines'),
('Cabay', 12,  'Batanes', 1,  'Philippines'),
('Cabodiongan', 12,  'Batanes', 1,  'Philippines'),
('Cagamotan', 12,  'Batanes', 1,  'Philippines'),
('Canhandugan', 12,  'Batanes', 1,  'Philippines'),
('Caraycaray', 12,  'Batanes', 1,  'Philippines'),
('Consuegra', 12,  'Batanes', 1,  'Philippines'),
('Culasian', 12,  'Batanes', 1,  'Philippines'),
('Doos', 12,  'Batanes', 1,  'Philippines'),
('Erenas', 12,  'Batanes', 1,  'Philippines'),
('Gabas', 12,  'Batanes', 1,  'Philippines'),
('Ginabuyan', 12,  'Batanes', 1,  'Philippines'),
('Guindapunan', 12,  'Batanes', 1,  'Philippines'),
('Guirang', 12,  'Batanes', 1,  'Philippines'),
('Hingatungan', 12,  'Batanes', 1,  'Philippines'),
('Hipadpad', 12,  'Batanes', 1,  'Philippines'),
('Hipasngo', 12,  'Batanes', 1,  'Philippines'),
('Ibarra', 12,  'Batanes', 1,  'Philippines'),
('Ichon', 12,  'Batanes', 1,  'Philippines'),
('Jubasan', 12,  'Batanes', 1,  'Philippines'),
('Kabuynan', 12,  'Batanes', 1,  'Philippines'),
('Kampokpok', 12,  'Batanes', 1,  'Philippines'),
('Kananya', 12,  'Batanes', 1,  'Philippines'),
('Kilim', 12,  'Batanes', 1,  'Philippines'),
('Lalauigan', 12,  'Batanes', 1,  'Philippines'),
('Lamak', 12,  'Batanes', 1,  'Philippines'),
('Liberty', 12,  'Batanes', 1,  'Philippines'),
('Lim-oo', 12,  'Batanes', 1,  'Philippines'),
('Limon', 12,  'Batanes', 1,  'Philippines'),
('Makiwalo', 12,  'Batanes', 1,  'Philippines'),
('Malaga', 12,  'Batanes', 1,  'Philippines'),
('Malajog', 12,  'Batanes', 1,  'Philippines'),
('Malilinao', 12,  'Batanes', 1,  'Philippines'),
('Mantang', 12,  'Batanes', 1,  'Philippines'),
('Masarayao', 12,  'Batanes', 1,  'Philippines'),
('Matlang', 12,  'Batanes', 1,  'Philippines'),
('Maypangdan', 12,  'Batanes', 1,  'Philippines'),
('Naghalin', 12,  'Batanes', 1,  'Philippines'),
('Napuro', 12,  'Batanes', 1,  'Philippines'),
('Nena', 12,  'Batanes', 1,  'Philippines'),
('Nenita', 12,  'Batanes', 1,  'Philippines'),
('Palanit', 12,  'Batanes', 1,  'Philippines'),
('Palaroo', 12,  'Batanes', 1,  'Philippines'),
('Palhi', 12,  'Batanes', 1,  'Philippines'),
('Panalanoy', 12,  'Batanes', 1,  'Philippines'),
('Patong', 12,  'Batanes', 1,  'Philippines'),
('Pawing', 12,  'Batanes', 1,  'Philippines'),
('Pinamopoan', 12,  'Batanes', 1,  'Philippines'),
('Plaridel', 12,  'Batanes', 1,  'Philippines'),
('Polahongon', 12,  'Batanes', 1,  'Philippines'),
('Polañge', 12,  'Batanes', 1,  'Philippines'),
('Puerto Bello', 12,  'Batanes', 1,  'Philippines'),
('Quinapundan', 12,  'Batanes', 1,  'Philippines'),
('San Eduardo', 12,  'Batanes', 1,  'Philippines'),
('San Policarpio', 12,  'Batanes', 1,  'Philippines'),
('San Sebastian', 12,  'Batanes', 1,  'Philippines'),
('Santa Paz', 12,  'Batanes', 1,  'Philippines'),
('Siguinon', 12,  'Batanes', 1,  'Philippines'),
('Silanga', 12,  'Batanes', 1,  'Philippines'),
('Tabonoc', 12,  'Batanes', 1,  'Philippines'),
('Tagbubungang Diot', 12,  'Batanes', 1,  'Philippines'),
('Tinambacan', 12,  'Batanes', 1,  'Philippines'),
('Tucdao', 12,  'Batanes', 1,  'Philippines'),
('Tugbong', 12,  'Batanes', 1,  'Philippines'),
('Tutubigan', 12,  'Batanes', 1,  'Philippines'),
('Umaganhan', 12,  'Batanes', 1,  'Philippines'),
('Valencia', 12,  'Batanes', 1,  'Philippines'),
('Victoria', 12,  'Batanes', 1,  'Philippines'),
('Viriato', 12,  'Batanes', 1,  'Philippines'),
('Wright', 12,  'Batanes', 1,  'Philippines'),
('Agoncillo', 13,  'Batangas', 1,  'Philippines'),
('Alitagtag', 13,  'Batangas', 1,  'Philippines'),
('Balayan', 13,  'Batangas', 1,  'Philippines'),
('Batangas', 13,  'Batangas', 1,  'Philippines'),
('Bauan', 13,  'Batangas', 1,  'Philippines'),
('Calaca', 13,  'Batangas', 1,  'Philippines'),
('Calatagan', 13,  'Batangas', 1,  'Philippines'),
('Cuenca', 13,  'Batangas', 1,  'Philippines'),
('Ibaan', 13,  'Batangas', 1,  'Philippines'),
('Laurel', 13,  'Batangas', 1,  'Philippines'),
('Lemery', 13,  'Batangas', 1,  'Philippines'),
('Lian', 13,  'Batangas', 1,  'Philippines'),
('Lipa', 13,  'Batangas', 1,  'Philippines'),
('Lobo', 13,  'Batangas', 1,  'Philippines'),
('Malvar', 13,  'Batangas', 1,  'Philippines'),
('Mataasnakahoy', 13,  'Batangas', 1,  'Philippines'),
('Nasugbu', 13,  'Batangas', 1,  'Philippines'),
('Padre Garcia', 13,  'Batangas', 1,  'Philippines'),
('Rosario', 13,  'Batangas', 1,  'Philippines'),
('San Jose', 13,  'Batangas', 1,  'Philippines'),
('Taal', 13,  'Batangas', 1,  'Philippines'),
('Tanauan', 13,  'Batangas', 1,  'Philippines'),
('Taysan', 13,  'Batangas', 1,  'Philippines'),
('Tingloy', 13,  'Batangas', 1,  'Philippines'),
('Tuy', 13,  'Batangas', 1,  'Philippines'),
('Adtugan', 14,  'Benguet', 1,  'Philippines'),
('Aglayan', 14,  'Benguet', 1,  'Philippines'),
('Agusan', 14,  'Benguet', 1,  'Philippines'),
('Alae', 14,  'Benguet', 1,  'Philippines'),
('Alanib', 14,  'Benguet', 1,  'Philippines'),
('Anakan', 14,  'Benguet', 1,  'Philippines'),
('Ani-e', 14,  'Benguet', 1,  'Philippines'),
('Aplaya', 14,  'Benguet', 1,  'Philippines'),
('Aumbay', 14,  'Benguet', 1,  'Philippines'),
('Bagakay', 14,  'Benguet', 1,  'Philippines'),
('Baikingon', 14,  'Benguet', 1,  'Philippines'),
('Balila', 14,  'Benguet', 1,  'Philippines'),
('Balili', 14,  'Benguet', 1,  'Philippines'),
('Bangahan', 14,  'Benguet', 1,  'Philippines'),
('Bantuanon', 14,  'Benguet', 1,  'Philippines'),
('Binitinan', 14,  'Benguet', 1,  'Philippines'),
('Bolo Bolo', 14,  'Benguet', 1,  'Philippines'),
('Boroon', 14,  'Benguet', 1,  'Philippines'),
('Bugcaon', 14,  'Benguet', 1,  'Philippines'),
('Bugo', 14,  'Benguet', 1,  'Philippines'),
('Busdi', 14,  'Benguet', 1,  'Philippines'),
('Cabanglasan', 14,  'Benguet', 1,  'Philippines'),
('Calabugao', 14,  'Benguet', 1,  'Philippines'),
('Canayan', 14,  'Benguet', 1,  'Philippines'),
('Candiis', 14,  'Benguet', 1,  'Philippines'),
('Caromatan', 14,  'Benguet', 1,  'Philippines'),
('Casisang', 14,  'Benguet', 1,  'Philippines'),
('Cosina', 14,  'Benguet', 1,  'Philippines'),
('Dagumba-an', 14,  'Benguet', 1,  'Philippines'),
('Dalipuga', 14,  'Benguet', 1,  'Philippines'),
('Dalirig', 14,  'Benguet', 1,  'Philippines'),
('Dalorong', 14,  'Benguet', 1,  'Philippines'),
('Dalwangan', 14,  'Benguet', 1,  'Philippines'),
('Damilag', 14,  'Benguet', 1,  'Philippines'),
('Damulog', 14,  'Benguet', 1,  'Philippines'),
('Dancagan', 14,  'Benguet', 1,  'Philippines'),
('Dimaluna', 14,  'Benguet', 1,  'Philippines'),
('Dimayon', 14,  'Benguet', 1,  'Philippines'),
('Dologon', 14,  'Benguet', 1,  'Philippines'),
('Don Carlos', 14,  'Benguet', 1,  'Philippines'),
('Dorsalanam', 14,  'Benguet', 1,  'Philippines'),
('Dumalaguing', 14,  'Benguet', 1,  'Philippines'),
('Gimampang', 14,  'Benguet', 1,  'Philippines'),
('Guinisiliban', 14,  'Benguet', 1,  'Philippines'),
('Halapitan', 14,  'Benguet', 1,  'Philippines'),
('Hinapalanan', 14,  'Benguet', 1,  'Philippines'),
('Igpit', 14,  'Benguet', 1,  'Philippines'),
('Imbatug', 14,  'Benguet', 1,  'Philippines'),
('Impalutao', 14,  'Benguet', 1,  'Philippines'),
('Indulang', 14,  'Benguet', 1,  'Philippines'),
('Inobulan', 14,  'Benguet', 1,  'Philippines'),
('Kabalantian', 14,  'Benguet', 1,  'Philippines'),
('Kabulohan', 14,  'Benguet', 1,  'Philippines'),
('Kadingilan', 14,  'Benguet', 1,  'Philippines'),
('Kalanganan', 14,  'Benguet', 1,  'Philippines'),
('Kalilangan', 14,  'Benguet', 1,  'Philippines'),
('Kalugmanan', 14,  'Benguet', 1,  'Philippines'),
('Kibangay', 14,  'Benguet', 1,  'Philippines'),
('Kibawe', 14,  'Benguet', 1,  'Philippines'),
('Kibonsod', 14,  'Benguet', 1,  'Philippines'),
('Kibureau', 14,  'Benguet', 1,  'Philippines'),
('Kimanuit', 14,  'Benguet', 1,  'Philippines'),
('Kimaya', 14,  'Benguet', 1,  'Philippines'),
('Kisolon', 14,  'Benguet', 1,  'Philippines'),
('Kitaotao', 14,  'Benguet', 1,  'Philippines'),
('Kitobo', 14,  'Benguet', 1,  'Philippines'),
('La Fortuna', 14,  'Benguet', 1,  'Philippines'),
('La Roxas', 14,  'Benguet', 1,  'Philippines'),
('Lagindingan', 14,  'Benguet', 1,  'Philippines'),
('Laguitas', 14,  'Benguet', 1,  'Philippines'),
('Langcangan', 14,  'Benguet', 1,  'Philippines'),
('Lanipao', 14,  'Benguet', 1,  'Philippines'),
('Lantapan', 14,  'Benguet', 1,  'Philippines'),
('Lapase', 14,  'Benguet', 1,  'Philippines'),
('Lapining', 14,  'Benguet', 1,  'Philippines'),
('Libona', 14,  'Benguet', 1,  'Philippines'),
('Liboran', 14,  'Benguet', 1,  'Philippines'),
('Limbaan', 14,  'Benguet', 1,  'Philippines'),
('Linabo', 14,  'Benguet', 1,  'Philippines'),
('Lingating', 14,  'Benguet', 1,  'Philippines'),
('Lingion', 14,  'Benguet', 1,  'Philippines'),
('Little Baguio', 14,  'Benguet', 1,  'Philippines'),
('Looc', 14,  'Benguet', 1,  'Philippines'),
('Lumbayao', 14,  'Benguet', 1,  'Philippines'),
('Lumbia', 14,  'Benguet', 1,  'Philippines'),
('Lunao', 14,  'Benguet', 1,  'Philippines'),
('Lurugan', 14,  'Benguet', 1,  'Philippines'),
('Maanas', 14,  'Benguet', 1,  'Philippines'),
('Maglamin', 14,  'Benguet', 1,  'Philippines'),
('Mailag', 14,  'Benguet', 1,  'Philippines'),
('Malaybalay', 14,  'Benguet', 1,  'Philippines'),
('Malinaw', 14,  'Benguet', 1,  'Philippines'),
('Maluko', 14,  'Benguet', 1,  'Philippines'),
('Mambatangan', 14,  'Benguet', 1,  'Philippines'),
('Mambayaan', 14,  'Benguet', 1,  'Philippines'),
('Mamungan', 14,  'Benguet', 1,  'Philippines'),
('Managok', 14,  'Benguet', 1,  'Philippines'),
('Mananum', 14,  'Benguet', 1,  'Philippines'),
('Mandangoa', 14,  'Benguet', 1,  'Philippines'),
('Manolo Fortich', 14,  'Benguet', 1,  'Philippines'),
('Mantampay', 14,  'Benguet', 1,  'Philippines'),
('Maputi', 14,  'Benguet', 1,  'Philippines'),
('Maramag', 14,  'Benguet', 1,  'Philippines'),
('Maranding', 14,  'Benguet', 1,  'Philippines'),
('Maria Cristina', 14,  'Benguet', 1,  'Philippines'),
('Mariano', 14,  'Benguet', 1,  'Philippines'),
('Mat-i', 14,  'Benguet', 1,  'Philippines'),
('Matangad', 14,  'Benguet', 1,  'Philippines'),
('Miaray', 14,  'Benguet', 1,  'Philippines'),
('Minlagas', 14,  'Benguet', 1,  'Philippines'),
('Molugan', 14,  'Benguet', 1,  'Philippines'),
('Moog', 14,  'Benguet', 1,  'Philippines'),
('Nañgka', 14,  'Benguet', 1,  'Philippines'),
('Napalitan', 14,  'Benguet', 1,  'Philippines'),
('Natalungan', 14,  'Benguet', 1,  'Philippines'),
('NIA Valencia', 14,  'Benguet', 1,  'Philippines'),
('Pan-an', 14,  'Benguet', 1,  'Philippines'),
('Panalo-on', 14,  'Benguet', 1,  'Philippines'),
('Pangabuan', 14,  'Benguet', 1,  'Philippines'),
('Pantao-Ragat', 14,  'Benguet', 1,  'Philippines'),
('Patrocinio', 14,  'Benguet', 1,  'Philippines'),
('Pines', 14,  'Benguet', 1,  'Philippines'),
('Pongol', 14,  'Benguet', 1,  'Philippines'),
('Pontian', 14,  'Benguet', 1,  'Philippines'),
('Punta Silum', 14,  'Benguet', 1,  'Philippines'),
('Rebe', 14,  'Benguet', 1,  'Philippines'),
('Salawagan', 14,  'Benguet', 1,  'Philippines'),
('Salimbalan', 14,  'Benguet', 1,  'Philippines'),
('Sampagar', 14,  'Benguet', 1,  'Philippines'),
('San Martin', 14,  'Benguet', 1,  'Philippines'),
('Sankanan', 14,  'Benguet', 1,  'Philippines'),
('Silae', 14,  'Benguet', 1,  'Philippines'),
('Sinonoc', 14,  'Benguet', 1,  'Philippines'),
('Sugbongkogon', 14,  'Benguet', 1,  'Philippines'),
('Sumilao', 14,  'Benguet', 1,  'Philippines'),
('Sumpong', 14,  'Benguet', 1,  'Philippines'),
('Sungai', 14,  'Benguet', 1,  'Philippines'),
('Tabid', 14,  'Benguet', 1,  'Philippines'),
('Taboc', 14,  'Benguet', 1,  'Philippines'),
('Tacub', 14,  'Benguet', 1,  'Philippines'),
('Talakag', 14,  'Benguet', 1,  'Philippines'),
('Taypano', 14,  'Benguet', 1,  'Philippines'),
('Ticala-an', 14,  'Benguet', 1,  'Philippines'),
('Tignapalan', 14,  'Benguet', 1,  'Philippines'),
('Tubigan', 14,  'Benguet', 1,  'Philippines'),
('Tudela', 14,  'Benguet', 1,  'Philippines'),
('Tuod', 14,  'Benguet', 1,  'Philippines'),
('Tupsan', 14,  'Benguet', 1,  'Philippines'),
('Yumbing', 14,  'Benguet', 1,  'Philippines'),
('Almeria', 16,  'Biliran', 1,  'Philippines'),
('Biliran', 16,  'Biliran', 1,  'Philippines'),
('Cabucgayan', 16,  'Biliran', 1,  'Philippines'),
('Caibiran', 16,  'Biliran', 1,  'Philippines'),
('Culaba', 16,  'Biliran', 1,  'Philippines'),
('Kawayan', 16,  'Biliran', 1,  'Philippines'),
('Maripipi', 16,  'Biliran', 1,  'Philippines'),
('Naval', 16,  'Biliran', 1,  'Philippines'),
('Anibongan', 17,  'Bohol', 1,  'Philippines'),
('Babag', 17,  'Bohol', 1,  'Philippines'),
('Balutakay', 17,  'Bohol', 1,  'Philippines'),
('Bansalan', 17,  'Bohol', 1,  'Philippines'),
('Bukid', 17,  'Bohol', 1,  'Philippines'),
('Jose Abad Santos', 17,  'Bohol', 1,  'Philippines'),
('Katipunan', 17,  'Bohol', 1,  'Philippines'),
('La Libertad', 17,  'Bohol', 1,  'Philippines'),
('La Union', 17,  'Bohol', 1,  'Philippines'),
('Mabuhay', 17,  'Bohol', 1,  'Philippines'),
('Magsaysay', 17,  'Bohol', 1,  'Philippines'),
('Mahayag', 17,  'Bohol', 1,  'Philippines'),
('New Baclayon', 17,  'Bohol', 1,  'Philippines'),
('New Bohol', 17,  'Bohol', 1,  'Philippines'),
('Pag-asa', 17,  'Bohol', 1,  'Philippines'),
('San Ignacio', 17,  'Bohol', 1,  'Philippines'),
('San Miguel', 17,  'Bohol', 1,  'Philippines'),
('Tagum', 17,  'Bohol', 1,  'Philippines'),
('Tubod', 17,  'Bohol', 1,  'Philippines'),
('Wines', 17,  'Bohol', 1,  'Philippines'),
('Amas', 18,  'Bukidnon', 1,  'Philippines'),
('Bagontapay', 18,  'Bukidnon', 1,  'Philippines'),
('Baguer', 18,  'Bukidnon', 1,  'Philippines'),
('Baliton', 18,  'Bukidnon', 1,  'Philippines'),
('Banawa', 18,  'Bukidnon', 1,  'Philippines'),
('Bantogon', 18,  'Bukidnon', 1,  'Philippines'),
('Barongis', 18,  'Bukidnon', 1,  'Philippines'),
('Batasan', 18,  'Bukidnon', 1,  'Philippines'),
('Batutitik', 18,  'Bukidnon', 1,  'Philippines'),
('Bau', 18,  'Bukidnon', 1,  'Philippines'),
('Bayasong', 18,  'Bukidnon', 1,  'Philippines'),
('Bialong', 18,  'Bukidnon', 1,  'Philippines'),
('Buadtasan', 18,  'Bukidnon', 1,  'Philippines'),
('Bual', 18,  'Bukidnon', 1,  'Philippines'),
('Buayan', 18,  'Bukidnon', 1,  'Philippines'),
('Bulatukan', 18,  'Bukidnon', 1,  'Philippines'),
('Cebuano', 18,  'Bukidnon', 1,  'Philippines'),
('City of Kidapawan', 18,  'Bukidnon', 1,  'Philippines'),
('City of Koronadal', 18,  'Bukidnon', 1,  'Philippines'),
('City of Tacurong', 18,  'Bukidnon', 1,  'Philippines'),
('Colongolo', 18,  'Bukidnon', 1,  'Philippines'),
('Daliao', 18,  'Bukidnon', 1,  'Philippines'),
('Damawato', 18,  'Bukidnon', 1,  'Philippines'),
('Dualing', 18,  'Bukidnon', 1,  'Philippines'),
('Dunguan', 18,  'Bukidnon', 1,  'Philippines'),
('Glad', 18,  'Bukidnon', 1,  'Philippines'),
('Glamang', 18,  'Bukidnon', 1,  'Philippines'),
('Glan Peidu', 18,  'Bukidnon', 1,  'Philippines'),
('Gocoton', 18,  'Bukidnon', 1,  'Philippines'),
('Ilaya', 18,  'Bukidnon', 1,  'Philippines'),
('Kabalen', 18,  'Bukidnon', 1,  'Philippines'),
('Kablalan', 18,  'Bukidnon', 1,  'Philippines'),
('Kalaisan', 18,  'Bukidnon', 1,  'Philippines'),
('Kalamangog', 18,  'Bukidnon', 1,  'Philippines'),
('Kamanga', 18,  'Bukidnon', 1,  'Philippines'),
('Kapatan', 18,  'Bukidnon', 1,  'Philippines'),
('Katubao', 18,  'Bukidnon', 1,  'Philippines'),
('Kisante', 18,  'Bukidnon', 1,  'Philippines'),
('Kiupo', 18,  'Bukidnon', 1,  'Philippines'),
('Klinan', 18,  'Bukidnon', 1,  'Philippines'),
('Kling', 18,  'Bukidnon', 1,  'Philippines'),
('Kulaman', 18,  'Bukidnon', 1,  'Philippines'),
('Labu-o', 18,  'Bukidnon', 1,  'Philippines'),
('Lambontong', 18,  'Bukidnon', 1,  'Philippines'),
('Lamian', 18,  'Bukidnon', 1,  'Philippines'),
('Lampitak', 18,  'Bukidnon', 1,  'Philippines'),
('Liliongan', 18,  'Bukidnon', 1,  'Philippines'),
('Limbalod', 18,  'Bukidnon', 1,  'Philippines'),
('Limulan', 18,  'Bukidnon', 1,  'Philippines'),
('Linao', 18,  'Bukidnon', 1,  'Philippines'),
('Lumatil', 18,  'Bukidnon', 1,  'Philippines'),
('Lumazal', 18,  'Bukidnon', 1,  'Philippines'),
('Lumuyon', 18,  'Bukidnon', 1,  'Philippines'),
('Lun Pequeño', 18,  'Bukidnon', 1,  'Philippines'),
('Lunen', 18,  'Bukidnon', 1,  'Philippines'),
('M lang', 18,  'Bukidnon', 1,  'Philippines'),
('Maan', 18,  'Bukidnon', 1,  'Philippines'),
('Mabay', 18,  'Bukidnon', 1,  'Philippines'),
('Maguling', 18,  'Bukidnon', 1,  'Philippines'),
('Malamote', 18,  'Bukidnon', 1,  'Philippines'),
('Malapag', 18,  'Bukidnon', 1,  'Philippines'),
('Malasila', 18,  'Bukidnon', 1,  'Philippines'),
('Malbang', 18,  'Bukidnon', 1,  'Philippines'),
('Malingao', 18,  'Bukidnon', 1,  'Philippines'),
('Malisbeng', 18,  'Bukidnon', 1,  'Philippines'),
('Malitubog', 18,  'Bukidnon', 1,  'Philippines'),
('Manaulanan', 18,  'Bukidnon', 1,  'Philippines'),
('Manuangan', 18,  'Bukidnon', 1,  'Philippines'),
('Manuel Roxas', 18,  'Bukidnon', 1,  'Philippines'),
('Marbel', 18,  'Bukidnon', 1,  'Philippines'),
('Mariano Marcos', 18,  'Bukidnon', 1,  'Philippines'),
('Minapan', 18,  'Bukidnon', 1,  'Philippines'),
('Mindupok', 18,  'Bukidnon', 1,  'Philippines'),
('Nalus', 18,  'Bukidnon', 1,  'Philippines'),
('New Cebu', 18,  'Bukidnon', 1,  'Philippines'),
('New Iloilo', 18,  'Bukidnon', 1,  'Philippines'),
('Noling', 18,  'Bukidnon', 1,  'Philippines'),
('Osias', 18,  'Bukidnon', 1,  'Philippines'),
('Paatan', 18,  'Bukidnon', 1,  'Philippines'),
('Pagangan', 18,  'Bukidnon', 1,  'Philippines'),
('Palkan', 18,  'Bukidnon', 1,  'Philippines'),
('Pangyan', 18,  'Bukidnon', 1,  'Philippines'),
('Patindeguen', 18,  'Bukidnon', 1,  'Philippines'),
('Pedtad', 18,  'Bukidnon', 1,  'Philippines'),
('Pimbalayan', 18,  'Bukidnon', 1,  'Philippines'),
('Puloypuloy', 18,  'Bukidnon', 1,  'Philippines'),
('Punolu', 18,  'Bukidnon', 1,  'Philippines'),
('Puricay', 18,  'Bukidnon', 1,  'Philippines'),
('Ragandang', 18,  'Bukidnon', 1,  'Philippines'),
('Rotunda', 18,  'Bukidnon', 1,  'Philippines'),
('Saguing', 18,  'Bukidnon', 1,  'Philippines'),
('Salimbao', 18,  'Bukidnon', 1,  'Philippines'),
('Salunayan', 18,  'Bukidnon', 1,  'Philippines'),
('Sampao', 18,  'Bukidnon', 1,  'Philippines'),
('Sañgay', 18,  'Bukidnon', 1,  'Philippines'),
('Sapu Padidu', 18,  'Bukidnon', 1,  'Philippines'),
('Sebu', 18,  'Bukidnon', 1,  'Philippines'),
('Silway 7', 18,  'Bukidnon', 1,  'Philippines'),
('Sinolon', 18,  'Bukidnon', 1,  'Philippines'),
('Sulit', 18,  'Bukidnon', 1,  'Philippines'),
('Suyan', 18,  'Bukidnon', 1,  'Philippines'),
('T boli', 18,  'Bukidnon', 1,  'Philippines'),
('Taguisa', 18,  'Bukidnon', 1,  'Philippines'),
('Taluya', 18,  'Bukidnon', 1,  'Philippines'),
('Tambilil', 18,  'Bukidnon', 1,  'Philippines'),
('Tañgo', 18,  'Bukidnon', 1,  'Philippines'),
('Teresita', 18,  'Bukidnon', 1,  'Philippines'),
('Tinoto', 18,  'Bukidnon', 1,  'Philippines'),
('Tomado', 18,  'Bukidnon', 1,  'Philippines'),
('Tran', 18,  'Bukidnon', 1,  'Philippines'),
('Tuyan', 18,  'Bukidnon', 1,  'Philippines'),
('Upper Klinan', 18,  'Bukidnon', 1,  'Philippines'),
('Upper San Mateo', 18,  'Bukidnon', 1,  'Philippines'),
('Agay', 19,  'Bulacan', 1,  'Philippines'),
('Amaga', 19,  'Bulacan', 1,  'Philippines'),
('Anticala', 19,  'Bulacan', 1,  'Philippines'),
('Aras-asan', 19,  'Bulacan', 1,  'Philippines'),
('Bah-Bah', 19,  'Bulacan', 1,  'Philippines'),
('Balangbalang', 19,  'Bulacan', 1,  'Philippines'),
('Bancasi', 19,  'Bulacan', 1,  'Philippines'),
('Bangonay', 19,  'Bulacan', 1,  'Philippines'),
('Basa', 19,  'Bulacan', 1,  'Philippines'),
('Bayabas', 19,  'Bulacan', 1,  'Philippines'),
('Bayugan', 19,  'Bulacan', 1,  'Philippines'),
('Bigaan', 19,  'Bulacan', 1,  'Philippines'),
('Binucayan', 19,  'Bulacan', 1,  'Philippines'),
('Butuan', 19,  'Bulacan', 1,  'Philippines'),
('Caloc-an', 19,  'Bulacan', 1,  'Philippines'),
('Cantapoy', 19,  'Bulacan', 1,  'Philippines'),
('Capalayan', 19,  'Bulacan', 1,  'Philippines'),
('Causwagan', 19,  'Bulacan', 1,  'Philippines'),
('City of Cabadbaran', 19,  'Bulacan', 1,  'Philippines'),
('Comagascas', 19,  'Bulacan', 1,  'Philippines'),
('Cuevas', 19,  'Bulacan', 1,  'Philippines'),
('Culit', 19,  'Bulacan', 1,  'Philippines'),
('Dakbayan sa Bislig', 19,  'Bulacan', 1,  'Philippines'),
('Gamut', 19,  'Bulacan', 1,  'Philippines'),
('Guinabsan', 19,  'Bulacan', 1,  'Philippines'),
('Ipil', 19,  'Bulacan', 1,  'Philippines'),
('Jagupit', 19,  'Bulacan', 1,  'Philippines'),
('Kinabhangan', 19,  'Bulacan', 1,  'Philippines'),
('Lapinigan', 19,  'Bulacan', 1,  'Philippines'),
('Las Nieves', 19,  'Bulacan', 1,  'Philippines'),
('Los Angeles', 19,  'Bulacan', 1,  'Philippines'),
('Los Arcos', 19,  'Bulacan', 1,  'Philippines'),
('Loyola', 19,  'Bulacan', 1,  'Philippines'),
('Mabahin', 19,  'Bulacan', 1,  'Philippines'),
('Mabua', 19,  'Bulacan', 1,  'Philippines'),
('Manapa', 19,  'Bulacan', 1,  'Philippines'),
('Matabao', 19,  'Bulacan', 1,  'Philippines'),
('Maygatasan', 19,  'Bulacan', 1,  'Philippines'),
('Panikian', 19,  'Bulacan', 1,  'Philippines'),
('Patin-ay', 19,  'Bulacan', 1,  'Philippines'),
('Punta', 19,  'Bulacan', 1,  'Philippines'),
('Sanghan', 19,  'Bulacan', 1,  'Philippines'),
('Sinubong', 19,  'Bulacan', 1,  'Philippines'),
('Socorro', 19,  'Bulacan', 1,  'Philippines'),
('Tagcatong', 19,  'Bulacan', 1,  'Philippines'),
('Talacogon', 19,  'Bulacan', 1,  'Philippines'),
('Taligaman', 19,  'Bulacan', 1,  'Philippines'),
('Tidman', 19,  'Bulacan', 1,  'Philippines'),
('Tigao', 19,  'Bulacan', 1,  'Philippines'),
('Trento', 19,  'Bulacan', 1,  'Philippines'),
('Unidad', 19,  'Bulacan', 1,  'Philippines'),
('Bacolod Grande', 20,  'Cagayan', 1,  'Philippines'),
('Cagayan de Tawi-Tawi', 20,  'Cagayan', 1,  'Philippines'),
('Lumba-a-Bayabao', 20,  'Cagayan', 1,  'Philippines'),
('Marunggas', 20,  'Cagayan', 1,  'Philippines'),
('Molundo', 20,  'Cagayan', 1,  'Philippines'),
('Municipality of Indanan', 20,  'Cagayan', 1,  'Philippines'),
('Municipality of Lantawan', 20,  'Cagayan', 1,  'Philippines'),
('Municipality of Pangutaran', 20,  'Cagayan', 1,  'Philippines'),
('Municipality of Sultan Gumander', 20,  'Cagayan', 1,  'Philippines'),
('Municipality of Tongkil', 20,  'Cagayan', 1,  'Philippines'),
('New Panamao', 20,  'Cagayan', 1,  'Philippines'),
('Old Panamao', 20,  'Cagayan', 1,  'Philippines'),
('Pata', 20,  'Cagayan', 1,  'Philippines'),
('Poon-a-Bayabao', 20,  'Cagayan', 1,  'Philippines'),
('Sultan Sumagka', 20,  'Cagayan', 1,  'Philippines'),
('Abulug', 21,  'Cagayan Valley', 1,  'Philippines'),
('Aggugaddah', 21,  'Cagayan Valley', 1,  'Philippines'),
('Alibago', 21,  'Cagayan Valley', 1,  'Philippines'),
('Batal', 21,  'Cagayan Valley', 1,  'Philippines'),
('Buguey', 21,  'Cagayan Valley', 1,  'Philippines'),
('Cabulay', 21,  'Cagayan Valley', 1,  'Philippines'),
('Ibung', 21,  'Cagayan Valley', 1,  'Philippines'),
('Iraga', 21,  'Cagayan Valley', 1,  'Philippines'),
('Magapit', 21,  'Cagayan Valley', 1,  'Philippines'),
('Magapit Aguiguican', 21,  'Cagayan Valley', 1,  'Philippines'),
('Pilig', 21,  'Cagayan Valley', 1,  'Philippines'),
('Tuguegarao', 21,  'Cagayan Valley', 1,  'Philippines'),
('Ambuclao', 23,  'Camarines Norte', 1,  'Philippines'),
('Amlimay', 23,  'Camarines Norte', 1,  'Philippines'),
('Ampusungan', 23,  'Camarines Norte', 1,  'Philippines'),
('Angad', 23,  'Camarines Norte', 1,  'Philippines'),
('Atok', 23,  'Camarines Norte', 1,  'Philippines'),
('Baculongan', 23,  'Camarines Norte', 1,  'Philippines'),
('Baguinge', 23,  'Camarines Norte', 1,  'Philippines'),
('Baguio', 23,  'Camarines Norte', 1,  'Philippines'),
('Bakun', 23,  'Camarines Norte', 1,  'Philippines'),
('Bangao', 23,  'Camarines Norte', 1,  'Philippines'),
('Betwagan', 23,  'Camarines Norte', 1,  'Philippines'),
('Bocos', 23,  'Camarines Norte', 1,  'Philippines'),
('Bokod', 23,  'Camarines Norte', 1,  'Philippines'),
('Bucloc', 23,  'Camarines Norte', 1,  'Philippines'),
('Buguias', 23,  'Camarines Norte', 1,  'Philippines'),
('Bulalacao', 23,  'Camarines Norte', 1,  'Philippines'),
('Butigui', 23,  'Camarines Norte', 1,  'Philippines'),
('Daguioman', 23,  'Camarines Norte', 1,  'Philippines'),
('Dalipey', 23,  'Camarines Norte', 1,  'Philippines'),
('Dalupirip', 23,  'Camarines Norte', 1,  'Philippines'),
('Gambang', 23,  'Camarines Norte', 1,  'Philippines'),
('Guinsadan', 23,  'Camarines Norte', 1,  'Philippines'),
('Hapao', 23,  'Camarines Norte', 1,  'Philippines'),
('Itogon', 23,  'Camarines Norte', 1,  'Philippines'),
('Kabayan', 23,  'Camarines Norte', 1,  'Philippines'),
('Kapangan', 23,  'Camarines Norte', 1,  'Philippines'),
('Kibungan', 23,  'Camarines Norte', 1,  'Philippines'),
('La Trinidad', 23,  'Camarines Norte', 1,  'Philippines'),
('Lacub', 23,  'Camarines Norte', 1,  'Philippines'),
('Langiden', 23,  'Camarines Norte', 1,  'Philippines'),
('Laya', 23,  'Camarines Norte', 1,  'Philippines'),
('Licuan', 23,  'Camarines Norte', 1,  'Philippines'),
('Liwan', 23,  'Camarines Norte', 1,  'Philippines'),
('Loacan', 23,  'Camarines Norte', 1,  'Philippines'),
('Malibcong', 23,  'Camarines Norte', 1,  'Philippines'),
('Mankayan', 23,  'Camarines Norte', 1,  'Philippines'),
('Monamon', 23,  'Camarines Norte', 1,  'Philippines'),
('Nangalisan', 23,  'Camarines Norte', 1,  'Philippines'),
('Natubleng', 23,  'Camarines Norte', 1,  'Philippines'),
('Pidigan', 23,  'Camarines Norte', 1,  'Philippines'),
('Potia', 23,  'Camarines Norte', 1,  'Philippines'),
('Sablan', 23,  'Camarines Norte', 1,  'Philippines'),
('Sadsadan', 23,  'Camarines Norte', 1,  'Philippines'),
('Sal-Lapadan', 23,  'Camarines Norte', 1,  'Philippines'),
('Tabaan', 23,  'Camarines Norte', 1,  'Philippines'),
('Tacadang', 23,  'Camarines Norte', 1,  'Philippines'),
('Tayum', 23,  'Camarines Norte', 1,  'Philippines'),
('Tineg', 23,  'Camarines Norte', 1,  'Philippines'),
('Topdac', 23,  'Camarines Norte', 1,  'Philippines'),
('Tuba', 23,  'Camarines Norte', 1,  'Philippines'),
('Tublay', 23,  'Camarines Norte', 1,  'Philippines'),
('Tubo', 23,  'Camarines Norte', 1,  'Philippines'),
('Tuding', 23,  'Camarines Norte', 1,  'Philippines'),
('Baao', 24,  'Camarines Sur', 1,  'Philippines'),
('Balatan', 24,  'Camarines Sur', 1,  'Philippines'),
('Bato', 24,  'Camarines Sur', 1,  'Philippines'),
('Bombon', 24,  'Camarines Sur', 1,  'Philippines'),
('Buhi', 24,  'Camarines Sur', 1,  'Philippines'),
('Bula', 24,  'Camarines Sur', 1,  'Philippines'),
('Cabusao', 24,  'Camarines Sur', 1,  'Philippines'),
('Calabanga', 24,  'Camarines Sur', 1,  'Philippines'),
('Camaligan', 24,  'Camarines Sur', 1,  'Philippines'),
('Canaman', 24,  'Camarines Sur', 1,  'Philippines'),
('Caramoan', 24,  'Camarines Sur', 1,  'Philippines'),
('Del Gallego', 24,  'Camarines Sur', 1,  'Philippines'),
('Gainza', 24,  'Camarines Sur', 1,  'Philippines'),
('Garchitorena', 24,  'Camarines Sur', 1,  'Philippines'),
('Goa', 24,  'Camarines Sur', 1,  'Philippines'),
('Iriga City', 24,  'Camarines Sur', 1,  'Philippines'),
('Lagonoy', 24,  'Camarines Sur', 1,  'Philippines'),
('Libmanan', 24,  'Camarines Sur', 1,  'Philippines'),
('Lupi', 24,  'Camarines Sur', 1,  'Philippines'),
('Magarao', 24,  'Camarines Sur', 1,  'Philippines'),
('Milaor', 24,  'Camarines Sur', 1,  'Philippines'),
('Minalabac', 24,  'Camarines Sur', 1,  'Philippines'),
('Nabua', 24,  'Camarines Sur', 1,  'Philippines'),
('Naga', 24,  'Camarines Sur', 1,  'Philippines'),
('Ocampo', 24,  'Camarines Sur', 1,  'Philippines'),
('Pamplona', 24,  'Camarines Sur', 1,  'Philippines'),
('Pasacao', 24,  'Camarines Sur', 1,  'Philippines'),
('Pili', 24,  'Camarines Sur', 1,  'Philippines'),
('Presentacion', 24,  'Camarines Sur', 1,  'Philippines'),
('Ragay', 24,  'Camarines Sur', 1,  'Philippines'),
('Sagnay', 24,  'Camarines Sur', 1,  'Philippines'),
('San Fernando', 24,  'Camarines Sur', 1,  'Philippines'),
('Sipocot', 24,  'Camarines Sur', 1,  'Philippines'),
('Siruma', 24,  'Camarines Sur', 1,  'Philippines'),
('Tigaon', 24,  'Camarines Sur', 1,  'Philippines'),
('Tinambac', 24,  'Camarines Sur', 1,  'Philippines'),
('Catarman', 25,  'Camiguin', 1,  'Philippines'),
('Guinsiliban', 25,  'Camiguin', 1,  'Philippines'),
('Mahinog', 25,  'Camiguin', 1,  'Philippines'),
('Mambajao', 25,  'Camiguin', 1,  'Philippines'),
('Sagay', 25,  'Camiguin', 1,  'Philippines'),
('Cuartero', 26,  'Capiz', 1,  'Philippines'),
('Dao', 26,  'Capiz', 1,  'Philippines'),
('Dumalag', 26,  'Capiz', 1,  'Philippines'),
('Dumarao', 26,  'Capiz', 1,  'Philippines'),
('Ivisan', 26,  'Capiz', 1,  'Philippines'),
('Jamindan', 26,  'Capiz', 1,  'Philippines'),
('Maayon', 26,  'Capiz', 1,  'Philippines'),
('Mambusao', 26,  'Capiz', 1,  'Philippines'),
('Panay', 26,  'Capiz', 1,  'Philippines'),
('Panitan', 26,  'Capiz', 1,  'Philippines'),
('Pilar', 26,  'Capiz', 1,  'Philippines'),
('Pontevedra', 26,  'Capiz', 1,  'Philippines'),
('President Roxas', 26,  'Capiz', 1,  'Philippines'),
('Roxas City', 26,  'Capiz', 1,  'Philippines'),
('Sapian', 26,  'Capiz', 1,  'Philippines'),
('Sigma', 26,  'Capiz', 1,  'Philippines'),
('Tapaz', 26,  'Capiz', 1,  'Philippines'),
('Adlay', 27,  'Caraga', 1,  'Philippines'),
('Basag', 27,  'Caraga', 1,  'Philippines'),
('Bunawan', 27,  'Caraga', 1,  'Philippines'),
('Cabadbaran', 27,  'Caraga', 1,  'Philippines'),
('Del Carmen Surigao del Norte', 27,  'Caraga', 1,  'Philippines'),
('Dinagat Islands', 27,  'Caraga', 1,  'Philippines'),
('Jabonga', 27,  'Caraga', 1,  'Philippines'),
('Kitcharao', 27,  'Caraga', 1,  'Philippines'),
('Lombocan', 27,  'Caraga', 1,  'Philippines'),
('Nasipit', 27,  'Caraga', 1,  'Philippines'),
('Santa Josefa', 27,  'Caraga', 1,  'Philippines'),
('Sibagat', 27,  'Caraga', 1,  'Philippines'),
('Surigao', 27,  'Caraga', 1,  'Philippines'),
('Tubay', 27,  'Caraga', 1,  'Philippines'),
('Tungao', 27,  'Caraga', 1,  'Philippines'),
('Veruela', 27,  'Caraga', 1,  'Philippines'),
('Bagamanoc', 28,  'Catanduanes', 1,  'Philippines'),
('Caramoran', 28,  'Catanduanes', 1,  'Philippines'),
('Gigmoto', 28,  'Catanduanes', 1,  'Philippines'),
('Panganiban', 28,  'Catanduanes', 1,  'Philippines'),
('Viga', 28,  'Catanduanes', 1,  'Philippines'),
('Virac', 28,  'Catanduanes', 1,  'Philippines'),
('Alfonso', 29,  'Cavite', 1,  'Philippines'),
('Amadeo', 29,  'Cavite', 1,  'Philippines'),
('Bacoor', 29,  'Cavite', 1,  'Philippines'),
('Carmona', 29,  'Cavite', 1,  'Philippines'),
('Cavite City', 29,  'Cavite', 1,  'Philippines'),
('Dasmariñas', 29,  'Cavite', 1,  'Philippines'),
('General Emilio Aguinaldo', 29,  'Cavite', 1,  'Philippines'),
('General Mariano Alvarez', 29,  'Cavite', 1,  'Philippines'),
('General Trias', 29,  'Cavite', 1,  'Philippines'),
('Imus', 29,  'Cavite', 1,  'Philippines'),
('Indang', 29,  'Cavite', 1,  'Philippines'),
('Kawit', 29,  'Cavite', 1,  'Philippines'),
('Magallanes', 29,  'Cavite', 1,  'Philippines'),
('Maragondon', 29,  'Cavite', 1,  'Philippines'),
('Mendez', 29,  'Cavite', 1,  'Philippines'),
('Naic', 29,  'Cavite', 1,  'Philippines'),
('Noveleta', 29,  'Cavite', 1,  'Philippines'),
('Silang', 29,  'Cavite', 1,  'Philippines'),
('Tagaytay', 29,  'Cavite', 1,  'Philippines'),
('Tanza', 29,  'Cavite', 1,  'Philippines'),
('Ternate', 29,  'Cavite', 1,  'Philippines'),
('Trece Martires', 29,  'Cavite', 1,  'Philippines'),
('Alcantara', 30,  'Cebu', 1,  'Philippines'),
('Alcoy', 30,  'Cebu', 1,  'Philippines'),
('Aloguinsan', 30,  'Cebu', 1,  'Philippines'),
('Argao', 30,  'Cebu', 1,  'Philippines'),
('Asturias', 30,  'Cebu', 1,  'Philippines'),
('Badian', 30,  'Cebu', 1,  'Philippines'),
('Balamban', 30,  'Cebu', 1,  'Philippines'),
('Bantayan', 30,  'Cebu', 1,  'Philippines'),
('Barili', 30,  'Cebu', 1,  'Philippines'),
('Bogo', 30,  'Cebu', 1,  'Philippines'),
('Boljoon', 30,  'Cebu', 1,  'Philippines'),
('Borbon', 30,  'Cebu', 1,  'Philippines'),
('Carcar', 30,  'Cebu', 1,  'Philippines'),
('Catmon', 30,  'Cebu', 1,  'Philippines'),
('Cebu City', 30,  'Cebu', 1,  'Philippines'),
('Compostela', 30,  'Cebu', 1,  'Philippines'),
('Consolacion', 30,  'Cebu', 1,  'Philippines'),
('Cordova', 30,  'Cebu', 1,  'Philippines'),
('Daanbantayan', 30,  'Cebu', 1,  'Philippines'),
('Dalaguete', 30,  'Cebu', 1,  'Philippines'),
('Danao', 30,  'Cebu', 1,  'Philippines'),
('Dumanjug', 30,  'Cebu', 1,  'Philippines'),
('Ginatilan', 30,  'Cebu', 1,  'Philippines'),
('Lapu-Lapu City', 30,  'Cebu', 1,  'Philippines'),
('Liloan', 30,  'Cebu', 1,  'Philippines'),
('Madridejos', 30,  'Cebu', 1,  'Philippines'),
('Malabuyoc', 30,  'Cebu', 1,  'Philippines'),
('Mandaue', 30,  'Cebu', 1,  'Philippines'),
('Medellin', 30,  'Cebu', 1,  'Philippines'),
('Minglanilla', 30,  'Cebu', 1,  'Philippines'),
('Moalboal', 30,  'Cebu', 1,  'Philippines'),
('Oslob', 30,  'Cebu', 1,  'Philippines'),
('Pinamungajan', 30,  'Cebu', 1,  'Philippines'),
('Poro', 30,  'Cebu', 1,  'Philippines'),
('Ronda', 30,  'Cebu', 1,  'Philippines'),
('Samboan', 30,  'Cebu', 1,  'Philippines'),
('Santander', 30,  'Cebu', 1,  'Philippines'),
('Sibonga', 30,  'Cebu', 1,  'Philippines'),
('Sogod', 30,  'Cebu', 1,  'Philippines'),
('Tabogon', 30,  'Cebu', 1,  'Philippines'),
('Tabuelan', 30,  'Cebu', 1,  'Philippines'),
('Toledo', 30,  'Cebu', 1,  'Philippines'),
('Apayao', 33,  'Cordillera Administrative', 1,  'Philippines'),
('Bangued', 33,  'Cordillera Administrative', 1,  'Philippines'),
('Boliney', 33,  'Cordillera Administrative', 1,  'Philippines'),
('Bucay', 33,  'Cordillera Administrative', 1,  'Philippines'),
('Danglas', 33,  'Cordillera Administrative', 1,  'Philippines'),
('Kalinga', 33,  'Cordillera Administrative', 1,  'Philippines'),
('Lagangilang', 33,  'Cordillera Administrative', 1,  'Philippines'),
('Lagayan', 33,  'Cordillera Administrative', 1,  'Philippines'),
('Luba', 33,  'Cordillera Administrative', 1,  'Philippines'),
('Manabo', 33,  'Cordillera Administrative', 1,  'Philippines'),
('Mountain Province', 33,  'Cordillera Administrative', 1,  'Philippines'),
('Peñarrubia', 33,  'Cordillera Administrative', 1,  'Philippines'),
('Villaviciosa', 33,  'Cordillera Administrative', 1,  'Philippines'),
('Alamada', 34,  'Cotabato', 1,  'Philippines'),
('Aleosan', 34,  'Cotabato', 1,  'Philippines'),
('Antipas', 34,  'Cotabato', 1,  'Philippines'),
('Arakan', 34,  'Cotabato', 1,  'Philippines'),
('Banisilan', 34,  'Cotabato', 1,  'Philippines'),
('Kabacan', 34,  'Cotabato', 1,  'Philippines'),
('Kadayangan', 34,  'Cotabato', 1,  'Philippines'),
('Kapalawan', 34,  'Cotabato', 1,  'Philippines'),
('Kidapawan', 34,  'Cotabato', 1,  'Philippines'),
('Libungan', 34,  'Cotabato', 1,  'Philippines'),
('Ligawasan', 34,  'Cotabato', 1,  'Philippines'),
('Magpet', 34,  'Cotabato', 1,  'Philippines'),
('Makilala', 34,  'Cotabato', 1,  'Philippines'),
('Malidegao', 34,  'Cotabato', 1,  'Philippines'),
('Matalam', 34,  'Cotabato', 1,  'Philippines'),
('Midsayap', 34,  'Cotabato', 1,  'Philippines'),
('Nabalawag', 34,  'Cotabato', 1,  'Philippines'),
('Old Kaabakan', 34,  'Cotabato', 1,  'Philippines'),
('Pigcawayan', 34,  'Cotabato', 1,  'Philippines'),
('Pikit', 34,  'Cotabato', 1,  'Philippines'),
('Tugunan', 34,  'Cotabato', 1,  'Philippines'),
('Tulunan', 34,  'Cotabato', 1,  'Philippines'),
('Alejal', 35,  'Davao', 1,  'Philippines'),
('Andili', 35,  'Davao', 1,  'Philippines'),
('Andop', 35,  'Davao', 1,  'Philippines'),
('Astorga', 35,  'Davao', 1,  'Philippines'),
('Baculin', 35,  'Davao', 1,  'Philippines'),
('Balagunan', 35,  'Davao', 1,  'Philippines'),
('Balangonan', 35,  'Davao', 1,  'Philippines'),
('Bantacan', 35,  'Davao', 1,  'Philippines'),
('Baon', 35,  'Davao', 1,  'Philippines'),
('Baracatan', 35,  'Davao', 1,  'Philippines'),
('Basiawan', 35,  'Davao', 1,  'Philippines'),
('Batiano', 35,  'Davao', 1,  'Philippines'),
('Batobato', 35,  'Davao', 1,  'Philippines'),
('Baylo', 35,  'Davao', 1,  'Philippines'),
('Bincoñgan', 35,  'Davao', 1,  'Philippines'),
('Bitaogan', 35,  'Davao', 1,  'Philippines'),
('Bolila', 35,  'Davao', 1,  'Philippines'),
('Buclad', 35,  'Davao', 1,  'Philippines'),
('Buhangin', 35,  'Davao', 1,  'Philippines'),
('Bulacan', 35,  'Davao', 1,  'Philippines'),
('Bungabon', 35,  'Davao', 1,  'Philippines'),
('Butulan', 35,  'Davao', 1,  'Philippines'),
('Cabayangan', 35,  'Davao', 1,  'Philippines'),
('Cabinuangan', 35,  'Davao', 1,  'Philippines'),
('Caburan', 35,  'Davao', 1,  'Philippines'),
('Cambanugoy', 35,  'Davao', 1,  'Philippines'),
('Camudmud', 35,  'Davao', 1,  'Philippines'),
('Compostela Valley', 35,  'Davao', 1,  'Philippines'),
('Corocotan', 35,  'Davao', 1,  'Philippines'),
('Coronon', 35,  'Davao', 1,  'Philippines'),
('Cuambog', 35,  'Davao', 1,  'Philippines'),
('Culaman', 35,  'Davao', 1,  'Philippines'),
('Dacudao', 35,  'Davao', 1,  'Philippines'),
('Davan', 35,  'Davao', 1,  'Philippines'),
('Davao', 35,  'Davao', 1,  'Philippines'),
('Dolo', 35,  'Davao', 1,  'Philippines'),
('Dumlan', 35,  'Davao', 1,  'Philippines'),
('Gabuyan', 35,  'Davao', 1,  'Philippines'),
('Goma', 35,  'Davao', 1,  'Philippines'),
('Guihing Proper', 35,  'Davao', 1,  'Philippines'),
('Gumalang', 35,  'Davao', 1,  'Philippines'),
('Gupitan', 35,  'Davao', 1,  'Philippines'),
('Hiju Maco', 35,  'Davao', 1,  'Philippines'),
('Ignit', 35,  'Davao', 1,  'Philippines'),
('Ilangay', 35,  'Davao', 1,  'Philippines'),
('Inawayan', 35,  'Davao', 1,  'Philippines'),
('Kalbay', 35,  'Davao', 1,  'Philippines'),
('Kalian', 35,  'Davao', 1,  'Philippines'),
('Kaligutan', 35,  'Davao', 1,  'Philippines'),
('Kapalong', 35,  'Davao', 1,  'Philippines'),
('Kinablangan', 35,  'Davao', 1,  'Philippines'),
('Kinamayan', 35,  'Davao', 1,  'Philippines'),
('Kinangan', 35,  'Davao', 1,  'Philippines'),
('Lacson', 35,  'Davao', 1,  'Philippines'),
('Lais', 35,  'Davao', 1,  'Philippines'),
('Lapuan', 35,  'Davao', 1,  'Philippines'),
('Lasang', 35,  'Davao', 1,  'Philippines'),
('Libuganon', 35,  'Davao', 1,  'Philippines'),
('Limao', 35,  'Davao', 1,  'Philippines'),
('Limot', 35,  'Davao', 1,  'Philippines'),
('Linoan', 35,  'Davao', 1,  'Philippines'),
('Lukatan', 35,  'Davao', 1,  'Philippines'),
('Lungaog', 35,  'Davao', 1,  'Philippines'),
('Luzon', 35,  'Davao', 1,  'Philippines'),
('Maduao', 35,  'Davao', 1,  'Philippines'),
('Magatos', 35,  'Davao', 1,  'Philippines'),
('Magdug', 35,  'Davao', 1,  'Philippines'),
('Magnaga', 35,  'Davao', 1,  'Philippines'),
('Magugpo Poblacion', 35,  'Davao', 1,  'Philippines'),
('Mahanob', 35,  'Davao', 1,  'Philippines'),
('Malagos', 35,  'Davao', 1,  'Philippines'),
('Malita', 35,  'Davao', 1,  'Philippines'),
('Mambago', 35,  'Davao', 1,  'Philippines'),
('Managa', 35,  'Davao', 1,  'Philippines'),
('Manaloal', 35,  'Davao', 1,  'Philippines'),
('Manat', 35,  'Davao', 1,  'Philippines'),
('Mangili', 35,  'Davao', 1,  'Philippines'),
('Manikling', 35,  'Davao', 1,  'Philippines'),
('Matiao', 35,  'Davao', 1,  'Philippines'),
('Matti', 35,  'Davao', 1,  'Philippines'),
('Mayo', 35,  'Davao', 1,  'Philippines'),
('Nangan', 35,  'Davao', 1,  'Philippines'),
('Nanyo', 35,  'Davao', 1,  'Philippines'),
('New Leyte', 35,  'Davao', 1,  'Philippines'),
('New Sibonga', 35,  'Davao', 1,  'Philippines'),
('New Visayas', 35,  'Davao', 1,  'Philippines'),
('Nuing', 35,  'Davao', 1,  'Philippines'),
('Pagsabangan', 35,  'Davao', 1,  'Philippines'),
('Palma Gil', 35,  'Davao', 1,  'Philippines'),
('Pandasan', 35,  'Davao', 1,  'Philippines'),
('Pangian', 35,  'Davao', 1,  'Philippines'),
('Pasian', 35,  'Davao', 1,  'Philippines'),
('Pondaguitan', 35,  'Davao', 1,  'Philippines'),
('Pung-Pang', 35,  'Davao', 1,  'Philippines'),
('San Alfonso', 35,  'Davao', 1,  'Philippines'),
('Sarangani', 35,  'Davao', 1,  'Philippines'),
('Sigaboy', 35,  'Davao', 1,  'Philippines'),
('Simod', 35,  'Davao', 1,  'Philippines'),
('Sinawilan', 35,  'Davao', 1,  'Philippines'),
('Sinayawan', 35,  'Davao', 1,  'Philippines'),
('Sirib', 35,  'Davao', 1,  'Philippines'),
('Sugal', 35,  'Davao', 1,  'Philippines'),
('Surup', 35,  'Davao', 1,  'Philippines'),
('Suz-on', 35,  'Davao', 1,  'Philippines'),
('Tagakpan', 35,  'Davao', 1,  'Philippines'),
('Tagdanua', 35,  'Davao', 1,  'Philippines'),
('Tagnanan', 35,  'Davao', 1,  'Philippines'),
('Takub', 35,  'Davao', 1,  'Philippines'),
('Talagutong', 35,  'Davao', 1,  'Philippines'),
('Talomo', 35,  'Davao', 1,  'Philippines'),
('Tamayong', 35,  'Davao', 1,  'Philippines'),
('Tamisan', 35,  'Davao', 1,  'Philippines'),
('Tamugan', 35,  'Davao', 1,  'Philippines'),
('Tanlad', 35,  'Davao', 1,  'Philippines'),
('Tapia', 35,  'Davao', 1,  'Philippines'),
('Tawan tawan', 35,  'Davao', 1,  'Philippines'),
('Tibagon', 35,  'Davao', 1,  'Philippines'),
('Tibanbang', 35,  'Davao', 1,  'Philippines'),
('Tiblawan', 35,  'Davao', 1,  'Philippines'),
('Tombongon', 35,  'Davao', 1,  'Philippines'),
('Tubalan', 35,  'Davao', 1,  'Philippines'),
('Tuban', 35,  'Davao', 1,  'Philippines'),
('Tuganay', 35,  'Davao', 1,  'Philippines'),
('Tuli', 35,  'Davao', 1,  'Philippines'),
('Ula', 35,  'Davao', 1,  'Philippines'),
('Wañgan', 35,  'Davao', 1,  'Philippines'),
('Laak', 36,  'Davao de Oro', 1,  'Philippines'),
('Maco', 36,  'Davao de Oro', 1,  'Philippines'),
('Maragusan', 36,  'Davao de Oro', 1,  'Philippines'),
('Mawab', 36,  'Davao de Oro', 1,  'Philippines'),
('Monkayo', 36,  'Davao de Oro', 1,  'Philippines'),
('Montevista', 36,  'Davao de Oro', 1,  'Philippines'),
('Nabunturan', 36,  'Davao de Oro', 1,  'Philippines'),
('New Bataan', 36,  'Davao de Oro', 1,  'Philippines'),
('Pantukan', 36,  'Davao de Oro', 1,  'Philippines'),
('Asuncion', 37,  'Davao del Norte', 1,  'Philippines'),
('Braulio E. Dujali', 37,  'Davao del Norte', 1,  'Philippines'),
('New Corella', 37,  'Davao del Norte', 1,  'Philippines'),
('Panabo', 37,  'Davao del Norte', 1,  'Philippines'),
('Samal', 37,  'Davao del Norte', 1,  'Philippines'),
('Talaingod', 37,  'Davao del Norte', 1,  'Philippines'),
('Davao City', 38,  'Davao del Sur', 1,  'Philippines'),
('Digos', 38,  'Davao del Sur', 1,  'Philippines'),
('Hagonoy', 38,  'Davao del Sur', 1,  'Philippines'),
('Kiblawan', 38,  'Davao del Sur', 1,  'Philippines'),
('Malalag', 38,  'Davao del Sur', 1,  'Philippines'),
('Matanao', 38,  'Davao del Sur', 1,  'Philippines'),
('Padada', 38,  'Davao del Sur', 1,  'Philippines'),
('Sulop', 38,  'Davao del Sur', 1,  'Philippines'),
('Don Marcelino', 39,  'Davao Occidental', 1,  'Philippines'),
('Baganga', 40,  'Davao Oriental', 1,  'Philippines'),
('Banaybanay', 40,  'Davao Oriental', 1,  'Philippines'),
('Boston', 40,  'Davao Oriental', 1,  'Philippines'),
('Caraga', 40,  'Davao Oriental', 1,  'Philippines'),
('Cateel', 40,  'Davao Oriental', 1,  'Philippines'),
('Governor Generoso', 40,  'Davao Oriental', 1,  'Philippines'),
('Lupon', 40,  'Davao Oriental', 1,  'Philippines'),
('Manay', 40,  'Davao Oriental', 1,  'Philippines'),
('Mati', 40,  'Davao Oriental', 1,  'Philippines'),
('Tarragona', 40,  'Davao Oriental', 1,  'Philippines'),
('Basilisa', 41,  'Dinagat Islands', 1,  'Philippines'),
('Cagdianao', 41,  'Dinagat Islands', 1,  'Philippines'),
('Dinagat', 41,  'Dinagat Islands', 1,  'Philippines'),
('Libjo', 41,  'Dinagat Islands', 1,  'Philippines'),
('Loreto', 41,  'Dinagat Islands', 1,  'Philippines'),
('Tubajon', 41,  'Dinagat Islands', 1,  'Philippines'),
('Arteche', 42,  'Eastern Samar', 1,  'Philippines'),
('Balangiga', 42,  'Eastern Samar', 1,  'Philippines'),
('Balangkayan', 42,  'Eastern Samar', 1,  'Philippines'),
('Borongan', 42,  'Eastern Samar', 1,  'Philippines'),
('Can-Avid', 42,  'Eastern Samar', 1,  'Philippines'),
('Dolores', 42,  'Eastern Samar', 1,  'Philippines'),
('General MacArthur', 42,  'Eastern Samar', 1,  'Philippines'),
('Giporlos', 42,  'Eastern Samar', 1,  'Philippines'),
('Guiuan', 42,  'Eastern Samar', 1,  'Philippines'),
('Hernani', 42,  'Eastern Samar', 1,  'Philippines'),
('Jipapad', 42,  'Eastern Samar', 1,  'Philippines'),
('Lawaan', 42,  'Eastern Samar', 1,  'Philippines'),
('Llorente', 42,  'Eastern Samar', 1,  'Philippines'),
('Maydolong', 42,  'Eastern Samar', 1,  'Philippines'),
('Oras', 42,  'Eastern Samar', 1,  'Philippines'),
('Quinapondan', 42,  'Eastern Samar', 1,  'Philippines'),
('Salcedo', 42,  'Eastern Samar', 1,  'Philippines'),
('San Julian', 42,  'Eastern Samar', 1,  'Philippines'),
('San Policarpo', 42,  'Eastern Samar', 1,  'Philippines'),
('Sulat', 42,  'Eastern Samar', 1,  'Philippines'),
('Taft', 42,  'Eastern Samar', 1,  'Philippines'),
('Calbayog', 43,  'Eastern Visayas', 1,  'Philippines'),
('Gubang', 43,  'Eastern Visayas', 1,  'Philippines'),
('Inangatan', 43,  'Eastern Visayas', 1,  'Philippines'),
('Lao', 43,  'Eastern Visayas', 1,  'Philippines'),
('Lubi', 43,  'Eastern Visayas', 1,  'Philippines'),
('Mahagnao', 43,  'Eastern Visayas', 1,  'Philippines'),
('Margen', 43,  'Eastern Visayas', 1,  'Philippines'),
('Pasay', 43,  'Eastern Visayas', 1,  'Philippines'),
('Pinangomhan', 43,  'Eastern Visayas', 1,  'Philippines'),
('Tabing', 43,  'Eastern Visayas', 1,  'Philippines'),
('Tibur', 43,  'Eastern Visayas', 1,  'Philippines'),
('Jordan', 44,  'Guimaras', 1,  'Philippines'),
('Nueva Valencia', 44,  'Guimaras', 1,  'Philippines'),
('Sibunag', 44,  'Guimaras', 1,  'Philippines'),
('Aguinaldo', 45,  'Ifugao', 1,  'Philippines'),
('Alfonso Lista', 45,  'Ifugao', 1,  'Philippines'),
('Asipulo', 45,  'Ifugao', 1,  'Philippines'),
('Banaue', 45,  'Ifugao', 1,  'Philippines'),
('Hingyon', 45,  'Ifugao', 1,  'Philippines'),
('Hungduan', 45,  'Ifugao', 1,  'Philippines'),
('Kiangan', 45,  'Ifugao', 1,  'Philippines'),
('Lagawe', 45,  'Ifugao', 1,  'Philippines'),
('Lamut', 45,  'Ifugao', 1,  'Philippines'),
('Mayoyao', 45,  'Ifugao', 1,  'Philippines'),
('Tinoc', 45,  'Ifugao', 1,  'Philippines'),
('Acao', 46,  'Ilocos', 1,  'Philippines'),
('Batac City', 46,  'Ilocos', 1,  'Philippines'),
('Catablan', 46,  'Ilocos', 1,  'Philippines'),
('Espiritu', 46,  'Ilocos', 1,  'Philippines'),
('Paldit', 46,  'Ilocos', 1,  'Philippines'),
('Tocok', 46,  'Ilocos', 1,  'Philippines'),
('Adams', 47,  'Ilocos Norte', 1,  'Philippines'),
('Bacarra', 47,  'Ilocos Norte', 1,  'Philippines'),
('Badoc', 47,  'Ilocos Norte', 1,  'Philippines'),
('Bangui', 47,  'Ilocos Norte', 1,  'Philippines'),
('Banna', 47,  'Ilocos Norte', 1,  'Philippines'),
('Batac', 47,  'Ilocos Norte', 1,  'Philippines'),
('Burgos', 47,  'Ilocos Norte', 1,  'Philippines'),
('Carasi', 47,  'Ilocos Norte', 1,  'Philippines'),
('Currimao', 47,  'Ilocos Norte', 1,  'Philippines'),
('Dingras', 47,  'Ilocos Norte', 1,  'Philippines'),
('Dumalneg', 47,  'Ilocos Norte', 1,  'Philippines'),
('Laoag', 47,  'Ilocos Norte', 1,  'Philippines'),
('Marcos', 47,  'Ilocos Norte', 1,  'Philippines'),
('Nueva Era', 47,  'Ilocos Norte', 1,  'Philippines'),
('Pagudpud', 47,  'Ilocos Norte', 1,  'Philippines'),
('Paoay', 47,  'Ilocos Norte', 1,  'Philippines'),
('Pasuquin', 47,  'Ilocos Norte', 1,  'Philippines'),
('Piddig', 47,  'Ilocos Norte', 1,  'Philippines'),
('Pinili', 47,  'Ilocos Norte', 1,  'Philippines'),
('Sarrat', 47,  'Ilocos Norte', 1,  'Philippines'),
('Solsona', 47,  'Ilocos Norte', 1,  'Philippines'),
('Vintar', 47,  'Ilocos Norte', 1,  'Philippines'),
('Alilem', 48,  'Ilocos Sur', 1,  'Philippines'),
('Banayoyo', 48,  'Ilocos Sur', 1,  'Philippines'),
('Bantay', 48,  'Ilocos Sur', 1,  'Philippines'),
('Candon', 48,  'Ilocos Sur', 1,  'Philippines'),
('Caoayan', 48,  'Ilocos Sur', 1,  'Philippines'),
('Galimuyod', 48,  'Ilocos Sur', 1,  'Philippines'),
('Gregorio del Pilar', 48,  'Ilocos Sur', 1,  'Philippines'),
('Lidlidda', 48,  'Ilocos Sur', 1,  'Philippines'),
('Magsingal', 48,  'Ilocos Sur', 1,  'Philippines'),
('Nagbukel', 48,  'Ilocos Sur', 1,  'Philippines'),
('Narvacan', 48,  'Ilocos Sur', 1,  'Philippines'),
('Quirino', 48,  'Ilocos Sur', 1,  'Philippines'),
('San Emilio', 48,  'Ilocos Sur', 1,  'Philippines'),
('San Esteban', 48,  'Ilocos Sur', 1,  'Philippines'),
('San Ildefonso', 48,  'Ilocos Sur', 1,  'Philippines'),
('Santa', 48,  'Ilocos Sur', 1,  'Philippines'),
('Santa Catalina', 48,  'Ilocos Sur', 1,  'Philippines'),
('Santa Lucia', 48,  'Ilocos Sur', 1,  'Philippines'),
('Sigay', 48,  'Ilocos Sur', 1,  'Philippines'),
('Sinait', 48,  'Ilocos Sur', 1,  'Philippines'),
('Sugpon', 48,  'Ilocos Sur', 1,  'Philippines'),
('Suyo', 48,  'Ilocos Sur', 1,  'Philippines'),
('Tagudin', 48,  'Ilocos Sur', 1,  'Philippines'),
('Vigan', 48,  'Ilocos Sur', 1,  'Philippines'),
('Ajuy', 49,  'Iloilo', 1,  'Philippines'),
('Alimodian', 49,  'Iloilo', 1,  'Philippines'),
('Anilao', 49,  'Iloilo', 1,  'Philippines'),
('Badiangan', 49,  'Iloilo', 1,  'Philippines'),
('Balasan', 49,  'Iloilo', 1,  'Philippines'),
('Banate', 49,  'Iloilo', 1,  'Philippines'),
('Barotac Nuevo', 49,  'Iloilo', 1,  'Philippines'),
('Barotac Viejo', 49,  'Iloilo', 1,  'Philippines'),
('Batad', 49,  'Iloilo', 1,  'Philippines'),
('Bingawan', 49,  'Iloilo', 1,  'Philippines'),
('Cabatuan', 49,  'Iloilo', 1,  'Philippines'),
('Calinog', 49,  'Iloilo', 1,  'Philippines'),
('Carles', 49,  'Iloilo', 1,  'Philippines'),
('Dingle', 49,  'Iloilo', 1,  'Philippines'),
('Dueñas', 49,  'Iloilo', 1,  'Philippines'),
('Dumangas', 49,  'Iloilo', 1,  'Philippines'),
('Guimbal', 49,  'Iloilo', 1,  'Philippines'),
('Igbaras', 49,  'Iloilo', 1,  'Philippines'),
('Iloilo', 49,  'Iloilo', 1,  'Philippines'),
('Janiuay', 49,  'Iloilo', 1,  'Philippines'),
('Lambunao', 49,  'Iloilo', 1,  'Philippines'),
('Leganes', 49,  'Iloilo', 1,  'Philippines'),
('Leon', 49,  'Iloilo', 1,  'Philippines'),
('Miagao', 49,  'Iloilo', 1,  'Philippines'),
('Mina', 49,  'Iloilo', 1,  'Philippines'),
('New Lucena', 49,  'Iloilo', 1,  'Philippines'),
('Oton', 49,  'Iloilo', 1,  'Philippines'),
('Passi', 49,  'Iloilo', 1,  'Philippines'),
('Pavia', 49,  'Iloilo', 1,  'Philippines'),
('Pototan', 49,  'Iloilo', 1,  'Philippines'),
('San Dionisio', 49,  'Iloilo', 1,  'Philippines'),
('San Enrique', 49,  'Iloilo', 1,  'Philippines'),
('Santa Barbara', 49,  'Iloilo', 1,  'Philippines'),
('Sara', 49,  'Iloilo', 1,  'Philippines'),
('Tigbauan', 49,  'Iloilo', 1,  'Philippines'),
('Tubungan', 49,  'Iloilo', 1,  'Philippines'),
('Zarraga', 49,  'Iloilo', 1,  'Philippines'),
('Angadanan', 50,  'Isabela', 1,  'Philippines'),
('Aurora', 50,  'Isabela', 1,  'Philippines'),
('Benito Soliven', 50,  'Isabela', 1,  'Philippines'),
('Cabagan', 50,  'Isabela', 1,  'Philippines'),
('Cauayan', 50,  'Isabela', 1,  'Philippines'),
('Cordon', 50,  'Isabela', 1,  'Philippines'),
('Delfin Albano', 50,  'Isabela', 1,  'Philippines'),
('Dinapigue', 50,  'Isabela', 1,  'Philippines'),
('Divilacan', 50,  'Isabela', 1,  'Philippines'),
('Echague', 50,  'Isabela', 1,  'Philippines'),
('Gamu', 50,  'Isabela', 1,  'Philippines'),
('Ilagan', 50,  'Isabela', 1,  'Philippines'),
('Jones', 50,  'Isabela', 1,  'Philippines'),
('Maconacon', 50,  'Isabela', 1,  'Philippines'),
('Mallig', 50,  'Isabela', 1,  'Philippines'),
('Ramon', 50,  'Isabela', 1,  'Philippines'),
('Reina Mercedes', 50,  'Isabela', 1,  'Philippines'),
('Roxas', 50,  'Isabela', 1,  'Philippines'),
('San Guillermo', 50,  'Isabela', 1,  'Philippines'),
('San Manuel', 50,  'Isabela', 1,  'Philippines'),
('Santiago City', 50,  'Isabela', 1,  'Philippines'),
('Tumauini', 50,  'Isabela', 1,  'Philippines'),
('Balbalan', 51,  'Kalinga', 1,  'Philippines'),
('Lubuagan', 51,  'Kalinga', 1,  'Philippines'),
('Pinukpuk', 51,  'Kalinga', 1,  'Philippines'),
('Tabuk', 51,  'Kalinga', 1,  'Philippines'),
('Tanudan', 51,  'Kalinga', 1,  'Philippines'),
('Tinglayan', 51,  'Kalinga', 1,  'Philippines'),
('Agoo', 52,  'La Union', 1,  'Philippines'),
('Aringay', 52,  'La Union', 1,  'Philippines'),
('Bacnotan', 52,  'La Union', 1,  'Philippines'),
('Bagulin', 52,  'La Union', 1,  'Philippines'),
('Balaoan', 52,  'La Union', 1,  'Philippines'),
('Bangar', 52,  'La Union', 1,  'Philippines'),
('Bauang', 52,  'La Union', 1,  'Philippines'),
('Caba', 52,  'La Union', 1,  'Philippines'),
('Pugo', 52,  'La Union', 1,  'Philippines'),
('San Gabriel', 52,  'La Union', 1,  'Philippines'),
('Santol', 52,  'La Union', 1,  'Philippines'),
('Sudipen', 52,  'La Union', 1,  'Philippines'),
('Tubao', 52,  'La Union', 1,  'Philippines'),
('Alaminos', 53,  'Laguna', 1,  'Philippines'),
('Bay', 53,  'Laguna', 1,  'Philippines'),
('Biñan', 53,  'Laguna', 1,  'Philippines'),
('Cabuyao', 53,  'Laguna', 1,  'Philippines'),
('Calamba', 53,  'Laguna', 1,  'Philippines'),
('Calauan', 53,  'Laguna', 1,  'Philippines'),
('Cavinti', 53,  'Laguna', 1,  'Philippines'),
('Famy', 53,  'Laguna', 1,  'Philippines'),
('Kalayaan', 53,  'Laguna', 1,  'Philippines'),
('Liliw', 53,  'Laguna', 1,  'Philippines'),
('Los Baños', 53,  'Laguna', 1,  'Philippines'),
('Luisiana', 53,  'Laguna', 1,  'Philippines'),
('Lumban', 53,  'Laguna', 1,  'Philippines'),
('Majayjay', 53,  'Laguna', 1,  'Philippines'),
('Nagcarlan', 53,  'Laguna', 1,  'Philippines'),
('Paete', 53,  'Laguna', 1,  'Philippines'),
('Pagsanjan', 53,  'Laguna', 1,  'Philippines'),
('Pakil', 53,  'Laguna', 1,  'Philippines'),
('Pangil', 53,  'Laguna', 1,  'Philippines'),
('Pila', 53,  'Laguna', 1,  'Philippines'),
('Santa Rosa', 53,  'Laguna', 1,  'Philippines'),
('Siniloan', 53,  'Laguna', 1,  'Philippines'),
('Baloi', 54,  'Lanao del Norte', 1,  'Philippines'),
('Baroy', 54,  'Lanao del Norte', 1,  'Philippines'),
('Iligan City', 54,  'Lanao del Norte', 1,  'Philippines'),
('Kapatagan', 54,  'Lanao del Norte', 1,  'Philippines'),
('Kauswagan', 54,  'Lanao del Norte', 1,  'Philippines'),
('Kolambugan', 54,  'Lanao del Norte', 1,  'Philippines'),
('Lala', 54,  'Lanao del Norte', 1,  'Philippines'),
('Linamon', 54,  'Lanao del Norte', 1,  'Philippines'),
('Maigo', 54,  'Lanao del Norte', 1,  'Philippines'),
('Matungao', 54,  'Lanao del Norte', 1,  'Philippines'),
('Munai', 54,  'Lanao del Norte', 1,  'Philippines'),
('Nunungan', 54,  'Lanao del Norte', 1,  'Philippines'),
('Pantao Ragat', 54,  'Lanao del Norte', 1,  'Philippines'),
('Pantar', 54,  'Lanao del Norte', 1,  'Philippines'),
('Poona Piagapo', 54,  'Lanao del Norte', 1,  'Philippines'),
('Salvador', 54,  'Lanao del Norte', 1,  'Philippines'),
('Sapad', 54,  'Lanao del Norte', 1,  'Philippines'),
('Sultan Naga Dimaporo', 54,  'Lanao del Norte', 1,  'Philippines'),
('Tagoloan', 54,  'Lanao del Norte', 1,  'Philippines'),
('Tangcal', 54,  'Lanao del Norte', 1,  'Philippines'),
('Amai Manabilang', 55,  'Lanao del Sur', 1,  'Philippines'),
('Bacolod-Kalawi', 55,  'Lanao del Sur', 1,  'Philippines'),
('Balabagan', 55,  'Lanao del Sur', 1,  'Philippines'),
('Balindong', 55,  'Lanao del Sur', 1,  'Philippines'),
('Bayang', 55,  'Lanao del Sur', 1,  'Philippines'),
('Binidayan', 55,  'Lanao del Sur', 1,  'Philippines'),
('Buadiposo-Buntong', 55,  'Lanao del Sur', 1,  'Philippines'),
('Bubong', 55,  'Lanao del Sur', 1,  'Philippines'),
('Butig', 55,  'Lanao del Sur', 1,  'Philippines'),
('Calanogas', 55,  'Lanao del Sur', 1,  'Philippines'),
('Ditsaan-Ramain', 55,  'Lanao del Sur', 1,  'Philippines'),
('Ganassi', 55,  'Lanao del Sur', 1,  'Philippines'),
('Kapai', 55,  'Lanao del Sur', 1,  'Philippines'),
('Lumba-Bayabao', 55,  'Lanao del Sur', 1,  'Philippines'),
('Lumbaca-Unayan', 55,  'Lanao del Sur', 1,  'Philippines'),
('Lumbatan', 55,  'Lanao del Sur', 1,  'Philippines'),
('Lumbayanague', 55,  'Lanao del Sur', 1,  'Philippines'),
('Madalum', 55,  'Lanao del Sur', 1,  'Philippines'),
('Madamba', 55,  'Lanao del Sur', 1,  'Philippines'),
('Maguing', 55,  'Lanao del Sur', 1,  'Philippines'),
('Malabang', 55,  'Lanao del Sur', 1,  'Philippines'),
('Marantao', 55,  'Lanao del Sur', 1,  'Philippines'),
('Marawi', 55,  'Lanao del Sur', 1,  'Philippines'),
('Marogong', 55,  'Lanao del Sur', 1,  'Philippines'),
('Masiu', 55,  'Lanao del Sur', 1,  'Philippines'),
('Mulondo', 55,  'Lanao del Sur', 1,  'Philippines'),
('Pagayawan', 55,  'Lanao del Sur', 1,  'Philippines'),
('Piagapo', 55,  'Lanao del Sur', 1,  'Philippines'),
('Picong', 55,  'Lanao del Sur', 1,  'Philippines'),
('Poona Bayabao', 55,  'Lanao del Sur', 1,  'Philippines'),
('Pualas', 55,  'Lanao del Sur', 1,  'Philippines'),
('Saguiaran', 55,  'Lanao del Sur', 1,  'Philippines'),
('Sultan Dumalondong', 55,  'Lanao del Sur', 1,  'Philippines'),
('Tamparan', 55,  'Lanao del Sur', 1,  'Philippines'),
('Taraka', 55,  'Lanao del Sur', 1,  'Philippines'),
('Tubaran', 55,  'Lanao del Sur', 1,  'Philippines'),
('Tugaya', 55,  'Lanao del Sur', 1,  'Philippines'),
('Wao', 55,  'Lanao del Sur', 1,  'Philippines'),
('Abuyog', 56,  'Leyte', 1,  'Philippines'),
('Alangalang', 56,  'Leyte', 1,  'Philippines'),
('Albuera', 56,  'Leyte', 1,  'Philippines'),
('Babatngon', 56,  'Leyte', 1,  'Philippines'),
('Barugo', 56,  'Leyte', 1,  'Philippines'),
('Baybay', 56,  'Leyte', 1,  'Philippines'),
('Burauen', 56,  'Leyte', 1,  'Philippines'),
('Calubian', 56,  'Leyte', 1,  'Philippines'),
('Capoocan', 56,  'Leyte', 1,  'Philippines'),
('Carigara', 56,  'Leyte', 1,  'Philippines'),
('Dagami', 56,  'Leyte', 1,  'Philippines'),
('Dulag', 56,  'Leyte', 1,  'Philippines'),
('Hilongos', 56,  'Leyte', 1,  'Philippines'),
('Hindang', 56,  'Leyte', 1,  'Philippines'),
('Inopacan', 56,  'Leyte', 1,  'Philippines'),
('Isabel', 56,  'Leyte', 1,  'Philippines'),
('Jaro', 56,  'Leyte', 1,  'Philippines'),
('Javier', 56,  'Leyte', 1,  'Philippines'),
('Julita', 56,  'Leyte', 1,  'Philippines'),
('Kananga', 56,  'Leyte', 1,  'Philippines'),
('Leyte', 56,  'Leyte', 1,  'Philippines'),
('MacArthur', 56,  'Leyte', 1,  'Philippines'),
('Mahaplag', 56,  'Leyte', 1,  'Philippines'),
('Matag-ob', 56,  'Leyte', 1,  'Philippines'),
('Matalom', 56,  'Leyte', 1,  'Philippines'),
('Mayorga', 56,  'Leyte', 1,  'Philippines'),
('Merida', 56,  'Leyte', 1,  'Philippines'),
('Ormoc', 56,  'Leyte', 1,  'Philippines'),
('Palo', 56,  'Leyte', 1,  'Philippines'),
('Palompon', 56,  'Leyte', 1,  'Philippines'),
('Pastrana', 56,  'Leyte', 1,  'Philippines'),
('Tabango', 56,  'Leyte', 1,  'Philippines'),
('Tabontabon', 56,  'Leyte', 1,  'Philippines'),
('Tacloban', 56,  'Leyte', 1,  'Philippines'),
('Tolosa', 56,  'Leyte', 1,  'Philippines'),
('Tunga', 56,  'Leyte', 1,  'Philippines'),
('Villaba', 56,  'Leyte', 1,  'Philippines'),
('Barira', 57,  'Maguindanao del Norte', 1,  'Philippines'),
('Buldon', 57,  'Maguindanao del Norte', 1,  'Philippines'),
('Cotabato City', 57,  'Maguindanao del Norte', 1,  'Philippines'),
('Datu Blah T. Sinsuat', 57,  'Maguindanao del Norte', 1,  'Philippines'),
('Datu Odin Sinsuat', 57,  'Maguindanao del Norte', 1,  'Philippines'),
('Kabuntalan', 57,  'Maguindanao del Norte', 1,  'Philippines'),
('Matanog', 57,  'Maguindanao del Norte', 1,  'Philippines'),
('Northern Kabuntalan', 57,  'Maguindanao del Norte', 1,  'Philippines'),
('Parang', 57,  'Maguindanao del Norte', 1,  'Philippines'),
('Sultan Kudarat', 57,  'Maguindanao del Norte', 1,  'Philippines'),
('Sultan Mastura', 57,  'Maguindanao del Norte', 1,  'Philippines'),
('Talitay', 57,  'Maguindanao del Norte', 1,  'Philippines'),
('Upi', 57,  'Maguindanao del Norte', 1,  'Philippines'),
('Ampatuan', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Buluan', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Datu Abdullah Sangki', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Datu Anggal Midtimbang', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Datu Hoffer Ampatuan', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Datu Montawal', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Datu Paglas', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Datu Piang', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Datu Salibo', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Datu Saudi-Ampatuan', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Datu Unsay', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('General Salipada K. Pendatun', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Guindulungan', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Mamasapano', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Mangudadatu', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Pagalungan', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Paglat', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Pandag', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Rajah Buayan', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Shariff Aguak', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Shariff Saydona Mustapha', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('South Upi', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Sultan sa Barongis', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Talayan', 58,  'Maguindanao del Sur', 1,  'Philippines'),
('Boac', 59,  'Marinduque', 1,  'Philippines'),
('Gasan', 59,  'Marinduque', 1,  'Philippines'),
('Mogpog', 59,  'Marinduque', 1,  'Philippines'),
('Torrijos', 59,  'Marinduque', 1,  'Philippines'),
('Aroroy', 60,  'Masbate', 1,  'Philippines'),
('Baleno', 60,  'Masbate', 1,  'Philippines'),
('Balud', 60,  'Masbate', 1,  'Philippines'),
('Batuan', 60,  'Masbate', 1,  'Philippines'),
('Cataingan', 60,  'Masbate', 1,  'Philippines'),
('Cawayan', 60,  'Masbate', 1,  'Philippines'),
('Claveria', 60,  'Masbate', 1,  'Philippines'),
('Dimasalang', 60,  'Masbate', 1,  'Philippines'),
('Mandaon', 60,  'Masbate', 1,  'Philippines'),
('Masbate', 60,  'Masbate', 1,  'Philippines'),
('Milagros', 60,  'Masbate', 1,  'Philippines'),
('Mobo', 60,  'Masbate', 1,  'Philippines'),
('Monreal', 60,  'Masbate', 1,  'Philippines'),
('Palanas', 60,  'Masbate', 1,  'Philippines'),
('Pio V. Corpus', 60,  'Masbate', 1,  'Philippines'),
('Placer', 60,  'Masbate', 1,  'Philippines'),
('San Jacinto', 60,  'Masbate', 1,  'Philippines'),
('Aloran', 62,  'Misamis Occidental', 1,  'Philippines'),
('Baliangao', 62,  'Misamis Occidental', 1,  'Philippines'),
('Bonifacio', 62,  'Misamis Occidental', 1,  'Philippines'),
('Clarin', 62,  'Misamis Occidental', 1,  'Philippines'),
('Don Victoriano Chiongbian', 62,  'Misamis Occidental', 1,  'Philippines'),
('Jimenez', 62,  'Misamis Occidental', 1,  'Philippines'),
('Lopez Jaena', 62,  'Misamis Occidental', 1,  'Philippines'),
('Oroquieta', 62,  'Misamis Occidental', 1,  'Philippines'),
('Ozamiz City', 62,  'Misamis Occidental', 1,  'Philippines'),
('Panaon', 62,  'Misamis Occidental', 1,  'Philippines'),
('Sapang Dalaga', 62,  'Misamis Occidental', 1,  'Philippines'),
('Sinacaban', 62,  'Misamis Occidental', 1,  'Philippines'),
('Tangub', 62,  'Misamis Occidental', 1,  'Philippines'),
('Alubijid', 63,  'Misamis Oriental', 1,  'Philippines'),
('Balingasag', 63,  'Misamis Oriental', 1,  'Philippines'),
('Balingoan', 63,  'Misamis Oriental', 1,  'Philippines'),
('Binuangan', 63,  'Misamis Oriental', 1,  'Philippines'),
('Cagayan de Oro', 63,  'Misamis Oriental', 1,  'Philippines'),
('El Salvador', 63,  'Misamis Oriental', 1,  'Philippines'),
('Gingoog', 63,  'Misamis Oriental', 1,  'Philippines'),
('Gitagum', 63,  'Misamis Oriental', 1,  'Philippines'),
('Initao', 63,  'Misamis Oriental', 1,  'Philippines'),
('Jasaan', 63,  'Misamis Oriental', 1,  'Philippines'),
('Kinoguitan', 63,  'Misamis Oriental', 1,  'Philippines'),
('Lagonglong', 63,  'Misamis Oriental', 1,  'Philippines'),
('Laguindingan', 63,  'Misamis Oriental', 1,  'Philippines'),
('Lugait', 63,  'Misamis Oriental', 1,  'Philippines'),
('Manticao', 63,  'Misamis Oriental', 1,  'Philippines'),
('Medina', 63,  'Misamis Oriental', 1,  'Philippines'),
('Naawan', 63,  'Misamis Oriental', 1,  'Philippines'),
('Opol', 63,  'Misamis Oriental', 1,  'Philippines'),
('Salay', 63,  'Misamis Oriental', 1,  'Philippines'),
('Sugbongcogon', 63,  'Misamis Oriental', 1,  'Philippines'),
('Talisayan', 63,  'Misamis Oriental', 1,  'Philippines'),
('Villanueva', 63,  'Misamis Oriental', 1,  'Philippines'),
('Barlig', 64,  'Mountain Province', 1,  'Philippines'),
('Bauko', 64,  'Mountain Province', 1,  'Philippines'),
('Besao', 64,  'Mountain Province', 1,  'Philippines'),
('Bontoc', 64,  'Mountain Province', 1,  'Philippines'),
('Natonin', 64,  'Mountain Province', 1,  'Philippines'),
('Paracelis', 64,  'Mountain Province', 1,  'Philippines'),
('Sabangan', 64,  'Mountain Province', 1,  'Philippines'),
('Sadanga', 64,  'Mountain Province', 1,  'Philippines'),
('Sagada', 64,  'Mountain Province', 1,  'Philippines'),
('Tadian', 64,  'Mountain Province', 1,  'Philippines'),
('Bago', 66,  'Negros Occidental', 1,  'Philippines'),
('Binalbagan', 66,  'Negros Occidental', 1,  'Philippines'),
('Cadiz', 66,  'Negros Occidental', 1,  'Philippines'),
('Calatrava', 66,  'Negros Occidental', 1,  'Philippines'),
('Candoni', 66,  'Negros Occidental', 1,  'Philippines'),
('Don Salvador Benedicto', 66,  'Negros Occidental', 1,  'Philippines'),
('Enrique B. Magalona', 66,  'Negros Occidental', 1,  'Philippines'),
('Escalante', 66,  'Negros Occidental', 1,  'Philippines'),
('Himamaylan', 66,  'Negros Occidental', 1,  'Philippines'),
('Hinigaran', 66,  'Negros Occidental', 1,  'Philippines'),
('Hinoba-an', 66,  'Negros Occidental', 1,  'Philippines'),
('Ilog', 66,  'Negros Occidental', 1,  'Philippines'),
('Kabankalan', 66,  'Negros Occidental', 1,  'Philippines'),
('La Carlota', 66,  'Negros Occidental', 1,  'Philippines'),
('La Castellana', 66,  'Negros Occidental', 1,  'Philippines'),
('Manapla', 66,  'Negros Occidental', 1,  'Philippines'),
('Moises Padilla', 66,  'Negros Occidental', 1,  'Philippines'),
('Murcia', 66,  'Negros Occidental', 1,  'Philippines'),
('Pulupandan', 66,  'Negros Occidental', 1,  'Philippines'),
('San Carlos', 66,  'Negros Occidental', 1,  'Philippines'),
('Silay', 66,  'Negros Occidental', 1,  'Philippines'),
('Sipalay', 66,  'Negros Occidental', 1,  'Philippines'),
('Toboso', 66,  'Negros Occidental', 1,  'Philippines'),
('Valladolid', 66,  'Negros Occidental', 1,  'Philippines'),
('Victorias', 66,  'Negros Occidental', 1,  'Philippines'),
('Amlan', 67,  'Negros Oriental', 1,  'Philippines'),
('Ayungon', 67,  'Negros Oriental', 1,  'Philippines'),
('Bacong', 67,  'Negros Oriental', 1,  'Philippines'),
('Bais', 67,  'Negros Oriental', 1,  'Philippines'),
('Basay', 67,  'Negros Oriental', 1,  'Philippines'),
('Bayawan', 67,  'Negros Oriental', 1,  'Philippines'),
('Bindoy', 67,  'Negros Oriental', 1,  'Philippines'),
('Canlaon', 67,  'Negros Oriental', 1,  'Philippines'),
('Dauin', 67,  'Negros Oriental', 1,  'Philippines'),
('Dumaguete', 67,  'Negros Oriental', 1,  'Philippines'),
('Guihulñgan', 67,  'Negros Oriental', 1,  'Philippines'),
('Jimalalud', 67,  'Negros Oriental', 1,  'Philippines'),
('Manjuyod', 67,  'Negros Oriental', 1,  'Philippines'),
('Siaton', 67,  'Negros Oriental', 1,  'Philippines'),
('Sibulan', 67,  'Negros Oriental', 1,  'Philippines'),
('Tanjay', 67,  'Negros Oriental', 1,  'Philippines'),
('Tayasan', 67,  'Negros Oriental', 1,  'Philippines'),
('Vallehermoso', 67,  'Negros Oriental', 1,  'Philippines'),
('Zamboanguita', 67,  'Negros Oriental', 1,  'Philippines'),
('Allen', 69,  'Northern Samar', 1,  'Philippines'),
('Biri', 69,  'Northern Samar', 1,  'Philippines'),
('Bobon', 69,  'Northern Samar', 1,  'Philippines'),
('Capul', 69,  'Northern Samar', 1,  'Philippines'),
('Catubig', 69,  'Northern Samar', 1,  'Philippines'),
('Gamay', 69,  'Northern Samar', 1,  'Philippines'),
('Laoang', 69,  'Northern Samar', 1,  'Philippines'),
('Lapinig', 69,  'Northern Samar', 1,  'Philippines'),
('Las Navas', 69,  'Northern Samar', 1,  'Philippines'),
('Lavezares', 69,  'Northern Samar', 1,  'Philippines'),
('Lope de Vega', 69,  'Northern Samar', 1,  'Philippines'),
('Mapanas', 69,  'Northern Samar', 1,  'Philippines'),
('Mondragon', 69,  'Northern Samar', 1,  'Philippines'),
('Palapag', 69,  'Northern Samar', 1,  'Philippines'),
('Pambujan', 69,  'Northern Samar', 1,  'Philippines'),
('Silvino Lobos', 69,  'Northern Samar', 1,  'Philippines'),
('Aliaga', 70,  'Nueva Ecija', 1,  'Philippines'),
('Bongabon', 70,  'Nueva Ecija', 1,  'Philippines'),
('Cabanatuan', 70,  'Nueva Ecija', 1,  'Philippines'),
('Cabiao', 70,  'Nueva Ecija', 1,  'Philippines'),
('Carranglan', 70,  'Nueva Ecija', 1,  'Philippines'),
('Cuyapo', 70,  'Nueva Ecija', 1,  'Philippines'),
('Gabaldon', 70,  'Nueva Ecija', 1,  'Philippines'),
('Gapan', 70,  'Nueva Ecija', 1,  'Philippines'),
('General Mamerto Natividad', 70,  'Nueva Ecija', 1,  'Philippines'),
('General Tinio', 70,  'Nueva Ecija', 1,  'Philippines'),
('Guimba', 70,  'Nueva Ecija', 1,  'Philippines'),
('Jaen', 70,  'Nueva Ecija', 1,  'Philippines'),
('Laur', 70,  'Nueva Ecija', 1,  'Philippines'),
('Licab', 70,  'Nueva Ecija', 1,  'Philippines'),
('Llanera', 70,  'Nueva Ecija', 1,  'Philippines'),
('Lupao', 70,  'Nueva Ecija', 1,  'Philippines'),
('Muñoz', 70,  'Nueva Ecija', 1,  'Philippines'),
('Nampicuan', 70,  'Nueva Ecija', 1,  'Philippines'),
('Palayan', 70,  'Nueva Ecija', 1,  'Philippines'),
('Pantabangan', 70,  'Nueva Ecija', 1,  'Philippines'),
('Peñaranda', 70,  'Nueva Ecija', 1,  'Philippines'),
('San Leonardo', 70,  'Nueva Ecija', 1,  'Philippines'),
('Talavera', 70,  'Nueva Ecija', 1,  'Philippines'),
('Talugtug', 70,  'Nueva Ecija', 1,  'Philippines'),
('Zaragoza', 70,  'Nueva Ecija', 1,  'Philippines'),
('Alfonso Castañeda', 71,  'Nueva Vizcaya', 1,  'Philippines'),
('Ambaguio', 71,  'Nueva Vizcaya', 1,  'Philippines'),
('Aritao', 71,  'Nueva Vizcaya', 1,  'Philippines'),
('Bagabag', 71,  'Nueva Vizcaya', 1,  'Philippines'),
('Bambang', 71,  'Nueva Vizcaya', 1,  'Philippines'),
('Bayombong', 71,  'Nueva Vizcaya', 1,  'Philippines'),
('Diadi', 71,  'Nueva Vizcaya', 1,  'Philippines'),
('Dupax del Norte', 71,  'Nueva Vizcaya', 1,  'Philippines'),
('Dupax del Sur', 71,  'Nueva Vizcaya', 1,  'Philippines'),
('Kasibu', 71,  'Nueva Vizcaya', 1,  'Philippines'),
('Kayapa', 71,  'Nueva Vizcaya', 1,  'Philippines'),
('Solano', 71,  'Nueva Vizcaya', 1,  'Philippines'),
('Villaverde', 71,  'Nueva Vizcaya', 1,  'Philippines'),
('Abuyon', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Aga', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Aliang', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Alupay', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Aya', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Ayusan Uno', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bagalangit', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bagombong', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bagong Pagasa', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bagupaye', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Balagtasin', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Balele', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Balibago', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Balite Segundo', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Balitoc', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Banaba', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Banalo', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bantilan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Banugao', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Batas', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bautista', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Baybayin', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bignay Uno', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bilaran', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bilog-Bilog', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Binahaan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Binay', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Binubusan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Binulasan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bitangan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bitin', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bolboc', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Boot', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bosdak', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bugaan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bukal', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bukal Sur', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bulacnin', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bungahan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Bungoy', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Cabatang', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Cagsiay', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Calilayan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Calubcub Dos', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Cambuga', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Camohaguin', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Camp Flora', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Capuluan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Castañas', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Casuguran', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Cigaras', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Concepcion Ibaba', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Dagatan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Daraitan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Dayap', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Dayapan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Del Monte', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Dinahican', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Guinayangan Fourth District of Quezon', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Gulod', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Gumian', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Guyam Malaki', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Halayhay', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Halayhayin', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Haligue', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Hondagua', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Hukay', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Ibabang Tayuman', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Inicbulan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Isabang', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Janagdong', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Janopol', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Javalera', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Kabulusan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Kanluran', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Kapatalan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Karligan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Kaytitinga', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Kiloloran', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Kinalaglagan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Kinatakutan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Lacdayan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Laiya', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Lalig', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Lapolapo', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Libato', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Lilio', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Lipa City', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Lipahan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Lucsuhin', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Luksuhin', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Lumbang', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Lumbangan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Lumil', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Luntal', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Lusacan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Mabitac', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Mabunga', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Macalamcam A', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Madulao', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Maguyam', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Mahabang Parang', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Mainit Norte', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Malabag', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Malabanan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Malabanban Norte', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Malainen Luma', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Malanday', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Malaruhatan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Malaya', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Malicboy', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Malinao Ilaya', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Mamala', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Mamatid', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Mangas', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Mangero', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Manggahan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Mapulo', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Mapulot', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Marao', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Masalukot Uno', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Masapang', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Masaya', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Mataas Na Kahoy', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Matagbak', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Matala', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Mataywanac', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Matingain', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Maugat West', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Maulawin', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Mendez-Nuñez', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Montecillo', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Mozon', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Mulauin', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Navotas', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Paagahan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Pagsañgahan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Paiisa', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Palahanan Uno', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Palangue', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Pangao', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Panikihan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Pansol', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Pansoy', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Pantay Na Matanda', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Pantijan No 2', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Paradahan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Pasong Kawayan Primero', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Patabog', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Patuto', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Payapa', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Pinagsibaan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Pinugay', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Poctol', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Prinza', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Progreso', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Pulangbato', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Pulong Santa Cruz', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Puting Kahoy', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Putol', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Quilo-quilo', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Quisao', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Sampiro', 72,  'Occidental Mindoro', 1,  'Philippines'),
('San Celestio', 72,  'Occidental Mindoro', 1,  'Philippines'),
('San Diego', 72,  'Occidental Mindoro', 1,  'Philippines'),
('San Gregorio', 72,  'Occidental Mindoro', 1,  'Philippines'),
('San Pedro One', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Santa Catalina Norte', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Santa Catalina Sur', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Santa Cecilia', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Santa Rita Aplaya', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Santisimo Rosario', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Santor', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Sico Uno', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Silongin', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Sinala', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Sinisian', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Solo', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Tagbacan Ibaba', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Tagkawayan Sabang', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Tala', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Talahib Payap', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Talahiban I', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Talaibon', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Talipan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Tayabas Ibaba', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Taywanak Ilaya', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Tignoan', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Tipaz', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Toong', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Tranca', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Tuhian', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Tulay', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Tumalim', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Wawa', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Yuni', 72,  'Occidental Mindoro', 1,  'Philippines'),
('Abra de Ilog', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Adela', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Agcogon', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Alad', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Alemanguan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Algeciras', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Alibug', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Apitong', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Apurawan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Aramawayan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Aramayuan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Babug', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Baco', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Bacungan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Bagong Sikat', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Baheli', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Balanacan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Balatero', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Balugo', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Banos', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Bansud', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Barahan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Barong Barong', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Batarasa', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Bayuin', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Bintacay', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Bunog', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Burirao', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Buyabod', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Cabacao', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Cabra', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Cagayan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Caigangan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Cajimos', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Calamundingan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Calapan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Calatugas', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Calintaan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Caminauit', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Cantel', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Canubing No 2', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Caramay', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Caruray', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Casian', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Conduaga', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Dapawan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Daykitin', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Dobdoban', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Eraan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('España', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Evangelista', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Gabawan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Gloria', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Guinlo', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Harrison', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Ipilan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Irahuan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Iraray', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Irirum', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Isugod', 73,  'Oriental Mindoro', 1,  'Philippines'),
('La Curva', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Labasan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Labog', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Laylay', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Leuteboro', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Limanancong', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Lubang', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Lumangbayan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Magbay', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Malamig', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Malibago', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Maliig', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Malitbog', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Maluanluan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Mamburao', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Manaul', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Mangarine', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Mansalay', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Masaguisi', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Masiga', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Mauhao', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Nagiba', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Naujan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('New Agutaya', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Odala', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Paclolo', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Paluan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Pambisan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Panacan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Panalingaan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Pancol', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Pañgobilian', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Pangulayan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Panique', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Panitian', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Panlaitan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Pato-o', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Pinagsabangan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Pinamalayan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Pola', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Port Barton', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Puerto Galera', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Punang', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Quinabigan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Ransang', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Rio Tuba', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Saaban', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Sablayan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('San Aquilino', 73,  'Oriental Mindoro', 1,  'Philippines'),
('San Teodoro', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Santa Brigida', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Saraza', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Suba', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Sumagui', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tabinay', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tacligan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Taclobo', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tagbak', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tagbita', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tagburos', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tagusao', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tambong', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tampayan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tangal', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tarusan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tayaman', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tigui', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tiguion', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tiguisan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tilik', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tiniguiban', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tomingad', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tugdan', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Tumarbong', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Vigo', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Yook', 73,  'Oriental Mindoro', 1,  'Philippines'),
('Aborlan', 74,  'Palawan', 1,  'Philippines'),
('Agutaya', 74,  'Palawan', 1,  'Philippines'),
('Araceli', 74,  'Palawan', 1,  'Philippines'),
('Balabac', 74,  'Palawan', 1,  'Philippines'),
('Bataraza', 74,  'Palawan', 1,  'Philippines'),
('Brookes Point', 74,  'Palawan', 1,  'Philippines'),
('Busuanga', 74,  'Palawan', 1,  'Philippines'),
('Cagayancillo', 74,  'Palawan', 1,  'Philippines'),
('Coron', 74,  'Palawan', 1,  'Philippines'),
('Culion', 74,  'Palawan', 1,  'Philippines'),
('Cuyo', 74,  'Palawan', 1,  'Philippines'),
('Dumaran', 74,  'Palawan', 1,  'Philippines'),
('El Nido', 74,  'Palawan', 1,  'Philippines'),
('Linapacan', 74,  'Palawan', 1,  'Philippines'),
('Narra', 74,  'Palawan', 1,  'Philippines'),
('Puerto Princesa', 74,  'Palawan', 1,  'Philippines'),
('Sofronio Española', 74,  'Palawan', 1,  'Philippines'),
('Taytay', 74,  'Palawan', 1,  'Philippines'),
('Angeles City', 75,  'Pampanga', 1,  'Philippines'),
('Apalit', 75,  'Pampanga', 1,  'Philippines'),
('Arayat', 75,  'Pampanga', 1,  'Philippines'),
('Bacolor', 75,  'Pampanga', 1,  'Philippines'),
('Candaba', 75,  'Pampanga', 1,  'Philippines'),
('Floridablanca', 75,  'Pampanga', 1,  'Philippines'),
('Guagua', 75,  'Pampanga', 1,  'Philippines'),
('Lubao', 75,  'Pampanga', 1,  'Philippines'),
('Mabalacat', 75,  'Pampanga', 1,  'Philippines'),
('Macabebe', 75,  'Pampanga', 1,  'Philippines'),
('Magalang', 75,  'Pampanga', 1,  'Philippines'),
('Masantol', 75,  'Pampanga', 1,  'Philippines'),
('Mexico', 75,  'Pampanga', 1,  'Philippines'),
('Minalin', 75,  'Pampanga', 1,  'Philippines'),
('Porac', 75,  'Pampanga', 1,  'Philippines'),
('San Simon', 75,  'Pampanga', 1,  'Philippines'),
('Sasmuan', 75,  'Pampanga', 1,  'Philippines'),
('Agno', 76,  'Pangasinan', 1,  'Philippines'),
('Aguilar', 76,  'Pangasinan', 1,  'Philippines'),
('Alcala', 76,  'Pangasinan', 1,  'Philippines'),
('Anda', 76,  'Pangasinan', 1,  'Philippines'),
('Asingan', 76,  'Pangasinan', 1,  'Philippines'),
('Balungao', 76,  'Pangasinan', 1,  'Philippines'),
('Bani', 76,  'Pangasinan', 1,  'Philippines'),
('Basista', 76,  'Pangasinan', 1,  'Philippines'),
('Bayambang', 76,  'Pangasinan', 1,  'Philippines'),
('Binalonan', 76,  'Pangasinan', 1,  'Philippines'),
('Binmaley', 76,  'Pangasinan', 1,  'Philippines'),
('Bolinao', 76,  'Pangasinan', 1,  'Philippines'),
('Bugallon', 76,  'Pangasinan', 1,  'Philippines'),
('Calasiao', 76,  'Pangasinan', 1,  'Philippines'),
('Dagupan', 76,  'Pangasinan', 1,  'Philippines'),
('Dasol', 76,  'Pangasinan', 1,  'Philippines'),
('Infanta', 76,  'Pangasinan', 1,  'Philippines'),
('Labrador', 76,  'Pangasinan', 1,  'Philippines'),
('Laoac', 76,  'Pangasinan', 1,  'Philippines'),
('Lingayen', 76,  'Pangasinan', 1,  'Philippines'),
('Malasiqui', 76,  'Pangasinan', 1,  'Philippines'),
('Manaoag', 76,  'Pangasinan', 1,  'Philippines'),
('Mangaldan', 76,  'Pangasinan', 1,  'Philippines'),
('Mangatarem', 76,  'Pangasinan', 1,  'Philippines'),
('Mapandan', 76,  'Pangasinan', 1,  'Philippines'),
('Natividad', 76,  'Pangasinan', 1,  'Philippines'),
('Pozorrubio', 76,  'Pangasinan', 1,  'Philippines'),
('Rosales', 76,  'Pangasinan', 1,  'Philippines'),
('San Fabian', 76,  'Pangasinan', 1,  'Philippines'),
('Sison', 76,  'Pangasinan', 1,  'Philippines'),
('Sual', 76,  'Pangasinan', 1,  'Philippines'),
('Tayug', 76,  'Pangasinan', 1,  'Philippines'),
('Umingan', 76,  'Pangasinan', 1,  'Philippines'),
('Urbiztondo', 76,  'Pangasinan', 1,  'Philippines'),
('Urdaneta', 76,  'Pangasinan', 1,  'Philippines'),
('Villasis', 76,  'Pangasinan', 1,  'Philippines'),
('Agdangan', 77,  'Quezon', 1,  'Philippines'),
('Alabat', 77,  'Quezon', 1,  'Philippines'),
('Atimonan', 77,  'Quezon', 1,  'Philippines'),
('Burdeos', 77,  'Quezon', 1,  'Philippines'),
('Calauag', 77,  'Quezon', 1,  'Philippines'),
('Candelaria', 77,  'Quezon', 1,  'Philippines'),
('Catanauan', 77,  'Quezon', 1,  'Philippines'),
('General Luna', 77,  'Quezon', 1,  'Philippines'),
('General Nakar', 77,  'Quezon', 1,  'Philippines'),
('Guinayangan', 77,  'Quezon', 1,  'Philippines'),
('Gumaca', 77,  'Quezon', 1,  'Philippines'),
('Jomalig', 77,  'Quezon', 1,  'Philippines'),
('Lopez', 77,  'Quezon', 1,  'Philippines'),
('Lucban', 77,  'Quezon', 1,  'Philippines'),
('Lucena', 77,  'Quezon', 1,  'Philippines'),
('Macalelon', 77,  'Quezon', 1,  'Philippines'),
('Mauban', 77,  'Quezon', 1,  'Philippines'),
('Mulanay', 77,  'Quezon', 1,  'Philippines'),
('Padre Burgos', 77,  'Quezon', 1,  'Philippines'),
('Pagbilao', 77,  'Quezon', 1,  'Philippines'),
('Panukulan', 77,  'Quezon', 1,  'Philippines'),
('Patnanungan', 77,  'Quezon', 1,  'Philippines'),
('Perez', 77,  'Quezon', 1,  'Philippines'),
('Pitogo', 77,  'Quezon', 1,  'Philippines'),
('Polillo', 77,  'Quezon', 1,  'Philippines'),
('Real', 77,  'Quezon', 1,  'Philippines'),
('Sampaloc', 77,  'Quezon', 1,  'Philippines'),
('San Narciso', 77,  'Quezon', 1,  'Philippines'),
('Sariaya', 77,  'Quezon', 1,  'Philippines'),
('Tagkawayan', 77,  'Quezon', 1,  'Philippines'),
('Tayabas', 77,  'Quezon', 1,  'Philippines'),
('Tiaong', 77,  'Quezon', 1,  'Philippines'),
('Unisan', 77,  'Quezon', 1,  'Philippines'),
('Aglipay', 78,  'Quirino', 1,  'Philippines'),
('Cabarroguis', 78,  'Quirino', 1,  'Philippines'),
('Diffun', 78,  'Quirino', 1,  'Philippines'),
('Maddela', 78,  'Quirino', 1,  'Philippines'),
('Nagtipunan', 78,  'Quirino', 1,  'Philippines'),
('Saguday', 78,  'Quirino', 1,  'Philippines'),
('Angono', 79,  'Rizal', 1,  'Philippines'),
('Antipolo', 79,  'Rizal', 1,  'Philippines'),
('Binangonan', 79,  'Rizal', 1,  'Philippines'),
('Cainta', 79,  'Rizal', 1,  'Philippines'),
('Cardona', 79,  'Rizal', 1,  'Philippines'),
('Jalajala', 79,  'Rizal', 1,  'Philippines'),
('Morong', 79,  'Rizal', 1,  'Philippines'),
('Pililla', 79,  'Rizal', 1,  'Philippines'),
('Rodriguez', 79,  'Rizal', 1,  'Philippines'),
('Tanay', 79,  'Rizal', 1,  'Philippines'),
('Teresa', 79,  'Rizal', 1,  'Philippines'),
('Banton', 80,  'Romblon', 1,  'Philippines'),
('Cajidiocan', 80,  'Romblon', 1,  'Philippines'),
('Corcuera', 80,  'Romblon', 1,  'Philippines'),
('Ferrol', 80,  'Romblon', 1,  'Philippines'),
('Magdiwang', 80,  'Romblon', 1,  'Philippines'),
('Odiongan', 80,  'Romblon', 1,  'Philippines'),
('Romblon', 80,  'Romblon', 1,  'Philippines'),
('Alabel', 81,  'Sarangani', 1,  'Philippines'),
('Glan', 81,  'Sarangani', 1,  'Philippines'),
('Kiamba', 81,  'Sarangani', 1,  'Philippines'),
('Maasim', 81,  'Sarangani', 1,  'Philippines'),
('Maitum', 81,  'Sarangani', 1,  'Philippines'),
('Malapatan', 81,  'Sarangani', 1,  'Philippines'),
('Malungon', 81,  'Sarangani', 1,  'Philippines'),
('Enrique Villanueva', 82,  'Siquijor', 1,  'Philippines'),
('Larena', 82,  'Siquijor', 1,  'Philippines'),
('Lazi', 82,  'Siquijor', 1,  'Philippines'),
('Maria', 82,  'Siquijor', 1,  'Philippines'),
('Siquijor', 82,  'Siquijor', 1,  'Philippines'),
('Biwang', 83,  'Soccsksargen', 1,  'Philippines'),
('Blingkong', 83,  'Soccsksargen', 1,  'Philippines'),
('Buawan', 83,  'Soccsksargen', 1,  'Philippines'),
('Bukay Pait', 83,  'Soccsksargen', 1,  'Philippines'),
('Busok', 83,  'Soccsksargen', 1,  'Philippines'),
('Carpenter Hill', 83,  'Soccsksargen', 1,  'Philippines'),
('Colongulo', 83,  'Soccsksargen', 1,  'Philippines'),
('Columbio', 83,  'Soccsksargen', 1,  'Philippines'),
('Conel', 83,  'Soccsksargen', 1,  'Philippines'),
('Daguma', 83,  'Soccsksargen', 1,  'Philippines'),
('Dansuli', 83,  'Soccsksargen', 1,  'Philippines'),
('Digkilaan', 83,  'Soccsksargen', 1,  'Philippines'),
('Dukay', 83,  'Soccsksargen', 1,  'Philippines'),
('Dumaguil', 83,  'Soccsksargen', 1,  'Philippines'),
('Gansing', 83,  'Soccsksargen', 1,  'Philippines'),
('Guinsang-an', 83,  'Soccsksargen', 1,  'Philippines'),
('Kalandagan', 83,  'Soccsksargen', 1,  'Philippines'),
('Kapaya', 83,  'Soccsksargen', 1,  'Philippines'),
('Kapingkong', 83,  'Soccsksargen', 1,  'Philippines'),
('Katangawan', 83,  'Soccsksargen', 1,  'Philippines'),
('Kipalbig', 83,  'Soccsksargen', 1,  'Philippines'),
('Kolumbug', 83,  'Soccsksargen', 1,  'Philippines'),
('Kudanding', 83,  'Soccsksargen', 1,  'Philippines'),
('Laguilayan', 83,  'Soccsksargen', 1,  'Philippines'),
('Lamba', 83,  'Soccsksargen', 1,  'Philippines'),
('Lampari', 83,  'Soccsksargen', 1,  'Philippines'),
('Lapuz', 83,  'Soccsksargen', 1,  'Philippines'),
('Linan', 83,  'Soccsksargen', 1,  'Philippines'),
('Maindang', 83,  'Soccsksargen', 1,  'Philippines'),
('Malandag', 83,  'Soccsksargen', 1,  'Philippines'),
('Maltana', 83,  'Soccsksargen', 1,  'Philippines'),
('Maluñgun', 83,  'Soccsksargen', 1,  'Philippines'),
('Mamali', 83,  'Soccsksargen', 1,  'Philippines'),
('Matiompong', 83,  'Soccsksargen', 1,  'Philippines'),
('New Lagao', 83,  'Soccsksargen', 1,  'Philippines'),
('New Panay', 83,  'Soccsksargen', 1,  'Philippines'),
('Nunguan', 83,  'Soccsksargen', 1,  'Philippines'),
('Palian', 83,  'Soccsksargen', 1,  'Philippines'),
('Pamantingan', 83,  'Soccsksargen', 1,  'Philippines'),
('Rogongon', 83,  'Soccsksargen', 1,  'Philippines'),
('Rotonda', 83,  'Soccsksargen', 1,  'Philippines'),
('Sadsalan', 83,  'Soccsksargen', 1,  'Philippines'),
('Sangay', 83,  'Soccsksargen', 1,  'Philippines'),
('Tambak', 83,  'Soccsksargen', 1,  'Philippines'),
('Tamnag', 83,  'Soccsksargen', 1,  'Philippines'),
('Tamontaka', 83,  'Soccsksargen', 1,  'Philippines'),
('Telafas', 83,  'Soccsksargen', 1,  'Philippines'),
('Tinagacan', 83,  'Soccsksargen', 1,  'Philippines'),
('Tuka', 83,  'Soccsksargen', 1,  'Philippines'),
('Villamor', 83,  'Soccsksargen', 1,  'Philippines'),
('Barcelona', 84,  'Sorsogon', 1,  'Philippines'),
('Bulan', 84,  'Sorsogon', 1,  'Philippines'),
('Bulusan', 84,  'Sorsogon', 1,  'Philippines'),
('Castilla', 84,  'Sorsogon', 1,  'Philippines'),
('Donsol', 84,  'Sorsogon', 1,  'Philippines'),
('Gubat', 84,  'Sorsogon', 1,  'Philippines'),
('Irosin', 84,  'Sorsogon', 1,  'Philippines'),
('Juban', 84,  'Sorsogon', 1,  'Philippines'),
('Matnog', 84,  'Sorsogon', 1,  'Philippines'),
('Prieto Diaz', 84,  'Sorsogon', 1,  'Philippines'),
('Santa Magdalena', 84,  'Sorsogon', 1,  'Philippines'),
('Sorsogon', 84,  'Sorsogon', 1,  'Philippines'),
('General Santos', 85,  'South Cotabato', 1,  'Philippines'),
('Koronadal', 85,  'South Cotabato', 1,  'Philippines'),
('Lake Sebu', 85,  'South Cotabato', 1,  'Philippines'),
('Norala', 85,  'South Cotabato', 1,  'Philippines'),
('Polomolok', 85,  'South Cotabato', 1,  'Philippines'),
('Surallah', 85,  'South Cotabato', 1,  'Philippines'),
('Tampakan', 85,  'South Cotabato', 1,  'Philippines'),
('Tantangan', 85,  'South Cotabato', 1,  'Philippines'),
('Tupi', 85,  'South Cotabato', 1,  'Philippines'),
('Anahawan', 86,  'Southern Leyte', 1,  'Philippines'),
('Hinunangan', 86,  'Southern Leyte', 1,  'Philippines'),
('Hinundayan', 86,  'Southern Leyte', 1,  'Philippines'),
('Libagon', 86,  'Southern Leyte', 1,  'Philippines'),
('Limasawa', 86,  'Southern Leyte', 1,  'Philippines'),
('Macrohon', 86,  'Southern Leyte', 1,  'Philippines'),
('Pintuyan', 86,  'Southern Leyte', 1,  'Philippines'),
('Saint Bernard', 86,  'Southern Leyte', 1,  'Philippines'),
('San Ricardo', 86,  'Southern Leyte', 1,  'Philippines'),
('Silago', 86,  'Southern Leyte', 1,  'Philippines'),
('Tomas Oppus', 86,  'Southern Leyte', 1,  'Philippines'),
('Isulan', 87,  'Sultan Kudarat', 1,  'Philippines'),
('Kalamansig', 87,  'Sultan Kudarat', 1,  'Philippines'),
('Lambayong', 87,  'Sultan Kudarat', 1,  'Philippines'),
('Lebak', 87,  'Sultan Kudarat', 1,  'Philippines'),
('Lutayan', 87,  'Sultan Kudarat', 1,  'Philippines'),
('Palimbang', 87,  'Sultan Kudarat', 1,  'Philippines'),
('President Quirino', 87,  'Sultan Kudarat', 1,  'Philippines'),
('Senator Ninoy Aquino', 87,  'Sultan Kudarat', 1,  'Philippines'),
('Tacurong', 87,  'Sultan Kudarat', 1,  'Philippines'),
('Banguingui', 88,  'Sulu', 1,  'Philippines'),
('Hadji Panglima Tahil', 88,  'Sulu', 1,  'Philippines'),
('Indanan', 88,  'Sulu', 1,  'Philippines'),
('Jolo', 88,  'Sulu', 1,  'Philippines'),
('Kalingalan Caluang', 88,  'Sulu', 1,  'Philippines'),
('Lugus', 88,  'Sulu', 1,  'Philippines'),
('Luuk', 88,  'Sulu', 1,  'Philippines'),
('Maimbung', 88,  'Sulu', 1,  'Philippines'),
('Omar', 88,  'Sulu', 1,  'Philippines'),
('Panamao', 88,  'Sulu', 1,  'Philippines'),
('Pandami', 88,  'Sulu', 1,  'Philippines'),
('Panglima Estino', 88,  'Sulu', 1,  'Philippines'),
('Pangutaran', 88,  'Sulu', 1,  'Philippines'),
('Patikul', 88,  'Sulu', 1,  'Philippines'),
('Siasi', 88,  'Sulu', 1,  'Philippines'),
('Talipao', 88,  'Sulu', 1,  'Philippines'),
('Tapul', 88,  'Sulu', 1,  'Philippines'),
('Bacuag', 89,  'Surigao del Norte', 1,  'Philippines'),
('Claver', 89,  'Surigao del Norte', 1,  'Philippines'),
('Dapa', 89,  'Surigao del Norte', 1,  'Philippines'),
('Del Carmen', 89,  'Surigao del Norte', 1,  'Philippines'),
('Gigaquit', 89,  'Surigao del Norte', 1,  'Philippines'),
('Mainit', 89,  'Surigao del Norte', 1,  'Philippines'),
('Malimono', 89,  'Surigao del Norte', 1,  'Philippines'),
('San Benito', 89,  'Surigao del Norte', 1,  'Philippines'),
('Surigao City', 89,  'Surigao del Norte', 1,  'Philippines'),
('Tagana-an', 89,  'Surigao del Norte', 1,  'Philippines'),
('Barobo', 90,  'Surigao del Sur', 1,  'Philippines'),
('Bislig', 90,  'Surigao del Sur', 1,  'Philippines'),
('Cagwait', 90,  'Surigao del Sur', 1,  'Philippines'),
('Cantilan', 90,  'Surigao del Sur', 1,  'Philippines'),
('Carrascal', 90,  'Surigao del Sur', 1,  'Philippines'),
('Cortes', 90,  'Surigao del Sur', 1,  'Philippines'),
('Hinatuan', 90,  'Surigao del Sur', 1,  'Philippines'),
('Lanuza', 90,  'Surigao del Sur', 1,  'Philippines'),
('Lianga', 90,  'Surigao del Sur', 1,  'Philippines'),
('Lingig', 90,  'Surigao del Sur', 1,  'Philippines'),
('Madrid', 90,  'Surigao del Sur', 1,  'Philippines'),
('Marihatag', 90,  'Surigao del Sur', 1,  'Philippines'),
('Tagbina', 90,  'Surigao del Sur', 1,  'Philippines'),
('Tago', 90,  'Surigao del Sur', 1,  'Philippines'),
('Tandag', 90,  'Surigao del Sur', 1,  'Philippines'),
('Anao', 91,  'Tarlac', 1,  'Philippines'),
('Bamban', 91,  'Tarlac', 1,  'Philippines'),
('Camiling', 91,  'Tarlac', 1,  'Philippines'),
('Capas', 91,  'Tarlac', 1,  'Philippines'),
('Gerona', 91,  'Tarlac', 1,  'Philippines'),
('Mayantoc', 91,  'Tarlac', 1,  'Philippines'),
('Moncada', 91,  'Tarlac', 1,  'Philippines'),
('Paniqui', 91,  'Tarlac', 1,  'Philippines'),
('Pura', 91,  'Tarlac', 1,  'Philippines'),
('Ramos', 91,  'Tarlac', 1,  'Philippines'),
('San Clemente', 91,  'Tarlac', 1,  'Philippines'),
('Santa Ignacia', 91,  'Tarlac', 1,  'Philippines'),
('Tarlac City', 91,  'Tarlac', 1,  'Philippines'),
('Bongao', 92,  'Tawi-Tawi', 1,  'Philippines'),
('Languyan', 92,  'Tawi-Tawi', 1,  'Philippines'),
('Mapun', 92,  'Tawi-Tawi', 1,  'Philippines'),
('Panglima Sugala', 92,  'Tawi-Tawi', 1,  'Philippines'),
('Sapa-Sapa', 92,  'Tawi-Tawi', 1,  'Philippines'),
('Sibutu', 92,  'Tawi-Tawi', 1,  'Philippines'),
('Simunul', 92,  'Tawi-Tawi', 1,  'Philippines'),
('Sitangkai', 92,  'Tawi-Tawi', 1,  'Philippines'),
('South Ubian', 92,  'Tawi-Tawi', 1,  'Philippines'),
('Tandubas', 92,  'Tawi-Tawi', 1,  'Philippines'),
('Turtle Islands', 92,  'Tawi-Tawi', 1,  'Philippines'),
('Almagro', 93,  'Western Samar', 1,  'Philippines'),
('Basey', 93,  'Western Samar', 1,  'Philippines'),
('Calbayog City', 93,  'Western Samar', 1,  'Philippines'),
('Calbiga', 93,  'Western Samar', 1,  'Philippines'),
('Catbalogan', 93,  'Western Samar', 1,  'Philippines'),
('Daram', 93,  'Western Samar', 1,  'Philippines'),
('Gandara', 93,  'Western Samar', 1,  'Philippines'),
('Hinabangan', 93,  'Western Samar', 1,  'Philippines'),
('Jiabong', 93,  'Western Samar', 1,  'Philippines'),
('Marabut', 93,  'Western Samar', 1,  'Philippines'),
('Matuguinao', 93,  'Western Samar', 1,  'Philippines'),
('Motiong', 93,  'Western Samar', 1,  'Philippines'),
('Pagsanghan', 93,  'Western Samar', 1,  'Philippines'),
('Paranas', 93,  'Western Samar', 1,  'Philippines'),
('Pinabacdao', 93,  'Western Samar', 1,  'Philippines'),
('San Jorge', 93,  'Western Samar', 1,  'Philippines'),
('San Jose de Buan', 93,  'Western Samar', 1,  'Philippines'),
('Santa Margarita', 93,  'Western Samar', 1,  'Philippines'),
('Tagapul-an', 93,  'Western Samar', 1,  'Philippines'),
('Talalora', 93,  'Western Samar', 1,  'Philippines'),
('Tarangnan', 93,  'Western Samar', 1,  'Philippines'),
('Villareal', 93,  'Western Samar', 1,  'Philippines'),
('Zumarraga', 93,  'Western Samar', 1,  'Philippines'),
('Botolan', 95,  'Zambales', 1,  'Philippines'),
('Cabangan', 95,  'Zambales', 1,  'Philippines'),
('Castillejos', 95,  'Zambales', 1,  'Philippines'),
('Iba', 95,  'Zambales', 1,  'Philippines'),
('Masinloc', 95,  'Zambales', 1,  'Philippines'),
('Olongapo', 95,  'Zambales', 1,  'Philippines'),
('Palauig', 95,  'Zambales', 1,  'Philippines'),
('San Felipe', 95,  'Zambales', 1,  'Philippines'),
('San Marcelino', 95,  'Zambales', 1,  'Philippines'),
('Subic', 95,  'Zambales', 1,  'Philippines'),
('Baliguian', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Dapitan', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Dipolog', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Godod', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Gutalac', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Jose Dalman', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Kalawit', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Labason', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Leon B. Postigo', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Liloy', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Manukan', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Mutia', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Piñan', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Polanco', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('President Manuel A. Roxas', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Salug', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Sergio Osmeña Sr.', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Siayan', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Sibuco', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Sibutad', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Sindangan', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Siocon', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Sirawai', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Tampilisan', 96,  'Zamboanga del Norte', 1,  'Philippines'),
('Bayog', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Dimataling', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Dinas', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Dumalinao', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Dumingag', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Guipos', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Josefina', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Kumalarang', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Labangan', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Lakewood', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Lapuyan', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Margosatubig', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Midsalip', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Molave', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Pagadian', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Ramon Magsaysay', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Sominot', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Tabina', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Tambulig', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Tigbao', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Tukuran', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Vincenzo A. Sagun', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Zamboanga', 97,  'Zamboanga del Sur', 1,  'Philippines'),
('Balagon', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Batu', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Binuatan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Bunguiao', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Buug', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Cabaluay', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Calabasa', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Caracal', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Culianan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Curuan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Dalangin', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Danlugan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Dawa-Dawa', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Dicayong', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Diplahan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Dipolo', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Disod', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Dulian', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('East Migpulao', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Ganyangan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Gubaan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Guiniculalay', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Irasan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Kagawasan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Kipit', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('La Dicha', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Labuan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Lamisahan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Landang Laum', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Langatian', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Laparay', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Legrada', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Leon Postigo', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Limaong', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Limpapa', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Linay', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Lingasan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Lintangan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Lumbayan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Lumbog', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Malangas', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Malayal', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Malim', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Mandih', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Mangusu', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Manicahan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Margos', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Monching', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Muricay', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Muti', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Olingan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Olutanga', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Palomoc', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Panubigan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Patawag', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Ponot', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Quinipot', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Rancheria Payau', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Robonkon', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Sagacad', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Sangali', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Seres', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Sergio Osmeña Sr', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Siari', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Siay', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Sibulao', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Sibutao', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Siraway', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Sumalig', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Tagasilay', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Taguitic', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Talabaan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Taluksangay', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Talusan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Tawagan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Tigpalay', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Tigtabon', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Tiguha', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Timonan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Tiparak', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Titay', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Tucuran', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Tungawan', 99,  'Zamboanga Sibugay', 1,  'Philippines'),
('Vitali', 99,  'Zamboanga Sibugay', 1,  'Philippines');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: CURRENCY
============================================================================================= */

DROP TABLE IF EXISTS currency;

CREATE TABLE currency(
	currency_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	currency_name VARCHAR(100) NOT NULL,
	symbol VARCHAR(5) NOT NULL,
	shorthand VARCHAR(10) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: CURRENCY
============================================================================================= */

INSERT INTO currency (currency_name, symbol, shorthand)
VALUES
('Philippine Peso', '₱', 'PHP'),
('United States Dollar', '$', 'USD'),
('Japanese Yen', '¥', 'JPY'),
('South Korean Won', '₩', 'KRW'),
('Euro', '€', 'EUR'),
('Pound Sterling', '£', 'GBP');

/* =============================================================================================
  INITIAL VALUES: NATIONALITY
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: BLOOD TYPE
============================================================================================= */

DROP TABLE IF EXISTS nationality;

CREATE TABLE nationality (
  nationality_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nationality_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);


/* =============================================================================================
  INDEX: BLOOD TYPE
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: BLOOD TYPE
============================================================================================= */

INSERT INTO nationality (nationality_name)
VALUES
('Afghan'),
('Albanian'),
('Algerian'),
('American'),
('Andorran'),
('Angolan'),
('Argentine'),
('Armenian'),
('Australian'),
('Austrian'),
('Azerbaijani'),
('Bahamian'),
('Bahraini'),
('Bangladeshi'),
('Barbadian'),
('Belarusian'),
('Belgian'),
('Belizean'),
('Beninese'),
('Bhutanese'),
('Bolivian'),
('Bosnian'),
('Brazilian'),
('British'),
('Bruneian'),
('Bulgarian'),
('Burkinabe'),
('Burmese'),
('Burundian'),
('Cambodian'),
('Cameroonian'),
('Canadian'),
('Cape Verdean'),
('Central African'),
('Chadian'),
('Chilean'),
('Chinese'),
('Colombian'),
('Comorian'),
('Congolese'),
('Costa Rican'),
('Croatian'),
('Cuban'),
('Cypriot'),
('Czech'),
('Danish'),
('Djiboutian'),
('Dominican'),
('Dutch'),
('Ecuadorian'),
('Egyptian'),
('Emirati'),
('English'),
('Equatorial Guinean'),
('Eritrean'),
('Estonian'),
('Ethiopian'),
('Fijian'),
('Finnish'),
('French'),
('Gabonese'),
('Gambian'),
('Georgian'),
('German'),
('Ghanaian'),
('Greek'),
('Grenadian'),
('Guatemalan'),
('Guinean'),
('Guyanese'),
('Haitian'),
('Honduran'),
('Hungarian'),
('Icelandic'),
('Indian'),
('Indonesian'),
('Iranian'),
('Iraqi'),
('Irish'),
('Israeli'),
('Italian'),
('Ivorian'),
('Jamaican'),
('Japanese'),
('Jordanian'),
('Kazakh'),
('Kenyan'),
('Kiribati'),
('Kuwaiti'),
('Kyrgyz'),
('Lao'),
('Latvian'),
('Lebanese'),
('Liberian'),
('Libyan'),
('Liechtenstein'),
('Lithuanian'),
('Luxembourgish'),
('Macedonian'),
('Malagasy'),
('Malawian'),
('Malaysian'),
('Maldivian'),
('Malian'),
('Maltese'),
('Marshallese'),
('Mauritanian'),
('Mauritian'),
('Mexican'),
('Micronesian'),
('Moldovan'),
('Monacan'),
('Mongolian'),
('Montenegrin'),
('Moroccan'),
('Mozambican'),
('Namibian'),
('Nauruan'),
('Nepalese'),
('New Zealander'),
('Nicaraguan'),
('Nigerien'),
('Nigerian'),
('North Korean'),
('Norwegian'),
('Omani'),
('Pakistani'),
('Palauan'),
('Palestinian'),
('Panamanian'),
('Papua New Guinean'),
('Paraguayan'),
('Peruvian'),
('Philippine'),
('Polish'),
('Portuguese'),
('Qatari'),
('Romanian'),
('Russian'),
('Rwandan'),
('Saint Lucian'),
('Salvadoran'),
('Samoan'),
('San Marinese'),
('Sao Tomean'),
('Saudi'),
('Scottish'),
('Senegalese'),
('Serbian'),
('Seychellois'),
('Sierra Leonean'),
('Singaporean'),
('Slovak'),
('Slovenian'),
('Solomon Islander'),
('Somali'),
('South African'),
('South Korean'),
('Spanish'),
('Sri Lankan'),
('Sudanese'),
('Surinamese'),
('Swazi'),
('Swedish'),
('Swiss'),
('Syrian'),
('Taiwanese'),
('Tajik'),
('Tanzanian'),
('Thai'),
('Togolese'),
('Tongan'),
('Trinidadian'),
('Tunisian'),
('Turkish'),
('Turkmen'),
('Tuvaluan'),
('Ugandan'),
('Ukrainian'),
('Uruguayan'),
('Uzbek'),
('Vanuatuan'),
('Vatican'),
('Venezuelan'),
('Vietnamese'),
('Welsh'),
('Yemeni'),
('Zambian'),
('Zimbabwean');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: COMPANY
============================================================================================= */

DROP TABLE IF EXISTS company;

CREATE TABLE company(
	company_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	company_name VARCHAR(100) NOT NULL,
	company_logo VARCHAR(500),
	address VARCHAR(1000),
	city_id INT UNSIGNED NOT NULL,
	city_name VARCHAR(100) NOT NULL,
	state_id INT UNSIGNED NOT NULL,
	state_name VARCHAR(100) NOT NULL,
	country_id INT UNSIGNED NOT NULL,
	country_name VARCHAR(100) NOT NULL,
	tax_id VARCHAR(100),
	currency_id INT UNSIGNED,
	currency_name VARCHAR(100),
	phone VARCHAR(20),
	telephone VARCHAR(20),
	email VARCHAR(255),
	website VARCHAR(255),
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id),
  FOREIGN KEY (city_id) REFERENCES city(city_id),
  FOREIGN KEY (state_id) REFERENCES state(state_id),
  FOREIGN KEY (country_id) REFERENCES country(country_id)
);

/* =============================================================================================
  INDEX: COMPANY
============================================================================================= */

CREATE INDEX idx_company_city_id ON company(city_id);
CREATE INDEX idx_company_state_id ON company(state_id);
CREATE INDEX idx_company_country_id ON company(country_id);
CREATE INDEX idx_company_currency_id ON company(currency_id);

/* =============================================================================================
  INITIAL VALUES: COMPANY
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: BLOOD TYPE
============================================================================================= */

DROP TABLE IF EXISTS blood_type;

CREATE TABLE blood_type (
  blood_type_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  blood_type_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);


/* =============================================================================================
  INDEX: BLOOD TYPE
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: BLOOD TYPE
============================================================================================= */

INSERT INTO blood_type (blood_type_name)
VALUES 
('A+'),
('A-'),
('B+'),
('B-'),
('AB+'),
('AB-'),
('O+'),
('O-');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: CIVIL STATUS
============================================================================================= */

DROP TABLE IF EXISTS civil_status;

CREATE TABLE civil_status (
  civil_status_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  civil_status_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: CIVIL STATUS
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: CIVIL STATUS
============================================================================================= */

INSERT INTO civil_status (civil_status_name)
VALUES 
('Single'),
('Married'),
('Divorced'),
('Widowed'),
('Separated');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: CREDENTIAL TYPE
============================================================================================= */

DROP TABLE IF EXISTS credential_type;

CREATE TABLE credential_type (
  credential_type_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  credential_type_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: CREDENTIAL TYPE
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: CREDENTIAL TYPE
============================================================================================= */

INSERT INTO credential_type (credential_type_name) 
VALUES
('Passport'),
('Driver\'s License'),
('National ID'),
('SSS ID'),
('GSIS ID'),
('PhilHealth ID'),
('Postal ID'),
('Voter\'s ID'),
('Barangay ID'),
('Student ID'),
('PRC License'),
('Company ID'),
('Professional Certification'),
('Work Permit'),
('Medical License'),
('Teaching License'),
('Engineering License'),
('Bar Exam Certificate'),
('Visa'),
('Work Visa'),
('Immigration Card'),
('Marriage Certificate'),
('Birth Certificate'),
('Death Certificate'),
('Police Clearance'),
('NBI Clearance'),
('Barangay Clearance'),
('Travel Permit'),
('Employment Certificate'),
('Firearm License'),
('Business Permit');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: EDUCATIONAL STAGE
============================================================================================= */

DROP TABLE IF EXISTS educational_stage;

CREATE TABLE educational_stage (
  educational_stage_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  educational_stage_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: EDUCATIONAL STAGE
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: EDUCATIONAL STAGE
============================================================================================= */

INSERT INTO educational_stage (educational_stage_name)
VALUES 
('Primary Education'),
('Middle School'),
('High School'),
('Diploma'),
('Bachelor'),
('Master'),
('Doctorate'),
('Post-Doctorate'),
('Vocational Training');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: GENDER
============================================================================================= */

DROP TABLE IF EXISTS gender;

CREATE TABLE gender (
  gender_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  gender_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: GENDER
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: GENDER
============================================================================================= */

INSERT INTO gender (gender_name)
VALUES 
('Male'),
('Female');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: RELATIONSHIP
============================================================================================= */

DROP TABLE IF EXISTS relationship;

CREATE TABLE relationship (
  relationship_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  relationship_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: RELATIONSHIP
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: RELATIONSHIP
============================================================================================= */

INSERT INTO relationship (relationship_name)
VALUES 
('Father'),
('Mother'),
('Husband'),
('Wife'),
('Son'),
('Daughter'),
('Brother'),
('Sister'),
('Grandfather'),
('Grandmother'),
('Grandson'),
('Granddaughter'),
('Uncle'),
('Aunt'),
('Nephew'),
('Niece'),
('Cousin'),
('Friend');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: RELIGION
============================================================================================= */

DROP TABLE IF EXISTS religion;

CREATE TABLE religion (
  religion_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  religion_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: RELIGION
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: RELIGION
============================================================================================= */

INSERT INTO religion (religion_name)
VALUES
('Christianity'),
('Atheism'),
('Islam'),
('Hinduism'),
('Buddhism'),
('Judaism'),
('Sikhism'),
('Atheism'),
('Agnosticism'),
('Confucianism'),
('Shinto'),
('Taoism'),
('Jainism'),
('Spiritualism'),
('Paganism'),
('Rastafarianism'),
('Unitarian Universalism'),
('Scientology'),
('Druze');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: LANGUAGE
============================================================================================= */

DROP TABLE IF EXISTS language;

CREATE TABLE language (
  language_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  language_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: LANGUAGE
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: LANGUAGE
============================================================================================= */

INSERT INTO language (language_name) VALUES
('Afrikaans'),
('Amharic'),
('Arabic'),
('Assamese'),
('Azerbaijani'),
('Belarusian'),
('Bulgarian'),
('Bhojpuri'),
('Bengali'),
('Bosnian'),
('Catalan, Valencian'),
('Cebuano'),
('Czech'),
('Danish'),
('German'),
('English'),
('Ewe'),
('Greek, Modern'),
('Spanish'),
('Estonian'),
('Basque'),
('Persian'),
('Fula'),
('Finnish'),
('French'),
('Irish'),
('Galician'),
('Guarani'),
('Gujarati'),
('Hausa'),
('Haitian Creole'),
('Hebrew (modern)'),
('Hindi'),
('Chhattisgarhi'),
('Croatian'),
('Hungarian'),
('Armenian'),
('Indonesian'),
('Igbo'),
('Icelandic'),
('Italian'),
('Japanese'),
('Syro-Palestinian Sign Language'),
('Javanese'),
('Georgian'),
('Kikuyu'),
('Kyrgyz'),
('Kuanyama'),
('Kazakh'),
('Khmer'),
('Kannada'),
('Korean'),
('Krio'),
('Kashmiri'),
('Kurdish'),
('Latin'),
('Lithuanian'),
('Luxembourgish'),
('Latvian'),
('Magahi'),
('Maithili'),
('Malagasy'),
('Macedonian'),
('Malayalam'),
('Mongolian'),
('Marathi (Marāṭhī)'),
('Malay'),
('Maltese'),
('Burmese'),
('Nepali'),
('Dutch'),
('Norwegian'),
('Oromo'),
('Odia'),
('Oromo'),
('Panjabi, Punjabi'),
('Polish'),
('Pashto'),
('Portuguese'),
('Rundi'),
('Romanian, Moldavian, Moldovan'),
('Russian'),
('Kinyarwanda'),
('Sindhi'),
('Argentine Sign Language'),
('Brazilian Sign Language'),
('Chinese Sign Language'),
('Colombian Sign Language'),
('German Sign Language'),
('Algerian Sign Language'),
('Ecuadorian Sign Language'),
('Spanish Sign Language'),
('Ethiopian Sign Language'),
('French Sign Language'),
('British Sign Language'),
('Ghanaian Sign Language'),
('Irish Sign Language'),
('Indopakistani Sign Language'),
('Persian Sign Language'),
('Italian Sign Language'),
('Japanese Sign Language'),
('Kenyan Sign Language'),
('Korean Sign Language'),
('Moroccan Sign Language'),
('Mexican Sign Language'),
('Malaysian Sign Language'),
('Philippine Sign Language'),
('Polish Sign Language'),
('Portuguese Sign Language'),
('Russian Sign Language'),
('Saudi Arabian Sign Language'),
('El Salvadoran Sign Language'),
('Turkish Sign Language'),
('Tanzanian Sign Language'),
('Ukrainian Sign Language'),
('American Sign Language'),
('South African Sign Language'),
('Zimbabwe Sign Language'),
('Sinhala, Sinhalese'),
('Slovak'),
('Saraiki'),
('Slovene'),
('Shona'),
('Somali'),
('Albanian'),
('Serbian'),
('Swati'),
('Sunda'),
('Swedish'),
('Swahili'),
('Sylheti'),
('Tagalog'),
('Tamil'),
('Telugu'),
('Thai'),
('Tibetan'),
('Tigrinya'),
('Turkmen'),
('Tswana'),
('Turkish'),
('Uyghur'),
('Ukrainian'),
('Urdu'),
('Uzbek'),
('Vietnamese'),
('Xhosa'),
('Yiddish'),
('Yoruba'),
('Cantonese'),
('Chinese'),
('Zulu');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: LANGUAGE PROFICIENCY
============================================================================================= */

DROP TABLE IF EXISTS language_proficiency;

CREATE TABLE language_proficiency(
	language_proficiency_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	language_proficiency_name VARCHAR(100) NOT NULL,
	language_proficiency_description VARCHAR(200) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: LANGUAGE PROFICIENCY
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: LANGUAGE PROFICIENCY
============================================================================================= */

INSERT INTO language_proficiency (language_proficiency_name, language_proficiency_description)
VALUES 
('Native', 'Fluent in the language, spoken at home'),
('Fluent', 'Able to communicate effectively and accurately in most formal and informal conversations'),
('Advanced', 'Able to communicate effectively and accurately in most formal and informal conversations, with some difficulty in complex situations'),
('Intermediate', 'Able to communicate in everyday situations, with some difficulty in formal conversations'),
('Basic', 'Able to communicate in very basic situations, with difficulty in everyday conversations'),
('Non-proficient', 'No knowledge of the language');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: ADDRESS TYPE
============================================================================================= */

DROP TABLE IF EXISTS address_type;

CREATE TABLE address_type (
  address_type_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  address_type_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: ADDRESS TYPE
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: ADDRESS TYPE
============================================================================================= */

INSERT INTO address_type (address_type_name) VALUES
('Home Address'),
('Billing Address'),
('Mailing Address'),
('Shipping Address'),
('Work Address');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: CONTACT INFORMATION TYPE
============================================================================================= */

DROP TABLE IF EXISTS contact_information_type;

CREATE TABLE contact_information_type (
  contact_information_type_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  contact_information_type_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: CONTACT INFORMATION TYPE
============================================================================================= */

INSERT INTO contact_information_type (contact_information_type_name)
VALUES 
('Personal'),
('Work');

/* =============================================================================================
  INITIAL VALUES: CONTACT INFORMATION TYPE
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: BANK
============================================================================================= */

DROP TABLE IF EXISTS bank;

CREATE TABLE bank(
	bank_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	bank_name VARCHAR(100) NOT NULL,
  bank_identifier_code VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: BANK
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: BANK
============================================================================================= */

INSERT INTO bank (bank_name, bank_identifier_code) VALUES
('Banco de Oro (BDO)', '010530667'),
('Metrobank', '010269996'),
('Land Bank of the Philippines', '010350025'),
('Bank of the Philippine Islands (BPI)', '010040018'),
('Philippine National Bank (PNB)', '010080010'),
('Security Bank', '010140015'),
('UnionBank of the Philippines', '010419995'),
('Development Bank of the Philippines (DBP)', '010590018'),
('EastWest Bank', '010620014'),
('China Banking Corporation (Chinabank)', '010100013'),
('RCBC (Rizal Commercial Banking Corporation)', '010280014'),
('Maybank Philippines', '010220016'),
('Bank of America', 'BOFAUS3N'),
('JPMorgan Chase', 'CHASUS33'),
('Wells Fargo', 'WFBIUS6W'),
('Citibank', 'CITIUS33'),
('Bank of New York Mellon', 'BKONYUS33'),
('State Street Corporation', 'SSTTUS33'),
('Goldman Sachs', 'GOLDUS33'),
('Morgan Stanley', 'MSNYUS33'),
('Capital One', 'COWNUS33'),
('PNC Financial Services Group', 'PNCCUS33'),
('Truist Financial Corporation', 'TRUIUS33'),
('Ally Financial', 'ALLYUS33'),
('TD Bank', 'TDUSUS33'),
('Regions Financial Corporation', 'RGNSUS33'),
('M&T Bank', 'MANTUS33'),
('SunTrust Banks', 'STBAUS33'),
('Emirates NBD', 'EBILAEAD'),
('First Abu Dhabi Bank', 'NBADAEAAXXX'),
('Abu Dhabi Commercial Bank', 'ADCBAEAAXXX'),
('Dubai Islamic Bank', 'DIBAEAAXXX'),
('Mashreq Bank', 'BOMLAEAD'),
('Union National Bank', 'UNBAEAAXXX'),
('Commercial Bank of Dubai', 'CBDAEAAXXX'),
('Emirates Islamic Bank', 'EIILAEAD'),
('Ajman Bank', 'AJBLAEAD'),
('Sharjah Islamic Bank', 'SIBAEAAXXX');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: BANK ACCOUNT TYPE
============================================================================================= */

DROP TABLE IF EXISTS bank_account_type;

CREATE TABLE bank_account_type (
  bank_account_type_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  bank_account_type_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: BANK ACCOUNT TYPE
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: BANK ACCOUNT TYPE
============================================================================================= */

INSERT INTO bank_account_type (bank_account_type_name)
VALUES 
('Checking'),
('Savings');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: DEPARTMENT
============================================================================================= */

DROP TABLE IF EXISTS department;

CREATE TABLE department (
  department_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  department_name VARCHAR(100) NOT NULL,
  parent_department_id INT,
  parent_department_name VARCHAR(100),
  manager_id INT,
  manager_name VARCHAR(1000),
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: DEPARTMENT
============================================================================================= */

CREATE INDEX idx_department_parent_department_id ON department(parent_department_id);
CREATE INDEX idx_department_manager_id ON department(manager_id);

/* =============================================================================================
  INITIAL VALUES: DEPARTMENT
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: DEPARTURE REASON
============================================================================================= */

DROP TABLE IF EXISTS departure_reason;

CREATE TABLE departure_reason (
  departure_reason_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  departure_reason_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: DEPARTURE REASON
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: DEPARTURE REASON
============================================================================================= */

INSERT INTO departure_reason (departure_reason_name)
VALUES
('Resigned'),
('Retirement'),
('Termination - Performance'),
('Termination - Misconduct'),
('Layoff / Redundancy'),
('End of Contract'),
('Mutual Agreement'),
('Medical Reasons'),
('Personal Reasons'),
('Relocation'),
('Career Change'),
('Better Opportunity'),
('Education / Study'),
('Family Responsibilities'),
('Deceased');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: EMPLOYMENT LOCATION TYPE
============================================================================================= */

DROP TABLE IF EXISTS employment_location_type;

CREATE TABLE employment_location_type (
  employment_location_type_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  employment_location_type_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: EMPLOYMENT LOCATION TYPE
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: EMPLOYMENT LOCATION TYPE
============================================================================================= */

INSERT INTO employment_location_type (employment_location_type_name)
VALUES
('Remote'),
('Hybrid'),
('Onsite');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: EMPLOYMENT TYPE
============================================================================================= */

DROP TABLE IF EXISTS employment_type;

CREATE TABLE employment_type (
  employment_type_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  employment_type_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: EMPLOYMENT TYPE
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: EMPLOYMENT TYPE
============================================================================================= */

INSERT INTO employment_type (employment_type_name)
VALUES
('Full-time'),
('Part-time'),
('Temporary'),
('Contract'),
('Internship'),
('Apprenticeship'),
('Seasonal'),
('Casual'),
('Consultant'),
('Freelance');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: JOB POSITION
============================================================================================= */

DROP TABLE IF EXISTS job_position;

CREATE TABLE job_position (
  job_position_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  job_position_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: JOB POSITION
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: JOB POSITION
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: WORK LOCATION
============================================================================================= */

DROP TABLE IF EXISTS work_location;

CREATE TABLE work_location(
	work_location_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	work_location_name VARCHAR(100) NOT NULL,
	address VARCHAR(1000),
	city_id INT UNSIGNED NOT NULL,
	city_name VARCHAR(100) NOT NULL,
	state_id INT UNSIGNED NOT NULL,
	state_name VARCHAR(100) NOT NULL,
	country_id INT UNSIGNED NOT NULL,
	country_name VARCHAR(100) NOT NULL,
	phone VARCHAR(20),
	telephone VARCHAR(20),
	email VARCHAR(255),
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id),
  FOREIGN KEY (city_id) REFERENCES city(city_id),
  FOREIGN KEY (state_id) REFERENCES state(state_id),
  FOREIGN KEY (country_id) REFERENCES country(country_id)
);

/* =============================================================================================
  INDEX: WORK LOCATION
============================================================================================= */

CREATE INDEX idx_work_location_city_id ON work_location(city_id);
CREATE INDEX idx_work_location_state_id ON work_location(state_id);
CREATE INDEX idx_work_location_country_id ON work_location(country_id);

/* =============================================================================================
  INITIAL VALUES: WORK LOCATION
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: EMPLOYEE
============================================================================================= */

DROP TABLE IF EXISTS employee;

CREATE TABLE employee (
  employee_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  employee_image VARCHAR(500),
  full_name VARCHAR(1000) NOT NULL,
  first_name VARCHAR(300) NOT NULL,
	middle_name VARCHAR(300),
	last_name VARCHAR(300) NOT NULL,
	suffix VARCHAR(10),
	nickname VARCHAR(100),
  private_address VARCHAR(500),
  private_address_city_id INT UNSIGNED,
	private_address_city_name VARCHAR(100),
	private_address_state_id INT UNSIGNED,
	private_address_state_name VARCHAR(100),
	private_address_country_id INT UNSIGNED,
	private_address_country_name VARCHAR(100),
  private_phone VARCHAR(20),
	private_telephone VARCHAR(20),
	private_email VARCHAR(255),
  civil_status_id INT UNSIGNED,
  civil_status_name VARCHAR(100),
  dependents INT DEFAULT 0,
  nationality_id INT UNSIGNED,
  nationality_name VARCHAR(100),
  gender_id INT UNSIGNED,
  gender_name VARCHAR(100),
  religion_id INT UNSIGNED,
  religion_name VARCHAR(100),
  blood_type_id INT UNSIGNED,
  blood_type_name VARCHAR(100),
  birthday DATE,
  place_of_birth VARCHAR(1000),
  home_work_distance DOUBLE DEFAULT 0,
  height FLOAT,
  weight FLOAT,
  employment_status VARCHAR(50) DEFAULT 'Active',
  company_id INT UNSIGNED,
  company_name VARCHAR(100),
  department_id INT UNSIGNED,
  department_name VARCHAR(100),
  job_position_id INT UNSIGNED,
  job_position_name VARCHAR(100),
  work_phone VARCHAR(20),
	work_telephone VARCHAR(20),
	work_email VARCHAR(255),
  manager_id INT UNSIGNED,
  manager_name VARCHAR(1000),
  work_location_id INT UNSIGNED,
  work_location_name VARCHAR(100),
  employment_type_id INT UNSIGNED,
  employment_type_name VARCHAR(100),
  employment_location_type_id INT UNSIGNED,
  employment_location_type_name VARCHAR(100),
  pin_code VARCHAR(255),
  badge_id VARCHAR(100),
  on_board_date DATE,
  off_board_date DATE,
  time_off_approver_id INT UNSIGNED,
  time_off_approver_name VARCHAR(300),
  departure_reason_id INT UNSIGNED,
  departure_reason_name VARCHAR(100),
  detailed_departure_reason VARCHAR(5000),
  departure_date DATE,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: EMPLOYEE
============================================================================================= */

CREATE INDEX idx_employee_department_id ON employee(department_id);
CREATE INDEX idx_employee_job_position_id ON employee(job_position_id);
CREATE INDEX idx_employee_work_location_id ON employee(work_location_id);
CREATE INDEX idx_employee_employment_type_id ON employee(employment_type_id);
CREATE INDEX idx_employee_private_address_city_id ON employee(private_address_city_id);
CREATE INDEX idx_employee_private_address_state_id ON employee(private_address_state_id);
CREATE INDEX idx_employee_private_address_country_id ON employee(private_address_country_id);
CREATE INDEX idx_employee_civil_status_id ON employee(civil_status_id);
CREATE INDEX idx_employee_nationality_id ON employee(nationality_id);
CREATE INDEX idx_employee_badge_id ON employee(badge_id);
CREATE INDEX idx_employee_employment_status ON employee(employment_status);

/* =============================================================================================
  INITIAL VALUES: EMPLOYEE
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: EMPLOYEE EXPERIENCE
============================================================================================= */

DROP TABLE IF EXISTS employee_experience;

CREATE TABLE employee_experience (
  employee_experience_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  employee_id INT UNSIGNED NOT NULL,
  job_title VARCHAR(100) NOT NULL,
  employment_type_id INT UNSIGNED,
  employment_type_name VARCHAR(100),
  company_name VARCHAR(200) NOT NULL,
  location VARCHAR(200),
  start_month VARCHAR(20),
  start_year VARCHAR(20),
  end_month VARCHAR(20),
  end_year VARCHAR(20),
  job_description VARCHAR(5000),
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: EMPLOYEE EXPERIENCE
============================================================================================= */

CREATE INDEX idx_employee_experience_employee_id ON employee_experience(employee_id);
CREATE INDEX idx_employee_experience_employment_type_id ON employee_experience(employment_type_id);

/* =============================================================================================
  INITIAL VALUES: EMPLOYEE EXPERIENCE
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: EMPLOYEE EDUCATION
============================================================================================= */

DROP TABLE IF EXISTS employee_education;

CREATE TABLE employee_education (
  employee_education_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  employee_id INT UNSIGNED NOT NULL,
  school VARCHAR(100) NOT NULL,
  degree VARCHAR(100),
  field_of_study VARCHAR(100),
  start_month VARCHAR(20),
  start_year VARCHAR(20),
  end_month VARCHAR(20),
  end_year VARCHAR(20),
  activities_societies VARCHAR(5000),
  education_description VARCHAR(5000),
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: EMPLOYEE EDUCATION
============================================================================================= */

CREATE INDEX idx_employee_education_employee_id ON employee_education(employee_id);

/* =============================================================================================
  INITIAL VALUES: EMPLOYEE EDUCATION
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: EMPLOYEE LICENSE
============================================================================================= */

DROP TABLE IF EXISTS employee_license;

CREATE TABLE employee_license (
  employee_license_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  employee_id INT UNSIGNED NOT NULL,
  licensed_profession VARCHAR(200) NOT NULL,
  licensing_body VARCHAR(200) NOT NULL,
  license_number VARCHAR(200) NOT NULL,
  issue_date DATE NOT NULL,
  expiration_date DATE,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: EMPLOYEE LICENSE
============================================================================================= */

CREATE INDEX idx_employee_license_employee_id ON employee_license(employee_id);

/* =============================================================================================
  INITIAL VALUES: EMPLOYEE LICENSE
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: EMPLOYEE EMERGENCY CONTACT
============================================================================================= */

DROP TABLE IF EXISTS employee_emergency_contact;

CREATE TABLE employee_emergency_contact (
  employee_emergency_contact_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  employee_id INT UNSIGNED NOT NULL,
  emergency_contact_name VARCHAR(500) NOT NULL,
  relationship_id INT UNSIGNED NOT NULL,
  relationship_name VARCHAR(100) NOT NULL,
  telephone VARCHAR(50),
  mobile VARCHAR(50),
  email VARCHAR(200),
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
  FOREIGN KEY (relationship_id) REFERENCES relationship(relationship_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: EMPLOYEE EMERGENCY CONTACT
============================================================================================= */

CREATE INDEX idx_employee_emergency_contact_employee_id ON employee_emergency_contact(employee_id);
CREATE INDEX idx_employee_emergency_contact_relationship_id ON employee_emergency_contact(relationship_id);

/* =============================================================================================
  INITIAL VALUES: EMPLOYEE EMERGENCY CONTACT
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: EMPLOYEE LANGUAGE
============================================================================================= */

DROP TABLE IF EXISTS employee_language;

CREATE TABLE employee_language (
  employee_language_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  employee_id INT UNSIGNED NOT NULL,
  language_id INT UNSIGNED NOT NULL,
  language_name VARCHAR(100) NOT NULL,
  language_proficiency_id INT UNSIGNED NOT NULL,
  language_proficiency_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
  FOREIGN KEY (language_id) REFERENCES language(language_id),
  FOREIGN KEY (language_proficiency_id) REFERENCES language_proficiency(language_proficiency_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: EMPLOYEE LANGUAGE
============================================================================================= */

CREATE INDEX idx_employee_language_employee_id ON employee_language(employee_id);
CREATE INDEX idx_employee_language_language_id ON employee_language(language_id);
CREATE INDEX idx_employee_language_language_proficiency_id ON employee_language(language_proficiency_id);

/* =============================================================================================
  INITIAL VALUES: EMPLOYEE LANGUAGE
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: EMPLOYEE DOCUMENT TYPE
============================================================================================= */

DROP TABLE IF EXISTS employee_document_type;

CREATE TABLE employee_document_type (
  employee_document_type_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  employee_document_type_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: EMPLOYEE DOCUMENT TYPE
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: EMPLOYEE DOCUMENT TYPE
============================================================================================= */

INSERT INTO employee_document_type (employee_document_type_name)
VALUES
('Resume'),
('Cover Letter'),
('Employment Contract'),
('Non-Disclosure Agreement'),
('Offer Letter'),
('Government ID'),
('Passport'),
('Work Visa'),
('Tax Identification Document'),
('Social Security Card'),
('Educational Certificates'),
('Professional Licenses'),
('Training Certificates'),
('Performance Appraisal'),
('Background Check Report'),
('Medical Certificate'),
('Bank Account Details'),
('Emergency Contact Form'),
('Company Policy Acknowledgment'),
('Exit Clearance Form');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: EMPLOYEE DOCUMENT
============================================================================================= */

DROP TABLE IF EXISTS employee_document;

CREATE TABLE employee_document (
  employee_document_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  employee_id INT UNSIGNED NOT NULL,
  document_name VARCHAR(200) NOT NULL,
  document_file VARCHAR(500) NOT NULL,
  employee_document_type_id INT UNSIGNED NOT NULL,
  employee_document_type_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
  FOREIGN KEY (employee_document_type_id) REFERENCES employee_document_type(employee_document_type_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: EMPLOYEE DOCUMENT
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: EMPLOYEE DOCUMENT
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: ATTRIBUTE
============================================================================================= */

DROP TABLE IF EXISTS attribute;

CREATE TABLE attribute (
  attribute_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  attribute_name VARCHAR(100) NOT NULL,
  attribute_description VARCHAR(500),
  variant_creation ENUM('Instantly','Never') DEFAULT 'Instantly',
  display_type ENUM('Radio','Checkbox') DEFAULT 'Radio',
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: ATTRIBUTE
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: ATTRIBUTE
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */


/* =============================================================================================
  TABLE: ATTRIBUTE VALUE
============================================================================================= */

DROP TABLE IF EXISTS attribute_value;

CREATE TABLE attribute_value (
  attribute_value_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  attribute_value_name VARCHAR(100) NOT NULL,
  attribute_id INT UNSIGNED NOT NULL,
  attribute_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (attribute_id) REFERENCES attribute(attribute_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: ATTRIBUTE
============================================================================================= */

CREATE INDEX idx_attribute_value_attribute_id ON attribute_value(attribute_id);

/* =============================================================================================
  INITIAL VALUES: ATTRIBUTE
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: TAX
============================================================================================= */

DROP TABLE IF EXISTS tax;

CREATE TABLE tax (
  tax_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  tax_name VARCHAR(100) NOT NULL,
  tax_rate DECIMAL(5,2) DEFAULT 0, 
  tax_type ENUM('None', 'Purchases','Sales') DEFAULT 'Sales',
  tax_computation ENUM('Fixed','Percentage') DEFAULT 'Percentage',
  tax_scope ENUM('Goods','Services'),
  tax_status ENUM('Active','Archived') DEFAULT 'Active',
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: TAX
============================================================================================= */

CREATE INDEX idx_tax_tax_type ON tax(tax_type);
CREATE INDEX idx_tax_tax_computation ON tax(tax_computation);
CREATE INDEX idx_tax_tax_scope ON tax(tax_scope);
CREATE INDEX idx_tax_tax_status ON tax(tax_status);

/* =============================================================================================
  INITIAL VALUES: TAX
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: PRODUCT CATEGORY
============================================================================================= */

DROP TABLE IF EXISTS product_category;

CREATE TABLE product_category (
  product_category_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  product_category_name VARCHAR(100) NOT NULL,
  parent_category_id INT UNSIGNED NULL,
  parent_category_name VARCHAR(100) NOT NULL,
  costing_method ENUM('Average Cost','First In First Out', 'Standard Price') DEFAULT 'Standard Price',
  display_order INT DEFAULT 0,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: PRODUCT CATEGORY
============================================================================================= */

CREATE INDEX idx_product_category_parent_category_id ON product_category(parent_category_id);
CREATE INDEX idx_product_category_costing_method ON product_category(costing_method);

/* =============================================================================================
  INITIAL VALUES: PRODUCT CATEGORY
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: SUPPLIER
============================================================================================= */

DROP TABLE IF EXISTS supplier;

CREATE TABLE supplier (
  supplier_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  supplier_name VARCHAR(200) NOT NULL,
  contact_person VARCHAR(500),
	phone VARCHAR(50),
	telephone VARCHAR(20),
	email VARCHAR(255),
  address VARCHAR(1000),
	city_id INT UNSIGNED NOT NULL,
	city_name VARCHAR(100) NOT NULL,
	state_id INT UNSIGNED NOT NULL,
	state_name VARCHAR(100) NOT NULL,
	country_id INT UNSIGNED NOT NULL,
	country_name VARCHAR(100) NOT NULL,
  tax_id_number VARCHAR(100),
  supplier_status ENUM('Active', 'Archived') DEFAULT 'Active',
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: SUPPLIER
============================================================================================= */

CREATE INDEX idx_supplier_city_id ON supplier(city_id);
CREATE INDEX idx_supplier_state_id ON supplier(state_id);
CREATE INDEX idx_supplier_country_id ON supplier(country_id);
CREATE INDEX idx_supplier_supplier_status ON supplier(supplier_status);

/* =============================================================================================
  INITIAL VALUES: SUPPLIER
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: WAREHOUSE TYPE
============================================================================================= */

DROP TABLE IF EXISTS warehouse_type;

CREATE TABLE warehouse_type (
  warehouse_type_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  warehouse_type_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: WAREHOUSE TYPE
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: WAREHOUSE TYPE
============================================================================================= */

INSERT INTO warehouse_type (warehouse_type_name) VALUES
('Main'),
('Branch'),
('Kitchen'),
('Storage');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: WAREHOUSE
============================================================================================= */

DROP TABLE IF EXISTS warehouse;

CREATE TABLE warehouse (
  warehouse_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  warehouse_name VARCHAR(200) NOT NULL,
  short_name VARCHAR(200) NOT NULL,
  contact_person VARCHAR(500),
  phone VARCHAR(50),
  telephone VARCHAR(20),
  email VARCHAR(100),
  address VARCHAR(1000),
	city_id INT UNSIGNED NOT NULL,
	city_name VARCHAR(100) NOT NULL,
	state_id INT UNSIGNED NOT NULL,
	state_name VARCHAR(100) NOT NULL,
	country_id INT UNSIGNED NOT NULL,
	country_name VARCHAR(100) NOT NULL,
  warehouse_type_id INT UNSIGNED,
  warehouse_type_name VARCHAR(100) NOT NULL,
  warehouse_status ENUM('Active', 'Archived') DEFAULT 'Active',
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (warehouse_type_id) REFERENCES warehouse_type(warehouse_type_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: WAREHOUSE
============================================================================================= */

CREATE INDEX idx_warehouse_city_id ON warehouse(city_id);
CREATE INDEX idx_warehouse_state_id ON warehouse(state_id);
CREATE INDEX idx_warehouse_country_id ON warehouse(country_id);
CREATE INDEX idx_warehouse_warehouse_type_id ON warehouse(warehouse_type_id);
CREATE INDEX idx_warehouse_warehouse_status ON warehouse(warehouse_status);

/* =============================================================================================
  INITIAL VALUES: WAREHOUSE
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: UNIT TYPE
============================================================================================= */

DROP TABLE IF EXISTS unit_type;

CREATE TABLE unit_type (
  unit_type_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  unit_type_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: UNIT TYPE
============================================================================================= */

INSERT INTO unit_type (unit_type_name)
VALUES
  ('Weight'),
  ('Volume'),
  ('Length'),
  ('Area'),
  ('Quantity'),
  ('Temperature'),
  ('Time'),
  ('Pack Size'),
  ('Dosage'),
  ('Piece Count');

/* =============================================================================================
  INITIAL VALUES: UNIT TYPE
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: UNIT
============================================================================================= */

DROP TABLE IF EXISTS unit;

CREATE TABLE unit (
  unit_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  unit_name VARCHAR(100) NOT NULL,
  unit_abbreviation VARCHAR(20),
  unit_type_id INT UNSIGNED NOT NULL,
  unit_type_name VARCHAR(100) NOT NULL,
  ratio_to_base DECIMAL(15,6) DEFAULT 1,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (unit_type_id) REFERENCES unit_type(unit_type_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: UNIT
============================================================================================= */

CREATE INDEX idx_unit_unit_type_id ON unit(unit_type_id);

/* =============================================================================================
  INITIAL VALUES: UNIT
============================================================================================= */

INSERT INTO unit (unit_name, unit_abbreviation, unit_type_id, unit_type_name, ratio_to_base)
VALUES
  ('Milligram', 'mg', 1, 'Weight', 0.001),
  ('Gram', 'g', 1, 'Weight', 1),
  ('Kilogram', 'kg', 1, 'Weight', 1000),
  ('Pound', 'lb', 1, 'Weight', 453.592),
  ('Ounce', 'oz', 1, 'Weight', 28.3495),
  ('Milliliter', 'mL', 2, 'Volume', 1),
  ('Liter', 'L', 2, 'Volume', 1000),
  ('Cubic Centimeter', 'cc', 2, 'Volume', 1),
  ('Gallon', 'gal', 2, 'Volume', 3785.41),
  ('Pint', 'pt', 2, 'Volume', 473.176),
  ('Millimeter', 'mm', 3, 'Length', 0.1),
  ('Centimeter', 'cm', 3, 'Length', 1),
  ('Meter', 'm', 3, 'Length', 100),
  ('Inch', 'in', 3, 'Length', 2.54),
  ('Foot', 'ft', 3, 'Length', 30.48),
  ('Square Centimeter', 'cm²', 4, 'Area', 0.0001),
  ('Square Meter', 'm²', 4, 'Area', 1),
  ('Square Foot', 'ft²', 4, 'Area', 0.092903),
  ('Acre', 'ac', 4, 'Area', 4046.86),
  ('Piece', 'pc', 5, 'Quantity', 1),
  ('Dozen', 'dz', 5, 'Quantity', 12),
  ('Pair', 'pair', 5, 'Quantity', 2),
  ('Pack', 'pack', 5, 'Quantity', 1),
  ('Box', 'box', 5, 'Quantity', 1),
  ('Celsius', '°C', 6, 'Temperature', 1),
  ('Fahrenheit', '°F', 6, 'Temperature', 1),
  ('Kelvin', 'K', 6, 'Temperature', 1),
  ('Second', 's', 7, 'Time', 1),
  ('Minute', 'min', 7, 'Time', 60),
  ('Hour', 'h', 7, 'Time', 3600),
  ('Day', 'd', 7, 'Time', 86400),
  ('Single', '1x', 8, 'Pack Size', 1),
  ('6-Pack', '6x', 8, 'Pack Size', 6),
  ('12-Pack', '12x', 8, 'Pack Size', 12),
  ('24-Pack', '24x', 8, 'Pack Size', 24),
  ('Tablet', 'tab', 9, 'Dosage', 1),
  ('Capsule', 'cap', 9, 'Dosage', 1),
  ('Syringe', 'syr', 9, 'Dosage', 1),
  ('Drop', 'gtt', 9, 'Dosage', 0.05),
  ('Each', 'ea', 10, 'Piece Count', 1),
  ('Set', 'set', 10, 'Piece Count', 1),
  ('Bundle', 'bndl', 10, 'Piece Count', 1),
  ('Roll', 'roll', 10, 'Piece Count', 1),
  ('Case', 'case', 10, 'Piece Count', 1);

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: PRODUCT
============================================================================================= */

DROP TABLE IF EXISTS product;

CREATE TABLE product (
  product_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(200) NOT NULL,
  product_description VARCHAR(1000),
  parent_product_id INT UNSIGNED NULL,
  parent_product_name VARCHAR(200),
  product_image VARCHAR(500),
  product_type ENUM('Goods','Services','Combo') DEFAULT 'Goods',
  sku VARCHAR(200) UNIQUE,
  barcode VARCHAR(200) UNIQUE,
  unit_id INT UNSIGNED,
  unit_name VARCHAR(100) NOT NULL,
  unit_abbreviation VARCHAR(20),
  quantity_on_hand DECIMAL(15,4) DEFAULT 0,
  cost DECIMAL(15,4) DEFAULT 0,
  sales_price DECIMAL(15,4) DEFAULT 0,
  is_variant ENUM('Yes','No') DEFAULT 'No',
  is_sellable ENUM('Yes','No') DEFAULT 'Yes',
  is_purchasable ENUM('Yes','No') DEFAULT 'Yes',
  show_on_pos ENUM('Yes','No') DEFAULT 'Yes',
  weight DECIMAL(10,4) DEFAULT 0,
  width DECIMAL(10,4) DEFAULT 0,
  height DECIMAL(10,4) DEFAULT 0,
  length DECIMAL(10,4) DEFAULT 0,
  variant_signature VARCHAR(500) NULL,
  product_status ENUM('Draft', 'Active','Archived') DEFAULT 'Draft',
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (parent_product_id) REFERENCES product(product_id),
  FOREIGN KEY (unit_id) REFERENCES unit(unit_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id),
  UNIQUE KEY uq_parent_signature (parent_product_id, variant_signature)
);

/* =============================================================================================
  INDEX: PRODUCT
============================================================================================= */

CREATE INDEX idx_product_parent ON product(parent_product_id);
CREATE INDEX idx_product_signature ON product(variant_signature);
CREATE INDEX idx_product_type ON product(product_type);
CREATE INDEX idx_product_barcode ON product(barcode);
CREATE INDEX idx_product_sku ON product(sku);
CREATE INDEX idx_product_unit_id ON product(unit_id);
CREATE INDEX idx_product_is_variant ON product(is_variant);
CREATE INDEX idx_product_is_sellable ON product(is_sellable);
CREATE INDEX idx_product_is_purchasable ON product(is_purchasable);
CREATE INDEX idx_product_show_on_pos ON product(show_on_pos);

/* =============================================================================================
  INITIAL VALUES: PRODUCT
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: PRODUCT TAX
============================================================================================= */

DROP TABLE IF EXISTS product_tax;

CREATE TABLE product_tax (
  product_tax_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  product_id INT UNSIGNED NOT NULL,
  product_name VARCHAR(100) NOT NULL,
  tax_type ENUM('Purchases','Sales'), 
  tax_id INT UNSIGNED NOT NULL,
  tax_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (product_id) REFERENCES product(product_id),
  FOREIGN KEY (tax_id) REFERENCES tax(tax_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: PRODUCT TAX
============================================================================================= */

CREATE INDEX idx_product_tax_product_id ON product_tax(product_id);
CREATE INDEX idx_product_tax_tax_type ON product_tax(tax_type);
CREATE INDEX idx_product_tax_tax_id ON product_tax(tax_id);

/* =============================================================================================
  INITIAL VALUES: PRODUCT TAX
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: PRODUCT CATEGORY MAP
============================================================================================= */

DROP TABLE IF EXISTS product_category_map;

CREATE TABLE product_category_map (
  product_category_map_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  product_id INT UNSIGNED NOT NULL,
  product_name VARCHAR(100) NOT NULL,
  product_category_id INT UNSIGNED NOT NULL,
  product_category_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (product_id) REFERENCES product(product_id),
  FOREIGN KEY (product_category_id) REFERENCES product_category(product_category_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: PRODUCT CATEGORY MAP
============================================================================================= */

CREATE INDEX idx_product_category_map_product_id ON product_category_map(product_id);
CREATE INDEX idx_product_category_map_category_id ON product_category_map(product_category_id);

/* =============================================================================================
  INITIAL VALUES: PRODUCT CATEGORY MAP
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: PRODUCT ATTIBUTE
============================================================================================= */

DROP TABLE IF EXISTS product_attribute;

CREATE TABLE product_attribute (
  product_attribute_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
  product_id INT UNSIGNED NOT NULL,
  product_name VARCHAR(100) NOT NULL,
  attribute_id INT UNSIGNED NOT NULL,
  attribute_name VARCHAR(100) NOT NULL,
  attribute_value_id INT UNSIGNED NOT NULL,
  attribute_value_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (product_id) REFERENCES product(product_id),
  FOREIGN KEY (attribute_id) REFERENCES attribute(attribute_id),
  FOREIGN KEY (attribute_value_id) REFERENCES attribute_value(attribute_value_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: PRODUCT ATTIBUTE
============================================================================================= */

CREATE INDEX idx_product_attribute_product_id ON product_attribute(product_id);
CREATE INDEX idx_product_attribute_attribute_id ON product_attribute(attribute_id);
CREATE INDEX idx_product_attribute_attribute_value_id ON product_attribute(attribute_value_id);

/* =============================================================================================
  INITIAL VALUES: PRODUCT ATTIBUTE
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: PRODUCT VARIANT
============================================================================================= */

DROP TABLE IF EXISTS product_variant;

CREATE TABLE product_variant (
  product_variant_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
  parent_product_id INT UNSIGNED NOT NULL,
  parent_product_name VARCHAR(200) NOT NULL,
  product_id INT UNSIGNED NOT NULL,
  product_name VARCHAR(200) NOT NULL,
  attribute_id INT UNSIGNED NOT NULL,
  attribute_name VARCHAR(100) NOT NULL,
  attribute_value_id INT UNSIGNED NOT NULL,
  attribute_value_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (parent_product_id) REFERENCES product(product_id),
  FOREIGN KEY (product_id) REFERENCES product(product_id),
  FOREIGN KEY (attribute_id) REFERENCES attribute(attribute_id),
  FOREIGN KEY (attribute_value_id) REFERENCES attribute_value(attribute_value_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id),
  UNIQUE KEY uq_variant_value (product_id, attribute_value_id)
);

/* =============================================================================================
  INDEX: PRODUCT VARIANT
============================================================================================= */

CREATE INDEX idx_product_variant_parent_product_id ON product_variant(parent_product_id);
CREATE INDEX idx_product_variant_product_id ON product_variant(product_id);
CREATE INDEX idx_product_variant_attribute_id ON product_variant(attribute_id);
CREATE INDEX idx_product_variant_attribute_value_id ON product_variant(attribute_value_id);

/* =============================================================================================
  INITIAL VALUES: PRODUCT VARIANT
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: PRODUCT PRICELIST
============================================================================================= */

DROP TABLE IF EXISTS product_pricelist;

CREATE TABLE product_pricelist (
  product_pricelist_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
  product_id INT UNSIGNED NOT NULL,
  product_name VARCHAR(200) NOT NULL,
  discount_type ENUM('Percentage','Fixed Amount') DEFAULT 'Percentage',
  fixed_price DECIMAL(10,2) DEFAULT 0,
  min_quantity INT DEFAULT 0,
  validity_start_date DATE NOT NULL,
  validity_end_date DATE,
  remarks VARCHAR(1000),
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (product_id) REFERENCES product(product_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: PRODUCT PRICELIST
============================================================================================= */

CREATE INDEX idx_product_pricelist_product_id ON product_pricelist(product_id);
CREATE INDEX idx_product_pricelist_discount_type ON product_pricelist(discount_type);
CREATE INDEX idx_product_pricelist_validity_start_date ON product_pricelist(validity_start_date);
CREATE INDEX idx_product_pricelist_validity_end_date ON product_pricelist(validity_end_date);

/* =============================================================================================
  INITIAL VALUES: PRODUCT PRICELIST
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: PHYSICAL INVENTORY
============================================================================================= */

DROP TABLE IF EXISTS physical_inventory;

CREATE TABLE physical_inventory (
  physical_inventory_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
  product_id INT UNSIGNED NOT NULL,
  product_name VARCHAR(200) NOT NULL,
  physical_inventory_status ENUM('Pending','Applied') DEFAULT 'Pending',
  quantity_on_hand DECIMAL(15,4) DEFAULT 0,
  inventory_count DECIMAL(15,4) DEFAULT 0,
  inventory_difference DECIMAL(15,4) DEFAULT 0,
  inventory_date DATE NOT NULL,
  inventory_by INT UNSIGNED DEFAULT 1,
  remarks VARCHAR(1000),
  applied_date DATETIME,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (product_id) REFERENCES product(product_id),
  FOREIGN KEY (inventory_by) REFERENCES user_account(inventory_by),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: PHYSICAL INVENTORY
============================================================================================= */

CREATE INDEX idx_physical_inventory_product_id ON physical_inventory(product_id);
CREATE INDEX idx_physical_inventory_inventory_by ON physical_inventory(inventory_by);
CREATE INDEX idx_physical_inventory_inventory_date ON physical_inventory(inventory_date);
CREATE INDEX idx_physical_inventory_inventory_status ON physical_inventory(physical_inventory_status);

/* =============================================================================================
  INITIAL VALUES: PHYSICAL INVENTORY
============================================================================================= */

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */




/* =============================================================================================
  TABLE: SCRAP REASON
============================================================================================= */

DROP TABLE IF EXISTS scrap_reason;

CREATE TABLE scrap_reason (
  scrap_reason_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  scrap_reason_name VARCHAR(100) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: DEPARTURE REASON
============================================================================================= */

/* =============================================================================================
  INITIAL VALUES: DEPARTURE REASON
============================================================================================= */

INSERT INTO scrap_reason (scrap_reason_name)
VALUES
('Damaged During Handling'),
('Expired Product'),
('Quality Control Failure'),
('Obsolete or Outdated'),
('Incorrect Production'),
('Contamination'),
('Packaging Defect'),
('Customer Return - Unsellable'),
('Overproduction'),
('Storage Damage (Moisture/Heat/Cold)'),
('Inventory Count Adjustment'),
('Lost or Missing'),
('Sample or Testing Use'),
('Product Recall'),
('Theft or Pilferage');

/* =============================================================================================
  END OF TABLE DEFINITIONS
============================================================================================= */



/* =============================================================================================
  TABLE: INVENTORY SCRAP
============================================================================================= */

DROP TABLE IF EXISTS inventory_scrap;

CREATE TABLE inventory_scrap (
  inventory_scrap_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
  product_id INT UNSIGNED NOT NULL,
  product_name VARCHAR(200) NOT NULL,
  reference_number VARCHAR(500),
  inventory_scrap_status ENUM('Draft','Completed') DEFAULT 'Draft',
  quantity_on_hand DECIMAL(15,4) DEFAULT 0,
  scrap_quantity DECIMAL(15,4) DEFAULT 0,
  scrap_reason_id INT UNSIGNED NOT NULL,
  scrap_reason_name VARCHAR(100) NOT NULL,
  detailed_scrap_reason VARCHAR(5000),
  completed_date DATETIME,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_log_by INT UNSIGNED DEFAULT 1,
  FOREIGN KEY (product_id) REFERENCES product(product_id),
  FOREIGN KEY (scrap_reason_id) REFERENCES scrap_reason(scrap_reason_id),
  FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

/* =============================================================================================
  INDEX: INVENTORY SCRAP
============================================================================================= */

CREATE INDEX idx_inventory_scrap_product_id ON inventory_scrap(product_id);
CREATE INDEX idx_inventory_scrap_scrap_reason_id ON inventory_scrap(scrap_reason_id);
CREATE INDEX idx_inventory_scrap_status ON inventory_scrap(inventory_scrap_status);

/* =============================================================================================
  INITIAL VALUES: INVENTORY SCRAPs
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