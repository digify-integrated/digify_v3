<?php
namespace App\Models;

use App\Core\Model;

class Tax extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveTax(
        null|int $p_tax_id,
        string $p_tax_name,
        float $p_tax_rate,
        string $p_tax_type,
        string $p_tax_computation,
        string $p_tax_scope,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveTax(
            :p_tax_id,
            :p_tax_name,
            :p_tax_rate,
            :p_tax_type,
            :p_tax_computation,
            :p_tax_scope,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_tax_id'              => $p_tax_id,
            'p_tax_name'            => $p_tax_name,
            'p_tax_rate'            => $p_tax_rate,
            'p_tax_type'            => $p_tax_type,
            'p_tax_computation'     => $p_tax_computation,
            'p_tax_scope'           => $p_tax_scope,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_tax_id'] ?? null;
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateTaxArchive(
        int $p_tax_id,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateTaxArchive(
            :p_tax_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_tax_id'          => $p_tax_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateTaxUnarchive(
        int $p_tax_id,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateTaxUnarchive(
            :p_tax_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_tax_id'          => $p_tax_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchTax(
        int $p_tax_id
    ) {
        $sql = 'CALL fetchTax(
            :p_tax_id
        )';
        
        return $this->fetch($sql, [
            'p_tax_id' => $p_tax_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteTax(
        int $p_tax_id
    ) {
        $sql = 'CALL deleteTax(
            :p_tax_id
        )';
        
        return $this->query($sql, [
            'p_tax_id' => $p_tax_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkTaxExist(
        int $p_tax_id
    ) {
        $sql = 'CALL checkTaxExist(
            :p_tax_id
        )';
        
        return $this->fetch($sql, [
            'p_tax_id' => $p_tax_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateTaxTable(
        null|string $p_filter_by_tax_type,
        null|string $p_filter_by_tax_computation,
        null|string $p_filter_by_tax_scope,
        null|string $p_filter_by_tax_status
    ) {
        $sql = 'CALL generateTaxTable(
            :p_filter_by_tax_type,
            :p_filter_by_tax_computation,
            :p_filter_by_tax_scope,
            :p_filter_by_tax_status
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_tax_type'          => $p_filter_by_tax_type,
            'p_filter_by_tax_computation'   => $p_filter_by_tax_computation,
            'p_filter_by_tax_scope'         => $p_filter_by_tax_scope,
            'p_filter_by_tax_status'        => $p_filter_by_tax_status
        ]);
    }

    public function generateTaxOptions() {
        $sql = 'CALL generateTaxOptions()';
        
        return $this->fetchAll($sql);
    }

    public function generateSalesTaxOptions() {
        $sql = 'CALL generateSalesTaxOptions()';
        
        return $this->fetchAll($sql);
    }

    public function generatePurchaseTaxOptions() {
        $sql = 'CALL generatePurchaseTaxOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}