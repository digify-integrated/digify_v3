-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 23, 2025 at 06:16 PM
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
DROP PROCEDURE IF EXISTS `checkAddressTypeExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkAddressTypeExist` (IN `p_address_type_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM address_type
    WHERE address_type_id = p_address_type_id;
END$$

DROP PROCEDURE IF EXISTS `checkAppModuleExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkAppModuleExist` (IN `p_app_module_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM app_module
    WHERE app_module_id = p_app_module_id;
END$$

DROP PROCEDURE IF EXISTS `checkAttributeExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkAttributeExist` (IN `p_attribute_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM attribute
    WHERE attribute_id = p_attribute_id;
END$$

DROP PROCEDURE IF EXISTS `checkAttributeValueExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkAttributeValueExist` (IN `p_attribute_value_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM attribute_value
    WHERE attribute_value_id = p_attribute_value_id;
END$$

DROP PROCEDURE IF EXISTS `checkBankAccountTypeExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkBankAccountTypeExist` (IN `p_bank_account_type_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM bank_account_type
    WHERE bank_account_type_id = p_bank_account_type_id;
END$$

DROP PROCEDURE IF EXISTS `checkBankExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkBankExist` (IN `p_bank_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM bank
    WHERE bank_id = p_bank_id;
END$$

DROP PROCEDURE IF EXISTS `checkBloodTypeExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkBloodTypeExist` (IN `p_blood_type_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM blood_type
    WHERE blood_type_id = p_blood_type_id;
END$$

DROP PROCEDURE IF EXISTS `checkCityExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkCityExist` (IN `p_city_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM city
    WHERE city_id = p_city_id;
END$$

DROP PROCEDURE IF EXISTS `checkCivilStatusExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkCivilStatusExist` (IN `p_civil_status_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM civil_status
    WHERE civil_status_id = p_civil_status_id;
END$$

DROP PROCEDURE IF EXISTS `checkCompanyExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkCompanyExist` (IN `p_company_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM company
    WHERE company_id = p_company_id;
END$$

DROP PROCEDURE IF EXISTS `checkContactInformationTypeExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkContactInformationTypeExist` (IN `p_contact_information_type_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM contact_information_type
    WHERE contact_information_type_id = p_contact_information_type_id;
END$$

DROP PROCEDURE IF EXISTS `checkCountryExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkCountryExist` (IN `p_country_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM country
    WHERE country_id = p_country_id;
END$$

DROP PROCEDURE IF EXISTS `checkCredentialTypeExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkCredentialTypeExist` (IN `p_credential_type_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM credential_type
    WHERE credential_type_id = p_credential_type_id;
END$$

DROP PROCEDURE IF EXISTS `checkCurrencyExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkCurrencyExist` (IN `p_currency_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM currency
    WHERE currency_id = p_currency_id;
END$$

DROP PROCEDURE IF EXISTS `checkDepartmentExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkDepartmentExist` (IN `p_department_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM department
    WHERE department_id = p_department_id;
END$$

DROP PROCEDURE IF EXISTS `checkDepartureReasonExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkDepartureReasonExist` (IN `p_departure_reason_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM departure_reason
    WHERE departure_reason_id = p_departure_reason_id;
END$$

DROP PROCEDURE IF EXISTS `checkEducationalStageExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkEducationalStageExist` (IN `p_educational_stage_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM educational_stage
    WHERE educational_stage_id = p_educational_stage_id;
END$$

DROP PROCEDURE IF EXISTS `checkEmployeeDocumentTypeExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkEmployeeDocumentTypeExist` (IN `p_employee_document_type_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM employee_document_type
    WHERE employee_document_type_id = p_employee_document_type_id;
END$$

DROP PROCEDURE IF EXISTS `checkEmployeeExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkEmployeeExist` (IN `p_employee_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM employee
    WHERE employee_id = p_employee_id;
END$$

DROP PROCEDURE IF EXISTS `checkEmploymentLocationTypeExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkEmploymentLocationTypeExist` (IN `p_employment_location_type_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM employment_location_type
    WHERE employment_location_type_id = p_employment_location_type_id;
END$$

DROP PROCEDURE IF EXISTS `checkEmploymentTypeExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkEmploymentTypeExist` (IN `p_employment_type_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM employment_type
    WHERE employment_type_id = p_employment_type_id;
END$$

DROP PROCEDURE IF EXISTS `checkFileExtensionExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkFileExtensionExist` (IN `p_file_extension_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM file_extension
    WHERE file_extension_id = p_file_extension_id;
END$$

DROP PROCEDURE IF EXISTS `checkFileTypeExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkFileTypeExist` (IN `p_file_type_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM file_type
    WHERE file_type_id = p_file_type_id;
END$$

DROP PROCEDURE IF EXISTS `checkGenderExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkGenderExist` (IN `p_gender_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM gender
    WHERE gender_id = p_gender_id;
END$$

DROP PROCEDURE IF EXISTS `checkJobPositionExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkJobPositionExist` (IN `p_job_position_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM job_position
    WHERE job_position_id = p_job_position_id;
END$$

DROP PROCEDURE IF EXISTS `checkLanguageExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkLanguageExist` (IN `p_language_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM language
    WHERE language_id = p_language_id;
END$$

DROP PROCEDURE IF EXISTS `checkLanguageProficiencyExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkLanguageProficiencyExist` (IN `p_language_proficiency_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM language_proficiency
    WHERE language_proficiency_id = p_language_proficiency_id;
END$$

DROP PROCEDURE IF EXISTS `checkLoginCredentialsExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkLoginCredentialsExist` (IN `p_credential` VARCHAR(255))   BEGIN
    SELECT COUNT(*) AS total
    FROM user_account
    WHERE user_account_id = CAST(p_credential AS UNSIGNED) OR email = BINARY p_credential;
END$$

DROP PROCEDURE IF EXISTS `checkMenuItemExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkMenuItemExist` (IN `p_menu_item_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM menu_item
    WHERE menu_item_id = p_menu_item_id;
END$$

DROP PROCEDURE IF EXISTS `checkNationalityExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkNationalityExist` (IN `p_nationality_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM nationality
    WHERE nationality_id = p_nationality_id;
END$$

DROP PROCEDURE IF EXISTS `checkNotificationSettingExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkNotificationSettingExist` (IN `p_notification_setting_id` INT)   BEGIN
    SELECT COUNT(*) AS total
    FROM notification_setting
    WHERE notification_setting_id = p_notification_setting_id;
END$$

DROP PROCEDURE IF EXISTS `checkProductBarcodeExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkProductBarcodeExist` (IN `p_product_id` INT, IN `p_barcode` VARCHAR(200))   BEGIN
	SELECT COUNT(*) AS total
    FROM product
    WHERE product_id != p_product_id 
    AND barcode = p_barcode;
END$$

DROP PROCEDURE IF EXISTS `checkProductCategoryExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkProductCategoryExist` (IN `p_product_category_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM product_category
    WHERE product_category_id = p_product_category_id;
END$$

DROP PROCEDURE IF EXISTS `checkProductExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkProductExist` (IN `p_product_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM product
    WHERE product_id = p_product_id;
END$$

DROP PROCEDURE IF EXISTS `checkProductSKUExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkProductSKUExist` (IN `p_product_id` INT, IN `p_sku` VARCHAR(200))   BEGIN
	SELECT COUNT(*) AS total
    FROM product
    WHERE product_id != p_product_id 
    AND sku = p_sku;
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

DROP PROCEDURE IF EXISTS `checkRelationshipExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkRelationshipExist` (IN `p_relationship_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM relationship
    WHERE relationship_id = p_relationship_id;
END$$

DROP PROCEDURE IF EXISTS `checkReligionExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkReligionExist` (IN `p_religion_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM religion
    WHERE religion_id = p_religion_id;
END$$

DROP PROCEDURE IF EXISTS `checkRoleExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkRoleExist` (IN `p_role_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM role
    WHERE role_id = p_role_id;
END$$

DROP PROCEDURE IF EXISTS `checkRolePermissionExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkRolePermissionExist` (IN `p_role_permission_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM role_permission
    WHERE role_permission_id = p_role_permission_id;
END$$

DROP PROCEDURE IF EXISTS `checkRoleSystemActionPermissionExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkRoleSystemActionPermissionExist` (IN `p_role_system_action_permission_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM role_system_action_permission
    WHERE role_system_action_permission_id = p_role_system_action_permission_id;
END$$

DROP PROCEDURE IF EXISTS `checkRoleUserAccountExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkRoleUserAccountExist` (IN `p_role_user_account_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM role_user_account
    WHERE role_user_account_id = p_role_user_account_id;
END$$

DROP PROCEDURE IF EXISTS `checkStateExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkStateExist` (IN `p_state_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM state
    WHERE state_id = p_state_id;
END$$

DROP PROCEDURE IF EXISTS `checkSupplierExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkSupplierExist` (IN `p_supplier_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM supplier
    WHERE supplier_id = p_supplier_id;
END$$

DROP PROCEDURE IF EXISTS `checkSystemActionExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkSystemActionExist` (IN `p_system_action_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM system_action
    WHERE system_action_id = p_system_action_id;
END$$

DROP PROCEDURE IF EXISTS `checkTaxExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkTaxExist` (IN `p_tax_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM tax
    WHERE tax_id = p_tax_id;
END$$

DROP PROCEDURE IF EXISTS `checkUploadSettingExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkUploadSettingExist` (IN `p_upload_setting_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM upload_setting
    WHERE upload_setting_id = p_upload_setting_id;
END$$

DROP PROCEDURE IF EXISTS `checkUserAccountEmailExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkUserAccountEmailExist` (IN `p_user_account_id` INT, IN `p_email` VARCHAR(255))   BEGIN
	SELECT COUNT(*) AS total
    FROM user_account
    WHERE user_account_id != p_user_account_id AND email = p_email;
END$$

DROP PROCEDURE IF EXISTS `checkUserAccountExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkUserAccountExist` (IN `p_user_account_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM user_account
    WHERE user_account_id = p_user_account_id;
END$$

DROP PROCEDURE IF EXISTS `checkUserAccountInsertEmailExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkUserAccountInsertEmailExist` (IN `p_email` VARCHAR(255))   BEGIN
	SELECT COUNT(*) AS total
    FROM user_account
    WHERE email = p_email;
END$$

DROP PROCEDURE IF EXISTS `checkUserAccountPhoneExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkUserAccountPhoneExist` (IN `p_user_account_id` INT, IN `p_phone` VARCHAR(50))   BEGIN
	SELECT COUNT(*) AS total
    FROM user_account
    WHERE user_account_id != p_user_account_id AND phone = p_phone;
END$$

DROP PROCEDURE IF EXISTS `checkUserPermission`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkUserPermission` (IN `p_user_account_id` INT, IN `p_menu_item_id` INT, IN `p_access_type` VARCHAR(20))   BEGIN
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

DROP PROCEDURE IF EXISTS `checkWarehouseExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkWarehouseExist` (IN `p_warehouse_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM warehouse
    WHERE warehouse_id = p_warehouse_id;
END$$

DROP PROCEDURE IF EXISTS `checkWarehouseTypeExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkWarehouseTypeExist` (IN `p_warehouse_type_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM warehouse_type
    WHERE warehouse_type_id = p_warehouse_type_id;
END$$

DROP PROCEDURE IF EXISTS `checkWorkLocationExist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkWorkLocationExist` (IN `p_work_location_id` INT)   BEGIN
	SELECT COUNT(*) AS total
    FROM work_location
    WHERE work_location_id = p_work_location_id;
END$$

DROP PROCEDURE IF EXISTS `deleteAddressType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAddressType` (IN `p_address_type_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM address_type WHERE address_type_id = p_address_type_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteAppModule`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAppModule` (IN `p_app_module_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM app_module
    WHERE app_module_id = p_app_module_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteAttribute`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAttribute` (IN `p_attribute_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM attribute_value WHERE attribute_id = p_attribute_id;
    DELETE FROM attribute WHERE attribute_id = p_attribute_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteAttributeValue`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAttributeValue` (IN `p_attribute_value_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM attribute_value WHERE attribute_value_id = p_attribute_value_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteBank`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteBank` (IN `p_bank_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM bank WHERE bank_id = p_bank_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteBankAccountType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteBankAccountType` (IN `p_bank_account_type_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM bank_account_type
    WHERE bank_account_type_id = p_bank_account_type_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteBloodType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteBloodType` (IN `p_blood_type_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM blood_type WHERE blood_type_id = p_blood_type_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteCity`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCity` (IN `p_city_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM city WHERE city_id = p_city_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteCivilStatus`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCivilStatus` (IN `p_civil_status_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM civil_status WHERE civil_status_id = p_civil_status_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteCompany`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCompany` (IN `p_company_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM company WHERE company_id = p_company_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteContactInformationType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteContactInformationType` (IN `p_contact_information_type_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM contact_information_type WHERE contact_information_type_id = p_contact_information_type_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteCountry`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCountry` (IN `p_country_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM state
    WHERE country_id = p_country_id;

    DELETE FROM city
    WHERE country_id = p_country_id;

    DELETE FROM country
    WHERE country_id = p_country_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteCredentialType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCredentialType` (IN `p_credential_type_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM credential_type WHERE credential_type_id = p_credential_type_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteCurrency`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCurrency` (IN `p_currency_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM currency WHERE currency_id = p_currency_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteDepartment`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteDepartment` (IN `p_department_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM department
    WHERE department_id = p_department_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteDepartureReason`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteDepartureReason` (IN `p_departure_reason_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM departure_reason
    WHERE departure_reason_id = p_departure_reason_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteEducationalStage`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEducationalStage` (IN `p_educational_stage_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM educational_stage WHERE educational_stage_id = p_educational_stage_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteEmployee`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEmployee` (IN `p_employee_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM employee_experience
    WHERE employee_id = p_employee_id;

    DELETE FROM employee_education
    WHERE employee_id = p_employee_id;

    DELETE FROM employee_license
    WHERE employee_id = p_employee_id;

    DELETE FROM employee_emergency_contact
    WHERE employee_id = p_employee_id;

    DELETE FROM employee_language
    WHERE employee_id = p_employee_id;

    DELETE FROM employee_document
    WHERE employee_id = p_employee_id;

    DELETE FROM employee
    WHERE employee_id = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteEmployeeDocument`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEmployeeDocument` (IN `p_employee_document_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM employee_document
    WHERE employee_document_id = p_employee_document_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteEmployeeDocumentType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEmployeeDocumentType` (IN `p_employee_document_type_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM employee_document_type
    WHERE employee_document_type_id = p_employee_document_type_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteEmployeeEducation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEmployeeEducation` (IN `p_employee_education_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM employee_education
    WHERE employee_education_id = p_employee_education_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteEmployeeEmergencyContact`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEmployeeEmergencyContact` (IN `p_employee_emergency_contact_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM employee_emergency_contact
    WHERE employee_emergency_contact_id = p_employee_emergency_contact_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteEmployeeExperience`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEmployeeExperience` (IN `p_employee_experience_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM employee_experience
    WHERE employee_experience_id = p_employee_experience_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteEmployeeLanguage`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEmployeeLanguage` (IN `p_employee_language_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM employee_language
    WHERE employee_language_id = p_employee_language_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteEmployeeLicense`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEmployeeLicense` (IN `p_employee_license_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM employee_license
    WHERE employee_license_id = p_employee_license_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteEmploymentLocationType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEmploymentLocationType` (IN `p_employment_location_type_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM employment_location_type
    WHERE employment_location_type_id = p_employment_location_type_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteEmploymentType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEmploymentType` (IN `p_employment_type_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM employment_type
    WHERE employment_type_id = p_employment_type_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteFileExtension`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteFileExtension` (IN `p_file_extension_id` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `deleteFileType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteFileType` (IN `p_file_type_id` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `deleteGender`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteGender` (IN `p_gender_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM gender WHERE gender_id = p_gender_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteJobPosition`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteJobPosition` (IN `p_job_position_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM job_position
    WHERE job_position_id = p_job_position_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteLanguage`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteLanguage` (IN `p_language_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM language WHERE language_id = p_language_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteLanguageProficiency`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteLanguageProficiency` (IN `p_language_proficiency_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM language_proficiency WHERE language_proficiency_id = p_language_proficiency_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteMenuItem`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteMenuItem` (IN `p_menu_item_id` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `deleteNationality`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteNationality` (IN `p_nationality_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM nationality WHERE nationality_id = p_nationality_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteNotificationSetting`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteNotificationSetting` (IN `p_notification_setting_id` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `deleteProductCategories`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteProductCategories` (IN `p_product_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM product_categories 
    WHERE product_id = p_product_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteProductCategory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteProductCategory` (IN `p_product_category_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM product_category WHERE product_category_id = p_product_category_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteRelationship`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteRelationship` (IN `p_relationship_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM relationship WHERE relationship_id = p_relationship_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteReligion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteReligion` (IN `p_religion_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM religion WHERE religion_id = p_religion_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteRole`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteRole` (IN `p_role_id` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `deleteRolePermission`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteRolePermission` (IN `p_role_permission_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM role_permission
    WHERE role_permission_id = p_role_permission_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteRoleSystemActionPermission`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteRoleSystemActionPermission` (IN `p_role_system_action_permission_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM role_system_action_permission
    WHERE role_system_action_permission_id = p_role_system_action_permission_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteRoleUserAccount`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteRoleUserAccount` (IN `p_role_user_account_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM role_user_account
    WHERE role_user_account_id = p_role_user_account_id;
    
    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteState`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteState` (IN `p_state_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM city WHERE state_id = p_state_id;
    DELETE FROM state WHERE state_id = p_state_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteSupplier`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteSupplier` (IN `p_supplier_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM supplier WHERE supplier_id = p_supplier_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteSystemAction`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteSystemAction` (IN `p_system_action_id` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `deleteTax`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteTax` (IN `p_tax_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM tax WHERE tax_id = p_tax_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteUploadSetting`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteUploadSetting` (IN `p_upload_setting_id` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `deleteUploadSettingFileExtension`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteUploadSettingFileExtension` (IN `p_upload_setting_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM upload_setting_file_extension 
    WHERE upload_setting_id = p_upload_setting_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteUserAccount`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteUserAccount` (IN `p_user_account_id` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `deleteWarehouse`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteWarehouse` (IN `p_warehouse_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM warehouse WHERE warehouse_id = p_warehouse_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteWarehouseType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteWarehouseType` (IN `p_warehouse_type_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM warehouse_type WHERE warehouse_type_id = p_warehouse_type_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `deleteWorkLocation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteWorkLocation` (IN `p_work_location_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM work_location
    WHERE work_location_id = p_work_location_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `fetchAddressType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchAddressType` (IN `p_address_type_id` INT)   BEGIN
	SELECT * FROM address_type
	WHERE address_type_id = p_address_type_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchAllEmployeeDocument`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchAllEmployeeDocument` (IN `p_employee_id` INT)   BEGIN
	SELECT * FROM employee_document
	WHERE employee_id = p_employee_id;
END$$

DROP PROCEDURE IF EXISTS `fetchAppModule`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchAppModule` (IN `p_app_module_id` INT)   BEGIN
	SELECT * FROM app_module
	WHERE app_module_id = p_app_module_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchAppModuleStack`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchAppModuleStack` (IN `p_user_account_id` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `fetchAttribute`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchAttribute` (IN `p_attribute_id` INT)   BEGIN
	SELECT * FROM attribute
	WHERE attribute_id = p_attribute_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchAttributeValue`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchAttributeValue` (IN `p_attribute_value_id` INT)   BEGIN
	SELECT * FROM attribute_value
	WHERE attribute_value_id = p_attribute_value_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchBank`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchBank` (IN `p_bank_id` INT)   BEGIN
	SELECT * FROM bank
	WHERE bank_id = p_bank_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchBankAccountType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchBankAccountType` (IN `p_bank_account_type_id` INT)   BEGIN
	SELECT * FROM bank_account_type
	WHERE bank_account_type_id = p_bank_account_type_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchBloodType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchBloodType` (IN `p_blood_type_id` INT)   BEGIN
	SELECT * FROM blood_type
	WHERE blood_type_id = p_blood_type_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchBreadcrumb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchBreadcrumb` (IN `p_page_id` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `fetchCity`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchCity` (IN `p_city_id` INT)   BEGIN
	SELECT * FROM city
	WHERE city_id = p_city_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchCivilStatus`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchCivilStatus` (IN `p_civil_status_id` INT)   BEGIN
	SELECT * FROM civil_status
	WHERE civil_status_id = p_civil_status_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchCompany`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchCompany` (IN `p_company_id` INT)   BEGIN
	SELECT * FROM company
	WHERE company_id = p_company_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchContactInformationType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchContactInformationType` (IN `p_contact_information_type_id` INT)   BEGIN
	SELECT * FROM contact_information_type
	WHERE contact_information_type_id = p_contact_information_type_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchCountry`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchCountry` (IN `p_country_id` INT)   BEGIN
	SELECT * FROM country
	WHERE country_id = p_country_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchCredentialType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchCredentialType` (IN `p_credential_type_id` INT)   BEGIN
	SELECT * FROM credential_type
	WHERE credential_type_id = p_credential_type_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchCurrency`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchCurrency` (IN `p_currency_id` INT)   BEGIN
	SELECT * FROM currency
	WHERE currency_id = p_currency_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchDepartment`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchDepartment` (IN `p_department_id` INT)   BEGIN
	SELECT *
    FROM department
	WHERE department_id = p_department_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchDepartureReason`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchDepartureReason` (IN `p_departure_reason_id` INT)   BEGIN
	SELECT * FROM departure_reason
	WHERE departure_reason_id = p_departure_reason_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchEducationalStage`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchEducationalStage` (IN `p_educational_stage_id` INT)   BEGIN
	SELECT * FROM educational_stage
	WHERE educational_stage_id = p_educational_stage_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchEmailNotificationTemplate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchEmailNotificationTemplate` (IN `p_notification_setting_id` INT)   BEGIN
    SELECT * 
    FROM notification_setting_email_template
    WHERE notification_setting_id = p_notification_setting_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchEmployee`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchEmployee` (IN `p_employee_id` INT)   BEGIN
	SELECT * FROM employee
	WHERE employee_id = p_employee_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchEmployeeDocument`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchEmployeeDocument` (IN `p_employee_document_id` INT)   BEGIN
	SELECT * FROM employee_document
	WHERE employee_document_id = p_employee_document_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchEmployeeDocumentType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchEmployeeDocumentType` (IN `p_employee_document_type_id` INT)   BEGIN
	SELECT * FROM employee_document_type
	WHERE employee_document_type_id = p_employee_document_type_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchEmployeeEducation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchEmployeeEducation` (IN `p_employee_education_id` INT)   BEGIN
	SELECT * FROM employee_education
	WHERE employee_education_id = p_employee_education_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchEmployeeEmergencyContact`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchEmployeeEmergencyContact` (IN `p_employee_emergency_contact_id` INT)   BEGIN
	SELECT * FROM employee_emergency_contact
	WHERE employee_emergency_contact_id = p_employee_emergency_contact_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchEmployeeExperience`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchEmployeeExperience` (IN `p_employee_experience_id` INT)   BEGIN
	SELECT * FROM employee_experience
	WHERE employee_experience_id = p_employee_experience_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchEmployeeLicense`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchEmployeeLicense` (IN `p_employee_license_id` INT)   BEGIN
	SELECT * FROM employee_license
	WHERE employee_license_id = p_employee_license_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchEmploymentLocationType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchEmploymentLocationType` (IN `p_employment_location_type_id` INT)   BEGIN
	SELECT * FROM employment_location_type
	WHERE employment_location_type_id = p_employment_location_type_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchEmploymentType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchEmploymentType` (IN `p_employment_type_id` INT)   BEGIN
	SELECT * FROM employment_type
	WHERE employment_type_id = p_employment_type_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchExportData`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchExportData` (IN `p_table_name` VARCHAR(255), IN `p_columns` TEXT, IN `p_ids` TEXT)   BEGIN
    SET @sql = CONCAT('SELECT ', p_columns, ' FROM ', p_table_name, ' WHERE ', p_table_name, '_id IN (', p_ids, ')');

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DROP PROCEDURE IF EXISTS `fetchFileExtension`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchFileExtension` (IN `p_file_extension_id` INT)   BEGIN
	SELECT * FROM file_extension
	WHERE file_extension_id = p_file_extension_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchFileType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchFileType` (IN `p_file_type_id` INT)   BEGIN
	SELECT * FROM file_type
	WHERE file_type_id = p_file_type_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchGender`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchGender` (IN `p_gender_id` INT)   BEGIN
	SELECT * FROM gender
	WHERE gender_id = p_gender_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchJobPosition`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchJobPosition` (IN `p_job_position_id` INT)   BEGIN
	SELECT * FROM job_position
	WHERE job_position_id = p_job_position_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchLanguage`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchLanguage` (IN `p_language_id` INT)   BEGIN
	SELECT * FROM language
	WHERE language_id = p_language_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchLanguageProficiency`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchLanguageProficiency` (IN `p_language_proficiency_id` INT)   BEGIN
	SELECT * FROM language_proficiency
	WHERE language_proficiency_id = p_language_proficiency_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchLoginCredentials`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchLoginCredentials` (IN `p_credential` VARCHAR(255))   BEGIN
    SELECT *
    FROM user_account
    WHERE user_account_id = CAST(p_credential AS UNSIGNED) OR email = BINARY p_credential
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchLogNotes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchLogNotes` (IN `p_table_name` VARCHAR(255), IN `p_reference_id` INT)   BEGIN
	SELECT log, changed_by, changed_at
    FROM audit_log
    WHERE table_name = p_table_name AND reference_id  = p_reference_id
    ORDER BY changed_at DESC;
END$$

DROP PROCEDURE IF EXISTS `fetchMenuItem`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchMenuItem` (IN `p_menu_item_id` INT)   BEGIN
	SELECT * FROM menu_item
	WHERE menu_item_id = p_menu_item_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchNationality`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchNationality` (IN `p_nationality_id` INT)   BEGIN
	SELECT * FROM nationality
	WHERE nationality_id = p_nationality_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchNavBar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchNavBar` (IN `p_user_account_id` INT, IN `p_app_module_id` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `fetchNotificationSetting`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchNotificationSetting` (IN `p_notification_setting_id` INT)   BEGIN
    SELECT * 
    FROM notification_setting
    WHERE notification_setting_id = p_notification_setting_id
    LIMIT 1;
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

DROP PROCEDURE IF EXISTS `fetchProduct`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchProduct` (IN `p_product_id` INT)   BEGIN
	SELECT * FROM product
	WHERE product_id = p_product_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchProductCategories`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchProductCategories` (IN `p_product_id` INT)   BEGIN
	SELECT * FROM product_categories
	WHERE product_id = p_product_id;
END$$

DROP PROCEDURE IF EXISTS `fetchProductCategory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchProductCategory` (IN `p_product_category_id` INT)   BEGIN
	SELECT * FROM product_category
	WHERE product_category_id = p_product_category_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchRelationship`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchRelationship` (IN `p_relationship_id` INT)   BEGIN
	SELECT * FROM relationship
	WHERE relationship_id = p_relationship_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchReligion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchReligion` (IN `p_religion_id` INT)   BEGIN
	SELECT * FROM religion
	WHERE religion_id = p_religion_id
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

DROP PROCEDURE IF EXISTS `fetchRole`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchRole` (IN `p_role_id` INT)   BEGIN
	SELECT * FROM role
    WHERE role_id = p_role_id
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
    WHERE notification_setting_id = p_notification_setting_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchState`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchState` (IN `p_state_id` INT)   BEGIN
	SELECT * FROM state
	WHERE state_id = p_state_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchSupplier`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchSupplier` (IN `p_supplier_id` INT)   BEGIN
	SELECT * FROM supplier
	WHERE supplier_id = p_supplier_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchSystemAction`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchSystemAction` (IN `p_system_action_id` INT)   BEGIN
	SELECT * FROM system_action
	WHERE system_action_id = p_system_action_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchSystemNotificationTemplate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchSystemNotificationTemplate` (IN `p_notification_setting_id` INT)   BEGIN
    SELECT * 
    FROM notification_setting_system_template
    WHERE notification_setting_id = p_notification_setting_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchTax`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchTax` (IN `p_tax_id` INT)   BEGIN
	SELECT * FROM tax
	WHERE tax_id = p_tax_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchUploadSetting`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchUploadSetting` (IN `p_upload_setting_id` INT)   BEGIN
	SELECT * FROM upload_setting
	WHERE upload_setting_id = p_upload_setting_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchUploadSettingFileExtension`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchUploadSettingFileExtension` (IN `p_upload_setting_id` INT)   BEGIN
	SELECT * FROM upload_setting_file_extension
	WHERE upload_setting_id = p_upload_setting_id;
END$$

DROP PROCEDURE IF EXISTS `fetchUserAccount`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchUserAccount` (IN `p_user_account_id` INT)   BEGIN
	SELECT * FROM user_account
	WHERE user_account_id = p_user_account_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchWarehouse`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchWarehouse` (IN `p_warehouse_id` INT)   BEGIN
	SELECT * FROM warehouse
	WHERE warehouse_id = p_warehouse_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchWarehouseType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchWarehouseType` (IN `p_warehouse_type_id` INT)   BEGIN
	SELECT * FROM warehouse_type
	WHERE warehouse_type_id = p_warehouse_type_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `fetchWorkLocation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchWorkLocation` (IN `p_work_location_id` INT)   BEGIN
	SELECT * FROM work_location
	WHERE work_location_id = p_work_location_id
    LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `generateAddressTypeOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateAddressTypeOptions` ()   BEGIN
	SELECT address_type_id, address_type_name 
    FROM address_type 
    ORDER BY address_type_name;
END$$

DROP PROCEDURE IF EXISTS `generateAddressTypeTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateAddressTypeTable` ()   BEGIN
	SELECT address_type_id, address_type_name
    FROM address_type 
    ORDER BY address_type_id;
END$$

DROP PROCEDURE IF EXISTS `generateAppModuleOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateAppModuleOptions` ()   BEGIN
	SELECT app_module_id, app_module_name 
    FROM app_module 
    ORDER BY app_module_name;
END$$

DROP PROCEDURE IF EXISTS `generateAppModuleTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateAppModuleTable` ()   BEGIN
	SELECT app_module_id, app_module_name, app_module_description, app_logo, order_sequence 
    FROM app_module 
    ORDER BY app_module_name;
END$$

DROP PROCEDURE IF EXISTS `generateAttributeOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateAttributeOptions` ()   BEGIN
	SELECT attribute_id, attribute_name 
    FROM attribute 
    ORDER BY attribute_name;
END$$

DROP PROCEDURE IF EXISTS `generateAttributeTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateAttributeTable` ()   BEGIN
	SELECT attribute_id, attribute_name
    FROM attribute 
    ORDER BY attribute_id;
END$$

DROP PROCEDURE IF EXISTS `generateAttributeValueTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateAttributeValueTable` (IN `p_attribute_id` INT)   BEGIN
	SELECT attribute_value_id, attribute_value_name
    FROM attribute_value 
    WHERE attribute_id = p_attribute_id
    ORDER BY attribute_value_name;
END$$

DROP PROCEDURE IF EXISTS `generateBankAccountTypeOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateBankAccountTypeOptions` ()   BEGIN
	SELECT bank_account_type_id, bank_account_type_name 
    FROM bank_account_type 
    ORDER BY bank_account_type_name;
END$$

DROP PROCEDURE IF EXISTS `generateBankAccountTypeTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateBankAccountTypeTable` ()   BEGIN
	SELECT bank_account_type_id, bank_account_type_name
    FROM bank_account_type 
    ORDER BY bank_account_type_id;
END$$

DROP PROCEDURE IF EXISTS `generateBankOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateBankOptions` ()   BEGIN
    SELECT bank_id, bank_name
    FROM bank 
    ORDER BY bank_name;
END$$

DROP PROCEDURE IF EXISTS `generateBankTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateBankTable` ()   BEGIN
    SELECT bank_id, bank_name, bank_identifier_code FROM bank;
END$$

DROP PROCEDURE IF EXISTS `generateBloodTypeOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateBloodTypeOptions` ()   BEGIN
	SELECT blood_type_id, blood_type_name 
    FROM blood_type 
    ORDER BY blood_type_name;
END$$

DROP PROCEDURE IF EXISTS `generateBloodTypeTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateBloodTypeTable` ()   BEGIN
	SELECT blood_type_id, blood_type_name
    FROM blood_type 
    ORDER BY blood_type_id;
END$$

DROP PROCEDURE IF EXISTS `generateCityOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateCityOptions` ()   BEGIN
    SELECT city_id, city_name, state_name, country_name
    FROM city 
    ORDER BY city_name;
END$$

DROP PROCEDURE IF EXISTS `generateCityTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateCityTable` (IN `p_filter_by_state` TEXT, IN `p_filter_by_country` TEXT)   BEGIN
    DECLARE query TEXT;
    DECLARE filter_conditions TEXT DEFAULT '';

    SET query = 'SELECT city_id, city_name, state_name, country_name 
                FROM city ';

    IF p_filter_by_state IS NOT NULL AND p_filter_by_state <> '' THEN
        SET filter_conditions = CONCAT(filter_conditions, ' state_id IN (', p_filter_by_state, ')');
    END IF;

    IF p_filter_by_country IS NOT NULL AND p_filter_by_country <> '' THEN
        IF filter_conditions <> '' THEN
            SET filter_conditions = CONCAT(filter_conditions, ' AND ');
        END IF;

        SET filter_conditions = CONCAT(filter_conditions, ' country_id IN (', p_filter_by_country, ')');
    END IF;

    IF filter_conditions <> '' THEN
        SET query = CONCAT(query, ' WHERE ', filter_conditions);
    END IF;

    SET query = CONCAT(query, ' ORDER BY city_name');

    PREPARE stmt FROM query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DROP PROCEDURE IF EXISTS `generateCivilStatusOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateCivilStatusOptions` ()   BEGIN
	SELECT civil_status_id, civil_status_name 
    FROM civil_status 
    ORDER BY civil_status_name;
END$$

DROP PROCEDURE IF EXISTS `generateCivilStatusTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateCivilStatusTable` ()   BEGIN
	SELECT civil_status_id, civil_status_name
    FROM civil_status 
    ORDER BY civil_status_id;
END$$

DROP PROCEDURE IF EXISTS `generateCompanyOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateCompanyOptions` ()   BEGIN
	SELECT company_id, company_name 
    FROM company 
    ORDER BY company_name;
END$$

DROP PROCEDURE IF EXISTS `generateCompanyTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateCompanyTable` (IN `p_filter_by_city` TEXT, IN `p_filter_by_state` TEXT, IN `p_filter_by_country` TEXT, IN `p_filter_by_currency` TEXT)   BEGIN
    DECLARE query TEXT;
    DECLARE filter_conditions TEXT DEFAULT '';

    SET query = 'SELECT company_id, company_name, company_logo, address, city_name, state_name, country_name 
                FROM company ';

    IF p_filter_by_city IS NOT NULL AND p_filter_by_city <> '' THEN
        SET filter_conditions = CONCAT(filter_conditions, ' city_id IN (', p_filter_by_city, ')');
    END IF;

    IF p_filter_by_state IS NOT NULL AND p_filter_by_state <> '' THEN
        IF filter_conditions <> '' THEN
            SET filter_conditions = CONCAT(filter_conditions, ' AND ');
        END IF;

        SET filter_conditions = CONCAT(filter_conditions, ' state_id IN (', p_filter_by_state, ')');
    END IF;

    IF p_filter_by_country IS NOT NULL AND p_filter_by_country <> '' THEN
        IF filter_conditions <> '' THEN
            SET filter_conditions = CONCAT(filter_conditions, ' AND ');
        END IF;

        SET filter_conditions = CONCAT(filter_conditions, ' country_id IN (', p_filter_by_country, ')');
    END IF;

    IF p_filter_by_currency IS NOT NULL AND p_filter_by_currency <> '' THEN
        IF filter_conditions <> '' THEN
            SET filter_conditions = CONCAT(filter_conditions, ' AND ');
        END IF;

        SET filter_conditions = CONCAT(filter_conditions, ' currency_id IN (', p_filter_by_currency, ')');
    END IF;

    IF filter_conditions <> '' THEN
        SET query = CONCAT(query, ' WHERE ', filter_conditions);
    END IF;

    SET query = CONCAT(query, ' ORDER BY company_name');

    PREPARE stmt FROM query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DROP PROCEDURE IF EXISTS `generateContactInformationTypeOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateContactInformationTypeOptions` ()   BEGIN
	SELECT contact_information_type_id, contact_information_type_name 
    FROM contact_information_type 
    ORDER BY contact_information_type_name;
END$$

DROP PROCEDURE IF EXISTS `generateContactInformationTypeTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateContactInformationTypeTable` ()   BEGIN
	SELECT contact_information_type_id, contact_information_type_name
    FROM contact_information_type 
    ORDER BY contact_information_type_id;
END$$

DROP PROCEDURE IF EXISTS `generateCountryOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateCountryOptions` ()   BEGIN
    SELECT country_id, country_name 
    FROM country 
    ORDER BY country_name;
END$$

DROP PROCEDURE IF EXISTS `generateCountryTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateCountryTable` ()   BEGIN
    SELECT country_id, country_name, country_code, phone_code 
    FROM country
    ORDER BY country_id;
END$$

DROP PROCEDURE IF EXISTS `generateCredentialTypeOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateCredentialTypeOptions` ()   BEGIN
	SELECT credential_type_id, credential_type_name 
    FROM credential_type 
    ORDER BY credential_type_name;
END$$

DROP PROCEDURE IF EXISTS `generateCredentialTypeTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateCredentialTypeTable` ()   BEGIN
	SELECT credential_type_id, credential_type_name
    FROM credential_type 
    ORDER BY credential_type_id;
END$$

DROP PROCEDURE IF EXISTS `generateCurrencyOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateCurrencyOptions` ()   BEGIN
    SELECT currency_id, currency_name, symbol
    FROM currency 
    ORDER BY currency_name;
END$$

DROP PROCEDURE IF EXISTS `generateCurrencyTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateCurrencyTable` ()   BEGIN
    SELECT currency_id, currency_name, symbol, shorthand 
    FROM currency
    ORDER BY currency_id;
END$$

DROP PROCEDURE IF EXISTS `generateDepartmentOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateDepartmentOptions` ()   BEGIN
	SELECT department_id, department_name
    FROM department 
    ORDER BY department_name;
END$$

DROP PROCEDURE IF EXISTS `generateDepartmentTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateDepartmentTable` (IN `p_filter_by_parent_department` TEXT, IN `p_filter_by_manager` TEXT)   BEGIN
    DECLARE query TEXT;
    DECLARE filter_conditions TEXT DEFAULT '';

    SET query = 'SELECT department_id, department_name, parent_department_name, manager_name
                FROM department ';

    IF p_filter_by_parent_department IS NOT NULL AND p_filter_by_parent_department <> '' THEN
        SET filter_conditions = CONCAT(filter_conditions, ' parent_department_id IN (', p_filter_by_parent_department, ')');
    END IF;

    IF p_filter_by_manager IS NOT NULL AND p_filter_by_manager <> '' THEN
        IF filter_conditions <> '' THEN
            SET filter_conditions = CONCAT(filter_conditions, ' AND ');
        END IF;

        SET filter_conditions = CONCAT(filter_conditions, ' manager_id IN (', p_filter_by_manager, ')');
    END IF;

    IF filter_conditions <> '' THEN
        SET query = CONCAT(query, ' WHERE ', filter_conditions);
    END IF;

    SET query = CONCAT(query, ' ORDER BY department_name');

    PREPARE stmt FROM query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DROP PROCEDURE IF EXISTS `generateDepartureReasonOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateDepartureReasonOptions` ()   BEGIN
	SELECT departure_reason_id, departure_reason_name 
    FROM departure_reason 
    ORDER BY departure_reason_name;
END$$

DROP PROCEDURE IF EXISTS `generateDepartureReasonTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateDepartureReasonTable` ()   BEGIN
	SELECT departure_reason_id, departure_reason_name
    FROM departure_reason 
    ORDER BY departure_reason_id;
END$$

DROP PROCEDURE IF EXISTS `generateEducationalStageOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEducationalStageOptions` ()   BEGIN
	SELECT educational_stage_id, educational_stage_name 
    FROM educational_stage 
    ORDER BY educational_stage_name;
END$$

DROP PROCEDURE IF EXISTS `generateEducationalStageTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEducationalStageTable` ()   BEGIN
	SELECT educational_stage_id, educational_stage_name
    FROM educational_stage 
    ORDER BY educational_stage_id;
END$$

DROP PROCEDURE IF EXISTS `generateEmployeeCard`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEmployeeCard` (IN `p_search_value` TEXT, IN `p_filter_by_company` TEXT, IN `p_filter_by_department` TEXT, IN `p_filter_by_job_position` TEXT, IN `p_filter_by_employee_status` TEXT, IN `p_filter_by_work_location` TEXT, IN `p_filter_by_employment_type` TEXT, IN `p_filter_by_gender` TEXT, IN `p_limit` INT, IN `p_offset` INT)   BEGIN
    DECLARE query TEXT;

    -- Base query
    SET query = 'SELECT employee_id, employee_image, full_name, department_name, job_position_name, employment_status
                 FROM employee
                 WHERE 1=1';

    -- Search filter
    IF p_search_value IS NOT NULL AND p_search_value <> '' THEN
        SET query = CONCAT(query, ' 
            AND (
                first_name LIKE ? OR
                middle_name LIKE ? OR
                last_name LIKE ? OR
                suffix LIKE ? OR
                department_name LIKE ? OR
                job_position_name LIKE ? OR
                employment_status LIKE ?
            )');
    END IF;

    -- Dynamic filters
    IF p_filter_by_company IS NOT NULL AND p_filter_by_company <> '' THEN
        SET query = CONCAT(query, ' AND company_id IN (', p_filter_by_company, ')');
    END IF;

    IF p_filter_by_department IS NOT NULL AND p_filter_by_department <> '' THEN
        SET query = CONCAT(query, ' AND department_id IN (', p_filter_by_department, ')');
    END IF;

    IF p_filter_by_job_position IS NOT NULL AND p_filter_by_job_position <> '' THEN
        SET query = CONCAT(query, ' AND job_position_id IN (', p_filter_by_job_position, ')');
    END IF;

    IF p_filter_by_employee_status IS NOT NULL AND p_filter_by_employee_status <> '' THEN
        SET query = CONCAT(query, ' AND employment_status IN (', p_filter_by_employee_status, ')');
    END IF;

    IF p_filter_by_work_location IS NOT NULL AND p_filter_by_work_location <> '' THEN
        SET query = CONCAT(query, ' AND work_location_id IN (', p_filter_by_work_location, ')');
    END IF;

    IF p_filter_by_employment_type IS NOT NULL AND p_filter_by_employment_type <> '' THEN
        SET query = CONCAT(query, ' AND employment_type_id IN (', p_filter_by_employment_type, ')');
    END IF;

    IF p_filter_by_gender IS NOT NULL AND p_filter_by_gender <> '' THEN
        SET query = CONCAT(query, ' AND gender_id IN (', p_filter_by_gender, ')');
    END IF;

    -- Final ordering + limit
    SET query = CONCAT(query, ' ORDER BY full_name LIMIT ?, ?');

    PREPARE stmt FROM query;

    -- Bind parameters for search + pagination
    IF p_search_value IS NOT NULL AND p_search_value <> '' THEN
        SET @s1 = CONCAT('%', p_search_value, '%');
        SET @s2 = @s1; SET @s3 = @s1; SET @s4 = @s1;
        SET @s5 = @s1; SET @s6 = @s1; SET @s7 = @s1;
        SET @offset = p_offset;
        SET @limit  = p_limit;

        EXECUTE stmt USING @s1, @s2, @s3, @s4, @s5, @s6, @s7, @offset, @limit;
    ELSE
        SET @offset = p_offset;
        SET @limit  = p_limit;

        EXECUTE stmt USING @offset, @limit;
    END IF;

    DEALLOCATE PREPARE stmt;
END$$

DROP PROCEDURE IF EXISTS `generateEmployeeDocumentTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEmployeeDocumentTable` (IN `p_employee_id` INT)   BEGIN
    SELECT 
        employee_document_id, 
        document_name, 
        document_file, 
        employee_document_type_name, 
        created_date, 
        last_updated
    FROM employee_document
    WHERE employee_id = p_employee_id
    ORDER BY created_date DESC;
END$$

DROP PROCEDURE IF EXISTS `generateEmployeeDocumentTypeOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEmployeeDocumentTypeOptions` ()   BEGIN
	SELECT employee_document_type_id, employee_document_type_name 
    FROM employee_document_type 
    ORDER BY employee_document_type_name;
END$$

DROP PROCEDURE IF EXISTS `generateEmployeeDocumentTypeTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEmployeeDocumentTypeTable` ()   BEGIN
	SELECT employee_document_type_id, employee_document_type_name
    FROM employee_document_type 
    ORDER BY employee_document_type_id;
END$$

DROP PROCEDURE IF EXISTS `generateEmployeeEducationList`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEmployeeEducationList` (IN `p_employee_id` INT)   BEGIN
    SELECT 
        employee_education_id, 
        school, 
        degree, 
        field_of_study, 
        start_month, 
        start_year, 
        end_month, 
        end_year, 
        activities_societies, 
        education_description
    FROM employee_education
    WHERE employee_id = p_employee_id
    ORDER BY
        CASE 
            WHEN (end_year IS NULL OR end_year = '' OR end_month IS NULL OR end_month = '') THEN 1
            ELSE 0
        END DESC,
        COALESCE(NULLIF(end_year, ''), start_year) DESC,
        COALESCE(NULLIF(end_month, ''), start_month) DESC;
END$$

DROP PROCEDURE IF EXISTS `generateEmployeeEmergencyContactList`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEmployeeEmergencyContactList` (IN `p_employee_id` INT)   BEGIN
    SELECT 
        employee_emergency_contact_id, 
        emergency_contact_name, 
        relationship_name, 
        telephone, 
        mobile, 
        email
    FROM employee_emergency_contact
    WHERE employee_id = p_employee_id
    ORDER BY emergency_contact_name;
END$$

DROP PROCEDURE IF EXISTS `generateEmployeeExperienceList`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEmployeeExperienceList` (IN `p_employee_id` INT)   BEGIN
    SELECT 
        employee_experience_id, 
        job_title, 
        employment_type_name, 
        company_name, 
        location, 
        work_location_type_name, 
        start_month, 
        start_year, 
        end_month, 
        end_year, 
        job_description
    FROM employee_experience
    WHERE employee_id = p_employee_id
    ORDER BY
        CASE 
            WHEN (end_year IS NULL OR end_year = '' OR end_month IS NULL OR end_month = '') THEN 1
            ELSE 0
        END DESC,
        COALESCE(NULLIF(end_year, ''), start_year) DESC,
        COALESCE(NULLIF(end_month, ''), start_month) DESC;
END$$

DROP PROCEDURE IF EXISTS `generateEmployeeLanguageList`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEmployeeLanguageList` (IN `p_employee_id` INT)   BEGIN
	SELECT employee_language_id, language_name, language_proficiency_name
    FROM employee_language
    WHERE employee_id = p_employee_id
    ORDER BY language_name;
END$$

DROP PROCEDURE IF EXISTS `generateEmployeeLanguageOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEmployeeLanguageOptions` (IN `p_employee_id` INT)   BEGIN
	SELECT language_id, language_name 
    FROM language
    WHERE language_id NOT IN (SELECT language_id FROM employee_language WHERE employee_id = p_employee_id)
    ORDER BY language_name;
END$$

DROP PROCEDURE IF EXISTS `generateEmployeeLicenseList`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEmployeeLicenseList` (IN `p_employee_id` INT)   BEGIN
    SELECT 
        employee_license_id, 
        licensed_profession, 
        licensing_body, 
        license_number, 
        issue_date, 
        expiration_date
    FROM employee_license
    WHERE employee_id = p_employee_id
    ORDER BY licensed_profession;
END$$

DROP PROCEDURE IF EXISTS `generateEmployeeOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEmployeeOptions` ()   BEGIN
	SELECT employee_id, full_name
    FROM employee 
    ORDER BY full_name;
END$$

DROP PROCEDURE IF EXISTS `generateEmployeeTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEmployeeTable` (IN `p_filter_by_company` TEXT, IN `p_filter_by_department` TEXT, IN `p_filter_by_job_position` TEXT, IN `p_filter_by_employee_status` TEXT, IN `p_filter_by_work_location` TEXT, IN `p_filter_by_employment_type` TEXT, IN `p_filter_by_gender` TEXT)   BEGIN
    DECLARE query TEXT DEFAULT 
        'SELECT employee_id, employee_image, full_name, department_name, job_position_name, employment_status
        FROM employee WHERE 1=1';

   IF p_filter_by_company IS NOT NULL AND p_filter_by_company <> '' THEN
        SET query = CONCAT(query, ' AND company_id IN (', p_filter_by_company, ')');
    END IF;

    IF p_filter_by_department IS NOT NULL AND p_filter_by_department <> '' THEN
        SET query = CONCAT(query, ' AND department_id IN (', p_filter_by_department, ')');
    END IF;

    IF p_filter_by_job_position IS NOT NULL AND p_filter_by_job_position <> '' THEN
        SET query = CONCAT(query, ' AND job_position_id IN (', p_filter_by_job_position, ')');
    END IF;

    IF p_filter_by_employee_status IS NOT NULL AND p_filter_by_employee_status <> '' THEN
        SET query = CONCAT(query, ' AND employment_status IN (', p_filter_by_employee_status, ')');
    END IF;

    IF p_filter_by_work_location IS NOT NULL AND p_filter_by_work_location <> '' THEN
        SET query = CONCAT(query, ' AND work_location_id IN (', p_filter_by_work_location, ')');
    END IF;

    IF p_filter_by_employment_type IS NOT NULL AND p_filter_by_employment_type <> '' THEN
        SET query = CONCAT(query, ' AND employment_type_id IN (', p_filter_by_employment_type, ')');
    END IF;

    IF p_filter_by_gender IS NOT NULL AND p_filter_by_gender <> '' THEN
        SET query = CONCAT(query, ' AND gender_id IN (', p_filter_by_gender, ')');
    END IF;

    SET query = CONCAT(query, ' ORDER BY full_name');

    PREPARE stmt FROM query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DROP PROCEDURE IF EXISTS `generateEmploymentLocationTypeOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEmploymentLocationTypeOptions` ()   BEGIN
	SELECT employment_location_type_id, employment_location_type_name 
    FROM employment_location_type 
    ORDER BY employment_location_type_name;
END$$

DROP PROCEDURE IF EXISTS `generateEmploymentLocationTypeTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEmploymentLocationTypeTable` ()   BEGIN
	SELECT employment_location_type_id, employment_location_type_name
    FROM employment_location_type 
    ORDER BY employment_location_type_id;
END$$

DROP PROCEDURE IF EXISTS `generateEmploymentTypeOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEmploymentTypeOptions` ()   BEGIN
	SELECT employment_type_id, employment_type_name 
    FROM employment_type 
    ORDER BY employment_type_name;
END$$

DROP PROCEDURE IF EXISTS `generateEmploymentTypeTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateEmploymentTypeTable` ()   BEGIN
	SELECT employment_type_id, employment_type_name
    FROM employment_type 
    ORDER BY employment_type_id;
END$$

DROP PROCEDURE IF EXISTS `generateExportOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateExportOptions` (IN `p_databasename` VARCHAR(500), IN `p_table_name` VARCHAR(500))   BEGIN
    SELECT column_name 
    FROM information_schema.columns 
    WHERE table_schema = p_databasename 
    AND table_name = p_table_name
    ORDER BY ordinal_position;
END$$

DROP PROCEDURE IF EXISTS `generateFileExtensionDualListBoxOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateFileExtensionDualListBoxOptions` (IN `p_upload_setting_id` INT)   BEGIN
	SELECT file_extension_id, file_extension_name, file_extension
    FROM file_extension 
    WHERE file_extension_id NOT IN (SELECT file_extension_id FROM upload_setting_file_extension WHERE upload_setting_id = p_upload_setting_id)
    ORDER BY file_extension_name;
END$$

DROP PROCEDURE IF EXISTS `generateFileExtensionOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateFileExtensionOptions` ()   BEGIN
	SELECT file_extension_id, file_extension_name, file_extension
    FROM file_extension 
    ORDER BY file_extension_name;
END$$

DROP PROCEDURE IF EXISTS `generateFileExtensionTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateFileExtensionTable` (IN `p_filter_by_file_type` TEXT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `generateFileTypeOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateFileTypeOptions` ()   BEGIN
	SELECT file_type_id, file_type_name 
    FROM file_type 
    ORDER BY file_type_name;
END$$

DROP PROCEDURE IF EXISTS `generateFileTypeTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateFileTypeTable` ()   BEGIN
	SELECT file_type_id, file_type_name
    FROM file_type 
    ORDER BY file_type_id;
END$$

DROP PROCEDURE IF EXISTS `generateGenderOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateGenderOptions` ()   BEGIN
	SELECT gender_id, gender_name 
    FROM gender 
    ORDER BY gender_name;
END$$

DROP PROCEDURE IF EXISTS `generateGenderTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateGenderTable` ()   BEGIN
	SELECT gender_id, gender_name
    FROM gender 
    ORDER BY gender_id;
END$$

DROP PROCEDURE IF EXISTS `generateJobPositionOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateJobPositionOptions` ()   BEGIN
	SELECT job_position_id, job_position_name 
    FROM job_position 
    ORDER BY job_position_name;
END$$

DROP PROCEDURE IF EXISTS `generateJobPositionTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateJobPositionTable` ()   BEGIN
	SELECT job_position_id, job_position_name
    FROM job_position 
    ORDER BY job_position_id;
END$$

DROP PROCEDURE IF EXISTS `generateLanguageOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateLanguageOptions` ()   BEGIN
	SELECT language_id, language_name 
    FROM language 
    ORDER BY language_name;
END$$

DROP PROCEDURE IF EXISTS `generateLanguageProficiencyOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateLanguageProficiencyOptions` ()   BEGIN
    SELECT language_proficiency_id, language_proficiency_name, language_proficiency_description
    FROM language_proficiency 
    ORDER BY language_proficiency_name;
END$$

DROP PROCEDURE IF EXISTS `generateLanguageProficiencyTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateLanguageProficiencyTable` ()   BEGIN
    SELECT language_proficiency_id, language_proficiency_name, language_proficiency_description 
    FROM language_proficiency
    ORDER BY language_proficiency_id;
END$$

DROP PROCEDURE IF EXISTS `generateLanguageTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateLanguageTable` ()   BEGIN
	SELECT language_id, language_name
    FROM language 
    ORDER BY language_id;
END$$

DROP PROCEDURE IF EXISTS `generateMenuItemAssignedRoleTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateMenuItemAssignedRoleTable` (IN `p_menu_item_id` INT)   BEGIN
    SELECT role_permission_id, role_name, read_access, write_access, create_access, delete_access, import_access, export_access, log_notes_access 
    FROM role_permission
    WHERE menu_item_id = p_menu_item_id;
END$$

DROP PROCEDURE IF EXISTS `generateMenuItemOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateMenuItemOptions` (IN `p_menu_item_id` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `generateMenuItemRoleDualListBoxOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateMenuItemRoleDualListBoxOptions` (IN `p_menu_item_id` INT)   BEGIN
	SELECT role_id, role_name 
    FROM role 
    WHERE role_id NOT IN (SELECT role_id FROM role_permission WHERE menu_item_id = p_menu_item_id)
    ORDER BY role_name;
END$$

DROP PROCEDURE IF EXISTS `generateMenuItemTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateMenuItemTable` (IN `p_filter_by_app_module` TEXT, IN `p_filter_by_parent_id` TEXT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `generateNationalityOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateNationalityOptions` ()   BEGIN
	SELECT nationality_id, nationality_name 
    FROM nationality 
    ORDER BY nationality_name;
END$$

DROP PROCEDURE IF EXISTS `generateNationalityTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateNationalityTable` ()   BEGIN
	SELECT nationality_id, nationality_name
    FROM nationality 
    ORDER BY nationality_id;
END$$

DROP PROCEDURE IF EXISTS `generateNotificationSettingTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateNotificationSettingTable` ()   BEGIN
    SELECT notification_setting_id, 
           notification_setting_name, 
           notification_setting_description
    FROM notification_setting 
    ORDER BY notification_setting_id;
END$$

DROP PROCEDURE IF EXISTS `generateParentCategoryOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateParentCategoryOptions` (IN `p_product_category_id` INT)   BEGIN
	SELECT product_category_id, product_category_name
    FROM product_category 
    WHERE product_category_id != p_product_category_id
    ORDER BY product_category_name;
END$$

DROP PROCEDURE IF EXISTS `generateParentDepartmentOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateParentDepartmentOptions` (IN `p_department_id` INT)   BEGIN
	SELECT department_id, department_name
    FROM department 
    WHERE department_id != p_department_id
    ORDER BY department_name;
END$$

DROP PROCEDURE IF EXISTS `generateProductCard`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateProductCard` (IN `p_search_value` TEXT, IN `p_filter_by_product_type` TEXT, IN `p_filter_by_product_category` TEXT, IN `p_filter_by_is_sellable` TEXT, IN `p_filter_by_is_purchasable` TEXT, IN `p_filter_by_show_on_pos` TEXT, IN `p_filter_by_product_status` TEXT, IN `p_limit` INT, IN `p_offset` INT)   BEGIN
    DECLARE query TEXT;

    -- Base query
    SET query = 'SELECT product_id, product_image, product_name, product_description, product_type, sku, barcode, is_sellable, is_purchasable, show_on_pos, quantity_on_hand, sales_price, cost, product_status
                FROM product
                WHERE 1=1';

    -- Search filter
    IF p_search_value IS NOT NULL AND p_search_value <> '' THEN
        SET query = CONCAT(query, ' 
            AND (
                product_name LIKE ? OR
                product_description LIKE ? OR
                sku LIKE ? OR
                barcode LIKE ?
            )');
    END IF;

    -- Dynamic filters
    IF p_filter_by_product_type IS NOT NULL AND p_filter_by_product_type <> '' THEN
        SET query = CONCAT(query, ' AND product_type IN (', p_filter_by_product_type, ')');
    END IF;

    IF p_filter_by_product_category IS NOT NULL AND p_filter_by_product_category <> '' THEN
        SET query = CONCAT(query, ' AND product_id IN (SELECT product_id FROM product_categories WHERE product_category_id IN (', p_filter_by_product_category, '))');
    END IF;

    IF p_filter_by_is_sellable IS NOT NULL AND p_filter_by_is_sellable <> '' THEN
        SET query = CONCAT(query, ' AND is_sellable IN (', p_filter_by_is_sellable, ')');
    END IF;

    IF p_filter_by_is_purchasable IS NOT NULL AND p_filter_by_is_purchasable <> '' THEN
        SET query = CONCAT(query, ' AND is_purchasable IN (', p_filter_by_is_purchasable, ')');
    END IF;

    IF p_filter_by_show_on_pos IS NOT NULL AND p_filter_by_show_on_pos <> '' THEN
        SET query = CONCAT(query, ' AND show_on_pos IN (', p_filter_by_show_on_pos, ')');
    END IF;

    IF p_filter_by_product_status IS NOT NULL AND p_filter_by_product_status <> '' THEN
        SET query = CONCAT(query, ' AND product_status IN (', p_filter_by_product_status, ')');
    END IF;

    -- Final ordering + limit
    SET query = CONCAT(query, ' ORDER BY product_name LIMIT ?, ?');

    PREPARE stmt FROM query;

    -- Bind parameters for search + pagination
    IF p_search_value IS NOT NULL AND p_search_value <> '' THEN
        SET @s1 = CONCAT('%', p_search_value, '%');
        SET @s2 = @s1; SET @s3 = @s1; SET @s4 = @s1;
        SET @offset = p_offset;
        SET @limit  = p_limit;

        EXECUTE stmt USING @s1, @s2, @s3, @s4, @offset, @limit;
    ELSE
        SET @offset = p_offset;
        SET @limit  = p_limit;

        EXECUTE stmt USING @offset, @limit;
    END IF;

    DEALLOCATE PREPARE stmt;
END$$

DROP PROCEDURE IF EXISTS `generateProductCategoryOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateProductCategoryOptions` ()   BEGIN
	SELECT product_category_id, product_category_name 
    FROM product_category 
    ORDER BY product_category_name;
END$$

DROP PROCEDURE IF EXISTS `generateProductCategoryTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateProductCategoryTable` (IN `p_filter_by_parent_category` TEXT, IN `p_filter_by_costing_method` TEXT)   BEGIN
    DECLARE query TEXT;
    DECLARE filter_conditions TEXT DEFAULT '';

    SET query = 'SELECT product_category_id, product_category_name, parent_category_name, costing_method
                FROM product_category';

    IF p_filter_by_parent_category IS NOT NULL AND p_filter_by_parent_category <> '' THEN
        SET filter_conditions = CONCAT(filter_conditions, ' parent_category_id IN (', p_filter_by_parent_category, ')');
    END IF;

    IF p_filter_by_costing_method IS NOT NULL AND p_filter_by_costing_method <> '' THEN
        SET filter_conditions = CONCAT(filter_conditions, ' costing_method IN (', p_filter_by_costing_method, ')');
    END IF;

    IF filter_conditions <> '' THEN
        SET query = CONCAT(query, ' WHERE ', filter_conditions);
    END IF;

    SET query = CONCAT(query, ' ORDER BY product_category_name');

    PREPARE stmt FROM query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DROP PROCEDURE IF EXISTS `generateProductTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateProductTable` (IN `p_filter_by_product_type` TEXT, IN `p_filter_by_product_category` TEXT, IN `p_filter_by_is_sellable` TEXT, IN `p_filter_by_is_purchasable` TEXT, IN `p_filter_by_show_on_pos` TEXT, IN `p_filter_by_product_status` TEXT)   BEGIN
    DECLARE query TEXT DEFAULT 
        'SELECT product_id, product_image, product_name, product_description, product_type, sku, barcode, is_sellable, is_purchasable, show_on_pos, quantity_on_hand, sales_price, cost, product_status
        FROM product WHERE 1=1';

     IF p_filter_by_product_type IS NOT NULL AND p_filter_by_product_type <> '' THEN
        SET query = CONCAT(query, ' AND product_type IN (', p_filter_by_product_type, ')');
    END IF;

    IF p_filter_by_product_category IS NOT NULL AND p_filter_by_product_category <> '' THEN
        SET query = CONCAT(query, ' AND product_id IN (SELECT product_id FROM product_categories WHERE product_category_id IN (', p_filter_by_product_category, '))');
    END IF;

    IF p_filter_by_is_sellable IS NOT NULL AND p_filter_by_is_sellable <> '' THEN
        SET query = CONCAT(query, ' AND is_sellable IN (', p_filter_by_is_sellable, ')');
    END IF;

    IF p_filter_by_is_purchasable IS NOT NULL AND p_filter_by_is_purchasable <> '' THEN
        SET query = CONCAT(query, ' AND is_purchasable IN (', p_filter_by_is_purchasable, ')');
    END IF;

    IF p_filter_by_show_on_pos IS NOT NULL AND p_filter_by_show_on_pos <> '' THEN
        SET query = CONCAT(query, ' AND show_on_pos IN (', p_filter_by_show_on_pos, ')');
    END IF;

    IF p_filter_by_product_status IS NOT NULL AND p_filter_by_product_status <> '' THEN
        SET query = CONCAT(query, ' AND product_status IN (', p_filter_by_product_status, ')');
    END IF;

    SET query = CONCAT(query, ' ORDER BY product_name');

    PREPARE stmt FROM query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DROP PROCEDURE IF EXISTS `generatePurchaseTaxOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generatePurchaseTaxOptions` ()   BEGIN
	SELECT tax_id, tax_name 
    FROM tax 
    WHERE tax_type = 'Purchases'
    ORDER BY tax_name;
END$$

DROP PROCEDURE IF EXISTS `generateRelationshipOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateRelationshipOptions` ()   BEGIN
	SELECT relationship_id, relationship_name 
    FROM relationship 
    ORDER BY relationship_name;
END$$

DROP PROCEDURE IF EXISTS `generateRelationshipTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateRelationshipTable` ()   BEGIN
	SELECT relationship_id, relationship_name
    FROM relationship 
    ORDER BY relationship_id;
END$$

DROP PROCEDURE IF EXISTS `generateReligionOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateReligionOptions` ()   BEGIN
	SELECT religion_id, religion_name 
    FROM religion 
    ORDER BY religion_name;
END$$

DROP PROCEDURE IF EXISTS `generateReligionTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateReligionTable` ()   BEGIN
	SELECT religion_id, religion_name
    FROM religion 
    ORDER BY religion_id;
END$$

DROP PROCEDURE IF EXISTS `generateRoleAssignedMenuItemTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateRoleAssignedMenuItemTable` (IN `p_role_id` INT)   BEGIN
    SELECT role_permission_id, menu_item_name, read_access, write_access, create_access, delete_access, import_access, export_access, log_notes_access 
    FROM role_permission
    WHERE role_id = p_role_id;
END$$

DROP PROCEDURE IF EXISTS `generateRoleAssignedSystemActionTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateRoleAssignedSystemActionTable` (IN `p_role_id` INT)   BEGIN
    SELECT role_system_action_permission_id, system_action_name, system_action_access 
    FROM role_system_action_permission
    WHERE role_id = p_role_id;
END$$

DROP PROCEDURE IF EXISTS `generateRoleMenuItemDualListBoxOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateRoleMenuItemDualListBoxOptions` (IN `p_role_id` INT)   BEGIN
	SELECT menu_item_id, menu_item_name 
    FROM menu_item 
    WHERE menu_item_id NOT IN (SELECT menu_item_id FROM role_permission WHERE role_id = p_role_id)
    ORDER BY menu_item_name;
END$$

DROP PROCEDURE IF EXISTS `generateRoleMenuItemPermissionTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateRoleMenuItemPermissionTable` (IN `p_role_id` INT)   BEGIN
	SELECT role_permission_id, menu_item_name, read_access, write_access, create_access, delete_access, import_access, export_access, log_notes_access
    FROM role_permission
    WHERE role_id = p_role_id
    ORDER BY menu_item_name;
END$$

DROP PROCEDURE IF EXISTS `generateRoleSystemActionDualListBoxOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateRoleSystemActionDualListBoxOptions` (IN `p_role_id` INT)   BEGIN
	SELECT system_action_id, system_action_name 
    FROM system_action
    WHERE system_action_id NOT IN (SELECT system_action_id FROM role_system_action_permission WHERE role_id = p_role_id)
    ORDER BY system_action_name;
END$$

DROP PROCEDURE IF EXISTS `generateRoleSystemActionPermissionTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateRoleSystemActionPermissionTable` (IN `p_role_id` INT)   BEGIN
	SELECT role_system_action_permission_id, system_action_name, system_action_access 
    FROM role_system_action_permission
    WHERE role_id = p_role_id
    ORDER BY system_action_name;
END$$

DROP PROCEDURE IF EXISTS `generateRoleTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateRoleTable` ()   BEGIN
	SELECT role_id, role_name, role_description
    FROM role 
    ORDER BY role_id;
END$$

DROP PROCEDURE IF EXISTS `generateRoleUserAccountTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateRoleUserAccountTable` (IN `p_role_id` INT)   BEGIN
	SELECT role_user_account_id, user_account_id, file_as 
    FROM role_user_account
    WHERE role_id = p_role_id
    ORDER BY file_as;
END$$

DROP PROCEDURE IF EXISTS `generateSalesTaxOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateSalesTaxOptions` ()   BEGIN
	SELECT tax_id, tax_name 
    FROM tax 
    WHERE tax_type = 'Sales'
    ORDER BY tax_name;
END$$

DROP PROCEDURE IF EXISTS `generateStateOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateStateOptions` ()   BEGIN
    SELECT state_id, state_name 
    FROM state 
    ORDER BY state_name;
END$$

DROP PROCEDURE IF EXISTS `generateStateTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateStateTable` (IN `p_filter_by_country` TEXT)   BEGIN
    DECLARE query TEXT;
    DECLARE filter_conditions TEXT DEFAULT '';

    SET query = 'SELECT state_id, state_name, country_name 
                FROM state ';

    IF p_filter_by_country IS NOT NULL AND p_filter_by_country <> '' THEN
        SET filter_conditions = CONCAT(filter_conditions, ' country_id IN (', p_filter_by_country, ')');
    END IF;

    IF filter_conditions <> '' THEN
        SET query = CONCAT(query, ' WHERE ', filter_conditions);
    END IF;

    SET query = CONCAT(query, ' ORDER BY state_name');

    PREPARE stmt FROM query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DROP PROCEDURE IF EXISTS `generateSupplierOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateSupplierOptions` ()   BEGIN
	SELECT supplier_id, supplier_name 
    FROM supplier 
    ORDER BY supplier_name;
END$$

DROP PROCEDURE IF EXISTS `generateSupplierTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateSupplierTable` (IN `p_filter_by_city` TEXT, IN `p_filter_by_state` TEXT, IN `p_filter_by_country` TEXT, IN `p_filter_by_supplier_status` TEXT)   BEGIN
    DECLARE query TEXT;
    DECLARE filter_conditions TEXT DEFAULT '';

    SET query = 'SELECT supplier_id, supplier_name, address, city_name, state_name, country_name 
                FROM supplier ';

    IF p_filter_by_city IS NOT NULL AND p_filter_by_city <> '' THEN
        SET filter_conditions = CONCAT(filter_conditions, ' city_id IN (', p_filter_by_city, ')');
    END IF;

    IF p_filter_by_state IS NOT NULL AND p_filter_by_state <> '' THEN
        IF filter_conditions <> '' THEN
            SET filter_conditions = CONCAT(filter_conditions, ' AND ');
        END IF;

        SET filter_conditions = CONCAT(filter_conditions, ' state_id IN (', p_filter_by_state, ')');
    END IF;

    IF p_filter_by_country IS NOT NULL AND p_filter_by_country <> '' THEN
        IF filter_conditions <> '' THEN
            SET filter_conditions = CONCAT(filter_conditions, ' AND ');
        END IF;

        SET filter_conditions = CONCAT(filter_conditions, ' country_id IN (', p_filter_by_country, ')');
    END IF;

    IF p_filter_by_supplier_status IS NOT NULL AND p_filter_by_supplier_status <> '' THEN
        IF filter_conditions <> '' THEN
            SET filter_conditions = CONCAT(filter_conditions, ' AND ');
        END IF;

        SET filter_conditions = CONCAT(filter_conditions, ' supplier_status IN (', p_filter_by_supplier_status, ')');
    END IF;

    IF filter_conditions <> '' THEN
        SET query = CONCAT(query, ' WHERE ', filter_conditions);
    END IF;

    SET query = CONCAT(query, ' ORDER BY supplier_name');

    PREPARE stmt FROM query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DROP PROCEDURE IF EXISTS `generateSystemActionAssignedRoleTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateSystemActionAssignedRoleTable` (IN `p_system_action_id` INT)   BEGIN
    SELECT role_system_action_permission_id, role_name, system_action_access 
    FROM role_system_action_permission
    WHERE system_action_id = p_system_action_id;
END$$

DROP PROCEDURE IF EXISTS `generateSystemActionOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateSystemActionOptions` ()   BEGIN
    SELECT system_action_id, system_action_name 
    FROM system_action 
    ORDER BY system_action_name;
END$$

DROP PROCEDURE IF EXISTS `generateSystemActionRoleDualListBoxOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateSystemActionRoleDualListBoxOptions` (IN `p_system_action_id` INT)   BEGIN
	SELECT role_id, role_name 
    FROM role 
    WHERE role_id NOT IN (SELECT role_id FROM role_system_action_permission WHERE system_action_id = p_system_action_id)
    ORDER BY role_name;
END$$

DROP PROCEDURE IF EXISTS `generateSystemActionTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateSystemActionTable` ()   BEGIN
    SELECT system_action_id, system_action_name, system_action_description 
    FROM system_action
    ORDER BY system_action_id;
END$$

DROP PROCEDURE IF EXISTS `generateTableOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateTableOptions` (IN `p_database_name` VARCHAR(255))   BEGIN
	SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = p_database_name;
END$$

DROP PROCEDURE IF EXISTS `generateTaxOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateTaxOptions` ()   BEGIN
	SELECT tax_id, tax_name 
    FROM tax 
    ORDER BY tax_name;
END$$

DROP PROCEDURE IF EXISTS `generateTaxTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateTaxTable` (IN `p_filter_by_tax_type` TEXT, IN `p_filter_by_tax_computation` TEXT, IN `p_filter_by_tax_scope` TEXT, IN `p_filter_by_tax_status` TEXT)   BEGIN
    DECLARE query TEXT;
    DECLARE filter_conditions TEXT DEFAULT '';

    SET query = 'SELECT tax_id, tax_name, tax_rate, tax_type, tax_computation, tax_scope 
                FROM tax ';

    IF p_filter_by_tax_type IS NOT NULL AND p_filter_by_tax_type <> '' THEN
        SET filter_conditions = CONCAT(filter_conditions, ' tax_type IN (', p_filter_by_tax_type, ')');
    END IF;

    IF p_filter_by_tax_computation IS NOT NULL AND p_filter_by_tax_computation <> '' THEN
        IF filter_conditions <> '' THEN
            SET filter_conditions = CONCAT(filter_conditions, ' AND ');
        END IF;

        SET filter_conditions = CONCAT(filter_conditions, ' tax_computation IN (', p_filter_by_tax_computation, ')');
    END IF;

    IF p_filter_by_tax_scope IS NOT NULL AND p_filter_by_tax_scope <> '' THEN
        IF filter_conditions <> '' THEN
            SET filter_conditions = CONCAT(filter_conditions, ' AND ');
        END IF;

        SET filter_conditions = CONCAT(filter_conditions, ' tax_scope IN (', p_filter_by_tax_scope, ')');
    END IF;

    IF p_filter_by_tax_status IS NOT NULL AND p_filter_by_tax_status <> '' THEN
        IF filter_conditions <> '' THEN
            SET filter_conditions = CONCAT(filter_conditions, ' AND ');
        END IF;

        SET filter_conditions = CONCAT(filter_conditions, ' tax_status IN (', p_filter_by_tax_status, ')');
    END IF;

    IF filter_conditions <> '' THEN
        SET query = CONCAT(query, ' WHERE ', filter_conditions);
    END IF;

    SET query = CONCAT(query, ' ORDER BY tax_name');

    PREPARE stmt FROM query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DROP PROCEDURE IF EXISTS `generateUploadSettingFileExtensionList`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateUploadSettingFileExtensionList` (IN `p_upload_setting_id` INT)   BEGIN
	SELECT upload_setting_file_extension_id, file_extension_id, file_extension_name, file_extension
    FROM upload_setting_file_extension
    WHERE upload_setting_id = p_upload_setting_id
    ORDER BY file_extension_name;
END$$

DROP PROCEDURE IF EXISTS `generateUploadSettingTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateUploadSettingTable` ()   BEGIN
	SELECT upload_setting_id, upload_setting_name, upload_setting_description, max_file_size
    FROM upload_setting 
    ORDER BY upload_setting_id;
END$$

DROP PROCEDURE IF EXISTS `generateUserAccountOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateUserAccountOptions` ()   BEGIN
	SELECT user_account_id, user_account_name 
    FROM user_account 
    ORDER BY user_account_name;
END$$

DROP PROCEDURE IF EXISTS `generateUserAccountRoleDualListBoxOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateUserAccountRoleDualListBoxOptions` (IN `p_user_account_id` INT)   BEGIN
	SELECT role_id, role_name 
    FROM role 
    WHERE role_id NOT IN (SELECT role_id FROM role_user_account WHERE user_account_id = p_user_account_id)
    ORDER BY role_name;
END$$

DROP PROCEDURE IF EXISTS `generateUserAccountRoleList`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateUserAccountRoleList` (IN `p_user_account_id` INT)   BEGIN
	SELECT role_user_account_id, role_name, date_assigned
    FROM role_user_account
    WHERE user_account_id = p_user_account_id
    ORDER BY role_name;
END$$

DROP PROCEDURE IF EXISTS `generateUserAccountTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateUserAccountTable` (IN `p_active` VARCHAR(5))   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `generateWarehouseOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateWarehouseOptions` ()   BEGIN
	SELECT warehouse_id, warehouse_name 
    FROM warehouse 
    ORDER BY warehouse_name;
END$$

DROP PROCEDURE IF EXISTS `generateWarehouseTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateWarehouseTable` (IN `p_filter_by_warehouse_type` TEXT, IN `p_filter_by_city` TEXT, IN `p_filter_by_state` TEXT, IN `p_filter_by_country` TEXT, IN `p_filter_by_warehouse_status` TEXT)   BEGIN
    DECLARE query TEXT;
    DECLARE filter_conditions TEXT DEFAULT '';

    SET query = 'SELECT warehouse_id, warehouse_name, address, city_name, state_name, country_name 
                FROM warehouse ';

    IF p_filter_by_warehouse_type IS NOT NULL AND p_filter_by_warehouse_type <> '' THEN
        SET filter_conditions = CONCAT(filter_conditions, ' warehouse_type_id IN (', p_filter_by_warehouse_type, ')');
    END IF;

    IF p_filter_by_city IS NOT NULL AND p_filter_by_city <> '' THEN
        SET filter_conditions = CONCAT(filter_conditions, ' city_id IN (', p_filter_by_city, ')');
    END IF;

    IF p_filter_by_state IS NOT NULL AND p_filter_by_state <> '' THEN
        IF filter_conditions <> '' THEN
            SET filter_conditions = CONCAT(filter_conditions, ' AND ');
        END IF;

        SET filter_conditions = CONCAT(filter_conditions, ' state_id IN (', p_filter_by_state, ')');
    END IF;

    IF p_filter_by_country IS NOT NULL AND p_filter_by_country <> '' THEN
        IF filter_conditions <> '' THEN
            SET filter_conditions = CONCAT(filter_conditions, ' AND ');
        END IF;

        SET filter_conditions = CONCAT(filter_conditions, ' country_id IN (', p_filter_by_country, ')');
    END IF;

    IF p_filter_by_warehouse_status IS NOT NULL AND p_filter_by_warehouse_status <> '' THEN
        IF filter_conditions <> '' THEN
            SET filter_conditions = CONCAT(filter_conditions, ' AND ');
        END IF;

        SET filter_conditions = CONCAT(filter_conditions, ' warehouse_status IN (', p_filter_by_warehouse_status, ')');
    END IF;

    IF filter_conditions <> '' THEN
        SET query = CONCAT(query, ' WHERE ', filter_conditions);
    END IF;

    SET query = CONCAT(query, ' ORDER BY warehouse_name');

    PREPARE stmt FROM query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DROP PROCEDURE IF EXISTS `generateWarehouseTypeOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateWarehouseTypeOptions` ()   BEGIN
	SELECT warehouse_type_id, warehouse_type_name 
    FROM warehouse_type 
    ORDER BY warehouse_type_name;
END$$

DROP PROCEDURE IF EXISTS `generateWarehouseTypeTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateWarehouseTypeTable` ()   BEGIN
	SELECT warehouse_type_id, warehouse_type_name
    FROM warehouse_type 
    ORDER BY warehouse_type_id;
END$$

DROP PROCEDURE IF EXISTS `generateWorkLocationOptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateWorkLocationOptions` ()   BEGIN
	SELECT work_location_id, work_location_name 
    FROM work_location 
    ORDER BY work_location_name;
END$$

DROP PROCEDURE IF EXISTS `generateWorkLocationTable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateWorkLocationTable` (IN `p_filter_by_city` TEXT, IN `p_filter_by_state` TEXT, IN `p_filter_by_country` TEXT)   BEGIN
    DECLARE query TEXT;
    DECLARE filter_conditions TEXT DEFAULT '';

    SET query = 'SELECT work_location_id, work_location_name, address, city_name, state_name, country_name 
                FROM work_location ';

    IF p_filter_by_city IS NOT NULL AND p_filter_by_city <> '' THEN
        SET filter_conditions = CONCAT(filter_conditions, ' city_id IN (', p_filter_by_city, ')');
    END IF;

    IF p_filter_by_state IS NOT NULL AND p_filter_by_state <> '' THEN
        IF filter_conditions <> '' THEN
            SET filter_conditions = CONCAT(filter_conditions, ' AND ');
        END IF;

        SET filter_conditions = CONCAT(filter_conditions, ' state_id IN (', p_filter_by_state, ')');
    END IF;

    IF p_filter_by_country IS NOT NULL AND p_filter_by_country <> '' THEN
        IF filter_conditions <> '' THEN
            SET filter_conditions = CONCAT(filter_conditions, ' AND ');
        END IF;
        
        SET filter_conditions = CONCAT(filter_conditions, ' country_id IN (', p_filter_by_country, ')');
    END IF;

    IF filter_conditions <> '' THEN
        SET query = CONCAT(query, ' WHERE ', filter_conditions);
    END IF;

    SET query = CONCAT(query, ' ORDER BY work_location_name');

    PREPARE stmt FROM query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DROP PROCEDURE IF EXISTS `insertEmployee`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEmployee` (IN `p_full_name` VARCHAR(1000), IN `p_first_name` VARCHAR(300), IN `p_middle_name` VARCHAR(300), IN `p_last_name` VARCHAR(300), IN `p_suffix` VARCHAR(10), IN `p_company_id` INT, IN `p_company_name` VARCHAR(100), IN `p_department_id` INT, IN `p_department_name` VARCHAR(100), IN `p_job_position_id` INT, IN `p_job_position_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_employee_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO employee (
        full_name,
        first_name,
        middle_name,
        last_name,
        suffix,
        company_id,
        company_name,
        department_id,
        department_name,
        job_position_id,
        job_position_name,
        last_log_by
    ) 
    VALUES(
        p_full_name,
        p_first_name,
        p_middle_name,
        p_last_name,
        p_suffix,
        p_company_id,
        p_company_name,
        p_department_id,
        p_department_name,
        p_job_position_id,
        p_job_position_name,
        p_last_log_by
    );

    SET v_new_employee_id = LAST_INSERT_ID();

    COMMIT;

    SELECT v_new_employee_id AS new_employee_id;
END$$

DROP PROCEDURE IF EXISTS `insertEmployeeDocument`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEmployeeDocument` (IN `p_employee_id` INT, IN `p_document_name` VARCHAR(200), IN `p_document_file` VARCHAR(500), IN `p_employee_document_type_id` INT, IN `p_employee_document_type_name` VARCHAR(500), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO employee_document (
        employee_id,
        document_name,
        document_file,
        employee_document_type_id,
        employee_document_type_name,
        last_log_by
    ) 
    VALUES(
        p_employee_id,
        p_document_name,
        p_document_file,
        p_employee_document_type_id,
        p_employee_document_type_name,
        p_last_log_by
    );

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `insertLoginAttempt`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertLoginAttempt` (IN `p_user_account_id` INT, IN `p_email` VARCHAR(255), IN `p_ip_address` VARCHAR(45), IN `p_success` TINYINT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `insertProduct`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertProduct` (IN `p_product_name` VARCHAR(100), IN `p_product_description` VARCHAR(1000), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_product_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO product (
        product_name,
        product_description,
        last_log_by
    ) 
    VALUES(
        p_product_name,
        p_product_description,
        p_last_log_by
    );

    SET v_new_product_id = LAST_INSERT_ID();

    COMMIT;

    SELECT v_new_product_id AS new_product_id;
END$$

DROP PROCEDURE IF EXISTS `insertProductCategories`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertProductCategories` (IN `p_product_id` INT, IN `p_product_name` VARCHAR(100), IN `p_product_category_id` INT, IN `p_product_category_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO product_categories (
        product_id,
        product_name,
        product_category_id,
        product_category_name,
        last_log_by
    ) 
    VALUES(
        p_product_id,
        p_product_name,
        p_product_category_id,
        p_product_category_name,
        p_last_log_by
    );

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `insertRolePermission`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertRolePermission` (IN `p_role_id` INT, IN `p_role_name` VARCHAR(100), IN `p_menu_item_id` INT, IN `p_menu_item_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `insertRoleSystemActionPermission`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertRoleSystemActionPermission` (IN `p_role_id` INT, IN `p_role_name` VARCHAR(100), IN `p_system_action_id` INT, IN `p_system_action_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `insertRoleUserAccount`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertRoleUserAccount` (IN `p_role_id` INT, IN `p_role_name` VARCHAR(100), IN `p_user_account_id` INT, IN `p_file_as` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `insertUploadSettingFileExtension`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertUploadSettingFileExtension` (IN `p_upload_setting_id` INT, IN `p_upload_setting_name` VARCHAR(100), IN `p_file_extension_id` INT, IN `p_file_extension_name` VARCHAR(100), IN `p_file_extension` VARCHAR(10), IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `insertUserAccount`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertUserAccount` (IN `p_file_as` VARCHAR(300), IN `p_email` VARCHAR(255), IN `p_password` VARCHAR(255), IN `p_phone` VARCHAR(50), IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `saveAddressType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveAddressType` (IN `p_address_type_id` INT, IN `p_address_type_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_address_type_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_address_type_id IS NULL OR NOT EXISTS (SELECT 1 FROM address_type WHERE address_type_id = p_address_type_id) THEN
        INSERT INTO address_type (
            address_type_name,
            last_log_by
        ) 
        VALUES(
            p_address_type_name,
            p_last_log_by
        );
        
        SET v_new_address_type_id = LAST_INSERT_ID();
    ELSE
        UPDATE address_type
        SET address_type_name   = p_address_type_name,
            last_log_by         = p_last_log_by
        WHERE address_type_id   = p_address_type_id;

        SET v_new_address_type_id = p_address_type_id;
    END IF;

    COMMIT;

    SELECT v_new_address_type_id AS new_address_type_id;
END$$

DROP PROCEDURE IF EXISTS `saveAppModule`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveAppModule` (IN `p_app_module_id` INT, IN `p_app_module_name` VARCHAR(100), IN `p_app_module_description` VARCHAR(500), IN `p_menu_item_id` INT, IN `p_menu_item_name` VARCHAR(100), IN `p_order_sequence` TINYINT(10), IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `saveAttribute`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveAttribute` (IN `p_attribute_id` INT, IN `p_attribute_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_attribute_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_attribute_id IS NULL OR NOT EXISTS (SELECT 1 FROM attribute WHERE attribute_id = p_attribute_id) THEN
        INSERT INTO attribute (
            attribute_name,
            last_log_by
        ) 
        VALUES(
            p_attribute_name,
            p_last_log_by
        );
        
        SET v_new_attribute_id = LAST_INSERT_ID();
    ELSE
        UPDATE attribute_value
        SET attribute_name  = p_attribute_name,
            last_log_by     = p_last_log_by
        WHERE attribute_id  = p_attribute_id;
        
        UPDATE product_variant
        SET attribute_name  = p_attribute_name,
            last_log_by     = p_last_log_by
        WHERE attribute_id  = p_attribute_id;

        UPDATE attribute
        SET attribute_name  = p_attribute_name,
            last_log_by     = p_last_log_by
        WHERE attribute_id  = p_attribute_id;

        SET v_new_attribute_id = p_attribute_id;
    END IF;

    COMMIT;

    SELECT v_new_attribute_id AS new_attribute_id;
END$$

DROP PROCEDURE IF EXISTS `saveAttributeValue`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveAttributeValue` (IN `p_attribute_value_id` INT, IN `p_attribute_value_name` VARCHAR(100), IN `p_attribute_id` INT, IN `p_attribute_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_attribute_value_id IS NULL OR NOT EXISTS (SELECT 1 FROM attribute_value WHERE attribute_value_id = p_attribute_value_id) THEN
        INSERT INTO attribute_value (
            attribute_value_name,
            attribute_id,
            attribute_name,
            last_log_by
        ) 
        VALUES(
            p_attribute_value_name,
            p_attribute_id,
            p_attribute_name,
            p_last_log_by
        );
    ELSE
        UPDATE attribute_value
        SET attribute_value_name    = p_attribute_value_name,
            attribute_id            = p_attribute_id,
            attribute_name          = p_attribute_name,
            last_log_by             = p_last_log_by
        WHERE attribute_value_id    = p_attribute_value_id;
    END IF;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `saveBank`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveBank` (IN `p_bank_id` INT, IN `p_bank_name` VARCHAR(100), IN `p_bank_identifier_code` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_bank_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_bank_id IS NULL OR NOT EXISTS (SELECT 1 FROM bank WHERE bank_id = p_bank_id) THEN
        INSERT INTO bank (
            bank_name,
            bank_identifier_code,
            last_log_by
        ) 
        VALUES(
            p_bank_name,
            p_bank_identifier_code,
            p_last_log_by
        );
        
        SET v_new_bank_id = LAST_INSERT_ID();
    ELSE        
        UPDATE bank
        SET bank_name               = p_bank_name,
            bank_identifier_code    = p_bank_identifier_code,
            last_log_by             = p_last_log_by
        WHERE bank_id               = p_bank_id;

        SET v_new_bank_id = p_bank_id;
    END IF;

    COMMIT;

    SELECT v_new_bank_id AS new_bank_id;
END$$

DROP PROCEDURE IF EXISTS `saveBankAccountType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveBankAccountType` (IN `p_bank_account_type_id` INT, IN `p_bank_account_type_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_bank_account_type_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_bank_account_type_id IS NULL OR NOT EXISTS (SELECT 1 FROM bank_account_type WHERE bank_account_type_id = p_bank_account_type_id) THEN
        INSERT INTO bank_account_type (
            bank_account_type_name,
            last_log_by
        ) 
        VALUES(
            p_bank_account_type_name,
            p_last_log_by
        );
        
        SET v_new_bank_account_type_id = LAST_INSERT_ID();
    ELSE
        UPDATE bank_account_type
        SET bank_account_type_name  = p_bank_account_type_name,
            last_log_by             = p_last_log_by
        WHERE bank_account_type_id  = p_bank_account_type_id;

        SET v_new_bank_account_type_id = p_bank_account_type_id;
    END IF;

    COMMIT;

    SELECT v_new_bank_account_type_id AS new_bank_account_type_id;
END$$

DROP PROCEDURE IF EXISTS `saveBloodType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveBloodType` (IN `p_blood_type_id` INT, IN `p_blood_type_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_blood_type_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_blood_type_id IS NULL OR NOT EXISTS (SELECT 1 FROM blood_type WHERE blood_type_id = p_blood_type_id) THEN
        INSERT INTO blood_type (
            blood_type_name,
            last_log_by
        ) 
        VALUES(
            p_blood_type_name,
            p_last_log_by
        );
        
        SET v_new_blood_type_id = LAST_INSERT_ID();
    ELSE
        UPDATE employee
        SET blood_type_name     = p_blood_type_name,
            last_log_by         = p_last_log_by
        WHERE blood_type_id     = p_blood_type_id;

        UPDATE blood_type
        SET blood_type_name     = p_blood_type_name,
            last_log_by         = p_last_log_by
        WHERE blood_type_id     = p_blood_type_id;

        SET v_new_blood_type_id = p_blood_type_id;
    END IF;

    COMMIT;

    SELECT v_new_blood_type_id AS new_blood_type_id;
END$$

DROP PROCEDURE IF EXISTS `saveCity`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveCity` (IN `p_city_id` INT, IN `p_city_name` VARCHAR(100), IN `p_state_id` INT, IN `p_state_name` VARCHAR(100), IN `p_country_id` INT, IN `p_country_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_city_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_city_id IS NULL OR NOT EXISTS (SELECT 1 FROM city WHERE city_id = p_city_id) THEN
        INSERT INTO city (
            city_name,
            state_id,
            state_name,
            country_id,
            country_name,
            last_log_by
        ) 
        VALUES(
            p_city_name,
            p_state_id,
            p_state_name,
            p_country_id,
            p_country_name,
            p_last_log_by
        );
        
        SET v_new_city_id = LAST_INSERT_ID();
    ELSE
        UPDATE work_location
        SET city_name       = p_city_name,
            last_log_by     = p_last_log_by
        WHERE city_id       = p_city_id;

        UPDATE company
        SET city_name       = p_city_name,
            last_log_by     = p_last_log_by
        WHERE city_id       = p_city_id;

        UPDATE warehouse
        SET city_name       = p_city_name,
            last_log_by     = p_last_log_by
        WHERE city_id       = p_city_id;

        UPDATE supplier
        SET city_name       = p_city_name,
            last_log_by     = p_last_log_by
        WHERE city_id       = p_city_id;

        UPDATE employee
        SET private_address_city_name       = p_city_name,
            last_log_by                     = p_last_log_by
        WHERE private_address_city_id       = p_city_id;

        UPDATE city
        SET city_name       = p_city_name,
            state_id        = p_state_id,
            state_name      = p_state_name,
            country_id      = p_country_id,
            country_name    = p_country_name,
            last_log_by     = p_last_log_by
        WHERE city_id       = p_city_id;

        SET v_new_city_id = p_city_id;
    END IF;

    COMMIT;

    SELECT v_new_city_id AS new_city_id;
END$$

DROP PROCEDURE IF EXISTS `saveCivilStatus`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveCivilStatus` (IN `p_civil_status_id` INT, IN `p_civil_status_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_civil_status_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_civil_status_id IS NULL OR NOT EXISTS (SELECT 1 FROM civil_status WHERE civil_status_id = p_civil_status_id) THEN
        INSERT INTO civil_status (
            civil_status_name,
            last_log_by
        ) 
        VALUES(
            p_civil_status_name,
            p_last_log_by
        );
        
        SET v_new_civil_status_id = LAST_INSERT_ID();
    ELSE
        UPDATE civil_status
        SET civil_status_name   = p_civil_status_name,
            last_log_by         = p_last_log_by
        WHERE civil_status_id   = p_civil_status_id;

        UPDATE employee
        SET civil_status_name   = p_civil_status_name,
            last_log_by         = p_last_log_by
        WHERE civil_status_id   = p_civil_status_id;

        SET v_new_civil_status_id = p_civil_status_id;
    END IF;

    COMMIT;

    SELECT v_new_civil_status_id AS new_civil_status_id;
END$$

DROP PROCEDURE IF EXISTS `saveCompany`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveCompany` (IN `p_company_id` INT, IN `p_company_name` VARCHAR(100), IN `p_address` VARCHAR(1000), IN `p_city_id` INT, IN `p_city_name` VARCHAR(100), IN `p_state_id` INT, IN `p_state_name` VARCHAR(100), IN `p_country_id` INT, IN `p_country_name` VARCHAR(100), IN `p_tax_id` VARCHAR(100), IN `p_currency_id` INT, IN `p_currency_name` VARCHAR(100), IN `p_phone` VARCHAR(20), IN `p_telephone` VARCHAR(20), IN `p_email` VARCHAR(255), IN `p_website` VARCHAR(255), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_company_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_company_id IS NULL OR NOT EXISTS (SELECT 1 FROM company WHERE company_id = p_company_id) THEN
        INSERT INTO company (
            company_name,
            address,
            city_id,
            city_name,
            state_id,
            state_name,
            country_id,
            country_name,
            tax_id,
            currency_id,
            currency_name,
            phone,
            telephone,
            email,
            website,
            last_log_by
        ) 
        VALUES(
            p_company_name,
            p_address,
            p_city_id,
            p_city_name,
            p_state_id,
            p_state_name,
            p_country_id,
            p_country_name,
            p_tax_id,
            p_currency_id,
            p_currency_name,
            p_phone,
            p_telephone,
            p_email,
            p_website,
            p_last_log_by
        );
        
        SET v_new_company_id = LAST_INSERT_ID();
    ELSE
        UPDATE employee
        SET company_name    = p_company_name,
            last_log_by     = p_last_log_by
        WHERE company_id    = p_company_id;
        
        UPDATE company
        SET company_name    = p_company_name,
            address         = p_address,
            city_id         = p_city_id,
            city_name       = p_city_name,
            state_id        = p_state_id,
            state_name      = p_state_name,
            country_id      = p_country_id,
            country_name    = p_country_name,
            tax_id          = p_tax_id,
            currency_id     = p_currency_id,
            currency_name   = p_currency_name,
            phone           = p_phone,
            telephone       = p_telephone,
            email           = p_email,
            website         = p_website,
            last_log_by     = p_last_log_by
        WHERE company_id    = p_company_id;

        SET v_new_company_id = p_company_id;
    END IF;

    COMMIT;

    SELECT v_new_company_id AS new_company_id;
END$$

DROP PROCEDURE IF EXISTS `saveContactInformationType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveContactInformationType` (IN `p_contact_information_type_id` INT, IN `p_contact_information_type_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_contact_information_type_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_contact_information_type_id IS NULL OR NOT EXISTS (SELECT 1 FROM contact_information_type WHERE contact_information_type_id = p_contact_information_type_id) THEN
        INSERT INTO contact_information_type (
            contact_information_type_name,
            last_log_by
        ) 
        VALUES(
            p_contact_information_type_name,
            p_last_log_by
        );
        
        SET v_new_contact_information_type_id = LAST_INSERT_ID();
    ELSE
        UPDATE contact_information_type
        SET contact_information_type_name   = p_contact_information_type_name,
            last_log_by                     = p_last_log_by
        WHERE contact_information_type_id   = p_contact_information_type_id;

        SET v_new_contact_information_type_id = p_contact_information_type_id;
    END IF;

    COMMIT;

    SELECT v_new_contact_information_type_id AS new_contact_information_type_id;
END$$

DROP PROCEDURE IF EXISTS `saveCountry`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveCountry` (IN `p_country_id` INT, IN `p_country_name` VARCHAR(100), IN `p_country_code` VARCHAR(10), IN `p_phone_code` VARCHAR(10), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_country_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_country_id IS NULL OR NOT EXISTS (SELECT 1 FROM country WHERE country_id = p_country_id) THEN
        INSERT INTO country (
            country_name,
            country_code,
            phone_code,
            last_log_by
        ) 
        VALUES(
            p_country_name,
            p_country_code,
            p_phone_code,
            p_last_log_by
        );
        
        SET v_new_country_id = LAST_INSERT_ID();
    ELSE
        UPDATE state
        SET country_name    = p_country_name,
            last_log_by     = p_last_log_by
        WHERE country_id    = p_country_id;

        UPDATE city
        SET country_name    = p_country_name,
            last_log_by     = p_last_log_by
        WHERE country_id    = p_country_id;

        UPDATE company
        SET country_name    = p_country_name,
            last_log_by     = p_last_log_by
        WHERE country_id    = p_country_id;

        UPDATE work_location
        SET country_name    = p_country_name,
            last_log_by     = p_last_log_by
        WHERE country_id    = p_country_id;

        UPDATE supplier
        SET country_name    = p_country_name,
            last_log_by     = p_last_log_by
        WHERE country_id    = p_country_id;

        UPDATE warehouse
        SET country_name    = p_country_name,
            last_log_by     = p_last_log_by
        WHERE country_id    = p_country_id;

        UPDATE employee
        SET private_address_country_name    = p_country_name,
            last_log_by                     = p_last_log_by
        WHERE private_address_country_id    = p_country_id;
        
        UPDATE country
        SET country_name    = p_country_name,
            country_code    = p_country_code,
            phone_code      = p_phone_code,
            last_log_by     = p_last_log_by
        WHERE country_id    = p_country_id;

         SET v_new_country_id = p_country_id;
    END IF;

    COMMIT;

    SELECT v_new_country_id AS new_country_id;
END$$

DROP PROCEDURE IF EXISTS `saveCredentialType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveCredentialType` (IN `p_credential_type_id` INT, IN `p_credential_type_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_credential_type_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_credential_type_id IS NULL OR NOT EXISTS (SELECT 1 FROM credential_type WHERE credential_type_id = p_credential_type_id) THEN
        INSERT INTO credential_type (
            credential_type_name,
            last_log_by
        ) 
        VALUES(
            p_credential_type_name,
            p_last_log_by
        );
        
        SET v_new_credential_type_id = LAST_INSERT_ID();
    ELSE
        UPDATE credential_type
        SET credential_type_name    = p_credential_type_name,
            last_log_by             = p_last_log_by
        WHERE credential_type_id    = p_credential_type_id;

        SET v_new_credential_type_id = p_credential_type_id;
    END IF;

    COMMIT;

    SELECT v_new_credential_type_id AS new_credential_type_id;
END$$

DROP PROCEDURE IF EXISTS `saveCurrency`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveCurrency` (IN `p_currency_id` INT, IN `p_currency_name` VARCHAR(100), IN `p_symbol` VARCHAR(5), IN `p_shorthand` VARCHAR(10), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_currency_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_currency_id IS NULL OR NOT EXISTS (SELECT 1 FROM currency WHERE currency_id = p_currency_id) THEN
        INSERT INTO currency (
            currency_name,
            symbol,
            shorthand,
            last_log_by
        ) 
        VALUES(
            p_currency_name,
            p_symbol,
            p_shorthand,
            p_last_log_by
        );
        
        SET v_new_currency_id = LAST_INSERT_ID();
    ELSE        
        UPDATE company
        SET currency_name   = p_currency_name,
            last_log_by     = p_last_log_by
        WHERE currency_id   = p_currency_id;

        UPDATE currency
        SET currency_name   = p_currency_name,
            symbol          = p_symbol,
            shorthand       = p_shorthand,
            last_log_by     = p_last_log_by
        WHERE currency_id   = p_currency_id;

        SET v_new_currency_id = p_currency_id;
    END IF;

    COMMIT;

    SELECT v_new_currency_id AS new_currency_id;
END$$

DROP PROCEDURE IF EXISTS `saveDepartment`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveDepartment` (IN `p_department_id` INT, IN `p_department_name` VARCHAR(100), IN `p_parent_department_id` INT, IN `p_parent_department_name` VARCHAR(100), IN `p_manager_id` INT, IN `p_manager_name` VARCHAR(1000), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_department_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_department_id IS NULL OR NOT EXISTS (SELECT 1 FROM department WHERE department_id = p_department_id) THEN
        INSERT INTO department (
            department_name,
            parent_department_id,
            parent_department_name,
            manager_id,
            manager_name,
            last_log_by) 
        VALUES(
            p_department_name,
            p_parent_department_id,
            p_parent_department_name,
            p_manager_id,
            p_manager_name,
            p_last_log_by
        );
        
        SET v_new_department_id = LAST_INSERT_ID();
    ELSE
        UPDATE employee
        SET department_name     = p_department_name,
            last_log_by         = p_last_log_by
        WHERE department_id     = p_department_id;

        UPDATE department
        SET parent_department_name  = p_department_name,
            last_log_by             = p_last_log_by
        WHERE parent_department_id  = p_department_id;

        UPDATE department
        SET department_name         = p_department_name,
            parent_department_id    = p_parent_department_id,
            parent_department_name  = p_parent_department_name,
            manager_id              = p_manager_id,
            manager_name            = p_manager_name,
            last_log_by             = p_last_log_by
        WHERE department_id         = p_department_id;

        SET v_new_department_id = p_department_id;
    END IF;

    COMMIT;

    SELECT v_new_department_id AS new_department_id;
END$$

DROP PROCEDURE IF EXISTS `saveDepartureReason`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveDepartureReason` (IN `p_departure_reason_id` INT, IN `p_departure_reason_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_departure_reason_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_departure_reason_id IS NULL OR NOT EXISTS (SELECT 1 FROM departure_reason WHERE departure_reason_id = p_departure_reason_id) THEN
        INSERT INTO departure_reason (
            departure_reason_name,
            last_log_by
        ) 
        VALUES(
            p_departure_reason_name,
            p_last_log_by
        );
        
        SET v_new_departure_reason_id = LAST_INSERT_ID();
    ELSE
        UPDATE employee
        SET departure_reason_name   = p_departure_reason_name,
            last_log_by             = p_last_log_by
        WHERE departure_reason_id   = p_departure_reason_id;
        
        UPDATE departure_reason
        SET departure_reason_name   = p_departure_reason_name,
            last_log_by             = p_last_log_by
        WHERE departure_reason_id   = p_departure_reason_id;

        SET v_new_departure_reason_id = p_departure_reason_id;
    END IF;

    COMMIT;

    SELECT v_new_departure_reason_id AS new_departure_reason_id;
END$$

DROP PROCEDURE IF EXISTS `saveEducationalStage`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveEducationalStage` (IN `p_educational_stage_id` INT, IN `p_educational_stage_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_educational_stage_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_educational_stage_id IS NULL OR NOT EXISTS (SELECT 1 FROM educational_stage WHERE educational_stage_id = p_educational_stage_id) THEN
        INSERT INTO educational_stage (
            educational_stage_name,
            last_log_by
        ) 
        VALUES(
            p_educational_stage_name,
            p_last_log_by
        );
        
        SET v_new_educational_stage_id = LAST_INSERT_ID();
    ELSE
        UPDATE educational_stage
        SET educational_stage_name  = p_educational_stage_name,
            last_log_by             = p_last_log_by
        WHERE educational_stage_id  = p_educational_stage_id;

        SET v_new_educational_stage_id = p_educational_stage_id;
    END IF;

    COMMIT;

    SELECT v_new_educational_stage_id AS new_educational_stage_id;
END$$

DROP PROCEDURE IF EXISTS `saveEmailNotificationTemplate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveEmailNotificationTemplate` (IN `p_notification_setting_id` INT, IN `p_email_notification_subject` VARCHAR(200), IN `p_email_notification_body` LONGTEXT, IN `p_last_log_by` INT)   BEGIN
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
            last_log_by
        ) VALUES (
            p_notification_setting_id, 
            p_email_notification_subject, 
            p_email_notification_body,
            p_last_log_by
        );

    ELSE
        UPDATE notification_setting_email_template
        SET email_notification_subject = p_email_notification_subject,
            email_notification_body    = p_email_notification_body,
            last_log_by                = p_last_log_by
        WHERE notification_setting_id = p_notification_setting_id;
    END IF;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `saveEmployeeDocumentType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveEmployeeDocumentType` (IN `p_employee_document_type_id` INT, IN `p_employee_document_type_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_employee_document_type_id INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_employee_document_type_id IS NULL OR NOT EXISTS (SELECT 1 FROM employee_document_type WHERE employee_document_type_id = p_employee_document_type_id) THEN
        INSERT INTO employee_document_type (
            employee_document_type_name,
            last_log_by
        ) 
        VALUES(
            p_employee_document_type_name,
            p_last_log_by
        );
        
        SET v_new_employee_document_type_id = LAST_INSERT_ID();
    ELSE
        UPDATE employee_document
        SET employee_document_type_name   = p_employee_document_type_name,
            last_log_by                     = p_last_log_by
        WHERE employee_document_type_id   = p_employee_document_type_id;

        UPDATE employee_document_type
        SET employee_document_type_name   = p_employee_document_type_name,
            last_log_by                     = p_last_log_by
        WHERE employee_document_type_id   = p_employee_document_type_id;

        SET v_new_employee_document_type_id = p_employee_document_type_id;
    END IF;

    COMMIT;

    SELECT v_new_employee_document_type_id AS new_employee_document_type_id;
END$$

DROP PROCEDURE IF EXISTS `saveEmployeeEducation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveEmployeeEducation` (IN `p_employee_education_id` INT, IN `p_employee_id` INT, IN `p_school` VARCHAR(100), IN `p_degree` VARCHAR(100), IN `p_field_of_study` VARCHAR(100), IN `p_start_month` VARCHAR(20), IN `p_start_year` VARCHAR(20), IN `p_end_month` VARCHAR(20), IN `p_end_year` VARCHAR(20), IN `p_activities_societies` VARCHAR(5000), IN `p_education_description` VARCHAR(5000), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM employee_education WHERE employee_education_id = p_employee_education_id) THEN
       INSERT INTO employee_education (
            employee_id,
            school,
            degree,
            field_of_study,
            start_month,
            start_year,
            end_month,
            end_year,
            activities_societies,
            education_description,
            last_log_by
        ) 
        VALUES(
            p_employee_id,
            p_school,
            p_degree,
            p_field_of_study,
            p_start_month,
            p_start_year,
            p_end_month,
            p_end_year,
            p_activities_societies,
            p_education_description,
            p_last_log_by
        );
    ELSE
        UPDATE employee_education
        SET school                      = p_school,
            degree                      = p_degree,
            field_of_study              = p_field_of_study,
            start_month                 = p_start_month,
            start_year                  = p_start_year,
            end_month                   = p_end_month,
            end_year                    = p_end_year,
            activities_societies        = p_activities_societies,
            education_description       = p_education_description,
            last_log_by                 = p_last_log_by
        WHERE employee_education_id     = p_employee_education_id;
    END IF;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `saveEmployeeEmergencyContact`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveEmployeeEmergencyContact` (IN `p_employee_emergency_contact_id` INT, IN `p_employee_id` INT, IN `p_emergency_contact_name` VARCHAR(500), IN `p_relationship_id` INT, IN `p_relationship_name` VARCHAR(100), IN `p_telephone` VARCHAR(50), IN `p_mobile` VARCHAR(50), IN `p_email` VARCHAR(200), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM employee_emergency_contact WHERE employee_emergency_contact_id = p_employee_emergency_contact_id) THEN
       INSERT INTO employee_emergency_contact (
            employee_id,
            emergency_contact_name,
            relationship_id,
            relationship_name,
            telephone,
            mobile,
            email,
            last_log_by
        ) 
        VALUES(
            p_employee_id,
            p_emergency_contact_name,
            p_relationship_id,
            p_relationship_name,
            p_telephone,
            p_mobile,
            p_email,
            p_last_log_by
        );
    ELSE
        UPDATE employee_emergency_contact
        SET emergency_contact_name              = p_emergency_contact_name,
            relationship_id                     = p_relationship_id,
            relationship_name                   = p_relationship_name,
            telephone                           = p_telephone,
            mobile                              = p_mobile,
            email                               = p_email,
            last_log_by                         = p_last_log_by
        WHERE employee_emergency_contact_id     = p_employee_emergency_contact_id;
    END IF;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `saveEmployeeExperience`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveEmployeeExperience` (IN `p_employee_experience_id` INT, IN `p_employee_id` INT, IN `p_job_title` VARCHAR(100), IN `p_employment_type_id` INT, IN `p_employment_type_name` VARCHAR(100), IN `p_company_name` VARCHAR(200), IN `p_location` VARCHAR(200), IN `p_start_month` VARCHAR(20), IN `p_start_year` VARCHAR(20), IN `p_end_month` VARCHAR(20), IN `p_end_year` VARCHAR(20), IN `p_job_description` VARCHAR(5000), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM employee_experience WHERE employee_experience_id = p_employee_experience_id) THEN
       INSERT INTO employee_experience (
            employee_id,
            job_title,
            employment_type_id,
            employment_type_name,
            company_name,
            location,
            start_month,
            start_year,
            end_month,
            end_year,
            job_description,
            last_log_by
        ) 
        VALUES(
            p_employee_id,
            p_job_title,
            p_employment_type_id,
            p_employment_type_name,
            p_company_name,
            p_location,
            p_start_month,
            p_start_year,
            p_end_month,
            p_end_year,
            p_job_description,
            p_last_log_by
        );
    ELSE
        UPDATE employee_experience
        SET job_title                   = p_job_title,
            employment_type_id          = p_employment_type_id,
            employment_type_name        = p_employment_type_name,
            company_name                = p_company_name,
            location                    = p_location,
            start_month                 = p_start_month,
            start_year                  = p_start_year,
            end_month                   = p_end_month,
            end_year                    = p_end_year,
            job_description             = p_job_description,
            last_log_by                 = p_last_log_by
        WHERE employee_experience_id    = p_employee_experience_id;
    END IF;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `saveEmployeeLanguage`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveEmployeeLanguage` (IN `p_employee_id` INT, IN `p_language_id` INT, IN `p_language_name` VARCHAR(100), IN `p_language_proficiency_id` INT, IN `p_language_proficiency_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM employee_language WHERE employee_id = p_employee_id AND language_id = p_language_id) THEN
       INSERT INTO employee_language (
            employee_id,
            language_id,
            language_name,
            language_proficiency_id,
            language_proficiency_name,
            last_log_by
        ) 
        VALUES(
            p_employee_id,
            p_language_id,
            p_language_name,
            p_language_proficiency_id,
            p_language_proficiency_name,
            p_last_log_by
        );
    ELSE
        UPDATE employee_language
        SET language_proficiency_id     = p_language_proficiency_id,
            language_proficiency_name   = p_language_proficiency_name,
            last_log_by                 = p_last_log_by
        WHERE employee_id               = p_employee_id AND language_id = p_language_id;
    END IF;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `saveEmployeeLicense`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveEmployeeLicense` (IN `p_employee_license_id` INT, IN `p_employee_id` INT, IN `p_licensed_profession` VARCHAR(200), IN `p_licensing_body` VARCHAR(200), IN `p_license_number` VARCHAR(200), IN `p_issue_date` DATE, IN `p_expiration_date` DATE, IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM employee_license WHERE employee_license_id = p_employee_license_id) THEN
       INSERT INTO employee_license (
            employee_id,
            licensed_profession,
            licensing_body,
            license_number,
            issue_date,
            expiration_date,
            last_log_by
        ) 
        VALUES(
            p_employee_id,
            p_licensed_profession,
            p_licensing_body,
            p_license_number,
            p_issue_date,
            p_expiration_date,
            p_last_log_by
        );
    ELSE
        UPDATE employee_license
        SET licensed_profession     = p_licensed_profession,
            licensing_body          = p_licensing_body,
            license_number          = p_license_number,
            issue_date              = p_issue_date,
            expiration_date         = p_expiration_date,
            last_log_by             = p_last_log_by
        WHERE employee_license_id   = p_employee_license_id;
    END IF;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `saveEmploymentLocationType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveEmploymentLocationType` (IN `p_employment_location_type_id` INT, IN `p_employment_location_type_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_employment_location_type_id INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_employment_location_type_id IS NULL OR NOT EXISTS (SELECT 1 FROM employment_location_type WHERE employment_location_type_id = p_employment_location_type_id) THEN
        INSERT INTO employment_location_type (
            employment_location_type_name,
            last_log_by
        ) 
        VALUES(
            p_employment_location_type_name,
            p_last_log_by
        );
        
        SET v_new_employment_location_type_id = LAST_INSERT_ID();
    ELSE
        UPDATE employee
        SET employment_location_type_name   = p_employment_location_type_name,
            last_log_by                     = p_last_log_by
        WHERE employment_location_type_id   = p_employment_location_type_id;

        UPDATE employment_location_type
        SET employment_location_type_name   = p_employment_location_type_name,
            last_log_by                     = p_last_log_by
        WHERE employment_location_type_id   = p_employment_location_type_id;

        SET v_new_employment_location_type_id = p_employment_location_type_id;
    END IF;

    COMMIT;

    SELECT v_new_employment_location_type_id AS new_employment_location_type_id;
END$$

DROP PROCEDURE IF EXISTS `saveEmploymentType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveEmploymentType` (IN `p_employment_type_id` INT, IN `p_employment_type_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_employment_type_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_employment_type_id IS NULL OR NOT EXISTS (SELECT 1 FROM employment_type WHERE employment_type_id = p_employment_type_id) THEN
        INSERT INTO employment_type (
            employment_type_name,
            last_log_by
        ) 
        VALUES(
            p_employment_type_name,
            p_last_log_by
        );
        
        SET v_new_employment_type_id = LAST_INSERT_ID();
    ELSE
        UPDATE employee
        SET employment_type_name    = p_employment_type_name,
            last_log_by             = p_last_log_by
        WHERE employment_type_id    = p_employment_type_id;

        UPDATE employee_experience
        SET employment_type_name    = p_employment_type_name,
            last_log_by             = p_last_log_by
        WHERE employment_type_id    = p_employment_type_id;

        UPDATE employment_type
        SET employment_type_name    = p_employment_type_name,
            last_log_by             = p_last_log_by
        WHERE employment_type_id    = p_employment_type_id;

        SET v_new_employment_type_id = p_employment_type_id;
    END IF;

    COMMIT;

    SELECT v_new_employment_type_id AS new_employment_type_id;
END$$

DROP PROCEDURE IF EXISTS `saveFileExtension`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveFileExtension` (IN `p_file_extension_id` INT, IN `p_file_extension_name` VARCHAR(100), IN `p_file_extension` VARCHAR(10), IN `p_file_type_id` INT, IN `p_file_type_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `saveFileType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveFileType` (IN `p_file_type_id` INT, IN `p_file_type_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `saveGender`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveGender` (IN `p_gender_id` INT, IN `p_gender_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_gender_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_gender_id IS NULL OR NOT EXISTS (SELECT 1 FROM gender WHERE gender_id = p_gender_id) THEN
        INSERT INTO gender (
            gender_name,
            last_log_by
        ) 
        VALUES(
            p_gender_name,
            p_last_log_by
        );
        
        SET v_new_gender_id = LAST_INSERT_ID();
    ELSE
        UPDATE employee
        SET gender_name     = p_gender_name,
            last_log_by     = p_last_log_by
        WHERE gender_id     = p_gender_id;

        UPDATE gender
        SET gender_name     = p_gender_name,
            last_log_by     = p_last_log_by
        WHERE gender_id     = p_gender_id;

        SET v_new_gender_id = p_gender_id;
    END IF;

    COMMIT;

    SELECT v_new_gender_id AS new_gender_id;
END$$

DROP PROCEDURE IF EXISTS `saveImport`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveImport` (IN `p_table_name` VARCHAR(255), IN `p_columns` TEXT, IN `p_placeholders` TEXT, IN `p_updateFields` TEXT, IN `p_values` TEXT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `saveJobPosition`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveJobPosition` (IN `p_job_position_id` INT, IN `p_job_position_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_job_position_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_job_position_id IS NULL OR NOT EXISTS (SELECT 1 FROM job_position WHERE job_position_id = p_job_position_id) THEN
        INSERT INTO job_position (
            job_position_name,
            last_log_by
        ) 
        VALUES(
            p_job_position_name,
            p_last_log_by
        );
        
        SET v_new_job_position_id = LAST_INSERT_ID();
    ELSE
        UPDATE employee
        SET job_position_name   = p_job_position_name,
            last_log_by         = p_last_log_by
        WHERE job_position_id   = p_job_position_id;

        UPDATE job_position
        SET job_position_name   = p_job_position_name,
            last_log_by         = p_last_log_by
        WHERE job_position_id   = p_job_position_id;

        SET v_new_job_position_id = p_job_position_id;
    END IF;

    COMMIT;

    SELECT v_new_job_position_id AS new_job_position_id;
END$$

DROP PROCEDURE IF EXISTS `saveLanguage`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveLanguage` (IN `p_language_id` INT, IN `p_language_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_language_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_language_id IS NULL OR NOT EXISTS (SELECT 1 FROM language WHERE language_id = p_language_id) THEN
        INSERT INTO language (
            language_name,
            last_log_by
        ) 
        VALUES(
            p_language_name,
            p_last_log_by
        );
        
        SET v_new_language_id = LAST_INSERT_ID();
    ELSE
        UPDATE employee_language
        SET language_name   = p_language_name,
            last_log_by     = p_last_log_by
        WHERE language_id   = p_language_id;

        UPDATE language
        SET language_name   = p_language_name,
            last_log_by     = p_last_log_by
        WHERE language_id   = p_language_id;

        SET v_new_language_id = p_language_id;
    END IF;

    COMMIT;

    SELECT v_new_language_id AS new_language_id;
END$$

DROP PROCEDURE IF EXISTS `saveLanguageProficiency`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveLanguageProficiency` (IN `p_language_proficiency_id` INT, IN `p_language_proficiency_name` VARCHAR(100), IN `p_language_proficiency_description` VARCHAR(200), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_language_proficiency_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_language_proficiency_id IS NULL OR NOT EXISTS (SELECT 1 FROM language_proficiency WHERE language_proficiency_id = p_language_proficiency_id) THEN
        INSERT INTO language_proficiency (
            language_proficiency_name,
            language_proficiency_description,
            last_log_by
        ) 
        VALUES(
            p_language_proficiency_name,
            p_language_proficiency_description,
            p_last_log_by
        );
        
        SET v_new_language_proficiency_id = LAST_INSERT_ID();
    ELSE        
        UPDATE employee_language
        SET language_proficiency_name           = p_language_proficiency_name,
            last_log_by                         = p_last_log_by
        WHERE language_proficiency_id           = p_language_proficiency_id;

        UPDATE language_proficiency
        SET language_proficiency_name           = p_language_proficiency_name,
            language_proficiency_description    = p_language_proficiency_description,
            last_log_by                         = p_last_log_by
        WHERE language_proficiency_id           = p_language_proficiency_id;

        SET v_new_language_proficiency_id = p_language_proficiency_id;
    END IF;

    COMMIT;

    SELECT v_new_language_proficiency_id AS new_language_proficiency_id;
END$$

DROP PROCEDURE IF EXISTS `saveMenuItem`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveMenuItem` (IN `p_menu_item_id` INT, IN `p_menu_item_name` VARCHAR(100), IN `p_menu_item_url` VARCHAR(50), IN `p_menu_item_icon` VARCHAR(50), IN `p_app_module_id` INT, IN `p_app_module_name` VARCHAR(100), IN `p_parent_id` INT, IN `p_parent_name` VARCHAR(100), IN `p_table_name` VARCHAR(100), IN `p_order_sequence` TINYINT(10), IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `saveNationality`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveNationality` (IN `p_nationality_id` INT, IN `p_nationality_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_nationality_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_nationality_id IS NULL OR NOT EXISTS (SELECT 1 FROM nationality WHERE nationality_id = p_nationality_id) THEN
        INSERT INTO nationality (
            nationality_name,
            last_log_by
        ) 
        VALUES(
            p_nationality_name,
            p_last_log_by
        );
        
        SET v_new_nationality_id = LAST_INSERT_ID();
    ELSE        
        UPDATE employee
        SET nationality_name    = p_nationality_name,
            last_log_by         = p_last_log_by
        WHERE nationality_id    = p_nationality_id;

        UPDATE nationality
        SET nationality_name    = p_nationality_name,
            last_log_by         = p_last_log_by
        WHERE nationality_id    = p_nationality_id;

        SET v_new_nationality_id = p_nationality_id;
    END IF;

    COMMIT;

    SELECT v_new_nationality_id AS new_nationality_id;
END$$

DROP PROCEDURE IF EXISTS `saveNotificationSetting`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveNotificationSetting` (IN `p_notification_setting_id` INT, IN `p_notification_setting_name` VARCHAR(100), IN `p_notification_setting_description` VARCHAR(200), IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `saveOTP`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveOTP` (IN `p_user_account_id` INT, IN `p_otp` VARCHAR(255), IN `p_otp_expiry_date` DATETIME)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `saveProductCategory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveProductCategory` (IN `p_product_category_id` INT, IN `p_product_category_name` VARCHAR(100), IN `p_parent_category_id` INT, IN `p_parent_category_name` VARCHAR(100), IN `p_costing_method` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_product_category_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_product_category_id IS NULL OR NOT EXISTS (SELECT 1 FROM product_category WHERE product_category_id = p_product_category_id) THEN
        INSERT INTO product_category (
            product_category_name,
            parent_category_id,
            parent_category_name,
            costing_method,
            last_log_by
        ) 
        VALUES(
            p_product_category_name,
            p_parent_category_id,
            p_parent_category_name,
            p_costing_method,
            p_last_log_by
        );
        
        SET v_new_product_category_id = LAST_INSERT_ID();
    ELSE
        UPDATE product
        SET product_category_name   = p_product_category_name,
            last_log_by             = p_last_log_by
        WHERE product_category_id   = p_product_category_id;

        UPDATE product_category
        SET parent_category_name    = p_product_category_name,
            last_log_by             = p_last_log_by
        WHERE parent_category_id    = p_product_category_id;

        UPDATE product_category
        SET product_category_name   = p_product_category_name,
            parent_category_id      = p_parent_category_id,
            parent_category_name    = p_parent_category_name,
            costing_method          = p_costing_method,
            last_log_by             = p_last_log_by
        WHERE product_category_id   = p_product_category_id;

        SET v_new_product_category_id = p_product_category_id;
    END IF;

    COMMIT;

    SELECT v_new_product_category_id AS new_product_category_id;
END$$

DROP PROCEDURE IF EXISTS `saveRelationship`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveRelationship` (IN `p_relationship_id` INT, IN `p_relationship_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_relationship_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_relationship_id IS NULL OR NOT EXISTS (SELECT 1 FROM relationship WHERE relationship_id = p_relationship_id) THEN
        INSERT INTO relationship (
            relationship_name,
            last_log_by
        ) 
        VALUES(
            p_relationship_name,
            p_last_log_by
        );
        
        SET v_new_relationship_id = LAST_INSERT_ID();
    ELSE
        UPDATE employee_emergency_contact
        SET relationship_name   = p_relationship_name,
            last_log_by         = p_last_log_by
        WHERE relationship_id   = p_relationship_id;

        UPDATE relationship
        SET relationship_name   = p_relationship_name,
            last_log_by         = p_last_log_by
        WHERE relationship_id   = p_relationship_id;

        SET v_new_relationship_id = p_relationship_id;
    END IF;

    COMMIT;

    SELECT v_new_relationship_id AS new_relationship_id;
END$$

DROP PROCEDURE IF EXISTS `saveReligion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveReligion` (IN `p_religion_id` INT, IN `p_religion_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_religion_id INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_religion_id IS NULL OR NOT EXISTS (SELECT 1 FROM religion WHERE religion_id = p_religion_id) THEN
        INSERT INTO religion (
            religion_name,
            last_log_by
        ) 
        VALUES(
            p_religion_name,
            p_last_log_by
        );
        
        SET v_new_religion_id = LAST_INSERT_ID();
    ELSE
        UPDATE employee
        SET religion_name   = p_religion_name,
            last_log_by     = p_last_log_by
        WHERE religion_id   = p_religion_id;

        UPDATE religion
        SET religion_name   = p_religion_name,
            last_log_by     = p_last_log_by
        WHERE religion_id   = p_religion_id;

        SET v_new_religion_id = p_religion_id;
    END IF;

    COMMIT;

    SELECT v_new_religion_id AS new_religion_id;
END$$

DROP PROCEDURE IF EXISTS `saveResetToken`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveResetToken` (IN `p_user_account_id` INT, IN `p_reset_token` VARCHAR(255), IN `p_reset_token_expiry_date` DATETIME)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `saveRole`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveRole` (IN `p_role_id` INT, IN `p_role_name` VARCHAR(100), IN `p_role_description` VARCHAR(200), IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `saveSession`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveSession` (IN `p_user_account_id` INT, IN `p_session_token` VARCHAR(255))   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `saveSMSNotificationTemplate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveSMSNotificationTemplate` (IN `p_notification_setting_id` INT, IN `p_sms_notification_message` VARCHAR(500), IN `p_last_log_by` INT)   BEGIN
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
        SET sms_notification_message    = p_sms_notification_message,
            last_log_by                 = p_last_log_by
        WHERE notification_setting_id   = p_notification_setting_id;
    END IF;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `saveState`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveState` (IN `p_state_id` INT, IN `p_state_name` VARCHAR(100), IN `p_country_id` INT, IN `p_country_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_state_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_state_id IS NULL OR NOT EXISTS (SELECT 1 FROM state WHERE state_id = p_state_id) THEN
        INSERT INTO state (
            state_name,
            country_id,
            country_name,
            last_log_by
        ) 
        VALUES(
            p_state_name,
            p_country_id,
            p_country_name,
            p_last_log_by
        );
        
       SET v_new_state_id = LAST_INSERT_ID();
    ELSE
        UPDATE city
        SET state_name      = p_state_name,
            last_log_by     = p_last_log_by
        WHERE state_id      = p_state_id;

        UPDATE company
        SET state_name      = p_state_name,
            last_log_by     = p_last_log_by
        WHERE state_id      = p_state_id;

        UPDATE work_location
        SET state_name      = p_state_name,
            last_log_by     = p_last_log_by
        WHERE state_id      = p_state_id;

        UPDATE supplier
        SET state_name      = p_state_name,
            last_log_by     = p_last_log_by
        WHERE state_id      = p_state_id;

        UPDATE warehouse
        SET state_name      = p_state_name,
            last_log_by     = p_last_log_by
        WHERE state_id      = p_state_id;

        UPDATE employee
        SET private_address_state_name  = p_state_name,
            last_log_by                 = p_last_log_by
        WHERE private_address_state_id  = p_state_id;
        
        UPDATE state
        SET state_name      = p_state_name,
            country_id      = p_country_id,
            country_name    = p_country_name,
            last_log_by     = p_last_log_by
        WHERE state_id      = p_state_id;

        SET v_new_state_id = p_state_id;
    END IF;

    COMMIT;

    SELECT v_new_state_id AS new_state_id;
END$$

DROP PROCEDURE IF EXISTS `saveSupplier`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveSupplier` (IN `p_supplier_id` INT, IN `p_supplier_name` VARCHAR(200), IN `p_contact_person` VARCHAR(500), IN `p_phone` VARCHAR(20), IN `p_telephone` VARCHAR(20), IN `p_email` VARCHAR(255), IN `p_address` VARCHAR(1000), IN `p_city_id` INT, IN `p_city_name` VARCHAR(100), IN `p_state_id` INT, IN `p_state_name` VARCHAR(100), IN `p_country_id` INT, IN `p_country_name` VARCHAR(100), IN `p_tax_id_number` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_supplier_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_supplier_id IS NULL OR NOT EXISTS (SELECT 1 FROM supplier WHERE supplier_id = p_supplier_id) THEN
        INSERT INTO supplier (
            supplier_name,
            contact_person,
            phone,
            telephone,
            email,
            address,
            city_id,
            city_name,
            state_id,
            state_name,
            country_id,
            country_name,
            tax_id_number,
            last_log_by
        ) 
        VALUES(
            p_supplier_name,
            p_contact_person,
            p_phone,
            p_telephone,
            p_email,
            p_address,
            p_city_id,
            p_city_name,
            p_state_id,
            p_state_name,
            p_country_id,
            p_country_name,
            p_tax_id_number,
            p_last_log_by
        ); 
        
        SET v_new_supplier_id = LAST_INSERT_ID();
    ELSE        
        UPDATE supplier
        SET supplier_name   = p_supplier_name,
            contact_person  = p_contact_person,
            phone           = p_phone,
            telephone       = p_telephone,
            email           = p_email,
            address         = p_address,
            city_id         = p_city_id,
            city_name       = p_city_name,
            state_id        = p_state_id,
            state_name      = p_state_name,
            country_id      = p_country_id,
            country_name    = p_country_name,
            tax_id_number   = p_tax_id_number,
            last_log_by     = p_last_log_by
        WHERE supplier_id   = p_supplier_id;

        SET v_new_supplier_id = p_supplier_id;
    END IF;

    COMMIT;

    SELECT v_new_supplier_id AS new_supplier_id;
END$$

DROP PROCEDURE IF EXISTS `saveSystemAction`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveSystemAction` (IN `p_system_action_id` INT, IN `p_system_action_name` VARCHAR(100), IN `p_system_action_description` VARCHAR(200), IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `saveSystemNotificationTemplate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveSystemNotificationTemplate` (IN `p_notification_setting_id` INT, IN `p_system_notification_title` VARCHAR(200), IN `p_system_notification_message` VARCHAR(200), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_notification_setting_id IS NULL OR NOT EXISTS (SELECT 1 FROM notification_setting_system_template WHERE notification_setting_id = p_notification_setting_id) THEN
        
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
        SET system_notification_title       = p_system_notification_title,
            system_notification_message     = p_system_notification_message,
            last_log_by                     = p_last_log_by
        WHERE notification_setting_id       = p_notification_setting_id;
    END IF;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `saveTax`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveTax` (IN `p_tax_id` INT, IN `p_tax_name` VARCHAR(200), IN `p_tax_rate` DECIMAL(5,2), IN `p_tax_type` VARCHAR(50), IN `p_tax_computation` VARCHAR(50), IN `p_tax_scope` VARCHAR(50), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_tax_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_tax_id IS NULL OR NOT EXISTS (SELECT 1 FROM tax WHERE tax_id = p_tax_id) THEN
        INSERT INTO tax (
            tax_name,
            tax_rate,
            tax_type,
            tax_computation,
            tax_scope,
            last_log_by
        ) 
        VALUES(
            p_tax_name,
            p_tax_rate,
            p_tax_type,
            p_tax_computation,
            p_tax_scope,
            p_last_log_by
        ); 
        
        SET v_new_tax_id = LAST_INSERT_ID();
    ELSE        
        UPDATE tax
        SET tax_name            = p_tax_name,
            tax_rate            = p_tax_rate,
            tax_type            = p_tax_type,
            tax_computation     = p_tax_computation,
            tax_scope           = p_tax_scope,
            last_log_by         = p_last_log_by
        WHERE tax_id            = p_tax_id;

        SET v_new_tax_id = p_tax_id;
    END IF;

    COMMIT;

    SELECT v_new_tax_id AS new_tax_id;
END$$

DROP PROCEDURE IF EXISTS `saveUploadSetting`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveUploadSetting` (IN `p_upload_setting_id` INT, IN `p_upload_setting_name` VARCHAR(100), IN `p_upload_setting_description` VARCHAR(200), IN `p_max_file_size` DOUBLE, IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `saveWarehouse`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveWarehouse` (IN `p_warehouse_id` INT, IN `p_warehouse_name` VARCHAR(200), IN `p_short_name` VARCHAR(200), IN `p_contact_person` VARCHAR(500), IN `p_phone` VARCHAR(20), IN `p_telephone` VARCHAR(20), IN `p_email` VARCHAR(255), IN `p_address` VARCHAR(1000), IN `p_city_id` INT, IN `p_city_name` VARCHAR(100), IN `p_state_id` INT, IN `p_state_name` VARCHAR(100), IN `p_country_id` INT, IN `p_country_name` VARCHAR(100), IN `p_warehouse_type_id` INT, IN `p_warehouse_type_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_warehouse_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_warehouse_id IS NULL OR NOT EXISTS (SELECT 1 FROM warehouse WHERE warehouse_id = p_warehouse_id) THEN
        INSERT INTO warehouse (
            warehouse_name,
            short_name,
            contact_person,
            phone,
            telephone,
            email,
            address,
            city_id,
            city_name,
            state_id,
            state_name,
            country_id,
            country_name,
            warehouse_type_id,
            warehouse_type_name,
            last_log_by
        ) 
        VALUES(
            p_warehouse_name,
            p_short_name,
            p_contact_person,
            p_phone,
            p_telephone,
            p_email,
            p_address,
            p_city_id,
            p_city_name,
            p_state_id,
            p_state_name,
            p_country_id,
            p_country_name,
            p_warehouse_type_id,
            p_warehouse_type_name,
            p_last_log_by
        ); 
        
        SET v_new_warehouse_id = LAST_INSERT_ID();
    ELSE        
        UPDATE warehouse
        SET warehouse_name          = p_warehouse_name,
            short_name              = p_short_name,
            contact_person          = p_contact_person,
            phone                   = p_phone,
            telephone               = p_telephone,
            email                   = p_email,
            address                 = p_address,
            city_id                 = p_city_id,
            city_name               = p_city_name,
            state_id                = p_state_id,
            state_name              = p_state_name,
            country_id              = p_country_id,
            country_name            = p_country_name,
            warehouse_type_id       = p_warehouse_type_id,
            warehouse_type_name     = p_warehouse_type_name,
            last_log_by             = p_last_log_by
        WHERE warehouse_id          = p_warehouse_id;

        SET v_new_warehouse_id = p_warehouse_id;
    END IF;

    COMMIT;

    SELECT v_new_warehouse_id AS new_warehouse_id;
END$$

DROP PROCEDURE IF EXISTS `saveWarehouseType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveWarehouseType` (IN `p_warehouse_type_id` INT, IN `p_warehouse_type_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_warehouse_type_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_warehouse_type_id IS NULL OR NOT EXISTS (SELECT 1 FROM warehouse_type WHERE warehouse_type_id = p_warehouse_type_id) THEN
        INSERT INTO warehouse_type (
            warehouse_type_name,
            last_log_by
        ) 
        VALUES(
            p_warehouse_type_name,
            p_last_log_by
        );
        
        SET v_new_warehouse_type_id = LAST_INSERT_ID();
    ELSE
        UPDATE warehouse
        SET warehouse_type_name   = p_warehouse_type_name,
            last_log_by         = p_last_log_by
        WHERE warehouse_type_id   = p_warehouse_type_id;

        UPDATE warehouse_type
        SET warehouse_type_name   = p_warehouse_type_name,
            last_log_by         = p_last_log_by
        WHERE warehouse_type_id   = p_warehouse_type_id;

        SET v_new_warehouse_type_id = p_warehouse_type_id;
    END IF;

    COMMIT;

    SELECT v_new_warehouse_type_id AS new_warehouse_type_id;
END$$

DROP PROCEDURE IF EXISTS `saveWorkLocation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveWorkLocation` (IN `p_work_location_id` INT, IN `p_work_location_name` VARCHAR(100), IN `p_address` VARCHAR(1000), IN `p_city_id` INT, IN `p_city_name` VARCHAR(100), IN `p_state_id` INT, IN `p_state_name` VARCHAR(100), IN `p_country_id` INT, IN `p_country_name` VARCHAR(100), IN `p_phone` VARCHAR(20), IN `p_telephone` VARCHAR(20), IN `p_email` VARCHAR(255), IN `p_last_log_by` INT)   BEGIN
    DECLARE v_new_work_location_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF p_work_location_id IS NULL OR NOT EXISTS (SELECT 1 FROM work_location WHERE work_location_id = p_work_location_id) THEN
        INSERT INTO work_location (
            work_location_name,
            address,
            city_id,
            city_name,
            state_id,
            state_name,
            country_id,
            country_name,
            phone,
            telephone,
            email,
            last_log_by
        ) 
        VALUES(
            p_work_location_name,
            p_address,
            p_city_id,
            p_city_name,
            p_state_id,
            p_state_name,
            p_country_id,
            p_country_name,
            p_phone,
            p_telephone,
            p_email,
            p_last_log_by
        );
        
        SET v_new_work_location_id = LAST_INSERT_ID();
    ELSE
        UPDATE employee
        SET work_location_name  = p_work_location_name,
            last_log_by         = p_last_log_by
        WHERE work_location_id  = p_work_location_id;

        UPDATE work_location
        SET work_location_name  = p_work_location_name,
            address             = p_address,
            city_id             = p_city_id,
            city_name           = p_city_name,
            state_id            = p_state_id,
            state_name          = p_state_name,
            country_id          = p_country_id,
            country_name        = p_country_name,
            phone               = p_phone,
            telephone           = p_telephone,
            email               = p_email,
            last_log_by         = p_last_log_by
        WHERE work_location_id  = p_work_location_id;

        SET v_new_work_location_id = p_work_location_id;
    END IF;

    COMMIT;

    SELECT v_new_work_location_id AS new_work_location_id;
END$$

DROP PROCEDURE IF EXISTS `updateAppLogo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAppLogo` (IN `p_app_module_id` INT, IN `p_app_logo` VARCHAR(500), IN `p_last_log_by` INT)   BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE app_module
    SET app_logo            = p_app_logo,
        last_log_by         = p_last_log_by
    WHERE app_module_id     = p_app_module_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateCompanyLogo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCompanyLogo` (IN `p_company_id` INT, IN `p_company_logo` VARCHAR(500), IN `p_last_log_by` INT)   BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE company
    SET company_logo    = p_company_logo,
        last_log_by     = p_last_log_by
    WHERE company_id    = p_company_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeArchive`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeArchive` (IN `p_employee_id` INT, IN `p_departure_reason_id` INT, IN `p_departure_reason_name` VARCHAR(500), IN `p_detailed_departure_reason` VARCHAR(5000), IN `p_departure_date` DATE, IN `p_last_log_by` INT)   BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET employment_status           = 'Archived',
        departure_reason_id         = p_departure_reason_id,
        departure_reason_name       = p_departure_reason_name,
        detailed_departure_reason   = p_detailed_departure_reason,
        departure_date              = p_departure_date,
        last_log_by                 = p_last_log_by
    WHERE employee_id               = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeBadgeId`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeBadgeId` (IN `p_employee_id` INT, IN `p_badge_id` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET badge_id        = p_badge_id,
        last_log_by     = p_last_log_by
    WHERE employee_id   = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeBirthday`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeBirthday` (IN `p_employee_id` INT, IN `p_birthday` DATE, IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET birthday        = p_birthday,
        last_log_by     = p_last_log_by
    WHERE employee_id   = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeCompany`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeCompany` (IN `p_employee_id` INT, IN `p_company_id` INT, IN `p_company_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET company_id      = p_company_id,
        company_name    = p_company_name,
        last_log_by     = p_last_log_by
    WHERE employee_id   = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeDepartment`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeDepartment` (IN `p_employee_id` INT, IN `p_department_id` INT, IN `p_department_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET department_id       = p_department_id,
        department_name     = p_department_name,
        last_log_by         = p_last_log_by
    WHERE employee_id       = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeEmploymentLocationType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeEmploymentLocationType` (IN `p_employee_id` INT, IN `p_employment_location_type_id` INT, IN `p_employment_location_type_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET employment_location_type_id     = p_employment_location_type_id,
        employment_location_type_name   = p_employment_location_type_name,
        last_log_by                     = p_last_log_by
    WHERE employee_id                   = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeEmploymentType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeEmploymentType` (IN `p_employee_id` INT, IN `p_employment_type_id` INT, IN `p_employment_type_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET employment_type_id      = p_employment_type_id,
        employment_type_name    = p_employment_type_name,
        last_log_by             = p_last_log_by
    WHERE employee_id           = p_employee_id;

     COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeGender`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeGender` (IN `p_employee_id` INT, IN `p_gender_id` INT, IN `p_gender_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET gender_id       = p_gender_id,
        gender_name     = p_gender_name,
        last_log_by     = p_last_log_by
    WHERE employee_id   = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeImage`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeImage` (IN `p_employee_id` INT, IN `p_employee_image` VARCHAR(500), IN `p_last_log_by` INT)   BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET employee_image  = p_employee_image,
        last_log_by     = p_last_log_by
    WHERE employee_id   = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeJobPosition`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeJobPosition` (IN `p_employee_id` INT, IN `p_job_position_id` INT, IN `p_job_position_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET job_position_id     = p_job_position_id,
        job_position_name   = p_job_position_name,
        last_log_by         = p_last_log_by
    WHERE employee_id       = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeManager`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeManager` (IN `p_employee_id` INT, IN `p_manager_id` INT, IN `p_manager_name` VARCHAR(1000), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET manager_id      = p_manager_id,
        manager_name    = p_manager_name,
        last_log_by     = p_last_log_by
    WHERE employee_id   = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeNationality`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeNationality` (IN `p_employee_id` INT, IN `p_nationality_id` INT, IN `p_nationality_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET nationality_id      = p_nationality_id,
        nationality_name    = p_nationality_name,
        last_log_by         = p_last_log_by
    WHERE employee_id       = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeOnBoardDate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeOnBoardDate` (IN `p_employee_id` INT, IN `p_on_board_date` DATE, IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET on_board_date   = p_on_board_date,
        last_log_by     = p_last_log_by
    WHERE employee_id   = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeePersonalDetails`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeePersonalDetails` (IN `p_employee_id` INT, IN `p_full_name` VARCHAR(1000), IN `p_first_name` VARCHAR(300), IN `p_middle_name` VARCHAR(300), IN `p_last_name` VARCHAR(300), IN `p_suffix` VARCHAR(10), IN `p_nickname` VARCHAR(100), IN `p_private_address` VARCHAR(500), IN `p_private_address_city_id` INT, IN `p_private_address_city_name` VARCHAR(100), IN `p_private_address_state_id` INT, IN `p_private_address_state_name` VARCHAR(100), IN `p_private_address_country_id` INT, IN `p_private_address_country_name` VARCHAR(100), IN `p_civil_status_id` INT, IN `p_civil_status_name` VARCHAR(100), IN `p_dependents` INT, IN `p_religion_id` INT, IN `p_religion_name` VARCHAR(100), IN `p_blood_type_id` INT, IN `p_blood_type_name` VARCHAR(100), IN `p_home_work_distance` DOUBLE, IN `p_height` FLOAT, IN `p_weight` FLOAT, IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE department
    SET manager_name    = p_full_name,
        last_log_by     = p_last_log_by
    WHERE manager_id    = p_employee_id;

    UPDATE employee
    SET manager_name    = p_full_name,
        last_log_by     = p_last_log_by
    WHERE manager_id    = p_employee_id;

    UPDATE employee
    SET time_off_approver_name  = p_full_name,
        last_log_by             = p_last_log_by
    WHERE time_off_approver_id  = p_employee_id;

    UPDATE employee
    SET full_name                       = p_full_name,
        first_name                      = p_first_name,
        middle_name                     = p_middle_name,
        last_name                       = p_last_name,
        suffix                          = p_suffix,
        nickname                        = p_nickname,
        private_address                 = p_private_address,
        private_address_city_id         = p_private_address_city_id,
        private_address_city_name       = p_private_address_city_name,
        private_address_state_id        = p_private_address_state_id,
        private_address_state_name      = p_private_address_state_name,
        private_address_country_id      = p_private_address_country_id,
        private_address_country_name    = p_private_address_country_name,
        civil_status_id                 = p_civil_status_id,
        civil_status_name               = p_civil_status_name,
        dependents                      = p_dependents,
        religion_id                     = p_religion_id,
        religion_name                   = p_religion_name,
        blood_type_id                   = p_blood_type_id,
        blood_type_name                 = p_blood_type_name,
        home_work_distance              = p_home_work_distance,
        height                          = p_height,
        weight                          = p_weight,
        last_log_by                     = p_last_log_by
    WHERE employee_id                   = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeePINCode`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeePINCode` (IN `p_employee_id` INT, IN `p_pin_code` VARCHAR(255), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET pin_code        = p_pin_code,
        last_log_by     = p_last_log_by
    WHERE employee_id   = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeePlaceOfBirth`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeePlaceOfBirth` (IN `p_employee_id` INT, IN `p_place_of_birth` VARCHAR(1000), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET place_of_birth  = p_place_of_birth,
        last_log_by     = p_last_log_by
    WHERE employee_id   = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeePrivateEmail`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeePrivateEmail` (IN `p_employee_id` INT, IN `p_private_email` VARCHAR(255), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET private_email   = p_private_email,
        last_log_by     = p_last_log_by
    WHERE employee_id   = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeePrivatePhone`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeePrivatePhone` (IN `p_employee_id` INT, IN `p_private_phone` VARCHAR(20), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET private_phone   = p_private_phone,
        last_log_by     = p_last_log_by
    WHERE employee_id   = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeePrivateTelephone`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeePrivateTelephone` (IN `p_employee_id` INT, IN `p_private_telephone` VARCHAR(20), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET private_telephone   = p_private_telephone,
        last_log_by         = p_last_log_by
    WHERE employee_id       = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeTimeOffApprover`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeTimeOffApprover` (IN `p_employee_id` INT, IN `p_time_off_approver_id` INT, IN `p_time_off_approver_name` VARCHAR(1000), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET time_off_approver_id    = p_time_off_approver_id,
        time_off_approver_name  = p_time_off_approver_name,
        last_log_by             = p_last_log_by
    WHERE employee_id           = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeUnarchive`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeUnarchive` (IN `p_employee_id` INT, IN `p_last_log_by` INT)   BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET employment_status           = 'Active',
        last_log_by                 = p_last_log_by
    WHERE employee_id               = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeWorkEmail`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeWorkEmail` (IN `p_employee_id` INT, IN `p_work_email` VARCHAR(255), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET work_email      = p_work_email,
        last_log_by     = p_last_log_by
    WHERE employee_id   = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeWorkLocation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeWorkLocation` (IN `p_employee_id` INT, IN `p_work_location_id` INT, IN `p_work_location_name` VARCHAR(100), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET work_location_id    = p_work_location_id,
        work_location_name  = p_work_location_name,
        last_log_by         = p_last_log_by
    WHERE employee_id       = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeWorkPhone`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeWorkPhone` (IN `p_employee_id` INT, IN `p_work_phone` VARCHAR(20), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET work_phone      = p_work_phone,
        last_log_by     = p_last_log_by
    WHERE employee_id   = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateEmployeeWorkTelephone`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeeWorkTelephone` (IN `p_employee_id` INT, IN `p_work_telephone` VARCHAR(20), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employee
    SET work_telephone  = p_work_telephone,
        last_log_by     = p_last_log_by
    WHERE employee_id   = p_employee_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateFailedOTPAttempts`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateFailedOTPAttempts` (IN `p_user_account_id` INT, IN `p_failed_otp_attempts` TINYINT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE otp
    SET failed_otp_attempts     = p_failed_otp_attempts
    WHERE user_account_id       = p_user_account_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateNotificationChannel`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateNotificationChannel` (IN `p_notification_setting_id` INT, IN `p_notification_channel` VARCHAR(10), IN `p_notification_channel_value` TINYINT, IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `updateOTPAsExpired`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateOTPAsExpired` (IN `p_user_account_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE otp
    SET otp_expiry_date     = NOW()
    WHERE user_account_id   = p_user_account_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateProductGeneral`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateProductGeneral` (IN `p_product_id` INT, IN `p_product_name` VARCHAR(100), IN `p_product_description` VARCHAR(1000), IN `p_last_log_by` INT)   BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE product
    SET product_name  = p_product_name,
        product_description  = p_product_description,
        last_log_by     = p_last_log_by
    WHERE product_id   = p_product_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateProductImage`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateProductImage` (IN `p_product_id` INT, IN `p_product_image` VARCHAR(500), IN `p_last_log_by` INT)   BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE product
    SET product_image  = p_product_image,
        last_log_by     = p_last_log_by
    WHERE product_id   = p_product_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateProductInventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateProductInventory` (IN `p_product_id` INT, IN `p_sku` VARCHAR(200), IN `p_barcode` VARCHAR(200), IN `p_product_type` VARCHAR(50), IN `p_quantity_on_hand` INT, IN `p_last_log_by` INT)   BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE product
    SET sku                 = p_sku,
        barcode             = p_barcode,
        product_type        = p_product_type,
        quantity_on_hand    = p_quantity_on_hand,
        last_log_by         = p_last_log_by
    WHERE product_id        = p_product_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateProductSettings`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateProductSettings` (IN `p_product_id` INT, IN `p_value` VARCHAR(500), IN `p_update_type` VARCHAR(50), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    CASE p_update_type
        WHEN 'is sellable' THEN
            UPDATE product
            SET is_sellable     = p_value,
                last_log_by     = p_last_log_by
            WHERE product_id    = p_product_id;

        WHEN 'is purchasable' THEN
            UPDATE product
            SET is_purchasable  = p_value,
                last_log_by     = p_last_log_by
            WHERE product_id    = p_product_id;

        ELSE
            UPDATE product
            SET show_on_pos     = p_value,
                last_log_by     = p_last_log_by
            WHERE product_id    = p_product_id;
    END CASE;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateProductShipping`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateProductShipping` (IN `p_product_id` INT, IN `p_weight` DECIMAL(5,2), IN `p_width` DECIMAL(5,2), IN `p_height` DECIMAL(5,2), IN `p_length` DECIMAL(5,2), IN `p_last_log_by` INT)   BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE product
    SET weight          = p_weight,
        width           = p_width,
        height          = p_height,
        length          = p_length,
        last_log_by     = p_last_log_by
    WHERE product_id    = p_product_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateResetTokenAsExpired`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateResetTokenAsExpired` (IN `p_user_account_id` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE reset_token
    SET reset_token_expiry_date     = NOW()
    WHERE user_account_id           = p_user_account_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateRolePermission`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateRolePermission` (IN `p_role_permission_id` INT, IN `p_access_type` VARCHAR(10), IN `p_access` TINYINT(1), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE role_permission
    SET 
        read_access             = CASE WHEN p_access_type = 'read'      THEN p_access ELSE read_access END,
        write_access            = CASE WHEN p_access_type = 'write'     THEN p_access ELSE write_access END,
        create_access           = CASE WHEN p_access_type = 'create'    THEN p_access ELSE create_access END,
        delete_access           = CASE WHEN p_access_type = 'delete'    THEN p_access ELSE delete_access END,
        import_access           = CASE WHEN p_access_type = 'import'    THEN p_access ELSE import_access END,
        export_access           = CASE WHEN p_access_type = 'export'    THEN p_access ELSE export_access END,
        log_notes_access        = CASE WHEN p_access_type = 'log notes' THEN p_access ELSE log_notes_access END,
        last_log_by             = p_last_log_by
    WHERE role_permission_id    = p_role_permission_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateRoleSystemActionPermission`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateRoleSystemActionPermission` (IN `p_role_system_action_permission_id` INT, IN `p_system_action_access` TINYINT(1), IN `p_last_log_by` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `updateSupplierArchive`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateSupplierArchive` (IN `p_supplier_id` INT, IN `p_last_log_by` INT)   BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE supplier
    SET supplier_status     = 'Archived',
        last_log_by         = p_last_log_by
    WHERE supplier_id       = p_supplier_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateSupplierUnarchive`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateSupplierUnarchive` (IN `p_supplier_id` INT, IN `p_last_log_by` INT)   BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE supplier
    SET supplier_status     = 'Active',
        last_log_by         = p_last_log_by
    WHERE supplier_id       = p_supplier_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateTaxArchive`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateTaxArchive` (IN `p_tax_id` INT, IN `p_last_log_by` INT)   BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tax
    SET tax_status      = 'Archived',
        last_log_by     = p_last_log_by
    WHERE tax_id        = p_tax_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateTaxUnarchive`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateTaxUnarchive` (IN `p_tax_id` INT, IN `p_last_log_by` INT)   BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tax
    SET tax_status      = 'Active',
        last_log_by     = p_last_log_by
    WHERE tax_id        = p_tax_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateUserAccount`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUserAccount` (IN `p_user_account_id` INT, IN `p_value` VARCHAR(500), IN `p_update_type` VARCHAR(50), IN `p_last_log_by` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    CASE p_update_type
        WHEN 'email' THEN
            UPDATE user_account
            SET email               = p_value,
                last_log_by         = p_last_log_by
            WHERE user_account_id   = p_user_account_id;

        WHEN 'phone' THEN
            UPDATE user_account
            SET phone               = p_value,
                last_log_by         = p_last_log_by
            WHERE user_account_id   = p_user_account_id;

        WHEN 'password' THEN
            UPDATE user_account
            SET password                = p_value,
                last_password_change    = NOW(),
                last_log_by             = p_last_log_by
            WHERE user_account_id       = p_user_account_id;

        WHEN 'profile picture' THEN
            UPDATE user_account
            SET profile_picture     = p_value,
                last_log_by         = p_last_log_by
            WHERE user_account_id   = p_user_account_id;

        WHEN 'two factor auth' THEN
            UPDATE user_account
            SET two_factor_auth     = p_value,
                last_log_by         = p_last_log_by
            WHERE user_account_id   = p_user_account_id;

        WHEN 'multiple session' THEN
            UPDATE user_account
            SET multiple_session    = p_value,
                last_log_by         = p_last_log_by
            WHERE user_account_id   = p_user_account_id;

        WHEN 'status' THEN
            UPDATE user_account
            SET active              = p_value,
                last_log_by         = p_last_log_by
            WHERE user_account_id   = p_user_account_id;

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
END$$

DROP PROCEDURE IF EXISTS `updateUserPassword`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUserPassword` (IN `p_user_account_id` INT, IN `p_password` VARCHAR(255))   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `updateWarehouseArchive`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateWarehouseArchive` (IN `p_warehouse_id` INT, IN `p_last_log_by` INT)   BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE warehouse
    SET warehouse_status    = 'Archived',
        last_log_by         = p_last_log_by
    WHERE warehouse_id      = p_warehouse_id;

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `updateWarehouseUnarchive`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateWarehouseUnarchive` (IN `p_warehouse_id` INT, IN `p_last_log_by` INT)   BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE warehouse
    SET warehouse_status    = 'Active',
        last_log_by         = p_last_log_by
    WHERE warehouse_id      = p_warehouse_id;

    COMMIT;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `address_type`
--

DROP TABLE IF EXISTS `address_type`;
CREATE TABLE `address_type` (
  `address_type_id` int(10) UNSIGNED NOT NULL,
  `address_type_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `address_type`
--

INSERT INTO `address_type` (`address_type_id`, `address_type_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Home Address', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(2, 'Billing Address', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(3, 'Mailing Address', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(4, 'Shipping Address', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(5, 'Work Address', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1);

--
-- Triggers `address_type`
--
DROP TRIGGER IF EXISTS `trg_address_type_insert`;
DELIMITER $$
CREATE TRIGGER `trg_address_type_insert` AFTER INSERT ON `address_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Address type created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('address_type', NEW.address_type_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_address_type_update`;
DELIMITER $$
CREATE TRIGGER `trg_address_type_update` AFTER UPDATE ON `address_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Address type changed.<br/><br/>';

    IF NEW.address_type_name <> OLD.address_type_name THEN
        SET audit_log = CONCAT(audit_log, "Address Type Name: ", OLD.address_type_name, " -> ", NEW.address_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Address type changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('address_type', NEW.address_type_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
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
(1, 'Settings', 'Centralized management hub for comprehensive organizational oversight and control.', './storage/uploads/app_module/1/settings.png', 1, 'App Module', 100, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2, 'Employee', 'Centralize employee information.', './storage/uploads/app_module/2/employees.png', 40, 'Employee', 5, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3, 'Point of Sale', 'Handle checkouts and payments for shops and restaurants.', './storage/uploads/app_module/4/pos.png', 1, 'App Module', 10, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(4, 'Inventory', 'Manage your stocks and logistics activities.', './storage/uploads/app_module/3/inventory.png', 58, 'Product', 15, '2025-10-21 21:38:00', '2025-10-21 22:16:42', 2);

--
-- Triggers `app_module`
--
DROP TRIGGER IF EXISTS `trg_app_module_insert`;
DELIMITER $$
CREATE TRIGGER `trg_app_module_insert` AFTER INSERT ON `app_module` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'App module created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('app_module', NEW.app_module_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_app_module_update`;
DELIMITER $$
CREATE TRIGGER `trg_app_module_update` AFTER UPDATE ON `app_module` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'App module changed.<br/><br/>';

    IF NEW.app_module_name <> OLD.app_module_name THEN
        SET audit_log = CONCAT(audit_log, "App Module Name: ", OLD.app_module_name, " -> ", NEW.app_module_name, "<br/>");
    END IF;

    IF NEW.app_module_description <> OLD.app_module_description THEN
        SET audit_log = CONCAT(audit_log, "App Module Description: ", OLD.app_module_description, " -> ", NEW.app_module_description, "<br/>");
    END IF;

    IF NEW.menu_item_name <> OLD.menu_item_name THEN
        SET audit_log = CONCAT(audit_log, "Menu Item: ", OLD.menu_item_name, " -> ", NEW.menu_item_name, "<br/>");
    END IF;

    IF NEW.order_sequence <> OLD.order_sequence THEN
        SET audit_log = CONCAT(audit_log, "Order Sequence: ", OLD.order_sequence, " -> ", NEW.order_sequence, "<br/>");
    END IF;
    
    IF audit_log <> 'App module changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('app_module', NEW.app_module_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `attribute`
--

DROP TABLE IF EXISTS `attribute`;
CREATE TABLE `attribute` (
  `attribute_id` int(10) UNSIGNED NOT NULL,
  `attribute_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `attribute`
--
DROP TRIGGER IF EXISTS `trg_attribute_insert`;
DELIMITER $$
CREATE TRIGGER `trg_attribute_insert` AFTER INSERT ON `attribute` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Attribute created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('attribute', NEW.attribute_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_attribute_update`;
DELIMITER $$
CREATE TRIGGER `trg_attribute_update` AFTER UPDATE ON `attribute` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Attribute changed.<br/><br/>';

    IF NEW.attribute_name <> OLD.attribute_name THEN
        SET audit_log = CONCAT(audit_log, "Attribute Name: ", OLD.attribute_name, " -> ", NEW.attribute_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Attribute changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('attribute', NEW.attribute_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `attribute_value`
--

DROP TABLE IF EXISTS `attribute_value`;
CREATE TABLE `attribute_value` (
  `attribute_value_id` int(10) UNSIGNED NOT NULL,
  `attribute_value_name` varchar(100) NOT NULL,
  `attribute_id` int(10) UNSIGNED NOT NULL,
  `attribute_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `attribute_value`
--
DROP TRIGGER IF EXISTS `trg_attribute_value_insert`;
DELIMITER $$
CREATE TRIGGER `trg_attribute_value_insert` AFTER INSERT ON `attribute_value` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Attribute value created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('attribute_value', NEW.attribute_value_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_attribute_value_update`;
DELIMITER $$
CREATE TRIGGER `trg_attribute_value_update` AFTER UPDATE ON `attribute_value` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Attribute value changed.<br/><br/>';

    IF NEW.attribute_value_name <> OLD.attribute_value_name THEN
        SET audit_log = CONCAT(audit_log, "Attribute Value Name: ", OLD.attribute_value_name, " -> ", NEW.attribute_value_name, "<br/>");
    END IF;

    IF NEW.attribute_name <> OLD.attribute_name THEN
        SET audit_log = CONCAT(audit_log, "Attribute Name: ", OLD.attribute_name, " -> ", NEW.attribute_name, "<br/>");
    END IF;

    IF audit_log <> 'Attribute value changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('attribute_value', NEW.attribute_value_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

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
  `changed_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

DROP TABLE IF EXISTS `bank`;
CREATE TABLE `bank` (
  `bank_id` int(10) UNSIGNED NOT NULL,
  `bank_name` varchar(100) NOT NULL,
  `bank_identifier_code` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bank`
--

INSERT INTO `bank` (`bank_id`, `bank_name`, `bank_identifier_code`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Banco de Oro (BDO)', '010530667', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(2, 'Metrobank', '010269996', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(3, 'Land Bank of the Philippines', '010350025', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(4, 'Bank of the Philippine Islands (BPI)', '010040018', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(5, 'Philippine National Bank (PNB)', '010080010', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(6, 'Security Bank', '010140015', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(7, 'UnionBank of the Philippines', '010419995', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(8, 'Development Bank of the Philippines (DBP)', '010590018', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(9, 'EastWest Bank', '010620014', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(10, 'China Banking Corporation (Chinabank)', '010100013', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(11, 'RCBC (Rizal Commercial Banking Corporation)', '010280014', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(12, 'Maybank Philippines', '010220016', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(13, 'Bank of America', 'BOFAUS3N', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(14, 'JPMorgan Chase', 'CHASUS33', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(15, 'Wells Fargo', 'WFBIUS6W', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(16, 'Citibank', 'CITIUS33', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(17, 'Bank of New York Mellon', 'BKONYUS33', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(18, 'State Street Corporation', 'SSTTUS33', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(19, 'Goldman Sachs', 'GOLDUS33', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(20, 'Morgan Stanley', 'MSNYUS33', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(21, 'Capital One', 'COWNUS33', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(22, 'PNC Financial Services Group', 'PNCCUS33', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(23, 'Truist Financial Corporation', 'TRUIUS33', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(24, 'Ally Financial', 'ALLYUS33', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(25, 'TD Bank', 'TDUSUS33', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(26, 'Regions Financial Corporation', 'RGNSUS33', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(27, 'M&T Bank', 'MANTUS33', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(28, 'SunTrust Banks', 'STBAUS33', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(29, 'Emirates NBD', 'EBILAEAD', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(30, 'First Abu Dhabi Bank', 'NBADAEAAXXX', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(31, 'Abu Dhabi Commercial Bank', 'ADCBAEAAXXX', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(32, 'Dubai Islamic Bank', 'DIBAEAAXXX', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(33, 'Mashreq Bank', 'BOMLAEAD', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(34, 'Union National Bank', 'UNBAEAAXXX', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(35, 'Commercial Bank of Dubai', 'CBDAEAAXXX', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(36, 'Emirates Islamic Bank', 'EIILAEAD', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(37, 'Ajman Bank', 'AJBLAEAD', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(38, 'Sharjah Islamic Bank', 'SIBAEAAXXX', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1);

--
-- Triggers `bank`
--
DROP TRIGGER IF EXISTS `trg_bank_insert`;
DELIMITER $$
CREATE TRIGGER `trg_bank_insert` AFTER INSERT ON `bank` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Bank created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('bank', NEW.bank_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_bank_update`;
DELIMITER $$
CREATE TRIGGER `trg_bank_update` AFTER UPDATE ON `bank` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Bank changed.<br/><br/>';

    IF NEW.bank_name <> OLD.bank_name THEN
        SET audit_log = CONCAT(audit_log, "Bank Name: ", OLD.bank_name, " -> ", NEW.bank_name, "<br/>");
    END IF;

    IF NEW.bank_identifier_code <> OLD.bank_identifier_code THEN
        SET audit_log = CONCAT(audit_log, "Bank Identifier Code: ", OLD.bank_identifier_code, " -> ", NEW.bank_identifier_code, "<br/>");
    END IF;
    
    IF audit_log <> 'Bank changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('bank', NEW.bank_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bank_account_type`
--

DROP TABLE IF EXISTS `bank_account_type`;
CREATE TABLE `bank_account_type` (
  `bank_account_type_id` int(10) UNSIGNED NOT NULL,
  `bank_account_type_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bank_account_type`
--

INSERT INTO `bank_account_type` (`bank_account_type_id`, `bank_account_type_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Checking', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(2, 'Savings', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1);

--
-- Triggers `bank_account_type`
--
DROP TRIGGER IF EXISTS `trg_bank_account_type_insert`;
DELIMITER $$
CREATE TRIGGER `trg_bank_account_type_insert` AFTER INSERT ON `bank_account_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Bank account type created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('bank_account_type', NEW.bank_account_type_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_bank_account_type_update`;
DELIMITER $$
CREATE TRIGGER `trg_bank_account_type_update` AFTER UPDATE ON `bank_account_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Bank account type changed.<br/><br/>';

    IF NEW.bank_account_type_name <> OLD.bank_account_type_name THEN
        SET audit_log = CONCAT(audit_log, "Bank Account Type Name: ", OLD.bank_account_type_name, " -> ", NEW.bank_account_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Bank account type changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('bank_account_type', NEW.bank_account_type_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `blood_type`
--

DROP TABLE IF EXISTS `blood_type`;
CREATE TABLE `blood_type` (
  `blood_type_id` int(10) UNSIGNED NOT NULL,
  `blood_type_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `blood_type`
--

INSERT INTO `blood_type` (`blood_type_id`, `blood_type_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'A+', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(2, 'A-', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(3, 'B+', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(4, 'B-', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(5, 'AB+', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(6, 'AB-', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(7, 'O+', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(8, 'O-', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1);

--
-- Triggers `blood_type`
--
DROP TRIGGER IF EXISTS `trg_blood_type_insert`;
DELIMITER $$
CREATE TRIGGER `trg_blood_type_insert` AFTER INSERT ON `blood_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Blood type created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('blood_type', NEW.blood_type_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_blood_type_update`;
DELIMITER $$
CREATE TRIGGER `trg_blood_type_update` AFTER UPDATE ON `blood_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Blood type changed.<br/><br/>';

    IF NEW.blood_type_name <> OLD.blood_type_name THEN
        SET audit_log = CONCAT(audit_log, "Blood Type Name: ", OLD.blood_type_name, " -> ", NEW.blood_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Blood type changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('blood_type', NEW.blood_type_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `city_id` int(10) UNSIGNED NOT NULL,
  `city_name` varchar(100) NOT NULL,
  `state_id` int(10) UNSIGNED NOT NULL,
  `state_name` varchar(100) NOT NULL,
  `country_id` int(10) UNSIGNED NOT NULL,
  `country_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `city`
--

INSERT INTO `city` (`city_id`, `city_name`, `state_id`, `state_name`, `country_id`, `country_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Alac', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2, 'Allangigan Primero', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3, 'Aloleng', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(4, 'Amagbagan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(5, 'Anambongan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(6, 'Angatel', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(7, 'Anulid', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(8, 'Baay', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(9, 'Bacag', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(10, 'Bacnar', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(11, 'Bactad Proper', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(12, 'Bacundao Weste', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(13, 'Bail', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(14, 'Balingasay', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(15, 'Balingueo', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(16, 'Balogo', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(17, 'Baluyot', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(18, 'Bangan-Oda', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(19, 'Banog Sur', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(20, 'Bantog', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(21, 'Barangobong', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(22, 'Baro', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(23, 'Barong', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(24, 'Basing', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(25, 'Bataquil', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(26, 'Bayaoas', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(27, 'Bical Norte', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(28, 'Bil-Loca', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(29, 'Binabalian', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(30, 'Binday', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(31, 'Bobonan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(32, 'Bogtong', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(33, 'Bolaoit', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(34, 'Bolingit', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(35, 'Bolo', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(36, 'Boñgalon', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(37, 'Botao', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(38, 'Bued', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(39, 'Buenlag', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(40, 'Bulog', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(41, 'Butubut Norte', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(42, 'Caabiangan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(43, 'Cabalaoangan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(44, 'Cabalitian', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(45, 'Cabittaogan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(46, 'Cabugao', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(47, 'Cabungan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(48, 'Calepaan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(49, 'Callaguip', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(50, 'Calomboyan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(51, 'Calongbuyan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(52, 'Calsib', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(53, 'Camaley', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(54, 'Canan Norte', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(55, 'Canaoalan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(56, 'Cantoria', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(57, 'Capandanan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(58, 'Capulaan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(59, 'Caramutan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(60, 'Caronoan West', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(61, 'Carot', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(62, 'Carriedo', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(63, 'Carusucan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(64, 'Caterman', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(65, 'Cato', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(66, 'Catuday', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(67, 'Cayanga', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(68, 'Cayungnan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(69, 'City of Batac', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(70, 'City of Candon', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(71, 'City of Urdaneta', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(72, 'City of Vigan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(73, 'Comillas Norte', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(74, 'Corrooy', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(75, 'Dagup', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(76, 'Damortis', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(77, 'Darapidap', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(78, 'Davila', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(79, 'Diaz', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(80, 'Dilan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(81, 'Domalanoan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(82, 'Don Pedro', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(83, 'Dorongan Punta', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(84, 'Doyong', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(85, 'Dulig', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(86, 'Dumpay', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(87, 'Eguia', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(88, 'Esmeralda', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(89, 'Fuerte', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(90, 'Gayaman', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(91, 'Guiling', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(92, 'Guiset East', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(93, 'Hacienda', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(94, 'Halog West', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(95, 'Ilioilio', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(96, 'Inabaan Sur', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(97, 'Isla', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(98, 'Labayug', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(99, 'Labney', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(100, 'Lagasit', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(101, 'Laguit Centro', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(102, 'Leones East', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(103, 'Lepa', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(104, 'Libas', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(105, 'Linmansangan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(106, 'Lloren', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(107, 'Lobong', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(108, 'Longos', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(109, 'Loqueb Este', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(110, 'Lucap', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(111, 'Lucero', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(112, 'Luna', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(113, 'Lunec', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(114, 'Lungog', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(115, 'Lusong', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(116, 'Mabilao', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(117, 'Mabilbila Sur', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(118, 'Mabusag', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(119, 'Macabuboni', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(120, 'Macalong', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(121, 'Macalva Norte', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(122, 'Macayug', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(123, 'Magtaking', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(124, 'Malabago', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(125, 'Malanay', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(126, 'Malawa', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(127, 'Malibong East', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(128, 'Mapolopolo', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(129, 'Maticmatic', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(130, 'Minien East', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(131, 'Nagbacalan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(132, 'Nagsaing', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(133, 'Naguelguel', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(134, 'Naguilayan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(135, 'Naguilian', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(136, 'Nalsian Norte', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(137, 'Nama', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(138, 'Namboongan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(139, 'Nancalobasaan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(140, 'Navatat', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(141, 'Nibaliw Central', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(142, 'Nilombot', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(143, 'Ninoy', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(144, 'Oaqui', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(145, 'Olea', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(146, 'Padong', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(147, 'Pagsanahan Norte', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(148, 'Paitan Este', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(149, 'Palacpalac', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(150, 'Palguyod', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(151, 'Pangapisan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(152, 'Pangascasan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(153, 'Pangpang', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(154, 'Paringao', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(155, 'Parioc Segundo', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(156, 'Pasibi West', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(157, 'Patayac', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(158, 'Patpata Segundo', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(159, 'Payocpoc Sur', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(160, 'Pindangan Centro', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(161, 'Pogonsili', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(162, 'Polo', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(163, 'Polong', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(164, 'Polong Norte', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(165, 'Pudoc', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(166, 'Pudoc North', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(167, 'Puelay', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(168, 'Puro Pinget', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(169, 'Quiling', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(170, 'Quinarayan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(171, 'Quintong', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(172, 'Ranao', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(173, 'Rimus', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(174, 'Rissing', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(175, 'Sablig', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(176, 'Sagud-Bahley', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(177, 'Sagunto', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(178, 'Samon', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(179, 'San Eugenio', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(180, 'San Fernando Poblacion', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(181, 'San Gabriel First', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(182, 'San Juan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(183, 'San Pedro Apartado', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(184, 'San Quintin', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(185, 'Sanlibo', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(186, 'Santo Tomas', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(187, 'Sonquil', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(188, 'Subusub', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(189, 'Sumabnit', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(190, 'Suso', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(191, 'Tablac', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(192, 'Tabug', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(193, 'Talospatang', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(194, 'Taloy', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(195, 'Tamayo', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(196, 'Tamorong', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(197, 'Tandoc', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(198, 'Tanolong', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(199, 'Tebag East', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(200, 'Telbang', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(201, 'Tiep', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(202, 'Toboy', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(203, 'Tobuan', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(204, 'Tococ East', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(205, 'Tombod', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(206, 'Tondol', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(207, 'Toritori', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(208, 'Umanday Centro', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(209, 'Unzad', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(210, 'Uyong', 1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(211, 'Abut', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(212, 'Accusilian', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(213, 'Afusing Centro', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(214, 'Alabug', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(215, 'Alannay', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(216, 'Alicia', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(217, 'Allacapan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(218, 'Almaguer North', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(219, 'Amulung', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(220, 'Antagan Segunda', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(221, 'Aparri', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(222, 'Atulayan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(223, 'Awallan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(224, 'Bacnor East', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(225, 'Baggabag B', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(226, 'Baggao', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(227, 'Bagong Tanza', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(228, 'Bagu', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(229, 'Ballesteros', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(230, 'Bangad', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(231, 'Banganan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(232, 'Banquero', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(233, 'Barucboc Norte', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(234, 'Basco', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(235, 'Battung', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(236, 'Belance', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(237, 'Binalan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(238, 'Binguang', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(239, 'Bintawan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(240, 'Bitag Grande', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(241, 'Bone South', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(242, 'Buliwao', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(243, 'Bulu', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(244, 'Busilak', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(245, 'Cabannungan Second', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(246, 'Cabaritan East', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(247, 'Cabiraoan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(248, 'Calamagui East', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(249, 'Calantac', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(250, 'Calaoagan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(251, 'Calayan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(252, 'Calinaoan Malasin', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(253, 'Calog Norte', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(254, 'Camalaniugan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(255, 'Capissayan Sur', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(256, 'Carig', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(257, 'Casambalangan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(258, 'Catayauan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(259, 'Cullalabo del Sur', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(260, 'Dalaoig', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(261, 'Daragutan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(262, 'Dassun', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(263, 'Diamantina', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(264, 'Dibuluan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(265, 'Dicabisagan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(266, 'Dicamay', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(267, 'Dinapigui', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(268, 'Divilican', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(269, 'Divisoria', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(270, 'Dodan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(271, 'Dumabato', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(272, 'Echague (town)', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(273, 'Eden', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(274, 'Enrile', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(275, 'Esperanza East', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(276, 'Estefania', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(277, 'Furao', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(278, 'Gadu', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(279, 'Gammad', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(280, 'Ganapi', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(281, 'Gappal', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(282, 'Gattaran', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(283, 'Gonzaga', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(284, 'Guiddam', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(285, 'Iguig', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(286, 'Ineangan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(287, 'Itbayat', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(288, 'Ivana', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(289, 'La Paz', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(290, 'Lal-lo', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(291, 'Lallayug', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(292, 'Lanna', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(293, 'Lapi', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(294, 'Larion Alto', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(295, 'Lasam', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(296, 'Mabasa', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(297, 'Mabuttal East', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(298, 'Maddarulug Norte', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(299, 'Magalalag', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(300, 'Maguilling', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(301, 'Mahatao', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(302, 'Malasin', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(303, 'Maluno Sur', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(304, 'Manaring', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(305, 'Manga', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(306, 'Masaya Sur', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(307, 'Masipi West', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(308, 'Maxingal', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(309, 'Minallo', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(310, 'Minanga Norte', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(311, 'Minante Segundo', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(312, 'Minuri', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(313, 'Mozzozzin Sur', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(314, 'Mungo', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(315, 'Municipality of Delfin Albano', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(316, 'Muñoz East', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(317, 'Nabannagan West', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(318, 'Nagrumbuan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(319, 'Namuac', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(320, 'Nattapian', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(321, 'Paddaya', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(322, 'Palagao Norte', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(323, 'Palanan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(324, 'Pangal Sur', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(325, 'Pattao', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(326, 'Peñablanca', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(327, 'Piat', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(328, 'Pinoma', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(329, 'Quibal', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(330, 'Ragan Norte', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(331, 'Ramon (municipal capital)', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(332, 'Ramos West', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(333, 'Rizal', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(334, 'Sabtang', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(335, 'Salinas', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(336, 'Salinungan Proper', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(337, 'San Agustin', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(338, 'San Antonio', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(339, 'San Bernardo', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(340, 'San Isidro', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(341, 'San Mateo', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(342, 'San Pablo', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(343, 'San Pedro', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(344, 'San Vicente', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(345, 'Sanchez Mira', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(346, 'Sandiat Centro', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(347, 'Santa Ana', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(348, 'Santa Cruz', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(349, 'Santa Praxedes', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(350, 'Santiago', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(351, 'Santo Niño', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(352, 'Siempre Viva', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(353, 'Sillawit', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(354, 'Simanu Sur', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(355, 'Simimbaan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(356, 'Sinamar', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(357, 'Sindon', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(358, 'Solana', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(359, 'Soyung', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(360, 'Taguing', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(361, 'Tapel', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(362, 'Tuao', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(363, 'Tupang', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(364, 'Uddiawan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(365, 'Ugac Sur', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(366, 'Ugad', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(367, 'Uyugan', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(368, 'Yeban Norte', 2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(369, 'Acli', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(370, 'Agbannawag', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(371, 'Akle', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(372, 'Alua', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(373, 'Amacalan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(374, 'Amucao', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(375, 'Amuñgan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(376, 'Angat', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(377, 'Angeles', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(378, 'Arenas', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(379, 'Arminia', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(380, 'Bacabac', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(381, 'Bacsay', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(382, 'Bagac', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(383, 'Bagong Barrio', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(384, 'Bagong-Sikat', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(385, 'Bahay Pare', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(386, 'Bakulong', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(387, 'Balagtas', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(388, 'Balanga', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(389, 'Balaoang', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(390, 'Balas', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(391, 'Balasing', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(392, 'Balayang', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(393, 'Balingcanaway', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(394, 'Balite', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(395, 'Baliuag', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(396, 'Baloc', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(397, 'Baloy', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(398, 'Balsic', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(399, 'Balucuc', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(400, 'Balut', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(401, 'Balutu', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(402, 'Banawang', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(403, 'Baquero Norte', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(404, 'Batasan Bata', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(405, 'Batitang', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(406, 'Bayanan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(407, 'Beddeng', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(408, 'Biay', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(409, 'Bibiclat', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(410, 'Bicos', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(411, 'Biga', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(412, 'Bilad', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(413, 'Bobon Second', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(414, 'Bodega', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(415, 'Bolitoc', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(416, 'Buensuseso', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(417, 'Bulaon', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(418, 'Bularit', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(419, 'Bulawin', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(420, 'Bulihan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(421, 'Buliran', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(422, 'Buliran Segundo', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(423, 'Bulualto', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(424, 'Bundoc', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(425, 'Bunol', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(426, 'Cabayaoasan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(427, 'Cabcaben', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(428, 'Cabog', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(429, 'Cafe', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(430, 'Calaba', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(431, 'Calancuasan Norte', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(432, 'Calangain', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(433, 'Calantas', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(434, 'Calayaan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(435, 'Calibungan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(436, 'Calibutbut', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(437, 'Calingcuan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(438, 'Calumpang', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(439, 'Calumpit', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(440, 'Cama Juan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(441, 'Camachile', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(442, 'Camias', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(443, 'Candating', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(444, 'Carmen', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(445, 'Cavite', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(446, 'Cawayan Bugtong', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(447, 'City of Balanga', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(448, 'City of Gapan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(449, 'City of Malolos', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(450, 'City of Meycauayan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(451, 'City of San Fernando', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(452, 'City of San Jose del Monte', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(453, 'Comillas', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(454, 'Communal', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(455, 'Concepcion', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(456, 'Conversion', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(457, 'Culianin', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(458, 'Culubasa', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(459, 'Cut-cut Primero', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(460, 'Dampol', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(461, 'Del Pilar', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(462, 'Digdig', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(463, 'Diliman Primero', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(464, 'Dinalongan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(465, 'Dinalupihan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(466, 'Entablado', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(467, 'Estipona', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(468, 'Estrella', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(469, 'Gueset', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(470, 'Guiguinto', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(471, 'Guisguis', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(472, 'Guyong', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(473, 'Hermosa', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(474, 'Lambakin', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(475, 'Lanat', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(476, 'Laug', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(477, 'Lawang Kupang', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(478, 'Lennec', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(479, 'Ligaya', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(480, 'Liozon', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(481, 'Lipay', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(482, 'Lomboy', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(483, 'Lourdes', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(484, 'Lucapon', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(485, 'Mabayo', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(486, 'Mabilang', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(487, 'Mabilog', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(488, 'Macapsing', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(489, 'Macarse', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(490, 'Macatbong', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1);
INSERT INTO `city` (`city_id`, `city_name`, `state_id`, `state_name`, `country_id`, `country_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(491, 'Magliman', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(492, 'Magtangol', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(493, 'Maguinao', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(494, 'Malabon', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(495, 'Malacampa', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(496, 'Maligaya', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(497, 'Malino', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(498, 'Malolos', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(499, 'Maloma', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(500, 'Maluid', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(501, 'Malusac', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(502, 'Mambog', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(503, 'Mamonit', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(504, 'Manacsac', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(505, 'Manatal', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(506, 'Mandili', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(507, 'Mangga', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(508, 'Manibaug Pasig', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(509, 'Manogpi', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(510, 'Mapalacsiao', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(511, 'Mapalad', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(512, 'Mapaniqui', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(513, 'Maquiapo', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(514, 'Marawa', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(515, 'Marilao', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(516, 'Mariveles', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(517, 'Masalipit', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(518, 'Matayumtayum', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(519, 'Maturanoc', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(520, 'Meycauayan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(521, 'Moriones', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(522, 'Motrico', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(523, 'Nagpandayan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(524, 'Nambalan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(525, 'Nancamarinan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(526, 'Nieves', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(527, 'Niugan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(528, 'Norzagaray', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(529, 'Obando', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(530, 'Orani', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(531, 'Paco Roman', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(532, 'Padapada', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(533, 'Paitan Norte', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(534, 'Palusapis', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(535, 'Pamatawan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(536, 'Panabingan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(537, 'Panan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(538, 'Pance', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(539, 'Pandacaqui', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(540, 'Pandi', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(541, 'Pando', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(542, 'Pantubig', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(543, 'Paombong', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(544, 'Papaya', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(545, 'Parista', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(546, 'Pau', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(547, 'Pias', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(548, 'Piñahan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(549, 'Pinambaran', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(550, 'Pio', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(551, 'Porais', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(552, 'Prado Siongco', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(553, 'Pulilan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(554, 'Pulo', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(555, 'Pulong Gubat', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(556, 'Pulong Sampalok', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(557, 'Pulung Santol', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(558, 'Pulungmasle', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(559, 'Puncan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(560, 'Purac', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(561, 'Putlod', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(562, 'Rajal Norte', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(563, 'Sabang', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(564, 'Sagana', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(565, 'Salapungan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(566, 'Salaza', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(567, 'Salvacion I', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(568, 'San Alejandro', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(569, 'San Andres', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(570, 'San Anton', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(571, 'San Basilio', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(572, 'San Casimiro', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(573, 'San Cristobal', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(574, 'San Felipe Old', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(575, 'San Francisco', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(576, 'San Jose del Monte', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(577, 'San Juan de Mata', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(578, 'San Lorenzo', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(579, 'San Luis', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(580, 'San Mariano', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(581, 'San Nicolas', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(582, 'San Patricio', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(583, 'San Rafael', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(584, 'San Roque', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(585, 'San Roque Dau First', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(586, 'San Vincente', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(587, 'Santa Fe', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(588, 'Santa Ines West', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(589, 'Santa Juliana', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(590, 'Santa Maria', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(591, 'Santa Monica', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(592, 'Santa Rita', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(593, 'Santa Teresa First', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(594, 'Santo Cristo', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(595, 'Santo Rosario', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(596, 'Sapang', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(597, 'Sapang Buho', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(598, 'Sapol', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(599, 'Saysain', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(600, 'Sibul', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(601, 'Siclong', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(602, 'Sinilian First', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(603, 'Soledad', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(604, 'Suklayin', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(605, 'Sula', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(606, 'Sulucan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(607, 'Tabacao', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(608, 'Tabon', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(609, 'Tabuating', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(610, 'Tal I Mun Doc', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(611, 'Talaga', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(612, 'Talang', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(613, 'Taltal', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(614, 'Tariji', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(615, 'Tayabo', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(616, 'Telabastagan', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(617, 'Tikiw', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(618, 'Tinang', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(619, 'Tondod', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(620, 'Uacon', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(621, 'Umiray', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(622, 'Upig', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(623, 'Vargas', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(624, 'Villa Aglipay', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(625, 'Villa Isla', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(626, 'Vizal San Pablo', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(627, 'Vizal Santo Niño', 3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(628, 'Altavas', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(629, 'Balete', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(630, 'Banga', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(631, 'Batan', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(632, 'Buruanga', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(633, 'Ibajay', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(634, 'Kalibo', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(635, 'Lezo', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(636, 'Libacao', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(637, 'Madalag', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(638, 'Makato', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(639, 'Malay', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(640, 'Malinao', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(641, 'Nabas', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(642, 'New Washington', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(643, 'Numancia', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(644, 'Tangalan', 4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(645, 'Aanislag', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(646, 'Abucay', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(647, 'Agos', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(648, 'Aguada', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(649, 'Agupit', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(650, 'Alayao', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(651, 'Anuling', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(652, 'Apad', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(653, 'Apud', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(654, 'Armenia', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(655, 'Ayugan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(656, 'Bacacay', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(657, 'Bacolod', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(658, 'Bacon', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(659, 'Bagacay', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(660, 'Bagahanlad', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(661, 'Bagumbayan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(662, 'Bahay', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(663, 'Balading', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(664, 'Balaogan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(665, 'Baligang', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(666, 'Balinad', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(667, 'Baliuag Nuevo', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(668, 'Balucawi', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(669, 'Banag', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(670, 'Bangkirohan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(671, 'Banocboc', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(672, 'Bao', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(673, 'Barayong', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(674, 'Bariw', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(675, 'Barra', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(676, 'Bascaron', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(677, 'Basiad', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(678, 'Basicao Coastal', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(679, 'Basud', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(680, 'Batana', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(681, 'Batobalane', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(682, 'Beberon', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(683, 'Bigaa', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(684, 'Binanwanaan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(685, 'Binitayan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(686, 'Binodegahan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(687, 'Bonga', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(688, 'Boton', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(689, 'Buang', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(690, 'Buenavista', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(691, 'Buga', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(692, 'Buhatan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(693, 'Bulo', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(694, 'Buluang', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(695, 'Burabod', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(696, 'Buracan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(697, 'Busing', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(698, 'Butag', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(699, 'Buyo', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(700, 'Cabcab', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(701, 'Cabiguan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(702, 'Cabitan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(703, 'Cabognon', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(704, 'Caditaan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(705, 'Cadlan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(706, 'Cagmanaba', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(707, 'Calabaca', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(708, 'Calachuchi', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(709, 'Calasgasan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(710, 'Calolbon', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(711, 'Camalig', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(712, 'Canomoy', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(713, 'Capalonga', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(714, 'Capucnasan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(715, 'Capuy', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(716, 'Caranan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(717, 'Caraycayon', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(718, 'Castillo', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(719, 'Catabangan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(720, 'Causip', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(721, 'Cotmon', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(722, 'Culacling', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(723, 'Cumadcad', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(724, 'Curry', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(725, 'Daet', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(726, 'Daguit', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(727, 'Dalupaon', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(728, 'Dangcalan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(729, 'Dapdap', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(730, 'Daraga', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(731, 'Del Rosario', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(732, 'Dugcal', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(733, 'Dugongan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(734, 'Estancia', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(735, 'Fabrica', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(736, 'Gabao', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(737, 'Gambalidio', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(738, 'Gatbo', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(739, 'Gibgos', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(740, 'Guijalo', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(741, 'Guinacotan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(742, 'Guinobatan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(743, 'Gumaus', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(744, 'Guruyan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(745, 'Hamoraon', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(746, 'Herrera', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(747, 'Himaao', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(748, 'Hobo', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(749, 'Imelda', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(750, 'Inapatan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(751, 'Iraya', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(752, 'Joroan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(753, 'Jose Pañganiban', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(754, 'Jovellar', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(755, 'Kaliliog', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(756, 'Kinalansan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(757, 'Labnig', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(758, 'Labo', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(759, 'Lacag', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(760, 'Lajong', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(761, 'Lanigay', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(762, 'Lantangan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(763, 'Larap', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(764, 'Legaspi', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(765, 'Libog', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(766, 'Libon', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(767, 'Liboro', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(768, 'Ligao', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(769, 'Limbuhan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(770, 'Lubigan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(771, 'Lugui', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(772, 'Luklukan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(773, 'Lupi Viejo', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(774, 'Maagnas', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(775, 'Mabiton', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(776, 'Macabugos', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(777, 'Macalaya', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(778, 'Magsalangi', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(779, 'Mahaba', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(780, 'Malabog', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(781, 'Malasugui', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(782, 'Malatap', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(783, 'Malawag', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(784, 'Malbug', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(785, 'Malidong', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(786, 'Malilipot', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(787, 'Malinta', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(788, 'Mambulo', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(789, 'Mampurog', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(790, 'Manamrag', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(791, 'Manito', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(792, 'Manquiring', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(793, 'Maonon', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(794, 'Marintoc', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(795, 'Marupit', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(796, 'Masaraway', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(797, 'Maslog', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(798, 'Masoli', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(799, 'Matacon', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(800, 'Mauraro', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(801, 'Mayngaran', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(802, 'Mercedes', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(803, 'Miaga', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(804, 'Miliroc', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(805, 'Monbon', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(806, 'Muladbucad', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(807, 'Naagas', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(808, 'Nabangig', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(809, 'Naro', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(810, 'Nato', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(811, 'Odicon', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(812, 'Ogod', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(813, 'Osiao', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(814, 'Osmeña', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(815, 'Padang', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(816, 'Palali', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(817, 'Palestina', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(818, 'Palsong', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(819, 'Pambuhan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(820, 'Pandan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(821, 'Panguiranan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(822, 'Pantao', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(823, 'Parabcan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(824, 'Paracale', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(825, 'Paulba', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(826, 'Pawa', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(827, 'Pawican', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(828, 'Pawili', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(829, 'Peña', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(830, 'Pinit', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(831, 'Pio Duran', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(832, 'Polangui', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(833, 'Ponso', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(834, 'Potot', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(835, 'Puro', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(836, 'Putiao', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(837, 'Quitang', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(838, 'Rapu-Rapu', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(839, 'Recodo', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(840, 'Sabang Indan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(841, 'Sagpon', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(842, 'Sagrada', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(843, 'Sagrada Familia', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(844, 'Sagurong', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(845, 'Salingogan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(846, 'Salogon', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(847, 'Salvacion', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(848, 'San Lucas', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(849, 'San Pascual', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(850, 'San Ramon', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(851, 'Santa Elena', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(852, 'Santa Justina', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(853, 'Santa Rosa Sur', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(854, 'Santa Teresita', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(855, 'Santo Domingo', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(856, 'Sinuknipan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(857, 'Sugcad', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(858, 'Sugod', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(859, 'Tabaco', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(860, 'Tagas', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(861, 'Tagoytoy', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(862, 'Talisay', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(863, 'Talubatib', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(864, 'Tambo', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(865, 'Tara', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(866, 'Tariric', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(867, 'Tigbaw', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(868, 'Tigbinan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(869, 'Tinago', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(870, 'Tinalmud', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(871, 'Tinampo', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(872, 'Tinawagan', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(873, 'Tiwi', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(874, 'Tubli', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(875, 'Tugos', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(876, 'Tulay na Lupa', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(877, 'Tumalaytay', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(878, 'Umabay', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(879, 'Usab', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(880, 'Uson', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(881, 'Utabi', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(882, 'Villahermosa', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(883, 'Vinzons', 5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(884, 'Abaca', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(885, 'Abangay', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(886, 'Abiera', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(887, 'Abilay', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(888, 'Ag-ambulong', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(889, 'Aganan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(890, 'Aglalana', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(891, 'Agpangi', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(892, 'Aguisan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(893, 'Alacaygan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(894, 'Alegria', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(895, 'Alibunan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(896, 'Alicante', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(897, 'Alijis', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(898, 'Alim', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(899, 'Alimono', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(900, 'Ambulong', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(901, 'Andres Bonifacio', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(902, 'Anini-y', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(903, 'Anoring', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(904, 'Aquino', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(905, 'Araal', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(906, 'Aranas Sur', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(907, 'Aranda', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(908, 'Arcangel', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(909, 'Asia', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(910, 'Asturga', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(911, 'Atabayan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(912, 'Atipuluhan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(913, 'Aurelliana', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(914, 'Avila', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(915, 'Bacalan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(916, 'Bacolod City', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(917, 'Bacuyangan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(918, 'Badlan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(919, 'Bago City', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(920, 'Bagroy', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(921, 'Bailan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(922, 'Balabag', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(923, 'Balibagan Oeste', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(924, 'Baliwagan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(925, 'Bancal', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(926, 'Barbaza', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(927, 'Basiao', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(928, 'Bay-ang', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(929, 'Bayas', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(930, 'Belison', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(931, 'Biao', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(932, 'Bilao', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(933, 'Binabaan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(934, 'Binantocan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(935, 'Binon-an', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(936, 'Binonga', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(937, 'Bitadtun', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(938, 'Bocana', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(939, 'Bolanon', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(940, 'Bolilao', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(941, 'Bolong', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(942, 'Brgy. Bachaw Norte Kalibo', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(943, 'Brgy. Bulwang Numancia', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(944, 'Brgy. Mabilo New Washington', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(945, 'Brgy. Nalook kalibo', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(946, 'Brgy. New Buswang Kalibo', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(947, 'Brgy. Tinigao Kalibo', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(948, 'Bugang', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(949, 'Bugasong', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(950, 'Bulad', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(951, 'Bulata', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(952, 'Buluangan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(953, 'Bungsuan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(954, 'Buray', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(955, 'Burias', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(956, 'Busay', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(957, 'Buyuan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(958, 'Cabacungan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(959, 'Cabadiangan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(960, 'Cabanbanan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(961, 'Cabano', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(962, 'Cabilao', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(963, 'Cabilauan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(964, 'Cadagmayan Norte', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(965, 'Cagbang', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(966, 'Calampisauan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(967, 'Calape', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(968, 'Calaya', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(969, 'Calizo', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(970, 'Caluya', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(971, 'Camalobalo', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(972, 'Camandag', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(973, 'Camangcamang', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(974, 'Camindangan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(975, 'Camingawan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(976, 'Caningay', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(977, 'Canroma', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(978, 'Cansilayan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(979, 'Cansolungon', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(980, 'Canturay', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(981, 'Capaga', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(982, 'Capitan Ramon', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(983, 'Carabalan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(984, 'Caridad', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(985, 'Carmelo', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(986, 'Carmen Grande', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(987, 'Cartagena', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(988, 'Cassanayan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(989, 'Caticlan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(990, 'Catungan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(991, 'Cayanguan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(992, 'Cayhagan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(993, 'Cervantes', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(994, 'Chambrey', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1);
INSERT INTO `city` (`city_id`, `city_name`, `state_id`, `state_name`, `country_id`, `country_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(995, 'Codcod', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(996, 'Cogon', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(997, 'Colipapa', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(998, 'Concordia', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(999, 'Constancia', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1000, 'Consuelo', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1001, 'Cortez', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1002, 'Culasi', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1003, 'Da-an Sur', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1004, 'Daliciasao', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1005, 'Damayan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1006, 'Dancalan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1007, 'Dapdapan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1008, 'De la Paz', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1009, 'Dian-ay', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1010, 'Dos Hermanas', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1011, 'Dulangan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1012, 'Dulao', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1013, 'Dungon', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1014, 'Duran', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1015, 'East Valencia', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1016, 'Egaña', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1017, 'Ermita', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1018, 'Eustaquio Lopez', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1019, 'Feliciano', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1020, 'Gabi', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1021, 'Getulio', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1022, 'Gibato', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1023, 'Gibong', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1024, 'Gines-Patay', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1025, 'Granada', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1026, 'Guadalupe', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1027, 'Guiljungan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1028, 'Guinoaliuan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1029, 'Guinticgan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1030, 'Guintubhan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1031, 'Guisijan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1032, 'Hacienda Refugio', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1033, 'Hacienda Santa Rosa', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1034, 'Haguimit', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1035, 'Hamtic', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1036, 'Himaya', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1037, 'Hipona', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1038, 'Idio', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1039, 'Igang', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1040, 'Igbon', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1041, 'Igcocolo', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1042, 'Igmaya-an', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1043, 'Imbang', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1044, 'Inayauan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1045, 'Intampilan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1046, 'Jaena', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1047, 'Jaguimitan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1048, 'Jalaud', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1049, 'Jamabalod', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1050, 'Japitan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1051, 'Jarigue', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1052, 'JayubÃ³', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1053, 'Jibao-an', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1054, 'Kabilauan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1055, 'Kalibo (poblacion)', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1056, 'Kaliling', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1057, 'Kumalisquis', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1058, 'La Granja', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1059, 'Lacaron', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1060, 'Lalab', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1061, 'Lalagsan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1062, 'Lañgub', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1063, 'Lanot', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1064, 'Lawigan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1065, 'Libertad', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1066, 'Linabuan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1067, 'Linabuan Sur', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1068, 'Linaon', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1069, 'Locmayan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1070, 'Lono', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1071, 'Lonoy', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1072, 'Lupo', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1073, 'Maao', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1074, 'Maasin', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1075, 'Mabini', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1076, 'Magallon Cadre', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1077, 'Magdalena', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1078, 'Malabonot', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1079, 'Malabor', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1080, 'Malangabang', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1081, 'Malayo-an', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1082, 'Malocloc', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1083, 'Maloco', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1084, 'Mambagatan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1085, 'Manalad', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1086, 'Mangoso', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1087, 'Manika', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1088, 'Manjoy', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1089, 'Manlucahoc', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1090, 'Manoc-Manoc', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1091, 'Mansilingan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1092, 'Manup', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1093, 'Mapili', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1094, 'Maquiling', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1095, 'Marawis', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1096, 'Maribong', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1097, 'Maricalom', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1098, 'Masaling', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1099, 'Masonogan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1100, 'Mianay', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1101, 'Minapasoc', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1102, 'Minuyan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1103, 'Miranda', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1104, 'Monpon', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1105, 'Montilla', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1106, 'Morales', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1107, 'Morobuan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1108, 'Nabulao', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1109, 'Naili', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1110, 'Naisud', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1111, 'Nangka', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1112, 'Napnapan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1113, 'Napoles', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1114, 'New Pandanon', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1115, 'Ochanado', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1116, 'Odiong', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1117, 'Ogtongon', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1118, 'Ondoy', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1119, 'Oracon', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1120, 'Orong', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1121, 'Pacol', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1122, 'Pakiad', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1123, 'Palampas', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1124, 'Panayacan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1125, 'Paraiso', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1126, 'Parion', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1127, 'Pasil', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1128, 'Patique', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1129, 'Patnongon', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1130, 'Patonan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1131, 'Patria', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1132, 'Payao', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1133, 'Piape I', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1134, 'Piña', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1135, 'Platagata', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1136, 'Polopina', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1137, 'Ponong', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1138, 'Prosperidad', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1139, 'Punao', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1140, 'Quezon', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1141, 'Quinagaringan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1142, 'Quipot', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1143, 'Sagang', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1144, 'Sagasa', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1145, 'Salamanca', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1146, 'San Joaquin', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1147, 'San Remigio', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1148, 'San Salvador', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1149, 'Santa Angel', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1150, 'Santa Teresa', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1151, 'Saravia', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1152, 'Sebaste', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1153, 'Semirara', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1154, 'Sibaguan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1155, 'Sibalom', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1156, 'Sibucao', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1157, 'Suay', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1158, 'Sulangan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1159, 'Sumag', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1160, 'Tabu', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1161, 'Tabuc Pontevedra', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1162, 'Talaban', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1163, 'Taloc', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1164, 'Talokgañgan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1165, 'Talon', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1166, 'Tambac', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1167, 'Tambalisa', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1168, 'Tamlang', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1169, 'Tapas', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1170, 'Tarong', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1171, 'Tibiao', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1172, 'Tiglauigan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1173, 'Tigum', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1174, 'Tiling', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1175, 'Timpas', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1176, 'Tinogboc', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1177, 'Tinongan', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1178, 'Tiring', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1179, 'Tobias Fornier', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1180, 'Tortosa', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1181, 'Trapiche', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1182, 'Tugas', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1183, 'Tumcon Ilawod', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1184, 'Tuyum', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1185, 'Ualog', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1186, 'Ungca', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1187, 'Unidos', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1188, 'Union', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1189, 'Valderrama', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1190, 'Viejo Daan Banua', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1191, 'Vista Alegre', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1192, 'Vito', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1193, 'Yapak', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1194, 'Yubo', 6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1195, 'Calanasan', 7, 'Apayao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1196, 'Conner', 7, 'Apayao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1197, 'Flora', 7, 'Apayao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1198, 'Kabugao', 7, 'Apayao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1199, 'Pudtol', 7, 'Apayao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1200, 'Santa Marcela', 7, 'Apayao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1201, 'Baler', 8, 'Aurora', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1202, 'Casiguran', 8, 'Aurora', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1203, 'Dilasag', 8, 'Aurora', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1204, 'Dinalungan', 8, 'Aurora', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1205, 'Dingalan', 8, 'Aurora', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1206, 'Dipaculao', 8, 'Aurora', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1207, 'Maria Aurora', 8, 'Aurora', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1208, 'Andalan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1209, 'Awang', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1210, 'Bacayawan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1211, 'Badak', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1212, 'Bagan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1213, 'Baka', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1214, 'Bakung', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1215, 'Balimbing', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1216, 'Bangkal', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1217, 'Bankaw', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1218, 'Barurao', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1219, 'Bato Bato', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1220, 'Baunu-Timbangan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1221, 'Bawison', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1222, 'Bayanga', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1223, 'Begang', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1224, 'Binuang', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1225, 'Blinsung', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1226, 'Bongued', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1227, 'Bualan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1228, 'Buan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1229, 'Buansa', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1230, 'Budta', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1231, 'Bugasan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1232, 'Buliok', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1233, 'Bulit', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1234, 'Bumbaran', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1235, 'City of Isabela', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1236, 'Colonia', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1237, 'Cotabato', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1238, 'Dado', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1239, 'Dadus', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1240, 'Dalican', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1241, 'Dalumangcob', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1242, 'Damabalas', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1243, 'Damatulan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1244, 'Digal', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1245, 'Dinaig', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1246, 'Dinganen', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1247, 'Ebcor Town', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1248, 'Gang', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1249, 'Guiong', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1250, 'Idtig', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1251, 'Kabasalan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1252, 'Kagay', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1253, 'Kajatian', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1254, 'Kalang', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1255, 'Kalbugan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1256, 'Kambing', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1257, 'Kanlagay', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1258, 'Kansipati', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1259, 'Karungdong', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1260, 'Katico', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1261, 'Katidtuan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1262, 'Katuli', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1263, 'Kauran', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1264, 'Kitango', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1265, 'Kitapak', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1266, 'Kolape', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1267, 'Kulase', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1268, 'Kulay-Kulay', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1269, 'Kulempang', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1270, 'Kungtad', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1271, 'Labuñgan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1272, 'Laminusa', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1273, 'Lamitan City', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1274, 'Langpas', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1275, 'Latung', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1276, 'Layog', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1277, 'Ligayan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1278, 'Limbo', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1279, 'Litayan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1280, 'Lookan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1281, 'Lu-uk', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1282, 'Lumbac', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1283, 'Luuk Datan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1284, 'Maganoy', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1285, 'Mahala', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1286, 'Makir', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1287, 'Maluso', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1288, 'Manubul', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1289, 'Manuk Mangkaw', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1290, 'Marawi City', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1291, 'Marsada', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1292, 'Mataya', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1293, 'Mauboh', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1294, 'Mileb', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1295, 'New Batu Batu', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1296, 'Nuyo', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1297, 'Pagatin', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1298, 'Paitan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1299, 'Panabuan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1300, 'Panadtaban', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1301, 'Pandakan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1302, 'Pandan Niog', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1303, 'Pang', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1304, 'Parangan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1305, 'Parian Dakula', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1306, 'Pawak', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1307, 'Payuhan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1308, 'Pidsandawan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1309, 'Pinaring', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1310, 'Polloc', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1311, 'Punay', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1312, 'Ramain', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1313, 'Rimpeso', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1314, 'Sambuluan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1315, 'Sanga-Sanga', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1316, 'Santa Clara', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1317, 'Sapa', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1318, 'Sapadun', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1319, 'Satan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1320, 'Semut', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1321, 'Simbahan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1322, 'Simuay', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1323, 'Sionogan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1324, 'Tabiauan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1325, 'Tablas', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1326, 'Taganak', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1327, 'Tairan Camp', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1328, 'Talipaw', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1329, 'Tapayan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1330, 'Tapikan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1331, 'Taungoh', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1332, 'Taviran', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1333, 'Tongouson', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1334, 'Tumbagaan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1335, 'Tunggol', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1336, 'Tungol', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1337, 'Ungus-Ungus', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1338, 'Uyaan', 9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1339, 'Akbar', 10, 'Basilan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1340, 'Al-Barka', 10, 'Basilan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1341, 'Hadji Mohammad Ajul', 10, 'Basilan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1342, 'Hadji Muhtamad', 10, 'Basilan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1343, 'Isabela', 10, 'Basilan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1344, 'Lamitan', 10, 'Basilan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1345, 'Lantawan', 10, 'Basilan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1346, 'Sumisip', 10, 'Basilan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1347, 'Tabuan-Lasa', 10, 'Basilan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1348, 'Tipo-Tipo', 10, 'Basilan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1349, 'Tuburan', 10, 'Basilan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1350, 'Ungkaya Pukan', 10, 'Basilan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1351, 'Abis', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1352, 'Abucayan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1353, 'Adlaon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1354, 'Agsungot', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1355, 'Aguining', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1356, 'Alangilan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1357, 'Alangilanan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1358, 'Alburquerque', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1359, 'Alpaco', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1360, 'Amdos', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1361, 'Amio', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1362, 'Anonang', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1363, 'Anopog', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1364, 'Antequera', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1365, 'Apas', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1366, 'Apoya', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1367, 'Atop-atop', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1368, 'Azagra', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1369, 'Bachauan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1370, 'Baclayon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1371, 'Bagay', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1372, 'Bagtic', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1373, 'Bairan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1374, 'Bal-os', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1375, 'Balayong', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1376, 'Balilihan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1377, 'Banhigan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1378, 'Banilad', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1379, 'Basak', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1380, 'Basdiot', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1381, 'Bateria', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1382, 'Baud', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1383, 'Baugo', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1384, 'Becerril', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1385, 'Biabas', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1386, 'Biasong', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1387, 'Bien Unido', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1388, 'Biking', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1389, 'Bilar', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1390, 'Binlod', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1391, 'Biton', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1392, 'Bitoon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1393, 'Bohol', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1394, 'Bolisong', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1395, 'Bonawon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1396, 'Bonbon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1397, 'Bood', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1398, 'Botigues', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1399, 'Buagsong', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1400, 'Buanoy', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1401, 'Bugas', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1402, 'Bugsoc', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1403, 'Bulasa', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1404, 'Bulod', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1405, 'Cabalawan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1406, 'Cabangahan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1407, 'Cabul-an', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1408, 'Calero', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1409, 'Calidñgan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1410, 'Calituban', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1411, 'Calumboyan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1412, 'Camambugan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1413, 'Cambanay', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1414, 'Campoyo', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1415, 'Campusong', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1416, 'Can-asujan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1417, 'Canauay', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1418, 'Candabong', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1419, 'Candijay', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1420, 'Canhaway', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1421, 'Canjulao', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1422, 'Canmaya Diot', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1423, 'Cansuje', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1424, 'Cantao-an', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1425, 'Casala-an', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1426, 'Casay', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1427, 'Caticugan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1428, 'Catigbian', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1429, 'Catmondaan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1430, 'Catungawan Sur', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1431, 'Cayang', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1432, 'Cogan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1433, 'Cogon Cruz', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1434, 'Cogtong', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1435, 'Corella', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1436, 'Dagohoy', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1437, 'Damolog', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1438, 'Datagon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1439, 'Dauis', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1440, 'Dimiao', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1441, 'Doljo', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1442, 'Doong', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1443, 'Duero', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1444, 'Dumanjog', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1445, 'El Pardo', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1446, 'Esperanza', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1447, 'Estaca', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1448, 'Garcia Hernandez', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1449, 'Giawang', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1450, 'Guba', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1451, 'Guibodangan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1452, 'Guindarohan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1453, 'Guindulman', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1454, 'Guiwanon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1455, 'Hagdan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1456, 'Hagnaya', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1457, 'Hibaiyo', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1458, 'Hilantagaan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1459, 'Hilotongan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1460, 'Himensulan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1461, 'Hinlayagan Ilaud', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1);
INSERT INTO `city` (`city_id`, `city_name`, `state_id`, `state_name`, `country_id`, `country_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1462, 'Ilihan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1463, 'Inabanga', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1464, 'Inayagan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1465, 'Jaclupan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1466, 'Jagna', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1467, 'Jampang', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1468, 'Jandayan Norte', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1469, 'Jantianon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1470, 'Jetafe', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1471, 'Jugno', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1472, 'Kabac', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1473, 'Kabungahan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1474, 'Kandabong', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1475, 'Kaongkod', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1476, 'Kauit', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1477, 'Kotkot', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1478, 'Kuanos', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1479, 'La Hacienda', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1480, 'Lanao', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1481, 'Lanas', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1482, 'Langob', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1483, 'Langtad', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1484, 'Lapaz', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1485, 'Lepanto', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1486, 'Lila', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1487, 'Lipayran', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1488, 'Loay', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1489, 'Loboc', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1490, 'Logon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1491, 'Lombog', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1492, 'Loon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1493, 'Lugo', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1494, 'Lunas', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1495, 'Lut-od', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1496, 'Maayong Tubig', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1497, 'Mabinay', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1498, 'Macaas', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1499, 'Magay', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1500, 'Malabugas', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1501, 'Malaiba', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1502, 'Malhiao', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1503, 'Malingin', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1504, 'Maloh', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1505, 'Malusay', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1506, 'Malway', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1507, 'Manalongon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1508, 'Mancilang', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1509, 'Mandaue City', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1510, 'Maninihon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1511, 'Maño', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1512, 'Mantalongon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1513, 'Mantiquil', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1514, 'Maravilla', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1515, 'Maribojoc', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1516, 'Maricaban', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1517, 'Masaba', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1518, 'Maya', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1519, 'Mayabon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1520, 'Mayana', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1521, 'Mayapusi', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1522, 'McKinley', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1523, 'Minolos', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1524, 'Montaneza', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1525, 'Nagbalaye', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1526, 'Nahawan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1527, 'Nailong', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1528, 'Nalundan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1529, 'Novallas', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1530, 'Nueva Fuerza', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1531, 'Nueva Vida Sur', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1532, 'Nugas', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1533, 'Obong', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1534, 'Ocaña', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1535, 'Ocoy', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1536, 'Okiot', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1537, 'Owak', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1538, 'Padre Zamora', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1539, 'Pajo', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1540, 'Panalipan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1541, 'Panaytayon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1542, 'Pangdan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1543, 'Panglao', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1544, 'Panognawan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1545, 'Patao', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1546, 'Payabon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1547, 'Paypay', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1548, 'Perrelos', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1549, 'Pinamungahan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1550, 'Pinayagan Norte', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1551, 'Pinokawan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1552, 'Putat', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1553, 'Saavedra', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1554, 'Sagbayan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1555, 'Sandayong Sur', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1556, 'Sandolot', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1557, 'Sangat', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1558, 'Santa Filomena', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1559, 'Santa Nino', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1560, 'Santander Poblacion', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1561, 'Sevilla', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1562, 'Sierra Bullones', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1563, 'Sikatuna', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1564, 'Silab', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1565, 'Sillon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1566, 'Simala', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1567, 'Songculan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1568, 'Tabalong', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1569, 'Tabonok', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1570, 'Tabuan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1571, 'Tabunok', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1572, 'Tagbilaran City', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1573, 'Tagum Norte', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1574, 'Tajao', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1575, 'Talangnan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1576, 'Talibon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1577, 'Tambalan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1578, 'Tambongon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1579, 'Tamiso', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1580, 'Tampocon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1581, 'Tandayag', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1582, 'Tangke', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1583, 'Tangnan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1584, 'Tapilon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1585, 'Tapon', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1586, 'Tawala', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1587, 'Taytayan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1588, 'Tayud', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1589, 'Tibigan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1590, 'Tiguib', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1591, 'Tinaan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1592, 'Tinaogan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1593, 'Tindog', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1594, 'Tinubuan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1595, 'Tipolo', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1596, 'Tominhao', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1597, 'Totolan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1598, 'Trinidad', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1599, 'Tubigagmanoc', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1600, 'Tubod-dugoan', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1601, 'Tutay', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1602, 'Ubay', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1603, 'Uling', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1604, 'Valle Hermoso', 11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1605, 'Alugan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1606, 'Anito', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1607, 'Balagui', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1608, 'Balinsacayao', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1609, 'Balocawehay', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1610, 'Bantiqui', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1611, 'Baras', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1612, 'Bilwang', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1613, 'Bitanjuan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1614, 'Bugho', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1615, 'Bugko', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1616, 'Bunga', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1617, 'Butazon', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1618, 'Cabacuñgan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1619, 'Cabay', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1620, 'Cabodiongan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1621, 'Cagamotan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1622, 'Canhandugan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1623, 'Caraycaray', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1624, 'Consuegra', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1625, 'Culasian', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1626, 'Doos', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1627, 'Erenas', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1628, 'Gabas', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1629, 'Ginabuyan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1630, 'Guindapunan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1631, 'Guirang', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1632, 'Hingatungan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1633, 'Hipadpad', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1634, 'Hipasngo', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1635, 'Ibarra', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1636, 'Ichon', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1637, 'Jubasan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1638, 'Kabuynan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1639, 'Kampokpok', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1640, 'Kananya', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1641, 'Kilim', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1642, 'Lalauigan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1643, 'Lamak', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1644, 'Liberty', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1645, 'Lim-oo', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1646, 'Limon', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1647, 'Makiwalo', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1648, 'Malaga', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1649, 'Malajog', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1650, 'Malilinao', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1651, 'Mantang', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1652, 'Masarayao', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1653, 'Matlang', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1654, 'Maypangdan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1655, 'Naghalin', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1656, 'Napuro', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1657, 'Nena', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1658, 'Nenita', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1659, 'Palanit', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1660, 'Palaroo', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1661, 'Palhi', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1662, 'Panalanoy', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1663, 'Patong', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1664, 'Pawing', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1665, 'Pinamopoan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1666, 'Plaridel', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1667, 'Polahongon', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1668, 'Polañge', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1669, 'Puerto Bello', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1670, 'Quinapundan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1671, 'San Eduardo', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1672, 'San Policarpio', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1673, 'San Sebastian', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1674, 'Santa Paz', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1675, 'Siguinon', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1676, 'Silanga', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1677, 'Tabonoc', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1678, 'Tagbubungang Diot', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1679, 'Tinambacan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1680, 'Tucdao', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1681, 'Tugbong', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1682, 'Tutubigan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1683, 'Umaganhan', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1684, 'Valencia', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1685, 'Victoria', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1686, 'Viriato', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1687, 'Wright', 12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1688, 'Agoncillo', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1689, 'Alitagtag', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1690, 'Balayan', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1691, 'Batangas', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1692, 'Bauan', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1693, 'Calaca', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1694, 'Calatagan', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1695, 'Cuenca', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1696, 'Ibaan', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1697, 'Laurel', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1698, 'Lemery', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1699, 'Lian', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1700, 'Lipa', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1701, 'Lobo', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1702, 'Malvar', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1703, 'Mataasnakahoy', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1704, 'Nasugbu', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1705, 'Padre Garcia', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1706, 'Rosario', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1707, 'San Jose', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1708, 'Taal', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1709, 'Tanauan', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1710, 'Taysan', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1711, 'Tingloy', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1712, 'Tuy', 13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1713, 'Adtugan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1714, 'Aglayan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1715, 'Agusan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1716, 'Alae', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1717, 'Alanib', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1718, 'Anakan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1719, 'Ani-e', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1720, 'Aplaya', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1721, 'Aumbay', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1722, 'Bagakay', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1723, 'Baikingon', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1724, 'Balila', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1725, 'Balili', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1726, 'Bangahan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1727, 'Bantuanon', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1728, 'Binitinan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1729, 'Bolo Bolo', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1730, 'Boroon', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1731, 'Bugcaon', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1732, 'Bugo', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1733, 'Busdi', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1734, 'Cabanglasan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1735, 'Calabugao', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1736, 'Canayan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1737, 'Candiis', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1738, 'Caromatan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1739, 'Casisang', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1740, 'Cosina', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1741, 'Dagumba-an', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1742, 'Dalipuga', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1743, 'Dalirig', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1744, 'Dalorong', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1745, 'Dalwangan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1746, 'Damilag', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1747, 'Damulog', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1748, 'Dancagan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1749, 'Dimaluna', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1750, 'Dimayon', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1751, 'Dologon', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1752, 'Don Carlos', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1753, 'Dorsalanam', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1754, 'Dumalaguing', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1755, 'Gimampang', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1756, 'Guinisiliban', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1757, 'Halapitan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1758, 'Hinapalanan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1759, 'Igpit', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1760, 'Imbatug', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1761, 'Impalutao', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1762, 'Indulang', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1763, 'Inobulan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1764, 'Kabalantian', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1765, 'Kabulohan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1766, 'Kadingilan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1767, 'Kalanganan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1768, 'Kalilangan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1769, 'Kalugmanan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1770, 'Kibangay', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1771, 'Kibawe', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1772, 'Kibonsod', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1773, 'Kibureau', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1774, 'Kimanuit', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1775, 'Kimaya', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1776, 'Kisolon', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1777, 'Kitaotao', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1778, 'Kitobo', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1779, 'La Fortuna', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1780, 'La Roxas', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1781, 'Lagindingan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1782, 'Laguitas', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1783, 'Langcangan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1784, 'Lanipao', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1785, 'Lantapan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1786, 'Lapase', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1787, 'Lapining', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1788, 'Libona', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1789, 'Liboran', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1790, 'Limbaan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1791, 'Linabo', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1792, 'Lingating', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1793, 'Lingion', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1794, 'Little Baguio', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1795, 'Looc', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1796, 'Lumbayao', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1797, 'Lumbia', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1798, 'Lunao', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1799, 'Lurugan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1800, 'Maanas', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1801, 'Maglamin', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1802, 'Mailag', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1803, 'Malaybalay', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1804, 'Malinaw', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1805, 'Maluko', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1806, 'Mambatangan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1807, 'Mambayaan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1808, 'Mamungan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1809, 'Managok', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1810, 'Mananum', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1811, 'Mandangoa', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1812, 'Manolo Fortich', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1813, 'Mantampay', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1814, 'Maputi', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1815, 'Maramag', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1816, 'Maranding', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1817, 'Maria Cristina', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1818, 'Mariano', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1819, 'Mat-i', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1820, 'Matangad', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1821, 'Miaray', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1822, 'Minlagas', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1823, 'Molugan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1824, 'Moog', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1825, 'Nañgka', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1826, 'Napalitan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1827, 'Natalungan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1828, 'NIA Valencia', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1829, 'Pan-an', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1830, 'Panalo-on', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1831, 'Pangabuan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1832, 'Pantao-Ragat', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1833, 'Patrocinio', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1834, 'Pines', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1835, 'Pongol', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1836, 'Pontian', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1837, 'Punta Silum', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1838, 'Rebe', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1839, 'Salawagan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1840, 'Salimbalan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1841, 'Sampagar', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1842, 'San Martin', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1843, 'Sankanan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1844, 'Silae', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1845, 'Sinonoc', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1846, 'Sugbongkogon', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1847, 'Sumilao', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1848, 'Sumpong', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1849, 'Sungai', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1850, 'Tabid', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1851, 'Taboc', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1852, 'Tacub', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1853, 'Talakag', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1854, 'Taypano', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1855, 'Ticala-an', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1856, 'Tignapalan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1857, 'Tubigan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1858, 'Tudela', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1859, 'Tuod', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1860, 'Tupsan', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1861, 'Yumbing', 14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1862, 'Almeria', 16, 'Biliran', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1863, 'Biliran', 16, 'Biliran', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1864, 'Cabucgayan', 16, 'Biliran', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1865, 'Caibiran', 16, 'Biliran', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1866, 'Culaba', 16, 'Biliran', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1867, 'Kawayan', 16, 'Biliran', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1868, 'Maripipi', 16, 'Biliran', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1869, 'Naval', 16, 'Biliran', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1870, 'Anibongan', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1871, 'Babag', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1872, 'Balutakay', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1873, 'Bansalan', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1874, 'Bukid', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1875, 'Jose Abad Santos', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1876, 'Katipunan', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1877, 'La Libertad', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1878, 'La Union', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1879, 'Mabuhay', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1880, 'Magsaysay', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1881, 'Mahayag', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1882, 'New Baclayon', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1883, 'New Bohol', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1884, 'Pag-asa', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1885, 'San Ignacio', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1886, 'San Miguel', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1887, 'Tagum', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1888, 'Tubod', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1889, 'Wines', 17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1890, 'Amas', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1891, 'Bagontapay', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1892, 'Baguer', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1893, 'Baliton', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1894, 'Banawa', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1895, 'Bantogon', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1896, 'Barongis', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1897, 'Batasan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1898, 'Batutitik', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1899, 'Bau', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1900, 'Bayasong', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1901, 'Bialong', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1902, 'Buadtasan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1903, 'Bual', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1904, 'Buayan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1905, 'Bulatukan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1906, 'Cebuano', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1907, 'City of Kidapawan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1908, 'City of Koronadal', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1909, 'City of Tacurong', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1910, 'Colongolo', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1911, 'Daliao', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1912, 'Damawato', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1913, 'Dualing', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1914, 'Dunguan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1915, 'Glad', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1916, 'Glamang', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1917, 'Glan Peidu', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1918, 'Gocoton', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1919, 'Ilaya', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1920, 'Kabalen', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1921, 'Kablalan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1922, 'Kalaisan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1923, 'Kalamangog', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1924, 'Kamanga', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1925, 'Kapatan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1926, 'Katubao', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1927, 'Kisante', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1928, 'Kiupo', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1929, 'Klinan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1930, 'Kling', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1931, 'Kulaman', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1932, 'Labu-o', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1933, 'Lambontong', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1934, 'Lamian', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1935, 'Lampitak', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1936, 'Liliongan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1937, 'Limbalod', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1938, 'Limulan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1939, 'Linao', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1940, 'Lumatil', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1941, 'Lumazal', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1942, 'Lumuyon', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1943, 'Lun Pequeño', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1944, 'Lunen', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1945, 'M lang', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1946, 'Maan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1947, 'Mabay', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1948, 'Maguling', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1949, 'Malamote', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1950, 'Malapag', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1951, 'Malasila', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1952, 'Malbang', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1953, 'Malingao', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1954, 'Malisbeng', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1955, 'Malitubog', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1956, 'Manaulanan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1957, 'Manuangan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1958, 'Manuel Roxas', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1959, 'Marbel', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1960, 'Mariano Marcos', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1961, 'Minapan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1);
INSERT INTO `city` (`city_id`, `city_name`, `state_id`, `state_name`, `country_id`, `country_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1962, 'Mindupok', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1963, 'Nalus', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1964, 'New Cebu', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1965, 'New Iloilo', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1966, 'Noling', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1967, 'Osias', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1968, 'Paatan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1969, 'Pagangan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1970, 'Palkan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1971, 'Pangyan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1972, 'Patindeguen', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1973, 'Pedtad', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1974, 'Pimbalayan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1975, 'Puloypuloy', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1976, 'Punolu', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1977, 'Puricay', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1978, 'Ragandang', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1979, 'Rotunda', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1980, 'Saguing', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1981, 'Salimbao', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1982, 'Salunayan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1983, 'Sampao', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1984, 'Sañgay', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1985, 'Sapu Padidu', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1986, 'Sebu', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1987, 'Silway 7', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1988, 'Sinolon', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1989, 'Sulit', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1990, 'Suyan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1991, 'T boli', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1992, 'Taguisa', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1993, 'Taluya', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1994, 'Tambilil', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1995, 'Tañgo', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1996, 'Teresita', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1997, 'Tinoto', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1998, 'Tomado', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(1999, 'Tran', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2000, 'Tuyan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2001, 'Upper Klinan', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2002, 'Upper San Mateo', 18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2003, 'Agay', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2004, 'Amaga', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2005, 'Anticala', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2006, 'Aras-asan', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2007, 'Bah-Bah', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2008, 'Balangbalang', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2009, 'Bancasi', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2010, 'Bangonay', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2011, 'Basa', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2012, 'Bayabas', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2013, 'Bayugan', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2014, 'Bigaan', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2015, 'Binucayan', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2016, 'Butuan', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2017, 'Caloc-an', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2018, 'Cantapoy', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2019, 'Capalayan', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2020, 'Causwagan', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2021, 'City of Cabadbaran', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2022, 'Comagascas', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2023, 'Cuevas', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2024, 'Culit', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2025, 'Dakbayan sa Bislig', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2026, 'Gamut', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2027, 'Guinabsan', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2028, 'Ipil', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2029, 'Jagupit', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2030, 'Kinabhangan', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2031, 'Lapinigan', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2032, 'Las Nieves', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2033, 'Los Angeles', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2034, 'Los Arcos', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2035, 'Loyola', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2036, 'Mabahin', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2037, 'Mabua', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2038, 'Manapa', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2039, 'Matabao', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2040, 'Maygatasan', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2041, 'Panikian', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2042, 'Patin-ay', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2043, 'Punta', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2044, 'Sanghan', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2045, 'Sinubong', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2046, 'Socorro', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2047, 'Tagcatong', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2048, 'Talacogon', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2049, 'Taligaman', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2050, 'Tidman', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2051, 'Tigao', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2052, 'Trento', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2053, 'Unidad', 19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2054, 'Bacolod Grande', 20, 'Cagayan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2055, 'Cagayan de Tawi-Tawi', 20, 'Cagayan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2056, 'Lumba-a-Bayabao', 20, 'Cagayan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2057, 'Marunggas', 20, 'Cagayan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2058, 'Molundo', 20, 'Cagayan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2059, 'Municipality of Indanan', 20, 'Cagayan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2060, 'Municipality of Lantawan', 20, 'Cagayan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2061, 'Municipality of Pangutaran', 20, 'Cagayan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2062, 'Municipality of Sultan Gumander', 20, 'Cagayan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2063, 'Municipality of Tongkil', 20, 'Cagayan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2064, 'New Panamao', 20, 'Cagayan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2065, 'Old Panamao', 20, 'Cagayan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2066, 'Pata', 20, 'Cagayan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2067, 'Poon-a-Bayabao', 20, 'Cagayan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2068, 'Sultan Sumagka', 20, 'Cagayan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2069, 'Abulug', 21, 'Cagayan Valley', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2070, 'Aggugaddah', 21, 'Cagayan Valley', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2071, 'Alibago', 21, 'Cagayan Valley', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2072, 'Batal', 21, 'Cagayan Valley', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2073, 'Buguey', 21, 'Cagayan Valley', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2074, 'Cabulay', 21, 'Cagayan Valley', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2075, 'Ibung', 21, 'Cagayan Valley', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2076, 'Iraga', 21, 'Cagayan Valley', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2077, 'Magapit', 21, 'Cagayan Valley', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2078, 'Magapit Aguiguican', 21, 'Cagayan Valley', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2079, 'Pilig', 21, 'Cagayan Valley', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2080, 'Tuguegarao', 21, 'Cagayan Valley', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2081, 'Ambuclao', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2082, 'Amlimay', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2083, 'Ampusungan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2084, 'Angad', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2085, 'Atok', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2086, 'Baculongan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2087, 'Baguinge', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2088, 'Baguio', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2089, 'Bakun', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2090, 'Bangao', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2091, 'Betwagan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2092, 'Bocos', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2093, 'Bokod', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2094, 'Bucloc', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2095, 'Buguias', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2096, 'Bulalacao', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2097, 'Butigui', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2098, 'Daguioman', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2099, 'Dalipey', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2100, 'Dalupirip', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2101, 'Gambang', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2102, 'Guinsadan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2103, 'Hapao', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2104, 'Itogon', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2105, 'Kabayan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2106, 'Kapangan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2107, 'Kibungan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2108, 'La Trinidad', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2109, 'Lacub', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2110, 'Langiden', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2111, 'Laya', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2112, 'Licuan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2113, 'Liwan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2114, 'Loacan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2115, 'Malibcong', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2116, 'Mankayan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2117, 'Monamon', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2118, 'Nangalisan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2119, 'Natubleng', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2120, 'Pidigan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2121, 'Potia', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2122, 'Sablan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2123, 'Sadsadan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2124, 'Sal-Lapadan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2125, 'Tabaan', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2126, 'Tacadang', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2127, 'Tayum', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2128, 'Tineg', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2129, 'Topdac', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2130, 'Tuba', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2131, 'Tublay', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2132, 'Tubo', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2133, 'Tuding', 23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2134, 'Baao', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2135, 'Balatan', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2136, 'Bato', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2137, 'Bombon', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2138, 'Buhi', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2139, 'Bula', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2140, 'Cabusao', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2141, 'Calabanga', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2142, 'Camaligan', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2143, 'Canaman', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2144, 'Caramoan', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2145, 'Del Gallego', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2146, 'Gainza', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2147, 'Garchitorena', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2148, 'Goa', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2149, 'Iriga City', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2150, 'Lagonoy', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2151, 'Libmanan', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2152, 'Lupi', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2153, 'Magarao', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2154, 'Milaor', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2155, 'Minalabac', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2156, 'Nabua', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2157, 'Naga', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2158, 'Ocampo', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2159, 'Pamplona', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2160, 'Pasacao', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2161, 'Pili', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2162, 'Presentacion', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2163, 'Ragay', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2164, 'Sagnay', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2165, 'San Fernando', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2166, 'Sipocot', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2167, 'Siruma', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2168, 'Tigaon', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2169, 'Tinambac', 24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2170, 'Catarman', 25, 'Camiguin', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2171, 'Guinsiliban', 25, 'Camiguin', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2172, 'Mahinog', 25, 'Camiguin', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2173, 'Mambajao', 25, 'Camiguin', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2174, 'Sagay', 25, 'Camiguin', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2175, 'Cuartero', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2176, 'Dao', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2177, 'Dumalag', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2178, 'Dumarao', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2179, 'Ivisan', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2180, 'Jamindan', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2181, 'Maayon', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2182, 'Mambusao', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2183, 'Panay', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2184, 'Panitan', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2185, 'Pilar', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2186, 'Pontevedra', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2187, 'President Roxas', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2188, 'Roxas City', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2189, 'Sapian', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2190, 'Sigma', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2191, 'Tapaz', 26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2192, 'Adlay', 27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2193, 'Basag', 27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2194, 'Bunawan', 27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2195, 'Cabadbaran', 27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2196, 'Del Carmen Surigao del Norte', 27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2197, 'Dinagat Islands', 27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2198, 'Jabonga', 27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2199, 'Kitcharao', 27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2200, 'Lombocan', 27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2201, 'Nasipit', 27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2202, 'Santa Josefa', 27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2203, 'Sibagat', 27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2204, 'Surigao', 27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2205, 'Tubay', 27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2206, 'Tungao', 27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2207, 'Veruela', 27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2208, 'Bagamanoc', 28, 'Catanduanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2209, 'Caramoran', 28, 'Catanduanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2210, 'Gigmoto', 28, 'Catanduanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2211, 'Panganiban', 28, 'Catanduanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2212, 'Viga', 28, 'Catanduanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2213, 'Virac', 28, 'Catanduanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2214, 'Alfonso', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2215, 'Amadeo', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2216, 'Bacoor', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2217, 'Carmona', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2218, 'Cavite City', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2219, 'Dasmariñas', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2220, 'General Emilio Aguinaldo', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2221, 'General Mariano Alvarez', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2222, 'General Trias', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2223, 'Imus', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2224, 'Indang', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2225, 'Kawit', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2226, 'Magallanes', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2227, 'Maragondon', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2228, 'Mendez', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2229, 'Naic', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2230, 'Noveleta', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2231, 'Silang', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2232, 'Tagaytay', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2233, 'Tanza', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2234, 'Ternate', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2235, 'Trece Martires', 29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2236, 'Alcantara', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2237, 'Alcoy', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2238, 'Aloguinsan', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2239, 'Argao', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2240, 'Asturias', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2241, 'Badian', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2242, 'Balamban', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2243, 'Bantayan', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2244, 'Barili', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2245, 'Bogo', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2246, 'Boljoon', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2247, 'Borbon', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2248, 'Carcar', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2249, 'Catmon', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2250, 'Cebu City', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2251, 'Compostela', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2252, 'Consolacion', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2253, 'Cordova', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2254, 'Daanbantayan', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2255, 'Dalaguete', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2256, 'Danao', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2257, 'Dumanjug', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2258, 'Ginatilan', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2259, 'Lapu-Lapu City', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2260, 'Liloan', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2261, 'Madridejos', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2262, 'Malabuyoc', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2263, 'Mandaue', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2264, 'Medellin', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2265, 'Minglanilla', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2266, 'Moalboal', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2267, 'Oslob', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2268, 'Pinamungajan', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2269, 'Poro', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2270, 'Ronda', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2271, 'Samboan', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2272, 'Santander', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2273, 'Sibonga', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2274, 'Sogod', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2275, 'Tabogon', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2276, 'Tabuelan', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2277, 'Toledo', 30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2278, 'Apayao', 33, 'Cordillera Administrative', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2279, 'Bangued', 33, 'Cordillera Administrative', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2280, 'Boliney', 33, 'Cordillera Administrative', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2281, 'Bucay', 33, 'Cordillera Administrative', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2282, 'Danglas', 33, 'Cordillera Administrative', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2283, 'Kalinga', 33, 'Cordillera Administrative', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2284, 'Lagangilang', 33, 'Cordillera Administrative', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2285, 'Lagayan', 33, 'Cordillera Administrative', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2286, 'Luba', 33, 'Cordillera Administrative', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2287, 'Manabo', 33, 'Cordillera Administrative', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2288, 'Mountain Province', 33, 'Cordillera Administrative', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2289, 'Peñarrubia', 33, 'Cordillera Administrative', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2290, 'Villaviciosa', 33, 'Cordillera Administrative', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2291, 'Alamada', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2292, 'Aleosan', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2293, 'Antipas', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2294, 'Arakan', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2295, 'Banisilan', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2296, 'Kabacan', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2297, 'Kadayangan', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2298, 'Kapalawan', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2299, 'Kidapawan', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2300, 'Libungan', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2301, 'Ligawasan', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2302, 'Magpet', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2303, 'Makilala', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2304, 'Malidegao', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2305, 'Matalam', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2306, 'Midsayap', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2307, 'Nabalawag', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2308, 'Old Kaabakan', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2309, 'Pigcawayan', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2310, 'Pikit', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2311, 'Tugunan', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2312, 'Tulunan', 34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2313, 'Alejal', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2314, 'Andili', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2315, 'Andop', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2316, 'Astorga', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2317, 'Baculin', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2318, 'Balagunan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2319, 'Balangonan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2320, 'Bantacan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2321, 'Baon', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2322, 'Baracatan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2323, 'Basiawan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2324, 'Batiano', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2325, 'Batobato', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2326, 'Baylo', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2327, 'Bincoñgan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2328, 'Bitaogan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2329, 'Bolila', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2330, 'Buclad', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2331, 'Buhangin', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2332, 'Bulacan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2333, 'Bungabon', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2334, 'Butulan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2335, 'Cabayangan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2336, 'Cabinuangan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2337, 'Caburan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2338, 'Cambanugoy', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2339, 'Camudmud', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2340, 'Compostela Valley', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2341, 'Corocotan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2342, 'Coronon', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2343, 'Cuambog', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2344, 'Culaman', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2345, 'Dacudao', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2346, 'Davan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2347, 'Davao', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2348, 'Dolo', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2349, 'Dumlan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2350, 'Gabuyan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2351, 'Goma', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2352, 'Guihing Proper', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2353, 'Gumalang', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2354, 'Gupitan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2355, 'Hiju Maco', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2356, 'Ignit', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2357, 'Ilangay', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2358, 'Inawayan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2359, 'Kalbay', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2360, 'Kalian', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2361, 'Kaligutan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2362, 'Kapalong', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2363, 'Kinablangan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2364, 'Kinamayan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2365, 'Kinangan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2366, 'Lacson', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2367, 'Lais', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2368, 'Lapuan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2369, 'Lasang', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2370, 'Libuganon', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2371, 'Limao', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2372, 'Limot', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2373, 'Linoan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2374, 'Lukatan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2375, 'Lungaog', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2376, 'Luzon', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2377, 'Maduao', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2378, 'Magatos', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2379, 'Magdug', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2380, 'Magnaga', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2381, 'Magugpo Poblacion', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2382, 'Mahanob', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2383, 'Malagos', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2384, 'Malita', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2385, 'Mambago', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2386, 'Managa', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2387, 'Manaloal', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2388, 'Manat', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2389, 'Mangili', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2390, 'Manikling', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2391, 'Matiao', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2392, 'Matti', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2393, 'Mayo', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2394, 'Nangan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2395, 'Nanyo', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2396, 'New Leyte', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2397, 'New Sibonga', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2398, 'New Visayas', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2399, 'Nuing', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2400, 'Pagsabangan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2401, 'Palma Gil', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2402, 'Pandasan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2403, 'Pangian', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2404, 'Pasian', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2405, 'Pondaguitan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2406, 'Pung-Pang', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2407, 'San Alfonso', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2408, 'Sarangani', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2409, 'Sigaboy', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2410, 'Simod', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2411, 'Sinawilan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2412, 'Sinayawan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2413, 'Sirib', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2414, 'Sugal', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2415, 'Surup', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2416, 'Suz-on', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2417, 'Tagakpan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2418, 'Tagdanua', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2419, 'Tagnanan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2420, 'Takub', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2421, 'Talagutong', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2422, 'Talomo', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2423, 'Tamayong', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2424, 'Tamisan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2425, 'Tamugan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2426, 'Tanlad', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2427, 'Tapia', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2428, 'Tawan tawan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2429, 'Tibagon', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2430, 'Tibanbang', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2431, 'Tiblawan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2432, 'Tombongon', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2433, 'Tubalan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2434, 'Tuban', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2435, 'Tuganay', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2436, 'Tuli', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2437, 'Ula', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2438, 'Wañgan', 35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2439, 'Laak', 36, 'Davao de Oro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2440, 'Maco', 36, 'Davao de Oro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2441, 'Maragusan', 36, 'Davao de Oro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2442, 'Mawab', 36, 'Davao de Oro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2443, 'Monkayo', 36, 'Davao de Oro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2444, 'Montevista', 36, 'Davao de Oro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2445, 'Nabunturan', 36, 'Davao de Oro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2446, 'New Bataan', 36, 'Davao de Oro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2447, 'Pantukan', 36, 'Davao de Oro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2448, 'Asuncion', 37, 'Davao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2449, 'Braulio E. Dujali', 37, 'Davao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2450, 'New Corella', 37, 'Davao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2451, 'Panabo', 37, 'Davao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2452, 'Samal', 37, 'Davao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2453, 'Talaingod', 37, 'Davao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1);
INSERT INTO `city` (`city_id`, `city_name`, `state_id`, `state_name`, `country_id`, `country_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(2454, 'Davao City', 38, 'Davao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2455, 'Digos', 38, 'Davao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2456, 'Hagonoy', 38, 'Davao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2457, 'Kiblawan', 38, 'Davao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2458, 'Malalag', 38, 'Davao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2459, 'Matanao', 38, 'Davao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2460, 'Padada', 38, 'Davao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2461, 'Sulop', 38, 'Davao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2462, 'Don Marcelino', 39, 'Davao Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2463, 'Baganga', 40, 'Davao Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2464, 'Banaybanay', 40, 'Davao Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2465, 'Boston', 40, 'Davao Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2466, 'Caraga', 40, 'Davao Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2467, 'Cateel', 40, 'Davao Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2468, 'Governor Generoso', 40, 'Davao Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2469, 'Lupon', 40, 'Davao Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2470, 'Manay', 40, 'Davao Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2471, 'Mati', 40, 'Davao Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2472, 'Tarragona', 40, 'Davao Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2473, 'Basilisa', 41, 'Dinagat Islands', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2474, 'Cagdianao', 41, 'Dinagat Islands', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2475, 'Dinagat', 41, 'Dinagat Islands', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2476, 'Libjo', 41, 'Dinagat Islands', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2477, 'Loreto', 41, 'Dinagat Islands', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2478, 'Tubajon', 41, 'Dinagat Islands', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2479, 'Arteche', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2480, 'Balangiga', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2481, 'Balangkayan', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2482, 'Borongan', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2483, 'Can-Avid', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2484, 'Dolores', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2485, 'General MacArthur', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2486, 'Giporlos', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2487, 'Guiuan', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2488, 'Hernani', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2489, 'Jipapad', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2490, 'Lawaan', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2491, 'Llorente', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2492, 'Maydolong', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2493, 'Oras', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2494, 'Quinapondan', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2495, 'Salcedo', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2496, 'San Julian', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2497, 'San Policarpo', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2498, 'Sulat', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2499, 'Taft', 42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2500, 'Calbayog', 43, 'Eastern Visayas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2501, 'Gubang', 43, 'Eastern Visayas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2502, 'Inangatan', 43, 'Eastern Visayas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2503, 'Lao', 43, 'Eastern Visayas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2504, 'Lubi', 43, 'Eastern Visayas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2505, 'Mahagnao', 43, 'Eastern Visayas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2506, 'Margen', 43, 'Eastern Visayas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2507, 'Pasay', 43, 'Eastern Visayas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2508, 'Pinangomhan', 43, 'Eastern Visayas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2509, 'Tabing', 43, 'Eastern Visayas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2510, 'Tibur', 43, 'Eastern Visayas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2511, 'Jordan', 44, 'Guimaras', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2512, 'Nueva Valencia', 44, 'Guimaras', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2513, 'Sibunag', 44, 'Guimaras', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2514, 'Aguinaldo', 45, 'Ifugao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2515, 'Alfonso Lista', 45, 'Ifugao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2516, 'Asipulo', 45, 'Ifugao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2517, 'Banaue', 45, 'Ifugao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2518, 'Hingyon', 45, 'Ifugao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2519, 'Hungduan', 45, 'Ifugao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2520, 'Kiangan', 45, 'Ifugao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2521, 'Lagawe', 45, 'Ifugao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2522, 'Lamut', 45, 'Ifugao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2523, 'Mayoyao', 45, 'Ifugao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2524, 'Tinoc', 45, 'Ifugao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2525, 'Acao', 46, 'Ilocos', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2526, 'Batac City', 46, 'Ilocos', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2527, 'Catablan', 46, 'Ilocos', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2528, 'Espiritu', 46, 'Ilocos', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2529, 'Paldit', 46, 'Ilocos', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2530, 'Tocok', 46, 'Ilocos', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2531, 'Adams', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2532, 'Bacarra', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2533, 'Badoc', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2534, 'Bangui', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2535, 'Banna', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2536, 'Batac', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2537, 'Burgos', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2538, 'Carasi', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2539, 'Currimao', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2540, 'Dingras', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2541, 'Dumalneg', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2542, 'Laoag', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2543, 'Marcos', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2544, 'Nueva Era', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2545, 'Pagudpud', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2546, 'Paoay', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2547, 'Pasuquin', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2548, 'Piddig', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2549, 'Pinili', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2550, 'Sarrat', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2551, 'Solsona', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2552, 'Vintar', 47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2553, 'Alilem', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2554, 'Banayoyo', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2555, 'Bantay', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2556, 'Candon', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2557, 'Caoayan', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2558, 'Galimuyod', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2559, 'Gregorio del Pilar', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2560, 'Lidlidda', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2561, 'Magsingal', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2562, 'Nagbukel', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2563, 'Narvacan', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2564, 'Quirino', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2565, 'San Emilio', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2566, 'San Esteban', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2567, 'San Ildefonso', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2568, 'Santa', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2569, 'Santa Catalina', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2570, 'Santa Lucia', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2571, 'Sigay', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2572, 'Sinait', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2573, 'Sugpon', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2574, 'Suyo', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2575, 'Tagudin', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2576, 'Vigan', 48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2577, 'Ajuy', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2578, 'Alimodian', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2579, 'Anilao', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2580, 'Badiangan', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2581, 'Balasan', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2582, 'Banate', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2583, 'Barotac Nuevo', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2584, 'Barotac Viejo', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2585, 'Batad', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2586, 'Bingawan', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2587, 'Cabatuan', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2588, 'Calinog', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2589, 'Carles', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2590, 'Dingle', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2591, 'Dueñas', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2592, 'Dumangas', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2593, 'Guimbal', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2594, 'Igbaras', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2595, 'Iloilo', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2596, 'Janiuay', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2597, 'Lambunao', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2598, 'Leganes', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2599, 'Leon', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2600, 'Miagao', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2601, 'Mina', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2602, 'New Lucena', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2603, 'Oton', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2604, 'Passi', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2605, 'Pavia', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2606, 'Pototan', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2607, 'San Dionisio', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2608, 'San Enrique', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2609, 'Santa Barbara', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2610, 'Sara', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2611, 'Tigbauan', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2612, 'Tubungan', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2613, 'Zarraga', 49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2614, 'Angadanan', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2615, 'Aurora', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2616, 'Benito Soliven', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2617, 'Cabagan', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2618, 'Cauayan', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2619, 'Cordon', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2620, 'Delfin Albano', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2621, 'Dinapigue', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2622, 'Divilacan', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2623, 'Echague', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2624, 'Gamu', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2625, 'Ilagan', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2626, 'Jones', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2627, 'Maconacon', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2628, 'Mallig', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2629, 'Ramon', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2630, 'Reina Mercedes', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2631, 'Roxas', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2632, 'San Guillermo', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2633, 'San Manuel', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2634, 'Santiago City', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2635, 'Tumauini', 50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2636, 'Balbalan', 51, 'Kalinga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2637, 'Lubuagan', 51, 'Kalinga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2638, 'Pinukpuk', 51, 'Kalinga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2639, 'Tabuk', 51, 'Kalinga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2640, 'Tanudan', 51, 'Kalinga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2641, 'Tinglayan', 51, 'Kalinga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2642, 'Agoo', 52, 'La Union', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2643, 'Aringay', 52, 'La Union', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2644, 'Bacnotan', 52, 'La Union', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2645, 'Bagulin', 52, 'La Union', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2646, 'Balaoan', 52, 'La Union', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2647, 'Bangar', 52, 'La Union', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2648, 'Bauang', 52, 'La Union', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2649, 'Caba', 52, 'La Union', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2650, 'Pugo', 52, 'La Union', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2651, 'San Gabriel', 52, 'La Union', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2652, 'Santol', 52, 'La Union', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2653, 'Sudipen', 52, 'La Union', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2654, 'Tubao', 52, 'La Union', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2655, 'Alaminos', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2656, 'Bay', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2657, 'Biñan', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2658, 'Cabuyao', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2659, 'Calamba', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2660, 'Calauan', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2661, 'Cavinti', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2662, 'Famy', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2663, 'Kalayaan', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2664, 'Liliw', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2665, 'Los Baños', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2666, 'Luisiana', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2667, 'Lumban', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2668, 'Majayjay', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2669, 'Nagcarlan', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2670, 'Paete', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2671, 'Pagsanjan', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2672, 'Pakil', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2673, 'Pangil', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2674, 'Pila', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2675, 'Santa Rosa', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2676, 'Siniloan', 53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2677, 'Baloi', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2678, 'Baroy', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2679, 'Iligan City', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2680, 'Kapatagan', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2681, 'Kauswagan', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2682, 'Kolambugan', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2683, 'Lala', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2684, 'Linamon', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2685, 'Maigo', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2686, 'Matungao', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2687, 'Munai', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2688, 'Nunungan', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2689, 'Pantao Ragat', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2690, 'Pantar', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2691, 'Poona Piagapo', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2692, 'Salvador', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2693, 'Sapad', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2694, 'Sultan Naga Dimaporo', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2695, 'Tagoloan', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2696, 'Tangcal', 54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2697, 'Amai Manabilang', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2698, 'Bacolod-Kalawi', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2699, 'Balabagan', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2700, 'Balindong', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2701, 'Bayang', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2702, 'Binidayan', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2703, 'Buadiposo-Buntong', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2704, 'Bubong', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2705, 'Butig', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2706, 'Calanogas', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2707, 'Ditsaan-Ramain', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2708, 'Ganassi', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2709, 'Kapai', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2710, 'Lumba-Bayabao', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2711, 'Lumbaca-Unayan', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2712, 'Lumbatan', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2713, 'Lumbayanague', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2714, 'Madalum', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2715, 'Madamba', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2716, 'Maguing', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2717, 'Malabang', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2718, 'Marantao', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2719, 'Marawi', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2720, 'Marogong', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2721, 'Masiu', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2722, 'Mulondo', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2723, 'Pagayawan', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2724, 'Piagapo', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2725, 'Picong', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2726, 'Poona Bayabao', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2727, 'Pualas', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2728, 'Saguiaran', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2729, 'Sultan Dumalondong', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2730, 'Tamparan', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2731, 'Taraka', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2732, 'Tubaran', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2733, 'Tugaya', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2734, 'Wao', 55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2735, 'Abuyog', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2736, 'Alangalang', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2737, 'Albuera', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2738, 'Babatngon', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2739, 'Barugo', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2740, 'Baybay', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2741, 'Burauen', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2742, 'Calubian', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2743, 'Capoocan', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2744, 'Carigara', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2745, 'Dagami', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2746, 'Dulag', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2747, 'Hilongos', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2748, 'Hindang', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2749, 'Inopacan', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2750, 'Isabel', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2751, 'Jaro', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2752, 'Javier', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2753, 'Julita', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2754, 'Kananga', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2755, 'Leyte', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2756, 'MacArthur', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2757, 'Mahaplag', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2758, 'Matag-ob', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2759, 'Matalom', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2760, 'Mayorga', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2761, 'Merida', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2762, 'Ormoc', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2763, 'Palo', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2764, 'Palompon', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2765, 'Pastrana', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2766, 'Tabango', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2767, 'Tabontabon', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2768, 'Tacloban', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2769, 'Tolosa', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2770, 'Tunga', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2771, 'Villaba', 56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2772, 'Barira', 57, 'Maguindanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2773, 'Buldon', 57, 'Maguindanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2774, 'Cotabato City', 57, 'Maguindanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2775, 'Datu Blah T. Sinsuat', 57, 'Maguindanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2776, 'Datu Odin Sinsuat', 57, 'Maguindanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2777, 'Kabuntalan', 57, 'Maguindanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2778, 'Matanog', 57, 'Maguindanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2779, 'Northern Kabuntalan', 57, 'Maguindanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2780, 'Parang', 57, 'Maguindanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2781, 'Sultan Kudarat', 57, 'Maguindanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2782, 'Sultan Mastura', 57, 'Maguindanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2783, 'Talitay', 57, 'Maguindanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2784, 'Upi', 57, 'Maguindanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2785, 'Ampatuan', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2786, 'Buluan', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2787, 'Datu Abdullah Sangki', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2788, 'Datu Anggal Midtimbang', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2789, 'Datu Hoffer Ampatuan', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2790, 'Datu Montawal', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2791, 'Datu Paglas', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2792, 'Datu Piang', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2793, 'Datu Salibo', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2794, 'Datu Saudi-Ampatuan', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2795, 'Datu Unsay', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2796, 'General Salipada K. Pendatun', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2797, 'Guindulungan', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2798, 'Mamasapano', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2799, 'Mangudadatu', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2800, 'Pagalungan', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2801, 'Paglat', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2802, 'Pandag', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2803, 'Rajah Buayan', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2804, 'Shariff Aguak', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2805, 'Shariff Saydona Mustapha', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2806, 'South Upi', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2807, 'Sultan sa Barongis', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2808, 'Talayan', 58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2809, 'Boac', 59, 'Marinduque', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2810, 'Gasan', 59, 'Marinduque', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2811, 'Mogpog', 59, 'Marinduque', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2812, 'Torrijos', 59, 'Marinduque', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2813, 'Aroroy', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2814, 'Baleno', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2815, 'Balud', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2816, 'Batuan', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2817, 'Cataingan', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2818, 'Cawayan', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2819, 'Claveria', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2820, 'Dimasalang', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2821, 'Mandaon', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2822, 'Masbate', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2823, 'Milagros', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2824, 'Mobo', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2825, 'Monreal', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2826, 'Palanas', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2827, 'Pio V. Corpus', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2828, 'Placer', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2829, 'San Jacinto', 60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2830, 'Aloran', 62, 'Misamis Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2831, 'Baliangao', 62, 'Misamis Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2832, 'Bonifacio', 62, 'Misamis Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2833, 'Clarin', 62, 'Misamis Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2834, 'Don Victoriano Chiongbian', 62, 'Misamis Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2835, 'Jimenez', 62, 'Misamis Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2836, 'Lopez Jaena', 62, 'Misamis Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2837, 'Oroquieta', 62, 'Misamis Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2838, 'Ozamiz City', 62, 'Misamis Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2839, 'Panaon', 62, 'Misamis Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2840, 'Sapang Dalaga', 62, 'Misamis Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2841, 'Sinacaban', 62, 'Misamis Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2842, 'Tangub', 62, 'Misamis Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2843, 'Alubijid', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2844, 'Balingasag', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2845, 'Balingoan', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2846, 'Binuangan', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2847, 'Cagayan de Oro', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2848, 'El Salvador', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2849, 'Gingoog', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2850, 'Gitagum', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2851, 'Initao', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2852, 'Jasaan', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2853, 'Kinoguitan', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2854, 'Lagonglong', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2855, 'Laguindingan', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2856, 'Lugait', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2857, 'Manticao', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2858, 'Medina', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2859, 'Naawan', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2860, 'Opol', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2861, 'Salay', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2862, 'Sugbongcogon', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2863, 'Talisayan', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2864, 'Villanueva', 63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2865, 'Barlig', 64, 'Mountain Province', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2866, 'Bauko', 64, 'Mountain Province', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2867, 'Besao', 64, 'Mountain Province', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2868, 'Bontoc', 64, 'Mountain Province', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2869, 'Natonin', 64, 'Mountain Province', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2870, 'Paracelis', 64, 'Mountain Province', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2871, 'Sabangan', 64, 'Mountain Province', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2872, 'Sadanga', 64, 'Mountain Province', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2873, 'Sagada', 64, 'Mountain Province', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2874, 'Tadian', 64, 'Mountain Province', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2875, 'Bago', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2876, 'Binalbagan', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2877, 'Cadiz', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2878, 'Calatrava', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2879, 'Candoni', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2880, 'Don Salvador Benedicto', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2881, 'Enrique B. Magalona', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2882, 'Escalante', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2883, 'Himamaylan', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2884, 'Hinigaran', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2885, 'Hinoba-an', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2886, 'Ilog', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2887, 'Kabankalan', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2888, 'La Carlota', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2889, 'La Castellana', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2890, 'Manapla', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2891, 'Moises Padilla', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2892, 'Murcia', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2893, 'Pulupandan', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2894, 'San Carlos', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2895, 'Silay', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2896, 'Sipalay', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2897, 'Toboso', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2898, 'Valladolid', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2899, 'Victorias', 66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2900, 'Amlan', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2901, 'Ayungon', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2902, 'Bacong', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2903, 'Bais', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2904, 'Basay', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2905, 'Bayawan', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2906, 'Bindoy', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2907, 'Canlaon', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2908, 'Dauin', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2909, 'Dumaguete', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2910, 'Guihulñgan', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2911, 'Jimalalud', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2912, 'Manjuyod', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2913, 'Siaton', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2914, 'Sibulan', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2915, 'Tanjay', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2916, 'Tayasan', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2917, 'Vallehermoso', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2918, 'Zamboanguita', 67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2919, 'Allen', 69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2920, 'Biri', 69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2921, 'Bobon', 69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2922, 'Capul', 69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2923, 'Catubig', 69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2924, 'Gamay', 69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2925, 'Laoang', 69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2926, 'Lapinig', 69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2927, 'Las Navas', 69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2928, 'Lavezares', 69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1);
INSERT INTO `city` (`city_id`, `city_name`, `state_id`, `state_name`, `country_id`, `country_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(2929, 'Lope de Vega', 69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2930, 'Mapanas', 69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2931, 'Mondragon', 69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2932, 'Palapag', 69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2933, 'Pambujan', 69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2934, 'Silvino Lobos', 69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2935, 'Aliaga', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2936, 'Bongabon', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2937, 'Cabanatuan', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2938, 'Cabiao', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2939, 'Carranglan', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2940, 'Cuyapo', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2941, 'Gabaldon', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2942, 'Gapan', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2943, 'General Mamerto Natividad', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2944, 'General Tinio', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2945, 'Guimba', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2946, 'Jaen', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2947, 'Laur', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2948, 'Licab', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2949, 'Llanera', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2950, 'Lupao', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2951, 'Muñoz', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2952, 'Nampicuan', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2953, 'Palayan', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2954, 'Pantabangan', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2955, 'Peñaranda', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2956, 'San Leonardo', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2957, 'Talavera', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2958, 'Talugtug', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2959, 'Zaragoza', 70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2960, 'Alfonso Castañeda', 71, 'Nueva Vizcaya', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2961, 'Ambaguio', 71, 'Nueva Vizcaya', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2962, 'Aritao', 71, 'Nueva Vizcaya', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2963, 'Bagabag', 71, 'Nueva Vizcaya', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2964, 'Bambang', 71, 'Nueva Vizcaya', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2965, 'Bayombong', 71, 'Nueva Vizcaya', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2966, 'Diadi', 71, 'Nueva Vizcaya', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2967, 'Dupax del Norte', 71, 'Nueva Vizcaya', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2968, 'Dupax del Sur', 71, 'Nueva Vizcaya', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2969, 'Kasibu', 71, 'Nueva Vizcaya', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2970, 'Kayapa', 71, 'Nueva Vizcaya', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2971, 'Solano', 71, 'Nueva Vizcaya', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2972, 'Villaverde', 71, 'Nueva Vizcaya', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2973, 'Abuyon', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2974, 'Aga', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2975, 'Aliang', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2976, 'Alupay', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2977, 'Aya', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2978, 'Ayusan Uno', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2979, 'Bagalangit', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2980, 'Bagombong', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2981, 'Bagong Pagasa', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2982, 'Bagupaye', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2983, 'Balagtasin', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2984, 'Balele', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2985, 'Balibago', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2986, 'Balite Segundo', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2987, 'Balitoc', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2988, 'Banaba', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2989, 'Banalo', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2990, 'Bantilan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2991, 'Banugao', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2992, 'Batas', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2993, 'Bautista', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2994, 'Baybayin', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2995, 'Bignay Uno', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2996, 'Bilaran', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2997, 'Bilog-Bilog', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2998, 'Binahaan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2999, 'Binay', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3000, 'Binubusan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3001, 'Binulasan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3002, 'Bitangan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3003, 'Bitin', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3004, 'Bolboc', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3005, 'Boot', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3006, 'Bosdak', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3007, 'Bugaan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3008, 'Bukal', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3009, 'Bukal Sur', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3010, 'Bulacnin', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3011, 'Bungahan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3012, 'Bungoy', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3013, 'Cabatang', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3014, 'Cagsiay', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3015, 'Calilayan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3016, 'Calubcub Dos', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3017, 'Cambuga', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3018, 'Camohaguin', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3019, 'Camp Flora', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3020, 'Capuluan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3021, 'Castañas', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3022, 'Casuguran', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3023, 'Cigaras', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3024, 'Concepcion Ibaba', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3025, 'Dagatan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3026, 'Daraitan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3027, 'Dayap', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3028, 'Dayapan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3029, 'Del Monte', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3030, 'Dinahican', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3031, 'Guinayangan Fourth District of Quezon', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3032, 'Gulod', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3033, 'Gumian', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3034, 'Guyam Malaki', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3035, 'Halayhay', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3036, 'Halayhayin', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3037, 'Haligue', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3038, 'Hondagua', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3039, 'Hukay', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3040, 'Ibabang Tayuman', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3041, 'Inicbulan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3042, 'Isabang', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3043, 'Janagdong', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3044, 'Janopol', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3045, 'Javalera', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3046, 'Kabulusan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3047, 'Kanluran', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3048, 'Kapatalan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3049, 'Karligan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3050, 'Kaytitinga', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3051, 'Kiloloran', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3052, 'Kinalaglagan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3053, 'Kinatakutan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3054, 'Lacdayan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3055, 'Laiya', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3056, 'Lalig', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3057, 'Lapolapo', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3058, 'Libato', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3059, 'Lilio', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3060, 'Lipa City', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3061, 'Lipahan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3062, 'Lucsuhin', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3063, 'Luksuhin', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3064, 'Lumbang', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3065, 'Lumbangan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3066, 'Lumil', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3067, 'Luntal', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3068, 'Lusacan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3069, 'Mabitac', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3070, 'Mabunga', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3071, 'Macalamcam A', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3072, 'Madulao', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3073, 'Maguyam', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3074, 'Mahabang Parang', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3075, 'Mainit Norte', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3076, 'Malabag', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3077, 'Malabanan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3078, 'Malabanban Norte', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3079, 'Malainen Luma', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3080, 'Malanday', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3081, 'Malaruhatan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3082, 'Malaya', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3083, 'Malicboy', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3084, 'Malinao Ilaya', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3085, 'Mamala', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3086, 'Mamatid', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3087, 'Mangas', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3088, 'Mangero', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3089, 'Manggahan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3090, 'Mapulo', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3091, 'Mapulot', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3092, 'Marao', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3093, 'Masalukot Uno', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3094, 'Masapang', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3095, 'Masaya', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3096, 'Mataas Na Kahoy', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3097, 'Matagbak', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3098, 'Matala', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3099, 'Mataywanac', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3100, 'Matingain', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3101, 'Maugat West', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3102, 'Maulawin', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3103, 'Mendez-Nuñez', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3104, 'Montecillo', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3105, 'Mozon', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3106, 'Mulauin', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3107, 'Navotas', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3108, 'Paagahan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3109, 'Pagsañgahan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3110, 'Paiisa', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3111, 'Palahanan Uno', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3112, 'Palangue', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3113, 'Pangao', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3114, 'Panikihan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3115, 'Pansol', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3116, 'Pansoy', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3117, 'Pantay Na Matanda', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3118, 'Pantijan No 2', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3119, 'Paradahan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3120, 'Pasong Kawayan Primero', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3121, 'Patabog', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3122, 'Patuto', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3123, 'Payapa', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3124, 'Pinagsibaan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3125, 'Pinugay', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3126, 'Poctol', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3127, 'Prinza', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3128, 'Progreso', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3129, 'Pulangbato', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3130, 'Pulong Santa Cruz', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3131, 'Puting Kahoy', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3132, 'Putol', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3133, 'Quilo-quilo', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3134, 'Quisao', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3135, 'Sampiro', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3136, 'San Celestio', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3137, 'San Diego', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3138, 'San Gregorio', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3139, 'San Pedro One', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3140, 'Santa Catalina Norte', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3141, 'Santa Catalina Sur', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3142, 'Santa Cecilia', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3143, 'Santa Rita Aplaya', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3144, 'Santisimo Rosario', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3145, 'Santor', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3146, 'Sico Uno', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3147, 'Silongin', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3148, 'Sinala', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3149, 'Sinisian', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3150, 'Solo', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3151, 'Tagbacan Ibaba', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3152, 'Tagkawayan Sabang', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3153, 'Tala', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3154, 'Talahib Payap', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3155, 'Talahiban I', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3156, 'Talaibon', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3157, 'Talipan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3158, 'Tayabas Ibaba', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3159, 'Taywanak Ilaya', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3160, 'Tignoan', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3161, 'Tipaz', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3162, 'Toong', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3163, 'Tranca', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3164, 'Tuhian', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3165, 'Tulay', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3166, 'Tumalim', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3167, 'Wawa', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3168, 'Yuni', 72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3169, 'Abra de Ilog', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3170, 'Adela', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3171, 'Agcogon', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3172, 'Alad', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3173, 'Alemanguan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3174, 'Algeciras', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3175, 'Alibug', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3176, 'Apitong', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3177, 'Apurawan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3178, 'Aramawayan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3179, 'Aramayuan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3180, 'Babug', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3181, 'Baco', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3182, 'Bacungan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3183, 'Bagong Sikat', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3184, 'Baheli', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3185, 'Balanacan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3186, 'Balatero', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3187, 'Balugo', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3188, 'Banos', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3189, 'Bansud', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3190, 'Barahan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3191, 'Barong Barong', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3192, 'Batarasa', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3193, 'Bayuin', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3194, 'Bintacay', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3195, 'Bunog', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3196, 'Burirao', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3197, 'Buyabod', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3198, 'Cabacao', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3199, 'Cabra', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3200, 'Cagayan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3201, 'Caigangan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3202, 'Cajimos', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3203, 'Calamundingan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3204, 'Calapan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3205, 'Calatugas', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3206, 'Calintaan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3207, 'Caminauit', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3208, 'Cantel', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3209, 'Canubing No 2', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3210, 'Caramay', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3211, 'Caruray', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3212, 'Casian', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3213, 'Conduaga', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3214, 'Dapawan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3215, 'Daykitin', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3216, 'Dobdoban', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3217, 'Eraan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3218, 'España', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3219, 'Evangelista', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3220, 'Gabawan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3221, 'Gloria', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3222, 'Guinlo', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3223, 'Harrison', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3224, 'Ipilan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3225, 'Irahuan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3226, 'Iraray', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3227, 'Irirum', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3228, 'Isugod', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3229, 'La Curva', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3230, 'Labasan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3231, 'Labog', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3232, 'Laylay', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3233, 'Leuteboro', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3234, 'Limanancong', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3235, 'Lubang', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3236, 'Lumangbayan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3237, 'Magbay', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3238, 'Malamig', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3239, 'Malibago', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3240, 'Maliig', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3241, 'Malitbog', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3242, 'Maluanluan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3243, 'Mamburao', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3244, 'Manaul', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3245, 'Mangarine', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3246, 'Mansalay', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3247, 'Masaguisi', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3248, 'Masiga', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3249, 'Mauhao', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3250, 'Nagiba', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3251, 'Naujan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3252, 'New Agutaya', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3253, 'Odala', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3254, 'Paclolo', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3255, 'Paluan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3256, 'Pambisan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3257, 'Panacan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3258, 'Panalingaan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3259, 'Pancol', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3260, 'Pañgobilian', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3261, 'Pangulayan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3262, 'Panique', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3263, 'Panitian', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3264, 'Panlaitan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3265, 'Pato-o', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3266, 'Pinagsabangan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3267, 'Pinamalayan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3268, 'Pola', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3269, 'Port Barton', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3270, 'Puerto Galera', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3271, 'Punang', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3272, 'Quinabigan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3273, 'Ransang', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3274, 'Rio Tuba', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3275, 'Saaban', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3276, 'Sablayan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3277, 'San Aquilino', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3278, 'San Teodoro', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3279, 'Santa Brigida', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3280, 'Saraza', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3281, 'Suba', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3282, 'Sumagui', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3283, 'Tabinay', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3284, 'Tacligan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3285, 'Taclobo', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3286, 'Tagbak', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3287, 'Tagbita', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3288, 'Tagburos', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3289, 'Tagusao', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3290, 'Tambong', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3291, 'Tampayan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3292, 'Tangal', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3293, 'Tarusan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3294, 'Tayaman', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3295, 'Tigui', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3296, 'Tiguion', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3297, 'Tiguisan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3298, 'Tilik', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3299, 'Tiniguiban', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3300, 'Tomingad', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3301, 'Tugdan', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3302, 'Tumarbong', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3303, 'Vigo', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3304, 'Yook', 73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3305, 'Aborlan', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3306, 'Agutaya', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3307, 'Araceli', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3308, 'Balabac', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3309, 'Bataraza', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3310, 'Brookes Point', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3311, 'Busuanga', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3312, 'Cagayancillo', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3313, 'Coron', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3314, 'Culion', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3315, 'Cuyo', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3316, 'Dumaran', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3317, 'El Nido', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3318, 'Linapacan', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3319, 'Narra', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3320, 'Puerto Princesa', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3321, 'Sofronio Española', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3322, 'Taytay', 74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3323, 'Angeles City', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3324, 'Apalit', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3325, 'Arayat', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3326, 'Bacolor', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3327, 'Candaba', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3328, 'Floridablanca', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3329, 'Guagua', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3330, 'Lubao', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3331, 'Mabalacat', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3332, 'Macabebe', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3333, 'Magalang', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3334, 'Masantol', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3335, 'Mexico', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3336, 'Minalin', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3337, 'Porac', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3338, 'San Simon', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3339, 'Sasmuan', 75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3340, 'Agno', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3341, 'Aguilar', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3342, 'Alcala', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3343, 'Anda', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3344, 'Asingan', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3345, 'Balungao', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3346, 'Bani', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3347, 'Basista', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3348, 'Bayambang', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3349, 'Binalonan', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3350, 'Binmaley', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3351, 'Bolinao', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3352, 'Bugallon', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3353, 'Calasiao', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3354, 'Dagupan', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3355, 'Dasol', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3356, 'Infanta', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3357, 'Labrador', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3358, 'Laoac', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3359, 'Lingayen', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3360, 'Malasiqui', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3361, 'Manaoag', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3362, 'Mangaldan', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3363, 'Mangatarem', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3364, 'Mapandan', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3365, 'Natividad', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3366, 'Pozorrubio', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3367, 'Rosales', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3368, 'San Fabian', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3369, 'Sison', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3370, 'Sual', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3371, 'Tayug', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3372, 'Umingan', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3373, 'Urbiztondo', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3374, 'Urdaneta', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3375, 'Villasis', 76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3376, 'Agdangan', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3377, 'Alabat', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3378, 'Atimonan', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3379, 'Burdeos', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3380, 'Calauag', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3381, 'Candelaria', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3382, 'Catanauan', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3383, 'General Luna', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3384, 'General Nakar', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3385, 'Guinayangan', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3386, 'Gumaca', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3387, 'Jomalig', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3388, 'Lopez', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1);
INSERT INTO `city` (`city_id`, `city_name`, `state_id`, `state_name`, `country_id`, `country_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(3389, 'Lucban', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3390, 'Lucena', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3391, 'Macalelon', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3392, 'Mauban', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3393, 'Mulanay', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3394, 'Padre Burgos', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3395, 'Pagbilao', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3396, 'Panukulan', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3397, 'Patnanungan', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3398, 'Perez', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3399, 'Pitogo', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3400, 'Polillo', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3401, 'Real', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3402, 'Sampaloc', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3403, 'San Narciso', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3404, 'Sariaya', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3405, 'Tagkawayan', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3406, 'Tayabas', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3407, 'Tiaong', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3408, 'Unisan', 77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3409, 'Aglipay', 78, 'Quirino', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3410, 'Cabarroguis', 78, 'Quirino', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3411, 'Diffun', 78, 'Quirino', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3412, 'Maddela', 78, 'Quirino', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3413, 'Nagtipunan', 78, 'Quirino', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3414, 'Saguday', 78, 'Quirino', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3415, 'Angono', 79, 'Rizal', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3416, 'Antipolo', 79, 'Rizal', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3417, 'Binangonan', 79, 'Rizal', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3418, 'Cainta', 79, 'Rizal', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3419, 'Cardona', 79, 'Rizal', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3420, 'Jalajala', 79, 'Rizal', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3421, 'Morong', 79, 'Rizal', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3422, 'Pililla', 79, 'Rizal', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3423, 'Rodriguez', 79, 'Rizal', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3424, 'Tanay', 79, 'Rizal', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3425, 'Teresa', 79, 'Rizal', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3426, 'Banton', 80, 'Romblon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3427, 'Cajidiocan', 80, 'Romblon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3428, 'Corcuera', 80, 'Romblon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3429, 'Ferrol', 80, 'Romblon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3430, 'Magdiwang', 80, 'Romblon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3431, 'Odiongan', 80, 'Romblon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3432, 'Romblon', 80, 'Romblon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3433, 'Alabel', 81, 'Sarangani', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3434, 'Glan', 81, 'Sarangani', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3435, 'Kiamba', 81, 'Sarangani', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3436, 'Maasim', 81, 'Sarangani', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3437, 'Maitum', 81, 'Sarangani', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3438, 'Malapatan', 81, 'Sarangani', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3439, 'Malungon', 81, 'Sarangani', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3440, 'Enrique Villanueva', 82, 'Siquijor', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3441, 'Larena', 82, 'Siquijor', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3442, 'Lazi', 82, 'Siquijor', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3443, 'Maria', 82, 'Siquijor', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3444, 'Siquijor', 82, 'Siquijor', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3445, 'Biwang', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3446, 'Blingkong', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3447, 'Buawan', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3448, 'Bukay Pait', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3449, 'Busok', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3450, 'Carpenter Hill', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3451, 'Colongulo', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3452, 'Columbio', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3453, 'Conel', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3454, 'Daguma', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3455, 'Dansuli', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3456, 'Digkilaan', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3457, 'Dukay', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3458, 'Dumaguil', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3459, 'Gansing', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3460, 'Guinsang-an', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3461, 'Kalandagan', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3462, 'Kapaya', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3463, 'Kapingkong', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3464, 'Katangawan', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3465, 'Kipalbig', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3466, 'Kolumbug', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3467, 'Kudanding', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3468, 'Laguilayan', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3469, 'Lamba', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3470, 'Lampari', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3471, 'Lapuz', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3472, 'Linan', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3473, 'Maindang', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3474, 'Malandag', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3475, 'Maltana', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3476, 'Maluñgun', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3477, 'Mamali', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3478, 'Matiompong', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3479, 'New Lagao', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3480, 'New Panay', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3481, 'Nunguan', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3482, 'Palian', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3483, 'Pamantingan', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3484, 'Rogongon', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3485, 'Rotonda', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3486, 'Sadsalan', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3487, 'Sangay', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3488, 'Tambak', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3489, 'Tamnag', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3490, 'Tamontaka', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3491, 'Telafas', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3492, 'Tinagacan', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3493, 'Tuka', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3494, 'Villamor', 83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3495, 'Barcelona', 84, 'Sorsogon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3496, 'Bulan', 84, 'Sorsogon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3497, 'Bulusan', 84, 'Sorsogon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3498, 'Castilla', 84, 'Sorsogon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3499, 'Donsol', 84, 'Sorsogon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3500, 'Gubat', 84, 'Sorsogon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3501, 'Irosin', 84, 'Sorsogon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3502, 'Juban', 84, 'Sorsogon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3503, 'Matnog', 84, 'Sorsogon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3504, 'Prieto Diaz', 84, 'Sorsogon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3505, 'Santa Magdalena', 84, 'Sorsogon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3506, 'Sorsogon', 84, 'Sorsogon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3507, 'General Santos', 85, 'South Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3508, 'Koronadal', 85, 'South Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3509, 'Lake Sebu', 85, 'South Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3510, 'Norala', 85, 'South Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3511, 'Polomolok', 85, 'South Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3512, 'Surallah', 85, 'South Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3513, 'Tampakan', 85, 'South Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3514, 'Tantangan', 85, 'South Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3515, 'Tupi', 85, 'South Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3516, 'Anahawan', 86, 'Southern Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3517, 'Hinunangan', 86, 'Southern Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3518, 'Hinundayan', 86, 'Southern Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3519, 'Libagon', 86, 'Southern Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3520, 'Limasawa', 86, 'Southern Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3521, 'Macrohon', 86, 'Southern Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3522, 'Pintuyan', 86, 'Southern Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3523, 'Saint Bernard', 86, 'Southern Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3524, 'San Ricardo', 86, 'Southern Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3525, 'Silago', 86, 'Southern Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3526, 'Tomas Oppus', 86, 'Southern Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3527, 'Isulan', 87, 'Sultan Kudarat', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3528, 'Kalamansig', 87, 'Sultan Kudarat', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3529, 'Lambayong', 87, 'Sultan Kudarat', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3530, 'Lebak', 87, 'Sultan Kudarat', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3531, 'Lutayan', 87, 'Sultan Kudarat', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3532, 'Palimbang', 87, 'Sultan Kudarat', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3533, 'President Quirino', 87, 'Sultan Kudarat', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3534, 'Senator Ninoy Aquino', 87, 'Sultan Kudarat', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3535, 'Tacurong', 87, 'Sultan Kudarat', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3536, 'Banguingui', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3537, 'Hadji Panglima Tahil', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3538, 'Indanan', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3539, 'Jolo', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3540, 'Kalingalan Caluang', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3541, 'Lugus', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3542, 'Luuk', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3543, 'Maimbung', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3544, 'Omar', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3545, 'Panamao', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3546, 'Pandami', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3547, 'Panglima Estino', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3548, 'Pangutaran', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3549, 'Patikul', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3550, 'Siasi', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3551, 'Talipao', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3552, 'Tapul', 88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3553, 'Bacuag', 89, 'Surigao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3554, 'Claver', 89, 'Surigao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3555, 'Dapa', 89, 'Surigao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3556, 'Del Carmen', 89, 'Surigao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3557, 'Gigaquit', 89, 'Surigao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3558, 'Mainit', 89, 'Surigao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3559, 'Malimono', 89, 'Surigao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3560, 'San Benito', 89, 'Surigao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3561, 'Surigao City', 89, 'Surigao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3562, 'Tagana-an', 89, 'Surigao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3563, 'Barobo', 90, 'Surigao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3564, 'Bislig', 90, 'Surigao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3565, 'Cagwait', 90, 'Surigao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3566, 'Cantilan', 90, 'Surigao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3567, 'Carrascal', 90, 'Surigao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3568, 'Cortes', 90, 'Surigao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3569, 'Hinatuan', 90, 'Surigao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3570, 'Lanuza', 90, 'Surigao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3571, 'Lianga', 90, 'Surigao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3572, 'Lingig', 90, 'Surigao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3573, 'Madrid', 90, 'Surigao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3574, 'Marihatag', 90, 'Surigao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3575, 'Tagbina', 90, 'Surigao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3576, 'Tago', 90, 'Surigao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3577, 'Tandag', 90, 'Surigao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3578, 'Anao', 91, 'Tarlac', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3579, 'Bamban', 91, 'Tarlac', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3580, 'Camiling', 91, 'Tarlac', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3581, 'Capas', 91, 'Tarlac', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3582, 'Gerona', 91, 'Tarlac', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3583, 'Mayantoc', 91, 'Tarlac', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3584, 'Moncada', 91, 'Tarlac', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3585, 'Paniqui', 91, 'Tarlac', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3586, 'Pura', 91, 'Tarlac', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3587, 'Ramos', 91, 'Tarlac', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3588, 'San Clemente', 91, 'Tarlac', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3589, 'Santa Ignacia', 91, 'Tarlac', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3590, 'Tarlac City', 91, 'Tarlac', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3591, 'Bongao', 92, 'Tawi-Tawi', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3592, 'Languyan', 92, 'Tawi-Tawi', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3593, 'Mapun', 92, 'Tawi-Tawi', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3594, 'Panglima Sugala', 92, 'Tawi-Tawi', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3595, 'Sapa-Sapa', 92, 'Tawi-Tawi', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3596, 'Sibutu', 92, 'Tawi-Tawi', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3597, 'Simunul', 92, 'Tawi-Tawi', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3598, 'Sitangkai', 92, 'Tawi-Tawi', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3599, 'South Ubian', 92, 'Tawi-Tawi', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3600, 'Tandubas', 92, 'Tawi-Tawi', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3601, 'Turtle Islands', 92, 'Tawi-Tawi', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3602, 'Almagro', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3603, 'Basey', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3604, 'Calbayog City', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3605, 'Calbiga', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3606, 'Catbalogan', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3607, 'Daram', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3608, 'Gandara', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3609, 'Hinabangan', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3610, 'Jiabong', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3611, 'Marabut', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3612, 'Matuguinao', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3613, 'Motiong', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3614, 'Pagsanghan', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3615, 'Paranas', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3616, 'Pinabacdao', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3617, 'San Jorge', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3618, 'San Jose de Buan', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3619, 'Santa Margarita', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3620, 'Tagapul-an', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3621, 'Talalora', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3622, 'Tarangnan', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3623, 'Villareal', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3624, 'Zumarraga', 93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3625, 'Botolan', 95, 'Zambales', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3626, 'Cabangan', 95, 'Zambales', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3627, 'Castillejos', 95, 'Zambales', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3628, 'Iba', 95, 'Zambales', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3629, 'Masinloc', 95, 'Zambales', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3630, 'Olongapo', 95, 'Zambales', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3631, 'Palauig', 95, 'Zambales', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3632, 'San Felipe', 95, 'Zambales', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3633, 'San Marcelino', 95, 'Zambales', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3634, 'Subic', 95, 'Zambales', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3635, 'Baliguian', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3636, 'Dapitan', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3637, 'Dipolog', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3638, 'Godod', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3639, 'Gutalac', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3640, 'Jose Dalman', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3641, 'Kalawit', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3642, 'Labason', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3643, 'Leon B. Postigo', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3644, 'Liloy', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3645, 'Manukan', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3646, 'Mutia', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3647, 'Piñan', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3648, 'Polanco', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3649, 'President Manuel A. Roxas', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3650, 'Salug', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3651, 'Sergio Osmeña Sr.', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3652, 'Siayan', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3653, 'Sibuco', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3654, 'Sibutad', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3655, 'Sindangan', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3656, 'Siocon', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3657, 'Sirawai', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3658, 'Tampilisan', 96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3659, 'Bayog', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3660, 'Dimataling', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3661, 'Dinas', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3662, 'Dumalinao', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3663, 'Dumingag', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3664, 'Guipos', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3665, 'Josefina', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3666, 'Kumalarang', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3667, 'Labangan', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3668, 'Lakewood', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3669, 'Lapuyan', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3670, 'Margosatubig', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3671, 'Midsalip', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3672, 'Molave', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3673, 'Pagadian', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3674, 'Ramon Magsaysay', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3675, 'Sominot', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3676, 'Tabina', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3677, 'Tambulig', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3678, 'Tigbao', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3679, 'Tukuran', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3680, 'Vincenzo A. Sagun', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3681, 'Zamboanga', 97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3682, 'Balagon', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3683, 'Batu', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3684, 'Binuatan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3685, 'Bunguiao', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3686, 'Buug', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3687, 'Cabaluay', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3688, 'Calabasa', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3689, 'Caracal', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3690, 'Culianan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3691, 'Curuan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3692, 'Dalangin', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3693, 'Danlugan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3694, 'Dawa-Dawa', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3695, 'Dicayong', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3696, 'Diplahan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3697, 'Dipolo', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3698, 'Disod', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3699, 'Dulian', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3700, 'East Migpulao', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3701, 'Ganyangan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3702, 'Gubaan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3703, 'Guiniculalay', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3704, 'Irasan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3705, 'Kagawasan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3706, 'Kipit', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3707, 'La Dicha', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3708, 'Labuan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3709, 'Lamisahan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3710, 'Landang Laum', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3711, 'Langatian', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3712, 'Laparay', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3713, 'Legrada', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3714, 'Leon Postigo', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3715, 'Limaong', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3716, 'Limpapa', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3717, 'Linay', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3718, 'Lingasan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3719, 'Lintangan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3720, 'Lumbayan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3721, 'Lumbog', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3722, 'Malangas', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3723, 'Malayal', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3724, 'Malim', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3725, 'Mandih', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3726, 'Mangusu', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3727, 'Manicahan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3728, 'Margos', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3729, 'Monching', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3730, 'Muricay', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3731, 'Muti', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3732, 'Olingan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3733, 'Olutanga', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3734, 'Palomoc', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3735, 'Panubigan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3736, 'Patawag', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3737, 'Ponot', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3738, 'Quinipot', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3739, 'Rancheria Payau', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3740, 'Robonkon', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3741, 'Sagacad', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3742, 'Sangali', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3743, 'Seres', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3744, 'Sergio Osmeña Sr', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3745, 'Siari', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3746, 'Siay', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3747, 'Sibulao', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3748, 'Sibutao', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3749, 'Siraway', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3750, 'Sumalig', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3751, 'Tagasilay', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3752, 'Taguitic', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3753, 'Talabaan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3754, 'Taluksangay', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3755, 'Talusan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3756, 'Tawagan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3757, 'Tigpalay', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3758, 'Tigtabon', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3759, 'Tiguha', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3760, 'Timonan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3761, 'Tiparak', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3762, 'Titay', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3763, 'Tucuran', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3764, 'Tungawan', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3765, 'Vitali', 99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1);

--
-- Triggers `city`
--
DROP TRIGGER IF EXISTS `trg_city_insert`;
DELIMITER $$
CREATE TRIGGER `trg_city_insert` AFTER INSERT ON `city` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'City created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('city', NEW.city_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_city_update`;
DELIMITER $$
CREATE TRIGGER `trg_city_update` AFTER UPDATE ON `city` FOR EACH ROW BEGIN
    DECLARE v_audit_log TEXT DEFAULT 'City changed.<br/><br/>';

    IF NEW.city_name <> OLD.city_name THEN
        SET v_audit_log = CONCAT(v_audit_log, 'City Name: ', OLD.city_name, ' -> ', NEW.city_name, '<br/>');
    END IF;

    IF NEW.state_name <> OLD.state_name THEN
        SET v_audit_log = CONCAT(v_audit_log, 'State: ', OLD.state_name, ' -> ', NEW.state_name, '<br/>');
    END IF;

    IF NEW.country_name <> OLD.country_name THEN
        SET v_audit_log = CONCAT(v_audit_log, 'Country: ', OLD.country_name, ' -> ', NEW.country_name, '<br/>');
    END IF;
    
    IF v_audit_log <> 'City changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('city', NEW.city_id, v_audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `civil_status`
--

DROP TABLE IF EXISTS `civil_status`;
CREATE TABLE `civil_status` (
  `civil_status_id` int(10) UNSIGNED NOT NULL,
  `civil_status_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `civil_status`
--

INSERT INTO `civil_status` (`civil_status_id`, `civil_status_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Single', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(2, 'Married', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(3, 'Divorced', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(4, 'Widowed', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(5, 'Separated', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1);

--
-- Triggers `civil_status`
--
DROP TRIGGER IF EXISTS `trg_civil_status_insert`;
DELIMITER $$
CREATE TRIGGER `trg_civil_status_insert` AFTER INSERT ON `civil_status` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Civil status created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('civil_status', NEW.civil_status_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_civil_status_update`;
DELIMITER $$
CREATE TRIGGER `trg_civil_status_update` AFTER UPDATE ON `civil_status` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Civil status changed.<br/><br/>';

    IF NEW.civil_status_name <> OLD.civil_status_name THEN
        SET audit_log = CONCAT(audit_log, "Civil Status Name: ", OLD.civil_status_name, " -> ", NEW.civil_status_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Civil status changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('civil_status', NEW.civil_status_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `company_id` int(10) UNSIGNED NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `company_logo` varchar(500) DEFAULT NULL,
  `address` varchar(1000) DEFAULT NULL,
  `city_id` int(10) UNSIGNED NOT NULL,
  `city_name` varchar(100) NOT NULL,
  `state_id` int(10) UNSIGNED NOT NULL,
  `state_name` varchar(100) NOT NULL,
  `country_id` int(10) UNSIGNED NOT NULL,
  `country_name` varchar(100) NOT NULL,
  `tax_id` varchar(100) DEFAULT NULL,
  `currency_id` int(10) UNSIGNED DEFAULT NULL,
  `currency_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `company`
--
DROP TRIGGER IF EXISTS `trg_company_insert`;
DELIMITER $$
CREATE TRIGGER `trg_company_insert` AFTER INSERT ON `company` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Company created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('company', NEW.company_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_company_update`;
DELIMITER $$
CREATE TRIGGER `trg_company_update` AFTER UPDATE ON `company` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Company changed.<br/><br/>';

    IF NEW.company_name <> OLD.company_name THEN
        SET audit_log = CONCAT(audit_log, "Company Name: ", OLD.company_name, " -> ", NEW.company_name, "<br/>");
    END IF;

    IF NEW.address <> OLD.address THEN
        SET audit_log = CONCAT(audit_log, "Address: ", OLD.address, " -> ", NEW.address, "<br/>");
    END IF;

    IF NEW.city_name <> OLD.city_name THEN
        SET audit_log = CONCAT(audit_log, "City: ", OLD.city_name, " -> ", NEW.city_name, "<br/>");
    END IF;

    IF NEW.state_name <> OLD.state_name THEN
        SET audit_log = CONCAT(audit_log, "State: ", OLD.state_name, " -> ", NEW.state_name, "<br/>");
    END IF;

    IF NEW.country_name <> OLD.country_name THEN
        SET audit_log = CONCAT(audit_log, "Country: ", OLD.country_name, " -> ", NEW.country_name, "<br/>");
    END IF;

    IF NEW.tax_id <> OLD.tax_id THEN
        SET audit_log = CONCAT(audit_log, "Tax ID: ", OLD.tax_id, " -> ", NEW.tax_id, "<br/>");
    END IF;

    IF NEW.currency_name <> OLD.currency_name THEN
        SET audit_log = CONCAT(audit_log, "Currency: ", OLD.currency_name, " -> ", NEW.currency_name, "<br/>");
    END IF;

    IF NEW.phone <> OLD.phone THEN
        SET audit_log = CONCAT(audit_log, "Phone: ", OLD.phone, " -> ", NEW.phone, "<br/>");
    END IF;

    IF NEW.telephone <> OLD.telephone THEN
        SET audit_log = CONCAT(audit_log, "Telephone: ", OLD.telephone, " -> ", NEW.telephone, "<br/>");
    END IF;

    IF NEW.email <> OLD.email THEN
        SET audit_log = CONCAT(audit_log, "Email: ", OLD.email, " -> ", NEW.email, "<br/>");
    END IF;

    IF NEW.website <> OLD.website THEN
        SET audit_log = CONCAT(audit_log, "Website: ", OLD.website, " -> ", NEW.website, "<br/>");
    END IF;
    
    IF audit_log <> 'Company changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('company', NEW.company_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `contact_information_type`
--

DROP TABLE IF EXISTS `contact_information_type`;
CREATE TABLE `contact_information_type` (
  `contact_information_type_id` int(10) UNSIGNED NOT NULL,
  `contact_information_type_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_information_type`
--

INSERT INTO `contact_information_type` (`contact_information_type_id`, `contact_information_type_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Personal', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(2, 'Work', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1);

--
-- Triggers `contact_information_type`
--
DROP TRIGGER IF EXISTS `trg_contact_information_type_insert`;
DELIMITER $$
CREATE TRIGGER `trg_contact_information_type_insert` AFTER INSERT ON `contact_information_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Contact information type created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('contact_information_type', NEW.contact_information_type_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_contact_information_type_update`;
DELIMITER $$
CREATE TRIGGER `trg_contact_information_type_update` AFTER UPDATE ON `contact_information_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Contact information type changed.<br/><br/>';

    IF NEW.contact_information_type_name <> OLD.contact_information_type_name THEN
        SET audit_log = CONCAT(audit_log, "Contact Information Type Name: ", OLD.contact_information_type_name, " -> ", NEW.contact_information_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Contact information type changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('contact_information_type', NEW.contact_information_type_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `country_id` int(10) UNSIGNED NOT NULL,
  `country_name` varchar(100) NOT NULL,
  `country_code` varchar(10) NOT NULL,
  `phone_code` varchar(10) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`country_id`, `country_name`, `country_code`, `phone_code`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Philippines', 'PH', '+63', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1);

--
-- Triggers `country`
--
DROP TRIGGER IF EXISTS `trg_country_insert`;
DELIMITER $$
CREATE TRIGGER `trg_country_insert` AFTER INSERT ON `country` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Country created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('country', NEW.country_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_country_update`;
DELIMITER $$
CREATE TRIGGER `trg_country_update` AFTER UPDATE ON `country` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Country changed.<br/><br/>';

    IF NEW.country_name <> OLD.country_name THEN
        SET audit_log = CONCAT(audit_log, "Country Name: ", OLD.country_name, " -> ", NEW.country_name, "<br/>");
    END IF;

    IF NEW.country_code <> OLD.country_code THEN
        SET audit_log = CONCAT(audit_log, "Country Code: ", OLD.country_code, " -> ", NEW.country_code, "<br/>");
    END IF;

    IF NEW.phone_code <> OLD.phone_code THEN
        SET audit_log = CONCAT(audit_log, "Phone Code: ", OLD.phone_code, " -> ", NEW.phone_code, "<br/>");
    END IF;
    
    IF audit_log <> 'Country changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('country', NEW.country_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `credential_type`
--

DROP TABLE IF EXISTS `credential_type`;
CREATE TABLE `credential_type` (
  `credential_type_id` int(10) UNSIGNED NOT NULL,
  `credential_type_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `credential_type`
--

INSERT INTO `credential_type` (`credential_type_id`, `credential_type_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Passport', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(2, 'Driver\'s License', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(3, 'National ID', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(4, 'SSS ID', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(5, 'GSIS ID', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(6, 'PhilHealth ID', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(7, 'Postal ID', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(8, 'Voter\'s ID', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(9, 'Barangay ID', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(10, 'Student ID', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(11, 'PRC License', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(12, 'Company ID', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(13, 'Professional Certification', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(14, 'Work Permit', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(15, 'Medical License', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(16, 'Teaching License', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(17, 'Engineering License', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(18, 'Bar Exam Certificate', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(19, 'Visa', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(20, 'Work Visa', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(21, 'Immigration Card', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(22, 'Marriage Certificate', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(23, 'Birth Certificate', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(24, 'Death Certificate', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(25, 'Police Clearance', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(26, 'NBI Clearance', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(27, 'Barangay Clearance', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(28, 'Travel Permit', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(29, 'Employment Certificate', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(30, 'Firearm License', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(31, 'Business Permit', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1);

--
-- Triggers `credential_type`
--
DROP TRIGGER IF EXISTS `trg_credential_type_insert`;
DELIMITER $$
CREATE TRIGGER `trg_credential_type_insert` AFTER INSERT ON `credential_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Credential type created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('credential_type', NEW.credential_type_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_credential_type_update`;
DELIMITER $$
CREATE TRIGGER `trg_credential_type_update` AFTER UPDATE ON `credential_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Credential type changed.<br/><br/>';

    IF NEW.credential_type_name <> OLD.credential_type_name THEN
        SET audit_log = CONCAT(audit_log, "Credential Type Name: ", OLD.credential_type_name, " -> ", NEW.credential_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Credential type changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('credential_type', NEW.credential_type_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
CREATE TABLE `currency` (
  `currency_id` int(10) UNSIGNED NOT NULL,
  `currency_name` varchar(100) NOT NULL,
  `symbol` varchar(5) NOT NULL,
  `shorthand` varchar(10) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `currency`
--

INSERT INTO `currency` (`currency_id`, `currency_name`, `symbol`, `shorthand`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Philippine Peso', '₱', 'PHP', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(2, 'United States Dollar', '$', 'USD', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(3, 'Japanese Yen', '¥', 'JPY', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(4, 'South Korean Won', '₩', 'KRW', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(5, 'Euro', '€', 'EUR', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(6, 'Pound Sterling', '£', 'GBP', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1);

--
-- Triggers `currency`
--
DROP TRIGGER IF EXISTS `trg_currency_insert`;
DELIMITER $$
CREATE TRIGGER `trg_currency_insert` AFTER INSERT ON `currency` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Currency created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('currency', NEW.currency_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_currency_update`;
DELIMITER $$
CREATE TRIGGER `trg_currency_update` AFTER UPDATE ON `currency` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Currency changed.<br/><br/>';

    IF NEW.currency_name <> OLD.currency_name THEN
        SET audit_log = CONCAT(audit_log, "Currency Name: ", OLD.currency_name, " -> ", NEW.currency_name, "<br/>");
    END IF;

    IF NEW.symbol <> OLD.symbol THEN
        SET audit_log = CONCAT(audit_log, "Symbol: ", OLD.symbol, " -> ", NEW.symbol, "<br/>");
    END IF;

    IF NEW.shorthand <> OLD.shorthand THEN
        SET audit_log = CONCAT(audit_log, "Shorthand: ", OLD.shorthand, " -> ", NEW.shorthand, "<br/>");
    END IF;
    
    IF audit_log <> 'Currency changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('currency', NEW.currency_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `department_id` int(10) UNSIGNED NOT NULL,
  `department_name` varchar(100) NOT NULL,
  `parent_department_id` int(11) DEFAULT NULL,
  `parent_department_name` varchar(100) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `manager_name` varchar(1000) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `department`
--
DROP TRIGGER IF EXISTS `trg_department_insert`;
DELIMITER $$
CREATE TRIGGER `trg_department_insert` AFTER INSERT ON `department` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Department created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('department', NEW.department_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_department_update`;
DELIMITER $$
CREATE TRIGGER `trg_department_update` AFTER UPDATE ON `department` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Department changed.<br/><br/>';

    IF NEW.department_name <> OLD.department_name THEN
        SET audit_log = CONCAT(audit_log, "Department Name: ", OLD.department_name, " -> ", NEW.department_name, "<br/>");
    END IF;

    IF NEW.parent_department_name <> OLD.parent_department_name THEN
        SET audit_log = CONCAT(audit_log, "Parent Department: ", OLD.parent_department_name, " -> ", NEW.parent_department_name, "<br/>");
    END IF;

    IF NEW.manager_name <> OLD.manager_name THEN
        SET audit_log = CONCAT(audit_log, "Manager: ", OLD.manager_name, " -> ", NEW.manager_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Department changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('department', NEW.department_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `departure_reason`
--

DROP TABLE IF EXISTS `departure_reason`;
CREATE TABLE `departure_reason` (
  `departure_reason_id` int(10) UNSIGNED NOT NULL,
  `departure_reason_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departure_reason`
--

INSERT INTO `departure_reason` (`departure_reason_id`, `departure_reason_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Resigned', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(2, 'Retirement', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(3, 'Termination - Performance', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(4, 'Termination - Misconduct', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(5, 'Layoff / Redundancy', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(6, 'End of Contract', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(7, 'Mutual Agreement', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(8, 'Medical Reasons', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(9, 'Personal Reasons', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(10, 'Relocation', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(11, 'Career Change', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(12, 'Better Opportunity', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(13, 'Education / Study', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(14, 'Family Responsibilities', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(15, 'Deceased', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1);

--
-- Triggers `departure_reason`
--
DROP TRIGGER IF EXISTS `trg_departure_reason_insert`;
DELIMITER $$
CREATE TRIGGER `trg_departure_reason_insert` AFTER INSERT ON `departure_reason` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Departure reason created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('departure_reason', NEW.departure_reason_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_departure_reason_update`;
DELIMITER $$
CREATE TRIGGER `trg_departure_reason_update` AFTER UPDATE ON `departure_reason` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Departure reason changed.<br/><br/>';

    IF NEW.departure_reason_name <> OLD.departure_reason_name THEN
        SET audit_log = CONCAT(audit_log, "Departure Reason Name: ", OLD.departure_reason_name, " -> ", NEW.departure_reason_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Departure reason changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('departure_reason', NEW.departure_reason_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `educational_stage`
--

DROP TABLE IF EXISTS `educational_stage`;
CREATE TABLE `educational_stage` (
  `educational_stage_id` int(10) UNSIGNED NOT NULL,
  `educational_stage_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `educational_stage`
--

INSERT INTO `educational_stage` (`educational_stage_id`, `educational_stage_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Primary Education', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(2, 'Middle School', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(3, 'High School', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(4, 'Diploma', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(5, 'Bachelor', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(6, 'Master', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(7, 'Doctorate', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(8, 'Post-Doctorate', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(9, 'Vocational Training', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1);

--
-- Triggers `educational_stage`
--
DROP TRIGGER IF EXISTS `trg_educational_stage_insert`;
DELIMITER $$
CREATE TRIGGER `trg_educational_stage_insert` AFTER INSERT ON `educational_stage` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Educational stage created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('educational_stage', NEW.educational_stage_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_educational_stage_update`;
DELIMITER $$
CREATE TRIGGER `trg_educational_stage_update` AFTER UPDATE ON `educational_stage` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Educational stage changed.<br/><br/>';

    IF NEW.educational_stage_name <> OLD.educational_stage_name THEN
        SET audit_log = CONCAT(audit_log, "Educational Stage Name: ", OLD.educational_stage_name, " -> ", NEW.educational_stage_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Educational stage changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('educational_stage', NEW.educational_stage_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `employee_id` int(10) UNSIGNED NOT NULL,
  `employee_image` varchar(500) DEFAULT NULL,
  `full_name` varchar(1000) NOT NULL,
  `first_name` varchar(300) NOT NULL,
  `middle_name` varchar(300) DEFAULT NULL,
  `last_name` varchar(300) NOT NULL,
  `suffix` varchar(10) DEFAULT NULL,
  `nickname` varchar(100) DEFAULT NULL,
  `private_address` varchar(500) DEFAULT NULL,
  `private_address_city_id` int(10) UNSIGNED DEFAULT NULL,
  `private_address_city_name` varchar(100) DEFAULT NULL,
  `private_address_state_id` int(10) UNSIGNED DEFAULT NULL,
  `private_address_state_name` varchar(100) DEFAULT NULL,
  `private_address_country_id` int(10) UNSIGNED DEFAULT NULL,
  `private_address_country_name` varchar(100) DEFAULT NULL,
  `private_phone` varchar(20) DEFAULT NULL,
  `private_telephone` varchar(20) DEFAULT NULL,
  `private_email` varchar(255) DEFAULT NULL,
  `civil_status_id` int(10) UNSIGNED DEFAULT NULL,
  `civil_status_name` varchar(100) DEFAULT NULL,
  `dependents` int(11) DEFAULT 0,
  `nationality_id` int(10) UNSIGNED DEFAULT NULL,
  `nationality_name` varchar(100) DEFAULT NULL,
  `gender_id` int(10) UNSIGNED DEFAULT NULL,
  `gender_name` varchar(100) DEFAULT NULL,
  `religion_id` int(10) UNSIGNED DEFAULT NULL,
  `religion_name` varchar(100) DEFAULT NULL,
  `blood_type_id` int(10) UNSIGNED DEFAULT NULL,
  `blood_type_name` varchar(100) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `place_of_birth` varchar(1000) DEFAULT NULL,
  `home_work_distance` double DEFAULT 0,
  `height` float DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `employment_status` varchar(50) DEFAULT 'Active',
  `company_id` int(10) UNSIGNED DEFAULT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `department_id` int(10) UNSIGNED DEFAULT NULL,
  `department_name` varchar(100) DEFAULT NULL,
  `job_position_id` int(10) UNSIGNED DEFAULT NULL,
  `job_position_name` varchar(100) DEFAULT NULL,
  `work_phone` varchar(20) DEFAULT NULL,
  `work_telephone` varchar(20) DEFAULT NULL,
  `work_email` varchar(255) DEFAULT NULL,
  `manager_id` int(10) UNSIGNED DEFAULT NULL,
  `manager_name` varchar(1000) DEFAULT NULL,
  `work_location_id` int(10) UNSIGNED DEFAULT NULL,
  `work_location_name` varchar(100) DEFAULT NULL,
  `employment_type_id` int(10) UNSIGNED DEFAULT NULL,
  `employment_type_name` varchar(100) DEFAULT NULL,
  `employment_location_type_id` int(10) UNSIGNED DEFAULT NULL,
  `employment_location_type_name` varchar(100) DEFAULT NULL,
  `pin_code` varchar(255) DEFAULT NULL,
  `badge_id` varchar(100) DEFAULT NULL,
  `on_board_date` date DEFAULT NULL,
  `off_board_date` date DEFAULT NULL,
  `time_off_approver_id` int(10) UNSIGNED DEFAULT NULL,
  `time_off_approver_name` varchar(300) DEFAULT NULL,
  `departure_reason_id` int(10) UNSIGNED DEFAULT NULL,
  `departure_reason_name` varchar(100) DEFAULT NULL,
  `detailed_departure_reason` varchar(5000) DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `employee`
--
DROP TRIGGER IF EXISTS `trg_employee_insert`;
DELIMITER $$
CREATE TRIGGER `trg_employee_insert` AFTER INSERT ON `employee` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employee created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('employee', NEW.employee_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_employee_update`;
DELIMITER $$
CREATE TRIGGER `trg_employee_update` AFTER UPDATE ON `employee` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employee changed.<br/><br/>';

    IF NEW.full_name <> OLD.full_name THEN
        SET audit_log = CONCAT(audit_log, "Full Name: ", OLD.full_name, " -> ", NEW.full_name, "<br/>");
    END IF;

    IF NEW.first_name <> OLD.first_name THEN
        SET audit_log = CONCAT(audit_log, "First Name: ", OLD.first_name, " -> ", NEW.first_name, "<br/>");
    END IF;

    IF NEW.middle_name <> OLD.middle_name THEN
        SET audit_log = CONCAT(audit_log, "Middle Name: ", OLD.middle_name, " -> ", NEW.middle_name, "<br/>");
    END IF;

    IF NEW.last_name <> OLD.last_name THEN
        SET audit_log = CONCAT(audit_log, "Last Name: ", OLD.last_name, " -> ", NEW.last_name, "<br/>");
    END IF;

    IF NEW.suffix <> OLD.suffix THEN
        SET audit_log = CONCAT(audit_log, "Suffix: ", OLD.suffix, " -> ", NEW.suffix, "<br/>");
    END IF;

    IF NEW.nickname <> OLD.nickname THEN
        SET audit_log = CONCAT(audit_log, "Nickname: ", OLD.nickname, " -> ", NEW.nickname, "<br/>");
    END IF;

    IF NEW.private_address <> OLD.private_address THEN
        SET audit_log = CONCAT(audit_log, "Private Address: ", OLD.private_address, " -> ", NEW.private_address, "<br/>");
    END IF;

    IF NEW.private_address_city_name <> OLD.private_address_city_name THEN
        SET audit_log = CONCAT(audit_log, "Private Address City: ", OLD.private_address_city_name, " -> ", NEW.private_address_city_name, "<br/>");
    END IF;

    IF NEW.private_address_state_name <> OLD.private_address_state_name THEN
        SET audit_log = CONCAT(audit_log, "Private Address State: ", OLD.private_address_state_name, " -> ", NEW.private_address_state_name, "<br/>");
    END IF;

    IF NEW.private_address_country_name <> OLD.private_address_country_name THEN
        SET audit_log = CONCAT(audit_log, "Private Address Country: ", OLD.private_address_country_name, " -> ", NEW.private_address_country_name, "<br/>");
    END IF;

    IF NEW.private_phone <> OLD.private_phone THEN
        SET audit_log = CONCAT(audit_log, "Private Phone: ", OLD.private_phone, " -> ", NEW.private_phone, "<br/>");
    END IF;

    IF NEW.private_telephone <> OLD.private_telephone THEN
        SET audit_log = CONCAT(audit_log, "Private Telephone: ", OLD.private_telephone, " -> ", NEW.private_telephone, "<br/>");
    END IF;

    IF NEW.private_email <> OLD.private_email THEN
        SET audit_log = CONCAT(audit_log, "Private Email: ", OLD.private_email, " -> ", NEW.private_email, "<br/>");
    END IF;

    IF NEW.civil_status_name <> OLD.civil_status_name THEN
        SET audit_log = CONCAT(audit_log, "Civil Status: ", OLD.civil_status_name, " -> ", NEW.civil_status_name, "<br/>");
    END IF;

    IF NEW.dependents <> OLD.dependents THEN
        SET audit_log = CONCAT(audit_log, "Dependents: ", OLD.dependents, " -> ", NEW.dependents, "<br/>");
    END IF;

    IF NEW.nationality_name <> OLD.nationality_name THEN
        SET audit_log = CONCAT(audit_log, "Nationality: ", OLD.nationality_name, " -> ", NEW.nationality_name, "<br/>");
    END IF;

    IF NEW.gender_name <> OLD.gender_name THEN
        SET audit_log = CONCAT(audit_log, "Gender: ", OLD.gender_name, " -> ", NEW.gender_name, "<br/>");
    END IF;

    IF NEW.religion_name <> OLD.religion_name THEN
        SET audit_log = CONCAT(audit_log, "Religion: ", OLD.religion_name, " -> ", NEW.religion_name, "<br/>");
    END IF;

    IF NEW.blood_type_name <> OLD.blood_type_name THEN
        SET audit_log = CONCAT(audit_log, "Blood Type: ", OLD.blood_type_name, " -> ", NEW.blood_type_name, "<br/>");
    END IF;

    IF NEW.birthday <> OLD.birthday THEN
        SET audit_log = CONCAT(audit_log, "Birthday: ", OLD.birthday, " -> ", NEW.birthday, "<br/>");
    END IF;

    IF NEW.place_of_birth <> OLD.place_of_birth THEN
        SET audit_log = CONCAT(audit_log, "Place of Birth: ", OLD.place_of_birth, " -> ", NEW.place_of_birth, "<br/>");
    END IF;

    IF NEW.home_work_distance <> OLD.home_work_distance THEN
        SET audit_log = CONCAT(audit_log, "Home-Work Distance: ", OLD.home_work_distance, " km -> ", NEW.home_work_distance, " km<br/>");
    END IF;

    IF NEW.height <> OLD.height THEN
        SET audit_log = CONCAT(audit_log, "Height: ", OLD.height, " cm -> ", NEW.height, " cm<br/>");
    END IF;

    IF NEW.weight <> OLD.weight THEN
        SET audit_log = CONCAT(audit_log, "Weight: ", OLD.weight, " kg -> ", NEW.weight, " kg<br/>");
    END IF;

    IF NEW.employment_status <> OLD.employment_status THEN
        SET audit_log = CONCAT(audit_log, "Employment Status: ", OLD.employment_status, " -> ", NEW.employment_status, "<br/>");
    END IF;

    IF NEW.company_name <> OLD.company_name THEN
        SET audit_log = CONCAT(audit_log, "Company: ", OLD.company_name, " -> ", NEW.company_name, "<br/>");
    END IF;

    IF NEW.department_name <> OLD.department_name THEN
        SET audit_log = CONCAT(audit_log, "Department: ", OLD.department_name, " -> ", NEW.department_name, "<br/>");
    END IF;

    IF NEW.job_position_name <> OLD.job_position_name THEN
        SET audit_log = CONCAT(audit_log, "Job Position: ", OLD.job_position_name, " -> ", NEW.job_position_name, "<br/>");
    END IF;

    IF NEW.work_phone <> OLD.work_phone THEN
        SET audit_log = CONCAT(audit_log, "Work Phone: ", OLD.work_phone, " -> ", NEW.work_phone, "<br/>");
    END IF;

    IF NEW.work_telephone <> OLD.work_telephone THEN
        SET audit_log = CONCAT(audit_log, "Work Telephone: ", OLD.work_telephone, " -> ", NEW.work_telephone, "<br/>");
    END IF;

    IF NEW.work_email <> OLD.work_email THEN
        SET audit_log = CONCAT(audit_log, "Work Email: ", OLD.work_email, " -> ", NEW.work_email, "<br/>");
    END IF;

    IF NEW.manager_name <> OLD.manager_name THEN
        SET audit_log = CONCAT(audit_log, "Manager: ", OLD.manager_name, " -> ", NEW.manager_name, "<br/>");
    END IF;

    IF NEW.work_location_name <> OLD.work_location_name THEN
        SET audit_log = CONCAT(audit_log, "Work Location: ", OLD.work_location_name, " -> ", NEW.work_location_name, "<br/>");
    END IF;

    IF NEW.employment_type_name <> OLD.employment_type_name THEN
        SET audit_log = CONCAT(audit_log, "Employment Type: ", OLD.employment_type_name, " -> ", NEW.employment_type_name, "<br/>");
    END IF;

    IF NEW.employment_location_type_name <> OLD.employment_location_type_name THEN
        SET audit_log = CONCAT(audit_log, "Employment Location Type: ", OLD.employment_location_type_name, " -> ", NEW.employment_location_type_name, "<br/>");
    END IF;

    IF NEW.badge_id <> OLD.badge_id THEN
        SET audit_log = CONCAT(audit_log, "Badge ID: ", OLD.badge_id, " -> ", NEW.badge_id, "<br/>");
    END IF;

    IF NEW.on_board_date <> OLD.on_board_date THEN
        SET audit_log = CONCAT(audit_log, "On-Board Date: ", OLD.on_board_date, " -> ", NEW.on_board_date, "<br/>");
    END IF;

    IF NEW.off_board_date <> OLD.off_board_date THEN
        SET audit_log = CONCAT(audit_log, "Off-Board Date: ", OLD.off_board_date, " -> ", NEW.off_board_date, "<br/>");
    END IF;

    IF NEW.time_off_approver_name <> OLD.time_off_approver_name THEN
        SET audit_log = CONCAT(audit_log, "Time-Off Approver: ", OLD.time_off_approver_name, " -> ", NEW.time_off_approver_name, "<br/>");
    END IF;

    IF NEW.departure_reason_name <> OLD.departure_reason_name THEN
        SET audit_log = CONCAT(audit_log, "Departure Reason: ", OLD.departure_reason_name, " -> ", NEW.departure_reason_name, "<br/>");
    END IF;

    IF NEW.detailed_departure_reason <> OLD.detailed_departure_reason THEN
        SET audit_log = CONCAT(audit_log, "Detailed Departure Reason: ", OLD.detailed_departure_reason, " -> ", NEW.detailed_departure_reason, "<br/>");
    END IF;

    IF NEW.departure_date <> OLD.departure_date THEN
        SET audit_log = CONCAT(audit_log, "Departure Date: ", OLD.departure_date, " -> ", NEW.departure_date, "<br/>");
    END IF;
    
    IF audit_log <> 'Employee changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('employee', NEW.employee_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee_document`
--

DROP TABLE IF EXISTS `employee_document`;
CREATE TABLE `employee_document` (
  `employee_document_id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL,
  `document_name` varchar(200) NOT NULL,
  `document_file` varchar(500) NOT NULL,
  `employee_document_type_id` int(10) UNSIGNED NOT NULL,
  `employee_document_type_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `employee_document`
--
DROP TRIGGER IF EXISTS `trg_employee_document_insert`;
DELIMITER $$
CREATE TRIGGER `trg_employee_document_insert` AFTER INSERT ON `employee_document` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employee document created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('employee_document', NEW.employee_document_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee_document_type`
--

DROP TABLE IF EXISTS `employee_document_type`;
CREATE TABLE `employee_document_type` (
  `employee_document_type_id` int(10) UNSIGNED NOT NULL,
  `employee_document_type_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee_document_type`
--

INSERT INTO `employee_document_type` (`employee_document_type_id`, `employee_document_type_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Resume', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(2, 'Cover Letter', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(3, 'Employment Contract', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(4, 'Non-Disclosure Agreement', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(5, 'Offer Letter', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(6, 'Government ID', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(7, 'Passport', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(8, 'Work Visa', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(9, 'Tax Identification Document', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(10, 'Social Security Card', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(11, 'Educational Certificates', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(12, 'Professional Licenses', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(13, 'Training Certificates', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(14, 'Performance Appraisal', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(15, 'Background Check Report', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(16, 'Medical Certificate', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(17, 'Bank Account Details', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(18, 'Emergency Contact Form', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(19, 'Company Policy Acknowledgment', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(20, 'Exit Clearance Form', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1);

--
-- Triggers `employee_document_type`
--
DROP TRIGGER IF EXISTS `trg_employee_document_type_insert`;
DELIMITER $$
CREATE TRIGGER `trg_employee_document_type_insert` AFTER INSERT ON `employee_document_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employment document type created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('employee_document_type', NEW.employee_document_type_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_employee_document_type_update`;
DELIMITER $$
CREATE TRIGGER `trg_employee_document_type_update` AFTER UPDATE ON `employee_document_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employment document type changed.<br/><br/>';

    IF NEW.employee_document_type_name <> OLD.employee_document_type_name THEN
        SET audit_log = CONCAT(audit_log, "Employment Document Type Name: ", OLD.employee_document_type_name, " -> ", NEW.employee_document_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Employment document type changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('employee_document_type', NEW.employee_document_type_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee_education`
--

DROP TABLE IF EXISTS `employee_education`;
CREATE TABLE `employee_education` (
  `employee_education_id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL,
  `school` varchar(100) NOT NULL,
  `degree` varchar(100) DEFAULT NULL,
  `field_of_study` varchar(100) DEFAULT NULL,
  `start_month` varchar(20) DEFAULT NULL,
  `start_year` varchar(20) DEFAULT NULL,
  `end_month` varchar(20) DEFAULT NULL,
  `end_year` varchar(20) DEFAULT NULL,
  `activities_societies` varchar(5000) DEFAULT NULL,
  `education_description` varchar(5000) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `employee_education`
--
DROP TRIGGER IF EXISTS `trg_employee_education_insert`;
DELIMITER $$
CREATE TRIGGER `trg_employee_education_insert` AFTER INSERT ON `employee_education` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employee education created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('employee_education', NEW.employee_education_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_employee_education_update`;
DELIMITER $$
CREATE TRIGGER `trg_employee_education_update` AFTER UPDATE ON `employee_education` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employee education changed.<br/><br/>';

    IF NEW.school <> OLD.school THEN
        SET audit_log = CONCAT(audit_log, "School: ", OLD.school, " -> ", NEW.school, "<br/>");
    END IF;

    IF NEW.degree <> OLD.degree THEN
        SET audit_log = CONCAT(audit_log, "Degree: ", OLD.degree, " -> ", NEW.degree, "<br/>");
    END IF;

    IF NEW.field_of_study <> OLD.field_of_study THEN
        SET audit_log = CONCAT(audit_log, "Field of Study: ", OLD.field_of_study, " -> ", NEW.field_of_study, "<br/>");
    END IF;

    IF NEW.start_month <> OLD.start_month THEN
        SET audit_log = CONCAT(audit_log, "Start Month: ", OLD.start_month, " -> ", NEW.start_month, "<br/>");
    END IF;

    IF NEW.start_year <> OLD.start_year THEN
        SET audit_log = CONCAT(audit_log, "Start Year: ", OLD.start_year, " -> ", NEW.start_year, "<br/>");
    END IF;

    IF NEW.end_month <> OLD.end_month THEN
        SET audit_log = CONCAT(audit_log, "End Month: ", OLD.end_month, " -> ", NEW.end_month, "<br/>");
    END IF;

    IF NEW.end_year <> OLD.end_year THEN
        SET audit_log = CONCAT(audit_log, "End Year: ", OLD.end_year, " -> ", NEW.end_year, "<br/>");
    END IF;

    IF NEW.activities_societies <> OLD.activities_societies THEN
        SET audit_log = CONCAT(audit_log, "Activities/Societies: ", OLD.activities_societies, " -> ", NEW.activities_societies, "<br/>");
    END IF;

    IF NEW.education_description <> OLD.education_description THEN
        SET audit_log = CONCAT(audit_log, "Description: ", OLD.education_description, " -> ", NEW.education_description, "<br/>");
    END IF;
    
    IF audit_log <> 'Employee education changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('employee_education', NEW.employee_education_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee_emergency_contact`
--

DROP TABLE IF EXISTS `employee_emergency_contact`;
CREATE TABLE `employee_emergency_contact` (
  `employee_emergency_contact_id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL,
  `emergency_contact_name` varchar(500) NOT NULL,
  `relationship_id` int(10) UNSIGNED NOT NULL,
  `relationship_name` varchar(100) NOT NULL,
  `telephone` varchar(50) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `employee_emergency_contact`
--
DROP TRIGGER IF EXISTS `trg_employee_emergency_contact_insert`;
DELIMITER $$
CREATE TRIGGER `trg_employee_emergency_contact_insert` AFTER INSERT ON `employee_emergency_contact` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employee emergency contact created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('employee_emergency_contact', NEW.employee_emergency_contact_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_employee_emergency_contact_update`;
DELIMITER $$
CREATE TRIGGER `trg_employee_emergency_contact_update` AFTER UPDATE ON `employee_emergency_contact` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employee emergency contact changed.<br/><br/>';

    IF NEW.emergency_contact_name <> OLD.emergency_contact_name THEN
        SET audit_log = CONCAT(audit_log, "Emergency Contact Name: ", OLD.emergency_contact_name, " -> ", NEW.emergency_contact_name, "<br/>");
    END IF;

    IF NEW.relationship_name <> OLD.relationship_name THEN
        SET audit_log = CONCAT(audit_log, "Relationship: ", OLD.relationship_name, " -> ", NEW.relationship_name, "<br/>");
    END IF;

    IF NEW.telephone <> OLD.telephone THEN
        SET audit_log = CONCAT(audit_log, "Telephone: ", OLD.telephone, " -> ", NEW.telephone, "<br/>");
    END IF;

    IF NEW.mobile <> OLD.mobile THEN
        SET audit_log = CONCAT(audit_log, "Mobile: ", OLD.mobile, " -> ", NEW.mobile, "<br/>");
    END IF;

    IF NEW.email <> OLD.email THEN
        SET audit_log = CONCAT(audit_log, "Email: ", OLD.email, " -> ", NEW.email, "<br/>");
    END IF;
    
    IF audit_log <> 'Employee emergency contact changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('employee_emergency_contact', NEW.employee_emergency_contact_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee_experience`
--

DROP TABLE IF EXISTS `employee_experience`;
CREATE TABLE `employee_experience` (
  `employee_experience_id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL,
  `job_title` varchar(100) NOT NULL,
  `employment_type_id` int(10) UNSIGNED DEFAULT NULL,
  `employment_type_name` varchar(100) DEFAULT NULL,
  `company_name` varchar(200) NOT NULL,
  `location` varchar(200) DEFAULT NULL,
  `start_month` varchar(20) DEFAULT NULL,
  `start_year` varchar(20) DEFAULT NULL,
  `end_month` varchar(20) DEFAULT NULL,
  `end_year` varchar(20) DEFAULT NULL,
  `job_description` varchar(5000) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `employee_experience`
--
DROP TRIGGER IF EXISTS `trg_employee_experience_insert`;
DELIMITER $$
CREATE TRIGGER `trg_employee_experience_insert` AFTER INSERT ON `employee_experience` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employee experience created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('employee_experience', NEW.employee_experience_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_employee_experience_update`;
DELIMITER $$
CREATE TRIGGER `trg_employee_experience_update` AFTER UPDATE ON `employee_experience` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employee experience changed.<br/><br/>';

    IF NEW.job_title <> OLD.job_title THEN
        SET audit_log = CONCAT(audit_log, "Job Title: ", OLD.job_title, " -> ", NEW.job_title, "<br/>");
    END IF;

    IF NEW.employment_type_name <> OLD.employment_type_name THEN
        SET audit_log = CONCAT(audit_log, "Employment Type: ", OLD.employment_type_name, " -> ", NEW.employment_type_name, "<br/>");
    END IF;

    IF NEW.company_name <> OLD.company_name THEN
        SET audit_log = CONCAT(audit_log, "Company: ", OLD.company_name, " -> ", NEW.company_name, "<br/>");
    END IF;

    IF NEW.location <> OLD.location THEN
        SET audit_log = CONCAT(audit_log, "Location: ", OLD.location, " -> ", NEW.location, "<br/>");
    END IF;

    IF NEW.start_month <> OLD.start_month THEN
        SET audit_log = CONCAT(audit_log, "Start Month: ", OLD.start_month, " -> ", NEW.start_month, "<br/>");
    END IF;

    IF NEW.start_year <> OLD.start_year THEN
        SET audit_log = CONCAT(audit_log, "Start Year: ", OLD.start_year, " -> ", NEW.start_year, "<br/>");
    END IF;

    IF NEW.end_month <> OLD.end_month THEN
        SET audit_log = CONCAT(audit_log, "End Month: ", OLD.end_month, " -> ", NEW.end_month, "<br/>");
    END IF;

    IF NEW.end_year <> OLD.end_year THEN
        SET audit_log = CONCAT(audit_log, "End Year: ", OLD.end_year, " -> ", NEW.end_year, "<br/>");
    END IF;

    IF NEW.job_description <> OLD.job_description THEN
        SET audit_log = CONCAT(audit_log, "Job Description: ", OLD.job_description, " -> ", NEW.job_description, "<br/>");
    END IF;
    
    IF audit_log <> 'Employee experience changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('employee_experience', NEW.employee_experience_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee_language`
--

DROP TABLE IF EXISTS `employee_language`;
CREATE TABLE `employee_language` (
  `employee_language_id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL,
  `language_id` int(10) UNSIGNED NOT NULL,
  `language_name` varchar(100) NOT NULL,
  `language_proficiency_id` int(10) UNSIGNED NOT NULL,
  `language_proficiency_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `employee_language`
--
DROP TRIGGER IF EXISTS `trg_employee_language_insert`;
DELIMITER $$
CREATE TRIGGER `trg_employee_language_insert` AFTER INSERT ON `employee_language` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employee language created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('employee_language', NEW.employee_language_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_employee_language_update`;
DELIMITER $$
CREATE TRIGGER `trg_employee_language_update` AFTER UPDATE ON `employee_language` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employee language changed.<br/><br/>';

    IF NEW.language_name <> OLD.language_name THEN
        SET audit_log = CONCAT(audit_log, "Language: ", OLD.language_name, " -> ", NEW.language_name, "<br/>");
    END IF;

    IF NEW.language_proficiency_name <> OLD.language_proficiency_name THEN
        SET audit_log = CONCAT(audit_log, "Language Proficiency: ", OLD.language_proficiency_name, " -> ", NEW.language_proficiency_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Employee language changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('employee_language', NEW.employee_language_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee_license`
--

DROP TABLE IF EXISTS `employee_license`;
CREATE TABLE `employee_license` (
  `employee_license_id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL,
  `licensed_profession` varchar(200) NOT NULL,
  `licensing_body` varchar(200) NOT NULL,
  `license_number` varchar(200) NOT NULL,
  `issue_date` date NOT NULL,
  `expiration_date` date DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `employee_license`
--
DROP TRIGGER IF EXISTS `trg_employee_license_insert`;
DELIMITER $$
CREATE TRIGGER `trg_employee_license_insert` AFTER INSERT ON `employee_license` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employee license created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('employee_license', NEW.employee_license_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_employee_license_update`;
DELIMITER $$
CREATE TRIGGER `trg_employee_license_update` AFTER UPDATE ON `employee_license` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employee license changed.<br/><br/>';

    IF NEW.licensed_profession <> OLD.licensed_profession THEN
        SET audit_log = CONCAT(audit_log, "Licensed Profession: ", OLD.licensed_profession, " -> ", NEW.licensed_profession, "<br/>");
    END IF;

    IF NEW.licensing_body <> OLD.licensing_body THEN
        SET audit_log = CONCAT(audit_log, "Licensing Body: ", OLD.licensing_body, " -> ", NEW.licensing_body, "<br/>");
    END IF;

    IF NEW.license_number <> OLD.license_number THEN
        SET audit_log = CONCAT(audit_log, "License Number: ", OLD.license_number, " -> ", NEW.license_number, "<br/>");
    END IF;

    IF NEW.issue_date <> OLD.issue_date THEN
        SET audit_log = CONCAT(audit_log, "Issue Date: ", OLD.issue_date, " -> ", NEW.issue_date, "<br/>");
    END IF;

    IF NEW.expiration_date <> OLD.expiration_date THEN
        SET audit_log = CONCAT(audit_log, "Expiration Date: ", OLD.expiration_date, " -> ", NEW.expiration_date, "<br/>");
    END IF;
    
    IF audit_log <> 'Employee license changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('employee_license', NEW.employee_license_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employment_location_type`
--

DROP TABLE IF EXISTS `employment_location_type`;
CREATE TABLE `employment_location_type` (
  `employment_location_type_id` int(10) UNSIGNED NOT NULL,
  `employment_location_type_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employment_location_type`
--

INSERT INTO `employment_location_type` (`employment_location_type_id`, `employment_location_type_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Remote', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(2, 'Hybrid', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(3, 'Onsite', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1);

--
-- Triggers `employment_location_type`
--
DROP TRIGGER IF EXISTS `trg_employment_location_type_insert`;
DELIMITER $$
CREATE TRIGGER `trg_employment_location_type_insert` AFTER INSERT ON `employment_location_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employment location type created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('employment_location_type', NEW.employment_location_type_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_employment_location_type_update`;
DELIMITER $$
CREATE TRIGGER `trg_employment_location_type_update` AFTER UPDATE ON `employment_location_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employment location type changed.<br/><br/>';

    IF NEW.employment_location_type_name <> OLD.employment_location_type_name THEN
        SET audit_log = CONCAT(audit_log, "Employment Location Type Name: ", OLD.employment_location_type_name, " -> ", NEW.employment_location_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Employment location type changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('employment_location_type', NEW.employment_location_type_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employment_type`
--

DROP TABLE IF EXISTS `employment_type`;
CREATE TABLE `employment_type` (
  `employment_type_id` int(10) UNSIGNED NOT NULL,
  `employment_type_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employment_type`
--

INSERT INTO `employment_type` (`employment_type_id`, `employment_type_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Full-time', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(2, 'Part-time', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(3, 'Temporary', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(4, 'Contract', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(5, 'Internship', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(6, 'Apprenticeship', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(7, 'Seasonal', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(8, 'Casual', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(9, 'Consultant', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(10, 'Freelance', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1);

--
-- Triggers `employment_type`
--
DROP TRIGGER IF EXISTS `trg_employment_type_insert`;
DELIMITER $$
CREATE TRIGGER `trg_employment_type_insert` AFTER INSERT ON `employment_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employment Type created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('employment_type', NEW.employment_type_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_employment_type_update`;
DELIMITER $$
CREATE TRIGGER `trg_employment_type_update` AFTER UPDATE ON `employment_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Employment Type changed.<br/><br/>';

    IF NEW.employment_type_name <> OLD.employment_type_name THEN
        SET audit_log = CONCAT(audit_log, "Employment Type Name: ", OLD.employment_type_name, " -> ", NEW.employment_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Employment Type changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('employment_type', NEW.employment_type_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `file_extension`
--

DROP TABLE IF EXISTS `file_extension`;
CREATE TABLE `file_extension` (
  `file_extension_id` int(10) UNSIGNED NOT NULL,
  `file_extension_name` varchar(100) NOT NULL,
  `file_extension` varchar(10) NOT NULL,
  `file_type_id` int(10) UNSIGNED NOT NULL,
  `file_type_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `file_extension`
--

INSERT INTO `file_extension` (`file_extension_id`, `file_extension_name`, `file_extension`, `file_type_id`, `file_type_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'AIF', 'aif', 1, 'Audio', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2, 'CDA', 'cda', 1, 'Audio', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3, 'MID', 'mid', 1, 'Audio', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(4, 'MIDI', 'midi', 1, 'Audio', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(5, 'MP3', 'mp3', 1, 'Audio', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(6, 'MPA', 'mpa', 1, 'Audio', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(7, 'OGG', 'ogg', 1, 'Audio', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(8, 'WAV', 'wav', 1, 'Audio', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(9, 'WMA', 'wma', 1, 'Audio', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(10, 'WPL', 'wpl', 1, 'Audio', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(11, '7Z', '7z', 2, 'Compressed', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(12, 'ARJ', 'arj', 2, 'Compressed', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(13, 'DEB', 'deb', 2, 'Compressed', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(14, 'PKG', 'pkg', 2, 'Compressed', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(15, 'RAR', 'rar', 2, 'Compressed', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(16, 'RPM', 'rpm', 2, 'Compressed', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(17, 'TAR.GZ', 'tar.gz', 2, 'Compressed', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(18, 'Z', 'z', 2, 'Compressed', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(19, 'ZIP', 'zip', 2, 'Compressed', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(20, 'BIN', 'bin', 3, 'Disk and Media', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(21, 'DMG', 'dmg', 3, 'Disk and Media', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(22, 'ISO', 'iso', 3, 'Disk and Media', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(23, 'TOAST', 'toast', 3, 'Disk and Media', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(24, 'VCD', 'vcd', 3, 'Disk and Media', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(25, 'CSV', 'csv', 4, 'Data and Database', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(26, 'DAT', 'dat', 4, 'Data and Database', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(27, 'DB', 'db', 4, 'Data and Database', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(28, 'DBF', 'dbf', 4, 'Data and Database', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(29, 'LOG', 'log', 4, 'Data and Database', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(30, 'MDB', 'mdb', 4, 'Data and Database', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(31, 'SAV', 'sav', 4, 'Data and Database', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(32, 'SQL', 'sql', 4, 'Data and Database', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(33, 'TAR', 'tar', 4, 'Data and Database', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(34, 'XML', 'xml', 4, 'Data and Database', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(35, 'EMAIL', 'email', 5, 'Email', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(36, 'EML', 'eml', 5, 'Email', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(37, 'EMLX', 'emlx', 5, 'Email', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(38, 'MSG', 'msg', 5, 'Email', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(39, 'OFT', 'oft', 5, 'Email', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(40, 'OST', 'ost', 5, 'Email', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(41, 'PST', 'pst', 5, 'Email', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(42, 'VCF', 'vcf', 5, 'Email', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(43, 'APK', 'apk', 6, 'Executable', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(44, 'BAT', 'bat', 6, 'Executable', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(45, 'BIN', 'bin', 6, 'Executable', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(46, 'CGI', 'cgi', 6, 'Executable', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(47, 'PL', 'pl', 6, 'Executable', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(48, 'COM', 'com', 6, 'Executable', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(49, 'EXE', 'exe', 6, 'Executable', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(50, 'GADGET', 'gadget', 6, 'Executable', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(51, 'JAR', 'jar', 6, 'Executable', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(52, 'WSF', 'wsf', 6, 'Executable', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(53, 'FNT', 'fnt', 7, 'Font', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(54, 'FON', 'fon', 7, 'Font', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(55, 'OTF', 'otf', 7, 'Font', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(56, 'TTF', 'ttf', 7, 'Font', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(57, 'AI', 'ai', 8, 'Image', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(58, 'BMP', 'bmp', 8, 'Image', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(59, 'GIF', 'gif', 8, 'Image', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(60, 'ICO', 'ico', 8, 'Image', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(61, 'JPG', 'jpg', 8, 'Image', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(62, 'JPEG', 'jpeg', 8, 'Image', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(63, 'PNG', 'png', 8, 'Image', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(64, 'PS', 'ps', 8, 'Image', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(65, 'PSD', 'psd', 8, 'Image', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(66, 'SVG', 'svg', 8, 'Image', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(67, 'TIF', 'tif', 8, 'Image', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(68, 'TIFF', 'tiff', 8, 'Image', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(69, 'WEBP', 'webp', 8, 'Image', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(70, 'ASP', 'asp', 9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(71, 'ASPX', 'aspx', 9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(72, 'CER', 'cer', 9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(73, 'CFM', 'cfm', 9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(74, 'CGI', 'cgi', 9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(75, 'PL', 'pl', 9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(76, 'CSS', 'css', 9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(77, 'HTM', 'htm', 9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(78, 'HTML', 'html', 9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(79, 'JS', 'js', 9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(80, 'JSP', 'jsp', 9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(81, 'PART', 'part', 9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(82, 'PHP', 'php', 9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(83, 'PY', 'py', 9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(84, 'RSS', 'rss', 9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(85, 'XHTML', 'xhtml', 9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(86, 'KEY', 'key', 10, 'Presentation', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(87, 'ODP', 'odp', 10, 'Presentation', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(88, 'PPS', 'pps', 10, 'Presentation', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(89, 'PPT', 'ppt', 10, 'Presentation', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(90, 'PPTX', 'pptx', 10, 'Presentation', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(91, 'ODS', 'ods', 11, 'Spreadsheet', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(92, 'XLS', 'xls', 11, 'Spreadsheet', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(93, 'XLSM', 'xlsm', 11, 'Spreadsheet', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(94, 'XLSX', 'xlsx', 11, 'Spreadsheet', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(95, 'BAK', 'bak', 12, 'System Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(96, 'CAB', 'cab', 12, 'System Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(97, 'CFG', 'cfg', 12, 'System Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(98, 'CPL', 'cpl', 12, 'System Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(99, 'CUR', 'cur', 12, 'System Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(100, 'DLL', 'dll', 12, 'System Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(101, 'DMP', 'dmp', 12, 'System Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(102, 'DRV', 'drv', 12, 'System Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(103, 'ICNS', 'icns', 12, 'System Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(104, 'INI', 'ini', 12, 'System Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(105, 'LNK', 'lnk', 12, 'System Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(106, 'MSI', 'msi', 12, 'System Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(107, 'SYS', 'sys', 12, 'System Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(108, 'TMP', 'tmp', 12, 'System Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(109, '3G2', '3g2', 13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(110, '3GP', '3gp', 13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(111, 'AVI', 'avi', 13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(112, 'FLV', 'flv', 13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(113, 'H264', 'h264', 13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(114, 'M4V', 'm4v', 13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(115, 'MKV', 'mkv', 13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(116, 'MOV', 'mov', 13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(117, 'MP4', 'mp4', 13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(118, 'MPG', 'mpg', 13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(119, 'MPEG', 'mpeg', 13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(120, 'RM', 'rm', 13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(121, 'SWF', 'swf', 13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(122, 'VOB', 'vob', 13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(123, 'WEBM', 'webm', 13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(124, 'WMV', 'wmv', 13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(125, 'DOC', 'doc', 14, 'Word Processor', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(126, 'DOCX', 'docx', 14, 'Word Processor', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(127, 'PDF', 'pdf', 14, 'Word Processor', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(128, 'RTF', 'rtf', 14, 'Word Processor', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(129, 'TEX', 'tex', 14, 'Word Processor', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(130, 'TXT', 'txt', 14, 'Word Processor', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(131, 'WPD', 'wpd', 14, 'Word Processor', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1);

--
-- Triggers `file_extension`
--
DROP TRIGGER IF EXISTS `trg_file_extension_insert`;
DELIMITER $$
CREATE TRIGGER `trg_file_extension_insert` AFTER INSERT ON `file_extension` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'File extension created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('file_extension', NEW.file_extension_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_file_extension_update`;
DELIMITER $$
CREATE TRIGGER `trg_file_extension_update` AFTER UPDATE ON `file_extension` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'File extension changed.<br/><br/>';

    IF NEW.file_extension_name <> OLD.file_extension_name THEN
        SET audit_log = CONCAT(audit_log, "File Extension Name: ", OLD.file_extension_name, " -> ", NEW.file_extension_name, "<br/>");
    END IF;

    IF NEW.file_extension <> OLD.file_extension THEN
        SET audit_log = CONCAT(audit_log, "File Extension: ", OLD.file_extension, " -> ", NEW.file_extension, "<br/>");
    END IF;

    IF NEW.file_type_name <> OLD.file_type_name THEN
        SET audit_log = CONCAT(audit_log, "File Type: ", OLD.file_type_name, " -> ", NEW.file_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'File extension changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('file_extension', NEW.file_extension_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `file_type`
--

DROP TABLE IF EXISTS `file_type`;
CREATE TABLE `file_type` (
  `file_type_id` int(10) UNSIGNED NOT NULL,
  `file_type_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `file_type`
--

INSERT INTO `file_type` (`file_type_id`, `file_type_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Audio', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2, 'Compressed', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3, 'Disk and Media', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(4, 'Data and Database', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(5, 'Email', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(6, 'Executable', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(7, 'Font', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(8, 'Image', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(9, 'Internet Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(10, 'Presentation', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(11, 'Spreadsheet', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(12, 'System Related', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(13, 'Video', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(14, 'Word Processor', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1);

--
-- Triggers `file_type`
--
DROP TRIGGER IF EXISTS `trg_file_type_insert`;
DELIMITER $$
CREATE TRIGGER `trg_file_type_insert` AFTER INSERT ON `file_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'File type created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('file_type', NEW.file_type_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_file_type_update`;
DELIMITER $$
CREATE TRIGGER `trg_file_type_update` AFTER UPDATE ON `file_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'File type changed.<br/><br/>';

    IF NEW.file_type_name <> OLD.file_type_name THEN
        SET audit_log = CONCAT(audit_log, "File Type Name: ", OLD.file_type_name, " -> ", NEW.file_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'File type changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('file_type', NEW.file_type_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `gender`
--

DROP TABLE IF EXISTS `gender`;
CREATE TABLE `gender` (
  `gender_id` int(10) UNSIGNED NOT NULL,
  `gender_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gender`
--

INSERT INTO `gender` (`gender_id`, `gender_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Male', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(2, 'Female', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1);

--
-- Triggers `gender`
--
DROP TRIGGER IF EXISTS `trg_gender_insert`;
DELIMITER $$
CREATE TRIGGER `trg_gender_insert` AFTER INSERT ON `gender` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Gender created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('gender', NEW.gender_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_gender_update`;
DELIMITER $$
CREATE TRIGGER `trg_gender_update` AFTER UPDATE ON `gender` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Gender changed.<br/><br/>';

    IF NEW.gender_name <> OLD.gender_name THEN
        SET audit_log = CONCAT(audit_log, "Gender Name: ", OLD.gender_name, " -> ", NEW.gender_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Gender changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('gender', NEW.gender_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `job_position`
--

DROP TABLE IF EXISTS `job_position`;
CREATE TABLE `job_position` (
  `job_position_id` int(10) UNSIGNED NOT NULL,
  `job_position_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `job_position`
--
DROP TRIGGER IF EXISTS `trg_job_position_insert`;
DELIMITER $$
CREATE TRIGGER `trg_job_position_insert` AFTER INSERT ON `job_position` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Job position created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('job_position', NEW.job_position_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_job_position_update`;
DELIMITER $$
CREATE TRIGGER `trg_job_position_update` AFTER UPDATE ON `job_position` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Job position changed.<br/><br/>';

    IF NEW.job_position_name <> OLD.job_position_name THEN
        SET audit_log = CONCAT(audit_log, "Job Position Name: ", OLD.job_position_name, " -> ", NEW.job_position_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Job position changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('job_position', NEW.job_position_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
CREATE TABLE `language` (
  `language_id` int(10) UNSIGNED NOT NULL,
  `language_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `language`
--

INSERT INTO `language` (`language_id`, `language_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Afrikaans', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(2, 'Amharic', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(3, 'Arabic', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(4, 'Assamese', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(5, 'Azerbaijani', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(6, 'Belarusian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(7, 'Bulgarian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(8, 'Bhojpuri', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(9, 'Bengali', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(10, 'Bosnian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(11, 'Catalan, Valencian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(12, 'Cebuano', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(13, 'Czech', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(14, 'Danish', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(15, 'German', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(16, 'English', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(17, 'Ewe', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(18, 'Greek, Modern', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(19, 'Spanish', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(20, 'Estonian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(21, 'Basque', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(22, 'Persian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(23, 'Fula', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(24, 'Finnish', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(25, 'French', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(26, 'Irish', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(27, 'Galician', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(28, 'Guarani', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(29, 'Gujarati', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(30, 'Hausa', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(31, 'Haitian Creole', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(32, 'Hebrew (modern)', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(33, 'Hindi', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(34, 'Chhattisgarhi', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(35, 'Croatian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(36, 'Hungarian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(37, 'Armenian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(38, 'Indonesian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(39, 'Igbo', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(40, 'Icelandic', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(41, 'Italian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(42, 'Japanese', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(43, 'Syro-Palestinian Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(44, 'Javanese', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(45, 'Georgian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(46, 'Kikuyu', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(47, 'Kyrgyz', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(48, 'Kuanyama', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(49, 'Kazakh', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(50, 'Khmer', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(51, 'Kannada', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(52, 'Korean', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(53, 'Krio', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(54, 'Kashmiri', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(55, 'Kurdish', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(56, 'Latin', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(57, 'Lithuanian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(58, 'Luxembourgish', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(59, 'Latvian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(60, 'Magahi', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(61, 'Maithili', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(62, 'Malagasy', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(63, 'Macedonian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(64, 'Malayalam', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(65, 'Mongolian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(66, 'Marathi (Marāṭhī)', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(67, 'Malay', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(68, 'Maltese', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(69, 'Burmese', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(70, 'Nepali', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(71, 'Dutch', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(72, 'Norwegian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(73, 'Oromo', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(74, 'Odia', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(75, 'Oromo', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(76, 'Panjabi, Punjabi', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(77, 'Polish', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(78, 'Pashto', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(79, 'Portuguese', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(80, 'Rundi', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(81, 'Romanian, Moldavian, Moldovan', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(82, 'Russian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(83, 'Kinyarwanda', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(84, 'Sindhi', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(85, 'Argentine Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(86, 'Brazilian Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(87, 'Chinese Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(88, 'Colombian Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(89, 'German Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(90, 'Algerian Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(91, 'Ecuadorian Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(92, 'Spanish Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(93, 'Ethiopian Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(94, 'French Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(95, 'British Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(96, 'Ghanaian Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(97, 'Irish Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(98, 'Indopakistani Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(99, 'Persian Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(100, 'Italian Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(101, 'Japanese Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(102, 'Kenyan Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(103, 'Korean Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(104, 'Moroccan Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(105, 'Mexican Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(106, 'Malaysian Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(107, 'Philippine Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(108, 'Polish Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(109, 'Portuguese Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(110, 'Russian Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(111, 'Saudi Arabian Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(112, 'El Salvadoran Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(113, 'Turkish Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(114, 'Tanzanian Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(115, 'Ukrainian Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(116, 'American Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(117, 'South African Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(118, 'Zimbabwe Sign Language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(119, 'Sinhala, Sinhalese', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(120, 'Slovak', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(121, 'Saraiki', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(122, 'Slovene', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(123, 'Shona', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(124, 'Somali', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(125, 'Albanian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(126, 'Serbian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(127, 'Swati', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(128, 'Sunda', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(129, 'Swedish', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(130, 'Swahili', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(131, 'Sylheti', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(132, 'Tagalog', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(133, 'Tamil', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(134, 'Telugu', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(135, 'Thai', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(136, 'Tibetan', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(137, 'Tigrinya', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(138, 'Turkmen', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(139, 'Tswana', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(140, 'Turkish', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(141, 'Uyghur', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(142, 'Ukrainian', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(143, 'Urdu', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(144, 'Uzbek', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(145, 'Vietnamese', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(146, 'Xhosa', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(147, 'Yiddish', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(148, 'Yoruba', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(149, 'Cantonese', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(150, 'Chinese', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(151, 'Zulu', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1);

--
-- Triggers `language`
--
DROP TRIGGER IF EXISTS `trg_language_insert`;
DELIMITER $$
CREATE TRIGGER `trg_language_insert` AFTER INSERT ON `language` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Language created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('language', NEW.language_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_language_update`;
DELIMITER $$
CREATE TRIGGER `trg_language_update` AFTER UPDATE ON `language` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Language changed.<br/><br/>';

    IF NEW.language_name <> OLD.language_name THEN
        SET audit_log = CONCAT(audit_log, "Language Name: ", OLD.language_name, " -> ", NEW.language_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Language changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('language', NEW.language_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `language_proficiency`
--

DROP TABLE IF EXISTS `language_proficiency`;
CREATE TABLE `language_proficiency` (
  `language_proficiency_id` int(10) UNSIGNED NOT NULL,
  `language_proficiency_name` varchar(100) NOT NULL,
  `language_proficiency_description` varchar(200) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `language_proficiency`
--

INSERT INTO `language_proficiency` (`language_proficiency_id`, `language_proficiency_name`, `language_proficiency_description`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Native', 'Fluent in the language, spoken at home', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(2, 'Fluent', 'Able to communicate effectively and accurately in most formal and informal conversations', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(3, 'Advanced', 'Able to communicate effectively and accurately in most formal and informal conversations, with some difficulty in complex situations', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(4, 'Intermediate', 'Able to communicate in everyday situations, with some difficulty in formal conversations', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(5, 'Basic', 'Able to communicate in very basic situations, with difficulty in everyday conversations', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(6, 'Non-proficient', 'No knowledge of the language', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1);

--
-- Triggers `language_proficiency`
--
DROP TRIGGER IF EXISTS `trg_language_proficiency_insert`;
DELIMITER $$
CREATE TRIGGER `trg_language_proficiency_insert` AFTER INSERT ON `language_proficiency` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Language proficiency created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('language_proficiency', NEW.language_proficiency_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_language_proficiency_update`;
DELIMITER $$
CREATE TRIGGER `trg_language_proficiency_update` AFTER UPDATE ON `language_proficiency` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Language proficiency changed.<br/><br/>';

    IF NEW.language_proficiency_name <> OLD.language_proficiency_name THEN
        SET audit_log = CONCAT(audit_log, "Language Proficiency Name: ", OLD.language_proficiency_name, " -> ", NEW.language_proficiency_name, "<br/>");
    END IF;

    IF NEW.language_proficiency_description <> OLD.language_proficiency_description THEN
        SET audit_log = CONCAT(audit_log, "Language Proficiency Description: ", OLD.language_proficiency_description, " -> ", NEW.language_proficiency_description, "<br/>");
    END IF;
    
    IF audit_log <> 'Language proficiency changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('language_proficiency', NEW.language_proficiency_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

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
  `attempt_time` datetime DEFAULT current_timestamp(),
  `success` tinyint(1) DEFAULT 0,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login_attempts`
--

INSERT INTO `login_attempts` (`login_attempts_id`, `user_account_id`, `email`, `ip_address`, `attempt_time`, `success`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 2, 'l.agulto@christianmotors.ph', '::1', '2025-10-21 21:41:38', 1, '2025-10-21 21:41:38', '2025-10-21 21:41:38', 1),
(2, 2, 'l.agulto@christianmotors.ph', '::1', '2025-10-21 21:48:16', 1, '2025-10-21 21:48:16', '2025-10-21 21:48:16', 1),
(3, 2, 'l.agulto@christianmotors.ph', '::1', '2025-10-22 09:21:27', 1, '2025-10-22 09:21:27', '2025-10-22 09:21:27', 1),
(4, 2, 'l.agulto@christianmotors.ph', '::1', '2025-10-22 21:18:07', 1, '2025-10-22 21:18:07', '2025-10-22 21:18:07', 1),
(5, 2, 'l.agulto@christianmotors.ph', '::1', '2025-10-23 08:58:34', 1, '2025-10-23 08:58:34', '2025-10-23 08:58:34', 1),
(6, 2, 'l.agulto@christianmotors.ph', '::1', '2025-10-23 19:42:35', 1, '2025-10-23 19:42:35', '2025-10-23 19:42:35', 1);

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
  `table_name` varchar(100) DEFAULT NULL,
  `order_sequence` tinyint(10) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_item`
--

INSERT INTO `menu_item` (`menu_item_id`, `menu_item_name`, `menu_item_url`, `menu_item_icon`, `app_module_id`, `app_module_name`, `parent_id`, `parent_name`, `table_name`, `order_sequence`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'App Module', 'app-module.php', '', 1, 'Settings', 0, '', 'app_module', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2, 'Settings', '', '', 1, 'Settings', 0, '', '', 80, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3, 'Users & Companies', '', '', 1, 'Settings', 0, '', '', 21, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(4, 'User Account', 'user-account.php', 'ki-outline ki-user', 1, 'Settings', 3, 'Users & Companies', 'user_account', 21, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(5, 'Company', 'company.php', 'ki-outline ki-shop', 1, 'Settings', 3, 'Users & Companies', 'company', 3, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(6, 'Role', 'role.php', '', 1, 'Settings', NULL, NULL, 'role', 3, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(7, 'User Interface', '', '', 1, 'Settings', NULL, NULL, '', 16, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(8, 'Menu Item', 'menu-item.php', 'ki-outline ki-data', 1, 'Settings', 7, 'User Interface', 'menu_item', 2, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(9, 'System Action', 'system-action.php', 'ki-outline ki-key-square', 1, 'Settings', 7, 'User Interface', 'system_action', 3, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(10, 'Account Settings', 'account-settings.php', '', 1, 'Settings', NULL, NULL, NULL, 127, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(11, 'Configurations', '', '', 1, 'Settings', 0, '', '', 50, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(12, 'Localization', '', 'ki-outline ki-compass', 1, 'Settings', 11, 'Configurations', '', 12, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(13, 'Country', 'country.php', '', 1, 'Settings', 12, 'Localization', 'country', 3, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(14, 'State', 'state.php', '', 1, 'Settings', 12, 'Localization', '', 19, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(15, 'City', 'city.php', '', 1, 'Settings', 12, 'Localization', 'city', 3, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(16, 'Currency', 'currency.php', '', 1, 'Settings', 12, 'Localization', 'currency', 3, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(17, 'Nationality', 'nationality.php', '', 1, 'Settings', 12, 'Localization', 'nationality', 20, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(18, 'Data Classification', '', 'ki-outline ki-file-up', 1, 'Settings', 11, 'Configurations', '', 4, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(19, 'File Type', 'file-type.php', '', 1, 'Settings', 18, 'Data Classification', 'file_type', 6, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(20, 'File Extension', 'file-extension.php', '', 1, 'Settings', 18, 'Data Classification', 'file_extension', 6, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(21, 'Upload Setting', 'upload-setting.php', 'ki-outline ki-exit-up', 1, 'Settings', 2, 'Settings', 'upload_setting', 21, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(22, 'Notification Setting', 'notification-setting.php', 'ki-outline ki-notification', 1, 'Settings', 2, 'Settings', 'notification_setting', 14, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(23, 'Banking', '', 'ki-outline ki-bank', 1, 'Settings', 11, 'Configurations', '', 2, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(24, 'Bank', 'bank.php', '', 1, 'Settings', 23, 'Banking', 'bank', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(25, 'Bank Account Type', 'bank-account-type.php', '', 1, 'Settings', 23, 'Banking', 'bank_account_type', 2, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(26, 'Contact Information', '', 'ki-outline ki-address-book', 1, 'Settings', 11, 'Configurations', '', 3, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(27, 'Address Type', 'address-type.php', '', 1, 'Settings', 26, 'Contact Information', 'address_type', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(28, 'Contact Information Type', 'contact-information-type.php', 'ki-outline ki-abstract', 1, 'Settings', 26, 'Contact Information', 'contact_information_type', 3, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(29, 'Language Settings', '', 'ki-outline ki-note-2', 1, 'Settings', 11, 'Configurations', '', 12, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(30, 'Language', 'language.php', '', 1, 'Settings', 29, 'Language Settings', 'language', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(31, 'Language Proficiency', 'language-proficiency.php', '', 1, 'Settings', 29, 'Language Settings', 'language_proficiency', 2, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(32, 'Profile Attribute', '', 'ki-outline ki-people', 1, 'Settings', 11, 'Configurations', '', 16, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(33, 'Blood Type', 'blood-type.php', '', 1, 'Settings', 32, 'Profile Attribute', 'blood_type', 2, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(34, 'Civil Status', 'civil-status.php', '', 1, 'Settings', 32, 'Profile Attribute', 'civil_status', 3, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(35, 'Educational Stage', 'educational-stage.php', '', 1, 'Settings', 32, 'Profile Attribute', 'educational_stage', 5, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(36, 'Gender', 'gender.php', '', 1, 'Settings', 32, 'Profile Attribute', 'gender', 7, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(37, 'Credential Type', 'credential-type.php', '', 1, 'Settings', 32, 'Profile Attribute', 'credential_type', 3, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(38, 'Relationship', 'relationship.php', '', 1, 'Settings', 32, 'Profile Attribute', 'relationship', 18, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(39, 'Religion', 'religion.php', '', 1, 'Settings', 32, 'Profile Attribute', 'religion', 19, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(40, 'Employee', 'employee.php', '', 2, 'Employee', 0, '', '', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(41, 'HR Configurations', '', '', 2, 'Employee', NULL, '', '', 99, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(42, 'Department', 'department.php', 'ki-outline ki-data', 2, 'Employee', 41, 'HR Configurations', 'department', 4, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(43, 'Departure Reason', 'departure-reason.php', 'ki-outline ki-user-square', 2, 'Employee', 41, 'HR Configurations', 'departure_reason', 4, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(44, 'Employment Location Type', 'employment-location-type.php', 'ki-outline ki-route', 2, 'Employee', 41, 'HR Configurations', 'employment_location_type', 5, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(45, 'Employment Type', 'employment-type.php', 'ki-outline ki-briefcase', 2, 'Employee', 41, 'HR Configurations', 'employment_type', 5, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(46, 'Job Position', 'job-position.php', 'ki-outline ki-questionnaire-tablet', 2, 'Employee', 41, 'HR Configurations', 'job_position', 10, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(47, 'Work Location', 'work-location.php', 'ki-outline ki-geolocation', 2, 'Employee', 41, 'HR Configurations', 'work_location', 23, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(48, 'Employee Document Type', 'employee-document-type.php', 'ki-outline ki-folder', 2, 'Employee', 41, 'HR Configurations', 'employee_document_type', 5, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(49, 'Inventory Configurations', '', '', 4, 'Inventory', 0, '', '', 99, '2025-10-21 21:42:16', '2025-10-21 21:42:16', 2),
(50, 'Attribute', 'attribute.php', 'ki-outline ki-more-2', 4, 'Inventory', 49, 'Inventory Configurations', 'attribute', 9, '2025-10-21 21:44:15', '2025-10-21 21:44:15', 2),
(51, 'Tax', 'tax.php', 'ki-outline ki-percentage', 4, 'Inventory', 49, 'Inventory Configurations', 'tax', 20, '2025-10-21 21:46:30', '2025-10-21 21:46:30', 2),
(52, 'Product Category', 'product-category.php', 'ki-outline ki-data', 4, 'Inventory', 49, 'Inventory Configurations', 'product_category', 16, '2025-10-21 21:49:03', '2025-10-21 21:49:07', 2),
(53, 'Supplier', 'supplier.php', 'ki-outline ki-logistic', 4, 'Inventory', 49, 'Inventory Configurations', 'supplier', 19, '2025-10-21 21:50:32', '2025-10-21 21:50:32', 2),
(54, 'Warehouse Management', '', 'ki-outline ki-home-3', 4, 'Inventory', 49, 'Inventory Configurations', '', 23, '2025-10-21 21:52:51', '2025-10-21 21:53:58', 2),
(55, 'Warehouse Type', 'warehouse-type.php', '', 4, 'Inventory', 54, 'Warehouse Management', 'warehouse_type', 23, '2025-10-21 21:53:24', '2025-10-21 21:53:24', 2),
(56, 'Warehouse', 'warehouse.php', '', 4, 'Inventory', 54, 'Warehouse Management', 'warehouse', 22, '2025-10-21 21:54:44', '2025-10-21 21:55:11', 2),
(57, 'Products', '', '', 4, 'Inventory', 0, '', '', 2, '2025-10-21 21:56:45', '2025-10-21 21:56:45', 2),
(58, 'Product', 'product.php', 'ki-outline ki-parcel', 4, 'Inventory', 57, 'Products', 'product', 1, '2025-10-21 21:57:38', '2025-10-21 21:57:38', 2),
(59, 'Pricelist', 'pricelist.php', 'ki-outline ki-tablet-text-down', 4, 'Inventory', 57, 'Products', 'product_pricelist', 5, '2025-10-21 21:59:20', '2025-10-21 21:59:20', 2),
(60, 'Product Variant', 'product-variant.php', 'ki-outline ki-lots-shopping', 4, 'Inventory', 57, 'Products', 'product_variant', 4, '2025-10-21 22:00:43', '2025-10-21 22:00:43', 2),
(61, 'Inventory Operations', '', '', 4, 'Inventory', 0, '', '', 3, '2025-10-21 22:02:16', '2025-10-21 22:02:16', 2),
(62, 'Inventory Transfer', '', 'ki-outline ki-courier', 4, 'Inventory', 61, 'Inventory Operations', '', 1, '2025-10-21 22:04:01', '2025-10-21 22:04:01', 2),
(63, 'Receipts', 'inventory-receipts.php', '', 4, 'Inventory', 62, 'Inventory Transfer', '', 1, '2025-10-21 22:05:28', '2025-10-21 22:06:45', 2),
(64, 'Delivery', 'inventory-delivery.php', '', 4, 'Inventory', 62, 'Inventory Transfer', '', 2, '2025-10-21 22:06:13', '2025-10-21 22:06:13', 2),
(65, 'Inventory Adjustments', '', 'ki-outline ki-setting-4', 4, 'Inventory', 61, 'Inventory Operations', '', 2, '2025-10-21 22:11:13', '2025-10-21 22:11:13', 2),
(66, 'Physical Inventory', 'physical-inventory.php', '', 4, 'Inventory', 65, 'Inventory Adjustments', '', 1, '2025-10-21 22:12:25', '2025-10-21 22:12:25', 2),
(67, 'Scrap', 'inventory-scrap.php', '', 4, 'Inventory', 65, 'Inventory Adjustments', '', 2, '2025-10-21 22:13:01', '2025-10-21 22:13:01', 2),
(68, 'Inventory Procurement', '', 'ki-outline ki-cheque', 4, 'Inventory', 61, 'Inventory Operations', '', 3, '2025-10-21 22:14:11', '2025-10-21 22:14:11', 2),
(69, 'Replenishment', 'inventory-replenishment.php', '', 4, 'Inventory', 68, 'Inventory Procurement', '', 1, '2025-10-21 22:15:19', '2025-10-21 22:15:19', 2);

--
-- Triggers `menu_item`
--
DROP TRIGGER IF EXISTS `trg_menu_item_insert`;
DELIMITER $$
CREATE TRIGGER `trg_menu_item_insert` AFTER INSERT ON `menu_item` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Menu item created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('menu_item', NEW.menu_item_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_menu_item_update`;
DELIMITER $$
CREATE TRIGGER `trg_menu_item_update` AFTER UPDATE ON `menu_item` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Menu item changed.<br/><br/>';

    IF NEW.menu_item_name <> OLD.menu_item_name THEN
        SET audit_log = CONCAT(audit_log, "Menu Item Name: ", OLD.menu_item_name, " -> ", NEW.menu_item_name, "<br/>");
    END IF;

    IF NEW.menu_item_url <> OLD.menu_item_url THEN
        SET audit_log = CONCAT(audit_log, "Menu Item URL: ", OLD.menu_item_url, " -> ", NEW.menu_item_url, "<br/>");
    END IF;

    IF NEW.menu_item_icon <> OLD.menu_item_icon THEN
        SET audit_log = CONCAT(audit_log, "Menu Icon: ", OLD.menu_item_icon, " -> ", NEW.menu_item_icon, "<br/>");
    END IF;

    IF NEW.app_module_name <> OLD.app_module_name THEN
        SET audit_log = CONCAT(audit_log, "App Module: ", OLD.app_module_name, " -> ", NEW.app_module_name, "<br/>");
    END IF;

    IF NEW.parent_name <> OLD.parent_name THEN
        SET audit_log = CONCAT(audit_log, "Parent Menu: ", OLD.parent_name, " -> ", NEW.parent_name, "<br/>");
    END IF;

    IF NEW.order_sequence <> OLD.order_sequence THEN
        SET audit_log = CONCAT(audit_log, "Order Sequence: ", OLD.order_sequence, " -> ", NEW.order_sequence, "<br/>");
    END IF;

    IF NEW.table_name <> OLD.table_name THEN
        SET audit_log = CONCAT(audit_log, "Export Table: ", OLD.table_name, " -> ", NEW.table_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Menu item changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('menu_item', NEW.menu_item_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `nationality`
--

DROP TABLE IF EXISTS `nationality`;
CREATE TABLE `nationality` (
  `nationality_id` int(10) UNSIGNED NOT NULL,
  `nationality_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nationality`
--

INSERT INTO `nationality` (`nationality_id`, `nationality_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Afghan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(2, 'Albanian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(3, 'Algerian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(4, 'American', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(5, 'Andorran', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(6, 'Angolan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(7, 'Argentine', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(8, 'Armenian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(9, 'Australian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(10, 'Austrian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(11, 'Azerbaijani', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(12, 'Bahamian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(13, 'Bahraini', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(14, 'Bangladeshi', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(15, 'Barbadian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(16, 'Belarusian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(17, 'Belgian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(18, 'Belizean', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(19, 'Beninese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(20, 'Bhutanese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(21, 'Bolivian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(22, 'Bosnian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(23, 'Brazilian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(24, 'British', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(25, 'Bruneian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(26, 'Bulgarian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(27, 'Burkinabe', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(28, 'Burmese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(29, 'Burundian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(30, 'Cambodian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(31, 'Cameroonian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(32, 'Canadian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(33, 'Cape Verdean', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(34, 'Central African', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(35, 'Chadian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(36, 'Chilean', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(37, 'Chinese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(38, 'Colombian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(39, 'Comorian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(40, 'Congolese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(41, 'Costa Rican', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(42, 'Croatian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(43, 'Cuban', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(44, 'Cypriot', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(45, 'Czech', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(46, 'Danish', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(47, 'Djiboutian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(48, 'Dominican', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(49, 'Dutch', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(50, 'Ecuadorian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(51, 'Egyptian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(52, 'Emirati', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(53, 'English', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(54, 'Equatorial Guinean', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(55, 'Eritrean', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(56, 'Estonian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(57, 'Ethiopian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(58, 'Fijian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(59, 'Finnish', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(60, 'French', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(61, 'Gabonese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(62, 'Gambian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(63, 'Georgian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(64, 'German', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(65, 'Ghanaian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(66, 'Greek', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(67, 'Grenadian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(68, 'Guatemalan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(69, 'Guinean', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(70, 'Guyanese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(71, 'Haitian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(72, 'Honduran', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(73, 'Hungarian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(74, 'Icelandic', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(75, 'Indian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(76, 'Indonesian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(77, 'Iranian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(78, 'Iraqi', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(79, 'Irish', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(80, 'Israeli', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(81, 'Italian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(82, 'Ivorian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(83, 'Jamaican', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(84, 'Japanese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(85, 'Jordanian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(86, 'Kazakh', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(87, 'Kenyan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(88, 'Kiribati', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(89, 'Kuwaiti', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(90, 'Kyrgyz', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(91, 'Lao', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(92, 'Latvian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(93, 'Lebanese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(94, 'Liberian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(95, 'Libyan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(96, 'Liechtenstein', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(97, 'Lithuanian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(98, 'Luxembourgish', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(99, 'Macedonian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(100, 'Malagasy', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(101, 'Malawian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(102, 'Malaysian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(103, 'Maldivian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(104, 'Malian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(105, 'Maltese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(106, 'Marshallese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(107, 'Mauritanian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(108, 'Mauritian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(109, 'Mexican', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(110, 'Micronesian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(111, 'Moldovan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(112, 'Monacan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(113, 'Mongolian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(114, 'Montenegrin', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(115, 'Moroccan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(116, 'Mozambican', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(117, 'Namibian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(118, 'Nauruan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(119, 'Nepalese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(120, 'New Zealander', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(121, 'Nicaraguan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(122, 'Nigerien', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(123, 'Nigerian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(124, 'North Korean', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(125, 'Norwegian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(126, 'Omani', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(127, 'Pakistani', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(128, 'Palauan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(129, 'Palestinian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(130, 'Panamanian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(131, 'Papua New Guinean', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(132, 'Paraguayan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(133, 'Peruvian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(134, 'Philippine', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(135, 'Polish', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(136, 'Portuguese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(137, 'Qatari', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(138, 'Romanian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(139, 'Russian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(140, 'Rwandan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(141, 'Saint Lucian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(142, 'Salvadoran', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(143, 'Samoan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(144, 'San Marinese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(145, 'Sao Tomean', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(146, 'Saudi', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(147, 'Scottish', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(148, 'Senegalese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(149, 'Serbian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(150, 'Seychellois', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(151, 'Sierra Leonean', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(152, 'Singaporean', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(153, 'Slovak', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(154, 'Slovenian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(155, 'Solomon Islander', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(156, 'Somali', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(157, 'South African', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(158, 'South Korean', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(159, 'Spanish', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(160, 'Sri Lankan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(161, 'Sudanese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(162, 'Surinamese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(163, 'Swazi', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(164, 'Swedish', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(165, 'Swiss', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(166, 'Syrian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(167, 'Taiwanese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(168, 'Tajik', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(169, 'Tanzanian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(170, 'Thai', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(171, 'Togolese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(172, 'Tongan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(173, 'Trinidadian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(174, 'Tunisian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(175, 'Turkish', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(176, 'Turkmen', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(177, 'Tuvaluan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(178, 'Ugandan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(179, 'Ukrainian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(180, 'Uruguayan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(181, 'Uzbek', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(182, 'Vanuatuan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(183, 'Vatican', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(184, 'Venezuelan', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(185, 'Vietnamese', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(186, 'Welsh', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(187, 'Yemeni', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(188, 'Zambian', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1),
(189, 'Zimbabwean', '2025-10-21 21:38:01', '2025-10-21 21:38:01', 1);

--
-- Triggers `nationality`
--
DROP TRIGGER IF EXISTS `trg_nationality_insert`;
DELIMITER $$
CREATE TRIGGER `trg_nationality_insert` AFTER INSERT ON `nationality` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Nationality created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('nationality', NEW.nationality_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_nationality_update`;
DELIMITER $$
CREATE TRIGGER `trg_nationality_update` AFTER UPDATE ON `nationality` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Nationality changed.<br/><br/>';

    IF NEW.nationality_name <> OLD.nationality_name THEN
        SET audit_log = CONCAT(audit_log, "Nationality Name: ", OLD.nationality_name, " -> ", NEW.nationality_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Nationality changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('nationality', NEW.nationality_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `notification_setting`
--

DROP TABLE IF EXISTS `notification_setting`;
CREATE TABLE `notification_setting` (
  `notification_setting_id` int(10) UNSIGNED NOT NULL,
  `notification_setting_name` varchar(100) NOT NULL,
  `notification_setting_description` varchar(200) NOT NULL,
  `system_notification` int(1) DEFAULT 1,
  `email_notification` int(1) DEFAULT 0,
  `sms_notification` int(1) DEFAULT 0,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notification_setting`
--

INSERT INTO `notification_setting` (`notification_setting_id`, `notification_setting_name`, `notification_setting_description`, `system_notification`, `email_notification`, `sms_notification`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Login OTP', 'Sent when a user receives a login OTP.', 0, 1, 0, '2025-10-21 21:37:59', '2025-10-21 21:37:59', 1),
(2, 'Forgot Password', 'Sent when a user requests a password reset.', 0, 1, 0, '2025-10-21 21:37:59', '2025-10-21 21:37:59', 1);

--
-- Triggers `notification_setting`
--
DROP TRIGGER IF EXISTS `trg_notification_setting_insert`;
DELIMITER $$
CREATE TRIGGER `trg_notification_setting_insert` AFTER INSERT ON `notification_setting` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Notification setting created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('notification_setting', NEW.notification_setting_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_notification_setting_update`;
DELIMITER $$
CREATE TRIGGER `trg_notification_setting_update` AFTER UPDATE ON `notification_setting` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Notification setting changed.<br/><br/>';

    IF NEW.notification_setting_name <> OLD.notification_setting_name THEN
        SET audit_log = CONCAT(audit_log, "Notification Setting Name: ", OLD.notification_setting_name, " -> ", NEW.notification_setting_name, "<br/>");
    END IF;

    IF NEW.notification_setting_description <> OLD.notification_setting_description THEN
        SET audit_log = CONCAT(audit_log, "Notification Setting Description: ", OLD.notification_setting_description, " -> ", NEW.notification_setting_description, "<br/>");
    END IF;

    IF NEW.system_notification <> OLD.system_notification THEN
        SET audit_log = CONCAT(audit_log, "System Notification: ", OLD.system_notification, " -> ", NEW.system_notification, "<br/>");
    END IF;

    IF NEW.email_notification <> OLD.email_notification THEN
        SET audit_log = CONCAT(audit_log, "Notification Notification: ", OLD.email_notification, " -> ", NEW.email_notification, "<br/>");
    END IF;

    IF NEW.sms_notification <> OLD.sms_notification THEN
        SET audit_log = CONCAT(audit_log, "SMS Notification: ", OLD.sms_notification, " -> ", NEW.sms_notification, "<br/>");
    END IF;

    IF audit_log <> 'Notification setting changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('notification_setting', NEW.notification_setting_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

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
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notification_setting_email_template`
--

INSERT INTO `notification_setting_email_template` (`notification_setting_email_id`, `notification_setting_id`, `email_notification_subject`, `email_notification_body`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 1, 'Login OTP - Secure Access to Your Account', '<p>Your One-Time Password (OTP) is:</p><p><strong>#{OTP_CODE}</strong></p><p>This code is valid for <strong>#{OTP_CODE_VALIDITY}</strong>.</p><p>If you did not request this, please ignore.</p>', '2025-10-21 21:37:59', '2025-10-21 21:37:59', 1),
(2, 2, 'Password Reset Request - Action Required', '<p>Click the link to reset your password:</p><p><a href=\"#{RESET_LINK}\">Password Reset Link</a></p><p>Link expires after <strong>#{RESET_LINK_VALIDITY}</strong>.</p><p>If not requested, ignore this email.</p>', '2025-10-21 21:37:59', '2025-10-21 21:37:59', 1);

--
-- Triggers `notification_setting_email_template`
--
DROP TRIGGER IF EXISTS `trg_notification_email_template_insert`;
DELIMITER $$
CREATE TRIGGER `trg_notification_email_template_insert` AFTER INSERT ON `notification_setting_email_template` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Notification notification template created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('notification_setting_email_template', NEW.notification_setting_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_notification_email_template_update`;
DELIMITER $$
CREATE TRIGGER `trg_notification_email_template_update` AFTER UPDATE ON `notification_setting_email_template` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Notification notification template changed.<br/><br/>';

    IF NEW.email_notification_subject <> OLD.email_notification_subject THEN
        SET audit_log = CONCAT(audit_log, "Notification Notification Subject: ", OLD.email_notification_subject, " -> ", NEW.email_notification_subject, "<br/>");
    END IF;

    IF NEW.email_notification_body <> OLD.email_notification_body THEN
        SET audit_log = CONCAT(audit_log, "Notification Notification Body: ", OLD.email_notification_body, " -> ", NEW.email_notification_body, "<br/>");
    END IF;

    IF audit_log <> 'Notification notification template changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('notification_setting_email_template', NEW.notification_setting_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

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
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `notification_setting_sms_template`
--
DROP TRIGGER IF EXISTS `trg_notification_sms_template_insert`;
DELIMITER $$
CREATE TRIGGER `trg_notification_sms_template_insert` AFTER INSERT ON `notification_setting_sms_template` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'SMS notification template created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('notification_setting_sms_template', NEW.notification_setting_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_notification_sms_template_update`;
DELIMITER $$
CREATE TRIGGER `trg_notification_sms_template_update` AFTER UPDATE ON `notification_setting_sms_template` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'SMS notification template changed.<br/><br/>';

    IF NEW.sms_notification_message <> OLD.sms_notification_message THEN
        SET audit_log = CONCAT(audit_log, "SMS Notification Message: ", OLD.sms_notification_message, " -> ", NEW.sms_notification_message, "<br/>");
    END IF;

    IF audit_log <> 'SMS notification template changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('notification_setting_sms_template', NEW.notification_setting_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

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
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `notification_setting_system_template`
--
DROP TRIGGER IF EXISTS `trg_notification_system_template_insert`;
DELIMITER $$
CREATE TRIGGER `trg_notification_system_template_insert` AFTER INSERT ON `notification_setting_system_template` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'System notification template created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('notification_setting_system_template', NEW.notification_setting_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_notification_system_template_update`;
DELIMITER $$
CREATE TRIGGER `trg_notification_system_template_update` AFTER UPDATE ON `notification_setting_system_template` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'System notification template changed.<br/><br/>';

    IF NEW.system_notification_title <> OLD.system_notification_title THEN
        SET audit_log = CONCAT(audit_log, "System Notification Title: ", OLD.system_notification_title, " -> ", NEW.system_notification_title, "<br/>");
    END IF;

    IF NEW.system_notification_message <> OLD.system_notification_message THEN
        SET audit_log = CONCAT(audit_log, "System Notification Message: ", OLD.system_notification_message, " -> ", NEW.system_notification_message, "<br/>");
    END IF;

    IF audit_log <> 'System notification template changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('notification_setting_system_template', NEW.notification_setting_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `otp`
--

DROP TABLE IF EXISTS `otp`;
CREATE TABLE `otp` (
  `otp_id` int(11) NOT NULL,
  `user_account_id` int(10) UNSIGNED NOT NULL,
  `otp` varchar(255) DEFAULT NULL,
  `otp_expiry_date` datetime DEFAULT NULL,
  `failed_otp_attempts` tinyint(3) UNSIGNED DEFAULT 0,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `product_description` varchar(1000) NOT NULL,
  `product_image` varchar(500) DEFAULT NULL,
  `product_type` enum('Goods','Services') DEFAULT 'Goods',
  `sku` varchar(200) DEFAULT NULL,
  `barcode` varchar(200) DEFAULT NULL,
  `is_sellable` enum('Yes','No') DEFAULT 'Yes',
  `is_purchasable` enum('Yes','No') DEFAULT 'Yes',
  `show_on_pos` enum('Yes','No') DEFAULT 'Yes',
  `quantity_on_hand` int(11) DEFAULT 0,
  `sales_price` double DEFAULT 0,
  `cost` double DEFAULT 0,
  `discount_type` enum('Fixed','None','Percentage') DEFAULT 'None',
  `discount_rate` decimal(5,2) DEFAULT 0.00,
  `weight` decimal(5,2) DEFAULT 0.00,
  `width` decimal(5,2) DEFAULT 0.00,
  `height` decimal(5,2) DEFAULT 0.00,
  `length` decimal(5,2) DEFAULT 0.00,
  `product_status` enum('Active','Archived') DEFAULT 'Active',
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `product_description`, `product_image`, `product_type`, `sku`, `barcode`, `is_sellable`, `is_purchasable`, `show_on_pos`, `quantity_on_hand`, `sales_price`, `cost`, `discount_type`, `discount_rate`, `weight`, `width`, `height`, `length`, `product_status`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'test', '', NULL, 'Goods', NULL, NULL, 'Yes', 'Yes', 'Yes', 0, 0, 0, 'None', 0.00, 0.00, 0.00, 0.00, 0.00, 'Active', '2025-10-23 17:21:54', '2025-10-23 17:21:54', 2),
(2, 'testtest', 'testtest\n', 'storage/uploads/product/2/ls9jFRr.png', 'Services', '1', '1', 'Yes', 'Yes', 'Yes', 1, 0, 0, 'Fixed', 0.00, 1.00, 2.00, 3.00, 4.00, 'Active', '2025-10-23 19:42:48', '2025-10-23 23:41:15', 2);

--
-- Triggers `product`
--
DROP TRIGGER IF EXISTS `trg_product_insert`;
DELIMITER $$
CREATE TRIGGER `trg_product_insert` AFTER INSERT ON `product` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Product created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('product', NEW.product_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_product_update`;
DELIMITER $$
CREATE TRIGGER `trg_product_update` AFTER UPDATE ON `product` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Product changed.<br/><br/>';

    IF NEW.product_name <> OLD.product_name THEN
        SET audit_log = CONCAT(audit_log, "Product Name: ", OLD.product_name, " -> ", NEW.product_name, "<br/>");
    END IF;

    IF NEW.product_description <> OLD.product_description THEN
        SET audit_log = CONCAT(audit_log, "Product Description: ", OLD.product_description, " -> ", NEW.product_description, "<br/>");
    END IF;

    IF NEW.product_type <> OLD.product_type THEN
        SET audit_log = CONCAT(audit_log, "Product Type: ", OLD.product_type, " -> ", NEW.product_type, "<br/>");
    END IF;

    IF NEW.sku <> OLD.sku THEN
        SET audit_log = CONCAT(audit_log, "SKU: ", OLD.sku, " -> ", NEW.sku, "<br/>");
    END IF;

    IF NEW.barcode <> OLD.barcode THEN
        SET audit_log = CONCAT(audit_log, "Barcode: ", OLD.barcode, " -> ", NEW.barcode, "<br/>");
    END IF;

    IF NEW.is_sellable <> OLD.is_sellable THEN
        SET audit_log = CONCAT(audit_log, "Is Sellable: ", OLD.is_sellable, " -> ", NEW.is_sellable, "<br/>");
    END IF;

    IF NEW.is_purchasable <> OLD.is_purchasable THEN
        SET audit_log = CONCAT(audit_log, "Is Purchasable: ", OLD.is_purchasable, " -> ", NEW.is_purchasable, "<br/>");
    END IF;

    IF NEW.show_on_pos <> OLD.show_on_pos THEN
        SET audit_log = CONCAT(audit_log, "Show on POS: ", OLD.show_on_pos, " -> ", NEW.show_on_pos, "<br/>");
    END IF;

    IF NEW.quantity_on_hand <> OLD.quantity_on_hand THEN
        SET audit_log = CONCAT(audit_log, "Quantity On Hand: ", OLD.quantity_on_hand, " -> ", NEW.quantity_on_hand, "<br/>");
    END IF;

    IF NEW.sales_price <> OLD.sales_price THEN
        SET audit_log = CONCAT(audit_log, "Sales Price: ", OLD.sales_price, " -> ", NEW.sales_price, "<br/>");
    END IF;

    IF NEW.cost <> OLD.cost THEN
        SET audit_log = CONCAT(audit_log, "Cost: ", OLD.cost, " -> ", NEW.cost, "<br/>");
    END IF;

    IF NEW.discount_type <> OLD.discount_type THEN
        SET audit_log = CONCAT(audit_log, "Discount Type: ", OLD.discount_type, " -> ", NEW.discount_type, "<br/>");
    END IF;

    IF NEW.discount_rate <> OLD.discount_rate THEN
        SET audit_log = CONCAT(audit_log, "Discount Rate: ", OLD.discount_rate, " -> ", NEW.discount_rate, "<br/>");
    END IF;

    IF NEW.weight <> OLD.weight THEN
        SET audit_log = CONCAT(audit_log, "Weight: ", OLD.weight, " -> ", NEW.weight, " kg<br/>");
    END IF;

    IF NEW.width <> OLD.width THEN
        SET audit_log = CONCAT(audit_log, "Width: ", OLD.width, " -> ", NEW.width, " cm<br/>");
    END IF;

    IF NEW.height <> OLD.height THEN
        SET audit_log = CONCAT(audit_log, "Height: ", OLD.height, " -> ", NEW.height, " cm<br/>");
    END IF;

    IF NEW.length <> OLD.length THEN
        SET audit_log = CONCAT(audit_log, "Length: ", OLD.length, " -> ", NEW.length, " cm<br/>");
    END IF;

    IF NEW.product_status <> OLD.product_status THEN
        SET audit_log = CONCAT(audit_log, "Product Status: ", OLD.product_status, " -> ", NEW.product_status, "<br/>");
    END IF;
    
    IF audit_log <> 'Product changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('product', NEW.product_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

DROP TABLE IF EXISTS `product_categories`;
CREATE TABLE `product_categories` (
  `product_categories_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `product_category_id` int(10) UNSIGNED NOT NULL,
  `product_category_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`product_categories_id`, `product_id`, `product_name`, `product_category_id`, `product_category_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(4, 2, 'testtest', 6, 'rwar', '2025-10-24 00:08:03', '2025-10-24 00:08:03', 2),
(5, 2, 'testtest', 5, 'teste', '2025-10-24 00:08:03', '2025-10-24 00:08:03', 2),
(6, 1, 'test', 6, 'rwar', '2025-10-24 00:15:00', '2025-10-24 00:15:00', 2);

--
-- Triggers `product_categories`
--
DROP TRIGGER IF EXISTS `trg_product_categories_insert`;
DELIMITER $$
CREATE TRIGGER `trg_product_categories_insert` AFTER INSERT ON `product_categories` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Product categories created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('product_categories', NEW.product_categories_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_product_categories_update`;
DELIMITER $$
CREATE TRIGGER `trg_product_categories_update` AFTER UPDATE ON `product_categories` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Product categories changed.<br/><br/>';

    IF NEW.product_name <> OLD.product_name THEN
        SET audit_log = CONCAT(audit_log, "Product: ", OLD.product_name, " -> ", NEW.product_name, "<br/>");
    END IF;

    IF NEW.product_category_name <> OLD.product_category_name THEN
        SET audit_log = CONCAT(audit_log, "Product Category: ", OLD.product_category_name, " -> ", NEW.product_category_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Product categories changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('product_categories', NEW.product_categories_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category` (
  `product_category_id` int(10) UNSIGNED NOT NULL,
  `product_category_name` varchar(100) NOT NULL,
  `parent_category_id` int(10) UNSIGNED DEFAULT NULL,
  `parent_category_name` varchar(100) NOT NULL,
  `costing_method` enum('Average Cost','First In First Out','Standard Price') DEFAULT 'Standard Price',
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_category`
--

INSERT INTO `product_category` (`product_category_id`, `product_category_name`, `parent_category_id`, `parent_category_name`, `costing_method`, `created_date`, `last_updated`, `last_log_by`) VALUES
(5, 'teste', 0, '', 'First In First Out', '2025-10-23 10:23:44', '2025-10-23 10:23:44', 2),
(6, 'rwar', 0, '', 'Average Cost', '2025-10-24 00:07:55', '2025-10-24 00:07:55', 2);

--
-- Triggers `product_category`
--
DROP TRIGGER IF EXISTS `trg_product_category_insert`;
DELIMITER $$
CREATE TRIGGER `trg_product_category_insert` AFTER INSERT ON `product_category` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Product category created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('product_category', NEW.product_category_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_product_category_update`;
DELIMITER $$
CREATE TRIGGER `trg_product_category_update` AFTER UPDATE ON `product_category` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Product category changed.<br/><br/>';

    IF NEW.product_category_name <> OLD.product_category_name THEN
        SET audit_log = CONCAT(audit_log, "Product Category Name: ", OLD.product_category_name, " -> ", NEW.product_category_name, "<br/>");
    END IF;

    IF NEW.parent_category_name <> OLD.parent_category_name THEN
        SET audit_log = CONCAT(audit_log, "Parent Category: ", OLD.parent_category_name, " -> ", NEW.parent_category_name, "<br/>");
    END IF;

    IF NEW.costing_method <> OLD.costing_method THEN
        SET audit_log = CONCAT(audit_log, "Costing Method: ", OLD.costing_method, " -> ", NEW.costing_method, "<br/>");
    END IF;
    
    IF audit_log <> 'Product category changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('product_category', NEW.product_category_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product_pricelist`
--

DROP TABLE IF EXISTS `product_pricelist`;
CREATE TABLE `product_pricelist` (
  `product_pricelist_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `product_variant_id` int(10) UNSIGNED DEFAULT NULL,
  `rule_type` enum('Add-On','Discount') DEFAULT 'Discount',
  `pricelist_computation` enum('Fixed','Percentage') DEFAULT 'Percentage',
  `pricelist_rate` decimal(5,2) DEFAULT 0.00,
  `validity_start_date` date NOT NULL,
  `validity_end_date` date DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `product_pricelist`
--
DROP TRIGGER IF EXISTS `trg_product_pricelist_insert`;
DELIMITER $$
CREATE TRIGGER `trg_product_pricelist_insert` AFTER INSERT ON `product_pricelist` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Product pricelist created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('product_pricelist', NEW.product_pricelist_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_product_pricelist_update`;
DELIMITER $$
CREATE TRIGGER `trg_product_pricelist_update` AFTER UPDATE ON `product_pricelist` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Product pricelist changed.<br/><br/>';

    IF NEW.product_name <> OLD.product_name THEN
        SET audit_log = CONCAT(audit_log, "Product Name: ", OLD.product_name, " -> ", NEW.product_name, "<br/>");
    END IF;

    IF NEW.rule_type <> OLD.rule_type THEN
        SET audit_log = CONCAT(audit_log, "Rule Type: ", OLD.rule_type, " -> ", NEW.rule_type, "<br/>");
    END IF;

    IF NEW.pricelist_computation <> OLD.pricelist_computation THEN
        SET audit_log = CONCAT(audit_log, "Pricelist Computation: ", OLD.pricelist_computation, " -> ", NEW.pricelist_computation, "<br/>");
    END IF;

    IF NEW.pricelist_rate <> OLD.pricelist_rate THEN
        SET audit_log = CONCAT(audit_log, "Pricelist Rate: ", OLD.pricelist_rate, " -> ", NEW.pricelist_rate, "<br/>");
    END IF;

    IF NEW.validity_start_date <> OLD.validity_start_date THEN
        SET audit_log = CONCAT(audit_log, "Validity Start Date: ", OLD.validity_start_date, " -> ", NEW.validity_start_date, "<br/>");
    END IF;

    IF NEW.validity_end_date <> OLD.validity_end_date THEN
        SET audit_log = CONCAT(audit_log, "Validity End Date: ", OLD.validity_end_date, " -> ", NEW.validity_end_date, "<br/>");
    END IF;
    
    IF audit_log <> 'Product pricelist changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('product_pricelist', NEW.product_pricelist_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product_tax`
--

DROP TABLE IF EXISTS `product_tax`;
CREATE TABLE `product_tax` (
  `product_tax_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `tax_type` enum('Purchases','Sales') DEFAULT NULL,
  `tax_id` int(10) UNSIGNED NOT NULL,
  `tax_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `product_tax`
--
DROP TRIGGER IF EXISTS `trg_product_tax_insert`;
DELIMITER $$
CREATE TRIGGER `trg_product_tax_insert` AFTER INSERT ON `product_tax` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Product tax created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('product_tax', NEW.product_tax_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_product_tax_update`;
DELIMITER $$
CREATE TRIGGER `trg_product_tax_update` AFTER UPDATE ON `product_tax` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Product tax changed.<br/><br/>';

    IF NEW.product_name <> OLD.product_name THEN
        SET audit_log = CONCAT(audit_log, "Product: ", OLD.product_name, " -> ", NEW.product_name, "<br/>");
    END IF;

    IF NEW.tax_type <> OLD.tax_type THEN
        SET audit_log = CONCAT(audit_log, "Tax Type: ", OLD.tax_type, " -> ", NEW.tax_type, "<br/>");
    END IF;

    IF NEW.tax_name <> OLD.tax_name THEN
        SET audit_log = CONCAT(audit_log, "Tax: ", OLD.tax_name, " -> ", NEW.tax_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Product tax changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('product_tax', NEW.product_tax_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product_variant`
--

DROP TABLE IF EXISTS `product_variant`;
CREATE TABLE `product_variant` (
  `product_variant_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `product_variant_image` varchar(500) DEFAULT NULL,
  `attribute_value_id` int(10) UNSIGNED NOT NULL,
  `attribute_value_name` varchar(100) NOT NULL,
  `attribute_id` int(10) UNSIGNED NOT NULL,
  `attribute_name` varchar(100) NOT NULL,
  `extra_price` double DEFAULT 0,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `product_variant`
--
DROP TRIGGER IF EXISTS `trg_product_variant_insert`;
DELIMITER $$
CREATE TRIGGER `trg_product_variant_insert` AFTER INSERT ON `product_variant` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Product variant created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('product_variant', NEW.product_variant_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_product_variant_update`;
DELIMITER $$
CREATE TRIGGER `trg_product_variant_update` AFTER UPDATE ON `product_variant` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Product variant changed.<br/><br/>';

    IF NEW.product_name <> OLD.product_name THEN
        SET audit_log = CONCAT(audit_log, "Product: ", OLD.product_name, " -> ", NEW.product_name, "<br/>");
    END IF;

    IF NEW.attribute_value_name <> OLD.attribute_value_name THEN
        SET audit_log = CONCAT(audit_log, "Attribute Value: ", OLD.attribute_value_name, " -> ", NEW.attribute_value_name, "<br/>");
    END IF;

    IF NEW.attribute_name <> OLD.attribute_name THEN
        SET audit_log = CONCAT(audit_log, "Attribute: ", OLD.attribute_name, " -> ", NEW.attribute_name, "<br/>");
    END IF;

    IF NEW.extra_price <> OLD.extra_price THEN
        SET audit_log = CONCAT(audit_log, "Extra Price: ", OLD.extra_price, " -> ", NEW.extra_price, "<br/>");
    END IF;
    
    IF audit_log <> 'Product variant changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('product_variant', NEW.product_variant_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `relationship`
--

DROP TABLE IF EXISTS `relationship`;
CREATE TABLE `relationship` (
  `relationship_id` int(10) UNSIGNED NOT NULL,
  `relationship_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `relationship`
--

INSERT INTO `relationship` (`relationship_id`, `relationship_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Father', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(2, 'Mother', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(3, 'Husband', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(4, 'Wife', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(5, 'Son', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(6, 'Daughter', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(7, 'Brother', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(8, 'Sister', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(9, 'Grandfather', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(10, 'Grandmother', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(11, 'Grandson', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(12, 'Granddaughter', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(13, 'Uncle', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(14, 'Aunt', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(15, 'Nephew', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(16, 'Niece', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(17, 'Cousin', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(18, 'Friend', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1);

--
-- Triggers `relationship`
--
DROP TRIGGER IF EXISTS `trg_relationship_insert`;
DELIMITER $$
CREATE TRIGGER `trg_relationship_insert` AFTER INSERT ON `relationship` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Relationship created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('relationship', NEW.relationship_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_relationship_update`;
DELIMITER $$
CREATE TRIGGER `trg_relationship_update` AFTER UPDATE ON `relationship` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Relationship changed.<br/><br/>';

    IF NEW.relationship_name <> OLD.relationship_name THEN
        SET audit_log = CONCAT(audit_log, "Relationship Name: ", OLD.relationship_name, " -> ", NEW.relationship_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Relationship changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('relationship', NEW.relationship_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `religion`
--

DROP TABLE IF EXISTS `religion`;
CREATE TABLE `religion` (
  `religion_id` int(10) UNSIGNED NOT NULL,
  `religion_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `religion`
--

INSERT INTO `religion` (`religion_id`, `religion_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Christianity', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(2, 'Atheism', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(3, 'Islam', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(4, 'Hinduism', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(5, 'Buddhism', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(6, 'Judaism', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(7, 'Sikhism', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(8, 'Atheism', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(9, 'Agnosticism', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(10, 'Confucianism', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(11, 'Shinto', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(12, 'Taoism', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(13, 'Jainism', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(14, 'Spiritualism', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(15, 'Paganism', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(16, 'Rastafarianism', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(17, 'Unitarian Universalism', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(18, 'Scientology', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1),
(19, 'Druze', '2025-10-21 21:38:02', '2025-10-21 21:38:02', 1);

--
-- Triggers `religion`
--
DROP TRIGGER IF EXISTS `trg_religion_insert`;
DELIMITER $$
CREATE TRIGGER `trg_religion_insert` AFTER INSERT ON `religion` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Religion created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('religion', NEW.religion_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_religion_update`;
DELIMITER $$
CREATE TRIGGER `trg_religion_update` AFTER UPDATE ON `religion` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Religion changed.<br/><br/>';

    IF NEW.religion_name <> OLD.religion_name THEN
        SET audit_log = CONCAT(audit_log, "Religion Name: ", OLD.religion_name, " -> ", NEW.religion_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Religion changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('religion', NEW.religion_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `reset_token`
--

DROP TABLE IF EXISTS `reset_token`;
CREATE TABLE `reset_token` (
  `reset_token_id` int(11) NOT NULL,
  `user_account_id` int(10) UNSIGNED NOT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expiry_date` datetime DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `role_description` varchar(200) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_id`, `role_name`, `role_description`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Super Admin', 'Super Admin is the highest-level system administrator in an application or platform.', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1);

--
-- Triggers `role`
--
DROP TRIGGER IF EXISTS `trg_role_insert`;
DELIMITER $$
CREATE TRIGGER `trg_role_insert` AFTER INSERT ON `role` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Role created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('role', NEW.role_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_role_update`;
DELIMITER $$
CREATE TRIGGER `trg_role_update` AFTER UPDATE ON `role` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Role changed.<br/><br/>';

    IF NEW.role_name <> OLD.role_name THEN
        SET audit_log = CONCAT(audit_log, "Role Name: ", OLD.role_name, " -> ", NEW.role_name, "<br/>");
    END IF;

    IF NEW.role_description <> OLD.role_description THEN
        SET audit_log = CONCAT(audit_log, "Role Description: ", OLD.role_description, " -> ", NEW.role_description, "<br/>");
    END IF;
    
    IF audit_log <> 'Role changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('role', NEW.role_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `role_permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `menu_item_id` int(10) UNSIGNED NOT NULL,
  `menu_item_name` varchar(100) NOT NULL,
  `read_access` tinyint(1) DEFAULT 0,
  `write_access` tinyint(1) DEFAULT 0,
  `create_access` tinyint(1) DEFAULT 0,
  `delete_access` tinyint(1) DEFAULT 0,
  `import_access` tinyint(1) DEFAULT 0,
  `export_access` tinyint(1) DEFAULT 0,
  `log_notes_access` tinyint(1) DEFAULT 0,
  `date_assigned` datetime DEFAULT current_timestamp(),
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_permission`
--

INSERT INTO `role_permission` (`role_permission_id`, `role_id`, `role_name`, `menu_item_id`, `menu_item_name`, `read_access`, `write_access`, `create_access`, `delete_access`, `import_access`, `export_access`, `log_notes_access`, `date_assigned`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 1, 'Super Admin', 1, 'App Module', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2, 1, 'Super Admin', 2, 'Settings', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3, 1, 'Super Admin', 3, 'Users & Companies', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(4, 1, 'Super Admin', 4, 'User Account', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(5, 1, 'Super Admin', 5, 'Company', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(6, 1, 'Super Admin', 6, 'Role', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(7, 1, 'Super Admin', 7, 'User Interface', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(8, 1, 'Super Admin', 8, 'Menu Item', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(9, 1, 'Super Admin', 9, 'System Action', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(10, 1, 'Super Admin', 10, 'Account Settings', 1, 1, 0, 0, 0, 0, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(11, 1, 'Super Admin', 11, 'Configurations', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(12, 1, 'Super Admin', 12, 'Localization', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(13, 1, 'Super Admin', 13, 'Country', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(14, 1, 'Super Admin', 14, 'State', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(15, 1, 'Super Admin', 15, 'City', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(16, 1, 'Super Admin', 16, 'Currency', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(17, 1, 'Super Admin', 17, 'Nationality', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(18, 1, 'Super Admin', 18, 'Data Classification', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(19, 1, 'Super Admin', 19, 'File Type', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(20, 1, 'Super Admin', 20, 'File Extension', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(21, 1, 'Super Admin', 21, 'Upload Setting', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(22, 1, 'Super Admin', 22, 'Notification Setting', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(23, 1, 'Super Admin', 23, 'Banking', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(24, 1, 'Super Admin', 24, 'Bank', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(25, 1, 'Super Admin', 25, 'Bank Account Type', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(26, 1, 'Super Admin', 26, 'Contact Information', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(27, 1, 'Super Admin', 27, 'Address Type', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(28, 1, 'Super Admin', 28, 'Contact Information Type', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(29, 1, 'Super Admin', 29, 'Language Settings', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(30, 1, 'Super Admin', 30, 'Language', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(31, 1, 'Super Admin', 31, 'Language Proficiency', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(32, 1, 'Super Admin', 32, 'Profile Attribute', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(33, 1, 'Super Admin', 33, 'Blood Type', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(34, 1, 'Super Admin', 34, 'Civil Status', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(35, 1, 'Super Admin', 35, 'Educational Stage', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(36, 1, 'Super Admin', 36, 'Gender', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(37, 1, 'Super Admin', 37, 'Credential Type', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(38, 1, 'Super Admin', 38, 'Relationship', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(39, 1, 'Super Admin', 39, 'Religion', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(40, 1, 'Super Admin', 40, 'Employee', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(41, 1, 'Super Admin', 41, 'HR Configurations', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(42, 1, 'Super Admin', 42, 'Department', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(43, 1, 'Super Admin', 43, 'Departure Reason', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(44, 1, 'Super Admin', 44, 'Employment Location Type', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(45, 1, 'Super Admin', 45, 'Employment Type', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(46, 1, 'Super Admin', 46, 'Job Position', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(47, 1, 'Super Admin', 47, 'Work Location', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(48, 1, 'Super Admin', 48, 'Employee Document Type', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(49, 1, 'Super Admin', 49, 'Inventory Configurations', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 21:42:21', '2025-10-21 21:42:21', '2025-10-21 21:42:22', 2),
(50, 1, 'Super Admin', 50, 'Attribute', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:44:18', '2025-10-21 21:44:18', '2025-10-21 21:44:23', 2),
(51, 1, 'Super Admin', 51, 'Tax', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:46:34', '2025-10-21 21:46:34', '2025-10-21 21:46:40', 2),
(52, 1, 'Super Admin', 52, 'Product Category', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:49:20', '2025-10-21 21:49:20', '2025-10-21 21:49:25', 2),
(53, 1, 'Super Admin', 53, 'Supplier', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:50:36', '2025-10-21 21:50:36', '2025-10-21 21:50:41', 2),
(54, 1, 'Super Admin', 54, 'Warehouse Management', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 21:52:55', '2025-10-21 21:52:55', '2025-10-21 21:52:57', 2),
(55, 1, 'Super Admin', 55, 'Warehouse Type', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:53:28', '2025-10-21 21:53:28', '2025-10-21 21:53:33', 2),
(56, 1, 'Super Admin', 56, 'Warehouse', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:54:54', '2025-10-21 21:54:54', '2025-10-21 21:55:00', 2),
(57, 1, 'Super Admin', 57, 'Products', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 21:56:49', '2025-10-21 21:56:49', '2025-10-21 21:56:50', 2),
(58, 1, 'Super Admin', 58, 'Product', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:57:42', '2025-10-21 21:57:42', '2025-10-21 21:57:46', 2),
(59, 1, 'Super Admin', 59, 'Pricelist', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 21:59:24', '2025-10-21 21:59:24', '2025-10-21 21:59:28', 2),
(60, 1, 'Super Admin', 60, 'Product Variant', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 22:00:46', '2025-10-21 22:00:46', '2025-10-21 22:00:51', 2),
(61, 1, 'Super Admin', 61, 'Inventory Operations', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 22:02:20', '2025-10-21 22:02:20', '2025-10-21 22:02:22', 2),
(62, 1, 'Super Admin', 62, 'Inventory Transfer', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 22:04:05', '2025-10-21 22:04:05', '2025-10-21 22:04:06', 2),
(63, 1, 'Super Admin', 63, 'Receipts', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 22:05:31', '2025-10-21 22:05:31', '2025-10-21 22:05:35', 2),
(64, 1, 'Super Admin', 64, 'Delivery', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 22:06:19', '2025-10-21 22:06:19', '2025-10-21 22:06:24', 2),
(65, 1, 'Super Admin', 65, 'Inventory Adjustments', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 22:11:27', '2025-10-21 22:11:27', '2025-10-21 22:11:28', 2),
(66, 1, 'Super Admin', 66, 'Physical Inventory', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 22:12:29', '2025-10-21 22:12:29', '2025-10-21 22:12:35', 2),
(67, 1, 'Super Admin', 67, 'Scrap', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 22:13:06', '2025-10-21 22:13:06', '2025-10-21 22:13:10', 2),
(68, 1, 'Super Admin', 68, 'Inventory Procurement', 1, 0, 0, 0, 0, 0, 0, '2025-10-21 22:14:17', '2025-10-21 22:14:17', '2025-10-21 22:14:29', 2),
(69, 1, 'Super Admin', 69, 'Replenishment', 1, 1, 1, 1, 1, 1, 1, '2025-10-21 22:15:24', '2025-10-21 22:15:24', '2025-10-21 22:15:30', 2);

--
-- Triggers `role_permission`
--
DROP TRIGGER IF EXISTS `trg_role_permission_insert`;
DELIMITER $$
CREATE TRIGGER `trg_role_permission_insert` AFTER INSERT ON `role_permission` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Role permission created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('role_permission', NEW.role_permission_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_role_permission_update`;
DELIMITER $$
CREATE TRIGGER `trg_role_permission_update` AFTER UPDATE ON `role_permission` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Role permission changed.<br/><br/>';

    IF NEW.role_name <> OLD.role_name THEN
        SET audit_log = CONCAT(audit_log, "Role Name: ", OLD.role_name, " -> ", NEW.role_name, "<br/>");
    END IF;

    IF NEW.menu_item_name <> OLD.menu_item_name THEN
        SET audit_log = CONCAT(audit_log, "Menu Item: ", OLD.menu_item_name, " -> ", NEW.menu_item_name, "<br/>");
    END IF;

    IF NEW.read_access <> OLD.read_access THEN
        SET audit_log = CONCAT(audit_log, "Read Access: ", OLD.read_access, " -> ", NEW.read_access, "<br/>");
    END IF;

    IF NEW.write_access <> OLD.write_access THEN
        SET audit_log = CONCAT(audit_log, "Write Access: ", OLD.write_access, " -> ", NEW.write_access, "<br/>");
    END IF;

    IF NEW.create_access <> OLD.create_access THEN
        SET audit_log = CONCAT(audit_log, "Create Access: ", OLD.create_access, " -> ", NEW.create_access, "<br/>");
    END IF;

    IF NEW.delete_access <> OLD.delete_access THEN
        SET audit_log = CONCAT(audit_log, "Delete Access: ", OLD.delete_access, " -> ", NEW.delete_access, "<br/>");
    END IF;

    IF NEW.import_access <> OLD.import_access THEN
        SET audit_log = CONCAT(audit_log, "Import Access: ", OLD.import_access, " -> ", NEW.import_access, "<br/>");
    END IF;

    IF NEW.export_access <> OLD.export_access THEN
        SET audit_log = CONCAT(audit_log, "Export Access: ", OLD.export_access, " -> ", NEW.export_access, "<br/>");
    END IF;

    IF NEW.log_notes_access <> OLD.log_notes_access THEN
        SET audit_log = CONCAT(audit_log, "Log Notes Access: ", OLD.log_notes_access, " -> ", NEW.log_notes_access, "<br/>");
    END IF;
    
    IF audit_log <> 'Role permission changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('role_permission', NEW.role_permission_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `role_system_action_permission`
--

DROP TABLE IF EXISTS `role_system_action_permission`;
CREATE TABLE `role_system_action_permission` (
  `role_system_action_permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `system_action_id` int(10) UNSIGNED NOT NULL,
  `system_action_name` varchar(100) NOT NULL,
  `system_action_access` tinyint(1) DEFAULT 0,
  `date_assigned` datetime DEFAULT current_timestamp(),
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_system_action_permission`
--

INSERT INTO `role_system_action_permission` (`role_system_action_permission_id`, `role_id`, `role_name`, `system_action_id`, `system_action_name`, `system_action_access`, `date_assigned`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 1, 'Super Admin', 1, 'Activate User Account', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', NULL),
(2, 1, 'Super Admin', 2, 'Deactivate User Account', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', NULL),
(3, 1, 'Super Admin', 3, 'Add Role User Account', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', NULL),
(4, 1, 'Super Admin', 4, 'Delete Role User Account', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', NULL),
(5, 1, 'Super Admin', 5, 'Add Role Access', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', NULL),
(6, 1, 'Super Admin', 6, 'Update Role Access', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', NULL),
(7, 1, 'Super Admin', 7, 'Delete Role Access', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', NULL),
(8, 1, 'Super Admin', 8, 'Add Role System Action Access', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', NULL),
(9, 1, 'Super Admin', 9, 'Update Role System Action Access', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', NULL),
(10, 1, 'Super Admin', 10, 'Delete Role System Action Access', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', NULL),
(11, 1, 'Super Admin', 11, 'Archive Employee', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', NULL),
(12, 1, 'Super Admin', 12, 'Unarchive Employee', 1, '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', NULL),
(13, 1, 'Super Admin', 13, 'Archive Supplier', 1, '2025-10-22 16:37:48', '2025-10-22 16:37:48', '2025-10-22 16:37:49', 2),
(14, 1, 'Super Admin', 14, 'Unarchive Supplier', 1, '2025-10-22 16:38:11', '2025-10-22 16:38:11', '2025-10-22 16:38:12', 2),
(15, 1, 'Super Admin', 15, 'Archive Tax', 1, '2025-10-22 17:10:36', '2025-10-22 17:10:36', '2025-10-22 17:10:37', 2),
(16, 1, 'Super Admin', 16, 'Unarchive Tax', 1, '2025-10-22 17:10:51', '2025-10-22 17:10:51', '2025-10-22 17:10:52', 2),
(17, 1, 'Super Admin', 17, 'Archive Warehouse', 1, '2025-10-22 21:58:17', '2025-10-22 21:58:17', '2025-10-22 21:58:18', 2),
(18, 1, 'Super Admin', 18, 'Unarchive Warehouse', 1, '2025-10-22 21:58:37', '2025-10-22 21:58:37', '2025-10-22 21:58:38', 2),
(19, 1, 'Super Admin', 19, 'Archive Product', 1, '2025-10-23 12:30:50', '2025-10-23 12:30:50', '2025-10-23 12:30:52', 2),
(20, 1, 'Super Admin', 20, 'Unarchive Product', 1, '2025-10-23 12:31:26', '2025-10-23 12:31:26', '2025-10-23 12:31:27', 2);

--
-- Triggers `role_system_action_permission`
--
DROP TRIGGER IF EXISTS `trg_role_system_action_permission_insert`;
DELIMITER $$
CREATE TRIGGER `trg_role_system_action_permission_insert` AFTER INSERT ON `role_system_action_permission` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Role system action permission created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('role_system_action_permission', NEW.role_system_action_permission_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_role_system_action_permission_update`;
DELIMITER $$
CREATE TRIGGER `trg_role_system_action_permission_update` AFTER UPDATE ON `role_system_action_permission` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Role system action permission changed.<br/><br/>';

    IF NEW.role_name <> OLD.role_name THEN
        SET audit_log = CONCAT(audit_log, "Role Name: ", OLD.role_name, " -> ", NEW.role_name, "<br/>");
    END IF;

    IF NEW.system_action_name <> OLD.system_action_name THEN
        SET audit_log = CONCAT(audit_log, "System Action: ", OLD.system_action_name, " -> ", NEW.system_action_name, "<br/>");
    END IF;

    IF NEW.system_action_access <> OLD.system_action_access THEN
        SET audit_log = CONCAT(audit_log, "System Action Access: ", OLD.system_action_access, " -> ", NEW.system_action_access, "<br/>");
    END IF;
    
    IF audit_log <> 'Role system action permission changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('role_system_action_permission', NEW.role_system_action_permission_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `role_user_account`
--

DROP TABLE IF EXISTS `role_user_account`;
CREATE TABLE `role_user_account` (
  `role_user_account_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `user_account_id` int(10) UNSIGNED NOT NULL,
  `file_as` varchar(300) NOT NULL,
  `date_assigned` datetime DEFAULT current_timestamp(),
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_user_account`
--

INSERT INTO `role_user_account` (`role_user_account_id`, `role_id`, `role_name`, `user_account_id`, `file_as`, `date_assigned`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 1, 'Super Admin', 1, 'Bot', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2, 1, 'Super Admin', 2, 'Lawrence Agulto', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1);

--
-- Triggers `role_user_account`
--
DROP TRIGGER IF EXISTS `trg_role_user_account_insert`;
DELIMITER $$
CREATE TRIGGER `trg_role_user_account_insert` AFTER INSERT ON `role_user_account` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Role user account created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('role_user_account', NEW.role_user_account_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_role_user_account_update`;
DELIMITER $$
CREATE TRIGGER `trg_role_user_account_update` AFTER UPDATE ON `role_user_account` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Role user account changed. <br/>';

    IF NEW.role_name <> OLD.role_name THEN
        SET audit_log = CONCAT(audit_log, "Role Name: ", OLD.role_name, " -> ", NEW.role_name, "<br/>");
    END IF;

    IF NEW.file_as <> OLD.file_as THEN
        SET audit_log = CONCAT(audit_log, "User Account Name: ", OLD.file_as, " -> ", NEW.file_as, "<br/>");
    END IF;
    
    IF audit_log <> 'Role user account changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('role_user_account', NEW.role_user_account_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `session_id` int(11) NOT NULL,
  `user_account_id` int(10) UNSIGNED NOT NULL,
  `session_token` varchar(255) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`session_id`, `user_account_id`, `session_token`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 2, '$2y$10$IcdAEl/8LU9pac7uc/gXNOQ/7jtW9UpSY1CeOfImo/ZB0nAkVKu6S', '2025-10-21 21:41:38', '2025-10-23 19:42:35', 1);

-- --------------------------------------------------------

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
CREATE TABLE `state` (
  `state_id` int(10) UNSIGNED NOT NULL,
  `state_name` varchar(100) NOT NULL,
  `country_id` int(10) UNSIGNED NOT NULL,
  `country_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `state`
--

INSERT INTO `state` (`state_id`, `state_name`, `country_id`, `country_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'Abra', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2, 'Agusan del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3, 'Agusan del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(4, 'Aklan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(5, 'Albay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(6, 'Antique', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(7, 'Apayao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(8, 'Aurora', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(9, 'Autonomous Region in Muslim Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(10, 'Basilan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(11, 'Bataan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(12, 'Batanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(13, 'Batangas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(14, 'Benguet', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(15, 'Bicol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(16, 'Biliran', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(17, 'Bohol', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(18, 'Bukidnon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(19, 'Bulacan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(20, 'Cagayan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(21, 'Cagayan Valley', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(22, 'Calabarzon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(23, 'Camarines Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(24, 'Camarines Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(25, 'Camiguin', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(26, 'Capiz', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(27, 'Caraga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(28, 'Catanduanes', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(29, 'Cavite', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(30, 'Cebu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(31, 'Central Luzon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(32, 'Central Visayas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(33, 'Cordillera Administrative', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(34, 'Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(35, 'Davao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(36, 'Davao de Oro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(37, 'Davao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(38, 'Davao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(39, 'Davao Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(40, 'Davao Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(41, 'Dinagat Islands', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(42, 'Eastern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(43, 'Eastern Visayas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(44, 'Guimaras', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(45, 'Ifugao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(46, 'Ilocos', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(47, 'Ilocos Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(48, 'Ilocos Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(49, 'Iloilo', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(50, 'Isabela', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(51, 'Kalinga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(52, 'La Union', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(53, 'Laguna', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(54, 'Lanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(55, 'Lanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(56, 'Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(57, 'Maguindanao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(58, 'Maguindanao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(59, 'Marinduque', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(60, 'Masbate', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(61, 'Mimaropa', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(62, 'Misamis Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(63, 'Misamis Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(64, 'Mountain Province', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(65, 'National Capital Region (Metro Manila)', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(66, 'Negros Occidental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(67, 'Negros Oriental', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(68, 'Northern Mindanao', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(69, 'Northern Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(70, 'Nueva Ecija', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(71, 'Nueva Vizcaya', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(72, 'Occidental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(73, 'Oriental Mindoro', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(74, 'Palawan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(75, 'Pampanga', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(76, 'Pangasinan', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(77, 'Quezon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(78, 'Quirino', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(79, 'Rizal', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(80, 'Romblon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(81, 'Sarangani', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(82, 'Siquijor', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(83, 'Soccsksargen', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(84, 'Sorsogon', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(85, 'South Cotabato', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(86, 'Southern Leyte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(87, 'Sultan Kudarat', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(88, 'Sulu', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(89, 'Surigao del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(90, 'Surigao del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(91, 'Tarlac', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(92, 'Tawi-Tawi', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(93, 'Western Samar', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(94, 'Western Visayas', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(95, 'Zambales', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(96, 'Zamboanga del Norte', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(97, 'Zamboanga del Sur', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(98, 'Zamboanga Peninsula', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(99, 'Zamboanga Sibugay', 1, 'Philippines', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1);

--
-- Triggers `state`
--
DROP TRIGGER IF EXISTS `trg_state_insert`;
DELIMITER $$
CREATE TRIGGER `trg_state_insert` AFTER INSERT ON `state` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'State created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('state', NEW.state_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_state_update`;
DELIMITER $$
CREATE TRIGGER `trg_state_update` AFTER UPDATE ON `state` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'State changed.<br/><br/>';

    IF NEW.state_name <> OLD.state_name THEN
        SET audit_log = CONCAT(audit_log, "State Name: ", OLD.state_name, " -> ", NEW.state_name, "<br/>");
    END IF;

    IF NEW.country_name <> OLD.country_name THEN
        SET audit_log = CONCAT(audit_log, "Country: ", OLD.country_name, " -> ", NEW.country_name, "<br/>");
    END IF;
    
    IF audit_log <> 'State changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('state', NEW.state_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `supplier_id` int(10) UNSIGNED NOT NULL,
  `supplier_name` varchar(200) NOT NULL,
  `contact_person` varchar(500) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(1000) DEFAULT NULL,
  `city_id` int(10) UNSIGNED NOT NULL,
  `city_name` varchar(100) NOT NULL,
  `state_id` int(10) UNSIGNED NOT NULL,
  `state_name` varchar(100) NOT NULL,
  `country_id` int(10) UNSIGNED NOT NULL,
  `country_name` varchar(100) NOT NULL,
  `tax_id_number` varchar(100) DEFAULT NULL,
  `supplier_status` enum('Active','Archived') DEFAULT 'Active',
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `supplier`
--
DROP TRIGGER IF EXISTS `trg_supplier_insert`;
DELIMITER $$
CREATE TRIGGER `trg_supplier_insert` AFTER INSERT ON `supplier` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Supplier created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('supplier', NEW.supplier_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_supplier_update`;
DELIMITER $$
CREATE TRIGGER `trg_supplier_update` AFTER UPDATE ON `supplier` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Supplier changed.<br/><br/>';

    IF NEW.supplier_name <> OLD.supplier_name THEN
        SET audit_log = CONCAT(audit_log, "Supplier Name: ", OLD.supplier_name, " -> ", NEW.supplier_name, "<br/>");
    END IF;

    IF NEW.contact_person <> OLD.contact_person THEN
        SET audit_log = CONCAT(audit_log, "Contact Person: ", OLD.contact_person, " -> ", NEW.contact_person, "<br/>");
    END IF;

    IF NEW.phone <> OLD.phone THEN
        SET audit_log = CONCAT(audit_log, "Phone: ", OLD.phone, " -> ", NEW.phone, "<br/>");
    END IF;

    IF NEW.telephone <> OLD.telephone THEN
        SET audit_log = CONCAT(audit_log, "Telephone: ", OLD.telephone, " -> ", NEW.telephone, "<br/>");
    END IF;

    IF NEW.email <> OLD.email THEN
        SET audit_log = CONCAT(audit_log, "Email: ", OLD.email, " -> ", NEW.email, "<br/>");
    END IF;

    IF NEW.address <> OLD.address THEN
        SET audit_log = CONCAT(audit_log, "Address: ", OLD.address, " -> ", NEW.address, "<br/>");
    END IF;

    IF NEW.city_name <> OLD.city_name THEN
        SET audit_log = CONCAT(audit_log, "City: ", OLD.city_name, " -> ", NEW.city_name, "<br/>");
    END IF;

    IF NEW.state_name <> OLD.state_name THEN
        SET audit_log = CONCAT(audit_log, "State: ", OLD.state_name, " -> ", NEW.state_name, "<br/>");
    END IF;

    IF NEW.country_name <> OLD.country_name THEN
        SET audit_log = CONCAT(audit_log, "Country: ", OLD.country_name, " -> ", NEW.country_name, "<br/>");
    END IF;

    IF NEW.tax_id_number <> OLD.tax_id_number THEN
        SET audit_log = CONCAT(audit_log, "Tax ID Number: ", OLD.tax_id_number, " -> ", NEW.tax_id_number, "<br/>");
    END IF;

    IF NEW.supplier_status <> OLD.supplier_status THEN
        SET audit_log = CONCAT(audit_log, "Supplier Status: ", OLD.supplier_status, " -> ", NEW.supplier_status, "<br/>");
    END IF;

    IF audit_log <> 'Supplier changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('supplier', NEW.supplier_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `system_action`
--

DROP TABLE IF EXISTS `system_action`;
CREATE TABLE `system_action` (
  `system_action_id` int(10) UNSIGNED NOT NULL,
  `system_action_name` varchar(100) NOT NULL,
  `system_action_description` varchar(200) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_action`
--

INSERT INTO `system_action` (`system_action_id`, `system_action_name`, `system_action_description`, `created_date`, `last_log_by`) VALUES
(1, 'Activate User Account', 'Access to activate the user account.', '2025-10-21 21:38:00', 1),
(2, 'Deactivate User Account', 'Access to deactivate the user account.', '2025-10-21 21:38:00', 1),
(3, 'Add Role User Account', 'Access to assign roles to user account.', '2025-10-21 21:38:00', 1),
(4, 'Delete Role User Account', 'Access to delete roles to user account.', '2025-10-21 21:38:00', 1),
(5, 'Add Role Access', 'Access to add role access.', '2025-10-21 21:38:00', 1),
(6, 'Update Role Access', 'Access to update role access.', '2025-10-21 21:38:00', 1),
(7, 'Delete Role Access', 'Access to delete role access.', '2025-10-21 21:38:00', 1),
(8, 'Add Role System Action Access', 'Access to add the role system action access.', '2025-10-21 21:38:00', 1),
(9, 'Update Role System Action Access', 'Access to update the role system action access.', '2025-10-21 21:38:00', 1),
(10, 'Delete Role System Action Access', 'Access to delete the role system action access.', '2025-10-21 21:38:00', 1),
(11, 'Archive Employee', 'Access to archive an employee.', '2025-10-21 21:38:00', 1),
(12, 'Unarchive Employee', 'Access to unarchive an employee.', '2025-10-21 21:38:00', 1),
(13, 'Archive Supplier', 'Access to archive a supplier.', '2025-10-22 16:37:36', 2),
(14, 'Unarchive Supplier', 'Access to unarchive a supplier.', '2025-10-22 16:38:08', 2),
(15, 'Archive Tax', 'Access to archive a tax.', '2025-10-22 17:10:33', 2),
(16, 'Unarchive Tax', 'Access to unarchive a tax.', '2025-10-22 17:10:47', 2),
(17, 'Archive Warehouse', 'Access to archive a warehouse.', '2025-10-22 21:58:13', 2),
(18, 'Unarchive Warehouse', 'Access to unarchive a warehouse.', '2025-10-22 21:58:33', 2),
(19, 'Archive Product', 'Access to archive a product.', '2025-10-23 12:30:47', 2),
(20, 'Unarchive Product', 'Access to unarchive a product.', '2025-10-23 12:31:21', 2);

--
-- Triggers `system_action`
--
DROP TRIGGER IF EXISTS `trg_system_action_insert`;
DELIMITER $$
CREATE TRIGGER `trg_system_action_insert` AFTER INSERT ON `system_action` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'System action created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('system_action', NEW.system_action_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_system_action_update`;
DELIMITER $$
CREATE TRIGGER `trg_system_action_update` AFTER UPDATE ON `system_action` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'System action changed.<br/><br/>';

    IF NEW.system_action_name <> OLD.system_action_name THEN
        SET audit_log = CONCAT(audit_log, "System Action Name: ", OLD.system_action_name, " -> ", NEW.system_action_name, "<br/>");
    END IF;

    IF NEW.system_action_description <> OLD.system_action_description THEN
        SET audit_log = CONCAT(audit_log, "System Action Description: ", OLD.system_action_description, " -> ", NEW.system_action_description, "<br/>");
    END IF;
    
    IF audit_log <> 'System action changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('system_action', NEW.system_action_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tax`
--

DROP TABLE IF EXISTS `tax`;
CREATE TABLE `tax` (
  `tax_id` int(10) UNSIGNED NOT NULL,
  `tax_name` varchar(100) NOT NULL,
  `tax_rate` decimal(5,2) DEFAULT 0.00,
  `tax_type` enum('None','Purchases','Sales') DEFAULT 'Sales',
  `tax_computation` enum('Fixed','Percentage') DEFAULT 'Percentage',
  `tax_scope` enum('Goods','Services') DEFAULT NULL,
  `tax_status` enum('Active','Archived') DEFAULT 'Active',
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tax`
--

INSERT INTO `tax` (`tax_id`, `tax_name`, `tax_rate`, `tax_type`, `tax_computation`, `tax_scope`, `tax_status`, `created_date`, `last_updated`, `last_log_by`) VALUES
(3, 'VAT', 12.00, 'Sales', 'Fixed', 'Goods', 'Active', '2025-10-23 21:21:18', '2025-10-23 21:21:18', 2),
(4, 'Withholding Tax', 12.00, 'Purchases', 'Percentage', 'Goods', 'Active', '2025-10-23 21:21:32', '2025-10-23 21:21:32', 2);

--
-- Triggers `tax`
--
DROP TRIGGER IF EXISTS `trg_tax_insert`;
DELIMITER $$
CREATE TRIGGER `trg_tax_insert` AFTER INSERT ON `tax` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Tax created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('tax', NEW.tax_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_tax_update`;
DELIMITER $$
CREATE TRIGGER `trg_tax_update` AFTER UPDATE ON `tax` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Tax changed.<br/><br/>';

    IF NEW.tax_name <> OLD.tax_name THEN
        SET audit_log = CONCAT(audit_log, "Tax Name: ", OLD.tax_name, " -> ", NEW.tax_name, "<br/>");
    END IF;

    IF NEW.tax_rate <> OLD.tax_rate THEN
        SET audit_log = CONCAT(audit_log, "Tax Rate: ", OLD.tax_rate, " -> ", NEW.tax_rate, "<br/>");
    END IF;

    IF NEW.tax_type <> OLD.tax_type THEN
        SET audit_log = CONCAT(audit_log, "Tax Type: ", OLD.tax_type, " -> ", NEW.tax_type, "<br/>");
    END IF;

    IF NEW.tax_computation <> OLD.tax_computation THEN
        SET audit_log = CONCAT(audit_log, "Tax Computation: ", OLD.tax_computation, " -> ", NEW.tax_computation, "<br/>");
    END IF;

    IF NEW.tax_scope <> OLD.tax_scope THEN
        SET audit_log = CONCAT(audit_log, "Tax Scope: ", OLD.tax_scope, " -> ", NEW.tax_scope, "<br/>");
    END IF;

    IF NEW.tax_status <> OLD.tax_status THEN
        SET audit_log = CONCAT(audit_log, "Tax Status: ", OLD.tax_status, " -> ", NEW.tax_status, "<br/>");
    END IF;

    IF audit_log <> 'Tax changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('tax', NEW.tax_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `upload_setting`
--

DROP TABLE IF EXISTS `upload_setting`;
CREATE TABLE `upload_setting` (
  `upload_setting_id` int(10) UNSIGNED NOT NULL,
  `upload_setting_name` varchar(100) NOT NULL,
  `upload_setting_description` varchar(200) NOT NULL,
  `max_file_size` double NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `upload_setting`
--

INSERT INTO `upload_setting` (`upload_setting_id`, `upload_setting_name`, `upload_setting_description`, `max_file_size`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'App Logo', 'Sets the upload setting when uploading app logo.', 800, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2, 'Internal Notes Attachment', 'Sets the upload setting when uploading internal notes attachement.', 800, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3, 'Import File', 'Sets the upload setting when importing data.', 800, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(4, 'User Account Profile Picture', 'Sets the upload setting when uploading user account profile picture.', 800, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(5, 'Company Logo', 'Sets the upload setting when uploading company logo.', 800, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(6, 'Employee Image', 'Sets the upload setting when uploading employee image.', 800, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(7, 'Employee Document', 'Sets the upload setting when uploading employee document.', 800, '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(8, 'Product Image', 'Sets the upload setting when uploading product image.', 500, '2025-10-23 22:19:20', '2025-10-23 22:19:20', 2);

--
-- Triggers `upload_setting`
--
DROP TRIGGER IF EXISTS `trg_upload_setting_insert`;
DELIMITER $$
CREATE TRIGGER `trg_upload_setting_insert` AFTER INSERT ON `upload_setting` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Upload setting created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('upload_setting', NEW.upload_setting_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_upload_setting_update`;
DELIMITER $$
CREATE TRIGGER `trg_upload_setting_update` AFTER UPDATE ON `upload_setting` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Upload setting changed.<br/><br/>';

    IF NEW.upload_setting_name <> OLD.upload_setting_name THEN
        SET audit_log = CONCAT(audit_log, "Upload Setting Name: ", OLD.upload_setting_name, " -> ", NEW.upload_setting_name, "<br/>");
    END IF;

    IF NEW.upload_setting_description <> OLD.upload_setting_description THEN
        SET audit_log = CONCAT(audit_log, "Upload Setting Description: ", OLD.upload_setting_description, " -> ", NEW.upload_setting_description, "<br/>");
    END IF;

    IF NEW.max_file_size <> OLD.max_file_size THEN
        SET audit_log = CONCAT(audit_log, "Max File Size: ", OLD.max_file_size, " -> ", NEW.max_file_size, "<br/>");
    END IF;
    
    IF audit_log <> 'Upload setting changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('upload_setting', NEW.upload_setting_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `upload_setting_file_extension`
--

DROP TABLE IF EXISTS `upload_setting_file_extension`;
CREATE TABLE `upload_setting_file_extension` (
  `upload_setting_file_extension_id` int(10) UNSIGNED NOT NULL,
  `upload_setting_id` int(10) UNSIGNED NOT NULL,
  `upload_setting_name` varchar(100) NOT NULL,
  `file_extension_id` int(10) UNSIGNED NOT NULL,
  `file_extension_name` varchar(100) NOT NULL,
  `file_extension` varchar(10) NOT NULL,
  `date_assigned` datetime DEFAULT current_timestamp(),
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `upload_setting_file_extension`
--

INSERT INTO `upload_setting_file_extension` (`upload_setting_file_extension_id`, `upload_setting_id`, `upload_setting_name`, `file_extension_id`, `file_extension_name`, `file_extension`, `date_assigned`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 1, 'App Logo', 63, 'PNG', 'png', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(2, 1, 'App Logo', 61, 'JPG', 'jpg', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(3, 1, 'App Logo', 62, 'JPEG', 'jpeg', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(4, 2, 'Internal Notes Attachment', 63, 'PNG', 'png', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(5, 2, 'Internal Notes Attachment', 61, 'JPG', 'jpg', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(6, 2, 'Internal Notes Attachment', 62, 'JPEG', 'jpeg', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(7, 2, 'Internal Notes Attachment', 127, 'PDF', 'pdf', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(8, 2, 'Internal Notes Attachment', 125, 'DOC', 'doc', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(9, 2, 'Internal Notes Attachment', 125, 'DOCX', 'docx', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(10, 2, 'Internal Notes Attachment', 130, 'TXT', 'txt', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(11, 2, 'Internal Notes Attachment', 92, 'XLS', 'xls', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(12, 2, 'Internal Notes Attachment', 94, 'XLSX', 'xlsx', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(13, 2, 'Internal Notes Attachment', 89, 'PPT', 'ppt', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(14, 2, 'Internal Notes Attachment', 90, 'PPTX', 'pptx', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(15, 3, 'Import File', 25, 'CSV', 'csv', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(16, 4, 'User Account Profile Picture', 63, 'PNG', 'png', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(17, 4, 'User Account Profile Picture', 61, 'JPG', 'jpg', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(18, 4, 'User Account Profile Picture', 62, 'JPEG', 'jpeg', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(19, 5, 'Company Logo', 63, 'PNG', 'png', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(20, 5, 'Company Logo', 61, 'JPG', 'jpg', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(21, 5, 'Company Logo', 62, 'JPEG', 'jpeg', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(22, 6, 'Employee Image', 63, 'PNG', 'png', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(23, 6, 'Employee Image', 61, 'JPG', 'jpg', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(24, 6, 'Employee Image', 62, 'JPEG', 'jpeg', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(25, 7, 'Employee Document', 63, 'PNG', 'png', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(26, 7, 'Employee Document', 61, 'JPG', 'jpg', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(27, 7, 'Employee Document', 62, 'JPEG', 'jpeg', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(28, 7, 'Employee Document', 127, 'PDF', 'pdf', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(29, 7, 'Employee Document', 125, 'DOC', 'doc', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(30, 7, 'Employee Document', 125, 'DOCX', 'docx', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(31, 7, 'Employee Document', 130, 'TXT', 'txt', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(32, 7, 'Employee Document', 92, 'XLS', 'xls', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(33, 7, 'Employee Document', 94, 'XLSX', 'xlsx', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(34, 7, 'Employee Document', 89, 'PPT', 'ppt', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(35, 7, 'Employee Document', 90, 'PPTX', 'pptx', '2025-10-21 21:38:00', '2025-10-21 21:38:00', '2025-10-21 21:38:00', 1),
(36, 8, 'Product Image', 62, 'JPEG', 'jpeg', '2025-10-23 22:19:32', '2025-10-23 22:19:32', '2025-10-23 22:19:32', 2),
(37, 8, 'Product Image', 61, 'JPG', 'jpg', '2025-10-23 22:19:32', '2025-10-23 22:19:32', '2025-10-23 22:19:32', 2),
(38, 8, 'Product Image', 63, 'PNG', 'png', '2025-10-23 22:19:32', '2025-10-23 22:19:32', '2025-10-23 22:19:32', 2);

--
-- Triggers `upload_setting_file_extension`
--
DROP TRIGGER IF EXISTS `trg_upload_setting_file_insert`;
DELIMITER $$
CREATE TRIGGER `trg_upload_setting_file_insert` AFTER INSERT ON `upload_setting_file_extension` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Upload setting file extension created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('upload_setting_file_extension', NEW.upload_setting_file_extension_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_upload_setting_file_update`;
DELIMITER $$
CREATE TRIGGER `trg_upload_setting_file_update` AFTER UPDATE ON `upload_setting_file_extension` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Upload setting file extension changed.<br/><br/>';

    IF NEW.upload_setting_name <> OLD.upload_setting_name THEN
        SET audit_log = CONCAT(audit_log, "Upload Setting Name: ", OLD.upload_setting_name, " -> ", NEW.upload_setting_name, "<br/>");
    END IF;

    IF NEW.file_extension_name <> OLD.file_extension_name THEN
        SET audit_log = CONCAT(audit_log, "File Extension Name: ", OLD.file_extension_name, " -> ", NEW.file_extension_name, "<br/>");
    END IF;

    IF NEW.file_extension <> OLD.file_extension THEN
        SET audit_log = CONCAT(audit_log, "File Extension: ", OLD.file_extension, " -> ", NEW.file_extension, "<br/>");
    END IF;
    
    IF audit_log <> 'Upload setting changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('upload_setting_file_extension', NEW.upload_setting_file_extension_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

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
  `multiple_session` varchar(5) DEFAULT 'No',
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
(1, 'Bot', 'bot@christianmotors.ph', '$2y$10$Qu3TEV2u0SBF1jdb2DzB6.OcMChTDStXHEOdX47Y01sOGkl4UnOaK', '123-456-7890', NULL, 'Yes', 'No', 'No', NULL, NULL, NULL, NULL, '2025-10-21 21:37:59', '2025-10-21 21:37:59', 1),
(2, 'Lawrence Agulto', 'l.agulto@christianmotors.ph', '$2y$10$Qu3TEV2u0SBF1jdb2DzB6.OcMChTDStXHEOdX47Y01sOGkl4UnOaK', '123-456-7890', NULL, 'Yes', 'No', 'No', '2025-10-23 19:42:35', NULL, NULL, NULL, '2025-10-21 21:37:59', '2025-10-23 19:42:35', 1);

--
-- Triggers `user_account`
--
DROP TRIGGER IF EXISTS `trg_user_account_insert`;
DELIMITER $$
CREATE TRIGGER `trg_user_account_insert` AFTER INSERT ON `user_account` FOR EACH ROW BEGIN
    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('user_account', NEW.user_account_id, 'User account created.', NEW.last_log_by, NOW());
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
        VALUES ('user_account', NEW.user_account_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE `warehouse` (
  `warehouse_id` int(10) UNSIGNED NOT NULL,
  `warehouse_name` varchar(200) NOT NULL,
  `short_name` varchar(200) NOT NULL,
  `contact_person` varchar(500) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(1000) DEFAULT NULL,
  `city_id` int(10) UNSIGNED NOT NULL,
  `city_name` varchar(100) NOT NULL,
  `state_id` int(10) UNSIGNED NOT NULL,
  `state_name` varchar(100) NOT NULL,
  `country_id` int(10) UNSIGNED NOT NULL,
  `country_name` varchar(100) NOT NULL,
  `warehouse_type_id` int(10) UNSIGNED DEFAULT NULL,
  `warehouse_type_name` varchar(100) NOT NULL,
  `warehouse_status` enum('Active','Archived') DEFAULT 'Active',
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `warehouse`
--

INSERT INTO `warehouse` (`warehouse_id`, `warehouse_name`, `short_name`, `contact_person`, `phone`, `telephone`, `email`, `address`, `city_id`, `city_name`, `state_id`, `state_name`, `country_id`, `country_name`, `warehouse_type_id`, `warehouse_type_name`, `warehouse_status`, `created_date`, `last_updated`, `last_log_by`) VALUES
(1, 'testasdasd', 'asdasdasd', 'asdasdasda', 'asd', 'asdasd', 'sadasd@gmail.com', 'testasdasdasd', 212, 'Accusilian', 2, 'Agusan del Norte', 1, 'Philippines', 3, 'Kitchen', 'Active', '2025-10-22 22:55:54', '2025-10-22 22:58:27', 2);

--
-- Triggers `warehouse`
--
DROP TRIGGER IF EXISTS `trg_warehouse_update`;
DELIMITER $$
CREATE TRIGGER `trg_warehouse_update` AFTER UPDATE ON `warehouse` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Warehouse changed.<br/><br/>';

    IF NEW.warehouse_name <> OLD.warehouse_name THEN
        SET audit_log = CONCAT(audit_log, "Warehouse Name: ", OLD.warehouse_name, " -> ", NEW.warehouse_name, "<br/>");
    END IF;

    IF NEW.short_name <> OLD.short_name THEN
        SET audit_log = CONCAT(audit_log, "Short Name: ", OLD.short_name, " -> ", NEW.short_name, "<br/>");
    END IF;

    IF NEW.contact_person <> OLD.contact_person THEN
        SET audit_log = CONCAT(audit_log, "Contact Person: ", OLD.contact_person, " -> ", NEW.contact_person, "<br/>");
    END IF;

    IF NEW.phone <> OLD.phone THEN
        SET audit_log = CONCAT(audit_log, "Phone: ", OLD.phone, " -> ", NEW.phone, "<br/>");
    END IF;

    IF NEW.telephone <> OLD.telephone THEN
        SET audit_log = CONCAT(audit_log, "Telephone: ", OLD.telephone, " -> ", NEW.telephone, "<br/>");
    END IF;

    IF NEW.email <> OLD.email THEN
        SET audit_log = CONCAT(audit_log, "Email: ", OLD.email, " -> ", NEW.email, "<br/>");
    END IF;

    IF NEW.address <> OLD.address THEN
        SET audit_log = CONCAT(audit_log, "Address: ", OLD.address, " -> ", NEW.address, "<br/>");
    END IF;

    IF NEW.city_name <> OLD.city_name THEN
        SET audit_log = CONCAT(audit_log, "City: ", OLD.city_name, " -> ", NEW.city_name, "<br/>");
    END IF;

    IF NEW.state_name <> OLD.state_name THEN
        SET audit_log = CONCAT(audit_log, "State: ", OLD.state_name, " -> ", NEW.state_name, "<br/>");
    END IF;

    IF NEW.country_name <> OLD.country_name THEN
        SET audit_log = CONCAT(audit_log, "Country: ", OLD.country_name, " -> ", NEW.country_name, "<br/>");
    END IF;

    IF NEW.warehouse_type_name <> OLD.warehouse_type_name THEN
        SET audit_log = CONCAT(audit_log, "Warehouse Type: ", OLD.warehouse_type_name, " -> ", NEW.warehouse_type_name, "<br/>");
    END IF;

    IF NEW.warehouse_status <> OLD.warehouse_status THEN
        SET audit_log = CONCAT(audit_log, "Warehouse Status: ", OLD.warehouse_status, " -> ", NEW.warehouse_status, "<br/>");
    END IF;
    
    IF audit_log <> 'Warehouse changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('warehouse', NEW.warehouse_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `warehouse_type`
--

DROP TABLE IF EXISTS `warehouse_type`;
CREATE TABLE `warehouse_type` (
  `warehouse_type_id` int(10) UNSIGNED NOT NULL,
  `warehouse_type_name` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `warehouse_type`
--

INSERT INTO `warehouse_type` (`warehouse_type_id`, `warehouse_type_name`, `created_date`, `last_updated`, `last_log_by`) VALUES
(2, 'Branchest', '2025-10-21 21:38:03', '2025-10-22 21:56:12', 2),
(3, 'Kitchen', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1),
(4, 'Storage', '2025-10-21 21:38:03', '2025-10-21 21:38:03', 1);

--
-- Triggers `warehouse_type`
--
DROP TRIGGER IF EXISTS `trg_warehouse_type_insert`;
DELIMITER $$
CREATE TRIGGER `trg_warehouse_type_insert` AFTER INSERT ON `warehouse_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Warehouse type created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('warehouse_type', NEW.warehouse_type_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_warehouse_type_update`;
DELIMITER $$
CREATE TRIGGER `trg_warehouse_type_update` AFTER UPDATE ON `warehouse_type` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Warehouse type changed.<br/><br/>';

    IF NEW.warehouse_type_name <> OLD.warehouse_type_name THEN
        SET audit_log = CONCAT(audit_log, "Warehouse Type Name: ", OLD.warehouse_type_name, " -> ", NEW.warehouse_type_name, "<br/>");
    END IF;
    
    IF audit_log <> 'Warehouse type changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('warehouse_type', NEW.warehouse_type_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `work_location`
--

DROP TABLE IF EXISTS `work_location`;
CREATE TABLE `work_location` (
  `work_location_id` int(10) UNSIGNED NOT NULL,
  `work_location_name` varchar(100) NOT NULL,
  `address` varchar(1000) DEFAULT NULL,
  `city_id` int(10) UNSIGNED NOT NULL,
  `city_name` varchar(100) NOT NULL,
  `state_id` int(10) UNSIGNED NOT NULL,
  `state_name` varchar(100) NOT NULL,
  `country_id` int(10) UNSIGNED NOT NULL,
  `country_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_log_by` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `work_location`
--
DROP TRIGGER IF EXISTS `trg_work_location_insert`;
DELIMITER $$
CREATE TRIGGER `trg_work_location_insert` AFTER INSERT ON `work_location` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Work location created.';

    INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
    VALUES ('work_location', NEW.work_location_id, audit_log, NEW.last_log_by, NOW());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_work_location_update`;
DELIMITER $$
CREATE TRIGGER `trg_work_location_update` AFTER UPDATE ON `work_location` FOR EACH ROW BEGIN
    DECLARE audit_log TEXT DEFAULT 'Work location changed.<br/><br/>';

    IF NEW.work_location_name <> OLD.work_location_name THEN
        SET audit_log = CONCAT(audit_log, "Work Location Name: ", OLD.work_location_name, " -> ", NEW.work_location_name, "<br/>");
    END IF;

    IF NEW.address <> OLD.address THEN
        SET audit_log = CONCAT(audit_log, "Address: ", OLD.address, " -> ", NEW.address, "<br/>");
    END IF;

    IF NEW.city_name <> OLD.city_name THEN
        SET audit_log = CONCAT(audit_log, "City: ", OLD.city_name, " -> ", NEW.city_name, "<br/>");
    END IF;

    IF NEW.state_name <> OLD.state_name THEN
        SET audit_log = CONCAT(audit_log, "State: ", OLD.state_name, " -> ", NEW.state_name, "<br/>");
    END IF;

    IF NEW.country_name <> OLD.country_name THEN
        SET audit_log = CONCAT(audit_log, "Country: ", OLD.country_name, " -> ", NEW.country_name, "<br/>");
    END IF;

    IF NEW.phone <> OLD.phone THEN
        SET audit_log = CONCAT(audit_log, "Phone: ", OLD.phone, " -> ", NEW.phone, "<br/>");
    END IF;

    IF NEW.telephone <> OLD.telephone THEN
        SET audit_log = CONCAT(audit_log, "Telephone: ", OLD.telephone, " -> ", NEW.telephone, "<br/>");
    END IF;

    IF NEW.email <> OLD.email THEN
        SET audit_log = CONCAT(audit_log, "Email: ", OLD.email, " -> ", NEW.email, "<br/>");
    END IF;
    
    IF audit_log <> 'Work location changed.<br/><br/>' THEN
        INSERT INTO audit_log (table_name, reference_id, log, changed_by, changed_at) 
        VALUES ('work_location', NEW.work_location_id, audit_log, NEW.last_log_by, NOW());
    END IF;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address_type`
--
ALTER TABLE `address_type`
  ADD PRIMARY KEY (`address_type_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `app_module`
--
ALTER TABLE `app_module`
  ADD PRIMARY KEY (`app_module_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_app_module_menu_item_id` (`menu_item_id`);

--
-- Indexes for table `attribute`
--
ALTER TABLE `attribute`
  ADD PRIMARY KEY (`attribute_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `attribute_value`
--
ALTER TABLE `attribute_value`
  ADD PRIMARY KEY (`attribute_value_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_attribute_value_attribute_id` (`attribute_id`);

--
-- Indexes for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`audit_log_id`),
  ADD KEY `idx_audit_log_table_name` (`table_name`),
  ADD KEY `idx_audit_log_reference_id` (`reference_id`),
  ADD KEY `idx_audit_log_changed_by` (`changed_by`),
  ADD KEY `idx_audit_log_changed_at` (`changed_at`);

--
-- Indexes for table `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`bank_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `bank_account_type`
--
ALTER TABLE `bank_account_type`
  ADD PRIMARY KEY (`bank_account_type_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `blood_type`
--
ALTER TABLE `blood_type`
  ADD PRIMARY KEY (`blood_type_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`city_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_city_state_id` (`state_id`),
  ADD KEY `idx_city_country_id` (`country_id`);

--
-- Indexes for table `civil_status`
--
ALTER TABLE `civil_status`
  ADD PRIMARY KEY (`civil_status_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`company_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_company_city_id` (`city_id`),
  ADD KEY `idx_company_state_id` (`state_id`),
  ADD KEY `idx_company_country_id` (`country_id`),
  ADD KEY `idx_company_currency_id` (`currency_id`);

--
-- Indexes for table `contact_information_type`
--
ALTER TABLE `contact_information_type`
  ADD PRIMARY KEY (`contact_information_type_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`country_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `credential_type`
--
ALTER TABLE `credential_type`
  ADD PRIMARY KEY (`credential_type_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`currency_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`department_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_department_parent_department_id` (`parent_department_id`),
  ADD KEY `idx_department_manager_id` (`manager_id`);

--
-- Indexes for table `departure_reason`
--
ALTER TABLE `departure_reason`
  ADD PRIMARY KEY (`departure_reason_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `educational_stage`
--
ALTER TABLE `educational_stage`
  ADD PRIMARY KEY (`educational_stage_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employee_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_employee_department_id` (`department_id`),
  ADD KEY `idx_employee_job_position_id` (`job_position_id`),
  ADD KEY `idx_employee_work_location_id` (`work_location_id`),
  ADD KEY `idx_employee_employment_type_id` (`employment_type_id`),
  ADD KEY `idx_employee_private_address_city_id` (`private_address_city_id`),
  ADD KEY `idx_employee_private_address_state_id` (`private_address_state_id`),
  ADD KEY `idx_employee_private_address_country_id` (`private_address_country_id`),
  ADD KEY `idx_employee_civil_status_id` (`civil_status_id`),
  ADD KEY `idx_employee_nationality_id` (`nationality_id`),
  ADD KEY `idx_employee_badge_id` (`badge_id`),
  ADD KEY `idx_employee_employment_status` (`employment_status`);

--
-- Indexes for table `employee_document`
--
ALTER TABLE `employee_document`
  ADD PRIMARY KEY (`employee_document_id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `employee_document_type_id` (`employee_document_type_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `employee_document_type`
--
ALTER TABLE `employee_document_type`
  ADD PRIMARY KEY (`employee_document_type_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `employee_education`
--
ALTER TABLE `employee_education`
  ADD PRIMARY KEY (`employee_education_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_employee_education_employee_id` (`employee_id`);

--
-- Indexes for table `employee_emergency_contact`
--
ALTER TABLE `employee_emergency_contact`
  ADD PRIMARY KEY (`employee_emergency_contact_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_employee_emergency_contact_employee_id` (`employee_id`),
  ADD KEY `idx_employee_emergency_contact_relationship_id` (`relationship_id`);

--
-- Indexes for table `employee_experience`
--
ALTER TABLE `employee_experience`
  ADD PRIMARY KEY (`employee_experience_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_employee_experience_employee_id` (`employee_id`),
  ADD KEY `idx_employee_experience_employment_type_id` (`employment_type_id`);

--
-- Indexes for table `employee_language`
--
ALTER TABLE `employee_language`
  ADD PRIMARY KEY (`employee_language_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_employee_language_employee_id` (`employee_id`),
  ADD KEY `idx_employee_language_language_id` (`language_id`),
  ADD KEY `idx_employee_language_language_proficiency_id` (`language_proficiency_id`);

--
-- Indexes for table `employee_license`
--
ALTER TABLE `employee_license`
  ADD PRIMARY KEY (`employee_license_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_employee_license_employee_id` (`employee_id`);

--
-- Indexes for table `employment_location_type`
--
ALTER TABLE `employment_location_type`
  ADD PRIMARY KEY (`employment_location_type_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `employment_type`
--
ALTER TABLE `employment_type`
  ADD PRIMARY KEY (`employment_type_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `file_extension`
--
ALTER TABLE `file_extension`
  ADD PRIMARY KEY (`file_extension_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_file_extension_file_type_id` (`file_type_id`);

--
-- Indexes for table `file_type`
--
ALTER TABLE `file_type`
  ADD PRIMARY KEY (`file_type_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `gender`
--
ALTER TABLE `gender`
  ADD PRIMARY KEY (`gender_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `job_position`
--
ALTER TABLE `job_position`
  ADD PRIMARY KEY (`job_position_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `language`
--
ALTER TABLE `language`
  ADD PRIMARY KEY (`language_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `language_proficiency`
--
ALTER TABLE `language_proficiency`
  ADD PRIMARY KEY (`language_proficiency_id`),
  ADD KEY `last_log_by` (`last_log_by`);

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
-- Indexes for table `nationality`
--
ALTER TABLE `nationality`
  ADD PRIMARY KEY (`nationality_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `notification_setting`
--
ALTER TABLE `notification_setting`
  ADD PRIMARY KEY (`notification_setting_id`),
  ADD KEY `last_log_by` (`last_log_by`);

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
  ADD KEY `idx_otp_user_account_id` (`user_account_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD UNIQUE KEY `sku` (`sku`),
  ADD UNIQUE KEY `barcode` (`barcode`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_product_product_type` (`product_type`),
  ADD KEY `idx_product_barcode` (`barcode`),
  ADD KEY `idx_product_sku` (`sku`),
  ADD KEY `idx_product_is_sellable` (`is_sellable`),
  ADD KEY `idx_product_is_purchasable` (`is_purchasable`),
  ADD KEY `idx_product_show_on_pos` (`show_on_pos`),
  ADD KEY `idx_product_discount_type` (`discount_type`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`product_categories_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `product_category_id` (`product_category_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`product_category_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_product_category_parent_category_id` (`parent_category_id`),
  ADD KEY `idx_product_category_costing_method` (`costing_method`);

--
-- Indexes for table `product_pricelist`
--
ALTER TABLE `product_pricelist`
  ADD PRIMARY KEY (`product_pricelist_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_product_pricelist_product_id` (`product_id`),
  ADD KEY `idx_product_pricelist_product_variant_id` (`product_variant_id`),
  ADD KEY `idx_product_pricelist_validity_start_date` (`validity_start_date`),
  ADD KEY `idx_product_pricelist_validity_end_date` (`validity_end_date`),
  ADD KEY `idx_product_pricelist_rule_type` (`rule_type`),
  ADD KEY `idx_product_pricelist_pricelist_computation` (`pricelist_computation`);

--
-- Indexes for table `product_tax`
--
ALTER TABLE `product_tax`
  ADD PRIMARY KEY (`product_tax_id`),
  ADD KEY `tax_id` (`tax_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_product_tax_product_id` (`product_id`),
  ADD KEY `idx_product_tax_tax_type` (`tax_type`);

--
-- Indexes for table `product_variant`
--
ALTER TABLE `product_variant`
  ADD PRIMARY KEY (`product_variant_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_product_variant_product_id` (`product_id`),
  ADD KEY `idx_product_variant_attribute_value_id` (`attribute_value_id`),
  ADD KEY `idx_product_variant_attribute_id` (`attribute_id`);

--
-- Indexes for table `relationship`
--
ALTER TABLE `relationship`
  ADD PRIMARY KEY (`relationship_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `religion`
--
ALTER TABLE `religion`
  ADD PRIMARY KEY (`religion_id`),
  ADD KEY `last_log_by` (`last_log_by`);

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
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `role_permission`
--
ALTER TABLE `role_permission`
  ADD PRIMARY KEY (`role_permission_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_role_permission_role_id` (`role_id`),
  ADD KEY `idx_role_permission_menu_item_id` (`menu_item_id`);

--
-- Indexes for table `role_system_action_permission`
--
ALTER TABLE `role_system_action_permission`
  ADD PRIMARY KEY (`role_system_action_permission_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_role_system_action_permission_role_id` (`role_id`),
  ADD KEY `idx_role_system_action_permission_system_action_id` (`system_action_id`);

--
-- Indexes for table `role_user_account`
--
ALTER TABLE `role_user_account`
  ADD PRIMARY KEY (`role_user_account_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_role_user_account_role_id` (`role_id`),
  ADD KEY `idx_role_user_account_user_account_id` (`user_account_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_sessions_user_account_id` (`user_account_id`);

--
-- Indexes for table `state`
--
ALTER TABLE `state`
  ADD PRIMARY KEY (`state_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_state_country_id` (`country_id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`supplier_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_supplier_city_id` (`city_id`),
  ADD KEY `idx_supplier_state_id` (`state_id`),
  ADD KEY `idx_supplier_country_id` (`country_id`),
  ADD KEY `idx_supplier_supplier_status` (`supplier_status`);

--
-- Indexes for table `system_action`
--
ALTER TABLE `system_action`
  ADD PRIMARY KEY (`system_action_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `tax`
--
ALTER TABLE `tax`
  ADD PRIMARY KEY (`tax_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_tax_tax_type` (`tax_type`),
  ADD KEY `idx_tax_tax_computation` (`tax_computation`),
  ADD KEY `idx_tax_tax_scope` (`tax_scope`),
  ADD KEY `idx_tax_tax_status` (`tax_status`);

--
-- Indexes for table `upload_setting`
--
ALTER TABLE `upload_setting`
  ADD PRIMARY KEY (`upload_setting_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `upload_setting_file_extension`
--
ALTER TABLE `upload_setting_file_extension`
  ADD PRIMARY KEY (`upload_setting_file_extension_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_upload_setting_file_ext_upload_setting_id` (`upload_setting_id`),
  ADD KEY `idx_upload_setting_file_ext_file_extension_id` (`file_extension_id`);

--
-- Indexes for table `user_account`
--
ALTER TABLE `user_account`
  ADD PRIMARY KEY (`user_account_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_user_account_email` (`email`),
  ADD KEY `idx_user_account_phone` (`phone`);

--
-- Indexes for table `warehouse`
--
ALTER TABLE `warehouse`
  ADD PRIMARY KEY (`warehouse_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_warehouse_city_id` (`city_id`),
  ADD KEY `idx_warehouse_state_id` (`state_id`),
  ADD KEY `idx_warehouse_country_id` (`country_id`),
  ADD KEY `idx_warehouse_warehouse_type_id` (`warehouse_type_id`),
  ADD KEY `idx_warehouse_warehouse_status` (`warehouse_status`);

--
-- Indexes for table `warehouse_type`
--
ALTER TABLE `warehouse_type`
  ADD PRIMARY KEY (`warehouse_type_id`),
  ADD KEY `last_log_by` (`last_log_by`);

--
-- Indexes for table `work_location`
--
ALTER TABLE `work_location`
  ADD PRIMARY KEY (`work_location_id`),
  ADD KEY `last_log_by` (`last_log_by`),
  ADD KEY `idx_work_location_city_id` (`city_id`),
  ADD KEY `idx_work_location_state_id` (`state_id`),
  ADD KEY `idx_work_location_country_id` (`country_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address_type`
--
ALTER TABLE `address_type`
  MODIFY `address_type_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `app_module`
--
ALTER TABLE `app_module`
  MODIFY `app_module_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `attribute`
--
ALTER TABLE `attribute`
  MODIFY `attribute_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `attribute_value`
--
ALTER TABLE `attribute_value`
  MODIFY `attribute_value_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `audit_log`
--
ALTER TABLE `audit_log`
  MODIFY `audit_log_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bank`
--
ALTER TABLE `bank`
  MODIFY `bank_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `bank_account_type`
--
ALTER TABLE `bank_account_type`
  MODIFY `bank_account_type_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `blood_type`
--
ALTER TABLE `blood_type`
  MODIFY `blood_type_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `city_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3766;

--
-- AUTO_INCREMENT for table `civil_status`
--
ALTER TABLE `civil_status`
  MODIFY `civil_status_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `company_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_information_type`
--
ALTER TABLE `contact_information_type`
  MODIFY `contact_information_type_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `country_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `credential_type`
--
ALTER TABLE `credential_type`
  MODIFY `credential_type_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `currency`
--
ALTER TABLE `currency`
  MODIFY `currency_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `department_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `departure_reason`
--
ALTER TABLE `departure_reason`
  MODIFY `departure_reason_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `educational_stage`
--
ALTER TABLE `educational_stage`
  MODIFY `educational_stage_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `employee_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_document`
--
ALTER TABLE `employee_document`
  MODIFY `employee_document_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_document_type`
--
ALTER TABLE `employee_document_type`
  MODIFY `employee_document_type_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `employee_education`
--
ALTER TABLE `employee_education`
  MODIFY `employee_education_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_emergency_contact`
--
ALTER TABLE `employee_emergency_contact`
  MODIFY `employee_emergency_contact_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_experience`
--
ALTER TABLE `employee_experience`
  MODIFY `employee_experience_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_language`
--
ALTER TABLE `employee_language`
  MODIFY `employee_language_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_license`
--
ALTER TABLE `employee_license`
  MODIFY `employee_license_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employment_location_type`
--
ALTER TABLE `employment_location_type`
  MODIFY `employment_location_type_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employment_type`
--
ALTER TABLE `employment_type`
  MODIFY `employment_type_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `file_extension`
--
ALTER TABLE `file_extension`
  MODIFY `file_extension_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `file_type`
--
ALTER TABLE `file_type`
  MODIFY `file_type_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `gender`
--
ALTER TABLE `gender`
  MODIFY `gender_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `job_position`
--
ALTER TABLE `job_position`
  MODIFY `job_position_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `language`
--
ALTER TABLE `language`
  MODIFY `language_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=152;

--
-- AUTO_INCREMENT for table `language_proficiency`
--
ALTER TABLE `language_proficiency`
  MODIFY `language_proficiency_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `login_attempts_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `menu_item`
--
ALTER TABLE `menu_item`
  MODIFY `menu_item_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `nationality`
--
ALTER TABLE `nationality`
  MODIFY `nationality_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=190;

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
  MODIFY `otp_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `product_categories_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product_category`
--
ALTER TABLE `product_category`
  MODIFY `product_category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product_pricelist`
--
ALTER TABLE `product_pricelist`
  MODIFY `product_pricelist_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_tax`
--
ALTER TABLE `product_tax`
  MODIFY `product_tax_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_variant`
--
ALTER TABLE `product_variant`
  MODIFY `product_variant_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `relationship`
--
ALTER TABLE `relationship`
  MODIFY `relationship_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `religion`
--
ALTER TABLE `religion`
  MODIFY `religion_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `reset_token`
--
ALTER TABLE `reset_token`
  MODIFY `reset_token_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `role_permission`
--
ALTER TABLE `role_permission`
  MODIFY `role_permission_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `role_system_action_permission`
--
ALTER TABLE `role_system_action_permission`
  MODIFY `role_system_action_permission_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `role_user_account`
--
ALTER TABLE `role_user_account`
  MODIFY `role_user_account_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `session_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `state`
--
ALTER TABLE `state`
  MODIFY `state_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `supplier_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `system_action`
--
ALTER TABLE `system_action`
  MODIFY `system_action_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `tax`
--
ALTER TABLE `tax`
  MODIFY `tax_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `upload_setting`
--
ALTER TABLE `upload_setting`
  MODIFY `upload_setting_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `upload_setting_file_extension`
--
ALTER TABLE `upload_setting_file_extension`
  MODIFY `upload_setting_file_extension_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `user_account`
--
ALTER TABLE `user_account`
  MODIFY `user_account_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `warehouse`
--
ALTER TABLE `warehouse`
  MODIFY `warehouse_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `warehouse_type`
--
ALTER TABLE `warehouse_type`
  MODIFY `warehouse_type_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `work_location`
--
ALTER TABLE `work_location`
  MODIFY `work_location_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address_type`
--
ALTER TABLE `address_type`
  ADD CONSTRAINT `address_type_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `app_module`
--
ALTER TABLE `app_module`
  ADD CONSTRAINT `app_module_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `attribute`
--
ALTER TABLE `attribute`
  ADD CONSTRAINT `attribute_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `attribute_value`
--
ALTER TABLE `attribute_value`
  ADD CONSTRAINT `attribute_value_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `attribute` (`attribute_id`),
  ADD CONSTRAINT `attribute_value_ibfk_2` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD CONSTRAINT `audit_log_ibfk_1` FOREIGN KEY (`changed_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `bank`
--
ALTER TABLE `bank`
  ADD CONSTRAINT `bank_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `bank_account_type`
--
ALTER TABLE `bank_account_type`
  ADD CONSTRAINT `bank_account_type_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `blood_type`
--
ALTER TABLE `blood_type`
  ADD CONSTRAINT `blood_type_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `city`
--
ALTER TABLE `city`
  ADD CONSTRAINT `city_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`),
  ADD CONSTRAINT `city_ibfk_2` FOREIGN KEY (`state_id`) REFERENCES `state` (`state_id`),
  ADD CONSTRAINT `city_ibfk_3` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`);

--
-- Constraints for table `civil_status`
--
ALTER TABLE `civil_status`
  ADD CONSTRAINT `civil_status_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `company`
--
ALTER TABLE `company`
  ADD CONSTRAINT `company_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`),
  ADD CONSTRAINT `company_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`),
  ADD CONSTRAINT `company_ibfk_3` FOREIGN KEY (`state_id`) REFERENCES `state` (`state_id`),
  ADD CONSTRAINT `company_ibfk_4` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`);

--
-- Constraints for table `contact_information_type`
--
ALTER TABLE `contact_information_type`
  ADD CONSTRAINT `contact_information_type_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `country`
--
ALTER TABLE `country`
  ADD CONSTRAINT `country_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `credential_type`
--
ALTER TABLE `credential_type`
  ADD CONSTRAINT `credential_type_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `currency`
--
ALTER TABLE `currency`
  ADD CONSTRAINT `currency_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `department_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `departure_reason`
--
ALTER TABLE `departure_reason`
  ADD CONSTRAINT `departure_reason_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `educational_stage`
--
ALTER TABLE `educational_stage`
  ADD CONSTRAINT `educational_stage_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `employee_document`
--
ALTER TABLE `employee_document`
  ADD CONSTRAINT `employee_document_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  ADD CONSTRAINT `employee_document_ibfk_2` FOREIGN KEY (`employee_document_type_id`) REFERENCES `employee_document_type` (`employee_document_type_id`),
  ADD CONSTRAINT `employee_document_ibfk_3` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `employee_document_type`
--
ALTER TABLE `employee_document_type`
  ADD CONSTRAINT `employee_document_type_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `employee_education`
--
ALTER TABLE `employee_education`
  ADD CONSTRAINT `employee_education_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  ADD CONSTRAINT `employee_education_ibfk_2` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `employee_emergency_contact`
--
ALTER TABLE `employee_emergency_contact`
  ADD CONSTRAINT `employee_emergency_contact_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  ADD CONSTRAINT `employee_emergency_contact_ibfk_2` FOREIGN KEY (`relationship_id`) REFERENCES `relationship` (`relationship_id`),
  ADD CONSTRAINT `employee_emergency_contact_ibfk_3` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `employee_experience`
--
ALTER TABLE `employee_experience`
  ADD CONSTRAINT `employee_experience_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  ADD CONSTRAINT `employee_experience_ibfk_2` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `employee_language`
--
ALTER TABLE `employee_language`
  ADD CONSTRAINT `employee_language_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  ADD CONSTRAINT `employee_language_ibfk_2` FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`),
  ADD CONSTRAINT `employee_language_ibfk_3` FOREIGN KEY (`language_proficiency_id`) REFERENCES `language_proficiency` (`language_proficiency_id`),
  ADD CONSTRAINT `employee_language_ibfk_4` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `employee_license`
--
ALTER TABLE `employee_license`
  ADD CONSTRAINT `employee_license_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  ADD CONSTRAINT `employee_license_ibfk_2` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `employment_location_type`
--
ALTER TABLE `employment_location_type`
  ADD CONSTRAINT `employment_location_type_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `employment_type`
--
ALTER TABLE `employment_type`
  ADD CONSTRAINT `employment_type_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `file_extension`
--
ALTER TABLE `file_extension`
  ADD CONSTRAINT `file_extension_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`),
  ADD CONSTRAINT `file_extension_ibfk_2` FOREIGN KEY (`file_type_id`) REFERENCES `file_type` (`file_type_id`);

--
-- Constraints for table `file_type`
--
ALTER TABLE `file_type`
  ADD CONSTRAINT `file_type_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `gender`
--
ALTER TABLE `gender`
  ADD CONSTRAINT `gender_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `job_position`
--
ALTER TABLE `job_position`
  ADD CONSTRAINT `job_position_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `language`
--
ALTER TABLE `language`
  ADD CONSTRAINT `language_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `language_proficiency`
--
ALTER TABLE `language_proficiency`
  ADD CONSTRAINT `language_proficiency_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

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
-- Constraints for table `nationality`
--
ALTER TABLE `nationality`
  ADD CONSTRAINT `nationality_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

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
  ADD CONSTRAINT `otp_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`),
  ADD CONSTRAINT `otp_ibfk_2` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD CONSTRAINT `product_categories_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `product_categories_ibfk_2` FOREIGN KEY (`product_category_id`) REFERENCES `product_category` (`product_category_id`),
  ADD CONSTRAINT `product_categories_ibfk_3` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `product_category`
--
ALTER TABLE `product_category`
  ADD CONSTRAINT `product_category_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `product_pricelist`
--
ALTER TABLE `product_pricelist`
  ADD CONSTRAINT `product_pricelist_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `product_pricelist_ibfk_2` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variant` (`product_variant_id`),
  ADD CONSTRAINT `product_pricelist_ibfk_3` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `product_tax`
--
ALTER TABLE `product_tax`
  ADD CONSTRAINT `product_tax_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `product_tax_ibfk_2` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`tax_id`),
  ADD CONSTRAINT `product_tax_ibfk_3` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `product_variant`
--
ALTER TABLE `product_variant`
  ADD CONSTRAINT `product_variant_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `product_variant_ibfk_2` FOREIGN KEY (`attribute_value_id`) REFERENCES `attribute_value` (`attribute_value_id`),
  ADD CONSTRAINT `product_variant_ibfk_3` FOREIGN KEY (`attribute_id`) REFERENCES `attribute` (`attribute_id`),
  ADD CONSTRAINT `product_variant_ibfk_4` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `relationship`
--
ALTER TABLE `relationship`
  ADD CONSTRAINT `relationship_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `religion`
--
ALTER TABLE `religion`
  ADD CONSTRAINT `religion_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `reset_token`
--
ALTER TABLE `reset_token`
  ADD CONSTRAINT `reset_token_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`),
  ADD CONSTRAINT `reset_token_ibfk_2` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `role`
--
ALTER TABLE `role`
  ADD CONSTRAINT `role_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `role_permission`
--
ALTER TABLE `role_permission`
  ADD CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_item` (`menu_item_id`),
  ADD CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  ADD CONSTRAINT `role_permission_ibfk_3` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `role_system_action_permission`
--
ALTER TABLE `role_system_action_permission`
  ADD CONSTRAINT `role_system_action_permission_ibfk_1` FOREIGN KEY (`system_action_id`) REFERENCES `system_action` (`system_action_id`),
  ADD CONSTRAINT `role_system_action_permission_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  ADD CONSTRAINT `role_system_action_permission_ibfk_3` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `role_user_account`
--
ALTER TABLE `role_user_account`
  ADD CONSTRAINT `role_user_account_ibfk_1` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`user_account_id`),
  ADD CONSTRAINT `role_user_account_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  ADD CONSTRAINT `role_user_account_ibfk_3` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`),
  ADD CONSTRAINT `sessions_ibfk_2` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `state`
--
ALTER TABLE `state`
  ADD CONSTRAINT `state_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`),
  ADD CONSTRAINT `state_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`);

--
-- Constraints for table `supplier`
--
ALTER TABLE `supplier`
  ADD CONSTRAINT `supplier_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `system_action`
--
ALTER TABLE `system_action`
  ADD CONSTRAINT `system_action_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `tax`
--
ALTER TABLE `tax`
  ADD CONSTRAINT `tax_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `upload_setting`
--
ALTER TABLE `upload_setting`
  ADD CONSTRAINT `upload_setting_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `upload_setting_file_extension`
--
ALTER TABLE `upload_setting_file_extension`
  ADD CONSTRAINT `upload_setting_file_extension_ibfk_1` FOREIGN KEY (`upload_setting_id`) REFERENCES `upload_setting` (`upload_setting_id`),
  ADD CONSTRAINT `upload_setting_file_extension_ibfk_2` FOREIGN KEY (`file_extension_id`) REFERENCES `file_extension` (`file_extension_id`),
  ADD CONSTRAINT `upload_setting_file_extension_ibfk_3` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `user_account`
--
ALTER TABLE `user_account`
  ADD CONSTRAINT `user_account_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `warehouse`
--
ALTER TABLE `warehouse`
  ADD CONSTRAINT `warehouse_ibfk_1` FOREIGN KEY (`warehouse_type_id`) REFERENCES `warehouse_type` (`warehouse_type_id`),
  ADD CONSTRAINT `warehouse_ibfk_2` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `warehouse_type`
--
ALTER TABLE `warehouse_type`
  ADD CONSTRAINT `warehouse_type_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`);

--
-- Constraints for table `work_location`
--
ALTER TABLE `work_location`
  ADD CONSTRAINT `work_location_ibfk_1` FOREIGN KEY (`last_log_by`) REFERENCES `user_account` (`user_account_id`),
  ADD CONSTRAINT `work_location_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`),
  ADD CONSTRAINT `work_location_ibfk_3` FOREIGN KEY (`state_id`) REFERENCES `state` (`state_id`),
  ADD CONSTRAINT `work_location_ibfk_4` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
