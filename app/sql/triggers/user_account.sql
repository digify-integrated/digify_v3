DELIMITER //

/* ====================================================================================================
   TRIGGER: trg_user_account_update
   ----------------------------------------------------------------------------------------------------
   Purpose:
     Captures updates on the `user_account` table and logs field-level changes into `audit_log`.
     Each modified column is compared, and differences are appended to an HTML-formatted log.

   Timing: AFTER UPDATE
   Scope : FOR EACH ROW

   Notes:
     • Only inserts into `audit_log` if at least one tracked field changed.
     • Uses CONVERT_TZ(NOW(), '+00:00', '+08:00') for PH local time.
==================================================================================================== */

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
        VALUES ('user_account', NEW.user_account_id, audit_log, NEW.last_log_by, CONVERT_TZ(NOW(), '+00:00', '+08:00'));
    END IF;
END //

/* ====================================================================================================
   TRIGGER: trg_user_account_insert
   ----------------------------------------------------------------------------------------------------
   Purpose:
     Captures new record insertions into `user_account` and logs the event into `audit_log`.

   Timing: AFTER INSERT
   Scope : FOR EACH ROW

   Notes:
     • Does not log field-level details (only a general "User created" message).
     • Extendable: Add field-level tracking if needed later.
==================================================================================================== */

DROP TRIGGER IF EXISTS trg_user_account_insert//

CREATE TRIGGER trg_user_account_insert
AFTER INSERT ON user_account
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('user_account', NEW.user_account_id, 'User account created.', NEW.last_log_by, CONVERT_TZ(NOW(), '+00:00', '+08:00'));
END //

DELIMITER ;
