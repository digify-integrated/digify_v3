<?php
namespace App\Models;

use App\Core\Model;

class ProductCategory extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveProductCategory(
        $p_product_category_id,
        $p_product_category_name,
        $p_parent_category_id,
        $p_parent_category_name,
        $p_costing_method,
        $p_last_log_by
    )    {
        $sql = 'CALL saveProductCategory(
            :p_product_category_id,
            :p_product_category_name,
            :p_parent_category_id,
            :p_parent_category_name,
            :p_costing_method,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_product_category_id'     => $p_product_category_id,
            'p_product_category_name'   => $p_product_category_name,
            'p_parent_category_id'      => $p_parent_category_id,
            'p_parent_category_name'    => $p_parent_category_name,
            'p_costing_method'          => $p_costing_method,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_product_category_id'] ?? null;
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

    public function fetchProductCategory(
        $p_product_category_id
    ) {
        $sql = 'CALL fetchProductCategory(
            :p_product_category_id
        )';
        
        return $this->fetch($sql, [
            'p_product_category_id' => $p_product_category_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteProductCategory(
        $p_product_category_id
    ) {
        $sql = 'CALL deleteProductCategory(
            :p_product_category_id
        )';
        
        return $this->query($sql, [
            'p_product_category_id' => $p_product_category_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkProductCategoryExist(
        $p_product_category_id
    ) {
        $sql = 'CALL checkProductCategoryExist(
            :p_product_category_id
        )';
        
        return $this->fetch($sql, [
            'p_product_category_id' => $p_product_category_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

   public function generateProductCategoryTable(
        $p_filter_by_parent_category,
        $p_filter_by_costing_method,
    ) {
        $sql = 'CALL generateProductCategoryTable(
            :p_filter_by_parent_category,
            :p_filter_by_costing_method
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_parent_category'   => $p_filter_by_parent_category,
            'p_filter_by_costing_method'    => $p_filter_by_costing_method
        ]);
    }

    public function generateProductCategoryOptions() {
        $sql = 'CALL generateProductCategoryOptions()';
        
        return $this->fetchAll($sql);
    }

     public function generateParentCategoryOptions(
        $p_product_category_id
    ) {
        $sql = 'CALL generateParentCategoryOptions(:p_product_category_id)';
        
        return $this->fetchAll($sql, [
            'p_product_category_id' => $p_product_category_id
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}