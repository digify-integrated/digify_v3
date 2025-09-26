<?php
namespace App\Models;

use App\Core\Model;

class Employee extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function insertEmployee(
        $p_full_name,
        $p_first_name,
        $p_middle_name,
        $p_last_name,
        $p_suffix,
        $p_last_log_by
    )    {
        $sql = 'CALL insertEmployee(
            :p_full_name,
            :p_first_name,
            :p_middle_name,
            :p_last_name,
            :p_suffix,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_full_name'       => $p_full_name,
            'p_first_name'      => $p_first_name,
            'p_middle_name'     => $p_middle_name,
            'p_last_name'       => $p_last_name,
            'p_suffix'          => $p_suffix,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_employee_id'] ?? null;
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

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
        $sql = 'CALL generateEmployeeCard(
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

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}