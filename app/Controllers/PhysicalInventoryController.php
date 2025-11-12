<?php
namespace App\Controllers;

session_start();

use App\Models\PhysicalInventory;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class PhysicalInventoryController {
    protected PhysicalInventory $physicalInventory;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        PhysicalInventory $physicalInventory,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->physicalInventory    = $physicalInventory;
        $this->authentication       = $authentication;
        $this->security             = $security;
        $this->systemHelper         = $systemHelper;
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
            'save physical inventory'               => $this->savePhysicalInventory($lastLogBy),
            'delete physical inventory'             => $this->deletePhysicalInventory(),
            'delete multiple physical inventory'    => $this->deleteMultiplePhysicalInventory(),
            'fetch physical inventory details'      => $this->fetchPhysicalInventoryDetails(),
            'generate physical inventory table'     => $this->generatePhysicalInventoryTable(),
            'generate physical inventory options'   => $this->generatePhysicalInventoryOptions(),
            default                                 => $this->systemHelper::sendErrorResponse(
                                                            'Transaction Failed',
                                                            'We encountered an issue while processing your request.'
                                                        )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function savePhysicalInventory(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'physical_inventory_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $physicalInventoryId      = $_POST['physical_inventory_id'] ?? null;
        $physicalInventoryName    = $_POST['physical_inventory_name'] ?? null;
        $parentCategoryId       = $_POST['parent_category_id'] ?? null;
        $costingMethod          = $_POST['costing_method'] ?? null;
        $displayOrder           = $_POST['display_order'] ?? 0;

        $parentCategoryDetails  = $this->physicalInventory->fetchPhysicalInventory($parentCategoryId);
        $parentCategoryName     = $parentCategoryDetails['physical_inventory_name'] ?? '';

        $physicalInventoryId = $this->physicalInventory->savePhysicalInventory(
            $physicalInventoryId,
            $physicalInventoryName,
            $parentCategoryId,
            $parentCategoryName,
            $costingMethod,
            $displayOrder,
            $lastLogBy
        );
        
        $encryptedPhysicalInventoryId = $this->security->encryptData($physicalInventoryId);

        $this->systemHelper::sendSuccessResponse(
            'Save Physical Inventory Success',
            'The physical inventory has been saved successfully.',
            ['physical_inventory_id' => $encryptedPhysicalInventoryId]
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

    public function fetchPhysicalInventoryDetails() {
        $physicalInventoryId          = $_POST['physical_inventory_id'] ?? null;
        $checkPhysicalInventoryExist  = $this->physicalInventory->checkPhysicalInventoryExist($physicalInventoryId);
        $total                      = $checkPhysicalInventoryExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Physical Inventory Details',
                'The physical inventory does not exist',
                ['notExist' => true]
            );
        }

        $physicalInventoryDetails = $this->physicalInventory->fetchPhysicalInventory($physicalInventoryId);

        $response = [
            'success'               => true,
            'physicalInventoryName'   => $physicalInventoryDetails['physical_inventory_name'] ?? null,
            'parentCategoryId'      => $physicalInventoryDetails['parent_category_id'] ?? null,
            'costingMethod'         => $physicalInventoryDetails['costing_method'] ?? null,
            'displayOrder'          => $physicalInventoryDetails['display_order'] ?? 0
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deletePhysicalInventory() {
        $physicalInventoryId = $_POST['physical_inventory_id'] ?? null;

        $this->physicalInventory->deletePhysicalInventory($physicalInventoryId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Physical Inventory Success',
            'The physical inventory has been deleted successfully.'
        );
    }

    public function deleteMultiplePhysicalInventory() {
        $physicalInventoryIds = $_POST['physical_inventory_id'] ?? null;

        foreach($physicalInventoryIds as $physicalInventoryId){
            $this->physicalInventory->deletePhysicalInventory($physicalInventoryId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Physical Inventories Success',
            'The selected physical inventories have been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generatePhysicalInventoryTable() {
        $filterParentCategory   = $this->systemHelper->checkFilter($_POST['filter_by_parent_category'] ?? null);
        $filterCostingMethod    = $this->systemHelper->checkFilter($_POST['filter_by_costing_method'] ?? null);
        $pageLink               = $_POST['page_link'] ?? null;
        $response               = [];

        $departments = $this->physicalInventory->generatePhysicalInventoryTable(
            $filterParentCategory,
            $filterCostingMethod
        );

        foreach ($departments as $row) {
            $physicalInventoryId      = $row['physical_inventory_id'];
            $physicalInventoryName    = $row['physical_inventory_name'];
            $parentCategoryName     = $row['parent_category_name'];
            $costingMethod          = $row['costing_method'];
            $displayOrder           = $row['display_order'];

            $physicalInventoryIdEncrypted = $this->security->encryptData($physicalInventoryId);

            $response[] = [
                'CHECK_BOX'                 => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                    <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $physicalInventoryId .'">
                                                </div>',
                'PRODUCT_CATEGORY_NAME'     => $physicalInventoryName,
                'PARENT_CATEGORY_NAME'      => $parentCategoryName,
                'COSTING_METHOD'            => $costingMethod,
                'DISPLAY_ORDER'             => $displayOrder,
                'LINK'                      => $pageLink .'&id='. $physicalInventoryIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generatePhysicalInventoryOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $physicalInventories = $this->physicalInventory->generatePhysicalInventoryOptions();

        foreach ($physicalInventories as $row) {
            $response[] = [
                'id'    => $row['physical_inventory_id'],
                'text'  => $row['physical_inventory_name']
            ];
        }

        echo json_encode($response);
    }

    public function generateParentCategoryOptions() {
        $physicalInventoryId  = $_POST['physical_inventory_id'] ?? null;
        $multiple           = $_POST['multiple'] ?? false;
        $response           = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $physicalInventories = $this->physicalInventory->generateParentCategoryOptions($physicalInventoryId);

        foreach ($physicalInventories as $row) {
            $response[] = [
                'id'    => $row['physical_inventory_id'],
                'text'  => $row['physical_inventory_name']
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

$controller = new PhysicalInventoryController(
    new PhysicalInventory(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();