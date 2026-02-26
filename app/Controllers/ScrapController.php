<?php
namespace App\Controllers;

session_start();

use App\Models\Scrap;
use App\Models\Product;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class ScrapController {
    protected Scrap $scrap;
    protected Product $product;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Scrap $scrap,
        Product $product,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->scrap    = $scrap;
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
            'insert scrap'             => $this->insertScrap($lastLogBy),
            'update scrap'             => $this->updateScrap($lastLogBy),
            'apply adjustment'                      => $this->applyScrap($lastLogBy),
            'apply multiple adjustment'             => $this->applyMultipleScrap($lastLogBy),
            'delete scrap'             => $this->deleteScrap(),
            'delete multiple scrap'    => $this->deleteMultipleScrap(),
            'fetch scrap details'      => $this->fetchScrapDetails(),
            'generate scrap table'     => $this->generateScrapTable(),
            'generate scrap options'   => $this->generateScrapOptions(),
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

    public function insertScrap(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'scrap_form')) {
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

        $scrapId = $this->scrap->insertScrap(
            $productId,
            $productName,
            $quantityOnHand,
            $inventoryCount,
            $inventoryDifference,
            $inventoryDate,
            $remarks,
            $lastLogBy
        );
        
        $encryptedScrapId = $this->security->encryptData($scrapId);

        $this->systemHelper::sendSuccessResponse(
            'Save Scrap Success',
            'The scrap has been saved successfully.',
            ['scrap_id' => $encryptedScrapId]
        );
    }

    public function updateScrap(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'scrap_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $scrapId    = $_POST['scrap_id'] ?? null;
        $inventoryDate          = $this->systemHelper->checkDate('empty', $_POST['inventory_date'] ?? null, '', 'Y-m-d', '');
        $inventoryCount         = $_POST['inventory_count'] ?? 0;
        $inventoryDifference    = $_POST['inventory_difference'] ?? 0;
        $remarks                = $_POST['remarks'] ?? null;
    
        $this->scrap->updateScrap(
            $scrapId,
            $inventoryCount,
            $inventoryDifference,
            $inventoryDate,
            $remarks,
            $lastLogBy
        );
        
        $encryptedScrapId = $this->security->encryptData($scrapId);

        $this->systemHelper::sendSuccessResponse(
            'Save Scrap Success',
            'The scrap has been saved successfully.',
            ['scrap_id' => $encryptedScrapId]
        );
    }

    /* =============================================================================================
        SECTION 3: UPDATE METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 4: FETCH METHOD
    ============================================================================================= */

    public function fetchScrapDetails() {
        $scrapId          = $_POST['scrap_id'] ?? null;
        $checkScrapExist  = $this->scrap->checkScrapExist($scrapId);
        $total                      = $checkScrapExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Scrap Details',
                'The scrap does not exist',
                ['notExist' => true]
            );
        }

        $scrapDetails = $this->scrap->fetchScrap($scrapId);

        $response = [
            'success'               => true,
            'productName'           => $scrapDetails['product_name'] ?? null,
            'quantityOnHand'        => $scrapDetails['quantity_on_hand'] ?? null,
            'inventoryCount'        => $scrapDetails['inventory_count'] ?? null,
            'inventoryDifference'   => $scrapDetails['inventory_difference'] ?? null,
            'inventoryDate'         => $this->systemHelper->checkDate('summary', $scrapDetails['inventory_date'] ?? null, '', 'M d, Y', ''),
            'remarks'               => $scrapDetails['remarks'] ?? 0
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteScrap() {
        $scrapId = $_POST['scrap_id'] ?? null;

        $this->scrap->deleteScrap($scrapId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Scrap Success',
            'The scrap has been deleted successfully.'
        );
    }

    public function deleteMultipleScrap() {
        $scrapIds = $_POST['scrap_id'] ?? null;

        foreach($scrapIds as $scrapId){
            $this->scrap->deleteScrap($scrapId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Scraps Success',
            'The selected scraps have been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateScrapTable() {
        $filterProduct                  = $this->systemHelper->checkFilter($_POST['filter_by_product'] ?? null);
        $filterScrapStatus  = $this->systemHelper->checkFilter($_POST['filter_by_scrap_status'] ?? null);
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

        $physicalInventories = $this->scrap->generateScrapTable(
            $filterProduct,
            $filterInventoryStartDate,
            $filterInventoryEndDate,
            $filterScrapStatus
        );

        foreach ($physicalInventories as $row) {
            $scrapId        = $row['scrap_id'];
            $productName                = $row['product_name'];
            $scrapStatus    = $row['scrap_status'];
            $quantityOnHand             = $row['quantity_on_hand'];
            $inventoryCount             = $row['inventory_count'];
            $inventoryDifference        = $row['inventory_difference'];
            $inventoryDate              = $this->systemHelper->checkDate('summary', $row['inventory_date'] ?? null, '', 'd M Y', '');
            $badgeClass                 = $scrapStatus == 'Applied' ? 'badge-light-success' : 'badge-light-warning';
            $textClass                  = $inventoryDifference >= 0 ? 'text-success' : 'text-danger';

            $scrapIdEncrypted = $this->security->encryptData($scrapId);

            $response[] = [
                'CHECK_BOX'                 => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                    <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $scrapId .'">
                                                </div>',
                'PRODUCT'           => $productName,
                'INVENTORY_DATE'    => $inventoryDate,
                'QUANTITY_ON_HAND'  => number_format($quantityOnHand, 4),
                'COUNTED'           => number_format($inventoryCount, 4),
                'DIFFERENCE'        => '<span class="'. $textClass .'">' . number_format($inventoryDifference, 4) . '</span>',
                'STATUS'            => '<div class="badge '. $badgeClass .'">'. $scrapStatus .'</div>',
                'LINK'              => $pageLink .'&id='. $scrapIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateScrapOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $physicalInventories = $this->scrap->generateScrapOptions();

        foreach ($physicalInventories as $row) {
            $response[] = [
                'id'    => $row['scrap_id'],
                'text'  => $row['scrap_name']
            ];
        }

        echo json_encode($response);
    }

    public function generateParentCategoryOptions() {
        $scrapId  = $_POST['scrap_id'] ?? null;
        $multiple           = $_POST['multiple'] ?? false;
        $response           = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $physicalInventories = $this->scrap->generateParentCategoryOptions($scrapId);

        foreach ($physicalInventories as $row) {
            $response[] = [
                'id'    => $row['scrap_id'],
                'text'  => $row['scrap_name']
            ];
        }

        echo json_encode($response);
    }

    /* =============================================================================================
        SECTION 8: CUSTOM METHOD
    ============================================================================================= */

    public function applyScrap(int $lastLogBy) {
        $scrapId = $_POST['scrap_id'] ?? null;

        $this->scrap->applyScrapAdjustment(
            $scrapId,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Apply Adjustment Success',
            'The adjustment has been applied successfully.'
        );
    }

    public function applyMultipleScrap(int $lastLogBy) {
        $scrapIds = $_POST['scrap_id'] ?? null;

        foreach($scrapIds as $scrapId){
            $this->scrap->applyScrapAdjustment(
                $scrapId,
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

$controller = new ScrapController(
    new Scrap(),
    new Product(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();