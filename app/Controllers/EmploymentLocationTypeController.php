<?php
namespace App\Controllers;

session_start();

use App\Models\EmploymentLocationType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class EmploymentLocationTypeController {
    protected EmploymentLocationType $employmentLocationType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        EmploymentLocationType $employmentLocationType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->employmentLocationType   = $employmentLocationType;
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
            'save employment location type'                 => $this->saveEmploymentLocationType($lastLogBy),
            'delete employment location type'               => $this->deleteEmploymentLocationType(),
            'delete multiple employment location type'      => $this->deleteMultipleEmploymentLocationType(),
            'fetch employment location type details'        => $this->fetchEmploymentLocationTypeDetails(),
            'generate employment location type table'       => $this->generateEmploymentLocationTypeTable(),
            'generate employment location type options'     => $this->generateEmploymentLocationTypeOptions(),
            default                                         => $this->systemHelper::sendErrorResponse(
                                                                    'Transaction Failed',
                                                                    'We encountered an issue while processing your request.'
                                                                )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveEmploymentLocationType(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'employment_location_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employmentLocationTypeId       = $_POST['employment_location_type_id'] ?? null;
        $employmentLocationTypeName     = $_POST['employment_location_type_name'] ?? null;

        $employmentLocationTypeId           = $this->employmentLocationType->saveEmploymentLocationType($employmentLocationTypeId, $employmentLocationTypeName, $lastLogBy);
        $encryptedEmploymentLocationTypeId  = $this->security->encryptData($employmentLocationTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Save Employment Location Type Success',
            'The employment location type has been saved successfully.',
            ['employment_location_type_id' => $encryptedEmploymentLocationTypeId]
        );
    }

    /* =============================================================================================
        SECTION 2: INSERT METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 4: FETCH METHOD
    ============================================================================================= */

    public function fetchEmploymentLocationTypeDetails() {
        $employmentLocationTypeId           = $_POST['employment_location_type_id'] ?? null;
        $checkEmploymentLocationTypeExist   = $this->employmentLocationType->checkEmploymentLocationTypeExist($employmentLocationTypeId);
        $total                              = $checkEmploymentLocationTypeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Employment Location Type Details',
                'The employment location type does not exist',
                ['notExist' => true]
            );
        }

        $employmentLocationTypeDetails = $this->employmentLocationType->fetchEmploymentLocationType($employmentLocationTypeId);

        $response = [
            'success'                       => true,
            'employmentLocationTypeName'    => $employmentLocationTypeDetails['employment_location_type_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteEmploymentLocationType() {
        $employmentLocationTypeId = $_POST['employment_location_type_id'] ?? null;

        $this->employmentLocationType->deleteEmploymentLocationType($employmentLocationTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Employment Location Type Success',
            'The employment location type has been deleted successfully.'
        );
    }

    public function deleteMultipleEmploymentLocationType() {
        $employmentLocationTypeIds = $_POST['employment_location_type_id'] ?? null;

        foreach($employmentLocationTypeIds as $employmentLocationTypeId){
            $this->employmentLocationType->deleteEmploymentLocationType($employmentLocationTypeId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Employment Location Types Success',
            'The selected employment location types have been deleted successfully.'
        );
    }
    
    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateEmploymentLocationTypeTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $employmentLocationTypes = $this->employmentLocationType->generateEmploymentLocationTypeTable();

        foreach ($employmentLocationTypes as $row) {
            $employmentLocationTypeId       = $row['employment_location_type_id'];
            $employmentLocationTypeName     = $row['employment_location_type_name'];

            $employmentLocationTypeIdEncrypted = $this->security->encryptData($employmentLocationTypeId);

            $response[] = [
                'CHECK_BOX'                         => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                            <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $employmentLocationTypeId .'">
                                                        </div>',
                'EMPLOYMENT_LOCATION_TYPE_NAME'     => $employmentLocationTypeName,
                'LINK'                              => $pageLink .'&id='. $employmentLocationTypeIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateEmploymentLocationTypeOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $employmentLocationTypes = $this->employmentLocationType->generateEmploymentLocationTypeOptions();

        foreach ($employmentLocationTypes as $row) {
            $response[] = [
                'id'    => $row['employment_location_type_id'],
                'text'  => $row['employment_location_type_name']
            ];
        }

        echo json_encode($response);
    }

    /* =============================================================================================
        SECTION 8: CUSTOM METHOD
    ============================================================================================= */

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
}

$controller = new EmploymentLocationTypeController(
    new EmploymentLocationType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();