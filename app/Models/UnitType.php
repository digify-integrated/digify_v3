<?php
namespace App\Models;

use App\Core\Model;

class UnitType extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveUnitType(
        null|int $p_unit_type_id,
        string $p_unit_type_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveUnitType(
            :p_unit_type_id,
            :p_unit_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_unit_type_id'     => $p_unit_type_id,
            'p_unit_type_name'   => $p_unit_type_name,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_unit_type_id'] ?? null;
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

    public function fetchUnitType(
        int $p_unit_type_id
    ) {
        $sql = 'CALL fetchUnitType(
            :p_unit_type_id
        )';
        
        return $this->fetch($sql, [
            'p_unit_type_id' => $p_unit_type_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteUnitType(
        int $p_unit_type_id
    ) {
        $sql = 'CALL deleteUnitType(
            :p_unit_type_id
        )';
        
        return $this->query($sql, [
            'p_unit_type_id' => $p_unit_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkUnitTypeExist(
        int $p_unit_type_id
    ) {
        $sql = 'CALL checkUnitTypeExist(
            :p_unit_type_id
        )';
        
        return $this->fetch($sql, [
            'p_unit_type_id' => $p_unit_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateUnitTypeTable() {
        $sql = 'CALL generateUnitTypeTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateUnitTypeOptions() {
        $sql = 'CALL generateUnitTypeOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}