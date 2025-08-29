/* Users Table */

DROP TABLE IF EXISTS user_account;

CREATE TABLE user_account (
    user_account_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    file_as VARCHAR(300) NOT NULL,
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    profile_picture VARCHAR(500),
    active VARCHAR(5) DEFAULT 'No',
    two_factor_auth VARCHAR(5) DEFAULT 'Yes',
    multiple_session VARCHAR(10) DEFAULT 'Yes',
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

CREATE INDEX user_account_index_user_account_id ON user_account(user_account_id);
CREATE INDEX user_account_index_email ON user_account(email);

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
    '$2y$10$Qu3TEV2u0SBF1jdb2DzB6.OcMChTDStXHEOdX47Y01sOGkl4UnOaK',
    '123-456-7890',
    'Yes',
    'No'
);


/* ----------------------------------------------------------------------------------------------------------------------------- */