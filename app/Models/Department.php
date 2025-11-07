<?php
namespace App\Models;

use App\Core\Model;

class Department extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveDepartment(
        null|int $p_department_id,
        string $p_department_name,
        null|string|int $p_parent_department_id,
        string $p_parent_department_name,
        null|string|int $p_manager_id,
        string $p_manager_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveDepartment(
            :p_department_id,
            :p_department_name,
            :p_parent_department_id,
            :p_parent_department_name,
            :p_manager_id,
            :p_manager_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_department_id'           => $p_department_id,
            'p_department_name'         => $p_department_name,
            'p_parent_department_id'    => $p_parent_department_id,
            'p_parent_department_name'  => $p_parent_department_name,
            'p_manager_id'              => $p_manager_id,
            'p_manager_name'            => $p_manager_name,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_department_id'] ?? null;
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

    public function fetchDepartment(
        null|string|int $p_department_id
    ) {
        $sql = 'CALL fetchDepartment(
            :p_department_id
        )';
        
        return $this->fetch($sql, [
            'p_department_id' => $p_department_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteDepartment(
        int $p_department_id
    ) {
        $sql = 'CALL deleteDepartment(
            :p_department_id
        )';
        
        return $this->query($sql, [
            'p_department_id' => $p_department_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkDepartmentExist(
        int $p_department_id
    ) {
        $sql = 'CALL checkDepartmentExist(
            :p_department_id
        )';
        
        return $this->fetch($sql, [
            'p_department_id' => $p_department_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateDepartmentTable(
        null|string $p_filter_by_parent_department,
        null|string $p_filter_by_manager
    ) {
        $sql = 'CALL generateDepartmentTable(
            :p_filter_by_parent_department,
            :p_filter_by_manager
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_parent_department'     => $p_filter_by_parent_department,
            'p_filter_by_manager'               => $p_filter_by_manager
        ]);
    }

    public function generateDepartmentOptions() {
        $sql = 'CALL generateDepartmentOptions()';
        
        return $this->fetchAll($sql);
    }

    public function generateParentDepartmentOptions(
        int $p_department_id
    ) {
        $sql = 'CALL generateParentDepartmentOptions(:p_department_id)';
        
        return $this->fetchAll($sql, [
            'p_department_id' => $p_department_id
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}