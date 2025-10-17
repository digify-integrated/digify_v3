<?php
namespace App\Models;

use App\Core\Model;

class ProductType extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveProductType(
        $p_product_type_id,
        $p_product_type_name,
        $p_last_log_by
    )    {
        $sql = 'CALL saveProductType(
            :p_product_type_id,
            :p_product_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_product_type_id'     => $p_product_type_id,
            'p_product_type_name'   => $p_product_type_name,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_product_type_id'] ?? null;
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

    public function fetchProductType(
        $p_product_type_id
    ) {
        $sql = 'CALL fetchProductType(
            :p_product_type_id
        )';
        
        return $this->fetch($sql, [
            'p_product_type_id' => $p_product_type_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteProductType(
        $p_product_type_id
    ) {
        $sql = 'CALL deleteProductType(
            :p_product_type_id
        )';
        
        return $this->query($sql, [
            'p_product_type_id' => $p_product_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkProductTypeExist(
        $p_product_type_id
    ) {
        $sql = 'CALL checkProductTypeExist(
            :p_product_type_id
        )';
        
        return $this->fetch($sql, [
            'p_product_type_id' => $p_product_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateProductTypeTable() {
        $sql = 'CALL generateProductTypeTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateProductTypeOptions() {
        $sql = 'CALL generateProductTypeOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}