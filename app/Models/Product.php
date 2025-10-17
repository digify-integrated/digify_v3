<?php
namespace App\Models;

use App\Core\Model;

class Product extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveProductLanguage(
        $p_product_id,
        $p_language_id,
        $p_language_name,
        $p_language_proficiency_id,
        $p_language_proficiency_name,
        $p_last_log_by
    ) {
        $sql = 'CALL saveProductLanguage(
            :p_product_id,
            :p_language_id,
            :p_language_name,
            :p_language_proficiency_id,
            :p_language_proficiency_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'                 => $p_product_id,
            'p_language_id'                 => $p_language_id,
            'p_language_name'               => $p_language_name,
            'p_language_proficiency_id'     => $p_language_proficiency_id,
            'p_language_proficiency_name'   => $p_language_proficiency_name,
            'p_last_log_by'                 => $p_last_log_by
        ]);
    }

    public function saveProductEducation(
        $p_product_education_id,
        $p_product_id,
        $p_school,
        $p_degree,
        $p_field_of_study,
        $p_start_month,
        $p_start_year,
        $p_end_month,
        $p_end_year,
        $p_activities_societies,
        $p_education_description,
        $p_last_log_by
    ) {
        $sql = 'CALL saveProductEducation(
            :p_product_education_id,
            :p_product_id,
            :p_school,
            :p_degree,
            :p_field_of_study,
            :p_start_month,
            :p_start_year,
            :p_end_month,
            :p_end_year,
            :p_activities_societies,
            :p_education_description,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_education_id'   => $p_product_education_id,
            'p_product_id'             => $p_product_id,
            'p_school'                  => $p_school,
            'p_degree'                  => $p_degree,
            'p_field_of_study'          => $p_field_of_study,
            'p_start_month'             => $p_start_month,
            'p_start_year'              => $p_start_year,
            'p_end_month'               => $p_end_month,
            'p_end_year'                => $p_end_year,
            'p_activities_societies'    => $p_activities_societies,
            'p_education_description'   => $p_education_description,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    public function saveProductEmergencyContact(
        $p_product_emergency_contact_id,
        $p_product_id,
        $p_emergency_contact_name,
        $p_relationship_id,
        $p_relationship_name,
        $p_telephone,
        $p_mobile,
        $p_email,
        $p_last_log_by
    ) {
        $sql = 'CALL saveProductEmergencyContact(
            :p_product_emergency_contact_id,
            :p_product_id,
            :p_emergency_contact_name,
            :p_relationship_id,
            :p_relationship_name,
            :p_telephone,
            :p_mobile,
            :p_email,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_emergency_contact_id'   => $p_product_emergency_contact_id,
            'p_product_id'                     => $p_product_id,
            'p_emergency_contact_name'          => $p_emergency_contact_name,
            'p_relationship_id'                 => $p_relationship_id,
            'p_relationship_name'               => $p_relationship_name,
            'p_telephone'                       => $p_telephone,
            'p_mobile'                          => $p_mobile,
            'p_email'                           => $p_email,
            'p_last_log_by'                     => $p_last_log_by
        ]);
    }

    public function saveProductLicense(
        $p_product_license_id,
        $p_product_id,
        $p_licensed_profession,
        $p_licensing_body,
        $p_license_number,
        $p_issue_date,
        $p_expiration_date,
        $p_last_log_by
    ) {
        $sql = 'CALL saveProductLicense(
            :p_product_license_id,
            :p_product_id,
            :p_licensed_profession,
            :p_licensing_body,
            :p_license_number,
            :p_issue_date,
            :p_expiration_date,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_license_id'     => $p_product_license_id,
            'p_product_id'             => $p_product_id,
            'p_licensed_profession'     => $p_licensed_profession,
            'p_licensing_body'          => $p_licensing_body,
            'p_license_number'          => $p_license_number,
            'p_issue_date'              => $p_issue_date,
            'p_expiration_date'         => $p_expiration_date,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    public function saveProductExperience(
        $p_product_experience_id,
        $p_product_id,
        $p_job_title,
        $p_employment_type_id,
        $p_employment_type_name,
        $p_company_name,
        $p_location,
        $p_start_month,
        $p_start_year,
        $p_end_month,
        $p_end_year,
        $p_job_description,
        $p_last_log_by
    ) {
        $sql = 'CALL saveProductExperience(
            :p_product_experience_id,
            :p_product_id,
            :p_job_title,
            :p_employment_type_id,
            :p_employment_type_name,
            :p_company_name,
            :p_location,
            :p_start_month,
            :p_start_year,
            :p_end_month,
            :p_end_year,
            :p_job_description,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_experience_id'  => $p_product_experience_id,
            'p_product_id'             => $p_product_id,
            'p_job_title'               => $p_job_title,
            'p_employment_type_id'      => $p_employment_type_id,
            'p_employment_type_name'    => $p_employment_type_name,
            'p_company_name'            => $p_company_name,
            'p_location'                => $p_location,
            'p_start_month'             => $p_start_month,
            'p_start_year'              => $p_start_year,
            'p_end_month'               => $p_end_month,
            'p_end_year'                => $p_end_year,
            'p_job_description'         => $p_job_description,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    public function insertProduct(
        $p_full_name,
        $p_first_name,
        $p_middle_name,
        $p_last_name,
        $p_suffix,
        $p_company_id,
        $p_company_name,
        $p_department_id,
        $p_department_name,
        $p_job_position_id,
        $p_job_position_name,
        $p_last_log_by
    )    {
        $sql = 'CALL insertProduct(
            :p_full_name,
            :p_first_name,
            :p_middle_name,
            :p_last_name,
            :p_suffix,
            :p_company_id,
            :p_company_name,
            :p_department_id,
            :p_department_name,
            :p_job_position_id,
            :p_job_position_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_full_name'           => $p_full_name,
            'p_first_name'          => $p_first_name,
            'p_middle_name'         => $p_middle_name,
            'p_last_name'           => $p_last_name,
            'p_suffix'              => $p_suffix,
            'p_company_id'          => $p_company_id,
            'p_company_name'        => $p_company_name,
            'p_department_id'       => $p_department_id,
            'p_department_name'     => $p_department_name,
            'p_job_position_id'     => $p_job_position_id,
            'p_job_position_name'   => $p_job_position_name,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_product_id'] ?? null;
    }
    public function insertProductDocument(
        $p_product_id,
        $p_document_name,
        $p_document_file,
        $p_product_document_type_id,
        $p_product_document_type_name,
        $p_last_log_by
    )    {
        $sql = 'CALL insertProductDocument(
            :p_product_id,
            :p_document_name,
            :p_document_file,
            :p_product_document_type_id,
            :p_product_document_type_name,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_product_id'                     => $p_product_id,
            'p_document_name'                   => $p_document_name,
            'p_document_file'                   => $p_document_file,
            'p_product_document_type_id'       => $p_product_document_type_id,
            'p_product_document_type_name'     => $p_product_document_type_name,
            'p_last_log_by'                     => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateProductPersonalDetails(
        $p_product_id,
        $p_full_name,
        $p_first_name,
        $p_middle_name,
        $p_last_name,
        $p_suffix,
        $p_nickname,
        $p_private_address,
        $p_private_address_city_id,
        $p_private_address_city_name,
        $p_private_address_state_id,
        $p_private_address_state_name,
        $p_private_address_country_id,
        $p_private_address_country_name,
        $p_civil_status_id,
        $p_civil_status_name,
        $p_dependents,
        $p_religion_id,
        $p_religion_name,
        $p_blood_type_id,
        $p_blood_type_name,
        $p_home_work_distance,
        $p_height,
        $p_weight,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductPersonalDetails(
            :p_product_id,
            :p_full_name,
            :p_first_name,
            :p_middle_name,
            :p_last_name,
            :p_suffix,
            :p_nickname,
            :p_private_address,
            :p_private_address_city_id,
            :p_private_address_city_name,
            :p_private_address_state_id,
            :p_private_address_state_name,
            :p_private_address_country_id,
            :p_private_address_country_name,
            :p_civil_status_id,
            :p_civil_status_name,
            :p_dependents,
            :p_religion_id,
            :p_religion_name,
            :p_blood_type_id,
            :p_blood_type_name,
            :p_home_work_distance,
            :p_height,
            :p_weight,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'                     => $p_product_id,
            'p_full_name'                       => $p_full_name,
            'p_first_name'                      => $p_first_name,
            'p_middle_name'                     => $p_middle_name,
            'p_last_name'                       => $p_last_name,
            'p_suffix'                          => $p_suffix,
            'p_nickname'                        => $p_nickname,
            'p_private_address'                 => $p_private_address,
            'p_private_address_city_id'         => $p_private_address_city_id,
            'p_private_address_city_name'       => $p_private_address_city_name,
            'p_private_address_state_id'        => $p_private_address_state_id,
            'p_private_address_state_name'      => $p_private_address_state_name,
            'p_private_address_country_id'      => $p_private_address_country_id,
            'p_private_address_country_name'    => $p_private_address_country_name,
            'p_civil_status_id'                 => $p_civil_status_id,
            'p_civil_status_name'               => $p_civil_status_name,
            'p_dependents'                      => $p_dependents,
            'p_religion_id'                     => $p_religion_id,
            'p_religion_name'                   => $p_religion_name,
            'p_blood_type_id'                   => $p_blood_type_id,
            'p_blood_type_name'                 => $p_blood_type_name,
            'p_home_work_distance'              => $p_home_work_distance,
            'p_height'                          => $p_height,
            'p_weight'                          => $p_weight,
            'p_last_log_by'                     => $p_last_log_by
        ]);
    }

    public function updateProductPINCode(
        $p_product_id,
        $p_pin_code,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductPINCode(
            :p_product_id,
            :p_pin_code,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'     => $p_product_id,
            'p_pin_code'        => $p_pin_code,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductBadgeId(
        $p_product_id,
        $p_badge_id,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductBadgeId(
            :p_product_id,
            :p_badge_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'     => $p_product_id,
            'p_badge_id'        => $p_badge_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductPrivateEmail(
        $p_product_id,
        $p_private_email,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductPrivateEmail(
            :p_product_id,
            :p_private_email,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'     => $p_product_id,
            'p_private_email'   => $p_private_email,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductPrivatePhone(
        $p_product_id,
        $p_private_phone,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductPrivatePhone(
            :p_product_id,
            :p_private_phone,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'     => $p_product_id,
            'p_private_phone'   => $p_private_phone,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductPrivateTelephone(
        $p_product_id,
        $p_private_telephone,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductPrivateTelephone(
            :p_product_id,
            :p_private_telephone,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'         => $p_product_id,
            'p_private_telephone'   => $p_private_telephone,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateProductNationality(
        $p_product_id,
        $p_nationality_id,
        $p_nationality_name,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductNationality(
            :p_product_id,
            :p_nationality_id,
            :p_nationality_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'         => $p_product_id,
            'p_nationality_id'      => $p_nationality_id,
            'p_nationality_name'    => $p_nationality_name,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateProductGender(
        $p_product_id,
        $p_gender_id,
        $p_gender_name,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductGender(
            :p_product_id,
            :p_gender_id,
            :p_gender_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'     => $p_product_id,
            'p_gender_id'       => $p_gender_id,
            'p_gender_name'     => $p_gender_name,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductBirthday(
        $p_product_id,
        $p_birthday,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductBirthday(
            :p_product_id,
            :p_birthday,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'     => $p_product_id,
            'p_birthday'        => $p_birthday,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductPlaceOfBirth(
        $p_product_id,
        $p_place_of_birth,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductPlaceOfBirth(
            :p_product_id,
            :p_place_of_birth,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'     => $p_product_id,
            'p_place_of_birth'  => $p_place_of_birth,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductCompany(
        $p_product_id,
        $p_company_id,
        $p_company_name,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductCompany(
            :p_product_id,
            :p_company_id,
            :p_company_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'     => $p_product_id,
            'p_company_id'      => $p_company_id,
            'p_company_name'    => $p_company_name,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductDepartment(
        $p_product_id,
        $p_department_id,
        $p_department_name,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductDepartment(
            :p_product_id,
            :p_department_id,
            :p_department_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'         => $p_product_id,
            'p_department_id'       => $p_department_id,
            'p_department_name'     => $p_department_name,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateProductJobPosition(
        $p_product_id,
        $p_job_position_id,
        $p_job_position_name,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductJobPosition(
            :p_product_id,
            :p_job_position_id,
            :p_job_position_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'         => $p_product_id,
            'p_job_position_id'     => $p_job_position_id,
            'p_job_position_name'   => $p_job_position_name,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateProductManager(
        $p_product_id,
        $p_manager_id,
        $p_manager_name,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductManager(
            :p_product_id,
            :p_manager_id,
            :p_manager_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'     => $p_product_id,
            'p_manager_id'      => $p_manager_id,
            'p_manager_name'    => $p_manager_name,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductTimeOffApprover(
        $p_product_id,
        $p_time_off_approver_id,
        $p_time_off_approver_name,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductTimeOffApprover(
            :p_product_id,
            :p_time_off_approver_id,
            :p_time_off_approver_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'             => $p_product_id,
            'p_time_off_approver_id'    => $p_time_off_approver_id,
            'p_time_off_approver_name'  => $p_time_off_approver_name,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    public function updateProductEmploymentType(
        $p_product_id,
        $p_employment_type_id,
        $p_employment_type_name,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductEmploymentType(
            :p_product_id,
            :p_employment_type_id,
            :p_employment_type_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'             => $p_product_id,
            'p_employment_type_id'      => $p_employment_type_id,
            'p_employment_type_name'    => $p_employment_type_name,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    public function updateProductEmploymentLocationType(
        $p_product_id,
        $p_employment_location_type_id,
        $p_employment_location_type_name,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductEmploymentLocationType(
            :p_product_id,
            :p_employment_location_type_id,
            :p_employment_location_type_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'                     => $p_product_id,
            'p_employment_location_type_id'     => $p_employment_location_type_id,
            'p_employment_location_type_name'   => $p_employment_location_type_name,
            'p_last_log_by'                     => $p_last_log_by
        ]);
    }

    public function updateProductWorkLocation(
        $p_product_id,
        $p_work_location_id,
        $p_work_location_name,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductWorkLocation(
            :p_product_id,
            :p_work_location_id,
            :p_work_location_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'         => $p_product_id,
            'p_work_location_id'    => $p_work_location_id,
            'p_work_location_name'  => $p_work_location_name,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateProductOnBoardDate(
        $p_product_id,
        $p_on_board_date,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductOnBoardDate(
            :p_product_id,
            :p_on_board_date,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'     => $p_product_id,
            'p_on_board_date'   => $p_on_board_date,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductWorkEmail(
        $p_product_id,
        $p_work_email,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductWorkEmail(
            :p_product_id,
            :p_work_email,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'     => $p_product_id,
            'p_work_email'      => $p_work_email,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductWorkPhone(
        $p_product_id,
        $p_work_phone,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductWorkPhone(
            :p_product_id,
            :p_work_phone,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'     => $p_product_id,
            'p_work_phone'      => $p_work_phone,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductWorkTelephone(
        $p_product_id,
        $p_work_telephone,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductWorkTelephone(
            :p_product_id,
            :p_work_telephone,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'     => $p_product_id,
            'p_work_telephone'  => $p_work_telephone,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductImage(
        $p_product_id,
        $p_product_image,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductImage(
            :p_product_id,
            :p_product_image,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'     => $p_product_id,
            'p_product_image'  => $p_product_image,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductArchive(
        $p_product_id,
        $p_departure_reason_id,
        $p_departure_reason_name,
        $p_detailed_departure_reason,
        $p_departure_date,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductArchive(
            :p_product_id,
            :p_departure_reason_id,
            :p_departure_reason_name,
            :p_detailed_departure_reason,
            :p_departure_date,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'                 => $p_product_id,
            'p_departure_reason_id'         => $p_departure_reason_id,
            'p_departure_reason_name'       => $p_departure_reason_name,
            'p_detailed_departure_reason'   => $p_detailed_departure_reason,
            'p_departure_date'              => $p_departure_date,
            'p_last_log_by'                 => $p_last_log_by
        ]);
    }

    public function updateProductUnarchive(
        $p_product_id,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductUnarchive(
            :p_product_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'     => $p_product_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchProduct(
        $p_product_id
    ) {
        $sql = 'CALL fetchProduct(
            :p_product_id
        )';
        
        return $this->fetch($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function fetchProductEducation(
        $p_product_education_id
    ): array|null {
        $sql = 'CALL fetchProductEducation(
            :p_product_education_id
        )';
        
        return $this->fetch($sql, [
            'p_product_education_id' => $p_product_education_id
        ]);
    }

    public function fetchProductEmergencyContact(
        $p_product_emergency_contact_id
    ): array|null {
        $sql = 'CALL fetchProductEmergencyContact(
            :p_product_emergency_contact_id
        )';
        
        return $this->fetch($sql, [
            'p_product_emergency_contact_id' => $p_product_emergency_contact_id
        ]);
    }

    public function fetchProductLicense(
        $p_product_license_id
    ): array|null {
        $sql = 'CALL fetchProductLicense(
            :p_product_license_id
        )';
        
        return $this->fetch($sql, [
            'p_product_license_id' => $p_product_license_id
        ]);
    }

    public function fetchProductExperience(
        $p_product_experience_id
    ): array|null {
        $sql = 'CALL fetchProductExperience(
            :p_product_experience_id
        )';
        
        return $this->fetch($sql, [
            'p_product_experience_id' => $p_product_experience_id
        ]);
    }

    public function fetchProductDocument(
        $p_product_document_id
    ): array|null {
        $sql = 'CALL fetchProductDocument(
            :p_product_document_id
        )';
        
        return $this->fetch($sql, [
            'p_product_document_id' => $p_product_document_id
        ]);
    }

    public function fetchAllProductDocument(
        $p_product_id
    ): array|null {
        $sql = 'CALL fetchAllProductDocument(
            :p_product_id
        )';
        
        return $this->fetchAll($sql, [
            'p_product_id' => $p_product_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteProduct(
        $p_product_id
    ) {
        $sql = 'CALL deleteProduct(
            :p_product_id
        )';
        
        return $this->query($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function deleteProductLanguage(
        $p_product_language_id
    ) {
        $sql = 'CALL deleteProductLanguage(
            :p_product_language_id
        )';
        
        return $this->query($sql, [
            'p_product_language_id' => $p_product_language_id
        ]);
    }

    public function deleteProductEducation(
        $p_product_education_id
    ) {
        $sql = 'CALL deleteProductEducation(
            :p_product_education_id
        )';
        
        return $this->query($sql, [
            'p_product_education_id' => $p_product_education_id
        ]);
    }

    public function deleteProductEmergencyContact(
        $p_product_emergency_contact_id
    ) {
        $sql = 'CALL deleteProductEmergencyContact(
            :p_product_emergency_contact_id
        )';
        
        return $this->query($sql, [
            'p_product_emergency_contact_id' => $p_product_emergency_contact_id
        ]);
    }

    public function deleteProductLicense(
        $p_product_license_id
    ) {
        $sql = 'CALL deleteProductLicense(
            :p_product_license_id
        )';
        
        return $this->query($sql, [
            'p_product_license_id' => $p_product_license_id
        ]);
    }

    public function deleteProductExperience(
        $p_product_experience_id
    ) {
        $sql = 'CALL deleteProductExperience(
            :p_product_experience_id
        )';
        
        return $this->query($sql, [
            'p_product_experience_id' => $p_product_experience_id
        ]);
    }

    public function deleteProductDocument(
        $p_product_document_id
    ) {
        $sql = 'CALL deleteProductDocument(
            :p_product_document_id
        )';
        
        return $this->query($sql, [
            'p_product_document_id' => $p_product_document_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkProductExist(
        $p_product_id
    ) {
        $sql = 'CALL checkProductExist(
            :p_product_id
        )';
        
        return $this->fetch($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateProductCard(
        $p_search_value,
        $p_filter_by_company, 
        $p_filter_by_department, 
        $p_filter_by_job_position, 
        $p_filter_by_product_status, 
        $p_filter_by_work_location, 
        $p_filter_by_employment_type, 
        $p_filter_by_gender, 
        $p_limit, 
        $p_offset
    ) {
        $sql = 'CALL generateProductCard(
            :p_search_value,
            :p_filter_by_company,
            :p_filter_by_department,
            :p_filter_by_job_position,
            :p_filter_by_product_status,
            :p_filter_by_work_location,
            :p_filter_by_employment_type,
            :p_filter_by_gender,
            :p_limit,
            :p_offset
        )';

        return $this->fetchAll($sql, [
            'p_search_value'                => $p_search_value,
            'p_filter_by_company'           => $p_filter_by_company,
            'p_filter_by_department'        => $p_filter_by_department,
            'p_filter_by_job_position'      => $p_filter_by_job_position,
            'p_filter_by_product_status'   => $p_filter_by_product_status,
            'p_filter_by_work_location'     => $p_filter_by_work_location,
            'p_filter_by_employment_type'   => $p_filter_by_employment_type,
            'p_filter_by_gender'            => $p_filter_by_gender,
            'p_limit'                       => $p_limit,
            'p_offset'                      => $p_offset
        ]);
    }

    public function generateProductTable(
        $p_filter_by_company, 
        $p_filter_by_department, 
        $p_filter_by_job_position, 
        $p_filter_by_product_status, 
        $p_filter_by_work_location, 
        $p_filter_by_employment_type, 
        $p_filter_by_gender
    ) {
        $sql = 'CALL generateProductTable(
            :p_filter_by_company,
            :p_filter_by_department,
            :p_filter_by_job_position,
            :p_filter_by_product_status,
            :p_filter_by_work_location,
            :p_filter_by_employment_type,
            :p_filter_by_gender
        )';

        return $this->fetchAll($sql, [
            'p_filter_by_company'           => $p_filter_by_company,
            'p_filter_by_department'        => $p_filter_by_department,
            'p_filter_by_job_position'      => $p_filter_by_job_position,
            'p_filter_by_product_status'   => $p_filter_by_product_status,
            'p_filter_by_work_location'     => $p_filter_by_work_location,
            'p_filter_by_employment_type'   => $p_filter_by_employment_type,
            'p_filter_by_gender'            => $p_filter_by_gender
        ]);
    }

    public function generateProductOptions() {
        $sql = 'CALL generateProductOptions()';
        
        return $this->fetchAll($sql);
    }

    public function generateProductLanguageList(
        $p_product_id
    ) {
        $sql = 'CALL generateProductLanguageList(
            :p_product_id
        )';

        return $this->fetchAll($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function generateProductEducationList(
        $p_product_id
    ) {
        $sql = 'CALL generateProductEducationList(
            :p_product_id
        )';

        return $this->fetchAll($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function generateProductEmergencyContactList(
        $p_product_id
    ) {
        $sql = 'CALL generateProductEmergencyContactList(
            :p_product_id
        )';

        return $this->fetchAll($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function generateProductLicenseList(
        $p_product_id
    ) {
        $sql = 'CALL generateProductLicenseList(
            :p_product_id
        )';

        return $this->fetchAll($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function generateProductExperienceList(
        $p_product_id
    ) {
        $sql = 'CALL generateProductExperienceList(
            :p_product_id
        )';

        return $this->fetchAll($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function generateProductDocumentTable(
        $p_product_id
    ) {
        $sql = 'CALL generateProductDocumentTable(
            :p_product_id
        )';

        return $this->fetchAll($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}