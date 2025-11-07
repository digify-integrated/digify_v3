<?php
namespace App\Models;

use App\Core\Model;

class Product extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveSubProductAndVariants(
        null|string|int $p_parent_product_id,
        string $p_parent_product_name,
        string $p_variant_name,
        string $p_variant_signature,
        int $p_last_log_by
    ) {
        $sql = 'CALL saveSubProductAndVariants(
            :p_parent_product_id,
            :p_parent_product_name,
            :p_variant_name,
            :p_variant_signature,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_parent_product_id'       => $p_parent_product_id,
            'p_parent_product_name'     => $p_parent_product_name,
            'p_variant_name'            => $p_variant_name,
            'p_variant_signature'       => $p_variant_signature,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_subproduct_id'] ?? null;
    }

    public function saveProductPricelist(
        null|string|int $p_product_pricelist_id,
        int $p_product_id,
        string $p_product_name,
        string $p_discount_type,
        float $p_fixed_price,
        int $p_min_quantity,
        string $p_validity_start_date,
        null|string $p_validity_end_date,
        string $p_remarks,
        int $p_last_log_by
    ) {
        $sql = 'CALL saveProductPricelist(
            :p_product_pricelist_id,
            :p_product_id,
            :p_product_name,
            :p_discount_type,
            :p_fixed_price,
            :p_min_quantity,
            :p_validity_start_date,
            :p_validity_end_date,
            :p_remarks,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_product_pricelist_id'    => $p_product_pricelist_id,
            'p_product_id'              => $p_product_id,
            'p_product_name'            => $p_product_name,
            'p_discount_type'           => $p_discount_type,
            'p_fixed_price'             => $p_fixed_price,
            'p_min_quantity'            => $p_min_quantity,
            'p_validity_start_date'     => $p_validity_start_date,
            'p_validity_end_date'       => $p_validity_end_date,
            'p_remarks'                 => $p_remarks,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    public function insertProduct(
        string $p_product_name,
        string $p_product_description,
        int $p_last_log_by
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

    public function insertProductVariant(
        int $p_parent_product_id,
        string $p_parent_product_name,
        int $p_product_id,
        string $p_product_name,
        int $p_attribute_id,
        string $p_attribute_name,
        int $p_attribute_value_id,
        string $p_attribute_value_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertProductVariant(
            :p_parent_product_id,
            :p_parent_product_name,
            :p_product_id,
            :p_product_name,
            :p_attribute_id,
            :p_attribute_name,
            :p_attribute_value_id,
            :p_attribute_value_name,
            :p_last_log_by
        )';

        $row = $this->query($sql, [
            'p_parent_product_id'       => $p_parent_product_id,
            'p_parent_product_name'     => $p_parent_product_name,
            'p_product_id'              => $p_product_id,
            'p_product_name'            => $p_product_name,
            'p_attribute_id'            => $p_attribute_id,
            'p_attribute_name'          => $p_attribute_name,
            'p_attribute_value_id'      => $p_attribute_value_id,
            'p_attribute_value_name'    => $p_attribute_value_name,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    public function insertProductCategoryMap(
        int $p_product_id,
        string $p_product_name,
        int $p_category_id,
        string $p_category_name,
        int $p_last_log_by
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
        int $p_product_id,
        string $p_product_name,
        string $p_tax_type,
        int $p_tax_id,
        string $p_tax_name,
        int $p_last_log_by
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
        int $p_product_id,
        string $p_product_name,
        int $p_attribute_id,
        string $p_attribute_name,
        int $p_attribute_value_id,
        string $p_attribute_value_name,
        int $p_last_log_by
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
        int $p_product_id,
        string $p_product_name,
        string $p_product_description,
        int $p_last_log_by
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
        int $p_product_id,
        string $p_sku,
        string $p_barcode,
        string $p_product_type,
        float $p_quantity_on_hand,
        int $p_unit_id,
        string $p_unit_name,
        string $p_unit_abbreviation,
        int $p_last_log_by
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
        int $p_product_id,
        float $p_sales_price,
        float $p_cost,
        int $p_last_log_by
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
        int $p_product_id,
        float $p_weight,
        float $p_width,
        float $p_height,
        float $p_length,
        int $p_last_log_by
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
        int $p_product_id,
        int $p_last_log_by
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
        int $p_product_id,
        int $p_last_log_by
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

    public function updateAllSubProductsDeactivate(
        int $p_parent_product_id,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateAllSubProductsDeactivate(
            :p_parent_product_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_parent_product_id'   => $p_parent_product_id,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateProductSettings(
        int $p_product_id,
        string $p_value,
        string $p_update_type,
        int $p_last_log_by
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
        int $p_product_id,
        string $p_product_image,
        int $p_last_log_by
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
        int $p_product_id
    ) {
        $sql = 'CALL fetchProduct(
            :p_product_id
        )';
        
        return $this->fetch($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function fetchProductCategoryMap(
        int $p_product_id
    ) {
        $sql = 'CALL fetchProductCategoryMap(
            :p_product_id
        )';
        
        return $this->fetchAll($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function fetchProductTax(
        int $p_product_id,
        string $p_tax_type
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

    public function fetchProductAttribute(
        int $p_product_attribute_id
    ) {
        $sql = 'CALL fetchProductAttribute(
            :p_product_attribute_id
        )';
        
        return $this->fetch($sql, [
            'p_product_attribute_id' => $p_product_attribute_id
        ]);
    }

    public function fetchAllProductAttributes(
        int $p_product_id,
        string $p_creation_type
    ) {
        $sql = 'CALL fetchAllProductAttributes(
            :p_product_id,
            :p_creation_type
        )';
        
        return $this->fetchAll($sql, [
            'p_product_id'      => $p_product_id,
            'p_creation_type'   => $p_creation_type
        ]);
    }

    public function fetchProductPricelist(
        int $p_product_pricelist_id
    ) {
        $sql = 'CALL fetchProductPricelist(
            :p_product_pricelist_id
        )';
        
        return $this->fetch($sql, [
            'p_product_pricelist_id' => $p_product_pricelist_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteProduct(
        int $p_product_id
    ) {
        $sql = 'CALL deleteProduct(
            :p_product_id
        )';
        
        return $this->query($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function deleteProductCategoryMap(
        int $p_product_id
    ) {
        $sql = 'CALL deleteProductCategoryMap(
            :p_product_id
        )';
        
        return $this->query($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function deleteProductTax(
        int $p_product_id
    ) {
        $sql = 'CALL deleteProductTax(
            :p_product_id
        )';
        
        return $this->query($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function deleteProductAttribute(
        int $p_product_attribute_id
    ) {
        $sql = 'CALL deleteProductAttribute(
            :p_product_attribute_id
        )';
        
        return $this->query($sql, [
            'p_product_attribute_id' => $p_product_attribute_id
        ]);
    }

    public function deleteProductPricelist(
        int $p_product_pricelist_id
    ) {
        $sql = 'CALL deleteProductPricelist(
            :p_product_pricelist_id
        )';
        
        return $this->query($sql, [
            'p_product_pricelist_id' => $p_product_pricelist_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkProductExist(
        int $p_product_id
    ) {
        $sql = 'CALL checkProductExist(
            :p_product_id
        )';
        
        return $this->fetch($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function checkProductSKUExist(
        int $p_product_id,
        string $p_sku
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
        int $p_product_id,
        string $p_barcode
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

    public function checkProductVariantExists($p_product_id, $p_attribute_value_id) {
        $sql = 'CALL checkProductVariantExists(
            :p_product_id, 
            :p_attribute_value_id
        )';

        return $this->fetch($sql, [
            'p_product_id'          => $p_product_id,
            'p_attribute_value_id'  => $p_attribute_value_id
        ]);
    }

    public function checkProductPricelistExists($p_product_pricelist_id) {
        $sql = 'CALL checkProductPricelistExists(
            :p_product_pricelist_id
        )';

        return $this->fetch($sql, [
            'p_product_pricelist_id' => $p_product_pricelist_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateProductCard(
        null|string $p_search_value,
        null|string $p_filter_by_product_type, 
        null|string $p_filter_by_product_category, 
        null|string $p_filter_by_is_sellable, 
        null|string $p_filter_by_is_purchasable, 
        null|string $p_filter_by_show_on_pos, 
        null|string $p_filter_by_product_status, 
        int $p_limit, 
        int $p_offset
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
        null|string $p_filter_by_product_type, 
        null|string $p_filter_by_product_category, 
        null|string $p_filter_by_is_sellable, 
        null|string $p_filter_by_is_purchasable, 
        null|string $p_filter_by_show_on_pos, 
        null|string $p_filter_by_product_status
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
        int $p_product_id
    ) {
        $sql = 'CALL generateProductAttributeTable(
            :p_product_id
        )';

        return $this->fetchAll($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function generateProductVariationTable(
        int $p_product_id
    ) {
        $sql = 'CALL generateProductVariationTable(
            :p_product_id
        )';

        return $this->fetchAll($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    public function generateProductPricelistTable(
        int $p_product_id
    ) {
        $sql = 'CALL generateProductPricelistTable(
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