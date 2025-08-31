DELIMITER //

DROP TRIGGER IF EXISTS user_account_trigger_update//

CREATE TRIGGER user_account_trigger_update
AFTER UPDATE ON user_account
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'User account changed.<br/><br/>';

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
        SET audit_log = CONCAT(audit_log, "Two Factor Authentication: ", OLD.two_factor_auth, " -> ", NEW.two_factor_auth, "<br/>");
    END IF;

    IF NEW.multiple_session <> OLD.multiple_session THEN
        SET audit_log = CONCAT(audit_log, "Multiple Session: ", OLD.multiple_session, " -> ", NEW.multiple_session, "<br/>");
    END IF;

    IF NEW.last_connection_date <> OLD.last_connection_date THEN
        SET audit_log = CONCAT(audit_log, "Last Connection Date: ", OLD.last_connection_date, " -> ", NEW.last_connection_date, "<br/>");
    END IF;

    IF NEW.last_failed_connection_date <> OLD.last_failed_connection_date THEN
        SET audit_log = CONCAT(audit_log, "Last Failed Connection Date: ", OLD.last_failed_connection_date, " -> ", NEW.last_failed_connection_date, "<br/>");
    END IF;

    IF NEW.last_password_change <> OLD.last_password_change THEN
        SET audit_log = CONCAT(audit_log, "Last Password Change: ", OLD.last_password_change, " -> ", NEW.last_password_change, "<br/>");
    END IF;

     IF NEW.last_password_reset_request <> OLD.last_password_reset_request THEN
        SET audit_log = CONCAT(audit_log, "Last Password Reset Request: ", OLD.last_password_reset_request, " -> ", NEW.last_password_reset_request, "<br/>");
    END IF;
    
    IF audit_log <> 'User account changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('user_account', NEW.user_account_id, audit_log, NEW.last_log_by, CONVERT_TZ(NOW(), '+00:00', '+08:00'));
    END IF;
END //

DROP TRIGGER IF EXISTS user_account_trigger_insert//

CREATE TRIGGER user_account_trigger_insert
AFTER INSERT ON user_account
FOR EACH ROW
BEGIN
    DECLARE audit_log TEXT DEFAULT 'User account created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('user_account', NEW.user_account_id, audit_log, NEW.last_log_by, CONVERT_TZ(NOW(), '+00:00', '+08:00'));
END //