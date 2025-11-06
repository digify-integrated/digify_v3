<?php
namespace App\Controllers;

session_start();

use App\Models\UnitType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class UnitTypeController {
    protected UnitType $unitType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        UnitType $unitType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->unitType      = $unitType;
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
            'save unit type'                 => $this->saveUnitType($lastLogBy),
            'delete unit type'               => $this->deleteUnitType(),
            'delete multiple unit type'      => $this->deleteMultipleUnitType(),
            'fetch unit type details'        => $this->fetchUnitTypeDetails(),
            'generate unit type table'       => $this->generateUnitTypeTable(),
            'generate unit type options'     => $this->generateUnitTypeOptions(),
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

    public function saveUnitType(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'unit_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $unitTypeId      = $_POST['unit_type_id'] ?? null;
        $unitTypeName    = $_POST['unit_type_name'] ?? null;

        $unitTypeId = $this->unitType->saveUnitType(
            $unitTypeId,
            $unitTypeName,
            $lastLogBy
        );
        
        $encryptedUnitTypeId = $this->security->encryptData($unitTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Save Unit Type Success',
            'The unit type has been saved successfully.',
            ['unit_type_id' => $encryptedUnitTypeId]
        );
    }

    public function deleteUnitType() {
        $unitTypeId = $_POST['unit_type_id'] ?? null;

        $this->unitType->deleteUnitType($unitTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Unit Type Success',
            'The unit type has been deleted successfully.'
        );
    }

    public function deleteMultipleUnitType() {
        $unitTypeIds = $_POST['unit_type_id'] ?? null;

        foreach($unitTypeIds as $unitTypeId){
            $this->unitType->deleteUnitType($unitTypeId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Unit Types Success',
            'The selected unit types have been deleted successfully.'
        );
    }

    public function fetchUnitTypeDetails() {
        $unitTypeId             = $_POST['unit_type_id'] ?? null;
        $checkUnitTypeExist     = $this->unitType->checkUnitTypeExist($unitTypeId);
        $total                  = $checkUnitTypeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Unit Type Details',
                'The unit type does not exist',
                ['notExist' => true]
            );
        }

        $unitTypeDetails = $this->unitType->fetchUnitType($unitTypeId);

        $response = [
            'success'       => true,
            'unitTypeName'  => $unitTypeDetails['unit_type_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateUnitTypeTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $unitTypes = $this->unitType->generateUnitTypeTable();

        foreach ($unitTypes as $row) {
            $unitTypeId      = $row['unit_type_id'];
            $unitTypeName   = $row['unit_type_name'];

            $unitTypeIdEncrypted = $this->security->encryptData($unitTypeId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $unitTypeId .'">
                                            </div>',
                'ADDRESS_TYPE_NAME'     => $unitTypeName,
                'LINK'                  => $pageLink .'&id='. $unitTypeIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateUnitTypeOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $countries = $this->unitType->generateUnitTypeOptions();

        foreach ($countries as $row) {
            $response[] = [
                'id'    => $row['unit_type_id'],
                'text'  => $row['unit_type_name']
            ];
        }

        echo json_encode($response);
    }
}

$controller = new UnitTypeController(
    new UnitType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();