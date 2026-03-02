<?php
namespace App\Models;

use App\Core\Model;

class PaymentMethod extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function savePaymentMethod(
        null|int $p_payment_method_id,
        string $p_payment_method_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL savePaymentMethod(
            :p_payment_method_id,
            :p_payment_method_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_payment_method_id'   => $p_payment_method_id,
            'p_payment_method_name' => $p_payment_method_name,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_payment_method_id'] ?? null;
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

    public function fetchPaymentMethod(
        int $p_payment_method_id
    ) {
        $sql = 'CALL fetchPaymentMethod(
            :p_payment_method_id
        )';
        
        return $this->fetch($sql, [
            'p_payment_method_id' => $p_payment_method_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deletePaymentMethod(
        int $p_payment_method_id
    ) {
        $sql = 'CALL deletePaymentMethod(
            :p_payment_method_id
        )';
        
        return $this->query($sql, [
            'p_payment_method_id' => $p_payment_method_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkPaymentMethodExist(
        int $p_payment_method_id
    ) {
        $sql = 'CALL checkPaymentMethodExist(
            :p_payment_method_id
        )';
        
        return $this->fetch($sql, [
            'p_payment_method_id' => $p_payment_method_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generatePaymentMethodTable() {
        $sql = 'CALL generatePaymentMethodTable()';
        
        return $this->fetchAll($sql);
    }

    public function generatePaymentMethodOptions() {
        $sql = 'CALL generatePaymentMethodOptions()';
        
        return $this->fetchAll($sql);
    }

    public function generateShopPaymentMethodOptions(int $p_shop_id) {
        $sql = 'CALL generateShopPaymentMethodOptions(:p_shop_id)';
        
        return $this->fetchAll($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}