-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 08, 2025 at 11:27 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `digifydb`
--
CREATE DATABASE IF NOT EXISTS `digifydb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `digifydb`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `checkLoginCredentialsExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkLoginCredentialsExist` (IN `p_credential` VARCHAR(255))   BEGIN
    SELECT COUNT(*) AS total
    FROM user_account
    WHERE user_account_id = CAST(p_credential AS UNSIGNED) OR email = BINARY p_credential;
END$$

DROP PROCEDURE IF EXISTS `checkNotificationSettingExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkNotificationSettingExist` (IN `p_notification_setting_id` INT)   BEGIN
    SELECT COUNT(*) AS total
    FROM notification_setting
    WHERE notification_setting_id = p_notification_setting_id;
END$$

DROP PROCEDURE IF EXISTS `checkRateLimited`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkRateLimited` (IN `p_email` VARCHAR(255), IN `p_ip_address` VARCHAR(45), IN `p_window` INT)   BEGIN
    SELECT COUNT(*) AS total
    FROM login_attempts
    WHERE attempt_time >= NOW() - INTERVAL p_window SECOND
      AND success = 0
      AND (ip_address = p_ip_address 
           OR email = p_email);
END$$

DROP PROCEDURE IF EXISTS `checkUserPermission`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkUserPermission` (IN `p_user_account_id` INT, IN `p_menu_item_id` INT, IN `p_access_type` VARCHAR(10))   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `checkUserSystemActionPermission`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkUserSystemActionPermission` (IN `p_user_account_id` INT, IN `p_system_action_id` INT)   BEGIN
    SELECT COUNT(role_id) AS total
    FROM role_system_action_permission 
    WHERE system_action_id = p_system_action_id
      AND system_action_access = 1
      AND role_id IN (
            SELECT role_id 
            FROM role_user_account 
            WHERE user_account_id = p_user_account_id
          );
END$$

DROP PROCEDURE IF EXISTS `deleteNotificationSetting`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteNotificationSetting` (IN `p_notification_setting_id` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `fetchEmailNotificationTemplate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchEmailNotificationTemplate` (IN `p_notification_setting_id` INT)   BEGIN
    SELECT * 
    FROM notification_setting_email_template
    WHERE notification_setting_id = p_notification_setting_id;
END$$

DROP PROCEDURE IF EXISTS `fetchInternalNotesAttachment`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchInternalNotesAttachment` (IN `p_internal_notes_id` INT)   BEGIN
    SELECT * 
    FROM internal_notes_attachment
    WHERE internal_notes_id = p_internal_notes_id;
END$$

