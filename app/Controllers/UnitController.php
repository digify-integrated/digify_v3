<?php
namespace App\Controllers;

session_start();

use App\Models\Unit;
use App\Models\UnitType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class UnitController {
    protected Unit $unit;
    protected UnitType $unitType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Unit $unit,
        UnitType $unitType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->unit             = $unit;
        $this->unitType         = $unitType;
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
            'save unit'                 => $this->saveUnit($lastLogBy),
            'delete unit'               => $this->deleteUnit(),
            'delete multiple unit'      => $this->deleteMultipleUnit(),
            'fetch unit details'        => $this->fetchUnitDetails(),
            'generate unit table'       => $this->generateUnitTable(),
            'generate unit options'     => $this->generateUnitOptions(),
            default                     => $this->systemHelper::sendErrorResponse(
                                                'Transaction Failed',
                                                'We encountered an issue while processing your request.'
                                            )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveUnit(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'unit_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $unitId             = $_POST['unit_id'] ?? null;
        $unitName           = $_POST['unit_name'] ?? null;
        $unitAbbreviation   = $_POST['unit_abbreviation'] ?? null;
        $unitTypeId         = $_POST['unit_type_id'] ?? null;
        $ratioToBase        = $_POST['ratio_to_base'] ?? null;

        $unitTypeDetails    = $this->unitType->fetchUnitType($unitTypeId);
        $unitTypeName       = $unitTypeDetails['unit_type_name'] ?? null;

        $unitId = $this->unit->saveUnit(
            $unitId,
            $unitName,
            $unitAbbreviation,
            $unitTypeId,
            $unitTypeName,
            $ratioToBase,
            $lastLogBy
        );

        $encryptedUnitId = $this->security->encryptData($unitId);

        $this->systemHelper::sendSuccessResponse(
            'Save Unit Success',
            'The unit has been saved successfully.',
            ['unit_id' => $encryptedUnitId]
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

    public function fetchUnitDetails() {
        $unitId             = $_POST['unit_id'] ?? null;
        $checkUnitExist     = $this->unit->checkUnitExist($unitId);
        $total              = $checkUnitExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Unit Details',
                'The unit does not exist',
                ['notExist' => true]
            );
        }

        $unitDetails = $this->unit->fetchUnit($unitId);

        $response = [
            'success'           => true,
            'unitName'          => $unitDetails['unit_name'] ?? null,
            'unitAbbreviation'  => $unitDetails['unit_abbreviation'] ?? null,
            'unitTypeId'        => $unitDetails['unit_type_id'] ?? null,
            'ratioToBase'       => $unitDetails['ratio_to_base'] ?? null,
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteUnit() {
        $unitId = $_POST['unit_id'] ?? null;

        $this->unit->deleteUnit($unitId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Unit Success',
            'The unit has been deleted successfully.'
        );
    }

    public function deleteMultipleUnit() {
        $unitIds = $_POST['unit_id'] ?? null;

        foreach($unitIds as $unitId){
            $this->unit->deleteUnit($unitId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Units Success',
            'The selected units have been deleted successfully.'
        );
    }
    
    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateUnitTable() {
        $pageLink           = $_POST['page_link'] ?? null;
        $unitTypeFilter     = $this->systemHelper->checkFilter($_POST['filter_by_unit_type'] ?? null);
        $response           = [];

        $units = $this->unit->generateUnitTable($unitTypeFilter);

        foreach ($units as $row) {
            $unitId             = $row['unit_id'];
            $unitName           = $row['unit_name'];
            $unitAbbreviation   = $row['unit_abbreviation'];
            $unitTypeName       = $row['unit_type_name'];
            $ratioToBase        = $row['ratio_to_base'];
            $unitIdEncrypted    = $this->security->encryptData($unitId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $unitId .'">
                                            </div>',
                'UNIT_NAME'             => $unitName,
                'UNIT_ABBREVIATION'     => $unitAbbreviation,
                'UNIT_TYPE_NAME'        => $unitTypeName,
                'RATIO_TO_BASE'         => number_format($ratioToBase, 6),
                'LINK'                  => $pageLink .'&id='. $unitIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateUnitOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $unitType = $this->unit->generateUnitOptions();

        $grouped = [];
        foreach ($unitType as $row) {
            $grouped[$row['unit_type_name']][] = [
                'id'   => $row['unit_id'],
                'text' => $row['unit_name'] . ' (' . $row['unit_abbreviation'] . ')'
            ];
        }

        foreach ($grouped as $unitName => $children) {
            $response[] = [
                'text'     => $unitName,
                'children' => $children
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

$controller = new UnitController(
    new Unit(),
    new UnitType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();