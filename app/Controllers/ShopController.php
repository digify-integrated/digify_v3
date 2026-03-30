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
use App\Models\DiscountType;
use App\Models\ChargeType;
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
    protected DiscountType $discountType;
    protected ChargeType $chargeType;
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
        DiscountType $discountType,
        ChargeType $chargeType,
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
        $this->discountType     = $discountType;
        $this->chargeType       = $chargeType;
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
            'save shop discounts'                   => $this->saveShopDiscounts($lastLogBy),
            'save shop charges'                     => $this->saveShopCharges($lastLogBy),
            'save shop order discount'              => $this->saveShopOrderDiscount($lastLogBy),
            'save shop order charge'                => $this->saveShopOrderCharge($lastLogBy),
            'insert shop session'                   => $this->insertShopSession($lastLogBy),
            'insert shop order'                     => $this->insertShopOrder($lastLogBy),
            'insert shop order product'             => $this->insertShopOrderProduct($lastLogBy),
            'update shop archive'                   => $this->updateShopArchive($lastLogBy),
            'update shop unarchive'                 => $this->updateShopUnarchive($lastLogBy),
            'update shop order table'               => $this->updateShopOrderTable($lastLogBy),
            'update shop order tab'                 => $this->updateShopOrderTab($lastLogBy),
            'update shop order to cancel'           => $this->updateShopOrderToCancel($lastLogBy),
            'update shop order preset'              => $this->updateShopOrderPreset($lastLogBy),
            'update shop order note'                => $this->updateShopOrderNote($lastLogBy),
            'update shop order quantity'            => $this->updateShopOrderQuantity($lastLogBy),
            'delete shop'                           => $this->deleteShop(),
            'delete shop payment method'            => $this->deleteShopPaymentMethod(),
            'delete shop floor plan'                => $this->deleteShopFloorPlan(),
            'delete shop access'                    => $this->deleteShopAccess(),
            'delete shop product'                   => $this->deleteShopProduct(),
            'delete shop discounts'                 => $this->deleteShopDiscounts(),
            'delete shop charges'                   => $this->deleteShopCharges(),
            'delete multiple shop'                  => $this->deleteMultipleShop(),
            'delete shop order details'             => $this->deleteShopOrderDetails($lastLogBy),
            'fetch shop details'                    => $this->fetchShopDetails(),
            'fetch shop register table details'     => $this->fetchShopRegisterTableDetails(),
            'fetch shop order total'                => $this->fetchShopOrderTotal(),
            'fetch shop order details'              => $this->fetchShopOrderDetailDetails(),
            'fetch shop order discount details'     => $this->fetchShopOrdeDiscountDetails(),
            'generate shop table'                   => $this->generateShopTable(),
            'generate shop payment method table'    => $this->generateShopPaymentMethodTable($lastLogBy, $pageId),
            'generate shop floor plan table'        => $this->generateShopFloorPlanTable($lastLogBy, $pageId),
            'generate shop access table'            => $this->generateShopAccessTable($lastLogBy, $pageId),
            'generate shop product table'           => $this->generateShopProductTable($lastLogBy, $pageId),
            'generate shop discounts table'         => $this->generateShopDiscountsTable($lastLogBy, $pageId),
            'generate shop charges table'           => $this->generateShopChargesTable($lastLogBy, $pageId),
            'generate shop register tabs'           => $this->generateShopRegisterTabs(),
            'generate shop register tables'         => $this->generateShopRegisterTables(),
            'generate shop product categories'      => $this->generateShopProductCategories(),
            'generate shop products'                => $this->generateShopProducts(),
            'generate shop order list'              => $this->generateShopOrderList(),
            'generate shop discounts list'          => $this->generateShopDiscountList(),
            'generate shop charges list'            => $this->generateShopChargeList(),
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
            'Save Shop Payment Method Success',
            'The shop payment method has been saved successfully.'
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
            'Save Shop Floor Plan Success',
            'The shop floor plan has been saved successfully.'
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
            'Save Shop Access Success',
            'The shop access has been saved successfully.'
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
            $this->systemHelper::sendErrorResponse('Save Shop Product Error', 'Please select the shop product.');
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
            'Save Shop Product Success',
            'The shop product has been saved successfully.'
        );
    }

    public function saveShopDiscounts(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'shop_discounts_form')) {
            $this->systemHelper::sendErrorResponse('Invalid Request', 'Security check failed. Please refresh and try again.');
        }

        $shopId             = $_POST['shop_id'] ?? null;
        $discountTypeIds    = $_POST['discount_type_id'] ?? [];

        if (empty($discountTypeIds)) {
            $this->systemHelper::sendErrorResponse('Save Shop Discounts Error', 'Please select the discounts.');
        }

        $shopDetails    = $this->shop->fetchShop($shopId);
        $shopName       = $shopDetails['shop_name'] ?? '';
        

        foreach ($discountTypeIds as $discountTypeId) {
            $discountTypeDetails    = $this->discountType->fetchDiscountType($discountTypeId);
            $discountTypeName       = $discountTypeDetails['discount_type_name'] ?? '';

            $this->shop->insertShopDiscounts(
                $shopId,
                $shopName,
                $discountTypeId,
                $discountTypeName,
                $lastLogBy
            );
        }

        $this->systemHelper::sendSuccessResponse(
            'Save Shop Discounts Success',
            'The shop discounts has been saved successfully.'
        );
    }

    public function saveShopCharges(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'shop_charges_form')) {
            $this->systemHelper::sendErrorResponse('Invalid Request', 'Security check failed. Please refresh and try again.');
        }

        $shopId         = $_POST['shop_id'] ?? null;
        $chargeTypeIds  = $_POST['charge_type_id'] ?? [];

        if (empty($chargeTypeIds)) {
            $this->systemHelper::sendErrorResponse('Save Shop Charges Error', 'Please select the charges.');
        }

        $shopDetails    = $this->shop->fetchShop($shopId);
        $shopName       = $shopDetails['shop_name'] ?? '';

        foreach ($chargeTypeIds as $chargeTypeId) {
            $chargeTypeDetails  = $this->chargeType->fetchChargeType($chargeTypeId);
            $chargeTypeName     = $chargeTypeDetails['charge_type_name'] ?? '';

            $this->shop->insertShopCharges(
                $shopId,
                $shopName,
                $chargeTypeId,
                $chargeTypeName,
                $lastLogBy
            );
        }

        $this->systemHelper::sendSuccessResponse(
            'Save Shop Charges Success',
            'The shop charges has been saved successfully.'
        );
    }

    public function saveShopOrderDiscount(
        int $lastLogBy
    ) {
        $shopOrderId    = $_POST['shop_order_id'] ?? null;
        $discountTypeId = $_POST['discount_type_id'] ?? null;
        $isApplied      = $_POST['is_applied'] ?? null;
        $appliedValue   = $_POST['value'] ?? 0;
        $remarks        = $_POST['remarks'] ?? null;

        if ($isApplied && $appliedValue > 0) {

            $order = $this->shop->fetchShopOrderTotal($shopOrderId);

            $discountType = $this->discountType->fetchDiscountType($discountTypeId);

            $base = ($discountType['application_order'] === 'Before Tax')
                ? $order['vat_sales']
                : $order['gross_sales'];

            if ($discountType['value_type'] === 'Percentage') {
                $calculatedAmount = round(($appliedValue / 100) * $base, 2);
            } else {
                $calculatedAmount = round($appliedValue, 2);
            }

            $this->shop->insertShopOrderAppliedDiscounts(
                $shopOrderId,
                $discountTypeId,
                $discountType['discount_type_name'],
                $appliedValue,
                $calculatedAmount,
                $discountType['value_type'],
                $discountType['application_order'],
                $discountType['is_vat_exempt'],
                $remarks,
                $lastLogBy
            );

        } else {
            $this->shop->deleteShopOrderAppliedDiscounts(
                $shopOrderId,
                $discountTypeId
            );
        }

        $this->shop->updateShopOrderTotal($shopOrderId, $lastLogBy);

        $this->systemHelper::sendSuccessResponse(
            'Save Shop Charges Success',
            'The shop charges has been saved successfully.'
        );
    }

    public function saveShopOrderCharge(
        int $lastLogBy
    ) {
        $shopOrderId  = $_POST['shop_order_id'] ?? null;
        $chargeTypeId = $_POST['charge_type_id'] ?? null;
        $isApplied    = $_POST['is_applied'] ?? null;
        $appliedValue = $_POST['value'] ?? 0;
        $remarks      = $_POST['remarks'] ?? null;

        if ($isApplied && $appliedValue > 0) {

            $order = $this->shop->fetchShopOrderTotal($shopOrderId);

            $chargeType = $this->chargeType->fetchChargeType($chargeTypeId);

            $base = ($chargeType['application_order'] === 'Before Tax')
                ? $order['vat_sales']
                : $order['gross_sales'];

            if ($chargeType['value_type'] === 'Percentage') {
                $calculatedAmount = round(($appliedValue / 100) * $base, 2);
            } else {
                $calculatedAmount = round($appliedValue, 2);
            }

            $this->shop->insertShopOrderAppliedCharges(
                $shopOrderId,
                $chargeTypeId,
                $chargeType['charge_type_name'],
                $appliedValue,
                $calculatedAmount,
                $chargeType['value_type'],
                $chargeType['application_order'],
                $chargeType['tax_type'],
                $remarks,
                $lastLogBy
            );

        } else {
            $this->shop->deleteShopOrderAppliedCharges(
                $shopOrderId,
                $chargeTypeId
            );
        }

        $this->shop->updateShopOrderTotal($shopOrderId, $lastLogBy);

        $this->systemHelper::sendSuccessResponse(
            'Save Shop Charges Success',
            'The shop charges has been saved successfully.'
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
        
        $shopOrderId = $this->shop->insertShopOrder(
            $shopId,
            $shopName,
            $floorPlanTableId,
            $tableNumber,
            null,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            '',
            '',
            ['shop_order_id' => $shopOrderId]
        );
    }
   
    public function insertShopOrderProduct(
        int $lastLogBy
    ) {
        $shopId         = $_POST['shop_id'] ?? null;
        $productId      = $_POST['product_id'] ?? null;
        $shopOrderId    = $_POST['shop_order_id'] ?? null;

        if (empty($shopOrderId)) {            
            $shopName = $this->shop->fetchShop($shopId)['shop_name'] ?? '';

            $shopOrderId = $this->shop->insertShopOrder(
                $shopId,
                $shopName,
                null,
                null,
                null,
                $lastLogBy
            );
        }

        $productDetails = $this->product->fetchProduct($productId);
        $productName    = $productDetails['product_name'] ?? '';
        $basePrice      = $productDetails['sales_price'] ?? 0;

        $inclusiveRate = $this->product->fetchProductTotalTaxRate($productId, 'Inclusive')['total'] ?? 0;
        $additiveRate  = $this->product->fetchProductTotalTaxRate($productId, 'Additive')['total'] ?? 0;

        $check = $this->shop->checkShopOrderProductExist($shopOrderId, $productId)['total'] ?? 0;

        if ($check > 0) {
            $details  = $this->shop->fetchShopOrderDetailsByProduct($shopOrderId, $productId);

            $quantity = ($details['quantity'] ?? 0) + 1;
            $basePrice = $details['base_price'];
        }
        else {
            $quantity = 1;
        }

        $amounts = $this->computeItemAmounts(
            $basePrice,
            $quantity,
            $inclusiveRate,
            $additiveRate
        );

        if ($check > 0) {
            $this->shop->updateShopOrderDetail(
                $shopOrderId,
                $productId,
                $quantity,
                $basePrice,
                $inclusiveRate,
                $additiveRate,
                $amounts['subtotal'],
                $amounts['inclusive_tax'],
                $amounts['additive_tax'],
                $amounts['net_sales'],
                $lastLogBy
            );
        }
        else {
            $this->shop->insertShopOrderDetail(
                $shopOrderId,
                $productId,
                $productName,
                $quantity,
                $basePrice,
                $inclusiveRate,
                $additiveRate,
                $amounts['subtotal'],
                $amounts['inclusive_tax'],
                $amounts['additive_tax'],
                $amounts['net_sales'],
                $lastLogBy
            );
        }

        $this->shop->updateShopOrderTotal(
            $shopOrderId,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            '',
            '',
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

    public function updateShopOrderTable(
        int $lastLogBy
    ) {
        $floorPlanTableId   = $_POST['floor_plan_table_id'] ?? null;
        $shopOrderId        = $_POST['shop_order_id'] ?? null;

        $floorPlanTableDetails  = $this->floorPlan->fetchFloorPlanTable($floorPlanTableId);
        $tableNumber            = $floorPlanTableDetails['table_number'] ?? '';
        
        $this->shop->updateShopOrderTable(
            $shopOrderId,
            $floorPlanTableId,
            $tableNumber,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            '',
            ''
        );
    }
   
    public function updateShopOrderTab(
        int $lastLogBy
    ) {
        $shopOrderId    = $_POST['shop_order_id'] ?? null;
        $orderFor       = $_POST['order_for'] ?? null;
        
        $this->shop->updateShopOrderTab(
            $shopOrderId,
            $orderFor,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            '',
            ''
        );
    }
   
    public function updateShopOrderToCancel(
        int $lastLogBy
    ) {
        $shopOrderId        = $_POST['shop_order_id'] ?? null;
        $cancelledReason    = $_POST['cancelled_reason'] ?? null;
        
        $this->shop->updateShopOrderToCancel(
            $shopOrderId,
            $cancelledReason,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            '',
            ''
        );
    }
   
    public function updateShopOrderPreset(
        int $lastLogBy
    ) {
        $shopOrderId    = $_POST['shop_order_id'] ?? null;
        $orderPreset    = $_POST['order_preset'] ?? null;
        
        $this->shop->updateShopOrderPreset(
            $shopOrderId,
            $orderPreset,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            '',
            ''
        );
    }
   
    public function updateShopOrderNote(
        int $lastLogBy
    ) {
        $shopOrderDetailsId = $_POST['shop_order_details_id'] ?? null;
        $note               = $_POST['note'] ?? null;

        $this->shop->updateShopOrderNote(
            $shopOrderDetailsId,
            $note,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            '',
            ''
        );
    }
   
    public function updateShopOrderQuantity(
        int $lastLogBy
    ) {
        $shopOrderDetailsId = $_POST['shop_order_details_id'] ?? null;
        $quantity           = $_POST['quantity'] ?? 0;

        $details        = $this->shop->fetchShopOrderDetailDetails($shopOrderDetailsId);
        $shopOrderId    = $details['shop_order_id'];
        $productId      = $details['product_id'];

        $productDetails = $this->product->fetchProduct($productId);
        $basePrice      = $productDetails['sales_price'] ?? 0;

        $inclusiveRate = $this->product->fetchProductTotalTaxRate($productId, 'Inclusive')['total'] ?? 0;
        $additiveRate  = $this->product->fetchProductTotalTaxRate($productId, 'Additive')['total'] ?? 0;

        $amounts = $this->computeItemAmounts(
            $basePrice,
            $quantity,
            $inclusiveRate,
            $additiveRate
        );

        if($quantity > 0){
            $this->shop->updateShopOrderDetail(
                $shopOrderId,
                $productId,
                $quantity,
                $basePrice,
                $inclusiveRate,
                $additiveRate,
                $amounts['subtotal'],
                $amounts['inclusive_tax'],
                $amounts['additive_tax'],
                $amounts['net_sales'],
                $lastLogBy
            );
        }

        $this->shop->updateShopOrderTotal(
            $shopOrderId,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            '',
            ''
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
        $shopOrderId = $_POST['shop_order_id'] ?? null;

        $shopOrderDetails = $this->shop->fetchShopOrderDetails($shopOrderId);
        $tableNumber = $shopOrderDetails['table_number'] ?? null;
        $orderFor = $shopOrderDetails['order_for'] ?? null;
        $orderPreset = $shopOrderDetails['order_preset'] ?? 'On-Site';

        $title = '';

        if(!empty($tableNumber)){
            $title = 'Table No. ' . $tableNumber;
        }

        if(!empty($orderFor)){
            $title = 'Order For: ' . $orderFor;
        }

        $response = [
            'success'       => true,
            'title'         => $title,
            'tableNumber'   => $tableNumber,
            'orderFor'      => $orderFor,
            'orderPreset'   => $orderPreset
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchShopOrderDetailDetails() {
        $shopOrderDetailsId = $_POST['shop_order_details_id'] ?? null;

        $shopOrderDetailDetails = $this->shop->fetchShopOrderDetailDetails($shopOrderDetailsId);
        $quantity               = $shopOrderDetailDetails['quantity'] ?? 0;
        $discountType           = $shopOrderDetailDetails['discount_type'] ?? '';
        $discountValue          = $shopOrderDetailDetails['discount_value'] ?? 0;
        $note                   = $shopOrderDetailDetails['note'] ?? '';

        $response = [
            'success'       => true,
            'quantity'      => $quantity,
            'discountType'  => $discountType,
            'discountValue' => $discountValue,
            'note'          => $note
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchShopOrdeDiscountDetails() {
        $shopOrderId = $_POST['shop_order_id'] ?? null;

        $shopOrderDetails           = $this->shop->fetchShopOrderDetails($shopOrderId);
        $transactionDiscountType    = $shopOrderDetails['transaction_discount_type'] ?? '';
        $transactionDiscountValue   = $shopOrderDetails['transaction_discount_value'] ?? 0;

        $response = [
            'success'                   => true,
            'transactionDiscountType'   => $transactionDiscountType,
            'transactionDiscountValue'  => $transactionDiscountValue
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchShopOrderTotal() { 
        $shopOrderId = $_POST['shop_order_id'] ?? null;

        $order = $this->shop->fetchShopOrderTotal($shopOrderId);

        // Fetch breakdowns
        $charges = $this->shop->fetchOrderCharges($shopOrderId) ?? [];
        $discounts = $this->shop->fetchOrderDiscounts($shopOrderId) ?? [];

        $response = [
            'success' => true,

            // 🔹 SAFE ACCESS
            'subtotal'   => isset($order['gross_sales']) ? (float)$order['gross_sales'] : 0,
            'vat_sales'  => isset($order['vat_sales']) ? (float)$order['vat_sales'] : 0,
            'vat_amount' => isset($order['vat_amount']) ? (float)$order['vat_amount'] : 0,
            'total'      => isset($order['total_amount_due']) ? (float)$order['total_amount_due'] : 0,

            'charges'    => $charges,
            'discounts'  => $discounts
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

    public function deleteShopDiscounts() {
        $shopDiscountsId = $_POST['shop_discounts_id'] ?? null;

        $this->shop->deleteShopDiscounts($shopDiscountsId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Discount Success',
            'The discount has been deleted successfully.'
        );
    }

    public function deleteShopCharges() {
        $shopChargesId = $_POST['shop_charges_id'] ?? null;

        $this->shop->deleteShopCharges($shopChargesId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Charge Success',
            'The charge has been deleted successfully.'
        );
    }

    public function deleteShopOrderDetails(
        int $lastLogBy
    ) {
        $shopOrderDetailsId = $_POST['shop_order_details_id'] ?? null;

        $details        = $this->shop->fetchShopOrderDetailDetails($shopOrderDetailsId);
        $shopOrderId    = $details['shop_order_id'];

        $this->shop->deleteShopOrderDetails($shopOrderDetailsId);

        $this->shop->updateShopOrderTotal(
            $shopOrderId,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            '',
            ''
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

    public function generateShopDiscountsTable(
        int $userId,
        int $pageId
    ) {
        $shopId     = $_POST['shop_id'] ?? null;
        $response   = [];

        $writeAccess    = $this->authentication->checkUserPermission($userId, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess = $this->authentication->checkUserPermission($userId, $pageId, 'log notes')['total'] ?? 0;
        
        $shopDiscounts = $this->shop->generateShopDiscountsTable($shopId);

        foreach ($shopDiscounts as $row) {
            $shopDiscountsId    = $row['shop_discounts_id'];
            $discountTypeId     = $row['discount_type_id'];
            $discountTypeName   = $row['discount_type_name'];

            $discountTypeDetails    = $this->discountType->fetchDiscountType($discountTypeId);
            $valueType              = $discountTypeDetails['value_type'] ?? 0;
            $discountValue          = $discountTypeDetails['discount_value'] ?? 0;

            $deleteButton = '';
            if($writeAccess > 0){
                $deleteButton = '<button class="btn btn-icon btn-light btn-active-light-danger delete-shop-discounts" data-shop-discounts-id="' . $shopDiscountsId . '">
                                    <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                                </button>';
            }
            
            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary view-shop-discounts-log-notes" data-shop-discounts-id="' . $shopDiscountsId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $response[] = [
                'DISCOUNT'          => $discountTypeName,
                'VALUE_TYPE'        => $valueType,
                'DISCOUNT_VALUE'    => number_format($discountValue, 2),
                'ACTION'            => '<div class="d-flex justify-content-end gap-3">
                                            '. $logNotes .'
                                            '. $deleteButton .'
                                        </div>'
            ];
        }

        echo json_encode($response);
    }

    public function generateShopChargesTable(
        int $userId,
        int $pageId
    ) {
        $shopId     = $_POST['shop_id'] ?? null;
        $response   = [];

        $writeAccess    = $this->authentication->checkUserPermission($userId, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess = $this->authentication->checkUserPermission($userId, $pageId, 'log notes')['total'] ?? 0;
        
        $shopCharges = $this->shop->generateShopChargesTable($shopId);

        foreach ($shopCharges as $row) {
            $shopChargesId  = $row['shop_charges_id'];
            $chargeTypeId   = $row['charge_type_id'];
            $chargeTypeName = $row['charge_type_name'];

            $chargeTypeDetails  = $this->chargeType->fetchChargeType($chargeTypeId);
            $valueType          = $chargeTypeDetails['value_type'] ?? 0;
            $chargeValue        = $chargeTypeDetails['charge_value'] ?? 0;

            $deleteButton = '';
            if($writeAccess > 0){
                $deleteButton = '<button class="btn btn-icon btn-light btn-active-light-danger delete-shop-charges" data-shop-charges-id="' . $shopChargesId . '">
                                    <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                                </button>';
            }
            
            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary view-shop-charges-log-notes" data-shop-charges-id="' . $shopChargesId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $response[] = [
                'CHARGES'       => $chargeTypeName,
                'VALUE_TYPE'    => $valueType,
                'CHARGE_VALUE'  => number_format($chargeValue, 2),
                'ACTION'        => '<div class="d-flex justify-content-end gap-3">
                                        '. $logNotes .'
                                        '. $deleteButton .'
                                    </div>'
            ];
        }

        echo json_encode($response);
    }
    
    public function generateShopRegisterTabs() {
        $shopId = $_POST['shop_id'] ?? null;
        $floorPlans = $this->shop->fetchShopFloorPlans($shopId);
        $data = [];

        foreach ($floorPlans as $row) {
            $floorPlanId = $row['floor_plan_id'];
            
            // Fetch the count
            $countData = $this->floorPlan->fetchAvailableFloorPlanTableCount($floorPlanId, $shopId);
            
            $data[] = [
                'id'    => $floorPlanId,
                'name'  => $row['floor_plan_name'],
                'count' => (int)($countData['total'] ?? 0)
            ];
        }

        echo json_encode([
            'success'    => true,
            'floorPlans' => $data
        ]);
    }
    
    public function generateShopDiscountList() {
        $shopId = $_POST['shop_id'] ?? null;
        $shopOrderId = $_POST['shop_order_id'] ?? null;

        $shopDiscounts = $this->shop->fetchShopDiscounts($shopId);
        $data = [];

        foreach ($shopDiscounts as $row) {
            $discountTypeId = $row['discount_type_id'];

            $discountType = $this->discountType->fetchDiscountType($discountTypeId);

            // 🔹 Check if already applied
            $applied = $this->shop->fetchAppliedDiscount($shopOrderId, $discountTypeId);

            // 🔥 VALUE LOGIC
            $appliedValue = $applied['applied_value'] 
                ?? $discountType['discount_value'];

            $isApplied = $applied['applied_value'] ?? 0 > 0 ? true : false;

            $data[] = [
                'discountTypeId'   => $discountTypeId,
                'discountName'     => $discountType['discount_type_name'],
                'valueType'        => $discountType['value_type'],
                'discountValue'    => $discountType['discount_value'],
                'appliedValue'     => $appliedValue,
                'isVariable'       => $discountType['is_variable'],
                'isApplied'        => $isApplied
            ];
        }

        echo json_encode([
            'success' => true,
            'discounts' => $data
        ]);
    }
    
    public function generateShopChargeList() {
        $shopId = $_POST['shop_id'] ?? null;
        $shopOrderId = $_POST['shop_order_id'] ?? null;

        $shopCharges = $this->shop->fetchShopCharges($shopId);
        $data = [];

        foreach ($shopCharges as $row) {
            $chargeTypeId = $row['charge_type_id'];

            $chargeType = $this->chargeType->fetchChargeType($chargeTypeId);

            // 🔹 Check if already applied
            $applied = $this->shop->fetchAppliedCharge($shopOrderId, $chargeTypeId);

            // 🔥 VALUE LOGIC
            $appliedValue = $applied['applied_value'] 
                ?? $chargeType['charge_value'];

            $isApplied = $applied['applied_value'] ?? 0 > 0 ? true : false;

            $data[] = [
                'chargeTypeId'  => $chargeTypeId,
                'chargeName'    => $chargeType['charge_type_name'],
                'valueType'     => $chargeType['value_type'],
                'chargeValue'   => $chargeType['charge_value'],
                'appliedValue'  => $appliedValue,
                'isVariable'    => $chargeType['is_variable'],
                'isApplied'     => $isApplied
            ];
        }

        echo json_encode([
            'success' => true,
            'charges' => $data
        ]);
    }
    
    public function generateShopRegisterTables() {
        $shopId = $_POST['shop_id'] ?? null;
        $floorPlans = $this->shop->fetchShopFloorPlans($shopId);
        $output = [];

        foreach ($floorPlans as $row) {
            $floorPlanId = $row['floor_plan_id'];
            $tables = $this->floorPlan->fetchFloorPlanTables($floorPlanId);
            $tableData = [];

            foreach ($tables as $tableRow) {
                $tableId = $tableRow['floor_plan_table_id'];
                $isAvailable = ($this->floorPlan->checkFloorPlanTableAvailability($tableId, $shopId)['total'] ?? 0) == 0;
                $activeOrder = $this->shop->fetchActiveShopOrder($shopId, $tableId);

                $tableData[] = [
                    'id'           => $tableId,
                    'number'       => $tableRow['table_number'] ?? 1,
                    'seats'        => $tableRow['seats'] ?? 1,
                    'isAvailable'  => $isAvailable,
                    'shopOrderId'  => $activeOrder['shop_order_id'] ?? null
                ];
            }

            $output[] = [
                'floorPlanId'   => $floorPlanId,
                'tables'        => $tableData
            ];
        }

        echo json_encode([
            'success'    => true,
            'floorPlans' => $output,
            'shopId'     => $shopId
        ]);
    }
    
    public function generateShopProductCategories() {
        $shopId = $_POST['shop_id'] ?? null;
        $categories = $this->shop->fetchShopProductCategories($shopId);
        
        $data = [];
        foreach ($categories as $row) {
            $data[] = [
                'id'   => $row['product_category_id'],
                'name' => $row['product_category_name']
            ];
        }

        echo json_encode([
            'success'    => true,
            'categories' => $data
        ]);
    }
    
    public function generateShopProducts() {
        $shopId = $_POST['shop_id'] ?? null;
        $catId  = $_POST['product_category_id'] ?? '';

        if ($catId === 'null' || $catId === '') {
            $productCategoryId = null; 
        } else {
            $productCategoryId = $catId;
        }
        
        $products = $this->shop->fetchShopProducts($shopId, $productCategoryId);
        $data = [];

        foreach ($products as $row) {
            $data[] = [
                'id'    => $row['product_id'],
                'name'  => $row['product_name'],
                'price' => (float)$row['sales_price'],
                'formatted_price' => number_format($row['sales_price'], 2),
                'image' => $this->systemHelper->checkImageExist($row['product_image'] ?? null, 'product')
            ];
        }

        echo json_encode([
            'success'  => true,
            'products' => $data,
            'shopId'   => $shopId
        ]);
    }
    
    public function generateShopOrderList() {
        $shopOrderId = $_POST['shop_order_id'] ?? null;
        $orders = $this->shop->fetchShopOrderList($shopOrderId);

        foreach ($orders as &$row) {
            $row['formatted_total'] = number_format($row['subtotal'], 2);
            $row['formatted_qty'] = number_format($row['quantity'], 2);
        }

        echo json_encode([
            'success' => true,
            'orders'  => $orders
        ]);
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

    private function computeItemAmounts($basePrice, $quantity, $inclusiveRate, $additiveRate) {
        $subtotal = round($basePrice * $quantity, 2);

        if ($inclusiveRate > 0) {
            $inclusiveTaxAmount = round(
                ($subtotal * $inclusiveRate) / (1 + $inclusiveRate),
                2
            );
        } else {
            $inclusiveTaxAmount = 0;
        }

        $netSales = round($subtotal - $inclusiveTaxAmount, 2);

        $additiveTaxAmount = round($netSales * $additiveRate, 2);

        return [
            'subtotal' => $subtotal,
            'inclusive_tax' => $inclusiveTaxAmount,
            'net_sales' => $netSales,
            'additive_tax' => $additiveTaxAmount
        ];
    }

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
    new DiscountType(),
    new ChargeType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();