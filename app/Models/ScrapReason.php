<?php
namespace App\Models;

use App\Core\Model;

class ScrapReason extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveScrapReason(
        null|int $p_scrap_reason_id,
        string $p_scrap_reason_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveScrapReason(
            :p_scrap_reason_id,
            :p_scrap_reason_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_scrap_reason_id'     => $p_scrap_reason_id,
            'p_scrap_reason_name'   => $p_scrap_reason_name,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_scrap_reason_id'] ?? null;
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

    public function fetchScrapReason(
        int $p_scrap_reason_id
    ) {
        $sql = 'CALL fetchScrapReason(
            :p_scrap_reason_id
        )';
        
        return $this->fetch($sql, [
            'p_scrap_reason_id' => $p_scrap_reason_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteScrapReason(
        int $p_scrap_reason_id
    ) {
        $sql = 'CALL deleteScrapReason(
            :p_scrap_reason_id
        )';
        
        return $this->query($sql, [
            'p_scrap_reason_id' => $p_scrap_reason_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkScrapReasonExist(
        int $p_scrap_reason_id
    ) {
        $sql = 'CALL checkScrapReasonExist(
            :p_scrap_reason_id
        )';
        
        return $this->fetch($sql, [
            'p_scrap_reason_id' => $p_scrap_reason_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateScrapReasonTable() {
        $sql = 'CALL generateScrapReasonTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateScrapReasonOptions() {
        $sql = 'CALL generateScrapReasonOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}