DROP PROCEDURE IF EXISTS `fetchLoginCredentials`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchLoginCredentials` (IN `p_credential` VARCHAR(255))   BEGIN
    SELECT user_account_id,
           file_as,
           email,
           password,
           active,
           two_factor_auth,
           multiple_session
    FROM user_account
    WHERE user_account_id = CAST(p_credential AS UNSIGNED) OR email = BINARY p_credential
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchNotificationSetting`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchNotificationSetting` (IN `p_notification_setting_id` INT)   BEGIN
    SELECT * 
    FROM notification_setting
    WHERE notification_setting_id = p_notification_setting_id;
END$$

DROP PROCEDURE IF EXISTS `fetchOTP`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchOTP` (IN `p_user_account_id` INT)   BEGIN
    SELECT otp,
           otp_expiry_date,
           failed_otp_attempts
    FROM otp
    WHERE user_account_id = p_user_account_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchResetToken`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchResetToken` (IN `p_user_account_id` INT)   BEGIN
    SELECT reset_token,
           reset_token_expiry_date
    FROM reset_token
    WHERE user_account_id = p_user_account_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchSession`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchSession` (IN `p_user_account_id` INT)   BEGIN
    SELECT session_token
    FROM sessions
    WHERE user_account_id = p_user_account_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchSmsNotificationTemplate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchSmsNotificationTemplate` (IN `p_notification_setting_id` INT)   BEGIN
    SELECT * 
    FROM notification_setting_sms_template
    WHERE notification_setting_id = p_notification_setting_id;
END$$

DROP PROCEDURE IF EXISTS `fetchSystemNotificationTemplate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchSystemNotificationTemplate` (IN `p_notification_setting_id` INT)   BEGIN
    SELECT * 
    FROM notification_setting_system_template
    WHERE notification_setting_id = p_notification_setting_id;
END$$

DROP PROCEDURE IF EXISTS `generateNotificationSettingTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateNotificationSettingTable` ()   BEGIN
    SELECT notification_setting_id, 
           notification_setting_name, 
           notification_setting_description
    FROM notification_setting 
    ORDER BY notification_setting_id;
END$$

DROP PROCEDURE IF EXISTS `insertLoginAttempt`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertLoginAttempt` (IN `p_user_account_id` INT, IN `p_email` VARCHAR(255), IN `p_ip_address` VARCHAR(45), IN `p_success` TINYINT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;
    DECLARE EXIT HANDLER FOR SQLWARNING ROLLBACK;

    START TRANSACTION;

    SET time_zone = '+08:00';

    INSERT INTO login_attempts (user_account_id, email, ip_address, success)
    VALUES (p_user_account_id, p_email, p_ip_address, p_success);

    IF p_success = 1 THEN
        UPDATE user_account 
        SET last_connection_date = NOW()
        WHERE user_account_id = p_user_account_id;
    ELSE
        UPDATE user_account 
        SET last_failed_connection_date = NOW()
        WHERE user_account_id = p_user_account_id;
    END IF;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `saveEmailNotificationTemplate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveEmailNotificationTemplate` (IN `p_notification_setting_id` INT, IN `p_email_notification_subject` VARCHAR(200), IN `p_email_notification_body` LONGTEXT, IN `p_email_setting_id` INT, IN `p_email_setting_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `saveNotificationSetting`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveNotificationSetting` (IN `p_notification_setting_id` INT, IN `p_notification_setting_name` VARCHAR(100), IN `p_notification_setting_description` VARCHAR(200), IN `p_last_log_by` INT, OUT `p_new_notification_setting_id` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `saveOTP`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveOTP` (IN `p_user_account_id` INT, IN `p_otp` VARCHAR(255), IN `p_otp_expiry_date` DATETIME)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    START TRANSACTION;

    IF EXISTS (SELECT 1 FROM otp WHERE user_account_id = p_user_account_id) THEN
        UPDATE otp
        SET otp = p_otp,
            otp_expiry_date = p_otp_expiry_date
        WHERE user_account_id = p_user_account_id;
    ELSE
        INSERT INTO otp (user_account_id, otp, otp_expiry_date)
        VALUES (p_user_account_id, p_otp, p_otp_expiry_date);
    END IF;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `saveResetToken`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveResetToken` (IN `p_user_account_id` INT, IN `p_reset_token` VARCHAR(255), IN `p_reset_token_expiry_date` DATETIME)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

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
END$$

DROP PROCEDURE IF EXISTS `saveSession`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveSession` (IN `p_user_account_id` INT, IN `p_session_token` VARCHAR(255))   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

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
END$$

DROP PROCEDURE IF EXISTS `saveSMSNotificationTemplate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveSMSNotificationTemplate` (IN `p_notification_setting_id` INT, IN `p_sms_notification_message` VARCHAR(500), IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `saveSystemNotificationTemplate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveSystemNotificationTemplate` (IN `p_notification_setting_id` INT, IN `p_system_notification_title` VARCHAR(200), IN `p_system_notification_message` VARCHAR(200), IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `updateFailedOTPAttempts`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateFailedOTPAttempts` (IN `p_user_account_id` INT, IN `p_failed_otp_attempts` TINYINT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    START TRANSACTION;

    UPDATE otp
    SET failed_otp_attempts = p_failed_otp_attempts
    WHERE user_account_id = p_user_account_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateNotificationChannel`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateNotificationChannel` (IN `p_notification_setting_id` INT, IN `p_notification_channel` VARCHAR(10), IN `p_notification_channel_value` TINYINT, IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `updateOTPAsExpired`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateOTPAsExpired` (IN `p_user_account_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE otp
    SET otp_expiry_date = NOW()
    WHERE user_account_id = p_user_account_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateResetTokenAsExpired`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateResetTokenAsExpired` (IN `p_user_account_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    START TRANSACTION;

    UPDATE reset_token
    SET reset_token_expiry_date = NOW()
    WHERE user_account_id = p_user_account_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateUserPassword`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUserPassword` (IN `p_user_account_id` INT, IN `p_password` VARCHAR(255))   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    START TRANSACTION;

    -- Update active password
    UPDATE user_account
    SET password             = p_password,
        last_log_by          = p_user_account_id
    WHERE user_account_id = p_user_account_id;

    COMMIT;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `app_module`
--

DROP TABLE IF EXISTS `app_module`;
CREATE TABLE `app_module` (
  `app_module_id` int(10) UNSIGNED NOT NULL,
  `app_module_name` varchar(100) NOT NULL,
  `app_module_description` varchar(500) NOT NULL,
  `app_logo` varchar(500) DEFAULT NULL,
  `menu_item_id` int(10) UNSIGNED NOT NULL,
  `menu_item_name` varchar(100) NOT NULL,
  `order_sequence` tinyint(10) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_module`
--

INSERT INTO `app_module` (`app_module_id`, `app_module_name`, `app_module_description`, `app_logo`, `menu_item_id`, `menu_item_name`, `order_sequence`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Settings', 'Centralized management hub for comprehensive organizational oversight and control', './storage/uploads/app_module/1/Pboex.png', 1, 'App Module', 100, '2025-09-08 17:26:05', '2025-09-08 17:26:05', 1);

-- --------------------------------------------------------

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
CREATE TABLE `audit_log` (
  `audit_log_id` int(10) UNSIGNED NOT NULL,
  `table_name` varchar(100) NOT NULL,
  `reference_id` int(11) NOT NULL,
  `log` text NOT NULL,
  `changed_by` int(10) UNSIGNED DEFAULT 1,
  `changed_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_log`
--

INSERT INTO `audit_log` (`audit_log_id`, `table_name`, `reference_id`, `log`, `changed_by`, `changed_at`, `created_date`) VALUES
(1, 'user_account', 1, 'User account changed.<br/><br/>2FA: Yes -> No<br/>', 1, '2025-09-09 00:42:44', '2025-09-08 16:42:44'),
(2, 'user_account', 1, 'User account changed.<br/><br/>Last Connection: 2025-09-08 15:06:48 -> 2025-09-08 16:43:15<br/>', 1, '2025-09-09 00:43:15', '2025-09-08 16:43:15'),
(3, 'user_account', 1, 'User account changed.<br/><br/>Last Connection: 2025-09-08 16:43:15 -> 2025-09-08 16:46:01<br/>', 1, '2025-09-09 00:46:01', '2025-09-08 16:46:01'),
(4, 'user_account', 1, 'User account changed.<br/><br/>Last Connection: 2025-09-08 16:46:01 -> 2025-09-08 16:48:20<br/>', 1, '2025-09-09 00:48:20', '2025-09-08 16:48:20'),
(5, 'user_account', 1, 'User account changed.<br/><br/>Last Connection: 2025-09-08 16:48:20 -> 2025-09-08 16:55:18<br/>', 1, '2025-09-09 00:55:18', '2025-09-08 16:55:18'),
(6, 'user_account', 1, 'User account changed.<br/><br/>Last Connection: 2025-09-08 16:55:18 -> 2025-09-08 16:55:31<br/>', 1, '2025-09-09 00:55:31', '2025-09-08 16:55:31'),
(7, 'user_account', 1, 'User account changed.<br/><br/>Multiple Session: No -> Yes<br/>', 1, '2025-09-09 00:55:44', '2025-09-08 16:55:44'),
(8, 'user_account', 1, 'User account changed.<br/><br/>Last Connection: 2025-09-08 16:55:31 -> 2025-09-08 16:55:53<br/>', 1, '2025-09-09 00:55:53', '2025-09-08 16:55:53');

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

DROP TABLE IF EXISTS `login_attempts`;
CREATE TABLE `login_attempts` (
  `login_attempts_id` int(11) NOT NULL,
  `user_account_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ip_address` varchar(45) NOT NULL,
  `attempt_time` datetime NOT NULL DEFAULT current_timestamp(),
  `success` tinyint(1) NOT NULL DEFAULT 0,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login_attempts`
--

INSERT INTO `login_attempts` (`login_attempts_id`, `user_account_id`, `email`, `ip_address`, `attempt_time`, `success`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 1, 'l.agulto@christianmotors.ph', '::1', '2025-09-08 15:06:48', 1, '2025-09-08 15:06:48', '2025-09-08 15:06:48', 1),
(4, 1, 'l.agulto@christianmotors.ph', '::1', '2025-09-08 16:43:15', 1, '2025-09-08 16:43:15', '2025-09-08 16:43:15', 1),
(5, 1, 'l.agulto@christianmotors.ph', '::1', '2025-09-08 16:46:01', 1, '2025-09-08 16:46:01', '2025-09-08 16:46:01', 1),
(6, 1, 'l.agulto@christianmotors.ph', '::1', '2025-09-08 16:48:20', 1, '2025-09-08 16:48:20', '2025-09-08 16:48:20', 1),
(7, 1, 'l.agulto@christianmotors.ph', '::1', '2025-09-08 16:55:18', 1, '2025-09-08 16:55:18', '2025-09-08 16:55:18', 1),
(8, 1, 'l.agulto@christianmotors.ph', '::1', '2025-09-08 16:55:31', 1, '2025-09-08 16:55:31', '2025-09-08 16:55:31', 1),
(9, 1, 'l.agulto@christianmotors.ph', '::1', '2025-09-08 16:55:53', 1, '2025-09-08 16:55:53', '2025-09-08 16:55:53', 1);

-- --------------------------------------------------------

--
-- Table structure for table `menu_item`
--

DROP TABLE IF EXISTS `menu_item`;
CREATE TABLE `menu_item` (
  `menu_item_id` int(10) UNSIGNED NOT NULL,
  `menu_item_name` varchar(100) NOT NULL,
  `menu_item_url` varchar(50) DEFAULT NULL,
  `menu_item_icon` varchar(50) DEFAULT NULL,
  `app_module_id` int(10) UNSIGNED NOT NULL,
  `app_module_name` varchar(100) NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `parent_name` varchar(100) DEFAULT NULL,
  `order_sequence` tinyint(10) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_item`
--

INSERT INTO `menu_item` (`menu_item_id`, `menu_item_name`, `menu_item_url`, `menu_item_icon`, `app_module_id`, `app_module_name`, `parent_id`, `parent_name`, `order_sequence`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'App Module', 'app-module.php', '', 1, 'Settings', 0, '', 1, '2025-09-08 17:26:27', '2025-09-08 17:26:27', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notification_setting`
--

DROP TABLE IF EXISTS `notification_setting`;
CREATE TABLE `notification_setting` (
  `notification_setting_id` int(10) UNSIGNED NOT NULL,
  `notification_setting_name` varchar(100) NOT NULL,
  `notification_setting_description` varchar(200) NOT NULL,
  `system_notification` int(1) NOT NULL DEFAULT 1,
  `email_notification` int(1) NOT NULL DEFAULT 0,
  `sms_notification` int(1) NOT NULL DEFAULT 0,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notification_setting`
--

INSERT INTO `notification_setting` (`notification_setting_id`, `notification_setting_name`, `notification_setting_description`, `system_notification`, `email_notification`, `sms_notification`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Login OTP', 'Sent when a user receives a login OTP.', 0, 1, 0, '2025-09-08 10:33:26', '2025-09-08 10:33:26', 1),
(2, 'Forgot Password', 'Sent when a user requests a password reset.', 0, 1, 0, '2025-09-08 10:33:26', '2025-09-08 10:33:26', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notification_setting_email_template`
--

DROP TABLE IF EXISTS `notification_setting_email_template`;
CREATE TABLE `notification_setting_email_template` (
  `notification_setting_email_id` int(10) UNSIGNED NOT NULL,
  `notification_setting_id` int(10) UNSIGNED NOT NULL,
  `email_notification_subject` varchar(200) NOT NULL,
  `email_notification_body` longtext NOT NULL,
  `email_setting_id` int(10) UNSIGNED NOT NULL,
  `email_setting_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notification_setting_email_template`
--

INSERT INTO `notification_setting_email_template` (`notification_setting_email_id`, `notification_setting_id`, `email_notification_subject`, `email_notification_body`, `email_setting_id`, `email_setting_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 1, 'Login OTP - Secure Access to Your Account', '<p>Your One-Time Password (OTP) is:</p><p><strong>#{OTP_CODE}</strong></p><p>This code is valid for <strong>#{OTP_CODE_VALIDITY}</strong>.</p><p>If you did not request this, please ignore.</p>', 1, 'Security Email Setting', '2025-09-08 10:33:27', '2025-09-08 10:33:27', 1),
(2, 2, 'Password Reset Request - Action Required', '<p>Click the link to reset your password:</p><p><a href=\"#{RESET_LINK}\">Password Reset Link</a></p><p>Link expires after <strong>#{RESET_LINK_VALIDITY}</strong>.</p><p>If not requested, ignore this email.</p>', 1, 'Security Email Setting', '2025-09-08 10:33:27', '2025-09-08 10:33:27', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notification_setting_sms_template`
--

DROP TABLE IF EXISTS `notification_setting_sms_template`;
CREATE TABLE `notification_setting_sms_template` (
  `notification_setting_sms_id` int(10) UNSIGNED NOT NULL,
  `notification_setting_id` int(10) UNSIGNED NOT NULL,
  `sms_notification_message` varchar(500) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_setting_system_template`
--

DROP TABLE IF EXISTS `notification_setting_system_template`;
CREATE TABLE `notification_setting_system_template` (
  `notification_setting_system_id` int(10) UNSIGNED NOT NULL,
  `notification_setting_id` int(10) UNSIGNED NOT NULL,
  `system_notification_title` varchar(200) NOT NULL,
  `system_notification_message` varchar(500) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `otp`
--

DROP TABLE IF EXISTS `otp`;
CREATE TABLE `otp` (
  `otp_id` int(11) NOT NULL,
  `user_account_id` int(11) DEFAULT NULL,
  `otp` varchar(255) DEFAULT NULL,
  `otp_expiry_date` datetime DEFAULT NULL,
  `failed_otp_attempts` tinyint(3) UNSIGNED DEFAULT 0,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `otp`
--

INSERT INTO `otp` (`otp_id`, `user_account_id`, `otp`, `otp_expiry_date`, `failed_otp_attempts`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 1, '$2y$10$jzCPtoNy8Nmiy3RtBexY1uetXMNnzZZQI3tTaNgK3ey2P9MwLl.kq', '2025-09-08 16:23:44', 0, '2025-09-08 15:05:23', '2025-09-08 16:23:44', 1);

-- --------------------------------------------------------

--
-- Table structure for table `reset_token`
--

DROP TABLE IF EXISTS `reset_token`;
CREATE TABLE `reset_token` (
  `reset_token_id` int(11) NOT NULL,
  `user_account_id` int(11) DEFAULT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expiry_date` datetime DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `session_id` int(11) NOT NULL,
  `user_account_id` int(11) DEFAULT NULL,
  `session_token` varchar(255) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`session_id`, `user_account_id`, `session_token`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 1, '$2y$10$aqDP0sjgigIqUCi6GY6qWefeh.5n4Eas0eWq27plXqbSrYBtaXOVC', '2025-09-08 15:06:48', '2025-09-08 16:55:53', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_account`
--

DROP TABLE IF EXISTS `user_account`;
CREATE TABLE `user_account` (
  `user_account_id` int(10) UNSIGNED NOT NULL,
  `file_as` varchar(300) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `profile_picture` varchar(500) DEFAULT NULL,
  `active` varchar(5) DEFAULT 'No',
  `two_factor_auth` varchar(5) DEFAULT 'Yes',
  `multiple_session` varchar(10) DEFAULT 'Yes',
  `last_connection_date` datetime DEFAULT NULL,
  `last_failed_connection_date` datetime DEFAULT NULL,
  `last_password_change` datetime DEFAULT NULL,
  `last_password_reset_request` datetime DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_account`
--

INSERT INTO `user_account` (`user_account_id`, `file_as`, `email`, `password`, `phone`, `profile_picture`, `active`, `two_factor_auth`, `multiple_session`, `last_connection_date`, `last_failed_connection_date`, `last_password_change`, `last_password_reset_request`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Lawrence Agulto', 'l.agulto@christianmotors.ph', '$2y$10$Qu3TEV2u0SBF1jdb2DzB6.OcMChTDStXHEOdX47Y01sOGkl4UnOaK', '123-456-7890', NULL, 'Yes', 'No', 'Yes', '2025-09-08 16:55:53', NULL, NULL, NULL, '2025-09-08 10:33:17', '2025-09-08 16:55:53', 1);

--
-- Triggers `user_account`
--
DROP TRIGGER IF EXISTS `trg_user_account_insert`;
DELIMITER $$
CREATE TRIGGER `trg_user_account_insert` AFTER INSERT ON `user_account` FOR EACH ROW BEGIN
    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('user_account', NEW.user_account_id, 'User account created.', NEW.last_log_by, CONVERT_TZ(NOW(), '+00:00', '+08:00'));
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_user_account_update`;
DELIMITER $$
CREATE TRIGGER `trg_user_account_update` AFTER UPDATE ON `user_account` FOR EACH ROW BEGIN
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
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `app_module`
--
ALTER TABLE `app_module`
  ADD PRIMARY KEY (`app_module_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_app_module_menu_item_id` (`menu_item_id`);

--
-- Indexes for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`audit_log_id`),
  ADD KEY `idx_audit_log_table_name` (`table_name`),
  ADD KEY `idx_audit_log_reference_id` (`reference_id`),
  ADD KEY `idx_audit_log_changed_by` (`changed_by`);

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`login_attempts_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_login_attempts_user_account_id` (`user_account_id`),
  ADD KEY `idx_login_attempts_email` (`email`),
  ADD KEY `idx_login_attempts_ip_address` (`ip_address`),
  ADD KEY `idx_login_attempts_success` (`success`);

--
-- Indexes for table `menu_item`
--
ALTER TABLE `menu_item`
  ADD PRIMARY KEY (`menu_item_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_menu_item_app_module_id` (`app_module_id`),
  ADD KEY `idx_menu_item_parent_id` (`parent_id`);

--
-- Indexes for table `notification_setting`
--
ALTER TABLE `notification_setting`
  ADD PRIMARY KEY (`notification_setting_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_notification_setting_id` (`notification_setting_id`);

--
-- Indexes for table `notification_setting_email_template`
--
ALTER TABLE `notification_setting_email_template`
  ADD PRIMARY KEY (`notification_setting_email_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_notification_email_setting_id` (`notification_setting_id`);

--
-- Indexes for table `notification_setting_sms_template`
--
ALTER TABLE `notification_setting_sms_template`
  ADD PRIMARY KEY (`notification_setting_sms_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_notification_sms_setting_id` (`notification_setting_id`);

--
-- Indexes for table `notification_setting_system_template`
--
ALTER TABLE `notification_setting_system_template`
  ADD PRIMARY KEY (`notification_setting_system_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_notification_system_setting_id` (`notification_setting_id`);

--
-- Indexes for table `otp`
--
ALTER TABLE `otp`
  ADD PRIMARY KEY (`otp_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_otp_user_account_id` (`user_account_id`),
  ADD KEY `idx_otp_value` (`otp`),
  ADD KEY `idx_otp_expiry` (`otp_expiry_date`),
  ADD KEY `idx_otp_failed_attempts` (`failed_otp_attempts`);

--
-- Indexes for table `reset_token`
--
ALTER TABLE `reset_token`
  ADD PRIMARY KEY (`reset_token_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_reset_token_user_account_id` (`user_account_id`),
  ADD KEY `idx_reset_token_value` (`reset_token`),
  ADD KEY `idx_reset_token_expiry` (`reset_token_expiry_date`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_sessions_user_account_id` (`user_account_id`),
  ADD KEY `idx_sessions_token` (`session_token`);

--
-- Indexes for table `user_account`
--
ALTER TABLE `user_account`
  ADD PRIMARY KEY (`user_account_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_user_account_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `app_module`
--
ALTER TABLE `app_module`
  MODIFY `app_module_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `audit_log`
--
ALTER TABLE `audit_log`
  MODIFY `audit_log_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `login_attempts_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `menu_item`
--
ALTER TABLE `menu_item`
  MODIFY `menu_item_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `notification_setting`
--
ALTER TABLE `notification_setting`
  MODIFY `notification_setting_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notification_setting_email_template`
--
ALTER TABLE `notification_setting_email_template`
  MODIFY `notification_setting_email_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notification_setting_sms_template`
--
ALTER TABLE `notification_setting_sms_template`
  MODIFY `notification_setting_sms_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification_setting_system_template`
--
ALTER TABLE `notification_setting_system_template`
  MODIFY `notification_setting_system_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `otp`
--
ALTER TABLE `otp`
  MODIFY `otp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `reset_token`
--
ALTER TABLE `reset_token`
  MODIFY `reset_token_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `session_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_account`
--
ALTER TABLE `user_account`
  MODIFY `user_account_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `app_module`
--
ALTER TABLE `app_module`
  ADD CONSTRAINT `app_module_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD CONSTRAINT `audit_log_ibfk_1` FOREIGN KEY (`changed_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD CONSTRAINT `login_attempts_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `menu_item`
--
ALTER TABLE `menu_item`
  ADD CONSTRAINT `menu_item_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `notification_setting`
--
ALTER TABLE `notification_setting`
  ADD CONSTRAINT `notification_setting_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `notification_setting_email_template`
--
ALTER TABLE `notification_setting_email_template`
  ADD CONSTRAINT `notification_setting_email_template_ibfk_1` FOREIGN KEY (`notification_setting_id`) REFERENCES `notification_setting` (`notification_setting_id`),
  ADD CONSTRAINT `notification_setting_email_template_ibfk_2` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `notification_setting_sms_template`
--
ALTER TABLE `notification_setting_sms_template`
  ADD CONSTRAINT `notification_setting_sms_template_ibfk_1` FOREIGN KEY (`notification_setting_id`) REFERENCES `notification_setting` (`notification_setting_id`),
  ADD CONSTRAINT `notification_setting_sms_template_ibfk_2` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `notification_setting_system_template`
--
ALTER TABLE `notification_setting_system_template`
  ADD CONSTRAINT `notification_setting_system_template_ibfk_1` FOREIGN KEY (`notification_setting_id`) REFERENCES `notification_setting` (`notification_setting_id`),
  ADD CONSTRAINT `notification_setting_system_template_ibfk_2` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `otp`
--
ALTER TABLE `otp`
  ADD CONSTRAINT `otp_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `reset_token`
--
ALTER TABLE `reset_token`
  ADD CONSTRAINT `reset_token_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `user_account`
--
ALTER TABLE `user_account`
  ADD CONSTRAINT `user_account_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
