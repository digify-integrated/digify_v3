<?php
namespace App\Models;

use App\Core\Model;

class EmploymentLocationType extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveEmploymentLocationType(
        null|int $p_employment_location_type_id,
        string $p_employment_location_type_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveEmploymentLocationType(
            :p_employment_location_type_id,
            :p_employment_location_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_employment_location_type_id'     => $p_employment_location_type_id,
            'p_employment_location_type_name'   => $p_employment_location_type_name,
            'p_last_log_by'                     => $p_last_log_by
        ]);

        return $row['new_employment_location_type_id'] ?? null;
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

    public function fetchEmploymentLocationType(
        int $p_employment_location_type_id
    ) {
        $sql = 'CALL fetchEmploymentLocationType(
            :p_employment_location_type_id
        )';
        
        return $this->fetch($sql, [
            'p_employment_location_type_id' => $p_employment_location_type_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteEmploymentLocationType(
        int $p_employment_location_type_id
    ) {
        $sql = 'CALL deleteEmploymentLocationType(
            :p_employment_location_type_id
        )';
        
        return $this->query($sql, [
            'p_employment_location_type_id' => $p_employment_location_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkEmploymentLocationTypeExist(
        int $p_employment_location_type_id
    ) {
        $sql = 'CALL checkEmploymentLocationTypeExist(
            :p_employment_location_type_id
        )';
        
        return $this->fetch($sql, [
            'p_employment_location_type_id' => $p_employment_location_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateEmploymentLocationTypeTable() {
        $sql = 'CALL generateEmploymentLocationTypeTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateEmploymentLocationTypeOptions() {
        $sql = 'CALL generateEmploymentLocationTypeOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}