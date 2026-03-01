<?php
namespace App\Controllers;

session_start();

use App\Models\FloorPlan;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class FloorPlanController {
    protected FloorPlan $floorPlan;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        FloorPlan $floorPlan,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->floorPlan        = $floorPlan;
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
        $pageId         = $_POST['page_id'] ?? null;
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
            'save floor plan'                   => $this->saveFloorPlan($lastLogBy),
            'save floor plan table'             => $this->saveFloorPlanTable($lastLogBy),
            'delete floor plan'                 => $this->deleteFloorPlan(),
            'delete multiple floor plan'        => $this->deleteMultipleFloorPlan(),
            'delete floor plan table'           => $this->deleteFloorPlanTable(),
            'fetch floor plan details'          => $this->fetchFloorPlanDetails(),
            'fetch floor plan table details'    => $this->fetchFloorPlanTableDetails(),
            'generate floor plan table'         => $this->generateFloorPlanTable(),
            'generate floor plan tables table'  => $this->generateFloorPlanTablesTable($lastLogBy, $pageId),
            'generate floor plan options'       => $this->generateFloorPlanOptions(),
            default                             => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveFloorPlan(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'floor_plan_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $floorPlanId    = $_POST['floor_plan_id'] ?? null;
        $floorPlanName  = $_POST['floor_plan_name'] ?? null;

        $floorPlanId = $this->floorPlan->saveFloorPlan(
            $floorPlanId,
            $floorPlanName,
            $lastLogBy
        );
        
        $encryptedFloorPlanId = $this->security->encryptData($floorPlanId);

        $this->systemHelper::sendSuccessResponse(
            'Save Floor Plan Success',
            'The floor plan has been saved successfully.',
            ['floor_plan_id' => $encryptedFloorPlanId]
        );
    }

    public function saveFloorPlanTable(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'floor_plan_table_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $floorPlanId            = $_POST['floor_plan_id'] ?? null;
        $floorPlanTableId       = $_POST['floor_plan_table_id'] ?? null;
        $tableNumber            = $_POST['table_number'] ?? 1;
        $seats                  = $_POST['seats'] ?? 1;

        $floorPlanDetails   = $this->floorPlan->fetchFloorPlan($floorPlanId);
        $floorPlanName      = $floorPlanDetails['floor_plan_name'] ?? '';

        $this->floorPlan->saveFloorPlanTable(
            $floorPlanTableId,
            $floorPlanId,
            $floorPlanName,
            $tableNumber,
            $seats,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Floor Plan Table Success',
            'The floor plan table has been saved successfully.'
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

    public function fetchFloorPlanDetails() {
        $floorPlanId            = $_POST['floor_plan_id'] ?? null;
        $checkFloorPlanExist    = $this->floorPlan->checkFloorPlanExist($floorPlanId);
        $total                  = $checkFloorPlanExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Floor Plan Details',
                'The floor plan does not exist',
                ['notExist' => true]
            );
        }

        $floorPlanDetails = $this->floorPlan->fetchFloorPlan($floorPlanId);

        $response = [
            'success'       => true,
            'floorPlanName' => $floorPlanDetails['floor_plan_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchFloorPlanTableDetails(){
        $floorPlanTableId           = $_POST['floor_plan_table_id'] ?? null;
        $checkFloorPlanTableExist   = $this->floorPlan->checkFloorPlanTableExist($floorPlanTableId);
        $total                      = $checkFloorPlanTableExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Floor Plan Table Details',
                'The floor plan table does not exist',
                ['notExist' => true]
            );
        }

        $floorPlanTableDetails = $this->floorPlan->fetchFloorPlanTable($floorPlanTableId);

        $response = [
            'success'   => true,
            'tableName' => $floorPlanTableDetails['table_name'] ?? 1,
            'seats'     => $floorPlanTableDetails['seats'] ?? 1
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteFloorPlan() {
        $floorPlanId = $_POST['floor_plan_id'] ?? null;

        $this->floorPlan->deleteFloorPlan($floorPlanId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Floor Plan Success',
            'The floor plan has been deleted successfully.'
        );
    }

    public function deleteMultipleFloorPlan() {
        $floorPlanIds = $_POST['floor_plan_id'] ?? null;

        foreach($floorPlanIds as $floorPlanId){
            $this->floorPlan->deleteFloorPlan($floorPlanId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Floor Plans Success',
            'The selected floor plans have been deleted successfully.'
        );
    }

    public function deleteFloorPlanTable() {
        $floorPlanTableId = $_POST['floor_plan_table_id'] ?? null;

        $this->floorPlan->deleteFloorPlanTable($floorPlanTableId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Floor Plan Table Success',
            'The floor plan table has been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateFloorPlanTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $floorPlans = $this->floorPlan->generateFloorPlanTable();

        foreach ($floorPlans as $row) {
            $floorPlanId      = $row['floor_plan_id'];
            $floorPlanName    = $row['floor_plan_name'];

            $floorPlanIdEncrypted = $this->security->encryptData($floorPlanId);

            $response[] = [
                'CHECK_BOX'         => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                            <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $floorPlanId .'">
                                        </div>',
                'FLOOR_PLAN_NAME'   => $floorPlanName,
                'LINK'              => $pageLink .'&id='. $floorPlanIdEncrypted
            ];
        }

        echo json_encode($response);
    }

    public function generateFloorPlanTablesTable(
        int $lastLogBy,
        int $pageId
    ) {
        $floorPlanId    = $_POST['floor_plan_id'] ?? null;
        $response       = [];

        $writeAccess        = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'log notes')['total'] ?? 0;

        $florPlanTables = $this->floorPlan->generateFloorPlanTablesTable($floorPlanId);

        foreach ($florPlanTables as $row) {
            $floorPlanTableId   = $row['floor_plan_table_id'];
            $tableNumber        = $row['table_number'];
            $seats              = $row['seats'];

            $button = '';
            if($writeAccess > 0){
                $button = '<button class="btn btn-icon btn-light btn-active-light-primary update-floor-plan-table" data-floor-plan-table-id="' . $floorPlanTableId . '" data-bs-toggle="modal" data-bs-target="#floor_plan_table_modal" title="View Log Notes">
                                <i class="ki-outline ki-pencil fs-3 m-0 fs-5"></i>
                            </button>
                            <button class="btn btn-icon btn-light btn-active-light-danger delete-floor-plan-table" data-floor-plan-table-id="' . $floorPlanTableId . '">
                                <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary view-floor-plan-table-log-notes" data-floor-plan-table-id="' . $floorPlanTableId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $response[] = [
                'TABLE_NUMBER'  => $tableNumber,
                'SEATS'         => $seats,
                'ACTION'        => '<div class="d-flex justify-content-end gap-3">
                                        '. $logNotes .'
                                        '. $button .'
                                    </div>'
            ];
        }

        echo json_encode($response);
    }
    
    public function generateFloorPlanOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $floorPlans = $this->floorPlan->generateFloorPlanOptions();

        foreach ($floorPlans as $row) {
            $response[] = [
                'id'    => $row['floor_plan_id'],
                'text'  => $row['floor_plan_name']
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

$controller = new FloorPlanController(
    new FloorPlan(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();