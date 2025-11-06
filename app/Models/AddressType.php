<?php
namespace App\Models;

use App\Core\Model;

class AddressType extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveAddressType(
        int $p_address_type_id,
        string $p_address_type_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveAddressType(
            :p_address_type_id,
            :p_address_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_address_type_id'     => $p_address_type_id,
            'p_address_type_name'   => $p_address_type_name,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_address_type_id'] ?? null;
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

    public function fetchAddressType(
        int $p_address_type_id
    ) {
        $sql = 'CALL fetchAddressType(
            :p_address_type_id
        )';
        
        return $this->fetch($sql, [
            'p_address_type_id' => $p_address_type_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteAddressType(
        int $p_address_type_id
    ) {
        $sql = 'CALL deleteAddressType(
            :p_address_type_id
        )';
        
        return $this->query($sql, [
            'p_address_type_id' => $p_address_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkAddressTypeExist(
        int $p_address_type_id
    ) {
        $sql = 'CALL checkAddressTypeExist(
            :p_address_type_id
        )';
        
        return $this->fetch($sql, [
            'p_address_type_id' => $p_address_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateAddressTypeTable() {
        $sql = 'CALL generateAddressTypeTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateAddressTypeOptions() {
        $sql = 'CALL generateAddressTypeOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}