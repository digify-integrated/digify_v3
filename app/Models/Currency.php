<?php
namespace App\Models;

use App\Core\Model;

class Currency extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveCurrency(
        int $p_currency_id,
        string $p_currency_name,
        string $p_symbol,
        string $p_shorthand,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveCurrency(
            :p_currency_id,
            :p_currency_name,
            :p_symbol,
            :p_shorthand,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_currency_id'     => $p_currency_id,
            'p_currency_name'   => $p_currency_name,
            'p_symbol'          => $p_symbol,
            'p_shorthand'       => $p_shorthand,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_currency_id'] ?? null;
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

    public function fetchCurrency(
        int $p_currency_id
    ) {
        $sql = 'CALL fetchCurrency(
            :p_currency_id
        )';
        
        return $this->fetch($sql, [
            'p_currency_id' => $p_currency_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteCurrency(
        int $p_currency_id
    ) {
        $sql = 'CALL deleteCurrency(
            :p_currency_id
        )';
        
        return $this->query($sql, [
            'p_currency_id' => $p_currency_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkCurrencyExist(
        int $p_currency_id
    ) {
        $sql = 'CALL checkCurrencyExist(
            :p_currency_id
        )';
        
        return $this->fetch($sql, [
            'p_currency_id' => $p_currency_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateCurrencyTable() {
        $sql = 'CALL generateCurrencyTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateCurrencyOptions() {
        $sql = 'CALL generateCurrencyOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}