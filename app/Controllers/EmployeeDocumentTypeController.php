<?php
namespace App\Controllers;

session_start();

use App\Models\EmployeeDocumentType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class EmployeeDocumentTypeController {
    protected EmployeeDocumentType $employeeDocumentType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        EmployeeDocumentType $employeeDocumentType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->employeeDocumentType     = $employeeDocumentType;
        $this->authentication           = $authentication;
        $this->security                 = $security;
        $this->systemHelper             = $systemHelper;
    }

    public function handleRequest() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Only POST requests are allowed.'
            );
        }

        $transaction    = $_POST['transaction'] ?? null;
        $lastLogBy      = $_SESSION['user_account_id'];

        if (!$transaction) {
            $this->systemHelper::sendErrorResponse(
                'Missing Transaction',
                'No transaction type was provided.'
            );
        }

        $loginCredentialsDetails    = $this->authentication->fetchLoginCredentials($lastLogBy);       
        $multipleSession            = $loginCredentialsDetails['multiple_session'] ?? 'No';
        $isActive                   = $loginCredentialsDetails['active'] ?? 'No';

        $sessionTokenDetails    = $this->authentication->fetchSession($lastLogBy);
        $sessionToken           = $sessionTokenDetails['session_token'] ?? '';

        if ($isActive === 'No' || (!$this->security->verifyToken($_SESSION['session_token'], $sessionToken) && $multipleSession === 'No')) {
            $this->systemHelper::sendErrorResponse(
                'Session Expired', 
                'Your session has expired. Please log in again to continue.',
                [
                    'invalid_session'   => true,
                    'redirect_link'     => 'logout.php?logout'
                ]
            );
        }

        $transaction = strtolower(trim($transaction));

        match ($transaction) {
            'save employee document type'               => $this->saveEmployeeDocumentType($lastLogBy),
            'delete employee document type'             => $this->deleteEmployeeDocumentType(),
            'delete multiple employee document type'    => $this->deleteMultipleEmployeeDocumentType(),
            'fetch employee document type details'      => $this->fetchEmployeeDocumentTypeDetails(),
            'generate employee document type table'     => $this->generateEmployeeDocumentTypeTable(),
            'generate employee document type options'   => $this->generateEmployeeDocumentTypeOptions(),
            default                                     => $this->systemHelper::sendErrorResponse(
                                                                    'Transaction Failed',
                                                                    'We encountered an issue while processing your request.'
                                                                )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 2: INSERT METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 4: FETCH METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 8: CUSTOM METHOD
    ============================================================================================= */

    public function saveEmployeeDocumentType(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'employee_document_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeDocumentTypeId     = $_POST['employee_document_type_id'] ?? null;
        $employeeDocumentTypeName   = $_POST['employee_document_type_name'] ?? null;

        $employeeDocumentTypeId = $this->employeeDocumentType->saveEmployeeDocumentType(
            $employeeDocumentTypeId,
            $employeeDocumentTypeName,
            $lastLogBy
        );
        
        $encryptedEmployeeDocumentTypeId = $this->security->encryptData($employeeDocumentTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Document Type Success',
            'The employee document type has been saved successfully.',
            ['employee_document_type_id' => $encryptedEmployeeDocumentTypeId]
        );
    }

    public function deleteEmployeeDocumentType() {
        $employeeDocumentTypeId = $_POST['employee_document_type_id'] ?? null;

        $this->employeeDocumentType->deleteEmployeeDocumentType($employeeDocumentTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Employee Document Type Success',
            'The employee document type has been deleted successfully.'
        );
    }

    public function deleteMultipleEmployeeDocumentType() {
        $employeeDocumentTypeIds = $_POST['employee_document_type_id'] ?? null;

        foreach($employeeDocumentTypeIds as $employeeDocumentTypeId){
            $this->employeeDocumentType->deleteEmployeeDocumentType($employeeDocumentTypeId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Employee Document Types Success',
            'The selected employee document types have been deleted successfully.'
        );
    }

    public function fetchEmployeeDocumentTypeDetails() {
        $employeeDocumentTypeId             = $_POST['employee_document_type_id'] ?? null;
        $checkEmployeeDocumentTypeExist     = $this->employeeDocumentType->checkEmployeeDocumentTypeExist($employeeDocumentTypeId);
        $total                              = $checkEmployeeDocumentTypeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Employee Document Type Details',
                'The employee document type does not exist',
                ['notExist' => true]
            );
        }

        $employeeDocumentTypeDetails = $this->employeeDocumentType->fetchEmployeeDocumentType($employeeDocumentTypeId);

        $response = [
            'success'                   => true,
            'employeeDocumentTypeName'  => $employeeDocumentTypeDetails['employee_document_type_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateEmployeeDocumentTypeTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $employeeDocumentTypes = $this->employeeDocumentType->generateEmployeeDocumentTypeTable();

        foreach ($employeeDocumentTypes as $row) {
            $employeeDocumentTypeId     = $row['employee_document_type_id'];
            $employeeDocumentTypeName   = $row['employee_document_type_name'];

            $employeeDocumentTypeIdEncrypted = $this->security->encryptData($employeeDocumentTypeId);

            $response[] = [
                'CHECK_BOX'                     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $employeeDocumentTypeId .'">
                                                    </div>',
                'EMPLOYEE_DOCUMENT_TYPE_NAME'   => $employeeDocumentTypeName,
                'LINK'                          => $pageLink .'&id='. $employeeDocumentTypeIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateEmployeeDocumentTypeOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $employeeDocumentTypes = $this->employeeDocumentType->generateEmployeeDocumentTypeOptions();

        foreach ($employeeDocumentTypes as $row) {
            $response[] = [
                'id'    => $row['employee_document_type_id'],
                'text'  => $row['employee_document_type_name']
            ];
        }

        echo json_encode($response);
    }
}

$controller = new EmployeeDocumentTypeController(
    new EmployeeDocumentType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();