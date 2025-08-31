/* Login Attempts Table */

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


CREATE INDEX login_attempts_index_user_account_id ON login_attempts(user_account_id);
CREATE INDEX login_attempts_index_email ON login_attempts(email);
CREATE INDEX login_attempts_index_ip_address ON login_attempts(ip_address);
CREATE INDEX login_attempts_index_success ON login_attempts(success);

/* ----------------------------------------------------------------------------------------------------------------------------- */

/* Reset Token Table */

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


CREATE INDEX reset_token_index_user_account_id ON reset_token(user_account_id);
CREATE INDEX reset_token_index_reset_token ON reset_token(reset_token);
CREATE INDEX reset_token_index_reset_token_expiry_date ON reset_token(reset_token_expiry_date);

/* ----------------------------------------------------------------------------------------------------------------------------- */

/* OTP Table */

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

CREATE INDEX otp_index_user_account_id ON otp(user_account_id);
CREATE INDEX otp_index_otp ON otp(otp);
CREATE INDEX otp_index_otp_expiry_date ON otp(otp_expiry_date);
CREATE INDEX otp_index_failed_otp_attempts ON otp(failed_otp_attempts);

/* ----------------------------------------------------------------------------------------------------------------------------- */

/* Sessions Table */

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

CREATE INDEX sessions_index_user_account_id ON sessions(user_account_id);
CREATE INDEX sessions_index_session_token ON sessions(session_token);

/* ----------------------------------------------------------------------------------------------------------------------------- */