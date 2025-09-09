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

DROP TRIGGER IF EXISTS trg_user_account_file_as_update//

CREATE TRIGGER trg_user_account_file_as_update
AFTER UPDATE ON user_account
FOR EACH ROW
BEGIN
    UPDATE role_user_account
    SET file_as = NEW.file_as,
        last_log_by = NEW.last_log_by
    WHERE user_account_id = NEW.user_account_id;
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
   SECTION 3: DELETE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_user_account_delete//

CREATE TRIGGER trg_user_account_delete
BEFORE DELETE ON user_account
FOR EACH ROW
BEGIN
    DELETE FROM reset_token WHERE user_account_id = OLD.user_account_id;
    DELETE FROM otp WHERE user_account_id = OLD.user_account_id;
    DELETE FROM sessions WHERE user_account_id = OLD.user_account_id;
    DELETE FROM role_user_account WHERE user_account_id = OLD.user_account_id;
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
   SECTION 3: DELETE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_notification_setting_delete//

CREATE TRIGGER trg_notification_setting_delete
BEFORE DELETE ON notification_setting
FOR EACH ROW
BEGIN
    DELETE FROM notification_setting_email_template  WHERE notification_setting_id = OLD.notification_setting_id;
    DELETE FROM notification_setting_system_template WHERE notification_setting_id = OLD.notification_setting_id;
    DELETE FROM notification_setting_sms_template    WHERE notification_setting_id = OLD.notification_setting_id;
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

DROP TRIGGER IF EXISTS trg_app_module_name_update//

CREATE TRIGGER trg_app_module_name_update
AFTER UPDATE ON app_module
FOR EACH ROW
BEGIN
    UPDATE menu_item
    SET app_module_name = NEW.app_module_name,
        last_log_by = NEW.last_log_by
    WHERE app_module_id = NEW.app_module_id;
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
   SECTION 3: DELETE TRIGGERS
============================================================================================= */

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

DROP TRIGGER IF EXISTS trg_role_name_update//

CREATE TRIGGER trg_role_name_update
AFTER UPDATE ON role
FOR EACH ROW
BEGIN
    UPDATE role_permission
    SET role_name = NEW.role_name,
        last_log_by = NEW.last_log_by
    WHERE role_id = NEW.role_id;

    UPDATE role_system_action_permission
    SET role_name = NEW.role_name,
        last_log_by = NEW.last_log_by
    WHERE role_id = NEW.role_id;

    UPDATE role_user_account
    SET role_name = NEW.role_name,
        last_log_by = NEW.last_log_by
    WHERE role_id = NEW.role_id;
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
   SECTION 3: DELETE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_role_delete//

CREATE TRIGGER trg_role_delete
BEFORE DELETE ON role
FOR EACH ROW
BEGIN
    DELETE FROM role_permission WHERE role_id = OLD.role_id;
    DELETE FROM role_system_action_permission WHERE role_id = OLD.role_id;
    DELETE FROM role_user_account WHERE role_id = OLD.role_id;
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

DROP TRIGGER IF EXISTS trg_menu_item_name_update//

CREATE TRIGGER trg_menu_item_name_update
AFTER UPDATE ON menu_item
FOR EACH ROW
BEGIN
    UPDATE role_permission
    SET menu_item_name = NEW.menu_item_name,
        last_log_by = NEW.last_log_by
    WHERE menu_item_id = NEW.menu_item_id;
        
    UPDATE menu_item
    SET parent_name = NEW.menu_item_name,
        last_log_by = NEW.last_log_by
    WHERE parent_id = NEW.menu_item_id;
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
   SECTION 3: DELETE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_menu_item_delete//

CREATE TRIGGER trg_menu_item_delete
BEFORE DELETE ON menu_item
FOR EACH ROW
BEGIN
    DELETE FROM role_permission WHERE menu_item_id = OLD.menu_item_id;
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

DROP TRIGGER IF EXISTS trg_system_action_name_update//

CREATE TRIGGER trg_system_action_name_update
AFTER UPDATE ON system_action
FOR EACH ROW
BEGIN
    UPDATE role_system_action_permission
    SET system_action_name = NEW.system_action_name,
        last_log_by = NEW.last_log_by
    WHERE system_action_id = NEW.system_action_id;
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
   SECTION 3: DELETE TRIGGERS
============================================================================================= */

DROP TRIGGER IF EXISTS trg_system_action_delete//

CREATE TRIGGER trg_system_action_delete
BEFORE DELETE ON system_action
FOR EACH ROW
BEGIN
   DELETE FROM role_system_action_permission WHERE system_action_id = OLD.system_action_id;
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
   SECTION 3: DELETE TRIGGERS
============================================================================================= */

/* =============================================================================================
   END OF TRIGGERS
============================================================================================= */


