DELIMITER //

---------------------------------------------------------------------------------------------
-- Save Procedures
--------------------------------------------------------------------------------------------- 

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

    IF EXISTS (SELECT 1 FROM reset_token WHERE user_account_id = p_user_account_id) THEN
        UPDATE reset_token
        SET reset_token = p_reset_token,
            reset_token_expiry_date = p_reset_token_expiry_date
        WHERE user_account_id = p_user_account_id;
    ELSE
        INSERT INTO reset_token (user_account_id, reset_token, reset_token_expiry_date)
        VALUES (p_user_account_id, p_reset_token, p_reset_token_expiry_date);
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

    IF EXISTS (SELECT 1 FROM sessions WHERE user_account_id = p_user_account_id) THEN
        UPDATE sessions
        SET session_token = p_session_token
        WHERE user_account_id = p_user_account_id;
    ELSE
        INSERT INTO sessions (user_account_id, session_token)
        VALUES (p_user_account_id, p_session_token);
    END IF;

    COMMIT;
END //

DROP PROCEDURE IF EXISTS saveOTP//

CREATE PROCEDURE saveOTP(
    IN p_user_account_id INT,
    IN p_otp VARCHAR(255),
    IN otp_expiry_date DATETIME
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF EXISTS (SELECT 1 FROM otp WHERE user_account_id = p_user_account_id) THEN
        UPDATE otp
        SET otp = p_otp,
            otp_expiry_date = otp_expiry_date
        WHERE user_account_id = p_user_account_id;
    ELSE
        INSERT INTO otp (user_account_id, otp, otp_expiry_date)
        VALUES (p_user_account_id, p_otp, otp_expiry_date);
    END IF;

    COMMIT;
END //

--------------------------------------------------------------------------------------------- 

---------------------------------------------------------------------------------------------
-- Insert Procedures
--------------------------------------------------------------------------------------------- 

DROP PROCEDURE IF EXISTS insertLoginAttempt//

CREATE PROCEDURE insertLoginAttempt(
    IN p_user_account_id INT,
    IN p_email VARCHAR(255),
    IN p_ip_address VARCHAR(45),
    IN p_success TINYINT(1)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO login_attempts (user_account_id, email, ip_address, success)
    VALUES (p_user_account_id, p_email, p_ip_address, p_success);

    COMMIT;
END //

--------------------------------------------------------------------------------------------- 

---------------------------------------------------------------------------------------------
-- Fetch Procedures
--------------------------------------------------------------------------------------------- 

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
    SET failed_otp_attempts = p_failed_otp_attempts
    WHERE user_account_id = p_user_account_id;

    COMMIT;
END //

DROP PROCEDURE IF EXISTS updateResetTokenAsExpired//

CREATE PROCEDURE updateResetTokenAsExpired(
    IN p_user_account_id INT,
    IN p_reset_token_expiry_date DATETIME
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE user_account
    SET reset_token_expiry_date = p_reset_token_expiry_date
    WHERE user_account_id = p_user_account_id;

    COMMIT;
END //

DROP PROCEDURE IF EXISTS updateResetTokenAsExpired//
CREATE PROCEDURE updateResetTokenAsExpired(
    IN p_user_account_id INT,
    IN p_reset_token_expiry_date DATETIME
)
BEGIN
    UPDATE user_account
    SET reset_token_expiry_date = p_reset_token_expiry_date
    WHERE user_account_id = p_user_account_id;
END //

DROP PROCEDURE IF EXISTS updateUserPassword//

CREATE PROCEDURE updateUserPassword(
    IN p_user_account_id INT,
    IN p_password VARCHAR(255), 
    IN p_password_expiry_date DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO password_history (user_account_id, password) 
    VALUES (p_user_account_id, p_password);

    UPDATE user_account
    SET password = p_password, 
        password_expiry_date = p_password_expiry_date,
        last_log_by = p_user_account_id
    WHERE user_account_id = p_user_account_id;

    COMMIT;
END //


--------------------------------------------------------------------------------------------- 

---------------------------------------------------------------------------------------------
-- Fetch Procedures
--------------------------------------------------------------------------------------------- 

DROP PROCEDURE IF EXISTS fetchLoginCredentials//

CREATE PROCEDURE fetchLoginCredentials(
    IN p_email VARCHAR(255)
)
BEGIN
    SELECT user_account_id,
           email,
           password_hash,
           is_active
    FROM user_account
    WHERE email = p_email
    LIMIT 1;
END //

DROP PROCEDURE IF EXISTS fetchPasswordHistory//

CREATE PROCEDURE fetchPasswordHistory(
    IN p_user_account_id INT
)
BEGIN
    SELECT password 
    FROM password_history
    WHERE user_account_id = p_user_account_id;
END //

DROP PROCEDURE IF EXISTS fetchInternalNotesAttachment//

CREATE PROCEDURE fetchInternalNotesAttachment(
    IN p_internal_notes_id INT
)
BEGIN
    SELECT * FROM internal_notes_attachment
    WHERE internal_notes_id = p_internal_notes_id;
END //

--------------------------------------------------------------------------------------------- 

---------------------------------------------------------------------------------------------
-- Check Procedures
--------------------------------------------------------------------------------------------- 

DROP PROCEDURE IF EXISTS checkLoginCredentialsExist//

CREATE PROCEDURE checkLoginCredentialsExist(
    IN p_email VARCHAR(255)
)
BEGIN
    SELECT COUNT(*) AS total
    FROM user_account
    WHERE email = BINARY p_email;
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
    AND role_id IN (SELECT role_id FROM role_user_account WHERE user_account_id = p_user_account_id);
END //

DROP PROCEDURE IF EXISTS checkUserPermission//

CREATE PROCEDURE checkUserPermission(
    IN p_user_account_id INT,
    IN p_menu_item_id INT,
    IN p_access_type VARCHAR(10)
)
BEGIN
	DECLARE v_total INT;

    SELECT COUNT(rua.role_id) INTO v_total
    FROM role_user_account rua
    JOIN role_permission rp ON rua.role_id = rp.role_id
    WHERE rua.user_account_id = p_user_account_id
      AND rp.menu_item_id = p_menu_item_id
      AND (
            (p_access_type = 'read'   AND rp.read_access   = 1) OR
            (p_access_type = 'write'  AND rp.write_access  = 1) OR
            (p_access_type = 'create' AND rp.create_access = 1) OR
            (p_access_type = 'delete' AND rp.delete_access = 1) OR
            (p_access_type = 'import' AND rp.import_access = 1) OR
            (p_access_type = 'export' AND rp.export_access = 1) OR
            (p_access_type = 'log'    AND rp.log_notes_access = 1)
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

--------------------------------------------------------------------------------------------- 