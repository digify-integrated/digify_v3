<?php
namespace App\Models;

use App\Core\Model;

class Attribute extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveAttribute(
        $p_attribute_id,
        $p_attribute_name,
        $p_last_log_by
    )    {
        $sql = 'CALL saveAttribute(
            :p_attribute_id,
            :p_attribute_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_attribute_id'    => $p_attribute_id,
            'p_attribute_name'  => $p_attribute_name,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_attribute_id'] ?? null;
    }

    public function saveAttributeValue(
        $p_attribute_value_id,
        $p_attribute_value_name,
        $p_attribute_id,
        $p_attribute_name,
        $p_last_log_by
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
        $p_attribute_id
    ) {
        $sql = 'CALL fetchAttribute(
            :p_attribute_id
        )';
        
        return $this->fetch($sql, [
            'p_attribute_id' => $p_attribute_id
        ]);
    }

    public function fetchAttributeValue(
        $p_attribute_value_id
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
        $p_attribute_id
    ) {
        $sql = 'CALL deleteAttribute(
            :p_attribute_id
        )';
        
        return $this->query($sql, [
            'p_attribute_id' => $p_attribute_id
        ]);
    }

    public function deleteAttributeValue(
        $p_attribute_value_id
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
        $p_attribute_id
    ) {
        $sql = 'CALL checkAttributeExist(
            :p_attribute_id
        )';
        
        return $this->fetch($sql, [
            'p_attribute_id' => $p_attribute_id
        ]);
    }

    public function checkAttributeValueExist(
        $p_attribute_value_id
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

    public function generateAttributeTable() {
        $sql = 'CALL generateAttributeTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateAttributeValueTable(
        $p_attribute_id
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

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}