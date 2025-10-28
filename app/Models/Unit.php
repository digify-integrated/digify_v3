<?php
namespace App\Models;

use App\Core\Model;

class Unit extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveUnit(
        $p_unit_id,
        $p_unit_name,
        $p_unit_abbreviation,
        $p_unit_type_id,
        $p_unit_type_name,
        $p_ratio_to_base,
        $p_last_log_by
    )    {
        $sql = 'CALL saveUnit(
            :p_unit_id,
            :p_unit_name,
            :p_unit_abbreviation,
            :p_unit_type_id,
            :p_unit_type_name,
            :p_ratio_to_base,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_unit_id'             => $p_unit_id,
            'p_unit_name'           => $p_unit_name,
            'p_unit_abbreviation'   => $p_unit_abbreviation,
            'p_unit_type_id'        => $p_unit_type_id,
            'p_unit_type_name'      => $p_unit_type_name,
            'p_ratio_to_base'       => $p_ratio_to_base,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_unit_id'] ?? null;
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

    public function fetchUnit(
        $p_unit_id
    ) {
        $sql = 'CALL fetchUnit(
            :p_unit_id
        )';
        
        return $this->fetch($sql, [
            'p_unit_id' => $p_unit_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteUnit(
        $p_unit_id
    ) {
        $sql = 'CALL deleteUnit(
            :p_unit_id
        )';
        
        return $this->query($sql, [
            'p_unit_id' => $p_unit_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkUnitExist(
        $p_unit_id
    ) {
        $sql = 'CALL checkUnitExist(
            :p_unit_id
        )';
        
        return $this->fetch($sql, [
            'p_unit_id' => $p_unit_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateUnitTable(
        $p_filter_by_unit_type
    ) {
        $sql = 'CALL generateUnitTable(
            :p_filter_by_unit_type
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_unit_type' => $p_filter_by_unit_type
        ]);
    }

    public function generateUnitOptions() {
        $sql = 'CALL generateUnitOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}