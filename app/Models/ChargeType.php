<?php
namespace App\Models;

use App\Core\Model;

class ChargeType extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveChargeType(
        null|int $p_charge_type_id,
        string $p_charge_type_name,
        string $p_value_type,
        string $p_charge_value,
        string $p_is_variable,
        string $p_affects_tax,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveChargeType(
            :p_charge_type_id,
            :p_charge_type_name,
            :p_value_type,
            :p_charge_value,
            :p_is_variable,
            :p_affects_tax,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_charge_type_id'    => $p_charge_type_id,
            'p_charge_type_name'  => $p_charge_type_name,
            'p_value_type'          => $p_value_type,
            'p_charge_value'      => $p_charge_value,
            'p_is_variable'         => $p_is_variable,
            'p_affects_tax'         => $p_affects_tax,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_charge_type_id'] ?? null;
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

    public function fetchChargeType(
        int $p_charge_type_id
    ) {
        $sql = 'CALL fetchChargeType(
            :p_charge_type_id
        )';
        
        return $this->fetch($sql, [
            'p_charge_type_id' => $p_charge_type_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteChargeType(
        int $p_charge_type_id
    ) {
        $sql = 'CALL deleteChargeType(
            :p_charge_type_id
        )';
        
        return $this->query($sql, [
            'p_charge_type_id' => $p_charge_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkChargeTypeExist(
        int $p_charge_type_id
    ) {
        $sql = 'CALL checkChargeTypeExist(
            :p_charge_type_id
        )';
        
        return $this->fetch($sql, [
            'p_charge_type_id' => $p_charge_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateChargeTypeTable() {
        $sql = 'CALL generateChargeTypeTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateChargeTypeOptions() {
        $sql = 'CALL generateChargeTypeOptions()';
        
        return $this->fetchAll($sql);
    }

    public function generateShopChargeTypeOptions(int $p_shop_id) {
        $sql = 'CALL generateShopChargeTypeOptions(:p_shop_id)';
        
        return $this->fetchAll($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}