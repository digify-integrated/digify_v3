<?php
namespace App\Models;

use App\Core\Model;

class Employee extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveEmployeeLanguage(
        null|string|int $p_employee_id,
        int $p_language_id,
        string $p_language_name,
        int $p_language_proficiency_id,
        string $p_language_proficiency_name,
        int $p_last_log_by
    ) {
        $sql = 'CALL saveEmployeeLanguage(
            :p_employee_id,
            :p_language_id,
            :p_language_name,
            :p_language_proficiency_id,
            :p_language_proficiency_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'                 => $p_employee_id,
            'p_language_id'                 => $p_language_id,
            'p_language_name'               => $p_language_name,
            'p_language_proficiency_id'     => $p_language_proficiency_id,
            'p_language_proficiency_name'   => $p_language_proficiency_name,
            'p_last_log_by'                 => $p_last_log_by
        ]);
    }

    public function saveEmployeeEducation(
        null|string|int $p_employee_education_id,
        int $p_employee_id,
        string $p_school,
        string $p_degree,
        string $p_field_of_study,
        string $p_start_month,
        string $p_start_year,
        string $p_end_month,
        string $p_end_year,
        string $p_activities_societies,
        string $p_education_description,
        int $p_last_log_by
    ) {
        $sql = 'CALL saveEmployeeEducation(
            :p_employee_education_id,
            :p_employee_id,
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
            'p_employee_education_id'   => $p_employee_education_id,
            'p_employee_id'             => $p_employee_id,
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

    public function saveEmployeeEmergencyContact(
        null|string|int $p_employee_emergency_contact_id,
        int $p_employee_id,
        string $p_emergency_contact_name,
        int $p_relationship_id,
        string $p_relationship_name,
        string $p_telephone,
        string $p_mobile,
        string $p_email,
        int $p_last_log_by
    ) {
        $sql = 'CALL saveEmployeeEmergencyContact(
            :p_employee_emergency_contact_id,
            :p_employee_id,
            :p_emergency_contact_name,
            :p_relationship_id,
            :p_relationship_name,
            :p_telephone,
            :p_mobile,
            :p_email,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_emergency_contact_id'   => $p_employee_emergency_contact_id,
            'p_employee_id'                     => $p_employee_id,
            'p_emergency_contact_name'          => $p_emergency_contact_name,
            'p_relationship_id'                 => $p_relationship_id,
            'p_relationship_name'               => $p_relationship_name,
            'p_telephone'                       => $p_telephone,
            'p_mobile'                          => $p_mobile,
            'p_email'                           => $p_email,
            'p_last_log_by'                     => $p_last_log_by
        ]);
    }

    public function saveEmployeeLicense(
        null|string|int $p_employee_license_id,
        int $p_employee_id,
        string $p_licensed_profession,
        string $p_licensing_body,
        string $p_license_number,
        string $p_issue_date,
        null|string $p_expiration_date,
        int $p_last_log_by
    ) {
        $sql = 'CALL saveEmployeeLicense(
            :p_employee_license_id,
            :p_employee_id,
            :p_licensed_profession,
            :p_licensing_body,
            :p_license_number,
            :p_issue_date,
            :p_expiration_date,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_license_id'     => $p_employee_license_id,
            'p_employee_id'             => $p_employee_id,
            'p_licensed_profession'     => $p_licensed_profession,
            'p_licensing_body'          => $p_licensing_body,
            'p_license_number'          => $p_license_number,
            'p_issue_date'              => $p_issue_date,
            'p_expiration_date'         => $p_expiration_date,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    public function saveEmployeeExperience(
        null|string|int $p_employee_experience_id,
        int $p_employee_id,
        string $p_job_title,
        int $p_employment_type_id,
        string $p_employment_type_name,
        string $p_company_name,
        string $p_location,
        string $p_start_month,
        string $p_start_year,
        string $p_end_month,
        string $p_end_year,
        string $p_job_description,
        int $p_last_log_by
    ) {
        $sql = 'CALL saveEmployeeExperience(
            :p_employee_experience_id,
            :p_employee_id,
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
            'p_employee_experience_id'  => $p_employee_experience_id,
            'p_employee_id'             => $p_employee_id,
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

    public function insertEmployee(
        string $p_full_name,
        string $p_first_name,
        string $p_middle_name,
        string $p_last_name,
        string $p_suffix,
        int $p_company_id,
        string $p_company_name,
        int $p_department_id,
        string $p_department_name,
        int $p_job_position_id,
        string $p_job_position_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertEmployee(
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

        return $row['new_employee_id'] ?? null;
    }
    public function insertEmployeeDocument(
        int $p_employee_id,
        string $p_document_name,
        string $p_document_file,
        int $p_employee_document_type_id,
        string $p_employee_document_type_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertEmployeeDocument(
            :p_employee_id,
            :p_document_name,
            :p_document_file,
            :p_employee_document_type_id,
            :p_employee_document_type_name,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_employee_id'                     => $p_employee_id,
            'p_document_name'                   => $p_document_name,
            'p_document_file'                   => $p_document_file,
            'p_employee_document_type_id'       => $p_employee_document_type_id,
            'p_employee_document_type_name'     => $p_employee_document_type_name,
            'p_last_log_by'                     => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateEmployeePersonalDetails(
        int $p_employee_id,
        string $p_full_name,
        string $p_first_name,
        string $p_middle_name,
        string $p_last_name,
        string $p_suffix,
        string $p_nickname,
        string $p_private_address,
        int $p_private_address_city_id,
        string $p_private_address_city_name,
        int $p_private_address_state_id,
        string $p_private_address_state_name,
        int $p_private_address_country_id,
        string $p_private_address_country_name,
        int $p_civil_status_id,
        string $p_civil_status_name,
        int $p_dependents,
        null|string|int $p_religion_id,
        string $p_religion_name,
        null|string|int $p_blood_type_id,
        string $p_blood_type_name,
        string|float $p_home_work_distance,
        string|float $p_height,
        string|float $p_weight,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeePersonalDetails(
            :p_employee_id,
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
            'p_employee_id'                     => $p_employee_id,
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

    public function updateEmployeePINCode(
        int $p_employee_id,
        string $p_pin_code,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeePINCode(
            :p_employee_id,
            :p_pin_code,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'     => $p_employee_id,
            'p_pin_code'        => $p_pin_code,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateEmployeeBadgeId(
        int $p_employee_id,
        string $p_badge_id,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeBadgeId(
            :p_employee_id,
            :p_badge_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'     => $p_employee_id,
            'p_badge_id'        => $p_badge_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateEmployeePrivateEmail(
        int $p_employee_id,
        string $p_private_email,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeePrivateEmail(
            :p_employee_id,
            :p_private_email,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'     => $p_employee_id,
            'p_private_email'   => $p_private_email,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateEmployeePrivatePhone(
        int $p_employee_id,
        string $p_private_phone,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeePrivatePhone(
            :p_employee_id,
            :p_private_phone,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'     => $p_employee_id,
            'p_private_phone'   => $p_private_phone,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateEmployeePrivateTelephone(
        int $p_employee_id,
        string $p_private_telephone,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeePrivateTelephone(
            :p_employee_id,
            :p_private_telephone,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'         => $p_employee_id,
            'p_private_telephone'   => $p_private_telephone,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateEmployeeNationality(
        int $p_employee_id,
        int $p_nationality_id,
        string $p_nationality_name,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeNationality(
            :p_employee_id,
            :p_nationality_id,
            :p_nationality_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'         => $p_employee_id,
            'p_nationality_id'      => $p_nationality_id,
            'p_nationality_name'    => $p_nationality_name,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateEmployeeGender(
        int $p_employee_id,
        int $p_gender_id,
        string $p_gender_name,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeGender(
            :p_employee_id,
            :p_gender_id,
            :p_gender_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'     => $p_employee_id,
            'p_gender_id'       => $p_gender_id,
            'p_gender_name'     => $p_gender_name,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateEmployeeBirthday(
        int $p_employee_id,
        string $p_birthday,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeBirthday(
            :p_employee_id,
            :p_birthday,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'     => $p_employee_id,
            'p_birthday'        => $p_birthday,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateEmployeePlaceOfBirth(
        int $p_employee_id,
        string $p_place_of_birth,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeePlaceOfBirth(
            :p_employee_id,
            :p_place_of_birth,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'     => $p_employee_id,
            'p_place_of_birth'  => $p_place_of_birth,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateEmployeeCompany(
        int $p_employee_id,
        int $p_company_id,
        string $p_company_name,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeCompany(
            :p_employee_id,
            :p_company_id,
            :p_company_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'     => $p_employee_id,
            'p_company_id'      => $p_company_id,
            'p_company_name'    => $p_company_name,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateEmployeeDepartment(
        int $p_employee_id,
        int $p_department_id,
        string $p_department_name,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeDepartment(
            :p_employee_id,
            :p_department_id,
            :p_department_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'         => $p_employee_id,
            'p_department_id'       => $p_department_id,
            'p_department_name'     => $p_department_name,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateEmployeeJobPosition(
        int $p_employee_id,
        int $p_job_position_id,
        string $p_job_position_name,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeJobPosition(
            :p_employee_id,
            :p_job_position_id,
            :p_job_position_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'         => $p_employee_id,
            'p_job_position_id'     => $p_job_position_id,
            'p_job_position_name'   => $p_job_position_name,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateEmployeeManager(
        int $p_employee_id,
        int $p_manager_id,
        string $p_manager_name,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeManager(
            :p_employee_id,
            :p_manager_id,
            :p_manager_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'     => $p_employee_id,
            'p_manager_id'      => $p_manager_id,
            'p_manager_name'    => $p_manager_name,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateEmployeeTimeOffApprover(
        int $p_employee_id,
        int $p_time_off_approver_id,
        string $p_time_off_approver_name,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeTimeOffApprover(
            :p_employee_id,
            :p_time_off_approver_id,
            :p_time_off_approver_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'             => $p_employee_id,
            'p_time_off_approver_id'    => $p_time_off_approver_id,
            'p_time_off_approver_name'  => $p_time_off_approver_name,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    public function updateEmployeeEmploymentType(
        int $p_employee_id,
        int $p_employment_type_id,
        string $p_employment_type_name,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeEmploymentType(
            :p_employee_id,
            :p_employment_type_id,
            :p_employment_type_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'             => $p_employee_id,
            'p_employment_type_id'      => $p_employment_type_id,
            'p_employment_type_name'    => $p_employment_type_name,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    public function updateEmployeeEmploymentLocationType(
        int $p_employee_id,
        int $p_employment_location_type_id,
        string $p_employment_location_type_name,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeEmploymentLocationType(
            :p_employee_id,
            :p_employment_location_type_id,
            :p_employment_location_type_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'                     => $p_employee_id,
            'p_employment_location_type_id'     => $p_employment_location_type_id,
            'p_employment_location_type_name'   => $p_employment_location_type_name,
            'p_last_log_by'                     => $p_last_log_by
        ]);
    }

    public function updateEmployeeWorkLocation(
        int $p_employee_id,
        int $p_work_location_id,
        string $p_work_location_name,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeWorkLocation(
            :p_employee_id,
            :p_work_location_id,
            :p_work_location_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'         => $p_employee_id,
            'p_work_location_id'    => $p_work_location_id,
            'p_work_location_name'  => $p_work_location_name,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateEmployeeOnBoardDate(
        int $p_employee_id,
        string $p_on_board_date,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeOnBoardDate(
            :p_employee_id,
            :p_on_board_date,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'     => $p_employee_id,
            'p_on_board_date'   => $p_on_board_date,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateEmployeeWorkEmail(
        int $p_employee_id,
        string $p_work_email,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeWorkEmail(
            :p_employee_id,
            :p_work_email,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'     => $p_employee_id,
            'p_work_email'      => $p_work_email,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateEmployeeWorkPhone(
        int $p_employee_id,
        string $p_work_phone,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeWorkPhone(
            :p_employee_id,
            :p_work_phone,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'     => $p_employee_id,
            'p_work_phone'      => $p_work_phone,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateEmployeeWorkTelephone(
        int $p_employee_id,
        string $p_work_telephone,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeWorkTelephone(
            :p_employee_id,
            :p_work_telephone,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'     => $p_employee_id,
            'p_work_telephone'  => $p_work_telephone,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateEmployeeImage(
        int $p_employee_id,
        string $p_employee_image,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeImage(
            :p_employee_id,
            :p_employee_image,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'     => $p_employee_id,
            'p_employee_image'  => $p_employee_image,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateEmployeeArchive(
        int $p_employee_id,
        int $p_departure_reason_id,
        string $p_departure_reason_name,
        string $p_detailed_departure_reason,
        string $p_departure_date,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeArchive(
            :p_employee_id,
            :p_departure_reason_id,
            :p_departure_reason_name,
            :p_detailed_departure_reason,
            :p_departure_date,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'                 => $p_employee_id,
            'p_departure_reason_id'         => $p_departure_reason_id,
            'p_departure_reason_name'       => $p_departure_reason_name,
            'p_detailed_departure_reason'   => $p_detailed_departure_reason,
            'p_departure_date'              => $p_departure_date,
            'p_last_log_by'                 => $p_last_log_by
        ]);
    }

    public function updateEmployeeUnarchive(
        int $p_employee_id,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateEmployeeUnarchive(
            :p_employee_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_employee_id'     => $p_employee_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchEmployee(
        null|string|int $p_employee_id
    ) {
        $sql = 'CALL fetchEmployee(
            :p_employee_id
        )';
        
        return $this->fetch($sql, [
            'p_employee_id' => $p_employee_id
        ]);
    }

    public function fetchEmployeeEducation(
        int $p_employee_education_id
    ): array|null {
        $sql = 'CALL fetchEmployeeEducation(
            :p_employee_education_id
        )';
        
        return $this->fetch($sql, [
            'p_employee_education_id' => $p_employee_education_id
        ]);
    }

    public function fetchEmployeeEmergencyContact(
        int $p_employee_emergency_contact_id
    ): array|null {
        $sql = 'CALL fetchEmployeeEmergencyContact(
            :p_employee_emergency_contact_id
        )';
        
        return $this->fetch($sql, [
            'p_employee_emergency_contact_id' => $p_employee_emergency_contact_id
        ]);
    }

    public function fetchEmployeeLicense(
        int $p_employee_license_id
    ): array|null {
        $sql = 'CALL fetchEmployeeLicense(
            :p_employee_license_id
        )';
        
        return $this->fetch($sql, [
            'p_employee_license_id' => $p_employee_license_id
        ]);
    }

    public function fetchEmployeeExperience(
        int $p_employee_experience_id
    ): array|null {
        $sql = 'CALL fetchEmployeeExperience(
            :p_employee_experience_id
        )';
        
        return $this->fetch($sql, [
            'p_employee_experience_id' => $p_employee_experience_id
        ]);
    }

    public function fetchEmployeeDocument(
        int $p_employee_document_id
    ): array|null {
        $sql = 'CALL fetchEmployeeDocument(
            :p_employee_document_id
        )';
        
        return $this->fetch($sql, [
            'p_employee_document_id' => $p_employee_document_id
        ]);
    }

    public function fetchAllEmployeeDocument(
        int $p_employee_id
    ): array|null {
        $sql = 'CALL fetchAllEmployeeDocument(
            :p_employee_id
        )';
        
        return $this->fetchAll($sql, [
            'p_employee_id' => $p_employee_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteEmployee(
        int $p_employee_id
    ) {
        $sql = 'CALL deleteEmployee(
            :p_employee_id
        )';
        
        return $this->query($sql, [
            'p_employee_id' => $p_employee_id
        ]);
    }

    public function deleteEmployeeLanguage(
        int $p_employee_language_id
    ) {
        $sql = 'CALL deleteEmployeeLanguage(
            :p_employee_language_id
        )';
        
        return $this->query($sql, [
            'p_employee_language_id' => $p_employee_language_id
        ]);
    }

    public function deleteEmployeeEducation(
        int $p_employee_education_id
    ) {
        $sql = 'CALL deleteEmployeeEducation(
            :p_employee_education_id
        )';
        
        return $this->query($sql, [
            'p_employee_education_id' => $p_employee_education_id
        ]);
    }

    public function deleteEmployeeEmergencyContact(
        int $p_employee_emergency_contact_id
    ) {
        $sql = 'CALL deleteEmployeeEmergencyContact(
            :p_employee_emergency_contact_id
        )';
        
        return $this->query($sql, [
            'p_employee_emergency_contact_id' => $p_employee_emergency_contact_id
        ]);
    }

    public function deleteEmployeeLicense(
        int $p_employee_license_id
    ) {
        $sql = 'CALL deleteEmployeeLicense(
            :p_employee_license_id
        )';
        
        return $this->query($sql, [
            'p_employee_license_id' => $p_employee_license_id
        ]);
    }

    public function deleteEmployeeExperience(
        int $p_employee_experience_id
    ) {
        $sql = 'CALL deleteEmployeeExperience(
            :p_employee_experience_id
        )';
        
        return $this->query($sql, [
            'p_employee_experience_id' => $p_employee_experience_id
        ]);
    }

    public function deleteEmployeeDocument(
        int $p_employee_document_id
    ) {
        $sql = 'CALL deleteEmployeeDocument(
            :p_employee_document_id
        )';
        
        return $this->query($sql, [
            'p_employee_document_id' => $p_employee_document_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkEmployeeExist(
        int $p_employee_id
    ) {
        $sql = 'CALL checkEmployeeExist(
            :p_employee_id
        )';
        
        return $this->fetch($sql, [
            'p_employee_id' => $p_employee_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateEmployeeCard(
        null|string $p_search_value,
        null|string $p_filter_by_company, 
        null|string $p_filter_by_department, 
        null|string $p_filter_by_job_position, 
        null|string $p_filter_by_employee_status, 
        null|string $p_filter_by_work_location, 
        null|string $p_filter_by_employment_type, 
        null|string $p_filter_by_gender, 
        int $p_limit, 
        int $p_offset
    ) {
        $sql = 'CALL generateEmployeeCard(
            :p_search_value,
            :p_filter_by_company,
            :p_filter_by_department,
            :p_filter_by_job_position,
            :p_filter_by_employee_status,
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
            'p_filter_by_employee_status'   => $p_filter_by_employee_status,
            'p_filter_by_work_location'     => $p_filter_by_work_location,
            'p_filter_by_employment_type'   => $p_filter_by_employment_type,
            'p_filter_by_gender'            => $p_filter_by_gender,
            'p_limit'                       => $p_limit,
            'p_offset'                      => $p_offset
        ]);
    }

    public function generateEmployeeTable(
        null|string $p_filter_by_company, 
        null|string $p_filter_by_department, 
        null|string $p_filter_by_job_position, 
        null|string $p_filter_by_employee_status, 
        null|string $p_filter_by_work_location, 
        null|string $p_filter_by_employment_type, 
        null|string $p_filter_by_gender
    ) {
        $sql = 'CALL generateEmployeeTable(
            :p_filter_by_company,
            :p_filter_by_department,
            :p_filter_by_job_position,
            :p_filter_by_employee_status,
            :p_filter_by_work_location,
            :p_filter_by_employment_type,
            :p_filter_by_gender
        )';

        return $this->fetchAll($sql, [
            'p_filter_by_company'           => $p_filter_by_company,
            'p_filter_by_department'        => $p_filter_by_department,
            'p_filter_by_job_position'      => $p_filter_by_job_position,
            'p_filter_by_employee_status'   => $p_filter_by_employee_status,
            'p_filter_by_work_location'     => $p_filter_by_work_location,
            'p_filter_by_employment_type'   => $p_filter_by_employment_type,
            'p_filter_by_gender'            => $p_filter_by_gender
        ]);
    }

    public function generateEmployeeOptions() {
        $sql = 'CALL generateEmployeeOptions()';
        
        return $this->fetchAll($sql);
    }

    public function generateEmployeeLanguageList(
        int $p_employee_id
    ) {
        $sql = 'CALL generateEmployeeLanguageList(
            :p_employee_id
        )';

        return $this->fetchAll($sql, [
            'p_employee_id' => $p_employee_id
        ]);
    }

    public function generateEmployeeEducationList(
        int $p_employee_id
    ) {
        $sql = 'CALL generateEmployeeEducationList(
            :p_employee_id
        )';

        return $this->fetchAll($sql, [
            'p_employee_id' => $p_employee_id
        ]);
    }

    public function generateEmployeeEmergencyContactList(
        int $p_employee_id
    ) {
        $sql = 'CALL generateEmployeeEmergencyContactList(
            :p_employee_id
        )';

        return $this->fetchAll($sql, [
            'p_employee_id' => $p_employee_id
        ]);
    }

    public function generateEmployeeLicenseList(
        int $p_employee_id
    ) {
        $sql = 'CALL generateEmployeeLicenseList(
            :p_employee_id
        )';

        return $this->fetchAll($sql, [
            'p_employee_id' => $p_employee_id
        ]);
    }

    public function generateEmployeeExperienceList(
        int $p_employee_id
    ) {
        $sql = 'CALL generateEmployeeExperienceList(
            :p_employee_id
        )';

        return $this->fetchAll($sql, [
            'p_employee_id' => $p_employee_id
        ]);
    }

    public function generateEmployeeDocumentTable(
        int $p_employee_id
    ) {
        $sql = 'CALL generateEmployeeDocumentTable(
            :p_employee_id
        )';

        return $this->fetchAll($sql, [
            'p_employee_id' => $p_employee_id
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}