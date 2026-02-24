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
            'apply adjustment'                      => $this->applyPhysicalInventory($lastLogBy),
            'apply multiple adjustment'             => $this->applyMultiplePhysicalInventory($lastLogBy),
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

        $productId              = $_POST['product_id'] ?? null;
        $inventoryDate          = $this->systemHelper->checkDate('empty', $_POST['inventory_date'] ?? null, '', 'Y-m-d', '');
        $quantityOnHand         = $_POST['quantity_on_hand'] ?? 0;
        $inventoryCount         = $_POST['inventory_count'] ?? 0;
        $inventoryDifference    = $_POST['inventory_difference'] ?? 0;
        $remarks                = $_POST['remarks'] ?? null;

        $productDetails     = $this->product->fetchProduct($productId);
        $productName        = $productDetails['product_name'] ?? '';

        $physicalInventoryId = $this->physicalInventory->insertPhysicalInventory(
            $productId,
            $productName,
            $quantityOnHand,
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

        $physicalInventoryId    = $_POST['physical_inventory_id'] ?? null;
        $inventoryDate          = $this->systemHelper->checkDate('empty', $_POST['inventory_date'] ?? null, '', 'Y-m-d', '');
        $inventoryCount         = $_POST['inventory_count'] ?? 0;
        $inventoryDifference    = $_POST['inventory_difference'] ?? 0;
        $remarks                = $_POST['remarks'] ?? null;
    
        $this->physicalInventory->updatePhysicalInventory(
            $physicalInventoryId,
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
            'productName'           => $physicalInventoryDetails['product_name'] ?? null,
            'quantityOnHand'        => $physicalInventoryDetails['quantity_on_hand'] ?? null,
            'inventoryCount'        => $physicalInventoryDetails['inventory_count'] ?? null,
            'inventoryDifference'   => $physicalInventoryDetails['inventory_difference'] ?? null,
            'inventoryDate'         => $this->systemHelper->checkDate('summary', $physicalInventoryDetails['inventory_date'] ?? null, '', 'M d, Y', ''),
            'remarks'               => $physicalInventoryDetails['remarks'] ?? 0
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
        $filterPhysicalInventoryStatus  = $this->systemHelper->checkFilter($_POST['filter_by_physical_inventory_status'] ?? null);
        $filterByInventoryDate          = $_POST['filter_by_inventory_date'] ?? null;
        $filterInventoryStartDate       = null;
        $filterInventoryEndDate         = null;
        $pageLink                       = $_POST['page_link'] ?? null;
        $response                       = [];        

        if (!empty($filterByInventoryDate)) {
            $parts = array_map('trim', explode('-', $filterByInventoryDate, 2));

            $startRaw = $parts[0] ?? '';
            $endRaw   = $parts[1] ?? '';

            $filterInventoryStartDate   = $this->systemHelper->checkDate('empty', $startRaw, '', 'Y-m-d', '');
            $filterInventoryEndDate     = $this->systemHelper->checkDate('empty', $endRaw, '', 'Y-m-d', '');
        }

        $physicalInventories = $this->physicalInventory->generatePhysicalInventoryTable(
            $filterProduct,
            $filterInventoryStartDate,
            $filterInventoryEndDate,
            $filterPhysicalInventoryStatus
        );

        foreach ($physicalInventories as $row) {
            $physicalInventoryId        = $row['physical_inventory_id'];
            $productName                = $row['product_name'];
            $physicalInventoryStatus    = $row['physical_inventory_status'];
            $quantityOnHand             = $row['quantity_on_hand'];
            $inventoryCount             = $row['inventory_count'];
            $inventoryDifference        = $row['inventory_difference'];
            $inventoryDate              = $this->systemHelper->checkDate('summary', $row['inventory_date'] ?? null, '', 'd M Y', '');
            $badgeClass                 = $physicalInventoryStatus == 'Applied' ? 'badge-light-success' : 'badge-light-warning';
            $textClass                  = $inventoryDifference >= 0 ? 'text-success' : 'text-danger';

            $physicalInventoryIdEncrypted = $this->security->encryptData($physicalInventoryId);

            $response[] = [
                'CHECK_BOX'                 => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                    <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $physicalInventoryId .'">
                                                </div>',
                'PRODUCT'           => $productName,
                'INVENTORY_DATE'    => $inventoryDate,
                'QUANTITY_ON_HAND'  => number_format($quantityOnHand, 4),
                'COUNTED'           => number_format($inventoryCount, 4),
                'DIFFERENCE'        => '<span class="'. $textClass .'">' . number_format($inventoryDifference, 4) . '</span>',
                'STATUS'            => '<div class="badge '. $badgeClass .'">'. $physicalInventoryStatus .'</div>',
                'LINK'              => $pageLink .'&id='. $physicalInventoryIdEncrypted
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

    public function applyPhysicalInventory(int $lastLogBy) {
        $physicalInventoryId = $_POST['physical_inventory_id'] ?? null;

        $this->physicalInventory->applyPhysicalInventoryAdjustment(
            $physicalInventoryId,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Apply Adjustment Success',
            'The adjustment has been applied successfully.'
        );
    }

    public function applyMultiplePhysicalInventory(int $lastLogBy) {
        $physicalInventoryIds = $_POST['physical_inventory_id'] ?? null;

        foreach($physicalInventoryIds as $physicalInventoryId){
            $this->physicalInventory->applyPhysicalInventoryAdjustment(
                $physicalInventoryId,
                $lastLogBy
            );
        }

        $this->systemHelper::sendSuccessResponse(
            'Apply Multiple Adjustments Success',
            'The selected adjustments have been applied successfully.'
        );
    }

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