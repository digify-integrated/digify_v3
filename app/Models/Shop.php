<?php
namespace App\Models;

use App\Core\Model;

class Shop extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveShop(
        null|int $p_shop_id,
        string $p_shop_name,
        int $p_company_id,
        string $p_company_name,
        int $p_shop_type_id,
        string $p_shop_type_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveShop(
            :p_shop_id,
            :p_shop_name,
            :p_company_id,
            :p_company_name,
            :p_shop_type_id,
            :p_shop_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_shop_id'         => $p_shop_id,
            'p_shop_name'       => $p_shop_name,
            'p_company_id'      => $p_company_id,
            'p_company_name'    => $p_company_name,
            'p_shop_type_id'    => $p_shop_type_id,
            'p_shop_type_name'  => $p_shop_type_name,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_shop_id'] ?? null;
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

    public function fetchShop(
        null|string|int $p_shop_id
    ) {
        $sql = 'CALL fetchShop(
            :p_shop_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteShop(
        int $p_shop_id
    ) {
        $sql = 'CALL deleteShop(
            :p_shop_id
        )';
        
        return $this->query($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkShopExist(
        int $p_shop_id
    ) {
        $sql = 'CALL checkShopExist(
            :p_shop_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateShopTable(
        null|string $p_filter_by_company,
        null|string $p_filter_by_shop_type
    ) {
        $sql = 'CALL generateShopTable(
            :p_filter_by_company,
            :p_filter_by_shop_type
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_company'   => $p_filter_by_company,
            'p_filter_by_shop_type' => $p_filter_by_shop_type
        ]);
    }

    public function generateShopOptions(
        null|int $p_shop_id
    ) {
        $sql = 'CALL generateShopOptions(
            :p_shop_id
        )';
        
        return $this->fetchAll($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}