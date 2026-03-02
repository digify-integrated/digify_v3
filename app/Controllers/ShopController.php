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
            'delete shop'                           => $this->deleteShop(),
            'delete multiple shop'                  => $this->deleteMultipleShop(),
            'fetch shop details'                    => $this->fetchShopDetails(),
            'generate shop table'                   => $this->generateShopTable(),
            'generate shop payment method table'    => $this->generateShopPaymentMethodTable($lastLogBy, $pageId),
            'generate shop floor plan table'        => $this->generateShopFloorPlanTable($lastLogBy, $pageId),
            'generate shop access table'            => $this->generateShopAccessTable($lastLogBy, $pageId),
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

    /* =============================================================================================
        SECTION 2: INSERT METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHOD
    ============================================================================================= */

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
            $shopId     = $row['shop_id'];
            $shopName   = $row['shop_name'];
            $companyName  = $row['company_name'];
            $shopTypeName  = $row['shop_type_name'];
            $shopStatus  = $row['shop_status'];
            $registerStatus  = $row['register_status'];

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

        $writeAccess        = $this->authentication->checkUserPermission($userId, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($userId, $pageId, 'log notes')['total'] ?? 0;
        
        $shopPaymentMethods = $this->shop->generateShopPaymentMethodTable($shopId);

        foreach ($shopPaymentMethods as $row) {
            $shopPaymentMethodId    = $row['shop_payment_method_id'];
            $paymentMethodName      = $row['payment_method_name'];

            $deleteButton = '';
            if($writeAccess > 0){
                $deleteButton = '<button class="btn btn-icon btn-light btn-active-light-warning update-shop-payment-method" data-bs-toggle="modal" data-bs-target="#shop-payment-method-modal" data-shop-payment-method-id="' . $shopPaymentMethodId . '">
                                    <i class="ki-outline ki-pencil fs-3 m-0 fs-5"></i>
                                </button>
                                <button class="btn btn-icon btn-light btn-active-light-danger delete-shop-payment-method" data-shop-payment-method-id="' . $shopPaymentMethodId . '">
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
                'PAYMENT_METHOD_NAME'   => $paymentMethodName,
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
                $deleteButton = '<button class="btn btn-icon btn-light btn-active-light-warning update-shop-floor-plan" data-bs-toggle="modal" data-bs-target="#shop-floor-plan-modal" data-shop-floor-plan-id="' . $shopFloorPlanId . '">
                                    <i class="ki-outline ki-pencil fs-3 m-0 fs-5"></i>
                                </button>
                                <button class="btn btn-icon btn-light btn-active-light-danger delete-shop-floor-plan" data-shop-floor-plan-id="' . $shopFloorPlanId . '">
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

        $writeAccess        = $this->authentication->checkUserPermission($userId, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($userId, $pageId, 'log notes')['total'] ?? 0;
        
        $shopFloorPlans = $this->shop->generateShopAccessTable($shopId);

        foreach ($shopFloorPlans as $row) {
            $shopAccessId   = $row['shop_access_id'];
            $fileAs         = $row['file_as'];

            $deleteButton = '';
            if($writeAccess > 0){
                $deleteButton = '<button class="btn btn-icon btn-light btn-active-light-warning update-shop-access" data-bs-toggle="modal" data-bs-target="#shop-access-modal" data-shop-access-id="' . $shopAccessId . '">
                                    <i class="ki-outline ki-pencil fs-3 m-0 fs-5"></i>
                                </button>
                                <button class="btn btn-icon btn-light btn-active-light-danger delete-shop-access" data-shop-access-id="' . $shopAccessId . '">
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

    public function generateShopOptions() {
        $multiple       = $_POST['multiple'] ?? false;
        $shopId     = $_POST['shop_id'] ?? null;
        $response       = [];

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