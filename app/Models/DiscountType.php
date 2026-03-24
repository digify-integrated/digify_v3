<?php
namespace App\Models;

use App\Core\Model;

class DiscountType extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveDiscountType(
        null|int $p_discount_type_id,
        string $p_discount_type_name,
        string $p_value_type,
        string $p_discount_value,
        string $p_is_variable,
        string $p_affects_tax,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveDiscountType(
            :p_discount_type_id,
            :p_discount_type_name,
            :p_value_type,
            :p_discount_value,
            :p_is_variable,
            :p_affects_tax,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_discount_type_id'    => $p_discount_type_id,
            'p_discount_type_name'  => $p_discount_type_name,
            'p_value_type'          => $p_value_type,
            'p_discount_value'      => $p_discount_value,
            'p_is_variable'         => $p_is_variable,
            'p_affects_tax'         => $p_affects_tax,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_discount_type_id'] ?? null;
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

    public function fetchDiscountType(
        int $p_discount_type_id
    ) {
        $sql = 'CALL fetchDiscountType(
            :p_discount_type_id
        )';
        
        return $this->fetch($sql, [
            'p_discount_type_id' => $p_discount_type_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteDiscountType(
        int $p_discount_type_id
    ) {
        $sql = 'CALL deleteDiscountType(
            :p_discount_type_id
        )';
        
        return $this->query($sql, [
            'p_discount_type_id' => $p_discount_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkDiscountTypeExist(
        int $p_discount_type_id
    ) {
        $sql = 'CALL checkDiscountTypeExist(
            :p_discount_type_id
        )';
        
        return $this->fetch($sql, [
            'p_discount_type_id' => $p_discount_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateDiscountTypeTable() {
        $sql = 'CALL generateDiscountTypeTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateDiscountTypeOptions() {
        $sql = 'CALL generateDiscountTypeOptions()';
        
        return $this->fetchAll($sql);
    }

    public function generateShopDiscountTypeOptions(int $p_shop_id) {
        $sql = 'CALL generateShopDiscountTypeOptions(:p_shop_id)';
        
        return $this->fetchAll($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}