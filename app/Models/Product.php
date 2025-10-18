<?php
namespace App\Models;

use App\Core\Model;

class Product extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveProduct(
        $p_product_id,
        $p_product_name,
        $p_barcode,
        $p_product_type_id,
        $p_product_type_name,
        $p_product_category_id,
        $p_product_category_name,
        $p_quantity,
        $p_sales_price,
        $p_cost,
        $p_last_log_by
    )    {
        $sql = 'CALL saveProduct(
            :p_product_id,
            :p_product_name,
            :p_barcode,
            :p_product_type_id,
            :p_product_type_name,
            :p_product_category_id,
            :p_product_category_name,
            :p_quantity,
            :p_sales_price,
            :p_cost,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_product_id'              => $p_product_id,
            'p_product_name'            => $p_product_name,
            'p_barcode'                 => $p_barcode,
            'p_product_type_id'         => $p_product_type_id,
            'p_product_type_name'       => $p_product_type_name,
            'p_product_category_id'     => $p_product_category_id,
            'p_product_category_name'   => $p_product_category_name,
            'p_quantity'                => $p_quantity,
            'p_sales_price'             => $p_sales_price,
            'p_cost'                    => $p_cost,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_product_id'] ?? null;
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateProductImage(
        $p_product_id,
        $p_product_image,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductImage(
            :p_product_id,
            :p_product_image,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'      => $p_product_id,
            'p_product_image'   => $p_product_image,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchProduct(
        $p_product_id
    ) {
        $sql = 'CALL fetchProduct(
            :p_product_id
        )';
        
        return $this->fetch($sql, [
            'p_product_id' => $p_product_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteProduct(
        $p_product_id
    ) {
        $sql = 'CALL deleteProduct(
            :p_product_id
        )';
        
        return $this->query($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkProductExist(
        $p_product_id
    ) {
        $sql = 'CALL checkProductExist(
            :p_product_id
        )';
        
        return $this->fetch($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateProductCard(
        $p_search_value,
        $p_filter_by_product_type, 
        $p_filter_by_product_category, 
        $p_product_status, 
        $p_limit, 
        $p_offset
    ) {
        $sql = 'CALL generateProductCard(
            :p_search_value,
            :p_filter_by_product_type,
            :p_filter_by_product_category,
            :p_product_status,
            :p_limit,
            :p_offset
        )';

        return $this->fetchAll($sql, [
            'p_search_value'                => $p_search_value,
            'p_filter_by_product_type'      => $p_filter_by_product_type,
            'p_filter_by_product_category'  => $p_filter_by_product_category,
            'p_product_status'              => $p_product_status,
            'p_limit'                       => $p_limit,
            'p_offset'                      => $p_offset
        ]);
    }

    public function generateProductTable(
        $p_filter_by_product_type, 
        $p_filter_by_product_category, 
        $p_product_status
    ) {
        $sql = 'CALL generateProductTable(
            :p_filter_by_product_type,
            :p_filter_by_product_category,
            :p_product_status
        )';

        return $this->fetchAll($sql, [
            'p_filter_by_product_type'      => $p_filter_by_product_type,
            'p_filter_by_product_category'  => $p_filter_by_product_category,
            'p_product_status'              => $p_product_status
        ]);
    }


    public function generateProductOptions() {
        $sql = 'CALL generateProductOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}