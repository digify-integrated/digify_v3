<?php
namespace App\Controllers;

session_start();

use App\Models\Product;
use App\Models\ProductCategory;
use App\Models\Tax;
use App\Models\Unit;
use App\Models\Attribute;
use App\Models\Authentication;
use App\Models\UploadSetting;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class ProductController {
    protected Product $product;
    protected ProductCategory $productCategory;
    protected Tax $tax;
    protected Unit $unit;
    protected Attribute $attribute;
    protected Authentication $authentication;
    protected UploadSetting $uploadSetting;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Product $product,
        ProductCategory $productCategory,
        Tax $tax,
        Unit $unit,
        Attribute $attribute,
        Authentication $authentication,
        UploadSetting $uploadSetting,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->product          = $product;
        $this->productCategory  = $productCategory;
        $this->tax              = $tax;
        $this->unit             = $unit;
        $this->attribute        = $attribute;
        $this->authentication   = $authentication;
        $this->uploadSetting    = $uploadSetting;
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
            'save product category'                 => $this->saveProductCategory($lastLogBy),
            'save product attribute'                => $this->saveProductAttribute($lastLogBy),
            'save product pricelist'                => $this->saveProductPricelist($lastLogBy),
            'insert product'                        => $this->insertProduct($lastLogBy),
            'update product general'                => $this->updateProductGeneral($lastLogBy),
            'update product inventory'              => $this->updateProductInventory($lastLogBy),
            'update product shipping'               => $this->updateProductShipping($lastLogBy),
            'update product pricing'                => $this->updateProductPricing($lastLogBy),
            'update product is sellable'            => $this->updateProductIsSellable($lastLogBy),
            'update product is purchasable'         => $this->updateProductIsPurchasable($lastLogBy),
            'update product show on pos'            => $this->updateProductShowOnPos($lastLogBy),
            'update product activate'               => $this->updateProductActivate($lastLogBy),
            'update product archive'                => $this->updateProductArchive($lastLogBy),
            'update product unarchive'              => $this->updateProductUnarchive($lastLogBy),
            'update product image'                  => $this->updateProductImage($lastLogBy),
            'delete product'                        => $this->deleteProduct(),
            'delete multiple product'               => $this->deleteMultipleProduct(),
            'delete product attribute'              => $this->deleteProductAttribute(),
            'delete product pricelist'              => $this->deleteProductPricelist(),
            'delete multiple product pricelist'     => $this->deleteMultipleProductPricelist(),
            'fetch product details'                 => $this->fetchProductDetails(),
            'fetch product categories details'      => $this->fetchProductCategoryMapDetails(),
            'fetch product tax details'             => $this->fetchProductTaxDetails(),
            'fetch product pricelist details'       => $this->fetchProductPricelistDetails(),
            'generate product card'                 => $this->generateProductCard(),
            'generate product table'                => $this->generateProductTable(),
            'generate product variant card'         => $this->generateProductVariantCard(),
            'generate product variant table'        => $this->generateProductVariantTable(),
            'generate product attribute table'      => $this->generateProductAttributeTable($lastLogBy, $pageId),
            'generate product variation table'      => $this->generateProductVariationTable(),
            'generate product pricelist table'      => $this->generateProductPricelistTable($lastLogBy, $pageId),
            'generate pricelist table'              => $this->generatePricelistTable(),
            'generate product options'              => $this->generateProductOptions(),
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

        $productId              = $_POST['product_id'] ?? null;
        $productCategoryIds     = $_POST['product_category_id'] ?? [];

        if(empty($productCategoryIds)){
            $this->systemHelper::sendErrorResponse(
                'Save Product Category Error',
                'Please select the product categories.'
            );
        }

        $this->product->deleteProductCategoryMap($productId);

        $productDetails   = $this->product->fetchProduct($productId);
        $productName      = $productDetails['product_name'] ?? '';

        foreach ($productCategoryIds as $productCategoryId) {
            $productCategoryDetails   = $this->productCategory->fetchProductCategory($productCategoryId);
            $productCategoryName      = $productCategoryDetails['product_category_name'] ?? null;

            $this->product->insertProductCategoryMap(
                $productId,
                $productName,
                $productCategoryId,
                $productCategoryName,
                $lastLogBy
            );
        }

        $this->systemHelper::sendSuccessResponse(
            'Save Product Category Success',
            'The product categories have been added successfully.'
        );
    }

    public function saveProductAttribute(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_attribute_form')) {
            $this->systemHelper::sendErrorResponse('Invalid Request', 'Security check failed. Please refresh and try again.');
        }

        $productId          = $_POST['product_id'] ?? null;
        $attributeValueIds  = $_POST['attribute_value_id'] ?? [];

        if (empty($attributeValueIds)) {
            $this->systemHelper::sendErrorResponse('Save Product Attribute Error', 'Please select the product attribute.');
        }

        $productDetails     = $this->product->fetchProduct($productId);
        $productName        = $productDetails['product_name'] ?? '';

        foreach ($attributeValueIds as $attributeValueId) {
            $attributeValueDetails  = $this->attribute->fetchAttributeValue($attributeValueId);
            $attributeId            = $attributeValueDetails['attribute_id'] ?? null;
            $attributeName          = $attributeValueDetails['attribute_name'] ?? null;
            $attributeValueName     = $attributeValueDetails['attribute_value_name'] ?? null;

            $this->product->insertProductAttribute(
                $productId,
                $productName,
                $attributeId,
                $attributeName,
                $attributeValueId,
                $attributeValueName,
                $lastLogBy
            );
        }

        $this->product->updateAllSubProductsDeactivate(
            $productId,
            $lastLogBy
        );
        
        $productAttributesInstantly = $this->product->fetchAllProductAttributes(
            $productId,
            'Instantly'
        );

        $groupedAttributes = [];

        foreach ($productAttributesInstantly as $row) {
            $attributeName  = $row['attribute_name'];
            $attributeId    = $row['attribute_id'];

            $groupedAttributes[$attributeName]['attribute_id'] = $attributeId;
            $groupedAttributes[$attributeName]['values'][] = [
                'attribute_value_id'    => $row['attribute_value_id'],
                'attribute_value_name'  => $row['attribute_value_name']
            ];
        }

        if (!empty($groupedAttributes)) {
            $combinations = $this->generateCombinations($groupedAttributes);

            foreach ($combinations as $combination) {
                $attributeValueIds = array_column($combination, 'attribute_value_id');
                sort($attributeValueIds);
                $variantSignature = sha1($productId . '-' . implode('-', $attributeValueIds));

                $variantName = $productName . ' - ' . implode(' - ', array_column($combination, 'attribute_value_name'));

                $subproductId = $this->product->saveSubProductAndVariants(
                    $productId,
                    $productName,
                    $variantName,
                    $variantSignature,
                    $lastLogBy
                );

                foreach ($combination as $attr) {
                    $checkProductVariantExists = $this->product->checkProductVariantExists($subproductId, $attr['attribute_value_id']);   

                    if ($checkProductVariantExists['total'] == 0) {
                        $this->product->insertProductVariant(
                            $productId,
                            $productName,
                            $subproductId,
                            $variantName,
                            $attr['attribute_id'],
                            $attr['attribute_name'],
                            $attr['attribute_value_id'],
                            $attr['attribute_value_name'],
                            $lastLogBy
                        );
                    }
                }
            }
        }

        $productAttributesNever = $this->product->fetchAllProductAttributes(
            $productId,
            'Never'
        );

        foreach ($productAttributesNever as $row) {
            $attributeId            = $row['attribute_id'];
            $attributeName          = $row['attribute_name'];
            $attributeValueId       = $row['attribute_value_id'];
            $attributeValueName     = $row['attribute_value_name'];

            $variantSignature   = sha1($productId . '-' . $attributeValueId);
            $variantName        = $productName . ' - ' . $attributeValueName;

            $subproductId = $this->product->saveSubProductAndVariants(
                $productId,
                $productName,
                $variantName,
                $variantSignature,
                $lastLogBy
            );

            $checkProductVariantExists = $this->product->checkProductVariantExists($subproductId, $attributeValueId);   

            if ($checkProductVariantExists['total'] == 0) {
                $this->product->insertProductVariant(
                    $productId,
                    $productName,
                    $subproductId,
                    $variantName,
                    $attributeId,
                    $attributeName,
                    $attributeValueId,
                    $attributeValueName,
                    $lastLogBy
                );
            }
        }

        $this->systemHelper::sendSuccessResponse(
            'Save Product Attribute Success',
            'The product attributes have been saved successfully.'
        );
    }

    public function saveProductPricelist(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_pricelist_form')) {
            $this->systemHelper::sendErrorResponse('Invalid Request', 'Security check failed. Please refresh and try again.');
        }

        $productPricelistId     = $_POST['product_pricelist_id'] ?? null;
        $productId              = $_POST['product_id'] ?? null;
        $discountType           = $_POST['discount_type'] ?? 'Percentage';
        $fixedPrice             = $_POST['fixed_price'] ?? 0;
        $minQuantity            = $_POST['min_quantity'] ?? 0;
        $validityStartDate      = $this->systemHelper->checkDate('empty', $_POST['validity_start_date'], '', 'Y-m-d', '');
        $validityEndDate        = $this->systemHelper->checkDate('empty', $_POST['validity_end_date'], '', 'Y-m-d', '');
        $remarks                = $_POST['remarks'] ?? '';

        if (!empty($validityStartDate) && !empty($validityEndDate)) {
            $start = strtotime($validityStartDate);
            $end   = strtotime($validityEndDate);

            if ($start > $end) {
               $this->systemHelper::sendErrorResponse(
                    'Save Product Pricelist Error',
                    'The validity end date must be greater than or equal to start date.'
                );
            }
        }

        $productDetails = $this->product->fetchProduct($productId);
        $productName = $productDetails['product_name'] ?? '';

        $productPricelistId = $this->product->saveProductPricelist(
            $productPricelistId,
            $productId,
            $productName,
            $discountType,
            $fixedPrice,
            $minQuantity,
            $validityStartDate,
            $validityEndDate,
            $remarks,
            $lastLogBy
        );

        $encryptedProductPricelistId = $this->security->encryptData($productPricelistId);

        $this->systemHelper::sendSuccessResponse(
            'Save Product Pricelist Success',
            'The product pricelist has been saved successfully.',
            ['product_pricelist_id' => $encryptedProductPricelistId]
        );
    }

    /* =============================================================================================
        SECTION 2: INSERT METHOD
    ============================================================================================= */

    public function insertProduct(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productName            = $_POST['product_name'] ?? null;
        $productDescription     = $_POST['product_description'] ?? null;

        $productId = $this->product->insertProduct(
            $productName,
            $productDescription,
            $lastLogBy
        );

        $encryptedProductId = $this->security->encryptData($productId);

        $this->systemHelper::sendSuccessResponse(
            'Save Product Success',
            'The product has been saved successfully.',
            ['product_id' => $encryptedProductId]
        );
    }

    /* =============================================================================================
        SECTION 3: UPDATE METHOD
    ============================================================================================= */

    public function updateProductGeneral(
        int $lastLogBy
    ) {
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

        $this->product->updateProductGeneral(
            $productId,
            $productName,
            $productDescription,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Update Product Success',
            'The product has been updated successfully.'
        );
    }

    public function updateProductPricing(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_pricing_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId          = $_POST['product_id'] ?? null;
        $salesPrice         = $_POST['sales_price'] ?? 0;
        $cost               = $_POST['cost'] ?? 0;
        $salesTaxIds        = $_POST['sales_tax_id'] ?? [];
        $purchaseTaxIds     = $_POST['purchase_tax_id'] ?? [];

        $this->product->updateProductPricing(
            $productId,
            $salesPrice,
            $cost,
            $lastLogBy
        );

        $this->product->deleteProductTax($productId);

        $productDetails   = $this->product->fetchProduct($productId);
        $productName      = $productDetails['product_name'] ?? '';

        foreach ($salesTaxIds as $salesTaxId) {
            $taxDetails     = $this->tax->fetchTax($salesTaxId);
            $taxName        = $taxDetails['tax_name'] ?? null;

            $this->product->insertProductTax(
                $productId,
                $productName,
                'Sales',
                $salesTaxId,
                $taxName,
                $lastLogBy
            );
        }

        foreach ($purchaseTaxIds as $purchaseTaxId) {
            $taxDetails     = $this->tax->fetchTax($purchaseTaxId);
            $taxName        = $taxDetails['tax_name'] ?? null;

            $this->product->insertProductTax(
                $productId,
                $productName,
                'Purchases',
                $purchaseTaxId,
                $taxName,
                $lastLogBy
            );
        }

        $this->systemHelper::sendSuccessResponse(
            'Update Product Success',
            'The product has been updated successfully.'
        );
    }

    public function updateProductInventory(
        int $lastLogBy
    ) {
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
        $quantityOnHand     = $_POST['quantity_on_hand'] ?? 0;
        $unitId             = $_POST['unit_id'] ?? null;

        $unitIdDetails      = $this->unit->fetchUnit($unitId);
        $unitName           = $unitIdDetails['unit_name'] ?? null;
        $unitAbbreviation   = $unitIdDetails['unit_abbreviation'] ?? null;
        
        if(!empty($sku)){
            $checkProductSKUExist   = $this->product->checkProductSKUExist($productId, $sku);
            $totalSKU               = $checkProductSKUExist['total'] ?? 0;

            if ($totalSKU > 0) {
                $this->systemHelper::sendErrorResponse(
                    'Update Product Error',
                    'The SKU entered already exists.'
                );
            }
        }
       

        if(!empty($barcode)){
            $checkProductBarcodeExist   = $this->product->checkProductBarcodeExist($productId, $barcode);
            $totalBarcode               = $checkProductBarcodeExist['total'] ?? 0;

            if ($totalBarcode > 0) {
                $this->systemHelper::sendErrorResponse(
                    'Update Product Error',
                    'The barcode entered already exists.'
                );
            }
        }

        $this->product->updateProductInventory(
            $productId,
            $sku,
            $barcode,
            $productType,
            $quantityOnHand,
            $unitId,
            $unitName,
            $unitAbbreviation,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Update Product Success',
            'The product has been updated successfully.'
        );
    }

    public function updateProductShipping(
        int $lastLogBy
    ) {
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

        $this->product->updateProductShipping(
            $productId,
            $weight,
            $width,
            $height,
            $length,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Update Product Success',
            'The product has been updated successfully.'
        );
    }

    public function updateProductIsSellable(
        int $lastLogBy
    ) {
        $productId          = $_POST['product_id'] ?? null;
        $productDetails     = $this->product->fetchProduct($productId);
        $isSellable         = $productDetails['is_sellable'] ?? 'Yes';
        $isSellable         = ($isSellable === 'Yes') ? 'No' : 'Yes';

        $this->product->updateProductSettings(
            $productId,
            $isSellable,
            'is sellable',
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Update Sales Success',
            'The sales has been updated successfully.'
        );
    }

    public function updateProductIsPurchasable(
        int $lastLogBy
    ) {
        $productId          = $_POST['product_id'] ?? null;
        $productDetails     = $this->product->fetchProduct($productId);
        $isPurchasable      = $productDetails['is_purchasable'] ?? 'Yes';
        $isPurchasable      = ($isPurchasable === 'Yes') ? 'No' : 'Yes';

        $this->product->updateProductSettings(
            $productId,
            $isPurchasable,
            'is purchasable',
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Update Purchase Success',
            'The purchase has been updated successfully.'
        );
    }

    public function updateProductShowOnPos(
        int $lastLogBy
    ) {
        $productId          = $_POST['product_id'] ?? null;
        $productDetails     = $this->product->fetchProduct($productId);
        $showOnPos          = $productDetails['show_on_pos'] ?? 'Yes';
        $showOnPos          = ($showOnPos === 'Yes') ? 'No' : 'Yes';

        $this->product->updateProductSettings(
            $productId,
            $showOnPos,
            'show on pos',
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Update Point of Sale Success',
            'The point of sale has been updated successfully.'
        );
    }

    public function updateProductActivate(
        int $lastLogBy
    ) {
        $productId = $_POST['product_id'] ?? null;

        $productDetails     = $this->product->fetchProduct($productId);
        $unitId             = $productDetails['unit_id'] ?? null;

        $productCategoriesDetails = $this->product->fetchProductCategoryMap($productId) ?? [];

        if(empty($unitId) || empty($productCategoriesDetails)){
            $this->systemHelper::sendErrorResponse(
                'Product Activation Error',
                'Please fill-out all of the required fields before activating the product.'
            );
        }

        $this->product->updateProductUnarchive(
            $productId,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Product Activation Success',
            'The product has been activated successfully.'
        );
    }

    public function updateProductArchive(
        int $lastLogBy
    ) {
        $productId = $_POST['product_id'] ?? null;

        $this->product->updateProductArchive(
            $productId,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Product Archive Success',
            'The product has been archived successfully.'
        );
    }

    public function updateProductUnarchive(
        int $lastLogBy
    ) {
        $productId = $_POST['product_id'] ?? null;

        $this->product->updateProductUnarchive(
            $productId,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Product Unarchive Success',
            'The product has been unarchived successfully.'
        );
    }

    public function updateProductImage(
        int $lastLogBy
    ) {
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

        $this->product->updateProductImage(
            $productId,
            $filePath,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Update Product Image Success',
            'The product image has been updated successfully.'
        );
    }

    /* =============================================================================================
        SECTION 4: FETCH METHOD
    ============================================================================================= */

    public function fetchProductDetails() {
        $productId          = $_POST['product_id'] ?? null;
        $checkProductExist  = $this->product->checkProductExist($productId);
        $total              = $checkProductExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
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
            'sku'                   => $productDetails['sku'] ?? null,
            'barcode'               => $productDetails['barcode'] ?? null,
            'unitId'                => $productDetails['unit_id'] ?? null,
            'isSellable'            => $productDetails['is_sellable'] ?? 'Yes',
            'isPurchasable'         => $productDetails['is_purchasable'] ?? 'Yes',
            'showOnPos'             => $productDetails['show_on_pos'] ?? 'Yes',
            'quantityOnHand'        => $productDetails['quantity_on_hand'] ?? 0,
            'salesPrice'            => $productDetails['sales_price'] ?? 0,
            'cost'                  => $productDetails['cost'] ?? 0,
            'weight'                => $productDetails['weight'] ?? 0,
            'width'                 => $productDetails['width'] ?? 0,
            'height'                => $productDetails['height'] ?? 0,
            'length'                => $productDetails['length'] ?? 0,
            'productImage'          => $productImage
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchProductTaxDetails() {
        $productId          = $_POST['product_id'] ?? null;
        $checkProductExist  = $this->product->checkProductExist($productId);
        $total              = $checkProductExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Product Categories Details',
                'The product does not exist',
                ['notExist' => true]
            );
        }

        $salesTaxDetails = $this->product->fetchProductTax(
            $productId,
            'Sales'
        );

        $purchaseTaxDetails = $this->product->fetchProductTax(
            $productId,
            'Purchases'
        );

        $salesTax = [];
        foreach ($salesTaxDetails as $row) {
            $salesTax[] = $row['tax_id'];
        }

        $purchaseTax = [];
        foreach ($purchaseTaxDetails as $row) {
            $purchaseTax[] = $row['tax_id'];
        }

        $response = [
            'success'       => true,
            'salesTax'      => $salesTax,
            'purchaseTax'   => $purchaseTax
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchProductCategoryMapDetails() {
        $productId          = $_POST['product_id'] ?? null;
        $checkProductExist  = $this->product->checkProductExist($productId);
        $total              = $checkProductExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Product Categories Details',
                'The product does not exist',
                ['notExist' => true]
            );
        }

        $productCategoriesDetails = $this->product->fetchProductCategoryMap($productId);

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

    public function fetchProductPricelistDetails() {
        $productPricelistId         = $_POST['product_pricelist_id'] ?? null;
        $productPricelistDetails    = $this->product->fetchProductPricelist($productPricelistId);

        $response = [
            'success'               => true,
            'productId'             => $productPricelistDetails['product_id'] ?? '',
            'discountType'          => $productPricelistDetails['discount_type'] ?? 'Percentage',
            'fixedPrice'            => $productPricelistDetails['fixed_price'] ?? 0,
            'minQuantity'           => $productPricelistDetails['min_quantity'] ?? 0,
            'validityStartDate'     => $this->systemHelper->checkDate('empty', $productPricelistDetails['validity_start_date'] ?? null, '', 'M d, Y', ''),
            'validityEndDate'       => $this->systemHelper->checkDate('empty', $productPricelistDetails['validity_end_date'] ?? null, '', 'M d, Y', ''),
            'remarks'               => $productPricelistDetails['remarks'] ?? ''
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteProduct() {
        $productId          = $_POST['product_id'] ?? null;
        $productDetails     = $this->product->fetchProduct($productId);
        $productImage       = $productDetails['product_image'] ?? null;

        $this->systemHelper->deleteFileIfExist($productImage);

        $subProduct = $this->product->fetchAllProductSubProduct(
            $productId
        );

        foreach ($subProduct as $row) {
            $this->product->deleteProduct($row['product_id']);
        }

        $this->product->deleteProduct($productId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Product Success',
            'The product has been deleted successfully.'
        );
    }

    public function deleteMultipleProduct() {
        $productIds = $_POST['product_id'] ?? null;

        foreach($productIds as $productId){
            $productDetails     = $this->product->fetchProduct($productId);
            $productImage       = $productDetails['product_image'] ?? null;

            $this->systemHelper->deleteFileIfExist($productImage);

            $this->product->deleteProduct($productId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Products Success',
            'The selected products have been deleted successfully.'
        );
    }

    public function deleteProductAttribute() {
        $productAttributeId         = $_POST['product_attribute_id'] ?? null;
        $productAttributeDetails    = $this->product->fetchProductAttribute($productAttributeId);
        $productId                  = $productAttributeDetails['product_id'] ?? null;

        $this->product->deleteProductAttribute($productAttributeId);

        $this->rebuildProductVariants($productId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Product Attribute Success',
            'The product attribute was deleted and the variants have been regenerated.'
        );
    }

    public function deleteProductPricelist() {
        $productPricelistId = $_POST['product_pricelist_id'] ?? null;

        $this->product->deleteProductPricelist($productPricelistId);

        $this->systemHelper::sendSuccessResponse(
            'Product Pricelist Success',
            'The product pricelist has been deleted successfully.'
        );
    }

    public function deleteMultipleProductPricelist() {
        $productPricelistIds = $_POST['product_pricelist_id'] ?? null;

        foreach($productPricelistIds as $productPricelistId){
            $this->product->deleteProductPricelist($productPricelistId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Product Pricelists Success',
            'The selected product pricelists have been deleted successfully.'
        );
    }
    
    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateProductCard() {
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

        $products = $this->product->generateProductCard(
            $searchValue,
            $productTypeFilter,
            $productCategoryFilter,
            $isSellableFilter,
            $isPurchasableFilter,
            $showOnPosFilter,
            $productStatusFilter,
            $limit,
            $offset
        );

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

    public function generateProductTable() {
        $pageLink               = $_POST['page_link'] ?? null;
        $productTypeFilter      = $this->systemHelper->checkFilter($_POST['filter_by_product_type'] ?? null);
        $productCategoryFilter  = $this->systemHelper->checkFilter($_POST['filter_by_product_category'] ?? null);
        $isSellableFilter       = $this->systemHelper->checkFilter($_POST['filter_by_is_sellable'] ?? null);
        $isPurchasableFilter    = $this->systemHelper->checkFilter($_POST['filter_by_is_purchasable'] ?? null);
        $showOnPosFilter        = $this->systemHelper->checkFilter($_POST['filter_by_show_on_pos'] ?? null);
        $productStatusFilter    = $this->systemHelper->checkFilter($_POST['filter_by_product_status'] ?? null);
        $response               = [];

        $products = $this->product->generateProductTable(
            $productTypeFilter,
            $productCategoryFilter,
            $isSellableFilter,
            $isPurchasableFilter,
            $showOnPosFilter,
            $productStatusFilter
        );

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

            $productCategoriesDetails = $this->product->fetchProductCategoryMap($productId);

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
                                                <div class="fs-5 text-gray-900 fw-bold">'. $productName .'</div>
                                                <div class="fs-7 text-gray-500">'. $productDescription .'</div>
                                            </div>
                                        </div>',
                'SKU'           => $sku,
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

    public function generateProductVariantCard() {
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

        $products = $this->product->generateProductVariantCard(
            $searchValue,
            $productTypeFilter,
            $productCategoryFilter,
            $isSellableFilter,
            $isPurchasableFilter,
            $showOnPosFilter,
            $productStatusFilter,
            $limit,
            $offset
        );

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

    public function generateProductVariantTable() {
        $pageLink               = $_POST['page_link'] ?? null;
        $productTypeFilter      = $this->systemHelper->checkFilter($_POST['filter_by_product_type'] ?? null);
        $productCategoryFilter  = $this->systemHelper->checkFilter($_POST['filter_by_product_category'] ?? null);
        $isSellableFilter       = $this->systemHelper->checkFilter($_POST['filter_by_is_sellable'] ?? null);
        $isPurchasableFilter    = $this->systemHelper->checkFilter($_POST['filter_by_is_purchasable'] ?? null);
        $showOnPosFilter        = $this->systemHelper->checkFilter($_POST['filter_by_show_on_pos'] ?? null);
        $productStatusFilter    = $this->systemHelper->checkFilter($_POST['filter_by_product_status'] ?? null);
        $response               = [];

        $products = $this->product->generateProductVariantTable(
            $productTypeFilter,
            $productCategoryFilter,
            $isSellableFilter,
            $isPurchasableFilter,
            $showOnPosFilter,
            $productStatusFilter
        );

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

            $productCategoriesDetails = $this->product->fetchProductCategoryMap($productId);

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
                                                <div class="fs-5 text-gray-900 fw-bold">'. $productName .'</div>
                                                <div class="fs-7 text-gray-500">'. $productDescription .'</div>
                                            </div>
                                        </div>',
                'SKU'           => $sku,
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

    public function generateProductAttributeTable(
        int $userId,
        int $pageId
    ) {
        $productId  = $_POST['product_id'] ?? null;
        $response   = [];

        $writeAccess        = $this->authentication->checkUserPermission($userId, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($userId, $pageId, 'log notes')['total'] ?? 0;
        
        $productAttributes = $this->product->generateProductAttributeTable($productId);

        foreach ($productAttributes as $row) {
            $productAttributeId     = $row['product_attribute_id'];
            $attributeName          = $row['attribute_name'];
            $attributeValueName     = $row['attribute_value_name'];

            $deleteButton = '';
            if($writeAccess > 0){
                $deleteButton = '<button class="btn btn-icon btn-light btn-active-light-danger delete-product-attribute" data-product-attribute-id="' . $productAttributeId . '" title="Delete Attribute">
                                        <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                                    </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary view-product-attribute-log-notes" data-product-attribute-id="' . $productAttributeId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                    <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                                </button>';
            }

            $response[] = [
                'ATTRIBUTE_NAME'    => $attributeName,
                'VALUE'             => $attributeValueName,
                'ACTION'            => '<div class="d-flex justify-content-end gap-3">
                                            '. $logNotes .'
                                            '. $deleteButton .'
                                        </div>'
            ];
        }

        echo json_encode($response);
    }

    public function generateProductVariationTable() {        
        $pageLink   = $_POST['page_link'] ?? null;
        $productId  = $_POST['product_id'] ?? null;
        $response   = [];

        $productVariations = $this->product->generateProductVariationTable($productId);

        foreach ($productVariations as $row) {
            $productId      = $row['product_id'];
            $productName    = $row['product_name'];

            $productIdEncrypted = $this->security->encryptData($productId);
            $response[] = [
                'PRODUCT_NAME'  => $productName,
                'ACTION'        => '<div class="d-flex justify-content-end gap-3">
                                        <a href="'. $pageLink .'&id='. $productIdEncrypted .'" class="btn btn-icon btn-light btn-active-light-primary" target="_blank" title="View Product">
                                            <i class="ki-outline ki-eye fs-3 m-0 fs-5"></i>
                                        </a>
                                    </div>'
            ];
        }

        echo json_encode($response);
    }

    public function generateProductPricelistTable(
        int $userId,
        int $pageId
    ) {
        $productId  = $_POST['product_id'] ?? null;
        $response   = [];

        $writeAccess        = $this->authentication->checkUserPermission($userId, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($userId, $pageId, 'log notes')['total'] ?? 0;
        
        $productPricelists = $this->product->generateProductPricelistTable($productId);

        foreach ($productPricelists as $row) {
            $productPricelistId     = $row['product_pricelist_id'];
            $discountType           = $row['discount_type'];
            $fixedPrice             = $row['fixed_price'];
            $minQuantity            = $row['min_quantity'];
            $validityStartDate      = $this->systemHelper->checkDate('empty', $row['validity_start_date'] ?? null, '', 'd M Y', '');
            $validityEndDate        = $this->systemHelper->checkDate('empty', $row['validity_end_date'] ?? null, '', 'd M Y', '');
            $remarks                = $row['remarks'];

            $validity = empty($validityEndDate)
            ? 'Effective from ' . $validityStartDate
            : $validityStartDate . ' - ' . $validityEndDate;

            $deleteButton = '';
            if($writeAccess > 0){
                $deleteButton = '<button class="btn btn-icon btn-light btn-active-light-warning update-product-pricelist" data-bs-toggle="modal" data-bs-target="#product-pricelist-modal" data-product-pricelist-id="' . $productPricelistId . '">
                                    <i class="ki-outline ki-pencil fs-3 m-0 fs-5"></i>
                                </button>
                                <button class="btn btn-icon btn-light btn-active-light-danger delete-product-pricelist" data-product-pricelist-id="' . $productPricelistId . '">
                                    <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                                </button>';
            }
            
            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary view-product-pricelist-log-notes" data-product-pricelist-id="' . $productPricelistId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                    <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                                </button>';
            }

            $response[] = [
                'DISCOUNT_TYPE'     => $discountType,
                'FIXED_PRICE'       => number_format($fixedPrice, 2),
                'MIN_QUANTITY'      => number_format($minQuantity, 0),
                'VALIDITY'          => $validity,
                'REMARKS'           => $remarks,
                'ACTION'            => '<div class="d-flex justify-content-end gap-3">
                                            '. $logNotes .'
                                            '. $deleteButton .'
                                        </div>'
            ];
        }

        echo json_encode($response);
    }

    public function generatePricelistTable() {
        $pageLink               = $_POST['page_link'] ?? null;
        $productFilter          = $this->systemHelper->checkFilter($_POST['filter_by_product'] ?? null);
        $discountTypeFilter     = $this->systemHelper->checkFilter($_POST['filter_by_discount_type'] ?? null);
        $response               = [];

        $products = $this->product->generatePricelistTable(
            $productFilter,
            $discountTypeFilter
        );

        foreach ($products as $row) {
            $productPricelistId     = $row['product_pricelist_id'];
            $discountType           = $row['discount_type'];
            $productName            = $row['product_name'];
            $fixedPrice             = $row['fixed_price'];
            $minQuantity            = $row['min_quantity'];
            $validityStartDate      = $this->systemHelper->checkDate('empty', $row['validity_start_date'] ?? null, '', 'd M Y', '');
            $validityEndDate        = $this->systemHelper->checkDate('empty', $row['validity_end_date'] ?? null, '', 'd M Y', '');
            $remarks                = $row['remarks'];

            $validity = empty($validityEndDate)
            ? 'Effective from ' . $validityStartDate
            : $validityStartDate . ' - ' . $validityEndDate;

            $productPricelistIdEncrypted = $this->security->encryptData($productPricelistId);

            $response[] = [
                'CHECK_BOX'         => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                            <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $productPricelistId .'">
                                        </div>',
                'PRODUCT'           => $productName,
                'DISCOUNT_TYPE'     => $discountType,
                'FIXED_PRICE'       => number_format($fixedPrice, 2),
                'MIN_QUANTITY'      => number_format($minQuantity, 0),
                'VALIDITY'          => $validity,
                'REMARKS'           => $remarks,
                'LINK'              => $pageLink .'&id='. $productPricelistIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateProductOptions() {
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

    private function generateCombinations(
        array $groups
    ) {
        if (empty($groups)) {
            return [];
        }

        $result = [[]];
        foreach ($groups as $attributeName => $attributeData) {
            $temp = [];
            foreach ($result as $combo) {
                foreach ($attributeData['values'] as $value) {
                    $temp[] = array_merge($combo, [
                        [
                            'attribute_id' => $attributeData['attribute_id'],
                            'attribute_name' => $attributeName,
                            'attribute_value_id' => $value['attribute_value_id'],
                            'attribute_value_name' => $value['attribute_value_name']
                        ]
                    ]);
                }
            }
            $result = $temp;
        }
        return $result;
    }

    /* =============================================================================================
        SECTION 8: CUSTOM METHOD
    ============================================================================================= */

    private function rebuildProductVariants(
        int $productId
    ){
        $lastLogBy = $_SESSION['user_account_id'] ?? 1;

        $this->product->updateAllSubProductsDeactivate($productId, $lastLogBy);

        $productDetails = $this->product->fetchProduct($productId);
        $productName = $productDetails['product_name'] ?? '';

        $productAttributesInstantly = $this->product->fetchAllProductAttributes($productId, 'Instantly');
        $groupedAttributes = [];

        foreach ($productAttributesInstantly as $row) {
            $attributeName = $row['attribute_name'];
            $attributeId   = $row['attribute_id'];

            $groupedAttributes[$attributeName]['attribute_id'] = $attributeId;
            $groupedAttributes[$attributeName]['values'][] = [
                'attribute_value_id'   => $row['attribute_value_id'],
                'attribute_value_name' => $row['attribute_value_name']
            ];
        }

        $combinations = $this->generateCombinations($groupedAttributes);

        foreach ($combinations as $combination) {
            $attributeValueIds = array_column($combination, 'attribute_value_id');
            sort($attributeValueIds);
            $variantSignature = sha1($productId . '-' . implode('-', $attributeValueIds));

            $variantName = $productName . ' - ' . implode(' - ', array_column($combination, 'attribute_value_name'));

            $subproductId = $this->product->saveSubProductAndVariants(
                $productId,
                $productName,
                $variantName,
                $variantSignature,
                $lastLogBy
            );

            foreach ($combination as $attr) {
                $exists = $this->product->checkProductVariantExists($subproductId, $attr['attribute_value_id']);
                if ($exists['total'] == 0) {
                    $this->product->insertProductVariant(
                        $productId,
                        $productName,
                        $subproductId,
                        $variantName,
                        $attr['attribute_id'],
                        $attr['attribute_name'],
                        $attr['attribute_value_id'],
                        $attr['attribute_value_name'],
                        $lastLogBy
                    );
                }
            }
        }

        $productAttributesNever = $this->product->fetchAllProductAttributes($productId, 'Never');

        foreach ($productAttributesNever as $row) {
            $attributeId        = $row['attribute_id'];
            $attributeName      = $row['attribute_name'];
            $attributeValueId   = $row['attribute_value_id'];
            $attributeValueName = $row['attribute_value_name'];

            $variantSignature = sha1($productId . '-' . $attributeValueId);
            $variantName = $productName . ' - ' . $attributeValueName;

            $subproductId = $this->product->saveSubProductAndVariants(
                $productId,
                $productName,
                $variantName,
                $variantSignature,
                $lastLogBy
            );

            $exists = $this->product->checkProductVariantExists($subproductId, $attributeValueId);
            if ($exists['total'] == 0) {
                $this->product->insertProductVariant(
                    $productId,
                    $productName,
                    $subproductId,
                    $variantName,
                    $attributeId,
                    $attributeName,
                    $attributeValueId,
                    $attributeValueName,
                    $lastLogBy
                );
            }
        }
    }


    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
}

$controller = new ProductController(
    new Product(),
    new ProductCategory(),
    new Tax(),
    new Unit(),
    new Attribute(),
    new Authentication(),
    new UploadSetting(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();