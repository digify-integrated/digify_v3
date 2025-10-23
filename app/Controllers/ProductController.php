<?php
namespace App\Controllers;


session_start();

use App\Models\Product;
use App\Models\ProductCategory;
use App\Models\Authentication;
use App\Models\UploadSetting;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class ProductController
{
    protected Product $product;
    protected ProductCategory $productCategory;
    protected Authentication $authentication;
    protected UploadSetting $uploadSetting;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Product $product,
        ProductCategory $productCategory,
        Authentication $authentication,
        UploadSetting $uploadSetting,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->product          = $product;
        $this->productCategory  = $productCategory;
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
            'insert product'            => $this->insertProduct($lastLogBy),
            'update product image'      => $this->updateProductImage($lastLogBy),
            'delete product'            => $this->deleteProduct(),
            'delete multiple product'   => $this->deleteMultipleProduct(),
            'fetch product details'     => $this->fetchProductDetails(),
            'generate product card'     => $this->generateProductCard(),
            'generate product table'    => $this->generateProductTable(),
            default                     => $this->systemHelper::sendErrorResponse(
                                                'Transaction Failed',
                                                'We encountered an issue while processing your request.'
                                            )
        };
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
            'barcode'               => $productDetails['barcode'] ?? null,
            'productTypeId'         => $productDetails['product_type_id'] ?? null,
            'productCategoryId'     => $productDetails['product_category_id'] ?? null,
            'quantity'              => $productDetails['quantity'] ?? 0,
            'salesPrice'            => $productDetails['sales_price'] ?? 0,
            'cost'                  => $productDetails['cost'] ?? null,
            'productImage'          => $productImage
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
        $productStatusFilter    = $this->systemHelper->checkFilter($_POST['filter_by_product_status'] ?? null);
        $limit                  = $_POST['limit'] ?? null;
        $offset                 = $_POST['offset'] ?? null;
        $response               = [];

        $products = $this->product->generateProductCard($searchValue, $productTypeFilter, $productCategoryFilter, $productStatusFilter, $limit, $offset);

        foreach ($products as $row) {
            $productId              = $row['product_id'];
            $productName            = $row['product_name'];
            $barcode                = $row['barcode'];
            $productTypeName        = $row['product_type_name'];
            $productCategoryName    = $row['product_category_name'];
            $quantity               = $row['quantity'];
            $salesPrice             = $row['sales_price'];
            $cost                   = $row['cost'];
            $productStatus          = $row['product_status'];
            $productImage           = $this->systemHelper->checkImageExist($row['product_image'] ?? null, 'profile');

            $productIdEncrypted = $this->security->encryptData($productId);

            $card = '<div class="col-md-3">
                        <a href="'. $pageLink .'&id='. $productIdEncrypted .'" class="cursor-pointer" target="_blank">
                            <div class="card">
                                <div class="card-body d-flex flex-center flex-column pt-12 p-9">
                                    <div class="symbol symbol-65px symbol-circle mb-5">
                                        <img src="'. $productImage .'" class="rounded-3 mb-4 w-150px h-150px w-xxl-200px h-xxl-200px" alt="image">
                                    </div>

                                    <div class="fw-bold text-gray-800 fs-3 fs-xl-1">'. $productName .'</div>
                                    <div class="text-gray-500 fw-semibold d-block fs-6 mt-n1">'. $productCategoryName .'</div>
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
        $productStatusFilter    = $this->systemHelper->checkFilter($_POST['filter_by_product_status'] ?? null);
        $response               = [];

        $products = $this->product->generateProductTable($productTypeFilter, $productCategoryFilter, $productStatusFilter);

        foreach ($products as $row) {
            $productId              = $row['product_id'];
            $productName            = $row['product_name'];
            $barcode                = $row['barcode'];
            $productTypeName        = $row['product_type_name'];
            $productCategoryName    = $row['product_category_name'];
            $quantity               = $row['quantity'];
            $salesPrice             = $row['sales_price'];
            $cost                   = $row['cost'];
            $productStatus          = $row['product_status'];
            $productImage           = $this->systemHelper->checkImageExist($row['product_image'] ?? null, 'profile');

            $badgeClass             = $productStatus == 'Active' ? 'bg-success' : 'bg-danger';
            $productStatusBadge     = '<div class="'. $badgeClass .' position-absolute border border-4 border-body h-15px w-15px rounded-circle translate-middle start-100 top-100 ms-n3 mt-n3"></div>';

            $productIdEncrypted = $this->security->encryptData($productId);

            $response[] = [
                'CHECK_BOX'         => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                            <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $productId .'">
                                        </div>',
                'PRODUCT'           => '<div class="d-flex align-items-center">
                                            <div class="me-4">
                                                <div class="symbol symbol-50px symbol-circle">
                                                    <img src="'. $productImage .'" alt="image">
                                                    '. $productStatusBadge .'
                                                </div>
                                            </div>
                                            <div class="d-flex flex-column">
                                                <span class="text-gray-800">'. $productName .'</span>
                                            </div>
                                        </div>',
                'BARCODE'           => $barcode,
                'PRODUCT_TYPE'      => $productTypeName,
                'PRODUCT_CATEGORY'  => $productCategoryName,
                'QUANTITY'          => number_format($quantity),
                'SALES_PRICE'       => number_format($salesPrice, 2) . ' PHP',
                'COST'              => number_format($cost, 2) . ' PHP',
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
    new Authentication(),
    new UploadSetting(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
