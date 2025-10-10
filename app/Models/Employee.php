<?php
namespace App\Models;

use App\Core\Model;

class Employee extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveEmployeeLanguage(
        $p_employee_id,
        $p_language_id,
        $p_language_name,
        $p_language_proficiency_id,
        $p_language_proficiency_name,
        $p_last_log_by
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
        $p_employee_education_id,
        $p_employee_id,
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
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    public function insertEmployee(
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

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateEmployeePersonalDetails(
        $p_employee_id,
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
        $p_employee_id,
        $p_pin_code,
        $p_last_log_by
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
        $p_employee_id,
        $p_badge_id,
        $p_last_log_by
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
        $p_employee_id,
        $p_private_email,
        $p_last_log_by
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
        $p_employee_id,
        $p_private_phone,
        $p_last_log_by
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
        $p_employee_id,
        $p_private_telephone,
        $p_last_log_by
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
        $p_employee_id,
        $p_nationality_id,
        $p_nationality_name,
        $p_last_log_by
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
        $p_employee_id,
        $p_gender_id,
        $p_gender_name,
        $p_last_log_by
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
        $p_employee_id,
        $p_birthday,
        $p_last_log_by
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
        $p_employee_id,
        $p_place_of_birth,
        $p_last_log_by
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
        $p_employee_id,
        $p_company_id,
        $p_company_name,
        $p_last_log_by
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
        $p_employee_id,
        $p_department_id,
        $p_department_name,
        $p_last_log_by
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
        $p_employee_id,
        $p_job_position_id,
        $p_job_position_name,
        $p_last_log_by
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
        $p_employee_id,
        $p_manager_id,
        $p_manager_name,
        $p_last_log_by
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
        $p_employee_id,
        $p_time_off_approver_id,
        $p_time_off_approver_name,
        $p_last_log_by
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
        $p_employee_id,
        $p_employment_type_id,
        $p_employment_type_name,
        $p_last_log_by
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
        $p_employee_id,
        $p_employment_location_type_id,
        $p_employment_location_type_name,
        $p_last_log_by
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
        $p_employee_id,
        $p_work_location_id,
        $p_work_location_name,
        $p_last_log_by
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
        $p_employee_id,
        $p_on_board_date,
        $p_last_log_by
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
        $p_employee_id,
        $p_work_email,
        $p_last_log_by
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
        $p_employee_id,
        $p_work_phone,
        $p_last_log_by
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
        $p_employee_id,
        $p_work_telephone,
        $p_last_log_by
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
        $p_employee_id,
        $p_employee_image,
        $p_last_log_by
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

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchEmployee(
        $p_employee_id
    ) {
        $sql = 'CALL fetchEmployee(
            :p_employee_id
        )';
        
        return $this->fetch($sql, [
            'p_employee_id' => $p_employee_id
        ]);
    }

    public function fetchEmployeeEducation(
        $p_employee_educatuib_id
    ): array|null {
        $sql = 'CALL fetchEmployeeEducation(
            :p_employee_educatuib_id
        )';
        
        return $this->fetch($sql, [
            'p_employee_educatuib_id' => $p_employee_educatuib_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteEmployee(
        $p_employee_id
    ) {
        $sql = 'CALL deleteEmployee(
            :p_employee_id
        )';
        
        return $this->query($sql, [
            'p_employee_id' => $p_employee_id
        ]);
    }

    public function deleteEmployeeLanguage(
        $p_employee_language_id
    ) {
        $sql = 'CALL deleteEmployeeLanguage(
            :p_employee_language_id
        )';
        
        return $this->query($sql, [
            'p_employee_language_id' => $p_employee_language_id
        ]);
    }

    public function deleteEmployeeEducation(
        $p_employee_education_id
    ) {
        $sql = 'CALL deleteEmployeeEducation(
            :p_employee_education_id
        )';
        
        return $this->query($sql, [
            'p_employee_education_id' => $p_employee_education_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkEmployeeExist(
        $p_employee_id
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
        $p_search_value,
        $p_filter_by_company, 
        $p_filter_by_department, 
        $p_filter_by_job_position, 
        $p_filter_by_employee_status, 
        $p_filter_by_work_location, 
        $p_filter_by_employment_type, 
        $p_filter_by_gender, 
        $p_limit, 
        $p_offset
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
            'p_search_value' => $p_search_value,
            'p_filter_by_company' => $p_filter_by_company,
            'p_filter_by_department' => $p_filter_by_department,
            'p_filter_by_job_position' => $p_filter_by_job_position,
            'p_filter_by_employee_status' => $p_filter_by_employee_status,
            'p_filter_by_work_location' => $p_filter_by_work_location,
            'p_filter_by_employment_type' => $p_filter_by_employment_type,
            'p_filter_by_gender' => $p_filter_by_gender,
            'p_limit' => $p_limit,
            'p_offset' => $p_offset
        ]);
    }

    public function generateEmployeeTable(
        $p_filter_by_company, 
        $p_filter_by_department, 
        $p_filter_by_job_position, 
        $p_filter_by_employee_status, 
        $p_filter_by_work_location, 
        $p_filter_by_employment_type, 
        $p_filter_by_gender
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
            'p_filter_by_company' => $p_filter_by_company,
            'p_filter_by_department' => $p_filter_by_department,
            'p_filter_by_job_position' => $p_filter_by_job_position,
            'p_filter_by_employee_status' => $p_filter_by_employee_status,
            'p_filter_by_work_location' => $p_filter_by_work_location,
            'p_filter_by_employment_type' => $p_filter_by_employment_type,
            'p_filter_by_gender' => $p_filter_by_gender
        ]);
    }

    public function generateEmployeeOptions() {
        $sql = 'CALL generateEmployeeOptions()';
        
        return $this->fetchAll($sql);
    }

    public function generateEmployeeLanguageList(
        $p_employee_id
    ) {
        $sql = 'CALL generateEmployeeLanguageList(
            :p_employee_id
        )';

        return $this->fetchAll($sql, [
            'p_employee_id' => $p_employee_id
        ]);
    }

    public function generateEmployeeEducationList(
        $p_employee_id
    ) {
        $sql = 'CALL generateEmployeeEducationList(
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