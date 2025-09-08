/* ====================================================================================================
   TABLE: audit_log
   ----------------------------------------------------------------------------------------------------
   Purpose:
     Tracks changes made to database records for auditing, accountability, and debugging.

   Key Columns:
     - audit_log_id  : Primary key, unique identifier for each audit log entry
     - table_name    : Name of the table where the change occurred
     - reference_id  : Primary key value of the affected record in the referenced table
     - log           : Description/details of the change (JSON, text, or diff)
     - changed_by    : User ID of the account that performed the change (FK → user_account.user_account_id)
     - changed_at    : Timestamp of when the change was applied
==================================================================================================== */

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

-- Indexes for frequent queries
CREATE INDEX idx_audit_log_table_name ON audit_log(table_name);
CREATE INDEX idx_audit_log_reference_id ON audit_log(reference_id);
CREATE INDEX idx_audit_log_changed_by ON audit_log(changed_by);


/* ====================================================================================================
   TABLE: login_attempts
   ----------------------------------------------------------------------------------------------------
   Purpose:
     Records login attempts for auditing, brute-force prevention, and rate limiting.

   Key Columns:
     - user_account_id : Optional link to user (nullable for unknown/failed attempts)
     - email           : Email address used in the attempt
     - ip_address      : Source IP of attempt
     - attempt_time    : Timestamp of the attempt
     - success         : 1 = success, 0 = failure
==================================================================================================== */

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

-- Indexes for frequent queries
CREATE INDEX idx_login_attempts_user_account_id ON login_attempts(user_account_id);
CREATE INDEX idx_login_attempts_email ON login_attempts(email);
CREATE INDEX idx_login_attempts_ip_address ON login_attempts(ip_address);
CREATE INDEX idx_login_attempts_success ON login_attempts(success);


/* ====================================================================================================
   TABLE: reset_token
   ----------------------------------------------------------------------------------------------------
   Purpose:
     Manages password reset flows with temporary tokens.

   Key Columns:
     - reset_token            : Token value for verification
     - reset_token_expiry_date: Expiration time to enforce validity window
==================================================================================================== */

DROP TABLE IF EXISTS reset_token;

CREATE TABLE reset_token (
    reset_token_id INT AUTO_INCREMENT PRIMARY KEY,
    user_account_id INT NULL,
    reset_token VARCHAR(255),
    reset_token_expiry_date DATETIME,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

-- Indexes for validation and cleanup
CREATE INDEX idx_reset_token_user_account_id ON reset_token(user_account_id);
CREATE INDEX idx_reset_token_value ON reset_token(reset_token);
CREATE INDEX idx_reset_token_expiry ON reset_token(reset_token_expiry_date);


/* ====================================================================================================
   TABLE: otp
   ----------------------------------------------------------------------------------------------------
   Purpose:
     Stores one-time passwords (OTPs) for multi-factor authentication (MFA).

   Key Columns:
     - otp                  : One-time code
     - otp_expiry_date      : Expiration timestamp
     - failed_otp_attempts  : Tracks invalid OTP entries for lockout policies
==================================================================================================== */

DROP TABLE IF EXISTS otp;

CREATE TABLE otp (
    otp_id INT AUTO_INCREMENT PRIMARY KEY,
    user_account_id INT NULL,
    otp VARCHAR(255),
    otp_expiry_date DATETIME,
    failed_otp_attempts TINYINT UNSIGNED DEFAULT 0,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

-- Indexes for validation and monitoring
CREATE INDEX idx_otp_user_account_id ON otp(user_account_id);
CREATE INDEX idx_otp_value ON otp(otp);
CREATE INDEX idx_otp_expiry ON otp(otp_expiry_date);
CREATE INDEX idx_otp_failed_attempts ON otp(failed_otp_attempts);


/* ====================================================================================================
   TABLE: sessions
   ----------------------------------------------------------------------------------------------------
   Purpose:
     Maintains session tokens to manage logged-in user sessions.

   Key Columns:
     - session_token : Unique token identifying the session
==================================================================================================== */

DROP TABLE IF EXISTS sessions;

CREATE TABLE sessions (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    user_account_id INT NULL,
    session_token VARCHAR(255) NOT NULL,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

-- Indexes for fast lookups and validation
CREATE INDEX idx_sessions_user_account_id ON sessions(user_account_id);
CREATE INDEX idx_sessions_token ON sessions(session_token);


/* ====================================================================================================
   END OF TABLE DEFINITIONS
==================================================================================================== */
