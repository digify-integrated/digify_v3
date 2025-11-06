<?php
namespace App\Controllers;

session_start();

use App\Models\WarehouseType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class WarehouseTypeController {
    protected WarehouseType $warehouseType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        WarehouseType $warehouseType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->warehouseType      = $warehouseType;
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
            'save warehouse type'                 => $this->saveWarehouseType($lastLogBy),
            'delete warehouse type'               => $this->deleteWarehouseType(),
            'delete multiple warehouse type'      => $this->deleteMultipleWarehouseType(),
            'fetch warehouse type details'        => $this->fetchWarehouseTypeDetails(),
            'generate warehouse type table'       => $this->generateWarehouseTypeTable(),
            'generate warehouse type options'     => $this->generateWarehouseTypeOptions(),
            default                             => $this->systemHelper::sendErrorResponse(
                                                        'Transaction Failed',
                                                        'We encountered an issue while processing your request.'
                                                    )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveWarehouseType(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'warehouse_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $warehouseTypeId    = $_POST['warehouse_type_id'] ?? null;
        $warehouseTypeName  = $_POST['warehouse_type_name'] ?? null;

        $warehouseTypeId = $this->warehouseType->saveWarehouseType(
            $warehouseTypeId,
            $warehouseTypeName,
            $lastLogBy
        );
        
        $encryptedWarehouseTypeId = $this->security->encryptData($warehouseTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Save Warehouse Type Success',
            'The warehouse type has been saved successfully.',
            ['warehouse_type_id' => $encryptedWarehouseTypeId]
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

    public function fetchWarehouseTypeDetails() {
        $warehouseTypeId            = $_POST['warehouse_type_id'] ?? null;
        $checkWarehouseTypeExist    = $this->warehouseType->checkWarehouseTypeExist($warehouseTypeId);
        $total                      = $checkWarehouseTypeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Warehouse Type Details',
                'The warehouse type does not exist',
                ['notExist' => true]
            );
        }

        $warehouseTypeDetails = $this->warehouseType->fetchWarehouseType($warehouseTypeId);

        $response = [
            'success'               => true,
            'warehouseTypeName'     => $warehouseTypeDetails['warehouse_type_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteWarehouseType() {
        $warehouseTypeId = $_POST['warehouse_type_id'] ?? null;

        $this->warehouseType->deleteWarehouseType($warehouseTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Warehouse Type Success',
            'The warehouse type has been deleted successfully.'
        );
    }

    public function deleteMultipleWarehouseType() {
        $warehouseTypeIds = $_POST['warehouse_type_id'] ?? null;

        foreach($warehouseTypeIds as $warehouseTypeId){
            $this->warehouseType->deleteWarehouseType($warehouseTypeId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Warehouse Types Success',
            'The selected warehouse types have been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateWarehouseTypeTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $warehouseTypes = $this->warehouseType->generateWarehouseTypeTable();

        foreach ($warehouseTypes as $row) {
            $warehouseTypeId    = $row['warehouse_type_id'];
            $warehouseTypeName  = $row['warehouse_type_name'];

            $warehouseTypeIdEncrypted = $this->security->encryptData($warehouseTypeId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $warehouseTypeId .'">
                                            </div>',
                'ADDRESS_TYPE_NAME'     => $warehouseTypeName,
                'LINK'                  => $pageLink .'&id='. $warehouseTypeIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateWarehouseTypeOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $countries = $this->warehouseType->generateWarehouseTypeOptions();

        foreach ($countries as $row) {
            $response[] = [
                'id'    => $row['warehouse_type_id'],
                'text'  => $row['warehouse_type_name']
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

$controller = new WarehouseTypeController(
    new WarehouseType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();