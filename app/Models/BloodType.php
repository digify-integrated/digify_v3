<?php
namespace App\Models;

use App\Core\Model;

class BloodType extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveBloodType(
        null|int $p_blood_type_id,
        string $p_blood_type_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveBloodType(
            :p_blood_type_id,
            :p_blood_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_blood_type_id'       => $p_blood_type_id,
            'p_blood_type_name'     => $p_blood_type_name,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_blood_type_id'] ?? null;
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

    public function fetchBloodType(
        null|string|int $p_blood_type_id
    ) {
        $sql = 'CALL fetchBloodType(
            :p_blood_type_id
        )';
        
        return $this->fetch($sql, [
            'p_blood_type_id' => $p_blood_type_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteBloodType(
        int $p_blood_type_id
    ) {
        $sql = 'CALL deleteBloodType(
            :p_blood_type_id
        )';
        
        return $this->query($sql, [
            'p_blood_type_id' => $p_blood_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkBloodTypeExist(
        int $p_blood_type_id
    ) {
        $sql = 'CALL checkBloodTypeExist(
            :p_blood_type_id
        )';
        
        return $this->fetch($sql, [
            'p_blood_type_id' => $p_blood_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateBloodTypeTable() {
        $sql = 'CALL generateBloodTypeTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateBloodTypeOptions() {
        $sql = 'CALL generateBloodTypeOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}