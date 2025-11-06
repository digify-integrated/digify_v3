<?php
namespace App\Models;

use App\Core\Model;

class Relationship extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveRelationship(
        int $p_relationship_id,
        string $p_relationship_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveRelationship(
            :p_relationship_id,
            :p_relationship_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_relationship_id'     => $p_relationship_id,
            'p_relationship_name'   => $p_relationship_name,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_relationship_id'] ?? null;
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

    public function fetchRelationship(
        int $p_relationship_id
    ) {
        $sql = 'CALL fetchRelationship(
            :p_relationship_id
        )';
        
        return $this->fetch($sql, [
            'p_relationship_id' => $p_relationship_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteRelationship(
        int $p_relationship_id
    ) {
        $sql = 'CALL deleteRelationship(
            :p_relationship_id
        )';
        
        return $this->query($sql, [
            'p_relationship_id' => $p_relationship_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkRelationshipExist(
        int $p_relationship_id
    ) {
        $sql = 'CALL checkRelationshipExist(
            :p_relationship_id
        )';
        
        return $this->fetch($sql, [
            'p_relationship_id' => $p_relationship_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateRelationshipTable() {
        $sql = 'CALL generateRelationshipTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateRelationshipOptions() {
        $sql = 'CALL generateRelationshipOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}