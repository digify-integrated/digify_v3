<?php
namespace App\Controllers;

session_start();

use App\Models\PhysicalInventory;
use App\Models\Product;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class PhysicalInventoryController {
    protected PhysicalInventory $physicalInventory;
    protected Product $product;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        PhysicalInventory $physicalInventory,
        Product $product,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->physicalInventory    = $physicalInventory;
        $this->product              = $product;
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
            'insert physical inventory'             => $this->insertPhysicalInventory($lastLogBy),
            'update physical inventory'             => $this->updatePhysicalInventory($lastLogBy),
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

    /* =============================================================================================
        SECTION 2: INSERT METHOD
    ============================================================================================= */

    public function insertPhysicalInventory(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'physical_inventory_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId      = $_POST['product_id'] ?? null;
        $inventoryDate  = $this->systemHelper->checkDate('empty', $_POST['inventory_date'] ?? null, '', 'd M Y', '');
        $remarks        = $_POST['remarks'] ?? null;

        $productDetails     = $this->product->fetchProduct($productId);
        $productName        = $productDetails['product_name'] ?? '';
        $quantityOnHand     = $productDetails['quantity_on_hand'] ?? 0;

        $physicalInventoryId = $this->physicalInventory->insertPhysicalInventory(
            $productId,
            $productName,
            $quantityOnHand,
            $inventoryDate,
            $remarks,
            $lastLogBy
        );
        
        $encryptedPhysicalInventoryId = $this->security->encryptData($physicalInventoryId);

        $this->systemHelper::sendSuccessResponse(
            'Save Physical Inventory Success',
            'The physical inventory has been saved successfully.',
            ['physical_inventory_id' => $encryptedPhysicalInventoryId]
        );
    }

    public function updatePhysicalInventory(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'physical_inventory_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId          = $_POST['product_id'] ?? null;
        $inventoryDate      = $this->systemHelper->checkDate('empty', $_POST['inventory_date'] ?? null, '', 'd M Y', '');
        $quantityOnHand     = $_POST['quantity_on_hand'] ?? 0;
        $inventoryCount     = $_POST['inventory_count'] ?? 0;
        $remarks            = $_POST['remarks'] ?? null;
        
        $inventoryDifference = $quantityOnHand - $quantityOnHand;

        $physicalInventoryId = $this->physicalInventory->updatePhysicalInventory(
            $inventoryCount,
            $inventoryDifference,
            $inventoryDate,
            $remarks,
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
        $filterProduct                  = $this->systemHelper->checkFilter($_POST['filter_by_product'] ?? null);
        $filterInventoryStartDate       = $this->systemHelper->checkDate('empty', $_POST['filter_by_inventory_start_date'], '', 'Y-m-d', '');
        $filterInventoryEndDate         = $this->systemHelper->checkDate('empty', $_POST['filter_by_inventory_end_date'], '', 'Y-m-d', '');
        $filterPhysicalInventoryStatus  = $this->systemHelper->checkFilter($_POST['filter_by_physical_inventory_status'] ?? null);
        $pageLink                       = $_POST['page_link'] ?? null;
        $response                       = [];

        $departments = $this->physicalInventory->generatePhysicalInventoryTable(
            $filterProduct,
            $filterInventoryStartDate,
            $filterInventoryEndDate,
            $filterPhysicalInventoryStatus
        );

        foreach ($departments as $row) {
            $physicalInventoryId      = $row['physical_inventory_id'];
            $productName    = $row['product_name'];
            $physical_inventory_status     = $row['physical_inventory_status'];
            $quantity_on_hand          = $row['quantity_on_hand'];
            $inventory_count           = $row['inventory_count'];
            $inventory_difference           = $row['inventory_difference'];
            $inventory_date           = $this->systemHelper->checkDate('summary', $employeeDetails['birthday'] ?? null, '', 'd M Y', '');

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
    new Product(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();