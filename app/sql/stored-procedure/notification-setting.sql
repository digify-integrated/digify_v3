DELIMITER //

/* =============================================================================================
   STORED PROCEDURES FOR NOTIFICATION SETTINGS
   ---------------------------------------------------------------------------------------------
   Purpose:
     - Manage CRUD operations for notification settings and templates
     - Support system, email, and SMS notifications
     - Provide fetch and generate methods for reporting and UI display
   ---------------------------------------------------------------------------------------------
   Maintenance Notes:
     - Use consistent naming: verbs (check, save, update, delete, fetch, generate)
     - All procedures include error handling with rollback
     - Keep parameters descriptive and consistent across procedures
============================================================================================= */


/* =============================================================================================
   SECTION 1: CHECK PROCEDURES
   ---------------------------------------------------------------------------------------------
   Validate notification setting existence.
============================================================================================= */

DROP PROCEDURE IF EXISTS checkNotificationSettingExist//
CREATE PROCEDURE checkNotificationSettingExist(
    IN p_notification_setting_id INT
)
BEGIN
    SELECT COUNT(*) AS total
    FROM notification_setting
    WHERE notification_setting_id = p_notification_setting_id;
END //


/* =============================================================================================
   SECTION 2: SAVE PROCEDURES
   ---------------------------------------------------------------------------------------------
   Insert or update records for notification settings and templates.
============================================================================================= */

-- Save or update notification setting (master record)
DROP PROCEDURE IF EXISTS saveNotificationSetting//
CREATE PROCEDURE saveNotificationSetting(
    IN  p_notification_setting_id INT, 
    IN  p_notification_setting_name VARCHAR(100), 
    IN  p_notification_setting_description VARCHAR(200),
    IN  p_last_log_by INT, 
    OUT p_new_notification_setting_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    START TRANSACTION;

    -- Insert if new, otherwise update
    IF p_notification_setting_id IS NULL 
       OR NOT EXISTS (SELECT 1 FROM notification_setting WHERE notification_setting_id = p_notification_setting_id) THEN
        
        INSERT INTO notification_setting (
            notification_setting_name, 
            notification_setting_description, 
            last_log_by
        ) VALUES (
            p_notification_setting_name, 
            p_notification_setting_description, 
            p_last_log_by
        );
        
        SET p_new_notification_setting_id = LAST_INSERT_ID();

    ELSE
        UPDATE notification_setting
        SET notification_setting_name        = p_notification_setting_name,
            notification_setting_description = p_notification_setting_description,
            last_log_by                      = p_last_log_by
        WHERE notification_setting_id = p_notification_setting_id;

        SET p_new_notification_setting_id = p_notification_setting_id;
    END IF;

    COMMIT;
END //


-- Save or update system notification template
DROP PROCEDURE IF EXISTS saveSystemNotificationTemplate//
CREATE PROCEDURE saveSystemNotificationTemplate(
    IN p_notification_setting_id INT, 
    IN p_system_notification_title VARCHAR(200),
    IN p_system_notification_message VARCHAR(200),
    IN p_last_log_by INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    START TRANSACTION;

    IF p_notification_setting_id IS NULL 
       OR NOT EXISTS (SELECT 1 FROM notification_setting_system_template WHERE notification_setting_id = p_notification_setting_id) THEN
        
        INSERT INTO notification_setting_system_template (
            notification_setting_id, 
            system_notification_title, 
            system_notification_message, 
            last_log_by
        ) VALUES (
            p_notification_setting_id, 
            p_system_notification_title, 
            p_system_notification_message, 
            p_last_log_by
        );

    ELSE
        UPDATE notification_setting_system_template
        SET system_notification_title   = p_system_notification_title,
            system_notification_message = p_system_notification_message,
            last_log_by                 = p_last_log_by
        WHERE notification_setting_id = p_notification_setting_id;
    END IF;

    COMMIT;
END //


-- Save or update email notification template
DROP PROCEDURE IF EXISTS saveEmailNotificationTemplate//
CREATE PROCEDURE saveEmailNotificationTemplate(
    IN p_notification_setting_id INT, 
    IN p_email_notification_subject VARCHAR(200),
    IN p_email_notification_body LONGTEXT,
    IN p_email_setting_id INT,
    IN p_email_setting_name VARCHAR(100),
    IN p_last_log_by INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    START TRANSACTION;

    IF p_notification_setting_id IS NULL 
       OR NOT EXISTS (SELECT 1 FROM notification_setting_email_template WHERE notification_setting_id = p_notification_setting_id) THEN
        
        INSERT INTO notification_setting_email_template (
            notification_setting_id, 
            email_notification_subject, 
            email_notification_body, 
            email_setting_id, 
            email_setting_name, 
            last_log_by
        ) VALUES (
            p_notification_setting_id, 
            p_email_notification_subject, 
            p_email_notification_body, 
            p_email_setting_id, 
            p_email_setting_name, 
            p_last_log_by
        );

    ELSE
        UPDATE notification_setting_email_template
        SET email_notification_subject = p_email_notification_subject,
            email_notification_body    = p_email_notification_body,
            email_setting_id           = p_email_setting_id,
            email_setting_name         = p_email_setting_name,
            last_log_by                = p_last_log_by
        WHERE notification_setting_id = p_notification_setting_id;
    END IF;

    COMMIT;
END //


-- Save or update SMS notification template
DROP PROCEDURE IF EXISTS saveSMSNotificationTemplate//
CREATE PROCEDURE saveSMSNotificationTemplate(
    IN p_notification_setting_id INT, 
    IN p_sms_notification_message VARCHAR(500),
    IN p_last_log_by INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    START TRANSACTION;

    IF p_notification_setting_id IS NULL 
       OR NOT EXISTS (SELECT 1 FROM notification_setting_sms_template WHERE notification_setting_id = p_notification_setting_id) THEN
        
        INSERT INTO notification_setting_sms_template (
            notification_setting_id, 
            sms_notification_message, 
            last_log_by
        ) VALUES (
            p_notification_setting_id, 
            p_sms_notification_message, 
            p_last_log_by
        );

    ELSE
        UPDATE notification_setting_sms_template
        SET sms_notification_message = p_sms_notification_message,
            last_log_by              = p_last_log_by
        WHERE notification_setting_id = p_notification_setting_id;
    END IF;

    COMMIT;
END //


/* =============================================================================================
   SECTION 3: UPDATE PROCEDURES
   ---------------------------------------------------------------------------------------------
   Update notification channel values (system, email, SMS).
============================================================================================= */

DROP PROCEDURE IF EXISTS updateNotificationChannel//
CREATE PROCEDURE updateNotificationChannel(
    IN p_notification_setting_id INT, 
    IN p_notification_channel VARCHAR(10), 
    IN p_notification_channel_value TINYINT,
    IN p_last_log_by INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    START TRANSACTION;

    IF p_notification_channel = 'system' THEN
        UPDATE notification_setting
        SET system_notification = p_notification_channel_value,
            last_log_by         = p_last_log_by
        WHERE notification_setting_id = p_notification_setting_id;

    ELSEIF p_notification_channel = 'email' THEN
        UPDATE notification_setting
        SET email_notification = p_notification_channel_value,
            last_log_by        = p_last_log_by
        WHERE notification_setting_id = p_notification_setting_id;

    ELSE
        UPDATE notification_setting
        SET sms_notification = p_notification_channel_value,
            last_log_by      = p_last_log_by
        WHERE notification_setting_id = p_notification_setting_id;
    END IF;

    COMMIT;
END //


/* =============================================================================================
   SECTION 4: DELETE PROCEDURES
   ---------------------------------------------------------------------------------------------
   Safely remove notification setting and its related templates.
============================================================================================= */

DROP PROCEDURE IF EXISTS deleteNotificationSetting//
CREATE PROCEDURE deleteNotificationSetting(
    IN p_notification_setting_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    START TRANSACTION;

    IF p_notification_setting_id IS NOT NULL 
       AND EXISTS (SELECT 1 FROM notification_setting WHERE notification_setting_id = p_notification_setting_id) THEN
        
        DELETE FROM notification_setting_email_template  WHERE notification_setting_id = p_notification_setting_id;
        DELETE FROM notification_setting_system_template WHERE notification_setting_id = p_notification_setting_id;
        DELETE FROM notification_setting_sms_template    WHERE notification_setting_id = p_notification_setting_id;
        DELETE FROM notification_setting                 WHERE notification_setting_id = p_notification_setting_id;
    END IF;  

    COMMIT;
END //


/* =============================================================================================
   SECTION 5: FETCH PROCEDURES
   ---------------------------------------------------------------------------------------------
   Retrieve notification settings and templates.
============================================================================================= */

DROP PROCEDURE IF EXISTS fetchNotificationSetting//
CREATE PROCEDURE fetchNotificationSetting(
    IN p_notification_setting_id INT
)
BEGIN
    SELECT * 
    FROM notification_setting
    WHERE notification_setting_id = p_notification_setting_id;
END //

DROP PROCEDURE IF EXISTS fetchEmailNotificationTemplate//
CREATE PROCEDURE fetchEmailNotificationTemplate(
    IN p_notification_setting_id INT
)
BEGIN
    SELECT * 
    FROM notification_setting_email_template
    WHERE notification_setting_id = p_notification_setting_id;
END //

DROP PROCEDURE IF EXISTS fetchSystemNotificationTemplate//
CREATE PROCEDURE fetchSystemNotificationTemplate(
    IN p_notification_setting_id INT
)
BEGIN
    SELECT * 
    FROM notification_setting_system_template
    WHERE notification_setting_id = p_notification_setting_id;
END //

DROP PROCEDURE IF EXISTS fetchSmsNotificationTemplate//
CREATE PROCEDURE fetchSmsNotificationTemplate(
    IN p_notification_setting_id INT
)
BEGIN
    SELECT * 
    FROM notification_setting_sms_template
    WHERE notification_setting_id = p_notification_setting_id;
END //


/* =============================================================================================
   SECTION 6: GENERATE PROCEDURES
   ---------------------------------------------------------------------------------------------
   Provide tabular data for reporting and UI display.
============================================================================================= */

DROP PROCEDURE IF EXISTS generateNotificationSettingTable//
CREATE PROCEDURE generateNotificationSettingTable()
BEGIN
    SELECT notification_setting_id, 
           notification_setting_name, 
           notification_setting_description
    FROM notification_setting 
    ORDER BY notification_setting_id;
END //


/* =============================================================================================
   END OF PROCEDURES
============================================================================================= */
