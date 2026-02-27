<?php
namespace App\Models;

use App\Core\Model;

class ShopType extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveShopType(
        null|int $p_shop_type_id,
        string $p_shop_type_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveShopType(
            :p_shop_type_id,
            :p_shop_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_shop_type_id'    => $p_shop_type_id,
            'p_shop_type_name'  => $p_shop_type_name,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_shop_type_id'] ?? null;
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

    public function fetchShopType(
        int $p_shop_type_id
    ) {
        $sql = 'CALL fetchShopType(
            :p_shop_type_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_type_id' => $p_shop_type_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteShopType(
        int $p_shop_type_id
    ) {
        $sql = 'CALL deleteShopType(
            :p_shop_type_id
        )';
        
        return $this->query($sql, [
            'p_shop_type_id' => $p_shop_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkShopTypeExist(
        int $p_shop_type_id
    ) {
        $sql = 'CALL checkShopTypeExist(
            :p_shop_type_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_type_id' => $p_shop_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateShopTypeTable() {
        $sql = 'CALL generateShopTypeTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateShopTypeOptions() {
        $sql = 'CALL generateShopTypeOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}