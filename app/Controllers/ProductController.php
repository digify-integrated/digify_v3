<?php
namespace App\Controllers;


session_start();

use App\Models\Product;
use App\Models\ProductCategory;
use App\Models\Tax;
use App\Models\Authentication;
use App\Models\UploadSetting;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class ProductController
{
    protected Product $product;
    protected ProductCategory $productCategory;
    protected Tax $tax;
    protected Authentication $authentication;
    protected UploadSetting $uploadSetting;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Product $product,
        ProductCategory $productCategory,
        Tax $tax,
        Authentication $authentication,
        UploadSetting $uploadSetting,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->product          = $product;
        $this->productCategory  = $productCategory;
        $this->tax              = $tax;
        $this->authentication   = $authentication;
        $this->uploadSetting    = $uploadSetting;
        $this->security         = $security;
        $this->systemHelper     = $systemHelper;
    }

    public function handleRequest(): void
    {
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
                    'invalid_session' => true,
                    'redirect_link' => 'imageut.php?imageut'
                ]
            );
        }

        $transaction = strtolower(trim($transaction));

        match ($transaction) {
            'save product category'             => $this->saveProductCategory($lastLogBy),
            'insert product'                    => $this->insertProduct($lastLogBy),
            'update product general'            => $this->updateProductGeneral($lastLogBy),
            'update product inventory'          => $this->updateProductInventory($lastLogBy),
            'update product shipping'           => $this->updateProductShipping($lastLogBy),
            'update product is sellable'        => $this->updateProductIsSellable($lastLogBy),
            'update product is purchasable'     => $this->updateProductIsPurchasable($lastLogBy),
            'update product show on pos'        => $this->updateProductShowOnPos($lastLogBy),
            'update product image'              => $this->updateProductImage($lastLogBy),
            'delete product'                    => $this->deleteProduct(),
            'delete multiple product'           => $this->deleteMultipleProduct(),
            'fetch product details'             => $this->fetchProductDetails(),
            'fetch product categories details'  => $this->fetchProductCategoriesDetails(),
            'generate product card'             => $this->generateProductCard(),
            'generate product table'            => $this->generateProductTable(),
            default                             => $this->systemHelper::sendErrorResponse(
                                                        'Transaction Failed',
                                                        'We encountered an issue while processing your request.'
                                                    )
        };
    }

    public function saveProductCategory($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_category_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId              = $_POST['product_id'] ?? null;
        $productCategoryIds     = $_POST['product_category_id'] ?? [];

        if(empty($productCategoryIds)){
            $this->systemHelper::sendErrorResponse(
                'Assign File Extension Error',
                'Please select the file extension(s) you wish to assign to the upload setting.'
            );
        }

        $this->product->deleteProductCategories($productId);

        $productDetails   = $this->product->fetchProduct($productId);
        $productName      = $productDetails['product_name'] ?? '';

        foreach ($productCategoryIds as $productCategoryId) {
            $productCategoryDetails   = $this->productCategory->fetchProductCategory($productCategoryId);
            $productCategoryName      = $productCategoryDetails['product_category_name'] ?? null;

            $this->product->insertProductCategories($productId, $productName, $productCategoryId, $productCategoryName, $lastLogBy);
        }

        $this->systemHelper->sendSuccessResponse(
            'Assign File Extension Success',
            'The file extension has been assigned successfully.'
        );
    }

    public function insertProduct($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productName            = $_POST['product_name'] ?? null;
        $productDescription     = $_POST['product_description'] ?? null;

        $productId = $this->product->insertProduct($productName, $productDescription, $lastLogBy);

        $encryptedproductId = $this->security->encryptData($productId);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Success',
            'The product has been saved successfully.',
            ['product_id' => $encryptedproductId]
        );
    }

    public function updateProductGeneral($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_general_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId              = $_POST['product_id'] ?? null;
        $productName            = $_POST['product_name'] ?? null;
        $productDescription     = $_POST['product_description'] ?? null;

        $this->product->updateProductGeneral($productId, $productName, $productDescription, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Update Product Success',
            'The product has been updated successfully.'
        );
    }

    public function updateProductInventory($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_inventory_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId          = $_POST['product_id'] ?? null;
        $sku                = $_POST['sku'] ?? null;
        $barcode            = $_POST['barcode'] ?? null;
        $productType        = $_POST['product_type'] ?? null;
        $quantityOnHand     = $_POST['quantity_on_hand'] ?? null;
        
        $checkProductSKUExist       = $this->product->checkProductSKUExist($productId, $sku);
        $totalSKU                   = $checkProcheckProductSKUExistductExist['total'] ?? 0;

        $checkProductBarcodeExist   = $this->product->checkProductBarcodeExist($productId, $barcode);
        $totalBarcode               = $checkProductBarcodeExist['total'] ?? 0;

        if ($totalSKU > 0) {
            $this->systemHelper::sendErrorResponse(
                'Update Product Error',
                'The SKU entered already exists.'
            );
        }

        if ($totalBarcode > 0) {
            $this->systemHelper::sendErrorResponse(
                'Update Product Error',
                'The barcode entered already exists.'
            );
        }

        $this->product->updateProductInventory($productId, $sku, $barcode, $productType, $quantityOnHand, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Update Product Success',
            'The product has been updated successfully.'
        );
    }

    public function updateProductShipping($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_shipping_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId  = $_POST['product_id'] ?? null;
        $weight     = $_POST['weight'] ?? null;
        $width      = $_POST['width'] ?? null;
        $height     = $_POST['height'] ?? null;
        $length     = $_POST['length'] ?? null;

        $this->product->updateProductShipping($productId, $weight, $width, $height, $length, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Update Product Success',
            'The product has been updated successfully.'
        );
    }

    public function updateProductIsSellable($lastLogBy){
        $productId          = $_POST['product_id'] ?? null;
        $productDetails     = $this->product->fetchProduct($productId);
        $isSellable         = $productDetails['is_sellable'] ?? 'Yes';
        $isSellable         = ($isSellable === 'Yes') ? 'No' : 'Yes';

        $this->product->updateProductSettings($productId, $isSellable, 'is sellable', $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Update Sales Success',
            'The sales has been updated successfully.'
        );
    }

    public function updateProductIsPurchasable($lastLogBy){
        $productId          = $_POST['product_id'] ?? null;
        $productDetails     = $this->product->fetchProduct($productId);
        $isPurchasable      = $productDetails['is_purchasable'] ?? 'Yes';
        $isPurchasable      = ($isPurchasable === 'Yes') ? 'No' : 'Yes';

        $this->product->updateProductSettings($productId, $isPurchasable, 'is purchasable', $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Update Purchase Success',
            'The purchase has been updated successfully.'
        );
    }

    public function updateProductShowOnPos($lastLogBy){
        $productId          = $_POST['product_id'] ?? null;
        $productDetails     = $this->product->fetchProduct($productId);
        $showOnPos      = $productDetails['show_on_pos'] ?? 'Yes';
        $showOnPos      = ($showOnPos === 'Yes') ? 'No' : 'Yes';

        $this->product->updateProductSettings($productId, $showOnPos, 'show on pos', $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Update Point of Sale Success',
            'The point of sale has been updated successfully.'
        );
    }

    public function updateProductImage($lastLogBy){
        $productId = $_POST['product_id'] ?? null;
       
        $productImageFileName               = $_FILES['product_image']['name'];
        $productImageFileSize               = $_FILES['product_image']['size'];
        $productImageFileError              = $_FILES['product_image']['error'];
        $productImageTempName               = $_FILES['product_image']['tmp_name'];
        $productImageFileExtension          = explode('.', $productImageFileName);
        $productImageActualFileExtension    = strtolower(end($productImageFileExtension));

        $uploadSetting  = $this->uploadSetting->fetchUploadSetting(8);
        $maxFileSize    = $uploadSetting['max_file_size'];

        $uploadSettingFileExtension     = $this->uploadSetting->fetchUploadSettingFileExtension(8);
        $allowedFileExtensions          = [];

        foreach ($uploadSettingFileExtension as $row) {
            $allowedFileExtensions[] = $row['file_extension'];
        }

        if (!in_array($productImageActualFileExtension, $allowedFileExtensions)) {              
            $this->systemHelper::sendErrorResponse(
                'Update Product Image Error', 
                'The file uploaded is not supported.'
            );
        }
            
        if(empty($productImageTempName)){
            $this->systemHelper::sendErrorResponse(
                'Update Product Image Error', 
                'Please choose the app image.'
            );
        }
            
        if($productImageFileError){                
            $this->systemHelper::sendErrorResponse(
                'Update Product Image Error', 
                'An error occurred while uploading the file.'
            );
        }
            
        if($productImageFileSize > ($maxFileSize * 1024)){
            $this->systemHelper::sendErrorResponse(
                'Update Product Image Error', 
                'The product image exceeds the maximum allowed size of ' . $maxFileSize . ' mb.'
            );
        }

        $fileName   = $this->security->generateFileName();
        $fileNew    = $fileName . '.' . $productImageActualFileExtension;
            
        define('PROJECT_BASE_DIR', dirname(__DIR__, 2));

        $uploadsDir         = PROJECT_BASE_DIR . '/storage/uploads/';
        $directory          = $uploadsDir . 'product/' . $productId . '/';
        $fileDestination    = $directory . $fileNew;
        $filePath           = 'storage/uploads/product/' . $productId . '/' . $fileNew;

        $directoryChecker = $this->security->directoryChecker($directory);

        if ($directoryChecker !== true) {
            $this->systemHelper::sendErrorResponse(
                'Update Product Image Error',
                $directoryChecker
            );
        }

        $productDetails     = $this->product->fetchProduct($productId);
        $productImage       = $productDetails['product_image'] ?? null;
        
        $this->systemHelper->deleteFileIfExist($productImage);

        if(!move_uploaded_file($productImageTempName, $fileDestination)){
            $this->systemHelper::sendErrorResponse(
                'Update Product Image Error', 
                'The product image cannot be uploaded due to an error'
            );
        }

        $this->product->updateProductImage($productId, $filePath, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Update Product Image Success',
            'The product image has been updated successfully.'
        );
    }

    public function deleteProduct(){
        $productId          = $_POST['product_id'] ?? null;
        $productDetails     = $this->product->fetchProduct($productId);
        $productImage       = $productDetails['product_image'] ?? null;

        $this->systemHelper->deleteFileIfExist($productImage);

        $this->product->deleteProduct($productId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Product Success',
            'The product has been deleted successfully.'
        );
    }

    public function deleteMultipleProduct(){
        $productIds = $_POST['product_id'] ?? null;

        foreach($productIds as $productId){
            $productDetails     = $this->product->fetchProduct($productId);
            $productImage       = $productDetails['product_image'] ?? null;

            $this->systemHelper->deleteFileIfExist($productImage);

            $this->product->deleteProduct($productId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Products Success',
            'The selected products have been deleted successfully.'
        );
    }

    public function fetchProductDetails(){
        $productId          = $_POST['product_id'] ?? null;
        $checkProductExist  = $this->product->checkProductExist($productId);
        $total              = $checkProductExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Product Details',
                'The product does not exist',
                ['notExist' => true]
            );
        }

        $productDetails     = $this->product->fetchProduct($productId);
        $productImage       = $this->systemHelper->checkImageExist($productDetails['product_image'] ?? null, 'upload placeholder');

        $response = [
            'success'               => true,
            'productName'           => $productDetails['product_name'] ?? null,
            'productDescription'    => $productDetails['product_description'] ?? null,
            'productType'           => $productDetails['product_type'] ?? null,
            'barcode'               => $productDetails['barcode'] ?? null,
            'sku'                   => $productDetails['sku'] ?? null,
            'isSellable'            => $productDetails['is_sellable'] ?? 'Yes',
            'isPurchasable'         => $productDetails['is_purchasable'] ?? 'Yes',
            'showOnPos'             => $productDetails['show_on_pos'] ?? 'Yes',
            'quantityOnHand'        => $productDetails['quantity_on_hand'] ?? 0,
            'salesPrice'            => $productDetails['sales_price'] ?? 0,
            'cost'                  => $productDetails['cost'] ?? 0,
            'discountType'          => $productDetails['discount_type'] ?? 'None',
            'discountRate'          => $productDetails['discount_rate'] ?? 0,
            'weight'                => $productDetails['weight'] ?? 0,
            'width'                 => $productDetails['width'] ?? 0,
            'height'                => $productDetails['height'] ?? 0,
            'length'                => $productDetails['length'] ?? 0,
            'productImage'          => $productImage
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchProductCategoriesDetails(){
        $productId          = $_POST['product_id'] ?? null;
        $checkProductExist  = $this->product->checkProductExist($productId);
        $total              = $checkProductExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Product Categories Details',
                'The product does not exist',
                ['notExist' => true]
            );
        }

        $productCategoriesDetails = $this->product->fetchProductCategories($productId);

        $productCategories = [];
        foreach ($productCategoriesDetails as $row) {
            $productCategories[] = $row['product_category_id'];
        }

        $response = [
            'success'               => true,
            'productCategories'     => $productCategories
        ];

        echo json_encode($response);
        exit;
    }

    public function generateProductCard()
    {
        $pageLink               = $_POST['page_link'] ?? null;
        $searchValue            = $_POST['search_value'] ?? null;
        $productTypeFilter      = $this->systemHelper->checkFilter($_POST['filter_by_product_type'] ?? null);
        $productCategoryFilter  = $this->systemHelper->checkFilter($_POST['filter_by_product_category'] ?? null);
        $isSellableFilter       = $this->systemHelper->checkFilter($_POST['filter_by_is_sellable'] ?? null);
        $isPurchasableFilter    = $this->systemHelper->checkFilter($_POST['filter_by_is_purchasable'] ?? null);
        $showOnPosFilter        = $this->systemHelper->checkFilter($_POST['filter_by_show_on_pos'] ?? null);
        $productStatusFilter    = $this->systemHelper->checkFilter($_POST['filter_by_product_status'] ?? null);
        $limit                  = $_POST['limit'] ?? null;
        $offset                 = $_POST['offset'] ?? null;
        $response               = [];

        $products = $this->product->generateProductCard($searchValue, $productTypeFilter, $productCategoryFilter, $isSellableFilter, $isPurchasableFilter, $showOnPosFilter, $productStatusFilter, $limit, $offset);

        foreach ($products as $row) {
            $productId              = $row['product_id'];
            $productName            = $row['product_name'];
            $productDescription     = $row['product_description'];
            $sku                    = $row['sku'];
            $barcode                = $row['barcode'];
            $productTypeName        = $row['product_type'];
            $quantityOnHand         = $row['quantity_on_hand'];
            $salesPrice             = $row['sales_price'];
            $cost                   = $row['cost'];
            $productStatus          = $row['product_status'];
            $productImage           = $this->systemHelper->checkImageExist($row['product_image'] ?? null, 'default');

            $productIdEncrypted = $this->security->encryptData($productId);

            $card = '<div class="col-md-3">
                        <a href="'. $pageLink .'&id='. $productIdEncrypted .'" class="cursor-pointer" target="_blank">
                            <div class="card">
                                <div class="card-body d-flex flex-center flex-column pt-12 p-9">
                                    <div class="symbol symbol-65px symbol-circle mb-5">
                                        <img src="'. $productImage .'" class="rounded-3 mb-4 w-150px h-150px" alt="image">
                                    </div>

                                    <div class="fw-bold text-gray-800 fs-3 fs-xl-1">'. $productName .'</div>
                                    <div class="text-gray-500 fw-semibold d-block fs-6 mt-n1">'. $productDescription .'</div>
                                    <span class="text-success text-end fw-bold fs-1">'. number_format($salesPrice, 2) .' PHP</span>
                                </div>
                            </div>
                        </a>
                    </div>';

            $response[] = ['EMPLOYEE_CARD' => $card];
        }

        echo json_encode($response);
    }

    public function generateProductTable()
    {
        $pageLink               = $_POST['page_link'] ?? null;
        $productTypeFilter      = $this->systemHelper->checkFilter($_POST['filter_by_product_type'] ?? null);
        $productCategoryFilter  = $this->systemHelper->checkFilter($_POST['filter_by_product_category'] ?? null);
        $isSellableFilter       = $this->systemHelper->checkFilter($_POST['filter_by_is_sellable'] ?? null);
        $isPurchasableFilter    = $this->systemHelper->checkFilter($_POST['filter_by_is_purchasable'] ?? null);
        $showOnPosFilter        = $this->systemHelper->checkFilter($_POST['filter_by_show_on_pos'] ?? null);
        $productStatusFilter    = $this->systemHelper->checkFilter($_POST['filter_by_product_status'] ?? null);
        $response               = [];

        $products = $this->product->generateProductTable($productTypeFilter, $productCategoryFilter, $isSellableFilter, $isPurchasableFilter, $showOnPosFilter, $productStatusFilter);

        foreach ($products as $row) {
            $productId              = $row['product_id'];
            $productName            = $row['product_name'];
            $productDescription     = $row['product_description'];
            $sku                    = $row['sku'];
            $barcode                = $row['barcode'];
            $productTypeName        = $row['product_type'];
            $quantityOnHand         = $row['quantity_on_hand'];
            $salesPrice             = $row['sales_price'];
            $cost                   = $row['cost'];
            $productStatus          = $row['product_status'];
            $productImage           = $this->systemHelper->checkImageExist($row['product_image'] ?? null, 'default');

            $badgeClass             = $productStatus == 'Active' ? 'badge-light-success' : 'badge-light-danger';

            $productIdEncrypted = $this->security->encryptData($productId);

            $productCategoriesDetails = $this->product->fetchProductCategories($productId);

            $productCategories = '';
            foreach ($productCategoriesDetails as $row) {
                $productCategories .= '<div class="badge badge-light-primary me-2">'. $row['product_category_name'] .'</div>';
            }

            $response[] = [
                'CHECK_BOX'         => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                            <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $productId .'">
                                        </div>',
                'PRODUCT'           => '<div class="d-flex align-items-center">
                                            <div class="me-4">
                                                <div class="symbol symbol-50px">
                                                    <img src="'. $productImage .'" alt="image">
                                                </div>
                                            </div>
                                            <div class="d-flex flex-column">
                                                <span class="text-gray-800">'. $productName .'</span>
                                            </div>
                                        </div>',
                'BARCODE'           => $barcode,
                'PRODUCT_TYPE'      => $productTypeName,
                'PRODUCT_CATEGORY'  => $productCategories,
                'QUANTITY'          => number_format($quantityOnHand),
                'SALES_PRICE'       => number_format($salesPrice, 2) . ' PHP',
                'COST'              => number_format($cost, 2) . ' PHP',
                'STATUS'            => '<div class="badge '. $badgeClass .'">'. $productStatus .'</div>',
                'LINK'              => $pageLink .'&id='. $productIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateProductOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $products = $this->product->generateProductOptions();

        foreach ($products as $row) {
            $response[] = [
                'id'    => $row['product_id'],
                'text'  => $row['product_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new ProductController(
    new Product(),
    new ProductCategory(),
    new Tax(),
    new Authentication(),
    new UploadSetting(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
