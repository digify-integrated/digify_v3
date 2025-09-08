/* ====================================================================================================
   TABLE: user_account
   ----------------------------------------------------------------------------------------------------
   Purpose:
     Stores core user account information, including credentials, contact details, authentication
     preferences, and activity tracking.

   Key Features:
     • Authentication → email (unique), hashed password
     • Security       → 2FA, password change/reset tracking
     • Sessions       → single/multiple concurrent session control
     • Auditing       → last login/failure, record creation/update tracking
==================================================================================================== */

DROP TABLE IF EXISTS user_account;

CREATE TABLE user_account (
    user_account_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    file_as VARCHAR(300) NOT NULL,                           -- Display/full name
    email VARCHAR(255) UNIQUE,                               -- Unique login identifier
    password VARCHAR(255) NOT NULL,                          -- Hashed password (bcrypt, Argon2, etc.)
    phone VARCHAR(50),                                       -- Contact number
    profile_picture VARCHAR(500),                            -- Path or URL to profile picture
    active VARCHAR(5) DEFAULT 'No',                          -- Account status (Yes/No)
    two_factor_auth VARCHAR(5) DEFAULT 'Yes',                -- 2FA status (Yes/No)
    multiple_session VARCHAR(5) DEFAULT 'No',               -- Allow multiple concurrent sessions (Yes/No)
    last_connection_date DATETIME,                           -- Last successful login
    last_failed_connection_date DATETIME,                    -- Last failed login attempt
    last_password_change DATETIME,                           -- Last password change timestamp
    last_password_reset_request DATETIME,                    -- Last password reset request
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,         
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP 
        ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,                      -- FK: User who last modified this record
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

-- Indexes
CREATE INDEX idx_user_account_email ON user_account(email);

-- Default admin/test account
INSERT INTO user_account (
    file_as,
    email,
    password,
    phone,
    active,
    multiple_session
) VALUES (
    'Lawrence Agulto',
    'l.agulto@christianmotors.ph',
    '$2y$10$Qu3TEV2u0SBF1jdb2DzB6.OcMChTDStXHEOdX47Y01sOGkl4UnOaK', -- bcrypt hash
    '123-456-7890',
    'Yes',
    'No'
);

/* ====================================================================================================
   END OF USER ACCOUNT TABLE
==================================================================================================== */
