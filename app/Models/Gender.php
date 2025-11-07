<?php
namespace App\Models;

use App\Core\Model;

class Gender extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveGender(
        null|int $p_gender_id,
        string $p_gender_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveGender(
            :p_gender_id,
            :p_gender_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_gender_id'       => $p_gender_id,
            'p_gender_name'     => $p_gender_name,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_gender_id'] ?? null;
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

    public function fetchGender(
        int $p_gender_id
    ) {
        $sql = 'CALL fetchGender(
            :p_gender_id
        )';
        
        return $this->fetch($sql, [
            'p_gender_id' => $p_gender_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteGender(
        int $p_gender_id
    ) {
        $sql = 'CALL deleteGender(
            :p_gender_id
        )';
        
        return $this->query($sql, [
            'p_gender_id' => $p_gender_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkGenderExist(
        int $p_gender_id
    ) {
        $sql = 'CALL checkGenderExist(
            :p_gender_id
        )';
        
        return $this->fetch($sql, [
            'p_gender_id' => $p_gender_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateGenderTable() {
        $sql = 'CALL generateGenderTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateGenderOptions() {
        $sql = 'CALL generateGenderOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}