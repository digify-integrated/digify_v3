<?php
namespace App\Controllers;

session_start();

use App\Models\EmploymentType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class EmploymentTypeController {
    protected EmploymentType $employmentType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        EmploymentType $employmentType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->employmentType   = $employmentType;
        $this->authentication   = $authentication;
        $this->security         = $security;
        $this->systemHelper     = $systemHelper;
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
            'save employment type'              => $this->saveEmploymentType($lastLogBy),
            'delete employment type'            => $this->deleteEmploymentType(),
            'delete multiple employment type'   => $this->deleteMultipleEmploymentType(),
            'fetch employment type details'     => $this->fetchEmploymentTypeDetails(),
            'generate employment type table'    => $this->generateEmploymentTypeTable(),
            'generate employment type options'  => $this->generateEmploymentTypeOptions(),
            default                             => $this->systemHelper::sendErrorResponse(
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

    public function saveEmploymentType(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'employment_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employmentTypeId       = $_POST['employment_type_id'] ?? null;
        $employmentTypeName     = $_POST['employment_type_name'] ?? null;

        $employmentTypeId = $this->employmentType->saveEmploymentType(
            $employmentTypeId,
            $employmentTypeName,
            $lastLogBy
        );
        
        $encryptedEmploymentTypeId = $this->security->encryptData($employmentTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Save Employment Type Success',
            'The employment type has been saved successfully.',
            ['employment_type_id' => $encryptedEmploymentTypeId]
        );
    }

    public function deleteEmploymentType() {
        $employmentTypeId = $_POST['employment_type_id'] ?? null;

        $this->employmentType->deleteEmploymentType($employmentTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Employment Type Success',
            'The employment type has been deleted successfully.'
        );
    }

    public function deleteMultipleEmploymentType() {
        $employmentTypeIds = $_POST['employment_type_id'] ?? null;

        foreach($employmentTypeIds as $employmentTypeId){
            $this->employmentType->deleteEmploymentType($employmentTypeId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Employment Types Success',
            'The selected employment types have been deleted successfully.'
        );
    }

    public function fetchEmploymentTypeDetails() {
        $employmentTypeId           = $_POST['employment_type_id'] ?? null;
        $checkEmploymentTypeExist   = $this->employmentType->checkEmploymentTypeExist($employmentTypeId);
        $total                      = $checkEmploymentTypeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Employment Type Details',
                'The employment type does not exist',
                ['notExist' => true]
            );
        }

        $employmentTypeDetails = $this->employmentType->fetchEmploymentType($employmentTypeId);

        $response = [
            'success'               => true,
            'employmentTypeName'    => $employmentTypeDetails['employment_type_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateEmploymentTypeTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $employmentTypes = $this->employmentType->generateEmploymentTypeTable();

        foreach ($employmentTypes as $row) {
            $employmentTypeId       = $row['employment_type_id'];
            $employmentTypeName     = $row['employment_type_name'];

            $employmentTypeIdEncrypted = $this->security->encryptData($employmentTypeId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $employmentTypeId .'">
                                            </div>',
                'EMPLOYMENT_TYPE_NAME'  => $employmentTypeName,
                'LINK'                  => $pageLink .'&id='. $employmentTypeIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateEmploymentTypeOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $employmentTypes = $this->employmentType->generateEmploymentTypeOptions();

        foreach ($employmentTypes as $row) {
            $response[] = [
                'id'    => $row['employment_type_id'],
                'text'  => $row['employment_type_name']
            ];
        }

        echo json_encode($response);
    }
}

$controller = new EmploymentTypeController(
    new EmploymentType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();