<?php
namespace App\Models;

use App\Core\Model;

class Product extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    public function insertProduct(
        $p_product_name,
        $p_product_description,
        $p_last_log_by
    )    {
        $sql = 'CALL insertProduct(
            :p_product_name,
            :p_product_description,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_product_name'            => $p_product_name,
            'p_product_description'     => $p_product_description,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_product_id'] ?? null;
    }

    public function insertSubProduct(
        $p_parent_product_id,
        $p_variant_name,
        $p_last_log_by
    )    {
        $sql = 'CALL insertSubProduct(
            :p_parent_product_id,
            :p_variant_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_parent_product_id'   => $p_parent_product_id,
            'p_variant_name'        => $p_variant_name,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_product_id'] ?? null;
    }

    public function insertProductVariant(
        $p_parent_product_id,
        $p_product_id,
        $p_attribute_id,
        $p_attribute_name,
        $p_attribute_value_id,
        $p_attribute_value_name,
        $p_last_log_by
    )    {
        $sql = 'CALL insertProductVariant(
            :p_parent_product_id,
            :p_product_id,
            :p_attribute_id,
            :p_attribute_name,
            :p_attribute_value_id,
            :p_attribute_value_name,
            :p_last_log_by
        )';

        $row = $this->query($sql, [
            'p_parent_product_id'      => $p_parent_product_id,
            'p_product_id'              => $p_product_id,
            'p_attribute_id'            => $p_attribute_id,
            'p_attribute_name'          => $p_attribute_name,
            'p_attribute_value_id'      => $p_attribute_value_id,
            'p_attribute_value_name'    => $p_attribute_value_name,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    public function insertProductCategoryMap(
        $p_product_id,
        $p_product_name,
        $p_category_id,
        $p_category_name,
        $p_last_log_by
    )    {
        $sql = 'CALL insertProductCategoryMap(
            :p_product_id,
            :p_product_name,
            :p_category_id,
            :p_category_name,
            :p_last_log_by
        )';

        $row = $this->query($sql, [
            'p_product_id'      => $p_product_id,
            'p_product_name'    => $p_product_name,
            'p_category_id'     => $p_category_id,
            'p_category_name'   => $p_category_name,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function insertProductTax(
        $p_product_id,
        $p_product_name,
        $p_tax_type,
        $p_tax_id,
        $p_tax_name,
        $p_last_log_by
    )    {
        $sql = 'CALL insertProductTax(
            :p_product_id,
            :p_product_name,
            :p_tax_type,
            :p_tax_id,
            :p_tax_name,
            :p_last_log_by
        )';

        $row = $this->query($sql, [
            'p_product_id'      => $p_product_id,
            'p_product_name'    => $p_product_name,
            'p_tax_type'        => $p_tax_type,
            'p_tax_id'          => $p_tax_id,
            'p_tax_name'        => $p_tax_name,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function insertProductAttribute(
        $p_product_id,
        $p_product_name,
        $p_attribute_id,
        $p_attribute_name,
        $p_attribute_value_id,
        $p_attribute_value_name,
        $p_last_log_by
    )    {
        $sql = 'CALL insertProductAttribute(
            :p_product_id,
            :p_product_name,
            :p_attribute_id,
            :p_attribute_name,
            :p_attribute_value_id,
            :p_attribute_value_name,
            :p_last_log_by
        )';

        $row = $this->query($sql, [
            'p_product_id'              => $p_product_id,
            'p_product_name'            => $p_product_name,
            'p_attribute_id'            => $p_attribute_id,
            'p_attribute_name'          => $p_attribute_name,
            'p_attribute_value_id'      => $p_attribute_value_id,
            'p_attribute_value_name'    => $p_attribute_value_name,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateProductGeneral(
        $p_product_id,
        $p_product_name,
        $p_product_description,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductGeneral(
            :p_product_id,
            :p_product_name,
            :p_product_description,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'              => $p_product_id,
            'p_product_name'            => $p_product_name,
            'p_product_description'     => $p_product_description,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    public function updateProductInventory(
        $p_product_id,
        $p_sku,
        $p_barcode,
        $p_product_type,
        $p_quantity_on_hand,
        $p_unit_id,
        $p_unit_name,
        $p_unit_abbreviation,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductInventory(
            :p_product_id,
            :p_sku,
            :p_barcode,
            :p_product_type,
            :p_quantity_on_hand,
            :p_unit_id,
            :p_unit_name,
            :p_unit_abbreviation,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'          => $p_product_id,
            'p_sku'                 => $p_sku,
            'p_barcode'             => $p_barcode,
            'p_product_type'        => $p_product_type,
            'p_quantity_on_hand'    => $p_quantity_on_hand,
            'p_unit_id'             => $p_unit_id,
            'p_unit_name'           => $p_unit_name,
            'p_unit_abbreviation'   => $p_unit_abbreviation,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateProductPricing(
        $p_product_id,
        $p_sales_price,
        $p_cost,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductPricing(
            :p_product_id,
            :p_sales_price,
            :p_cost,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'      => $p_product_id,
            'p_sales_price'     => $p_sales_price,
            'p_cost'            => $p_cost,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductShipping(
        $p_product_id,
        $p_weight,
        $p_width,
        $p_height,
        $p_length,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductShipping(
            :p_product_id,
            :p_weight,
            :p_width,
            :p_height,
            :p_length,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'      => $p_product_id,
            'p_weight'          => $p_weight,
            'p_width'           => $p_width,
            'p_height'          => $p_height,
            'p_length'          => $p_length,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductArchive(
        $p_product_id,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductArchive(
            :p_product_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'      => $p_product_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductUnarchive(
        $p_product_id,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductUnarchive(
            :p_product_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'      => $p_product_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateProductSettings(
        $p_product_id,
        $p_value,
        $p_update_type,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProductSettings(
            :p_product_id,
            :p_value,
            :p_update_type,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_product_id'      => $p_product_id,
            'p_value'           => $p_value,
            'p_update_type'     => $p_update_type,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

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

    public function fetchProductCategoryMap(
        $p_product_id
    ) {
        $sql = 'CALL fetchProductCategoryMap(
            :p_product_id
        )';
        
        return $this->fetchAll($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function fetchProductTax(
        $p_product_id,
        $p_tax_type
    ) {
        $sql = 'CALL fetchProductTax(
            :p_product_id,
            :p_tax_type
        )';
        
        return $this->fetchAll($sql, [
            'p_product_id'  => $p_product_id,
            'p_tax_type'    => $p_tax_type
        ]);
    }

    public function fetchAllProductAttributes(
        $p_product_id,
        $p_tax_type
    ) {
        $sql = 'CALL fetchAllProductAttributes(
            :p_product_id,
            :p_tax_type
        )';
        
        return $this->fetchAll($sql, [
            'p_product_id'  => $p_product_id,
            'p_tax_type'    => $p_tax_type
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

    public function deleteProductCategoryMap(
        $p_product_id
    ) {
        $sql = 'CALL deleteProductCategoryMap(
            :p_product_id
        )';
        
        return $this->query($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function deleteProductTax(
        $p_product_id
    ) {
        $sql = 'CALL deleteProductTax(
            :p_product_id
        )';
        
        return $this->query($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function deleteProductAttribute(
        $p_product_attribute_id
    ) {
        $sql = 'CALL deleteProductAttribute(
            :p_product_attribute_id
        )';
        
        return $this->query($sql, [
            'p_product_attribute_id' => $p_product_attribute_id
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

    public function checkProductSKUExist(
        $p_product_id,
        $p_sku
    ) {
        $sql = 'CALL checkProductSKUExist(
            :p_product_id,
            :p_sku
        )';
        
        return $this->fetch($sql, [
            'p_product_id'  => $p_product_id,
            'p_sku'         => $p_sku
        ]);
    }

    public function checkProductBarcodeExist(
        $p_product_id,
        $p_barcode
    ) {
        $sql = 'CALL checkProductBarcodeExist(
            :p_product_id,
            :p_barcode
        )';
        
        return $this->fetch($sql, [
            'p_product_id'  => $p_product_id,
            'p_barcode'     => $p_barcode
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateProductCard(
        $p_search_value,
        $p_filter_by_product_type, 
        $p_filter_by_product_category, 
        $p_filter_by_is_sellable, 
        $p_filter_by_is_purchasable, 
        $p_filter_by_show_on_pos, 
        $p_filter_by_product_status, 
        $p_limit, 
        $p_offset
    ) {
        $sql = 'CALL generateProductCard(
            :p_search_value,
            :p_filter_by_product_type,
            :p_filter_by_product_category,
            :p_filter_by_is_sellable,
            :p_filter_by_is_purchasable,
            :p_filter_by_show_on_pos,
            :p_filter_by_product_status,
            :p_limit,
            :p_offset
        )';

        return $this->fetchAll($sql, [
            'p_search_value'                => $p_search_value,
            'p_filter_by_product_type'      => $p_filter_by_product_type,
            'p_filter_by_product_category'  => $p_filter_by_product_category,
            'p_filter_by_is_sellable'       => $p_filter_by_is_sellable,
            'p_filter_by_is_purchasable'    => $p_filter_by_is_purchasable,
            'p_filter_by_show_on_pos'       => $p_filter_by_show_on_pos,
            'p_filter_by_product_status'    => $p_filter_by_product_status,
            'p_limit'                       => $p_limit,
            'p_offset'                      => $p_offset
        ]);
    }

    public function generateProductTable(
        $p_filter_by_product_type, 
        $p_filter_by_product_category, 
        $p_filter_by_is_sellable, 
        $p_filter_by_is_purchasable, 
        $p_filter_by_show_on_pos, 
        $p_filter_by_product_status
    ) {
        $sql = 'CALL generateProductTable(
            :p_filter_by_product_type,
            :p_filter_by_product_category,
            :p_filter_by_is_sellable,
            :p_filter_by_is_purchasable,
            :p_filter_by_show_on_pos,
            :p_filter_by_product_status
        )';

        return $this->fetchAll($sql, [
            'p_filter_by_product_type'      => $p_filter_by_product_type,
            'p_filter_by_product_category'  => $p_filter_by_product_category,
            'p_filter_by_is_sellable'       => $p_filter_by_is_sellable,
            'p_filter_by_is_purchasable'    => $p_filter_by_is_purchasable,
            'p_filter_by_show_on_pos'       => $p_filter_by_show_on_pos,
            'p_filter_by_product_status'    => $p_filter_by_product_status
        ]);
    }

    public function generateProductAttributeTable(
        $p_product_id
    ) {
        $sql = 'CALL generateProductAttributeTable(
            :p_product_id
        )';

        return $this->fetchAll($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function generateProductVariationTable(
        $p_product_id
    ) {
        $sql = 'CALL generateProductVariationTable(
            :p_product_id
        )';

        return $this->fetchAll($sql, [
            'p_product_id' => $p_product_id
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