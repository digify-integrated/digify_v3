DELIMITER //

/* =============================================================================================
   TRIGGER: USER ACCOUNT
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_user_account_update//

CREATE TRIGGER trg_user_account_update
AFTER UPDATE ON user_account
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'User account changed.<br/><br/>'; -- Base message

    -- Compare fields (only those relevant for auditing)
    IF NEW.file_as <> OLD.file_as THEN
        SET audit_log = CONCAT(audit_log, "File As: ", OLD.file_as, " -> ", NEW.file_as, "<br/>");
    END IF;

    IF NEW.email <> OLD.email THEN
        SET audit_log = CONCAT(audit_log, "Email: ", OLD.email, " -> ", NEW.email, "<br/>");
    END IF;

    IF NEW.phone <> OLD.phone THEN
        SET audit_log = CONCAT(audit_log, "Phone: ", OLD.phone, " -> ", NEW.phone, "<br/>");
    END IF;

    IF NEW.active <> OLD.active THEN
        SET audit_log = CONCAT(audit_log, "Active: ", OLD.active, " -> ", NEW.active, "<br/>");
    END IF;

    IF NEW.two_factor_auth <> OLD.two_factor_auth THEN
        SET audit_log = CONCAT(audit_log, "2FA: ", OLD.two_factor_auth, " -> ", NEW.two_factor_auth, "<br/>");
    END IF;

    IF NEW.multiple_session <> OLD.multiple_session THEN
        SET audit_log = CONCAT(audit_log, "Multiple Session: ", OLD.multiple_session, " -> ", NEW.multiple_session, "<br/>");
    END IF;

    IF NEW.last_connection_date <> OLD.last_connection_date THEN
        SET audit_log = CONCAT(audit_log, "Last Connection: ", OLD.last_connection_date, " -> ", NEW.last_connection_date, "<br/>");
    END IF;

    IF NEW.last_failed_connection_date <> OLD.last_failed_connection_date THEN
        SET audit_log = CONCAT(audit_log, "Last Failed Connection: ", OLD.last_failed_connection_date, " -> ", NEW.last_failed_connection_date, "<br/>");
    END IF;

    IF NEW.last_password_change <> OLD.last_password_change THEN
        SET audit_log = CONCAT(audit_log, "Password Change: ", OLD.last_password_change, " -> ", NEW.last_password_change, "<br/>");
    END IF;

    IF NEW.last_password_reset_request <> OLD.last_password_reset_request THEN
        SET audit_log = CONCAT(audit_log, "Password Reset Request: ", OLD.last_password_reset_request, " -> ", NEW.last_password_reset_request, "<br/>");
    END IF;

    -- Insert only if something actually changed
    IF audit_log <> 'User account changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('user_account', NEW.user_account_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_user_account_insert//

CREATE TRIGGER trg_user_account_insert
AFTER INSERT ON user_account
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('user_account', NEW.user_account_id, 'User account created.', NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: NOTIFICATION SETTING
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_notification_setting_update//

CREATE TRIGGER trg_notification_setting_update
AFTER UPDATE ON notification_setting
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Notification setting changed.<br/><br/>';

    IF NEW.notification_setting_name <> OLD.notification_setting_name THEN
        SET audit_log = CONCAT(audit_log, "Notification Setting Name: ", OLD.notification_setting_name, " -> ", NEW.notification_setting_name, "<br/>");
    END IF;

    IF NEW.notification_setting_description <> OLD.notification_setting_description THEN
        SET audit_log = CONCAT(audit_log, "Notification Setting Description: ", OLD.notification_setting_description, " -> ", NEW.notification_setting_description, "<br/>");
    END IF;

    IF NEW.system_notification <> OLD.system_notification THEN
        SET audit_log = CONCAT(audit_log, "System Notification: ", OLD.system_notification, " -> ", NEW.system_notification, "<br/>");
    END IF;

    IF NEW.email_notification <> OLD.email_notification THEN
        SET audit_log = CONCAT(audit_log, "Notification Notification: ", OLD.email_notification, " -> ", NEW.email_notification, "<br/>");
    END IF;

    IF NEW.sms_notification <> OLD.sms_notification THEN
        SET audit_log = CONCAT(audit_log, "SMS Notification: ", OLD.sms_notification, " -> ", NEW.sms_notification, "<br/>");
    END IF;

    IF audit_log <> 'Notification setting changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('notification_setting', NEW.notification_setting_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

DROP TRIGGER IF EXISTS trg_notification_email_template_update//

CREATE TRIGGER trg_notification_email_template_update
AFTER UPDATE ON notification_setting_email_template
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Notification notification template changed.<br/><br/>';

    IF NEW.email_notification_subject <> OLD.email_notification_subject THEN
        SET audit_log = CONCAT(audit_log, "Notification Notification Subject: ", OLD.email_notification_subject, " -> ", NEW.email_notification_subject, "<br/>");
    END IF;

    IF NEW.email_notification_body <> OLD.email_notification_body THEN
        SET audit_log = CONCAT(audit_log, "Notification Notification Body: ", OLD.email_notification_body, " -> ", NEW.email_notification_body, "<br/>");
    END IF;

    IF audit_log <> 'Notification notification template changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('notification_setting_email_template', NEW.notification_setting_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

DROP TRIGGER IF EXISTS trg_notification_system_template_update//

CREATE TRIGGER trg_notification_system_template_update
AFTER UPDATE ON notification_setting_system_template
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'System notification template changed.<br/><br/>';

    IF NEW.system_notification_title <> OLD.system_notification_title THEN
        SET audit_log = CONCAT(audit_log, "System Notification Title: ", OLD.system_notification_title, " -> ", NEW.system_notification_title, "<br/>");
    END IF;

    IF NEW.system_notification_message <> OLD.system_notification_message THEN
        SET audit_log = CONCAT(audit_log, "System Notification Message: ", OLD.system_notification_message, " -> ", NEW.system_notification_message, "<br/>");
    END IF;

    IF audit_log <> 'System notification template changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('notification_setting_system_template', NEW.notification_setting_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

DROP TRIGGER IF EXISTS trg_notification_sms_template_update//

CREATE TRIGGER trg_notification_sms_template_update
AFTER UPDATE ON notification_setting_sms_template
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'SMS notification template changed.<br/><br/>';

    IF NEW.sms_notification_message <> OLD.sms_notification_message THEN
        SET audit_log = CONCAT(audit_log, "SMS Notification Message: ", OLD.sms_notification_message, " -> ", NEW.sms_notification_message, "<br/>");
    END IF;

    IF audit_log <> 'SMS notification template changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('notification_setting_sms_template', NEW.notification_setting_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_notification_setting_insert//

CREATE TRIGGER trg_notification_setting_insert
AFTER INSERT ON notification_setting
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Notification setting created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('notification_setting', NEW.notification_setting_id, audit_log, NEW.last_log_by, NOW());
END //

DROP TRIGGER IF EXISTS trg_notification_email_template_insert//

CREATE TRIGGER trg_notification_email_template_insert
AFTER INSERT ON notification_setting_email_template
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Notification notification template created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('notification_setting_email_template', NEW.notification_setting_id, audit_log, NEW.last_log_by, NOW());
END //

DROP TRIGGER IF EXISTS trg_notification_system_template_insert//

CREATE TRIGGER trg_notification_system_template_insert
AFTER INSERT ON notification_setting_system_template
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'System notification template created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('notification_setting_system_template', NEW.notification_setting_id, audit_log, NEW.last_log_by, NOW());
END //

DROP TRIGGER IF EXISTS trg_notification_sms_template_insert//

CREATE TRIGGER trg_notification_sms_template_insert
AFTER INSERT ON notification_setting_sms_template
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'SMS notification template created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('notification_setting_sms_template', NEW.notification_setting_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: APP MODULE
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_app_module_update//

CREATE TRIGGER trg_app_module_update
AFTER UPDATE ON app_module
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'App module changed.<br/><br/>';

    IF NEW.app_module_name <> OLD.app_module_name THEN
        SET audit_log = CONCAT(audit_log, "App Module Name: ", OLD.app_module_name, " -> ", NEW.app_module_name, "<br/>");
    END IF;

    IF NEW.app_module_description <> OLD.app_module_description THEN
        SET audit_log = CONCAT(audit_log, "App Module Description: ", OLD.app_module_description, " -> ", NEW.app_module_description, "<br/>");
    END IF;

    IF NEW.menu_item_name <> OLD.menu_item_name THEN
        SET audit_log = CONCAT(audit_log, "Menu Item: ", OLD.menu_item_name, " -> ", NEW.menu_item_name, "<br/>");
    END IF;

    IF NEW.order_sequence <> OLD.order_sequence THEN
        SET audit_log = CONCAT(audit_log, "Order Sequence: ", OLD.order_sequence, " -> ", NEW.order_sequence, "<br/>");
    END IF;
    
    IF audit_log <> 'App module changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('app_module', NEW.app_module_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_app_module_insert//

CREATE TRIGGER trg_app_module_insert
AFTER INSERT ON app_module
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'App module created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('app_module', NEW.app_module_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: ROLE
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_role_update//

CREATE TRIGGER trg_role_update
AFTER UPDATE ON role
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Role changed.<br/><br/>';

    IF NEW.role_name <> OLD.role_name THEN
        SET audit_log = CONCAT(audit_log, "Role Name: ", OLD.role_name, " -> ", NEW.role_name, "<br/>");
    END IF;

    IF NEW.role_description <> OLD.role_description THEN
        SET audit_log = CONCAT(audit_log, "Role Description: ", OLD.role_description, " -> ", NEW.role_description, "<br/>");
    END IF;
    
    IF audit_log <> 'Role changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('role', NEW.role_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

DROP TRIGGER IF EXISTS trg_role_permission_update//

CREATE TRIGGER trg_role_permission_update
AFTER UPDATE ON role_permission
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Role permission changed.<br/><br/>';

    IF NEW.role_name <> OLD.role_name THEN
        SET audit_log = CONCAT(audit_log, "Role Name: ", OLD.role_name, " -> ", NEW.role_name, "<br/>");
    END IF;

    IF NEW.menu_item_name <> OLD.menu_item_name THEN
        SET audit_log = CONCAT(audit_log, "Menu Item: ", OLD.menu_item_name, " -> ", NEW.menu_item_name, "<br/>");
    END IF;

    IF NEW.read_access <> OLD.read_access THEN
        SET audit_log = CONCAT(audit_log, "Read Access: ", OLD.read_access, " -> ", NEW.read_access, "<br/>");
    END IF;

    IF NEW.write_access <> OLD.write_access THEN
        SET audit_log = CONCAT(audit_log, "Write Access: ", OLD.write_access, " -> ", NEW.write_access, "<br/>");
    END IF;

    IF NEW.create_access <> OLD.create_access THEN
        SET audit_log = CONCAT(audit_log, "Create Access: ", OLD.create_access, " -> ", NEW.create_access, "<br/>");
    END IF;

    IF NEW.delete_access <> OLD.delete_access THEN
        SET audit_log = CONCAT(audit_log, "Delete Access: ", OLD.delete_access, " -> ", NEW.delete_access, "<br/>");
    END IF;

    IF NEW.import_access <> OLD.import_access THEN
        SET audit_log = CONCAT(audit_log, "Import Access: ", OLD.import_access, " -> ", NEW.import_access, "<br/>");
    END IF;

    IF NEW.export_access <> OLD.export_access THEN
        SET audit_log = CONCAT(audit_log, "Export Access: ", OLD.export_access, " -> ", NEW.export_access, "<br/>");
    END IF;

    IF NEW.log_notes_access <> OLD.log_notes_access THEN
        SET audit_log = CONCAT(audit_log, "Log Notes Access: ", OLD.log_notes_access, " -> ", NEW.log_notes_access, "<br/>");
    END IF;
    
    IF audit_log <> 'Role permission changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('role_permission', NEW.role_permission_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

DROP TRIGGER IF EXISTS trg_role_system_action_permission_update//

CREATE TRIGGER trg_role_system_action_permission_update
AFTER UPDATE ON role_system_action_permission
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Role system action permission changed.<br/><br/>';

    IF NEW.role_name <> OLD.role_name THEN
        SET audit_log = CONCAT(audit_log, "Role Name: ", OLD.role_name, " -> ", NEW.role_name, "<br/>");
    END IF;

    IF NEW.system_action_name <> OLD.system_action_name THEN
        SET audit_log = CONCAT(audit_log, "System Action: ", OLD.system_action_name, " -> ", NEW.system_action_name, "<br/>");
    END IF;

    IF NEW.system_action_access <> OLD.system_action_access THEN
        SET audit_log = CONCAT(audit_log, "System Action Access: ", OLD.system_action_access, " -> ", NEW.system_action_access, "<br/>");
    END IF;
    
    IF audit_log <> 'Role system action permission changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('role_system_action_permission', NEW.role_system_action_permission_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

DROP TRIGGER IF EXISTS trg_role_user_account_update//

CREATE TRIGGER trg_role_user_account_update
AFTER UPDATE ON role_user_account
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Role user account changed. <br/>';

    IF NEW.role_name <> OLD.role_name THEN
        SET audit_log = CONCAT(audit_log, "Role Name: ", OLD.role_name, " -> ", NEW.role_name, "<br/>");
    END IF;

    IF NEW.file_as <> OLD.file_as THEN
        SET audit_log = CONCAT(audit_log, "User Account Name: ", OLD.file_as, " -> ", NEW.file_as, "<br/>");
    END IF;
    
    IF audit_log <> 'Role user account changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('role_user_account', NEW.role_user_account_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_role_insert//

CREATE TRIGGER trg_role_insert
AFTER INSERT ON role
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Role created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('role', NEW.role_id, audit_log, NEW.last_log_by, NOW());
END //

DROP TRIGGER IF EXISTS trg_role_permission_insert//

CREATE TRIGGER trg_role_permission_insert
AFTER INSERT ON role_permission
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Role permission created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('role_permission', NEW.role_permission_id, audit_log, NEW.last_log_by, NOW());
END //

DROP TRIGGER IF EXISTS trg_role_system_action_permission_insert//

CREATE TRIGGER trg_role_system_action_permission_insert
AFTER INSERT ON role_system_action_permission
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Role system action permission created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('role_system_action_permission', NEW.role_system_action_permission_id, audit_log, NEW.last_log_by, NOW());
END //

DROP TRIGGER IF EXISTS trg_role_user_account_insert//

CREATE TRIGGER trg_role_user_account_insert
AFTER INSERT ON role_user_account
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Role user account created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('role_user_account', NEW.role_user_account_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: MENU ITEM
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_menu_item_update//

CREATE TRIGGER trg_menu_item_update
AFTER UPDATE ON menu_item
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Menu item changed.<br/><br/>';

    IF NEW.menu_item_name <> OLD.menu_item_name THEN
        SET audit_log = CONCAT(audit_log, "Menu Item Name: ", OLD.menu_item_name, " -> ", NEW.menu_item_name, "<br/>");
    END IF;

    IF NEW.menu_item_url <> OLD.menu_item_url THEN
        SET audit_log = CONCAT(audit_log, "Menu Item URL: ", OLD.menu_item_url, " -> ", NEW.menu_item_url, "<br/>");
    END IF;

    IF NEW.menu_item_icon <> OLD.menu_item_icon THEN
        SET audit_log = CONCAT(audit_log, "Menu Icon: ", OLD.menu_item_icon, " -> ", NEW.menu_item_icon, "<br/>");
    END IF;

    IF NEW.app_module_name <> OLD.app_module_name THEN
        SET audit_log = CONCAT(audit_log, "App Module: ", OLD.app_module_name, " -> ", NEW.app_module_name, "<br/>");
    END IF;

    IF NEW.parent_name <> OLD.parent_name THEN
        SET audit_log = CONCAT(audit_log, "Parent Menu: ", OLD.parent_name, " -> ", NEW.parent_name, "<br/>");
    END IF;

    IF NEW.order_sequence <> OLD.order_sequence THEN
        SET audit_log = CONCAT(audit_log, "Order Sequence: ", OLD.order_sequence, " -> ", NEW.order_sequence, "<br/>");
    END IF;

    IF NEW.table_name <> OLD.table_name THEN
        SET audit_log = CONCAT(audit_log, "Export Table: ", OLD.table_name, " -> ", NEW.table_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Menu item changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('menu_item', NEW.menu_item_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_menu_item_insert//

CREATE TRIGGER trg_menu_item_insert
AFTER INSERT ON menu_item
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Menu item created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('menu_item', NEW.menu_item_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: SYSTEM ACTION
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_system_action_update//

CREATE TRIGGER trg_system_action_update
AFTER UPDATE ON system_action
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'System action changed.<br/><br/>';

    IF NEW.system_action_name <> OLD.system_action_name THEN
        SET audit_log = CONCAT(audit_log, "System Action Name: ", OLD.system_action_name, " -> ", NEW.system_action_name, "<br/>");
    END IF;

    IF NEW.system_action_description <> OLD.system_action_description THEN
        SET audit_log = CONCAT(audit_log, "System Action Description: ", OLD.system_action_description, " -> ", NEW.system_action_description, "<br/>");
    END IF;
    
    IF audit_log <> 'System action changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('system_action', NEW.system_action_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_system_action_insert//

CREATE TRIGGER trg_system_action_insert
AFTER INSERT ON system_action
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'System action created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('system_action', NEW.system_action_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: FILE TYPE
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_file_type_update//

CREATE TRIGGER trg_file_type_update
AFTER UPDATE ON file_type
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'File type changed.<br/><br/>';

    IF NEW.file_type_name <> OLD.file_type_name THEN
        SET audit_log = CONCAT(audit_log, "File Type Name: ", OLD.file_type_name, " -> ", NEW.file_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'File type changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('file_type', NEW.file_type_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_file_type_insert//

CREATE TRIGGER trg_file_type_insert
AFTER INSERT ON file_type
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'File type created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('file_type', NEW.file_type_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: FILE EXTENSION
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_file_extension_update//

CREATE TRIGGER trg_file_extension_update
AFTER UPDATE ON file_extension
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'File extension changed.<br/><br/>';

    IF NEW.file_extension_name <> OLD.file_extension_name THEN
        SET audit_log = CONCAT(audit_log, "File Extension Name: ", OLD.file_extension_name, " -> ", NEW.file_extension_name, "<br/>");
    END IF;

    IF NEW.file_extension <> OLD.file_extension THEN
        SET audit_log = CONCAT(audit_log, "File Extension: ", OLD.file_extension, " -> ", NEW.file_extension, "<br/>");
    END IF;

    IF NEW.file_type_name <> OLD.file_type_name THEN
        SET audit_log = CONCAT(audit_log, "File Type: ", OLD.file_type_name, " -> ", NEW.file_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'File extension changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('file_extension', NEW.file_extension_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_file_extension_insert//

CREATE TRIGGER trg_file_extension_insert
AFTER INSERT ON file_extension
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'File extension created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('file_extension', NEW.file_extension_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: UPLOAD SETTING
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_upload_setting_update//

CREATE TRIGGER trg_upload_setting_update
AFTER UPDATE ON upload_setting
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Upload setting changed.<br/><br/>';

    IF NEW.upload_setting_name <> OLD.upload_setting_name THEN
        SET audit_log = CONCAT(audit_log, "Upload Setting Name: ", OLD.upload_setting_name, " -> ", NEW.upload_setting_name, "<br/>");
    END IF;

    IF NEW.upload_setting_description <> OLD.upload_setting_description THEN
        SET audit_log = CONCAT(audit_log, "Upload Setting Description: ", OLD.upload_setting_description, " -> ", NEW.upload_setting_description, "<br/>");
    END IF;

    IF NEW.max_file_size <> OLD.max_file_size THEN
        SET audit_log = CONCAT(audit_log, "Max File Size: ", OLD.max_file_size, " -> ", NEW.max_file_size, "<br/>");
    END IF;
    
    IF audit_log <> 'Upload setting changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('upload_setting', NEW.upload_setting_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //


/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_upload_setting_insert//

CREATE TRIGGER trg_upload_setting_insert
AFTER INSERT ON upload_setting
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Upload setting created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('upload_setting', NEW.upload_setting_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: UPLOAD SETTING FILE EXTENSION
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_upload_setting_file_update//

CREATE TRIGGER trg_upload_setting_file_update
AFTER UPDATE ON upload_setting_file_extension
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Upload setting file extension changed.<br/><br/>';

    IF NEW.upload_setting_name <> OLD.upload_setting_name THEN
        SET audit_log = CONCAT(audit_log, "Upload Setting Name: ", OLD.upload_setting_name, " -> ", NEW.upload_setting_name, "<br/>");
    END IF;

    IF NEW.file_extension_name <> OLD.file_extension_name THEN
        SET audit_log = CONCAT(audit_log, "File Extension Name: ", OLD.file_extension_name, " -> ", NEW.file_extension_name, "<br/>");
    END IF;

    IF NEW.file_extension <> OLD.file_extension THEN
        SET audit_log = CONCAT(audit_log, "File Extension: ", OLD.file_extension, " -> ", NEW.file_extension, "<br/>");
    END IF;
    
    IF audit_log <> 'Upload setting changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('upload_setting_file_extension', NEW.upload_setting_file_extension_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_upload_setting_file_insert//

CREATE TRIGGER trg_upload_setting_file_insert
AFTER INSERT ON upload_setting_file_extension
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Upload setting file extension created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('upload_setting_file_extension', NEW.upload_setting_file_extension_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: COUNTRY
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_country_update//

CREATE TRIGGER trg_country_update
AFTER UPDATE ON country
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Country changed.<br/><br/>';

    IF NEW.country_name <> OLD.country_name THEN
        SET audit_log = CONCAT(audit_log, "Country Name: ", OLD.country_name, " -> ", NEW.country_name, "<br/>");
    END IF;

    IF NEW.country_code <> OLD.country_code THEN
        SET audit_log = CONCAT(audit_log, "Country Code: ", OLD.country_code, " -> ", NEW.country_code, "<br/>");
    END IF;

    IF NEW.phone_code <> OLD.phone_code THEN
        SET audit_log = CONCAT(audit_log, "Phone Code: ", OLD.phone_code, " -> ", NEW.phone_code, "<br/>");
    END IF;
    
    IF audit_log <> 'Country changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('country', NEW.country_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_country_insert//

CREATE TRIGGER trg_country_insert
AFTER INSERT ON country
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Country created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('country', NEW.country_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: STATE
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_state_update//

CREATE TRIGGER trg_state_update
AFTER UPDATE ON state
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'State changed.<br/><br/>';

    IF NEW.state_name <> OLD.state_name THEN
        SET audit_log = CONCAT(audit_log, "State Name: ", OLD.state_name, " -> ", NEW.state_name, "<br/>");
    END IF;

    IF NEW.country_name <> OLD.country_name THEN
        SET audit_log = CONCAT(audit_log, "Country: ", OLD.country_name, " -> ", NEW.country_name, "<br/>");
    END IF;
    
    IF audit_log <> 'State changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('state', NEW.state_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_state_insert//

CREATE TRIGGER trg_state_insert
AFTER INSERT ON state
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'State created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('state', NEW.state_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: CITY
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_city_update//

CREATE TRIGGER trg_city_update
AFTER UPDATE ON city
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'City changed.<br/><br/>';

    IF NEW.city_name <> OLD.city_name THEN
        SET audit_log = CONCAT(audit_log, "City Name: ", OLD.city_name, " -> ", NEW.city_name, "<br/>");
    END IF;

    IF NEW.state_name <> OLD.state_name THEN
        SET audit_log = CONCAT(audit_log, "State: ", OLD.state_name, " -> ", NEW.state_name, "<br/>");
    END IF;

    IF NEW.country_name <> OLD.country_name THEN
        SET audit_log = CONCAT(audit_log, "Country: ", OLD.country_name, " -> ", NEW.country_name, "<br/>");
    END IF;
    
    IF audit_log <> 'City changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('city', NEW.city_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_city_insert//

CREATE TRIGGER trg_city_insert
AFTER INSERT ON city
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'City created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('city', NEW.city_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: CURRENCY
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_currency_update//

CREATE TRIGGER trg_currency_update
AFTER UPDATE ON currency
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Currency changed.<br/><br/>';

    IF NEW.currency_name <> OLD.currency_name THEN
        SET audit_log = CONCAT(audit_log, "Currency Name: ", OLD.currency_name, " -> ", NEW.currency_name, "<br/>");
    END IF;

    IF NEW.symbol <> OLD.symbol THEN
        SET audit_log = CONCAT(audit_log, "Symbol: ", OLD.symbol, " -> ", NEW.symbol, "<br/>");
    END IF;

    IF NEW.shorthand <> OLD.shorthand THEN
        SET audit_log = CONCAT(audit_log, "Shorthand: ", OLD.shorthand, " -> ", NEW.shorthand, "<br/>");
    END IF;
    
    IF audit_log <> 'Currency changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('currency', NEW.currency_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_currency_insert//

CREATE TRIGGER trg_currency_insert
AFTER INSERT ON currency
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Currency created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('currency', NEW.currency_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: COMPANY
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DELIMITER //

DROP TRIGGER IF EXISTS trg_company_update//

CREATE TRIGGER trg_company_update
AFTER UPDATE ON company
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Company changed.<br/><br/>';

    IF NEW.company_name <> OLD.company_name THEN
        SET audit_log = CONCAT(audit_log, "Company Name: ", OLD.company_name, " -> ", NEW.company_name, "<br/>");
    END IF;

    IF NEW.address <> OLD.address THEN
        SET audit_log = CONCAT(audit_log, "Address: ", OLD.address, " -> ", NEW.address, "<br/>");
    END IF;

    IF NEW.city_name <> OLD.city_name THEN
        SET audit_log = CONCAT(audit_log, "City: ", OLD.city_name, " -> ", NEW.city_name, "<br/>");
    END IF;

    IF NEW.state_name <> OLD.state_name THEN
        SET audit_log = CONCAT(audit_log, "State: ", OLD.state_name, " -> ", NEW.state_name, "<br/>");
    END IF;

    IF NEW.country_name <> OLD.country_name THEN
        SET audit_log = CONCAT(audit_log, "Country: ", OLD.country_name, " -> ", NEW.country_name, "<br/>");
    END IF;

    IF NEW.tax_id <> OLD.tax_id THEN
        SET audit_log = CONCAT(audit_log, "Tax ID: ", OLD.tax_id, " -> ", NEW.tax_id, "<br/>");
    END IF;

    IF NEW.currency_name <> OLD.currency_name THEN
        SET audit_log = CONCAT(audit_log, "Currency: ", OLD.currency_name, " -> ", NEW.currency_name, "<br/>");
    END IF;

    IF NEW.phone <> OLD.phone THEN
        SET audit_log = CONCAT(audit_log, "Phone: ", OLD.phone, " -> ", NEW.phone, "<br/>");
    END IF;

    IF NEW.telephone <> OLD.telephone THEN
        SET audit_log = CONCAT(audit_log, "Telephone: ", OLD.telephone, " -> ", NEW.telephone, "<br/>");
    END IF;

    IF NEW.email <> OLD.email THEN
        SET audit_log = CONCAT(audit_log, "Email: ", OLD.email, " -> ", NEW.email, "<br/>");
    END IF;

    IF NEW.website <> OLD.website THEN
        SET audit_log = CONCAT(audit_log, "Website: ", OLD.website, " -> ", NEW.website, "<br/>");
    END IF;
    
    IF audit_log <> 'Company changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('company', NEW.company_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_company_insert//

CREATE TRIGGER trg_company_insert
AFTER INSERT ON company
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Company created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('company', NEW.company_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: BLOOD TYPE
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_blood_type_update//

CREATE TRIGGER trg_blood_type_update
AFTER UPDATE ON blood_type
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Blood type changed.<br/><br/>';

    IF NEW.blood_type_name <> OLD.blood_type_name THEN
        SET audit_log = CONCAT(audit_log, "Blood Type Name: ", OLD.blood_type_name, " -> ", NEW.blood_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Blood type changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('blood_type', NEW.blood_type_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_blood_type_insert//

CREATE TRIGGER trg_blood_type_insert
AFTER INSERT ON blood_type
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Blood type created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('blood_type', NEW.blood_type_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: CIVIL STATUS
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_civil_status_update//

CREATE TRIGGER trg_civil_status_update
AFTER UPDATE ON civil_status
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Civil status changed.<br/><br/>';

    IF NEW.civil_status_name <> OLD.civil_status_name THEN
        SET audit_log = CONCAT(audit_log, "Civil Status Name: ", OLD.civil_status_name, " -> ", NEW.civil_status_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Civil status changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('civil_status', NEW.civil_status_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_civil_status_insert//

CREATE TRIGGER trg_civil_status_insert
AFTER INSERT ON civil_status
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Civil status created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('civil_status', NEW.civil_status_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: CREDENTIAL TYPE
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_credential_type_update//

CREATE TRIGGER trg_credential_type_update
AFTER UPDATE ON credential_type
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Credential type changed.<br/><br/>';

    IF NEW.credential_type_name <> OLD.credential_type_name THEN
        SET audit_log = CONCAT(audit_log, "Credential Type Name: ", OLD.credential_type_name, " -> ", NEW.credential_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Credential type changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('credential_type', NEW.credential_type_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_credential_type_insert//

CREATE TRIGGER trg_credential_type_insert
AFTER INSERT ON credential_type
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Credential type created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('credential_type', NEW.credential_type_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: EDUCATIONAL STAGE
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_educational_stage_update//

CREATE TRIGGER trg_educational_stage_update
AFTER UPDATE ON educational_stage
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Educational stage changed.<br/><br/>';

    IF NEW.educational_stage_name <> OLD.educational_stage_name THEN
        SET audit_log = CONCAT(audit_log, "Educational Stage Name: ", OLD.educational_stage_name, " -> ", NEW.educational_stage_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Educational stage changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('educational_stage', NEW.educational_stage_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_educational_stage_insert//

CREATE TRIGGER trg_educational_stage_insert
AFTER INSERT ON educational_stage
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Educational stage created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('educational_stage', NEW.educational_stage_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: GENDER
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_gender_update//

CREATE TRIGGER trg_gender_update
AFTER UPDATE ON gender
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Gender changed.<br/><br/>';

    IF NEW.gender_name <> OLD.gender_name THEN
        SET audit_log = CONCAT(audit_log, "Gender Name: ", OLD.gender_name, " -> ", NEW.gender_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Gender changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('gender', NEW.gender_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_gender_insert//

CREATE TRIGGER trg_gender_insert
AFTER INSERT ON gender
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Gender created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('gender', NEW.gender_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: RELATIONSHIP
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_relationship_update//

CREATE TRIGGER trg_relationship_update
AFTER UPDATE ON relationship
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Relationship changed.<br/><br/>';

    IF NEW.relationship_name <> OLD.relationship_name THEN
        SET audit_log = CONCAT(audit_log, "Relationship Name: ", OLD.relationship_name, " -> ", NEW.relationship_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Relationship changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('relationship', NEW.relationship_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_relationship_insert//

CREATE TRIGGER trg_relationship_insert
AFTER INSERT ON relationship
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Relationship created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('relationship', NEW.relationship_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: RELIGION
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_religion_update//

CREATE TRIGGER trg_religion_update
AFTER UPDATE ON religion
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Religion changed.<br/><br/>';

    IF NEW.religion_name <> OLD.religion_name THEN
        SET audit_log = CONCAT(audit_log, "Religion Name: ", OLD.religion_name, " -> ", NEW.religion_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Religion changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('religion', NEW.religion_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //


/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_religion_insert//

CREATE TRIGGER trg_religion_insert
AFTER INSERT ON religion
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Religion created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('religion', NEW.religion_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: LANGUAGE
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_language_update//

CREATE TRIGGER trg_language_update
AFTER UPDATE ON language
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Language changed.<br/><br/>';

    IF NEW.language_name <> OLD.language_name THEN
        SET audit_log = CONCAT(audit_log, "Language Name: ", OLD.language_name, " -> ", NEW.language_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Language changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('language', NEW.language_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_language_insert//

CREATE TRIGGER trg_language_insert
AFTER INSERT ON language
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Language created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('language', NEW.language_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: LANGUAGE PROFICIENCY
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_language_proficiency_update//

CREATE TRIGGER trg_language_proficiency_update
AFTER UPDATE ON language_proficiency
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Language proficiency changed.<br/><br/>';

    IF NEW.language_proficiency_name <> OLD.language_proficiency_name THEN
        SET audit_log = CONCAT(audit_log, "Language Proficiency Name: ", OLD.language_proficiency_name, " -> ", NEW.language_proficiency_name, "<br/>");
    END IF;

    IF NEW.language_proficiency_description <> OLD.language_proficiency_description THEN
        SET audit_log = CONCAT(audit_log, "Language Proficiency Description: ", OLD.language_proficiency_description, " -> ", NEW.language_proficiency_description, "<br/>");
    END IF;
    
    IF audit_log <> 'Language proficiency changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('language_proficiency', NEW.language_proficiency_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_language_proficiency_insert//

CREATE TRIGGER trg_language_proficiency_insert
AFTER INSERT ON language_proficiency
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Language proficiency created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('language_proficiency', NEW.language_proficiency_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: ADDRESS TYPE
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_address_type_update//

CREATE TRIGGER trg_address_type_update
AFTER UPDATE ON address_type
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Address type changed.<br/><br/>';

    IF NEW.address_type_name <> OLD.address_type_name THEN
        SET audit_log = CONCAT(audit_log, "Address Type Name: ", OLD.address_type_name, " -> ", NEW.address_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Address type changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('address_type', NEW.address_type_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_address_type_insert//

CREATE TRIGGER trg_address_type_insert
AFTER INSERT ON address_type
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Address type created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('address_type', NEW.address_type_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: CONTACT INFORMATION TYPE
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_contact_information_type_update//

CREATE TRIGGER trg_contact_information_type_update
AFTER UPDATE ON contact_information_type
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Contact information type changed.<br/><br/>';

    IF NEW.contact_information_type_name <> OLD.contact_information_type_name THEN
        SET audit_log = CONCAT(audit_log, "Contact Information Type Name: ", OLD.contact_information_type_name, " -> ", NEW.contact_information_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Contact information type changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('contact_information_type', NEW.contact_information_type_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_contact_information_type_insert//

CREATE TRIGGER trg_contact_information_type_insert
AFTER INSERT ON contact_information_type
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Contact information type created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('contact_information_type', NEW.contact_information_type_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: BANK
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_bank_update//

CREATE TRIGGER trg_bank_update
AFTER UPDATE ON bank
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Bank changed.<br/><br/>';

    IF NEW.bank_name <> OLD.bank_name THEN
        SET audit_log = CONCAT(audit_log, "Bank Name: ", OLD.bank_name, " -> ", NEW.bank_name, "<br/>");
    END IF;

    IF NEW.bank_identifier_code <> OLD.bank_identifier_code THEN
        SET audit_log = CONCAT(audit_log, "Bank Identifier Code: ", OLD.bank_identifier_code, " -> ", NEW.bank_identifier_code, "<br/>");
    END IF;
    
    IF audit_log <> 'Bank changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('bank', NEW.bank_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_bank_insert//

CREATE TRIGGER trg_bank_insert
AFTER INSERT ON bank
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Bank created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('bank', NEW.bank_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: BANK ACCOUNT TYPE
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_bank_account_type_update//

CREATE TRIGGER trg_bank_account_type_update
AFTER UPDATE ON bank_account_type
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Bank account type changed.<br/><br/>';

    IF NEW.bank_account_type_name <> OLD.bank_account_type_name THEN
        SET audit_log = CONCAT(audit_log, "Bank Account Type Name: ", OLD.bank_account_type_name, " -> ", NEW.bank_account_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Bank account type changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('bank_account_type', NEW.bank_account_type_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END //

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_bank_account_type_insert//

CREATE TRIGGER trg_bank_account_type_insert
AFTER INSERT ON bank_account_type
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'Bank account type created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('bank_account_type', NEW.bank_account_type_id, audit_log, NEW.last_log_by, NOW());
END //

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */



/* =============================================================================================
   TRIGGER: 
============================================================================================= */

/* =============================================================================================
   SECTION 1: UPDATE TRIGGERS
============================================================================================= */

/* =============================================================================================
   SECTION 2: INSERT TRIGGERS
============================================================================================= */

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */