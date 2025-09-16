DELIMITER //

/* =============================================================================================
   STORED PROCEDURE: AUTHENTICATION
============================================================================================= */

/* =============================================================================================
   SECTION 1: SAVE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS saveResetToken//

CREATE PROCEDURE saveResetToken(
    IN p_user_account_id INT,
    IN p_reset_token VARCHAR(255),
    IN p_reset_token_expiry_date DATETIME
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_user_account_id IS NULL OR NOT EXISTS (SELECT 1 FROM reset_token WHERE user_account_id = p_user_account_id) THEN
        INSERT INTO reset_token (
            user_account_id,
            reset_token,
            reset_token_expiry_date
        )
        VALUES (
            p_user_account_id,
            p_reset_token,
            p_reset_token_expiry_date
        );
    ELSE
        UPDATE reset_token
        SET reset_token                 = p_reset_token,
            reset_token_expiry_date     = p_reset_token_expiry_date
        WHERE user_account_id           = p_user_account_id;
    END IF;
    
    COMMIT;
END //


DROP PROCEDURE IF EXISTS saveSession//

CREATE PROCEDURE saveSession(
    IN p_user_account_id INT,
    IN p_session_token VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE sessions
    SET session_token       = p_session_token
    WHERE user_account_id   = p_user_account_id;

    IF ROW_COUNT() = 0 THEN
        INSERT INTO sessions (
            user_account_id,
            session_token
        )
        VALUES (
            p_user_account_id,
            p_session_token
        );
    END IF;

    COMMIT;
END //


DROP PROCEDURE IF EXISTS saveOTP//

CREATE PROCEDURE saveOTP(
    IN p_user_account_id INT,
    IN p_otp VARCHAR(255),
    IN p_otp_expiry_date DATETIME
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE otp
    SET otp                 = p_otp,
        otp_expiry_date     = p_otp_expiry_date
    WHERE user_account_id   = p_user_account_id;

    IF ROW_COUNT() = 0 THEN
        INSERT INTO otp (
            user_account_id,
            otp,
            otp_expiry_date
        )
        VALUES (
            p_user_account_id,
            p_otp, p_otp_expiry_date
        );
    END IF;

    COMMIT;
END //


/* =============================================================================================
   SECTION 2: INSERT PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS insertLoginAttempt//

CREATE PROCEDURE insertLoginAttempt(
    IN p_user_account_id INT,
    IN p_email VARCHAR(255),
    IN p_ip_address VARCHAR(45),
    IN p_success TINYINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    DECLARE EXIT HANDLER FOR SQLWARNING ROLLBACK;

    START TRANSACTION;

    INSERT INTO login_attempts (
        user_account_id,
        email,
        ip_address,
        success
    )
    VALUES (
        p_user_account_id,
        p_email,
        p_ip_address,
        p_success
    );

    IF p_success = 1 THEN
        UPDATE user_account 
        SET last_connection_date    = NOW()
        WHERE user_account_id       = p_user_account_id;
    ELSE
        UPDATE user_account 
        SET last_failed_connection_date     = NOW()
        WHERE user_account_id               = p_user_account_id;
    END IF;

    COMMIT;
END //


/* =============================================================================================
   SECTION 3: UPDATE PROCEDURES
=============================================================================================  */

DROP PROCEDURE IF EXISTS updateFailedOTPAttempts//

CREATE PROCEDURE updateFailedOTPAttempts(
    IN p_user_account_id INT,
    IN p_failed_otp_attempts TINYINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE otp
    SET failed_otp_attempts     = p_failed_otp_attempts
    WHERE user_account_id       = p_user_account_id;

    COMMIT;
END //


DROP PROCEDURE IF EXISTS updateResetTokenAsExpired//

CREATE PROCEDURE updateResetTokenAsExpired(
    IN p_user_account_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE reset_token
    SET reset_token_expiry_date     = NOW()
    WHERE user_account_id           = p_user_account_id;

    COMMIT;
END //


DROP PROCEDURE IF EXISTS updateUserPassword//

CREATE PROCEDURE updateUserPassword(
    IN p_user_account_id INT,
    IN p_password VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE user_account
    SET password                = p_password,
        last_log_by             = p_user_account_id
    WHERE user_account_id       = p_user_account_id;

    COMMIT;
END //

DROP PROCEDURE IF EXISTS updateOTPAsExpired//

CREATE PROCEDURE updateOTPAsExpired(
    IN p_user_account_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE otp
    SET otp_expiry_date     = NOW()
    WHERE user_account_id   = p_user_account_id;

    COMMIT;
END //

/* =============================================================================================
   SECTION 4: FETCH PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS fetchLoginCredentials//

CREATE PROCEDURE fetchLoginCredentials(
    IN p_credential VARCHAR(255)
)
BEGIN
    SELECT *
    FROM user_account
    WHERE user_account_id = CAST(p_credential AS UNSIGNED) OR email = BINARY p_credential
    LIMIT 1;
END //

DROP PROCEDURE IF EXISTS fetchOTP//

CREATE PROCEDURE fetchOTP(
    IN p_user_account_id INT
)
BEGIN
    SELECT otp,
           otp_expiry_date,
           failed_otp_attempts
    FROM otp
    WHERE user_account_id = p_user_account_id
    LIMIT 1;
END //

DROP PROCEDURE IF EXISTS fetchResetToken//

CREATE PROCEDURE fetchResetToken(
    IN p_user_account_id INT
)
BEGIN
    SELECT reset_token,
           reset_token_expiry_date
    FROM reset_token
    WHERE user_account_id = p_user_account_id
    LIMIT 1;
END //

DROP PROCEDURE IF EXISTS fetchSession//

CREATE PROCEDURE fetchSession(
    IN p_user_account_id INT
)
BEGIN
    SELECT session_token
    FROM sessions
    WHERE user_account_id = p_user_account_id
    LIMIT 1;
END //

DROP PROCEDURE IF EXISTS fetchAppModuleStack//

CREATE PROCEDURE fetchAppModuleStack(
    IN p_user_account_id INT
)
BEGIN
    SELECT DISTINCT(am.app_module_id) as app_module_id, am.app_module_name, am.menu_item_id, app_logo, app_module_description
    FROM app_module am
    JOIN menu_item mi ON mi.app_module_id = am.app_module_id
    WHERE EXISTS (
        SELECT 1
        FROM role_permission mar
        WHERE mar.menu_item_id = mi.menu_item_id
        AND mar.read_access = 1
        AND mar.role_id IN (
            SELECT role_id
            FROM role_user_account
            WHERE user_account_id = p_user_account_id
        )
    )
    ORDER BY am.order_sequence, am.app_module_name;
END //

DROP PROCEDURE IF EXISTS fetchLogNotes//

CREATE PROCEDURE fetchLogNotes(
    IN p_table_name VARCHAR(255),
    IN p_reference_id INT
)
BEGIN
	SELECT log, changed_by, changed_at
    FROM audit_log
    WHERE table_name = p_table_name AND reference_id  = p_reference_id
    ORDER BY changed_at DESC;
END //


/* =============================================================================================
   SECTION 5: DELETE PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 6: CHECK PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS checkLoginCredentialsExist//

CREATE PROCEDURE checkLoginCredentialsExist(
    IN p_credential VARCHAR(255)
)
BEGIN
    SELECT COUNT(*) AS total
    FROM user_account
    WHERE user_account_id = CAST(p_credential AS UNSIGNED) OR email = BINARY p_credential;
END //

DROP PROCEDURE IF EXISTS checkUserSystemActionPermission//

CREATE PROCEDURE checkUserSystemActionPermission(
    IN p_user_account_id INT,
    IN p_system_action_id INT
)
BEGIN
    SELECT COUNT(role_id) AS total
    FROM role_system_action_permission 
    WHERE system_action_id = p_system_action_id
      AND system_action_access = 1
      AND role_id IN (
            SELECT role_id 
            FROM role_user_account 
            WHERE user_account_id = p_user_account_id
          );
END //

DROP PROCEDURE IF EXISTS checkUserPermission//

CREATE PROCEDURE checkUserPermission(
    IN p_user_account_id INT,
    IN p_menu_item_id INT,
    IN p_access_type VARCHAR(20)
)
BEGIN
    DECLARE v_total INT;

    SELECT COUNT(rua.role_id) INTO v_total
    FROM role_user_account rua
    JOIN role_permission rp ON rua.role_id = rp.role_id
    WHERE rua.user_account_id = p_user_account_id
      AND rp.menu_item_id = p_menu_item_id
      AND (
            (p_access_type = 'read'      AND rp.read_access   = 1) OR
            (p_access_type = 'write'     AND rp.write_access  = 1) OR
            (p_access_type = 'create'    AND rp.create_access = 1) OR
            (p_access_type = 'delete'    AND rp.delete_access = 1) OR
            (p_access_type = 'import'    AND rp.import_access = 1) OR
            (p_access_type = 'export'    AND rp.export_access = 1) OR
            (p_access_type = 'log notes' AND rp.log_notes_access = 1)
        );

    SELECT v_total AS total;
END //

DROP PROCEDURE IF EXISTS checkRateLimited//

CREATE PROCEDURE checkRateLimited(
    IN p_email VARCHAR(255),
    IN p_ip_address VARCHAR(45),
    IN p_window INT
)
BEGIN
    SELECT COUNT(*) AS total
    FROM login_attempts
    WHERE attempt_time >= NOW() - INTERVAL p_window SECOND
      AND success = 0
      AND (ip_address = p_ip_address 
           OR email = p_email);
END //

/* =============================================================================================
   SECTION 7: GENERATE PROCEDURES
============================================================================================= */

/* =============================================================================================
   END OF PROCEDURES
============================================================================================= */



/* =============================================================================================
   STORED PROCEDURE: USER ACCOUNT
============================================================================================= */

/* =============================================================================================
   SECTION 1: SAVE PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 2: INSERT PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS insertUserAccount//

CREATE PROCEDURE insertUserAccount(
    IN p_file_as VARCHAR(300), 
    IN p_email VARCHAR(255), 
    IN p_password VARCHAR(255),
    IN p_phone VARCHAR(50), 
    IN p_last_log_by INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO user_account (
        file_as,
        email,
        password,
        phone,
        last_log_by
    ) 
    VALUES(
        p_file_as,
        p_email,
        p_password,
        p_phone,
        p_last_log_by
    );

    COMMIT;

    SELECT LAST_INSERT_ID() AS new_user_account_id;
END //

/* =============================================================================================
   SECTION 3: UPDATE PROCEDURES
=============================================================================================  */

DROP PROCEDURE IF EXISTS updateUserAccount //

CREATE PROCEDURE updateUserAccount (
    IN p_user_account_id INT, 
    IN p_value VARCHAR(500),
    IN p_update_type VARCHAR(50),
    IN p_last_log_by INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    CASE p_update_type
        WHEN 'email' THEN
            UPDATE user_account
            SET email = p_value,
                last_log_by = p_last_log_by
            WHERE user_account_id = p_user_account_id;

        WHEN 'phone' THEN
            UPDATE user_account
            SET phone = p_value,
                last_log_by = p_last_log_by
            WHERE user_account_id = p_user_account_id;

        WHEN 'password' THEN
            UPDATE user_account
            SET password = p_value,
                last_password_change = NOW(),
                last_log_by = p_last_log_by
            WHERE user_account_id = p_user_account_id;

        WHEN 'profile picture' THEN
            UPDATE user_account
            SET profile_picture = p_value,
                last_log_by = p_last_log_by
            WHERE user_account_id = p_user_account_id;

        WHEN 'two factor auth' THEN
            UPDATE user_account
            SET two_factor_auth = p_value,
                last_log_by = p_last_log_by
            WHERE user_account_id = p_user_account_id;

        WHEN 'multiple session' THEN
            UPDATE user_account
            SET multiple_session = p_value,
                last_log_by = p_last_log_by
            WHERE user_account_id = p_user_account_id;

        WHEN 'status' THEN
            UPDATE user_account
            SET active = p_value,
                last_log_by = p_last_log_by
            WHERE user_account_id = p_user_account_id;

        ELSE
            UPDATE role_user_account
            SET file_as             = p_value,
                last_log_by         = p_last_log_by
            WHERE user_account_id   = p_user_account_id;

            UPDATE user_account
            SET file_as             = p_value,
                last_log_by         = p_last_log_by
            WHERE user_account_id   = p_user_account_id;
    END CASE;

    COMMIT;
END //

/* =============================================================================================
   SECTION 4: FETCH PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS fetchUserAccount//

CREATE PROCEDURE fetchUserAccount(
    IN p_user_account_id INT
)
BEGIN
	SELECT * FROM user_account
	WHERE user_account_id = p_user_account_id
    LIMIT 1;
END //

/* =============================================================================================
   SECTION 5: DELETE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS deleteUserAccount//

CREATE PROCEDURE deleteUserAccount(
    IN p_user_account_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM reset_token
    WHERE user_account_id = p_user_account_id;

    DELETE FROM otp
    WHERE user_account_id = p_user_account_id;

    DELETE FROM sessions
    WHERE user_account_id = p_user_account_id;

    DELETE FROM role_user_account
    WHERE user_account_id = p_user_account_id;

    DELETE FROM user_account
    WHERE user_account_id = p_user_account_id;

    COMMIT;
END //

/* =============================================================================================
   SECTION 6: CHECK PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS checkUserAccountExist//

CREATE PROCEDURE checkUserAccountExist(
    IN p_user_account_id INT
)
BEGIN
	SELECT COUNT(*) AS total
    FROM user_account
    WHERE user_account_id = p_user_account_id;
END //

DROP PROCEDURE IF EXISTS checkUserAccountEmailExist//

CREATE PROCEDURE checkUserAccountEmailExist(
    IN p_user_account_id INT,
    IN p_email VARCHAR(255)
)
BEGIN
	SELECT COUNT(*) AS total
    FROM user_account
    WHERE user_account_id != p_user_account_id AND email = p_email;
END //

DROP PROCEDURE IF EXISTS checkUserAccountPhoneExist//

CREATE PROCEDURE checkUserAccountPhoneExist(
    IN p_user_account_id INT,
    IN p_phone VARCHAR(50)
)
BEGIN
	SELECT COUNT(*) AS total
    FROM user_account
    WHERE user_account_id != p_user_account_id AND phone = p_phone;
END //

/* =============================================================================================
   SECTION 7: GENERATE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS generateUserAccountTable//

CREATE PROCEDURE generateUserAccountTable(
    IN p_active VARCHAR(5)
)
BEGIN
    DECLARE query TEXT DEFAULT 
        'SELECT user_account_id, file_as, email, profile_picture, active, last_connection_date, last_failed_connection_date
        FROM user_account WHERE 1=1';

    IF p_active IS NOT NULL AND p_active <> '' THEN
        SET query = CONCAT(query, ' AND active = ', QUOTE(p_active));
    END IF;

    SET query = CONCAT(query, ' ORDER BY file_as');

    PREPARE stmt FROM query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DROP PROCEDURE IF EXISTS generateUserAccountOptions//

CREATE PROCEDURE generateUserAccountOptions()
BEGIN
	SELECT user_account_id, user_account_name 
    FROM user_account 
    ORDER BY user_account_name;
END //

/* =============================================================================================
   END OF PROCEDURES
============================================================================================= */



/* =============================================================================================
   STORED PROCEDURE: NOTIFICATION SETTING
============================================================================================= */

/* =============================================================================================
   SECTION 1: SAVE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS saveNotificationSetting//

CREATE PROCEDURE saveNotificationSetting(
    IN  p_notification_setting_id INT, 
    IN  p_notification_setting_name VARCHAR(100), 
    IN  p_notification_setting_description VARCHAR(200),
    IN  p_last_log_by INT
)
BEGIN
    DECLARE v_new_notification_setting_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_notification_setting_id IS NULL OR NOT EXISTS (SELECT 1 FROM notification_setting WHERE notification_setting_id = p_notification_setting_id) THEN
        INSERT INTO notification_setting (
            notification_setting_name, 
            notification_setting_description, 
            last_log_by
        ) VALUES (
            p_notification_setting_name, 
            p_notification_setting_description, 
            p_last_log_by
        );

        SET v_new_notification_setting_id = LAST_INSERT_ID();
    ELSE
        UPDATE notification_setting
        SET notification_setting_name           = p_notification_setting_name,
            notification_setting_description    = p_notification_setting_description,
            last_log_by                         = p_last_log_by
        WHERE notification_setting_id           = p_notification_setting_id;
        
        SET v_new_notification_setting_id = p_notification_setting_id;
    END IF;

    COMMIT;

    SELECT v_new_notification_setting_id AS new_notification_setting_id;
END //

DROP PROCEDURE IF EXISTS saveSystemNotificationTemplate//

CREATE PROCEDURE saveSystemNotificationTemplate(
    IN p_notification_setting_id INT, 
    IN p_system_notification_title VARCHAR(200),
    IN p_system_notification_message VARCHAR(200),
    IN p_last_log_by INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

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
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

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

DROP PROCEDURE IF EXISTS saveSMSNotificationTemplate//

CREATE PROCEDURE saveSMSNotificationTemplate(
    IN p_notification_setting_id INT, 
    IN p_sms_notification_message VARCHAR(500),
    IN p_last_log_by INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

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
   SECTION 2: INSERT PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 3: UPDATE PROCEDURES
=============================================================================================  */

DROP PROCEDURE IF EXISTS updateNotificationChannel//

CREATE PROCEDURE updateNotificationChannel(
    IN p_notification_setting_id INT, 
    IN p_notification_channel VARCHAR(10), 
    IN p_notification_channel_value TINYINT,
    IN p_last_log_by INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_notification_channel = 'system' THEN
        UPDATE notification_setting
        SET system_notification         = p_notification_channel_value,
            last_log_by                 = p_last_log_by
        WHERE notification_setting_id   = p_notification_setting_id;

    ELSEIF p_notification_channel = 'email' THEN
        UPDATE notification_setting
        SET email_notification          = p_notification_channel_value,
            last_log_by                 = p_last_log_by
        WHERE notification_setting_id   = p_notification_setting_id;

    ELSE
        UPDATE notification_setting
        SET sms_notification            = p_notification_channel_value,
            last_log_by                 = p_last_log_by
        WHERE notification_setting_id   = p_notification_setting_id;
    END IF;

    COMMIT;
END //

/* =============================================================================================
   SECTION 4: FETCH PROCEDURES
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
   SECTION 5: DELETE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS deleteNotificationSetting//

CREATE PROCEDURE deleteNotificationSetting(
    IN p_notification_setting_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM notification_setting_email_template 
    WHERE notification_setting_id = p_notification_setting_id;

    DELETE FROM notification_setting_system_template
    WHERE notification_setting_id = p_notification_setting_id;

    DELETE FROM notification_setting_sms_template
    WHERE notification_setting_id = p_notification_setting_id;

    DELETE FROM notification_setting
    WHERE notification_setting_id = p_notification_setting_id; 
   
    COMMIT;
END //

/* =============================================================================================
   SECTION 6: CHECK PROCEDURES
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
   SECTION 7: GENERATE PROCEDURES
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



/* =============================================================================================
   STORED PROCEDURE: APP MODULE
============================================================================================= */

/* =============================================================================================
   SECTION 1: SAVE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS saveAppModule//

CREATE PROCEDURE saveAppModule(
    IN p_app_module_id INT, 
    IN p_app_module_name VARCHAR(100), 
    IN p_app_module_description VARCHAR(500), 
    IN p_menu_item_id INT, 
    IN p_menu_item_name VARCHAR(100), 
    IN p_order_sequence TINYINT(10), 
    IN p_last_log_by INT
)
BEGIN
    DECLARE v_new_app_module_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_app_module_id IS NULL OR NOT EXISTS (SELECT 1 FROM app_module WHERE app_module_id = p_app_module_id) THEN
        INSERT INTO app_module (
            app_module_name,
            app_module_description,
            menu_item_id,
            menu_item_name,
            order_sequence,
            last_log_by
        ) 
        VALUES(
            p_app_module_name,
            p_app_module_description,
            p_menu_item_id, p_menu_item_name,
            p_order_sequence,
            p_last_log_by
        );
        
        SET v_new_app_module_id = LAST_INSERT_ID();
    ELSE
        UPDATE menu_item
        SET app_module_name = p_app_module_name,
            last_log_by = p_last_log_by
        WHERE app_module_id = p_app_module_id;

        UPDATE app_module
        SET app_module_name         = p_app_module_name,
            app_module_description  = p_app_module_description,
            menu_item_id            = p_menu_item_id,
            menu_item_name          = p_menu_item_name,
            order_sequence          = p_order_sequence,
            last_log_by             = p_last_log_by
        WHERE app_module_id         = p_app_module_id;
        
        SET v_new_app_module_id = p_app_module_id;
    END IF;

    COMMIT;

    SELECT v_new_app_module_id AS new_app_module_id;
END //

/* =============================================================================================
   SECTION 2: INSERT PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 3: UPDATE PROCEDURES
=============================================================================================  */

DROP PROCEDURE IF EXISTS updateAppLogo//

CREATE PROCEDURE updateAppLogo(
	IN p_app_module_id INT, 
	IN p_app_logo VARCHAR(500), 
	IN p_last_log_by INT
)
BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE app_module
    SET app_logo        = p_app_logo,
        last_log_by     = p_last_log_by
    WHERE app_module_id = p_app_module_id;

    COMMIT;
END //

/* =============================================================================================
   SECTION 4: FETCH PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS fetchAppModule//

CREATE PROCEDURE fetchAppModule(
    IN p_app_module_id INT
)
BEGIN
	SELECT * FROM app_module
	WHERE app_module_id = p_app_module_id
    LIMIT 1;
END //

/* =============================================================================================
   SECTION 5: DELETE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS deleteAppModule//

CREATE PROCEDURE deleteAppModule(
    IN p_app_module_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM app_module
    WHERE app_module_id = p_app_module_id;

    COMMIT;
END //

/* =============================================================================================
   SECTION 6: CHECK PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS checkAppModuleExist//

CREATE PROCEDURE checkAppModuleExist(
    IN p_app_module_id INT
)
BEGIN
	SELECT COUNT(*) AS total
    FROM app_module
    WHERE app_module_id = p_app_module_id;
END //

/* =============================================================================================
   SECTION 7: GENERATE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS generateAppModuleTable//

CREATE PROCEDURE generateAppModuleTable()
BEGIN
	SELECT app_module_id, app_module_name, app_module_description, app_logo, order_sequence 
    FROM app_module 
    ORDER BY app_module_name;
END //

DROP PROCEDURE IF EXISTS generateAppModuleOptions//

CREATE PROCEDURE generateAppModuleOptions()
BEGIN
	SELECT app_module_id, app_module_name 
    FROM app_module 
    ORDER BY app_module_name;
END //

/* =============================================================================================
   END OF PROCEDURES
============================================================================================= */



/* =============================================================================================
   STORED PROCEDURE: ROLE
============================================================================================= */

/* =============================================================================================
   SECTION 1: SAVE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS saveRole//

CREATE PROCEDURE saveRole(
    IN p_role_id INT,
    IN p_role_name VARCHAR(100),
    IN p_role_description VARCHAR(200),
    IN p_last_log_by INT
)
BEGIN
    DECLARE v_new_role_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_role_id IS NULL OR NOT EXISTS (SELECT 1 FROM role WHERE role_id = p_role_id) THEN
        INSERT INTO role (
            role_name,
            role_description,
            last_log_by
        ) 
	    VALUES(
            p_role_name,
            p_role_description,
            p_last_log_by
        );
        
        SET v_new_role_id = LAST_INSERT_ID();
    ELSE
        UPDATE role_permission
        SET role_name       = p_role_name,
            last_log_by     = p_last_log_by
        WHERE role_id       = p_role_id;

        UPDATE role_system_action_permission
        SET role_name       = p_role_name,
            last_log_by     = p_last_log_by
        WHERE role_id       = p_role_id;

        UPDATE role_user_account
        SET role_name       = p_role_name,
            last_log_by     = p_last_log_by
        WHERE role_id       = p_role_id;

        UPDATE role
        SET role_name           = p_role_name,
            role_name           = p_role_name,
            role_description    = p_role_description,
            last_log_by         = p_last_log_by
        WHERE role_id           = p_role_id;
        
        SET v_new_role_id = p_role_id;
    END IF;
    
    COMMIT;

    SELECT v_new_role_id AS new_role_id;
END //

/* =============================================================================================
   SECTION 2: INSERT PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS insertRolePermission//

CREATE PROCEDURE insertRolePermission(
    IN p_role_id INT,
    IN p_role_name VARCHAR(100),
    IN p_menu_item_id INT,
    IN p_menu_item_name VARCHAR(100),
    IN p_last_log_by INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO role_permission (
        role_id,
        role_name,
        menu_item_id,
        menu_item_name,
        last_log_by
    ) 
	VALUES(
        p_role_id,
        p_role_name,
        p_menu_item_id,
        p_menu_item_name,
        p_last_log_by
    );

    COMMIT;
END //

DROP PROCEDURE IF EXISTS insertRoleSystemActionPermission//

CREATE PROCEDURE insertRoleSystemActionPermission(
    IN p_role_id INT,
    IN p_role_name VARCHAR(100),
    IN p_system_action_id INT,
    IN p_system_action_name VARCHAR(100),
    IN p_last_log_by INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO role_system_action_permission (
        role_id,
        role_name,
        system_action_id,
        system_action_name,
        last_log_by
    ) 
	VALUES(
        p_role_id, p_role_name,
        p_system_action_id,
        p_system_action_name,
        p_last_log_by
    );

    COMMIT;
END //

DROP PROCEDURE IF EXISTS insertRoleUserAccount//

CREATE PROCEDURE insertRoleUserAccount(
    IN p_role_id INT,
    IN p_role_name VARCHAR(100),
    IN p_user_account_id INT,
    IN p_file_as VARCHAR(100),
    IN p_last_log_by INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO role_user_account (
        role_id,
        role_name,
        user_account_id,
        file_as,
        last_log_by
    ) 
	VALUES(
        p_role_id,
        p_role_name,
        p_user_account_id,
        p_file_as, 
        p_last_log_by
    );

    COMMIT;
END //

/* =============================================================================================
   SECTION 3: UPDATE PROCEDURES
=============================================================================================  */

DROP PROCEDURE IF EXISTS updateRolePermission//

CREATE PROCEDURE updateRolePermission(
    IN p_role_permission_id INT,
    IN p_access_type VARCHAR(10),
    IN p_access TINYINT(1),
    IN p_last_log_by INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE role_permission
    SET 
        read_access      = CASE WHEN p_access_type = 'read'      THEN p_access ELSE read_access END,
        write_access     = CASE WHEN p_access_type = 'write'     THEN p_access ELSE write_access END,
        create_access    = CASE WHEN p_access_type = 'create'    THEN p_access ELSE create_access END,
        delete_access    = CASE WHEN p_access_type = 'delete'    THEN p_access ELSE delete_access END,
        import_access    = CASE WHEN p_access_type = 'import'    THEN p_access ELSE import_access END,
        export_access    = CASE WHEN p_access_type = 'export'    THEN p_access ELSE export_access END,
        log_notes_access = CASE WHEN p_access_type = 'log notes' THEN p_access ELSE log_notes_access END,
        last_log_by      = p_last_log_by
    WHERE role_permission_id = p_role_permission_id;

    COMMIT;
END //

DROP PROCEDURE IF EXISTS updateRoleSystemActionPermission//

CREATE PROCEDURE updateRoleSystemActionPermission(
    IN p_role_system_action_permission_id INT,
    IN p_system_action_access TINYINT(1),
    IN p_last_log_by INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE role_system_action_permission
    SET system_action_access                = p_system_action_access,
        last_log_by                         = p_last_log_by
    WHERE role_system_action_permission_id  = p_role_system_action_permission_id;

    COMMIT;
END //

/* =============================================================================================
   SECTION 4: FETCH PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS fetchRole//

CREATE PROCEDURE fetchRole(
    IN p_role_id INT
)
BEGIN
	SELECT * FROM role
    WHERE role_id = p_role_id
    LIMIT 1;
END //

/* =============================================================================================
   SECTION 5: DELETE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS deleteRole//

CREATE PROCEDURE deleteRole(
    IN p_role_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM role_permission
    WHERE role_id = p_role_id;

    DELETE FROM role_system_action_permission
    WHERE role_id = p_role_id;

    DELETE FROM role_user_account
    WHERE role_id = p_role_id;

    DELETE FROM role
    WHERE role_id = p_role_id;

    COMMIT;
END //

DROP PROCEDURE IF EXISTS deleteRolePermission//

CREATE PROCEDURE deleteRolePermission(
    IN p_role_permission_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM role_permission
    WHERE role_permission_id = p_role_permission_id;

    COMMIT;
END //

DROP PROCEDURE IF EXISTS deleteRoleSystemActionPermission//

CREATE PROCEDURE deleteRoleSystemActionPermission(
    IN p_role_system_action_permission_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM role_system_action_permission
    WHERE role_system_action_permission_id = p_role_system_action_permission_id;

    COMMIT;
END //

DROP PROCEDURE IF EXISTS deleteRoleUserAccount//

CREATE PROCEDURE deleteRoleUserAccount(
    IN p_role_user_account_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM role_user_account
    WHERE role_user_account_id = p_role_user_account_id;
    
    COMMIT;
END //

/* =============================================================================================
   SECTION 6: CHECK PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS checkRoleExist//

CREATE PROCEDURE checkRoleExist(
    IN p_role_id INT
)
BEGIN
	SELECT COUNT(*) AS total
    FROM role
    WHERE role_id = p_role_id;
END //

DROP PROCEDURE IF EXISTS checkRolePermissionExist//

CREATE PROCEDURE checkRolePermissionExist(
    IN p_role_permission_id INT
)
BEGIN
	SELECT COUNT(*) AS total
    FROM role_permission
    WHERE role_permission_id = p_role_permission_id;
END //

DROP PROCEDURE IF EXISTS checkRoleSystemActionPermissionExist//

CREATE PROCEDURE checkRoleSystemActionPermissionExist(
    IN p_role_system_action_permission_id INT
)
BEGIN
	SELECT COUNT(*) AS total
    FROM role_system_action_permission
    WHERE role_system_action_permission_id = p_role_system_action_permission_id;
END //

DROP PROCEDURE IF EXISTS checkRoleUserAccountExist//

CREATE PROCEDURE checkRoleUserAccountExist(
    IN p_role_user_account_id INT
)
BEGIN
	SELECT COUNT(*) AS total
    FROM role_user_account
    WHERE role_user_account_id = p_role_user_account_id;
END //

/* =============================================================================================
   SECTION 7: GENERATE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS generateRoleTable//

CREATE PROCEDURE generateRoleTable()
BEGIN
	SELECT role_id, role_name, role_description
    FROM role 
    ORDER BY role_id;
END //

DROP PROCEDURE IF EXISTS generateRoleMenuItemPermissionTable//

CREATE PROCEDURE generateRoleMenuItemPermissionTable(
    IN p_role_id INT
)
BEGIN
	SELECT role_permission_id, menu_item_name, read_access, write_access, create_access, delete_access, import_access, export_access, log_notes_access
    FROM role_permission
    WHERE role_id = p_role_id
    ORDER BY menu_item_name;
END //

DROP PROCEDURE IF EXISTS generateRoleSystemActionPermissionTable//

CREATE PROCEDURE generateRoleSystemActionPermissionTable(
    IN p_role_id INT
)
BEGIN
	SELECT role_system_action_permission_id, system_action_name, system_action_access 
    FROM role_system_action_permission
    WHERE role_id = p_role_id
    ORDER BY system_action_name;
END //

DROP PROCEDURE IF EXISTS generateRoleUserAccountTable//

CREATE PROCEDURE generateRoleUserAccountTable(
    IN p_role_id INT
)
BEGIN
	SELECT role_user_account_id, user_account_id, file_as 
    FROM role_user_account
    WHERE role_id = p_role_id
    ORDER BY file_as;
END //

DROP PROCEDURE IF EXISTS generateUserAccountRoleList//

CREATE PROCEDURE generateUserAccountRoleList(
    IN p_user_account_id INT
)
BEGIN
	SELECT role_user_account_id, role_name, date_assigned
    FROM role_user_account
    WHERE user_account_id = p_user_account_id
    ORDER BY role_name;
END //

DROP PROCEDURE IF EXISTS generateRoleAssignedMenuItemTable//

CREATE PROCEDURE generateRoleAssignedMenuItemTable(
    IN p_role_id INT
)
BEGIN
    SELECT role_permission_id, menu_item_name, read_access, write_access, create_access, delete_access, import_access, export_access, log_notes_access 
    FROM role_permission
    WHERE role_id = p_role_id;
END //

DROP PROCEDURE IF EXISTS generateRoleAssignedSystemActionTable//

CREATE PROCEDURE generateRoleAssignedSystemActionTable(
    IN p_role_id INT
)
BEGIN
    SELECT role_system_action_permission_id, system_action_name, system_action_access 
    FROM role_system_action_permission
    WHERE role_id = p_role_id;
END //

DROP PROCEDURE IF EXISTS generateUserAccountRoleDualListBoxOptions//

CREATE PROCEDURE generateUserAccountRoleDualListBoxOptions(
    IN p_user_account_id INT
)
BEGIN
	SELECT role_id, role_name 
    FROM role 
    WHERE role_id NOT IN (SELECT role_id FROM role_user_account WHERE user_account_id = p_user_account_id)
    ORDER BY role_name;
END //

DROP PROCEDURE IF EXISTS generateSystemActionRoleDualListBoxOptions//

CREATE PROCEDURE generateSystemActionRoleDualListBoxOptions(
    IN p_system_action_id INT
)
BEGIN
	SELECT role_id, role_name 
    FROM role 
    WHERE role_id NOT IN (SELECT role_id FROM role_system_action_permission WHERE system_action_id = p_system_action_id)
    ORDER BY role_name;
END //

DROP PROCEDURE IF EXISTS generateRoleMenuItemDualListBoxOptions//

CREATE PROCEDURE generateRoleMenuItemDualListBoxOptions(
    IN p_role_id INT
)
BEGIN
	SELECT menu_item_id, menu_item_name 
    FROM menu_item 
    WHERE menu_item_id NOT IN (SELECT menu_item_id FROM role_permission WHERE role_id = p_role_id)
    ORDER BY menu_item_name;
END //

DROP PROCEDURE IF EXISTS generateRoleSystemActionDualListBoxOptions//

CREATE PROCEDURE generateRoleSystemActionDualListBoxOptions(
    IN p_role_id INT
)
BEGIN
	SELECT system_action_id, system_action_name 
    FROM system_action
    WHERE system_action_id NOT IN (SELECT system_action_id FROM role_system_action_permission WHERE role_id = p_role_id)
    ORDER BY system_action_name;
END //

/* =============================================================================================
   END OF PROCEDURES
============================================================================================= */



/* =============================================================================================
   STORED PROCEDURE: MENU ITEM
============================================================================================= */

/* =============================================================================================
   SECTION 1: SAVE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS saveMenuItem//

CREATE PROCEDURE saveMenuItem(
    IN p_menu_item_id INT, 
    IN p_menu_item_name VARCHAR(100), 
    IN p_menu_item_url VARCHAR(50), 
    IN p_menu_item_icon VARCHAR(50), 
    IN p_app_module_id INT, 
    IN p_app_module_name VARCHAR(100), 
    IN p_parent_id INT, 
    IN p_parent_name VARCHAR(100), 
    IN p_table_name VARCHAR(100), 
    IN p_order_sequence TINYINT(10), 
    IN p_last_log_by INT
)
BEGIN
    DECLARE v_new_menu_item_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_menu_item_id IS NULL OR NOT EXISTS (SELECT 1 FROM menu_item WHERE menu_item_id = p_menu_item_id) THEN
        INSERT INTO menu_item (
            menu_item_name,
            menu_item_url,
            menu_item_icon,
            app_module_id,
            app_module_name,
            parent_id,
            parent_name,
            table_name,
            order_sequence,
            last_log_by
        ) 
        VALUES(
            p_menu_item_name,
            p_menu_item_url,
            p_menu_item_icon,
            p_app_module_id,
            p_app_module_name,
            p_parent_id,
            p_parent_name,
            p_table_name,
            p_order_sequence,
            p_last_log_by
        );
        
        SET v_new_menu_item_id = LAST_INSERT_ID();
    ELSE
        UPDATE role_permission
        SET menu_item_name  = p_menu_item_name,
            last_log_by     = p_last_log_by
        WHERE menu_item_id  = p_menu_item_id;
            
        UPDATE menu_item
        SET parent_name     = p_menu_item_name,
            last_log_by     = p_last_log_by
        WHERE parent_id     = p_menu_item_id;

        UPDATE menu_item
        SET menu_item_name  = p_menu_item_name,
            menu_item_url   = p_menu_item_url,
            menu_item_icon  = p_menu_item_icon,
            app_module_id   = p_app_module_id,
            app_module_name = p_app_module_name,
            parent_id       = p_parent_id,
            parent_name     = p_parent_name,
            table_name      = p_table_name,
            order_sequence  = p_order_sequence,
            last_log_by     = p_last_log_by
        WHERE menu_item_id  = p_menu_item_id;
        
        SET v_new_menu_item_id = p_menu_item_id;
    END IF;

    COMMIT;

    SELECT v_new_menu_item_id AS new_menu_item_id;
END //

/* =============================================================================================
   SECTION 2: INSERT PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 3: UPDATE PROCEDURES
=============================================================================================  */

/* =============================================================================================
   SECTION 4: FETCH PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS fetchMenuItem//

CREATE PROCEDURE fetchMenuItem(
    IN p_menu_item_id INT
)
BEGIN
	SELECT * FROM menu_item
	WHERE menu_item_id = p_menu_item_id
    LIMIT 1;
END //

DROP PROCEDURE IF EXISTS fetchBreadcrumb//

CREATE PROCEDURE fetchBreadcrumb(
    IN p_page_id INT
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE current_id INT DEFAULT p_page_id;
    
    DECLARE menu_name VARCHAR(100);
    DECLARE menu_url VARCHAR(50);
    DECLARE parent INT;
    
    DECLARE breadcrumb_cursor CURSOR FOR
        SELECT menu_item_name, menu_item_url, parent_id
        FROM menu_item
        WHERE menu_item_id = current_id;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    CREATE TEMPORARY TABLE IF NOT EXISTS BreadcrumbTrail (
        menu_item_name VARCHAR(100),
        menu_item_url VARCHAR(50)
    );
    
    OPEN breadcrumb_cursor;
    
    read_loop: LOOP
        FETCH breadcrumb_cursor INTO menu_name, menu_url, parent;
        
        IF done THEN
            LEAVE read_loop;
        END IF;

        IF current_id != p_page_id THEN
            INSERT INTO BreadcrumbTrail (menu_item_name, menu_item_url) 
            VALUES (menu_name, menu_url);
        END IF;

        SET current_id = parent;
        
        IF current_id IS NULL THEN
            LEAVE read_loop;
        END IF;
        
        CLOSE breadcrumb_cursor;
        OPEN breadcrumb_cursor;
    END LOOP read_loop;

    CLOSE breadcrumb_cursor;

    SELECT * FROM BreadcrumbTrail ORDER BY FIELD(menu_item_name, menu_item_name);

    DROP TEMPORARY TABLE BreadcrumbTrail;
END //

DROP PROCEDURE IF EXISTS fetchNavBar//

CREATE PROCEDURE fetchNavBar(
    IN p_user_account_id INT,
    IN p_app_module_id INT
)
BEGIN
    SELECT 
    mi.menu_item_id,
    mi.menu_item_name,
    mi.menu_item_url,
    mi.parent_id,
    mi.app_module_id,
    mi.menu_item_icon,
    mi.order_sequence
    FROM menu_item AS mi
    INNER JOIN role_permission AS mar ON mi.menu_item_id = mar.menu_item_id
    INNER JOIN role_user_account AS ru ON mar.role_id = ru.role_id
    WHERE mar.read_access = 1 AND ru.user_account_id = p_user_account_id AND mi.app_module_id = p_app_module_id
    ORDER BY mi.order_sequence, mi.menu_item_name;
END //

/* =============================================================================================
   SECTION 5: DELETE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS deleteMenuItem//

CREATE PROCEDURE deleteMenuItem(
    IN p_menu_item_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM role_permission
    WHERE menu_item_id = p_menu_item_id;

    DELETE FROM menu_item
    WHERE menu_item_id = p_menu_item_id;

    COMMIT;
END //

/* =============================================================================================
   SECTION 6: CHECK PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS checkMenuItemExist//

CREATE PROCEDURE checkMenuItemExist(
    IN p_menu_item_id INT
)
BEGIN
	SELECT COUNT(*) AS total
    FROM menu_item
    WHERE menu_item_id = p_menu_item_id;
END //

/* =============================================================================================
   SECTION 7: GENERATE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS generateMenuItemTable//

CREATE PROCEDURE generateMenuItemTable(
    IN p_filter_by_app_module TEXT,
    IN p_filter_by_parent_id TEXT
)
BEGIN
    DECLARE query TEXT DEFAULT 
        'SELECT menu_item_id, menu_item_name, app_module_name, parent_name, order_sequence
        FROM menu_item WHERE 1=1';

    IF p_filter_by_app_module IS NOT NULL AND p_filter_by_app_module <> '' THEN
        SET query = CONCAT(query, ' AND app_module_id IN (', p_filter_by_app_module, ')');
    END IF;

    IF p_filter_by_parent_id IS NOT NULL AND p_filter_by_parent_id <> '' THEN
        SET query = CONCAT(query, ' AND parent_id IN (', p_filter_by_parent_id, ')');
    END IF;

    SET query = CONCAT(query, ' ORDER BY menu_item_name');

    PREPARE stmt FROM query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DROP PROCEDURE IF EXISTS generateMenuItemAssignedRoleTable//

CREATE PROCEDURE generateMenuItemAssignedRoleTable(
    IN p_menu_item_id INT
)
BEGIN
    SELECT role_permission_id, role_name, read_access, write_access, create_access, delete_access, import_access, export_access, log_notes_access 
    FROM role_permission
    WHERE menu_item_id = p_menu_item_id;
END //

DROP PROCEDURE IF EXISTS generateMenuItemOptions//

CREATE PROCEDURE generateMenuItemOptions(
    IN p_menu_item_id INT
)
BEGIN
    IF p_menu_item_id IS NOT NULL AND p_menu_item_id != '' THEN
        SELECT menu_item_id, menu_item_name 
        FROM menu_item 
        WHERE menu_item_id != p_menu_item_id
        ORDER BY menu_item_name;
    ELSE
        SELECT menu_item_id, menu_item_name 
        FROM menu_item 
        ORDER BY menu_item_name;
    END IF;
END //

DROP PROCEDURE IF EXISTS generateMenuItemRoleDualListBoxOptions//

CREATE PROCEDURE generateMenuItemRoleDualListBoxOptions(
    IN p_menu_item_id INT
)
BEGIN
	SELECT role_id, role_name 
    FROM role 
    WHERE role_id NOT IN (SELECT role_id FROM role_permission WHERE menu_item_id = p_menu_item_id)
    ORDER BY role_name;
END //

/* =============================================================================================
   END OF PROCEDURES
============================================================================================= */



/* =============================================================================================
   STORED PROCEDURE: SYSTEM ACTION
============================================================================================= */

/* =============================================================================================
   SECTION 1: SAVE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS saveSystemAction//

CREATE PROCEDURE saveSystemAction(
    IN p_system_action_id INT, 
    IN p_system_action_name VARCHAR(100), 
    IN p_system_action_description VARCHAR(200),
    IN p_last_log_by INT
)
BEGIN
    DECLARE v_new_system_action_id INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_system_action_id IS NULL OR NOT EXISTS (SELECT 1 FROM system_action WHERE system_action_id = p_system_action_id) THEN
        INSERT INTO system_action (
            system_action_name,
            system_action_description,
            last_log_by
        ) 
        VALUES(
            p_system_action_name,
            p_system_action_description,
            p_last_log_by
        );
        
        SET v_new_system_action_id = LAST_INSERT_ID();
    ELSE
        UPDATE role_system_action_permission
        SET system_action_name  = p_system_action_name,
            last_log_by         = p_last_log_by
        WHERE system_action_id  = p_system_action_id;

        UPDATE system_action
        SET system_action_name          = p_system_action_name,
            system_action_description   = p_system_action_description,
            last_log_by                 = p_last_log_by
        WHERE system_action_id          = p_system_action_id;
        
        SET v_new_system_action_id = p_system_action_id;
    END IF;

    COMMIT;

    SELECT v_new_system_action_id AS new_system_action_id;
END //

/* =============================================================================================
   SECTION 2: INSERT PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 3: UPDATE PROCEDURES
=============================================================================================  */

/* =============================================================================================
   SECTION 4: FETCH PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS fetchSystemAction//

CREATE PROCEDURE fetchSystemAction(
    IN p_system_action_id INT
)
BEGIN
	SELECT * FROM system_action
	WHERE system_action_id = p_system_action_id
    LIMIT 1;
END //

/* =============================================================================================
   SECTION 5: DELETE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS deleteSystemAction//

CREATE PROCEDURE deleteSystemAction(
    IN p_system_action_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM role_system_action_permission
    WHERE system_action_id = p_system_action_id;
    
    DELETE FROM system_action
    WHERE system_action_id = p_system_action_id;

    COMMIT;
END //

/* =============================================================================================
   SECTION 6: CHECK PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS checkSystemActionExist//

CREATE PROCEDURE checkSystemActionExist(
    IN p_system_action_id INT
)
BEGIN
	SELECT COUNT(*) AS total
    FROM system_action
    WHERE system_action_id = p_system_action_id;
END //

/* =============================================================================================
   SECTION 7: GENERATE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS generateSystemActionTable//

CREATE PROCEDURE generateSystemActionTable()
BEGIN
    SELECT system_action_id, system_action_name, system_action_description 
    FROM system_action
    ORDER BY system_action_id;
END //

DROP PROCEDURE IF EXISTS generateSystemActionOptions//

CREATE PROCEDURE generateSystemActionOptions()
BEGIN
    SELECT system_action_id, system_action_name 
    FROM system_action 
    ORDER BY system_action_name;
END //

DROP PROCEDURE IF EXISTS generateSystemActionAssignedRoleTable//

CREATE PROCEDURE generateSystemActionAssignedRoleTable(
    IN p_system_action_id INT
)
BEGIN
    SELECT role_system_action_permission_id, role_name, system_action_access 
    FROM role_system_action_permission
    WHERE system_action_id = p_system_action_id;
END //

/* =============================================================================================
   END OF PROCEDURES
============================================================================================= */



/* =============================================================================================
   STORED PROCEDURE: FILE TYPE
============================================================================================= */

/* =============================================================================================
   SECTION 1: SAVE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS saveFileType//

CREATE PROCEDURE saveFileType(
    IN p_file_type_id INT, 
    IN p_file_type_name VARCHAR(100), 
    IN p_last_log_by INT
)
BEGIN
    DECLARE v_new_file_type_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_file_type_id IS NULL OR NOT EXISTS (SELECT 1 FROM file_type WHERE file_type_id = p_file_type_id) THEN
        INSERT INTO file_type (
            file_type_name,
            last_log_by
        ) 
        VALUES(
            p_file_type_name,
            p_last_log_by
        );
        
        SET v_new_file_type_id = LAST_INSERT_ID();
    ELSE
        UPDATE file_extension
        SET file_type_name  = p_file_type_name,
            last_log_by     = p_last_log_by
        WHERE file_type_id  = p_file_type_id;

        UPDATE file_type
        SET file_type_name  = p_file_type_name,
            last_log_by     = p_last_log_by
        WHERE file_type_id  = p_file_type_id;
        
        SET v_new_file_type_id = p_file_type_id;
    END IF;

    COMMIT;

    SELECT v_new_file_type_id AS new_file_type_id;
END //

/* =============================================================================================
   SECTION 2: INSERT PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 3: UPDATE PROCEDURES
=============================================================================================  */

/* =============================================================================================
   SECTION 4: FETCH PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS fetchFileType//

CREATE PROCEDURE fetchFileType(
    IN p_file_type_id INT
)
BEGIN
	SELECT * FROM file_type
	WHERE file_type_id = p_file_type_id
    LIMIT 1;
END //

/* =============================================================================================
   SECTION 5: DELETE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS deleteFileType//

CREATE PROCEDURE deleteFileType(
    IN p_file_type_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM file_extension
    WHERE file_type_id = p_file_type_id;

    DELETE FROM file_type
    WHERE file_type_id = p_file_type_id;

    COMMIT;
END //

/* =============================================================================================
   SECTION 6: CHECK PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS checkFileTypeExist//

CREATE PROCEDURE checkFileTypeExist(
    IN p_file_type_id INT
)
BEGIN
	SELECT COUNT(*) AS total
    FROM file_type
    WHERE file_type_id = p_file_type_id;
END //

/* =============================================================================================
   SECTION 7: GENERATE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS generateFileTypeTable//

CREATE PROCEDURE generateFileTypeTable()
BEGIN
	SELECT file_type_id, file_type_name
    FROM file_type 
    ORDER BY file_type_id;
END //

DROP PROCEDURE IF EXISTS generateFileTypeOptions//

CREATE PROCEDURE generateFileTypeOptions()
BEGIN
	SELECT file_type_id, file_type_name 
    FROM file_type 
    ORDER BY file_type_name;
END //

/* =============================================================================================
   END OF PROCEDURES
============================================================================================= */



/* =============================================================================================
   STORED PROCEDURE: FILE EXTENSION
============================================================================================= */

/* =============================================================================================
   SECTION 1: SAVE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS saveFileExtension//

CREATE PROCEDURE saveFileExtension(
    IN p_file_extension_id INT, 
    IN p_file_extension_name VARCHAR(100), 
    IN p_file_extension VARCHAR(10), 
    IN p_file_type_id INT, 
    IN p_file_type_name VARCHAR(100), 
    IN p_last_log_by INT
)
BEGIN
    DECLARE v_new_file_extension_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_file_extension_id IS NULL OR NOT EXISTS (SELECT 1 FROM file_extension WHERE file_extension_id = p_file_extension_id) THEN
        INSERT INTO file_extension (
            file_extension_name,
            file_extension,
            file_type_id,
            file_type_name,
            last_log_by
        ) 
        VALUES(
            p_file_extension_name,
            p_file_extension,
            p_file_type_id,
            p_file_type_name,
            p_last_log_by
        );
        
        SET v_new_file_extension_id = LAST_INSERT_ID();
    ELSE
        UPDATE upload_setting_file_extension
        SET file_extension_name     = p_file_extension_name,
            file_extension          = p_file_extension,
            last_log_by             = p_last_log_by
        WHERE file_extension_id     = p_file_extension_id;

        UPDATE file_extension
        SET file_extension_name     = p_file_extension_name,
            file_extension          = p_file_extension,
            file_type_id            = p_file_type_id,
            file_type_name          = p_file_type_name,
            last_log_by             = p_last_log_by
        WHERE file_extension_id     = p_file_extension_id;
        
        SET v_new_file_extension_id = p_file_extension_id;
    END IF;

    COMMIT;

    SELECT v_new_file_extension_id AS new_file_extension_id;
END //

/* =============================================================================================
   SECTION 2: INSERT PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 3: UPDATE PROCEDURES
=============================================================================================  */

/* =============================================================================================
   SECTION 4: FETCH PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS fetchFileExtension//

CREATE PROCEDURE fetchFileExtension(
    IN p_file_extension_id INT
)
BEGIN
	SELECT * FROM file_extension
	WHERE file_extension_id = p_file_extension_id
    LIMIT 1;
END //

/* =============================================================================================
   SECTION 5: DELETE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS deleteFileExtension//

CREATE PROCEDURE deleteFileExtension(
    IN p_file_extension_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM upload_setting_file_extension
    WHERE file_extension_id = p_file_extension_id;

    DELETE FROM file_extension
    WHERE file_extension_id = p_file_extension_id;

    COMMIT;
END //

/* =============================================================================================
   SECTION 6: CHECK PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS checkFileExtensionExist//

CREATE PROCEDURE checkFileExtensionExist(
    IN p_file_extension_id INT
)
BEGIN
	SELECT COUNT(*) AS total
    FROM file_extension
    WHERE file_extension_id = p_file_extension_id;
END //

/* =============================================================================================
   SECTION 7: GENERATE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS generateFileExtensionTable//

CREATE PROCEDURE generateFileExtensionTable(
    IN p_filter_by_file_type TEXT
)
BEGIN
    DECLARE query TEXT;
    DECLARE filter_conditions TEXT DEFAULT '';

    SET query = 'SELECT file_extension_id, file_extension_name, file_extension, file_type_name 
                FROM file_extension ';

    IF p_filter_by_file_type IS NOT NULL AND p_filter_by_file_type <> '' THEN
        SET filter_conditions = CONCAT(filter_conditions, ' file_type_id IN (', p_filter_by_file_type, ')');
    END IF;

    IF filter_conditions <> '' THEN
        SET query = CONCAT(query, ' WHERE ', filter_conditions);
    END IF;

    SET query = CONCAT(query, ' ORDER BY file_extension_name');

    PREPARE stmt FROM query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DROP PROCEDURE IF EXISTS generateFileExtensionOptions//

CREATE PROCEDURE generateFileExtensionOptions()
BEGIN
	SELECT file_extension_id, file_extension_name, file_extension
    FROM file_extension 
    ORDER BY file_extension_name;
END //

/* =============================================================================================
   END OF PROCEDURES
============================================================================================= */



/* =============================================================================================
   STORED PROCEDURE: UPLOAD SETTING
============================================================================================= */

/* =============================================================================================
   SECTION 1: SAVE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS saveUploadSetting//

CREATE PROCEDURE saveUploadSetting(
    IN p_upload_setting_id INT, 
    IN p_upload_setting_name VARCHAR(100), 
    IN p_upload_setting_description VARCHAR(200), 
    IN p_max_file_size DOUBLE, 
    IN p_last_log_by INT, 
    OUT p_new_upload_setting_id INT
)
BEGIN
    DECLARE v_new_upload_setting_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_upload_setting_id IS NULL OR NOT EXISTS (SELECT 1 FROM upload_setting WHERE upload_setting_id = p_upload_setting_id) THEN
        INSERT INTO upload_setting (
            upload_setting_name,
            upload_setting_description,
            max_file_size,
            last_log_by
        ) 
        VALUES(
            p_upload_setting_name,
            p_upload_setting_description,
            p_max_file_size,
            p_last_log_by
        );
        
        SET v_new_upload_setting_id = LAST_INSERT_ID();
    ELSE
        UPDATE upload_setting_file_extension
        SET upload_setting_name     = p_upload_setting_name,
            last_log_by             = p_last_log_by
        WHERE upload_setting_id     = p_upload_setting_id;

        UPDATE upload_setting
        SET upload_setting_name         = p_upload_setting_name,
            upload_setting_description  = p_upload_setting_description,
            max_file_size               = p_max_file_size,
            last_log_by                 = p_last_log_by
        WHERE upload_setting_id         = p_upload_setting_id;
        
        SET v_new_upload_setting_id = p_upload_setting_id;
    END IF;

    COMMIT;

    SELECT v_new_upload_setting_id AS new_upload_setting_id;
END //

/* =============================================================================================
   SECTION 2: INSERT PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 3: UPDATE PROCEDURES
=============================================================================================  */

/* =============================================================================================
   SECTION 4: FETCH PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS fetchUploadSetting//

CREATE PROCEDURE fetchUploadSetting(
	IN p_upload_setting_id INT
)
BEGIN
	SELECT * FROM upload_setting
	WHERE upload_setting_id = p_upload_setting_id
    LIMIT 1;
END //

/* =============================================================================================
   SECTION 5: DELETE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS deleteUploadSetting//

CREATE PROCEDURE deleteUploadSetting(
    IN p_upload_setting_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM upload_setting_file_extension
    WHERE upload_setting_id = p_upload_setting_id;

    DELETE FROM upload_setting
    WHERE upload_setting_id = p_upload_setting_id;

    COMMIT;
END //

/* =============================================================================================
   SECTION 6: CHECK PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS checkUploadSettingExist//

CREATE PROCEDURE checkUploadSettingExist(
    IN p_upload_setting_id INT
)
BEGIN
	SELECT COUNT(*) AS total
    FROM upload_setting
    WHERE upload_setting_id = p_upload_setting_id;
END //

/* =============================================================================================
   SECTION 7: GENERATE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS generateUploadSettingTable//

CREATE PROCEDURE generateUploadSettingTable()
BEGIN
	SELECT upload_setting_id, upload_setting_name, upload_setting_description, max_file_size
    FROM upload_setting 
    ORDER BY upload_setting_id;
END //

/* =============================================================================================
   END OF PROCEDURES
============================================================================================= */



/* =============================================================================================
   STORED PROCEDURE: UPLOAD SETTING FILE EXTENSION
============================================================================================= */

/* =============================================================================================
   SECTION 1: SAVE PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 2: INSERT PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS insertUploadSettingFileExtension//

CREATE PROCEDURE insertUploadSettingFileExtension(
    IN p_upload_setting_id INT, 
    IN p_upload_setting_name VARCHAR(100), 
    IN p_file_extension_id INT, 
    IN p_file_extension_name VARCHAR(100), 
    IN p_file_extension VARCHAR(10), 
    IN p_last_log_by INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO upload_setting_file_extension (
        upload_setting_id,
        upload_setting_name,
        file_extension_id,
        file_extension_name,
        file_extension,
        last_log_by
    ) 
    VALUES(
        p_upload_setting_id,
        p_upload_setting_name,
        p_file_extension_id,
        p_file_extension_name,
        p_file_extension,
        p_last_log_by
    );

    COMMIT;
END //

/* =============================================================================================
   SECTION 3: UPDATE PROCEDURES
=============================================================================================  */

/* =============================================================================================
   SECTION 4: FETCH PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS fetchUploadSettingFileExtension//

CREATE PROCEDURE fetchUploadSettingFileExtension(
	IN p_upload_setting_id INT
)
BEGIN
	SELECT * FROM upload_setting_file_extension
	WHERE upload_setting_id = p_upload_setting_id;
END //

/* =============================================================================================
   SECTION 5: DELETE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS deleteUploadSettingFileExtension//

CREATE PROCEDURE deleteUploadSettingFileExtension(
    IN p_upload_setting_file_extension_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM upload_setting_file_extension 
    WHERE upload_setting_file_extension_id = p_upload_setting_file_extension_id;

    COMMIT;
END //

/* =============================================================================================
   SECTION 6: CHECK PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 7: GENERATE PROCEDURES
============================================================================================= */

/* =============================================================================================
   END OF PROCEDURES
============================================================================================= */



/* =============================================================================================
   STORED PROCEDURE: EXPORT
============================================================================================= */

/* =============================================================================================
   SECTION 1: SAVE PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 2: INSERT PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 3: UPDATE PROCEDURES
=============================================================================================  */

/* =============================================================================================
   SECTION 4: FETCH PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS fetchExportData//

CREATE PROCEDURE fetchExportData(
    IN p_table_name VARCHAR(255),
    IN p_columns TEXT,
    IN p_ids TEXT
)
BEGIN
    SET @sql = CONCAT('SELECT ', p_columns, ' FROM ', p_table_name, ' WHERE ', p_table_name, '_id IN (', p_ids, ')');

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END//

/* =============================================================================================
   SECTION 5: DELETE PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 6: CHECK PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 7: GENERATE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS generateTableOptions//

CREATE PROCEDURE generateTableOptions(
    IN p_database_name VARCHAR(255)
)
BEGIN
	SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = p_database_name;
END //

DROP PROCEDURE IF EXISTS generateExportOptions//

CREATE PROCEDURE generateExportOptions(
    IN p_databasename VARCHAR(500),
    IN p_table_name VARCHAR(500)
)
BEGIN
    SELECT column_name 
    FROM information_schema.columns 
    WHERE table_schema = p_databasename 
    AND table_name = p_table_name
    ORDER BY ordinal_position;
END //

/* =============================================================================================
   END OF PROCEDURES
============================================================================================= */


/* =============================================================================================
   STORED PROCEDURE: IMPORT
============================================================================================= */

/* =============================================================================================
   SECTION 1: SAVE PROCEDURES
============================================================================================= */

DROP PROCEDURE IF EXISTS saveImport //

CREATE PROCEDURE saveImport(
    IN p_table_name VARCHAR(255),
    IN p_columns TEXT,
    IN p_placeholders TEXT,
    IN p_updateFields TEXT,
    IN p_values TEXT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @p1 = MESSAGE_TEXT;
            SELECT @p1 AS error_message;
        ROLLBACK;
    END;

    START TRANSACTION;

    SET @sql = CONCAT(
        'INSERT INTO ', p_table_name, ' (', p_columns, ') ',
        'VALUES ', p_values, ' ',
        'ON DUPLICATE KEY UPDATE ', p_updateFields
    );

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    COMMIT;
END //


/* =============================================================================================
   SECTION 2: INSERT PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 3: UPDATE PROCEDURES
=============================================================================================  */

/* =============================================================================================
   SECTION 4: FETCH PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 5: DELETE PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 6: CHECK PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 7: GENERATE PROCEDURES
============================================================================================= */

/* =============================================================================================
   END OF PROCEDURES
============================================================================================= */



/* =============================================================================================
   STORED PROCEDURE: 
============================================================================================= */

/* =============================================================================================
   SECTION 1: SAVE PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 2: INSERT PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 3: UPDATE PROCEDURES
=============================================================================================  */

/* =============================================================================================
   SECTION 4: FETCH PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 5: DELETE PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 6: CHECK PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 7: GENERATE PROCEDURES
============================================================================================= */

/* =============================================================================================
   END OF PROCEDURES
============================================================================================= */



/* =============================================================================================
   STORED PROCEDURE: 
============================================================================================= */

/* =============================================================================================
   SECTION 1: SAVE PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 2: INSERT PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 3: UPDATE PROCEDURES
=============================================================================================  */

/* =============================================================================================
   SECTION 4: FETCH PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 5: DELETE PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 6: CHECK PROCEDURES
============================================================================================= */

/* =============================================================================================
   SECTION 7: GENERATE PROCEDURES
============================================================================================= */

/* =============================================================================================
   END OF PROCEDURES
============================================================================================= */


