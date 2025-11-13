<?php
namespace App\Controllers;

session_start();

use App\Models\ProductCategory;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class ProductCategoryController {
    protected ProductCategory $productCategory;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        ProductCategory $productCategory,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->productCategory  = $productCategory;
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
            'save product category'                 => $this->saveProductCategory($lastLogBy),
            'delete product category'               => $this->deleteProductCategory(),
            'delete multiple product category'      => $this->deleteMultipleProductCategory(),
            'fetch product category details'        => $this->fetchProductCategoryDetails(),
            'generate product category table'       => $this->generateProductCategoryTable(),
            'generate product category options'     => $this->generateProductCategoryOptions(),
            'generate parent category options'      => $this->generateParentCategoryOptions(),
            default                                 => $this->systemHelper::sendErrorResponse(
                                                            'Transaction Failed',
                                                            'We encountered an issue while processing your request.'
                                                        )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveProductCategory(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_category_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productCategoryId      = $_POST['product_category_id'];
        $productCategoryName    = $_POST['product_category_name'] ?? null;
        $parentCategoryId       = $_POST['parent_category_id'] ?? null;
        $costingMethod          = $_POST['costing_method'] ?? null;
        $displayOrder           = $_POST['display_order'] ?? 0;

        $parentCategoryDetails  = $this->productCategory->fetchProductCategory($parentCategoryId);
        $parentCategoryName     = $parentCategoryDetails['product_category_name'] ?? '';

        $productCategoryId = $this->productCategory->saveProductCategory(
            $productCategoryId,
            $productCategoryName,
            $parentCategoryId,
            $parentCategoryName,
            $costingMethod,
            $displayOrder,
            $lastLogBy
        );
        
        $encryptedProductCategoryId = $this->security->encryptData($productCategoryId);

        $this->systemHelper::sendSuccessResponse(
            'Save Product Category Success',
            'The product category has been saved successfully.',
            ['product_category_id' => $encryptedProductCategoryId]
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

    public function fetchProductCategoryDetails() {
        $productCategoryId          = $_POST['product_category_id'] ?? null;
        $checkProductCategoryExist  = $this->productCategory->checkProductCategoryExist($productCategoryId);
        $total                      = $checkProductCategoryExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Product Category Details',
                'The product category does not exist',
                ['notExist' => true]
            );
        }

        $productCategoryDetails = $this->productCategory->fetchProductCategory($productCategoryId);

        $response = [
            'success'               => true,
            'productCategoryName'   => $productCategoryDetails['product_category_name'] ?? null,
            'parentCategoryId'      => $productCategoryDetails['parent_category_id'] ?? null,
            'costingMethod'         => $productCategoryDetails['costing_method'] ?? null,
            'displayOrder'          => $productCategoryDetails['display_order'] ?? 0
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteProductCategory() {
        $productCategoryId = $_POST['product_category_id'] ?? null;

        $this->productCategory->deleteProductCategory($productCategoryId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Product Category Success',
            'The product category has been deleted successfully.'
        );
    }

    public function deleteMultipleProductCategory() {
        $productCategoryIds = $_POST['product_category_id'] ?? null;

        foreach($productCategoryIds as $productCategoryId){
            $this->productCategory->deleteProductCategory($productCategoryId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Product Categories Success',
            'The selected product categories have been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateProductCategoryTable() {
        $filterParentCategory   = $this->systemHelper->checkFilter($_POST['filter_by_parent_category'] ?? null);
        $filterCostingMethod    = $this->systemHelper->checkFilter($_POST['filter_by_costing_method'] ?? null);
        $pageLink               = $_POST['page_link'] ?? null;
        $response               = [];

        $departments = $this->productCategory->generateProductCategoryTable(
            $filterParentCategory,
            $filterCostingMethod
        );

        foreach ($departments as $row) {
            $productCategoryId      = $row['product_category_id'];
            $productCategoryName    = $row['product_category_name'];
            $parentCategoryName     = $row['parent_category_name'];
            $costingMethod          = $row['costing_method'];
            $displayOrder           = $row['display_order'];

            $productCategoryIdEncrypted = $this->security->encryptData($productCategoryId);

            $response[] = [
                'CHECK_BOX'                 => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                    <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $productCategoryId .'">
                                                </div>',
                'PRODUCT_CATEGORY_NAME'     => $productCategoryName,
                'PARENT_CATEGORY_NAME'      => $parentCategoryName,
                'COSTING_METHOD'            => $costingMethod,
                'DISPLAY_ORDER'             => $displayOrder,
                'LINK'                      => $pageLink .'&id='. $productCategoryIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateProductCategoryOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $productCategories = $this->productCategory->generateProductCategoryOptions();

        foreach ($productCategories as $row) {
            $response[] = [
                'id'    => $row['product_category_id'],
                'text'  => $row['product_category_name']
            ];
        }

        echo json_encode($response);
    }

    public function generateParentCategoryOptions() {
        $productCategoryId  = $_POST['product_category_id'] ?? null;
        $multiple           = $_POST['multiple'] ?? false;
        $response           = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $productCategories = $this->productCategory->generateParentCategoryOptions($productCategoryId);

        foreach ($productCategories as $row) {
            $response[] = [
                'id'    => $row['product_category_id'],
                'text'  => $row['product_category_name']
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

$controller = new ProductCategoryController(
    new ProductCategory(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();