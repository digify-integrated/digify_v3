<?php
namespace App\Models;

use App\Core\Model;

class Attribute extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveAttribute(
        int $p_attribute_id,
        string $p_attribute_name,
        string $p_attribute_description,
        string $p_variant_creation,
        string $p_display_type,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveAttribute(
            :p_attribute_id,
            :p_attribute_name,
            :p_attribute_description,
            :p_variant_creation,
            :p_display_type,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_attribute_id'            => $p_attribute_id,
            'p_attribute_name'          => $p_attribute_name,
            'p_attribute_description'   => $p_attribute_description,
            'p_variant_creation'        => $p_variant_creation,
            'p_display_type'            => $p_display_type,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_attribute_id'] ?? null;
    }

    public function saveAttributeValue(
        int $p_attribute_value_id,
        string $p_attribute_value_name,
        int $p_attribute_id,
        string $p_attribute_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveAttributeValue(
            :p_attribute_value_id,
            :p_attribute_value_name,
            :p_attribute_id,
            :p_attribute_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_attribute_value_id'      => $p_attribute_value_id,
            'p_attribute_value_name'    => $p_attribute_value_name,
            'p_attribute_id'            => $p_attribute_id,
            'p_attribute_name'          => $p_attribute_name,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_attribute_id'] ?? null;
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

    public function fetchAttribute(
        int $p_attribute_id
    ) {
        $sql = 'CALL fetchAttribute(
            :p_attribute_id
        )';
        
        return $this->fetch($sql, [
            'p_attribute_id' => $p_attribute_id
        ]);
    }

    public function fetchAttributeValue(
        int $p_attribute_value_id
    ) {
        $sql = 'CALL fetchAttributeValue(
            :p_attribute_value_id
        )';
        
        return $this->fetch($sql, [
            'p_attribute_value_id' => $p_attribute_value_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteAttribute(
        int $p_attribute_id
    ) {
        $sql = 'CALL deleteAttribute(
            :p_attribute_id
        )';
        
        return $this->query($sql, [
            'p_attribute_id' => $p_attribute_id
        ]);
    }

    public function deleteAttributeValue(
        int $p_attribute_value_id
    ) {
        $sql = 'CALL deleteAttributeValue(
            :p_attribute_value_id
        )';
        
        return $this->query($sql, [
            'p_attribute_value_id' => $p_attribute_value_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkAttributeExist(
        int $p_attribute_id
    ) {
        $sql = 'CALL checkAttributeExist(
            :p_attribute_id
        )';
        
        return $this->fetch($sql, [
            'p_attribute_id' => $p_attribute_id
        ]);
    }

    public function checkAttributeValueExist(
        int $p_attribute_value_id
    ) {
        $sql = 'CALL checkAttributeValueExist(
            :p_attribute_value_id
        )';
        
        return $this->fetch($sql, [
            'p_attribute_value_id' => $p_attribute_value_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateAttributeTable(
        string $p_filter_by_variant_creation,
        string $p_filter_by_display_type
    ) {
        $sql = 'CALL generateAttributeTable(
            :p_filter_by_variant_creation,
            :p_filter_by_display_type
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_variant_creation'  => $p_filter_by_variant_creation,
            'p_filter_by_display_type'      => $p_filter_by_display_type
        ]);
    }

    public function generateAttributeValueTable(
        int $p_attribute_id
    ) {
        $sql = 'CALL generateAttributeValueTable(
            :p_attribute_id
        )';
        
        return $this->fetchAll($sql, [
            'p_attribute_id' => $p_attribute_id
        ]);
    }

    public function generateAttributeOptions() {
        $sql = 'CALL generateAttributeOptions()';
        
        return $this->fetchAll($sql);
    }

    public function generateAttributeValueOptions() {
        $sql = 'CALL generateAttributeValueOptions()';
        
        return $this->fetchAll($sql);
    }

    public function generateProductAttributeValueOptions(
        int $p_product_id
    ) {
        $sql = 'CALL generateProductAttributeValueOptions(
            :p_product_id
        )';
        
        return $this->fetchAll($sql, [
            'p_product_id' => $p_product_id
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}