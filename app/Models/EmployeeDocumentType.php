<?php
namespace App\Models;

use App\Core\Model;

class EmployeeDocumentType extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveEmployeeDocumentType(
        null|int $p_employee_document_type_id,
        string $p_employee_document_type_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveEmployeeDocumentType(
            :p_employee_document_type_id,
            :p_employee_document_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_employee_document_type_id'       => $p_employee_document_type_id,
            'p_employee_document_type_name'     => $p_employee_document_type_name,
            'p_last_log_by'                     => $p_last_log_by
        ]);

        return $row['new_employee_document_type_id'] ?? null;
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

    public function fetchEmployeeDocumentType(
        int $p_employee_document_type_id
    ) {
        $sql = 'CALL fetchEmployeeDocumentType(
            :p_employee_document_type_id
        )';
        
        return $this->fetch($sql, [
            'p_employee_document_type_id' => $p_employee_document_type_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteEmployeeDocumentType(
        int $p_employee_document_type_id
    ) {
        $sql = 'CALL deleteEmployeeDocumentType(
            :p_employee_document_type_id
        )';
        
        return $this->query($sql, [
            'p_employee_document_type_id' => $p_employee_document_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkEmployeeDocumentTypeExist(
        int $p_employee_document_type_id
    ) {
        $sql = 'CALL checkEmployeeDocumentTypeExist(
            :p_employee_document_type_id
        )';
        
        return $this->fetch($sql, [
            'p_employee_document_type_id' => $p_employee_document_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateEmployeeDocumentTypeTable() {
        $sql = 'CALL generateEmployeeDocumentTypeTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateEmployeeDocumentTypeOptions() {
        $sql = 'CALL generateEmployeeDocumentTypeOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}