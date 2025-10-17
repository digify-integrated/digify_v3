<?php
namespace App\Controllers;


session_start();

use App\Models\ProductType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class ProductTypeController
{
    protected ProductType $productType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        ProductType $productType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->productType      = $productType;
        $this->authentication   = $authentication;
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
                    'redirect_link' => 'logout.php?logout'
                ]
            );
        }

        $transaction = strtolower(trim($transaction));

        match ($transaction) {
            'save product type'                 => $this->saveProductType($lastLogBy),
            'delete product type'               => $this->deleteProductType(),
            'delete multiple product type'      => $this->deleteMultipleProductType(),
            'fetch product type details'        => $this->fetchProductTypeDetails(),
            'generate product type table'       => $this->generateProductTypeTable(),
            'generate product type options'     => $this->generateProductTypeOptions(),
            default                             => $this->systemHelper::sendErrorResponse(
                                                        'Transaction Failed',
                                                        'We encountered an issue while processing your request.'
                                                    )
        };
    }

    public function saveProductType($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productTypeId      = $_POST['product_type_id'] ?? null;
        $productTypeName    = $_POST['product_type_name'] ?? null;

        $productTypeId              = $this->productType->saveProductType($productTypeId, $productTypeName, $lastLogBy);
        $encryptedProductTypeId     = $this->security->encryptData($productTypeId);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Type Success',
            'The product type has been saved successfully.',
            ['product_type_id' => $encryptedProductTypeId]
        );
    }

    public function deleteProductType(){
        $productTypeId = $_POST['product_type_id'] ?? null;

        $this->productType->deleteProductType($productTypeId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Product Type Success',
            'The product type has been deleted successfully.'
        );
    }

    public function deleteMultipleProductType(){
        $productTypeIds = $_POST['product_type_id'] ?? null;

        foreach($productTypeIds as $productTypeId){
            $this->productType->deleteProductType($productTypeId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Product Types Success',
            'The selected product types have been deleted successfully.'
        );
    }

    public function fetchProductTypeDetails(){
        $productTypeId          = $_POST['product_type_id'] ?? null;
        $checkProductTypeExist  = $this->productType->checkProductTypeExist($productTypeId);
        $total                  = $checkProductTypeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Product Type Details',
                'The product type does not exist',
                ['notExist' => true]
            );
        }

        $productTypeDetails = $this->productType->fetchProductType($productTypeId);

        $response = [
            'success'           => true,
            'productTypeName'   => $productTypeDetails['product_type_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateProductTypeTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $productTypes = $this->productType->generateProductTypeTable();

        foreach ($productTypes as $row) {
            $productTypeId      = $row['product_type_id'];
            $productTypeName    = $row['product_type_name'];

            $productTypeIdEncrypted = $this->security->encryptData($productTypeId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $productTypeId .'">
                                            </div>',
                'PRODUCT_TYPE_NAME'     => $productTypeName,
                'LINK'                  => $pageLink .'&id='. $productTypeIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateProductTypeOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $countries = $this->productType->generateProductTypeOptions();

        foreach ($countries as $row) {
            $response[] = [
                'id'    => $row['product_type_id'],
                'text'  => $row['product_type_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new ProductTypeController(
    new ProductType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
