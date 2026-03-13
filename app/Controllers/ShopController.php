<?php
namespace App\Controllers;

session_start();

use App\Models\Shop;
use App\Models\Company;
use App\Models\ShopType;
use App\Models\PaymentMethod;
use App\Models\FloorPlan;
use App\Models\UserAccount;
use App\Models\Product;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';
class ShopController {
    protected Shop $shop;
    protected Company $company;
    protected ShopType $shopType;
    protected PaymentMethod $paymentMethod;
    protected FloorPlan $floorPlan;
    protected UserAccount $userAccount;
    protected Product $product;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Shop $shop,
        Company $company,
        ShopType $shopType,
        PaymentMethod $paymentMethod,
        FloorPlan $floorPlan,
        UserAccount $userAccount,
        Product $product,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->shop             = $shop;
        $this->company          = $company;
        $this->shopType         = $shopType;
        $this->paymentMethod    = $paymentMethod;
        $this->floorPlan        = $floorPlan;
        $this->userAccount      = $userAccount;
        $this->product          = $product;
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
            'save shop'                             => $this->saveShop($lastLogBy),
            'save shop payment method'              => $this->saveShopPaymentMethod($lastLogBy),
            'save shop floor plan'                  => $this->saveShopFloorPlan($lastLogBy),
            'save shop access'                      => $this->saveShopAccess($lastLogBy),
            'save shop product'                     => $this->saveShopProduct($lastLogBy),
            'insert shop session'                   => $this->insertShopSession($lastLogBy),
            'insert shop order'                     => $this->insertShopOrder($lastLogBy),
            'update shop archive'                   => $this->updateShopArchive($lastLogBy),
            'update shop unarchive'                 => $this->updateShopUnarchive($lastLogBy),
            'delete shop'                           => $this->deleteShop(),
            'delete shop payment method'            => $this->deleteShopPaymentMethod(),
            'delete shop floor plan'                => $this->deleteShopFloorPlan(),
            'delete shop access'                    => $this->deleteShopAccess(),
            'delete shop product'                   => $this->deleteShopProduct(),
            'delete multiple shop'                  => $this->deleteMultipleShop(),
            'fetch shop details'                    => $this->fetchShopDetails(),
            'fetch shop register table details'     => $this->fetchShopRegisterTableDetails(),
            'generate shop table'                   => $this->generateShopTable(),
            'generate shop payment method table'    => $this->generateShopPaymentMethodTable($lastLogBy, $pageId),
            'generate shop floor plan table'        => $this->generateShopFloorPlanTable($lastLogBy, $pageId),
            'generate shop access table'            => $this->generateShopAccessTable($lastLogBy, $pageId),
            'generate shop product table'           => $this->generateShopProductTable($lastLogBy, $pageId),
            'generate shop register tabs'           => $this->generateShopRegisterTabs(),
            'generate shop register tables'         => $this->generateShopRegisterTables(),
            'generate shop product categories'      => $this->generateShopProductCategories(),
            'generate shop products'                => $this->generateShopProducts(),
            'generate shop options'                 => $this->generateShopOptions(),
            default                                 => $this->systemHelper::sendErrorResponse(
                                                        'Transaction Failed',
                                                        'We encountered an issue while processing your request.'
                                                    )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveShop(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'shop_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $shopId     = $_POST['shop_id'] ?? null;
        $shopName   = $_POST['shop_name'] ?? null;
        $companyId  = $_POST['company_id'] ?? null;
        $shopTypeId = $_POST['shop_type_id'] ?? null;

        $companyDetails = $this->company->fetchCompany($companyId);
        $companyName    = $companyDetails['company_name'] ?? null;

        $shopTypeDetails    = $this->shopType->fetchShopType($shopTypeId);
        $shopTypeName       = $shopTypeDetails['shop_type_name'] ?? null;

        $shopId = $this->shop->saveShop(
            $shopId,
            $shopName,
            $companyId,
            $companyName,
            $shopTypeId,
            $shopTypeName,
            $lastLogBy
        );
        
        $encryptedshopId = $this->security->encryptData($shopId);

        $this->systemHelper::sendSuccessResponse(
            'Save Shop Success',
            'The shop has been saved successfully.',
            ['shop_id' => $encryptedshopId]
        );
    }

    public function saveShopPaymentMethod(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'shop_payment_method_form')) {
            $this->systemHelper::sendErrorResponse('Invalid Request', 'Security check failed. Please refresh and try again.');
        }

        $shopId             = $_POST['shop_id'] ?? null;
        $paymentMethodIds   = $_POST['payment_method_id'] ?? [];

        if (empty($paymentMethodIds)) {
            $this->systemHelper::sendErrorResponse('Save Shop Payment Method Error', 'Please select the payment method.');
        }

        $shopDetails    = $this->shop->fetchShop($shopId);
        $shopName       = $shopDetails['shop_name'] ?? '';

        foreach ($paymentMethodIds as $paymentMethodId) {
            $paymentMethodDetails  = $this->paymentMethod->fetchPaymentMethod($paymentMethodId);
            $paymentMethodName     = $paymentMethodDetails['payment_method_name'] ?? null;

            $this->shop->insertShopPaymentMethod(
                $shopId,
                $shopName,
                $paymentMethodId,
                $paymentMethodName,
                $lastLogBy
            );
        }

        $this->systemHelper::sendSuccessResponse(
            'Save Payment Method Success',
            'The payment method has been saved successfully.'
        );
    }

    public function saveShopFloorPlan(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'shop_floor_plan_form')) {
            $this->systemHelper::sendErrorResponse('Invalid Request', 'Security check failed. Please refresh and try again.');
        }

        $shopId         = $_POST['shop_id'] ?? null;
        $floorPlanIds   = $_POST['floor_plan_id'] ?? [];

        if (empty($floorPlanIds)) {
            $this->systemHelper::sendErrorResponse('Save Shop Floor Plan Error', 'Please select the floor plan.');
        }

        $shopDetails    = $this->shop->fetchShop($shopId);
        $shopName       = $shopDetails['shop_name'] ?? '';

        foreach ($floorPlanIds as $floorPlanId) {
            $floorPlanDetails  = $this->floorPlan->fetchFloorPlan($floorPlanId);
            $floorPlanName     = $floorPlanDetails['floor_plan_name'] ?? null;

            $this->shop->insertShopFloorPlan(
                $shopId,
                $shopName,
                $floorPlanId,
                $floorPlanName,
                $lastLogBy
            );
        }

        $this->systemHelper::sendSuccessResponse(
            'Save Floor Plan Success',
            'The floor plan has been saved successfully.'
        );
    }

    public function saveShopAccess(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'shop_access_form')) {
            $this->systemHelper::sendErrorResponse('Invalid Request', 'Security check failed. Please refresh and try again.');
        }

        $shopId         = $_POST['shop_id'] ?? null;
        $userAccountIds = $_POST['user_account_id'] ?? [];

        if (empty($userAccountIds)) {
            $this->systemHelper::sendErrorResponse('Save Shop Access Error', 'Please select the user account.');
        }

        $shopDetails    = $this->shop->fetchShop($shopId);
        $shopName       = $shopDetails['shop_name'] ?? '';

        foreach ($userAccountIds as $userAccountId) {
            $userAccountDetails     = $this->userAccount->fetchUserAccount($userAccountId);
            $fileAs                 = $userAccountDetails['file_as'] ?? null;

            $this->shop->insertShopUserAccount(
                $shopId,
                $shopName,
                $userAccountId,
                $fileAs,
                $lastLogBy
            );
        }

        $this->systemHelper::sendSuccessResponse(
            'Save Access Success',
            'The access has been saved successfully.'
        );
    }

    public function saveShopProduct(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'shop_product_form')) {
            $this->systemHelper::sendErrorResponse('Invalid Request', 'Security check failed. Please refresh and try again.');
        }

        $shopId         = $_POST['shop_id'] ?? null;
        $productIds     = $_POST['product_id'] ?? [];

        if (empty($productIds)) {
            $this->systemHelper::sendErrorResponse('Save Shop Product Error', 'Please select the product.');
        }

        $shopDetails    = $this->shop->fetchShop($shopId);
        $shopName       = $shopDetails['shop_name'] ?? '';

        foreach ($productIds as $productId) {
            $productDetails     = $this->product->fetchProduct($productId);
            $productName        = $productDetails['product_name'] ?? null;

            $this->shop->insertShopProduct(
                $shopId,
                $shopName,
                $productId,
                $productName,
                $lastLogBy
            );
        }

        $this->systemHelper::sendSuccessResponse(
            'Save Product Success',
            'The product has been saved successfully.'
        );
    }

    /* =============================================================================================
        SECTION 2: INSERT METHOD
    ============================================================================================= */
   
    public function insertShopSession(
        int $lastLogBy
    ) {
        $shopId         = $_POST['shop_id'] ?? null;
        $openRemarks    = $_POST['open_remarks'] ?? null;

        $shopDetails    = $this->shop->fetchShop($shopId);
        $shopName       = $shopDetails['shop_name'] ?? '';

        $userAccountDetails = $this->userAccount->fetchUserAccount($lastLogBy);
        $fileAs             = $userAccountDetails['file_as'] ?? null;
        
        $denoms = [
            ['value' => 1000, 'field' => 'open_1000'],
            ['value' => 500,  'field' => 'open_500'],
            ['value' => 200,  'field' => 'open_200'],
            ['value' => 100,  'field' => 'open_100'],
            ['value' => 50,   'field' => 'open_50'],
            ['value' => 20,   'field' => 'open_20'],
            ['value' => 10,   'field' => 'open_10'],
            ['value' => 5,    'field' => 'open_5'],
            ['value' => 1,    'field' => 'open_1'],
            ['value' => 0.50, 'field' => 'open_0_50'],
            ['value' => 0.25, 'field' => 'open_0_25'],
            ['value' => 0.10, 'field' => 'open_0_10'],
            ['value' => 0.05, 'field' => 'open_0_05'],
            ['value' => 0.01, 'field' => 'open_0_01'],
        ];

        $shopSessionId = $this->shop->insertShopSession($shopId, $shopName, $openRemarks, $fileAs, $lastLogBy);

        foreach ($denoms as $denom) {
            $count = (int)($_POST[$denom['field']] ?? 0);

            if ($count > 0) {
                $this->shop->insertShopSessionDenomination(
                    $shopSessionId,
                    'Open',
                    $denom['value'],
                    $count,
                    $lastLogBy
                );
            }
        }

        $this->systemHelper::sendSuccessResponse(
            'Open Register Success',
            'The register has been openned successfully.'
        );
    }
   
    public function insertShopOrder(
        int $lastLogBy
    ) {
        $shopId             = $_POST['shop_id'] ?? null;
        $floorPlanTableId   = $_POST['floor_plan_table_id'] ?? null;

        $shopDetails    = $this->shop->fetchShop($shopId);
        $shopName       = $shopDetails['shop_name'] ?? '';

        $floorPlanTableDetails  = $this->floorPlan->fetchFloorPlanTable($floorPlanTableId);
        $tableNumber            = $floorPlanTableDetails['table_number'] ?? '';
        
        $shopOrderId = $this->shop->insertShopOrder($shopId, $shopName, $floorPlanTableId, $tableNumber, $lastLogBy);

        $this->systemHelper::sendSuccessResponse(
            'Open Register Success',
            'The register has been openned successfully.',
            ['shop_order_id' => $shopOrderId]
        );
    }

    /* =============================================================================================
        SECTION 3: UPDATE METHOD
    ============================================================================================= */

    public function updateShopUnarchive(
        int $lastLogBy
    ) {
        $shopId = $_POST['shop_id'] ?? null;

        $this->shop->updateShopUnarchive(
            $shopId,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Shop Unarchive Success',
            'The shop has been unarchived successfully.'
        );
    }

    public function updateShopArchive(
        int $lastLogBy
    ) {
        $shopId = $_POST['shop_id'] ?? null;

        $this->shop->updateShopArchive(
            $shopId,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Shop Archive Success',
            'The shop has been archived successfully.'
        );
    }

    /* =============================================================================================
        SECTION 4: FETCH METHOD
    ============================================================================================= */

    public function fetchShopDetails() {
        $shopId         = $_POST['shop_id'] ?? null;
        $checkShopExist = $this->shop->checkShopExist($shopId);
        $total          = $checkShopExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Shop Details',
                'The shop does not exist'
            );
        }

        $shopDetails = $this->shop->fetchShop($shopId);

        $response = [
            'success'       => true,
            'shopName'      => $shopDetails['shop_name'] ?? null,
            'companyId'     => $shopDetails['company_id'] ?? null,
            'companyName'   => $shopDetails['company_name'] ?? null,
            'shopTypeId'    => $shopDetails['shop_type_id'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchShopRegisterTableDetails() {
        $shopId             = $_POST['shop_id'] ?? null;
        $floorPlanTableId   = $_POST['floor_plan_table_id'] ?? null;

        $floorPlanTableDetails = $this->floorPlan->fetchFloorPlanTable($floorPlanTableId);

        $response = [
            'success'       => true,
            'tableNumber'   => $floorPlanTableDetails['table_number'] ?? 0,
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteShop() {
        $shopId = $_POST['shop_id'] ?? null;

        $this->shop->deleteShop($shopId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Shop Success',
            'The shop has been deleted successfully.'
        );
    }

    public function deleteMultipleShop() {
        $shopIds = $_POST['shop_id'] ?? null;

        foreach($shopIds as $shopId){
            $this->shop->deleteShop($shopId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Shops Success',
            'The selected shops have been deleted successfully.'
        );
    }

    public function deleteShopPaymentMethod() {
        $shopPaymentMethodId = $_POST['shop_payment_method_id'] ?? null;

        $this->shop->deleteShopPaymentMethod($shopPaymentMethodId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Payment Method Success',
            'The payment method has been deleted successfully.'
        );
    }

    public function deleteShopFloorPlan() {
        $shopFloorPlanId = $_POST['shop_floor_plan_id'] ?? null;

        $this->shop->deleteShopFloorPlan($shopFloorPlanId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Floor Plan Success',
            'The floor plan has been deleted successfully.'
        );
    }

    public function deleteShopAccess() {
        $shopAccessId = $_POST['shop_access_id'] ?? null;

        $this->shop->deleteShopAccess($shopAccessId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Access Success',
            'The access has been deleted successfully.'
        );
    }

    public function deleteShopProduct() {
        $shopProductId = $_POST['shop_product_id'] ?? null;

        $this->shop->deleteShopProduct($shopProductId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Product Success',
            'The product has been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateShopTable() {
        $filterByCompany        = $this->systemHelper->checkFilter($_POST['filter_by_company'] ?? null);
        $filterByShopType       = $this->systemHelper->checkFilter($_POST['filter_by_shop_type'] ?? null);
        $filterByShopStatus     = $this->systemHelper->checkFilter($_POST['filter_by_shop_status'] ?? null);
        $filterByRegisterStatus = $this->systemHelper->checkFilter($_POST['filter_by_register_status'] ?? null);
        $pageLink               = $_POST['page_link'] ?? null;
        $response               = [];

        $shops = $this->shop->generateShopTable(
            $filterByCompany,
            $filterByShopType,
            $filterByShopStatus,
            $filterByRegisterStatus
        );

        foreach ($shops as $row) {
            $shopId         = $row['shop_id'];
            $shopName       = $row['shop_name'];
            $companyName    = $row['company_name'];
            $shopTypeName   = $row['shop_type_name'];
            $shopStatus     = $row['shop_status'];
            $registerStatus = $row['register_status'];

            $shopBadge = $shopStatus == 'Active' ? '<span class="badge badge-light-success">'. $shopStatus .'</span>' : '<span class="badge badge-light-danger">'. $shopStatus .'</span>';
            $registerBadge = $registerStatus == 'Open' ? '<span class="badge badge-light-success">'. $registerStatus .'</span>' : '<span class="badge badge-light-danger">'. $registerStatus .'</span>';

            $shopIdEncrypted = $this->security->encryptData($shopId);

            $response[] = [
                'CHECK_BOX'         => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                            <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $shopId .'">
                                        </div>',
                'SHOP_NAME'         => $shopName,
                'COMPANY_NAME'      => $companyName,
                'SHOP_TYPE_NAME'    => $shopTypeName,
                'SHOP_STATUS'       => $shopBadge,
                'REGISTER_STATUS'   => $registerBadge,
                'LINK'              => $pageLink .'&id='. $shopIdEncrypted
            ];
        }

        echo json_encode($response);
    }

    public function generateShopPaymentMethodTable(
        int $userId,
        int $pageId
    ) {
        $shopId     = $_POST['shop_id'] ?? null;
        $response   = [];

        $writeAccess    = $this->authentication->checkUserPermission($userId, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess = $this->authentication->checkUserPermission($userId, $pageId, 'log notes')['total'] ?? 0;
        
        $shopPaymentMethods = $this->shop->generateShopPaymentMethodTable($shopId);

        foreach ($shopPaymentMethods as $row) {
            $shopPaymentMethodId    = $row['shop_payment_method_id'];
            $paymentMethodName      = $row['payment_method_name'];

            $deleteButton = '';
            if($writeAccess > 0){
                $deleteButton = '<button class="btn btn-icon btn-light btn-active-light-danger delete-shop-payment-method" data-shop-payment-method-id="' . $shopPaymentMethodId . '">
                                    <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                                </button>';
            }
            
            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary view-shop-payment-method-log-notes" data-shop-payment-method-id="' . $shopPaymentMethodId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                            <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                        </button>';
            }

            $response[] = [
                'PAYMENT_METHOD'   => $paymentMethodName,
                'ACTION'                => '<div class="d-flex justify-content-end gap-3">
                                                '. $logNotes .'
                                                '. $deleteButton .'
                                            </div>'
            ];
        }

        echo json_encode($response);
    }

    public function generateShopFloorPlanTable(
        int $userId,
        int $pageId
    ) {
        $shopId     = $_POST['shop_id'] ?? null;
        $response   = [];

        $writeAccess        = $this->authentication->checkUserPermission($userId, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($userId, $pageId, 'log notes')['total'] ?? 0;
        
        $shopFloorPlans = $this->shop->generateShopFloorPlanTable($shopId);

        foreach ($shopFloorPlans as $row) {
            $shopFloorPlanId    = $row['shop_floor_plan_id'];
            $floorPlanId        = $row['floor_plan_id'];
            $floorPlanName      = $row['floor_plan_name'];

            $tableCount = $this->floorPlan->fetchFloorPlanTableCount($floorPlanId)['total'] ?? 0;
            $seatCount  = $this->floorPlan->fetchFloorPlanSeatCount($floorPlanId)['total'] ?? 0;

            $deleteButton = '';
            if($writeAccess > 0){
                $deleteButton = '<button class="btn btn-icon btn-light btn-active-light-danger delete-shop-floor-plan" data-shop-floor-plan-id="' . $shopFloorPlanId . '">
                                    <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                                </button>';
            }
            
            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary view-shop-floor-plan-log-notes" data-shop-floor-plan-id="' . $shopFloorPlanId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                            <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                        </button>';
            }

            $response[] = [
                'FLOOR_PLAN_NAME'   => $floorPlanName,
                'TABLES'            => number_format($tableCount),
                'SEATS'             => number_format($seatCount),
                'ACTION'            => '<div class="d-flex justify-content-end gap-3">
                                            '. $logNotes .'
                                            '. $deleteButton .'
                                        </div>'
            ];
        }

        echo json_encode($response);
    }

    public function generateShopAccessTable(
        int $userId,
        int $pageId
    ) {
        $shopId     = $_POST['shop_id'] ?? null;
        $response   = [];

        $writeAccess    = $this->authentication->checkUserPermission($userId, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess = $this->authentication->checkUserPermission($userId, $pageId, 'log notes')['total'] ?? 0;
        
        $shopFloorPlans = $this->shop->generateShopAccessTable($shopId);

        foreach ($shopFloorPlans as $row) {
            $shopAccessId   = $row['shop_access_id'];
            $fileAs         = $row['file_as'];

            $deleteButton = '';
            if($writeAccess > 0){
                $deleteButton = '<button class="btn btn-icon btn-light btn-active-light-danger delete-shop-access" data-shop-access-id="' . $shopAccessId . '">
                                    <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                                </button>';
            }
            
            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary view-shop-access-log-notes" data-shop-access-id="' . $shopAccessId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $response[] = [
                'USER_ACCOUNT'  => $fileAs,
                'ACTION'        => '<div class="d-flex justify-content-end gap-3">
                                        '. $logNotes .'
                                        '. $deleteButton .'
                                    </div>'
            ];
        }

        echo json_encode($response);
    }

    public function generateShopProductTable(
        int $userId,
        int $pageId
    ) {
        $shopId     = $_POST['shop_id'] ?? null;
        $response   = [];

        $writeAccess    = $this->authentication->checkUserPermission($userId, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess = $this->authentication->checkUserPermission($userId, $pageId, 'log notes')['total'] ?? 0;
        
        $shopProducts = $this->shop->generateShopProductTable($shopId);

        foreach ($shopProducts as $row) {
            $shopProductId  = $row['shop_product_id'];
            $productId      = $row['product_id'];
            $productName    = $row['product_name'];

            $productDetails = $this->product->fetchProduct($productId);
            $quantityOnHand = $productDetails['quantity_on_hand'] ?? 0;
            $cost           = $productDetails['cost'] ?? 0;
            $salesPrice     = $productDetails['sales_price'] ?? 0;

            $deleteButton = '';
            if($writeAccess > 0){
                $deleteButton = '<button class="btn btn-icon btn-light btn-active-light-danger delete-shop-product" data-shop-product-id="' . $shopProductId . '">
                                    <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                                </button>';
            }
            
            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary view-shop-product-log-notes" data-shop-product-id="' . $shopProductId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $response[] = [
                'PRODUCT'       => $productName,
                'QUANTITY'      => number_format($quantityOnHand, 4),
                'SALES_PRICE'   => number_format($salesPrice, 2),
                'COST'          => number_format($cost, 2),
                'ACTION'        => '<div class="d-flex justify-content-end gap-3">
                                        '. $logNotes .'
                                        '. $deleteButton .'
                                    </div>'
            ];
        }

        echo json_encode($response);
    }
    
    public function generateShopRegisterTabs() {
        $shopId         = $_POST['reference_id'] ?? null;
        $response       = [];
        $isFirst        = true;
        $floorPlansHtml = '';

        $floorPlans = $this->shop->fetchShopFloorPlans($shopId);

        foreach ($floorPlans as $row) {
            $floorPlanId   = $row['floor_plan_id'];
            $floorPlanName = $row['floor_plan_name'];

            $tableCount = $this->floorPlan->fetchAvailableFloorPlanTableCount($floorPlanId, $shopId)['total'] ?? 0;

            $activeNav  = $isFirst ? 'active' : '';

            $floorPlansHtml .= '<div class="col-lg-2 mb-7">
                                    <a class="nav-link nav-link-border-solid btn btn-outline btn-flex 
                                    btn-active-color-primary flex-column flex-stack w-100 p-5 page-bg '. $activeNav .'"
                                    data-bs-toggle="pill"
                                    href="#floor_plan_'. $floorPlanId .'">
                                        <div>
                                            <span class="text-gray-800 fw-bold fs-2 d-block">
                                                '.htmlspecialchars($floorPlanName).'
                                            </span>

                                            <span class="text-primary fw-semibold fs-7">
                                                Available Table: '.number_format($tableCount).'
                                            </span>
                                        </div>
                                    </a>
                                </div>';

            $isFirst = false;

        }

        $response = [
            'success' => true,
            'ELEMENT' => $floorPlansHtml
        ];

        echo json_encode($response);
    }
    
    public function generateShopRegisterTables() {
        $shopId                 = $_POST['reference_id'] ?? null;
        $response               = [];
        $isFirst                = true;
        $floorPlansContentHtml  = '';

        $floorPlans = $this->shop->fetchShopFloorPlans($shopId);

        foreach ($floorPlans as $row) {
            $floorPlanId = $row['floor_plan_id'];

            $activePane = $isFirst ? 'show active' : '';

            $fetchFloorPlanTables = $this->floorPlan->fetchFloorPlanTables($floorPlanId);

            $floorPlanTableHtml = '<div class="tab-pane fade '.$activePane.'" id="floor_plan_'.$floorPlanId.'">
            <div class="row g-6 g-xl-9">';

            foreach ($fetchFloorPlanTables as $tableRow) {
                $floorPlanTableId = $tableRow['floor_plan_table_id'];
                $tableNumber      = $tableRow['table_number'] ?? 1;
                $seats            = $tableRow['seats'] ?? 1;

                $isAvailable            = $this->floorPlan->checkFloorPlanTableAvailability($floorPlanTableId, $shopId)['total'] ?? 0;
                $activeShopOrderDetails = $this->shop->fetchActiveShopOrder($shopId, $floorPlanTableId);

                $statusText  = $isAvailable == 0 ? 'Available' : 'Occupied';
                $borderClass = $isAvailable == 0 ? 'border-success' : 'border-danger';
                $badgeClass  = $isAvailable == 0 ? 'badge-light-success' : 'badge-light-danger';

                $buttonHtml = $isAvailable == 0
                    ? '<button class="btn btn-success w-100 add-shop-table-order"
                            data-shop-id="'.htmlspecialchars($shopId).'"
                            data-floor-plan-table-id="'.htmlspecialchars($floorPlanTableId).'">
                            Add Order
                    </button>'
                    : '<button class="btn btn-warning w-100 view-shop-table-orders"
                            data-shop-id="'.htmlspecialchars($shopId).'"
                            data-floor-plan-table-id="'.htmlspecialchars($floorPlanTableId).'"
                            data-shop-order-id="'.htmlspecialchars($activeShopOrderDetails['shop_order_id']).'">
                            View Orders
                    </button>';

                $floorPlanTableHtml .= '
                    <div class="col-6 col-xl-3">
                        <div class="card '.$borderClass.'">
                            <div class="card-header border-0 pt-9">
                                <div class="card-title m-0">
                                    <h3 class="card-title align-items-start flex-column">
                                        <span class="card-label fw-bold">
                                            Table No. '.number_format($tableNumber).'
                                        </span>

                                        <span class="text-gray-700 mt-1 fw-semibold fs-6">
                                            Seats: '.number_format($seats).'
                                        </span>
                                    </h3>
                                </div>

                                <div class="card-toolbar">
                                    <span class="badge '.$badgeClass.' fw-bold me-auto px-4 py-3">
                                        '.$statusText.'
                                    </span>
                                </div>
                            </div>

                            <div class="card-body px-9 pt-3 pb-9">
                                <div class="separator separator-dashed mb-7"></div>
                                '.$buttonHtml.'
                            </div>
                        </div>
                    </div>';
            }

            $floorPlanTableHtml .= '</div></div>';

            $floorPlansContentHtml .= $floorPlanTableHtml;

            $isFirst = false;
        }

        $response = [
            'success'   => true,
            'ELEMENT'   => $floorPlansContentHtml
        ];

        echo json_encode($response);
    }
    
    public function generateShopProductCategories() {
        $shopId                 = $_POST['reference_id'] ?? null;
        $response               = [];
        $productCategoriesHtml  = '<div class="col-lg-2 mb-4">
                                    <a class="nav-link nav-link-border-solid btn btn-outline btn-flex btn-active-color-primary flex-column flex-stack w-100 p-5 page-bg active product-category-filter" data-bs-toggle="pill">
                                        <div>
                                            <span class="text-gray-800 fw-bold fs-3 d-block">All</span>
                                        </div>
                                    </a>
                                </div>';

        $productCategories = $this->shop->fetchShopProductCategories($shopId);

        foreach ($productCategories as $row) {
            $productCategoryId   = $row['product_category_id'];
            $productCategoryName = $row['product_category_name'];

            $productCategoriesHtml  .= '<div class="col-lg-2 mb-4">
                                            <a class="nav-link nav-link-border-solid btn btn-outline btn-flex btn-active-color-primary flex-column flex-stack w-100 p-5 page-bg product-category-filter" data-bs-toggle="pill" data-product-filter="'. $productCategoryId .'">
                                                <div>
                                                    <span class="text-gray-800 fw-bold fs-3 d-block">'. $productCategoryName .'</span>
                                                </div>
                                            </a>
                                        </div>';

        }

        $response = [
            'success'   => true,
            'ELEMENT'   => $productCategoriesHtml
        ];

        echo json_encode($response);
    }
    
    public function generateShopProducts() {
        $shopId             = $_POST['reference_id'] ?? null;
        $productCategoryId  = $_POST['product_category_id'] ?? null;
        $response           = [];
        $productsHtml       = '';

        $products = $this->shop->fetchShopProducts($shopId, $productCategoryId);

        foreach ($products as $row) {
            $productId      = $row['product_id'];
            $productName    = $row['product_name'];
            $salesPrice     = $row['sales_price'];
            $productImage   = $this->systemHelper->checkImageExist($row['product_image'] ?? null, 'product');

            $productsHtml   .= '<div class="col-6 col-lg-3 mb-5">
                                    <div class="card card-flush flex-row-fluid p-0 w-100 border border-hover-primary cursor-pointer" class="add-product-order" data-product-id="'. $productId .'">
                                        <div class="card-body text-center">
                                            <img src="'. $productImage .'" class="rounded-3 mb-4 w-100 h-120px" alt="'. $productName .'"/>  
                                            <div class="mb-2">
                                                <div class="text-center">
                                                    <span class="fw-bold text-gray-800 fs-3 fs-xl-1">'. $productName .'</span>
                                                </div>
                                            </div>
                                            <span class="text-success text-end fw-bold fs-2">&#8369; '. number_format($salesPrice, 2) .'</span>
                                        </div>
                                    </div>
                                </div>';

        }

        $response = [
            'success'   => true,
            'ELEMENT'   => $productsHtml
        ];

        echo json_encode($response);
    }

    public function generateShopOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $shopId     = $_POST['shop_id'] ?? null;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $shops = $this->shop->generateShopOptions($shopId);

        foreach ($shops as $row) {
            $response[] = [
                'id'    => $row['shop_id'],
                'text'  => $row['shop_name']
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

$controller = new ShopController(
    new Shop(),
    new Company(),
    new ShopType(),
    new PaymentMethod(),
    new FloorPlan(),
    new UserAccount(),
    new Product(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();