<?php
namespace App\Models;

use App\Core\Model;

class EmploymentType extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveEmploymentType(
        $p_employment_type_id,
        $p_employment_type_name,
        $p_last_log_by
    )    {
        $sql = 'CALL saveEmploymentType(
            :p_employment_type_id,
            :p_employment_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_employment_type_id'      => $p_employment_type_id,
            'p_employment_type_name'    => $p_employment_type_name,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_employment_type_id'] ?? null;
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

    public function fetchEmploymentType(
        $p_employment_type_id
    ) {
        $sql = 'CALL fetchEmploymentType(
            :p_employment_type_id
        )';
        
        return $this->fetch($sql, [
            'p_employment_type_id' => $p_employment_type_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteEmploymentType(
        $p_employment_type_id
    ) {
        $sql = 'CALL deleteEmploymentType(
            :p_employment_type_id
        )';
        
        return $this->query($sql, [
            'p_employment_type_id' => $p_employment_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkEmploymentTypeExist(
        $p_employment_type_id
    ) {
        $sql = 'CALL checkEmploymentTypeExist(
            :p_employment_type_id
        )';
        
        return $this->fetch($sql, [
            'p_employment_type_id' => $p_employment_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateEmploymentTypeTable() {
        $sql = 'CALL generateEmploymentTypeTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateEmploymentTypeOptions() {
        $sql = 'CALL generateEmploymentTypeOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}