<?php
namespace App\Controllers;

session_start();

use App\Models\ShopType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class ShopTypeController {
    protected ShopType $shopType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        ShopType $shopType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->shopType  = $shopType;
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
            'save shop type'                => $this->saveShopType($lastLogBy),
            'delete shop type'              => $this->deleteShopType(),
            'delete multiple shop type'     => $this->deleteMultipleShopType(),
            'fetch shop type details'       => $this->fetchShopTypeDetails(),
            'generate shop type table'      => $this->generateShopTypeTable(),
            'generate shop type options'    => $this->generateShopTypeOptions(),
            default                         => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveShopType(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'shop_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $shopTypeId     = $_POST['shop_type_id'] ?? null;
        $shopTypeName   = $_POST['shop_type_name'] ?? null;

        $shopTypeId = $this->shopType->saveShopType(
            $shopTypeId,
            $shopTypeName,
            $lastLogBy
        );
        
        $encryptedShopTypeId = $this->security->encryptData($shopTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Save Shop Type Success',
            'The shop type has been saved successfully.',
            ['shop_type_id' => $encryptedShopTypeId]
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

    public function fetchShopTypeDetails() {
        $shopTypeId         = $_POST['shop_type_id'] ?? null;
        $checkShopTypeExist = $this->shopType->checkShopTypeExist($shopTypeId);
        $total              = $checkShopTypeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Shop Type Details',
                'The shop type does not exist',
                ['notExist' => true]
            );
        }

        $shopTypeDetails = $this->shopType->fetchShopType($shopTypeId);

        $response = [
            'success'       => true,
            'shopTypeName'  => $shopTypeDetails['shop_type_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteShopType() {
        $shopTypeId = $_POST['shop_type_id'] ?? null;

        $this->shopType->deleteShopType($shopTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Shop Type Success',
            'The shop type has been deleted successfully.'
        );
    }

    public function deleteMultipleShopType() {
        $shopTypeIds = $_POST['shop_type_id'] ?? null;

        foreach($shopTypeIds as $shopTypeId){
            $this->shopType->deleteShopType($shopTypeId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Shop Types Success',
            'The selected shop types have been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateShopTypeTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $shopTypes = $this->shopType->generateShopTypeTable();

        foreach ($shopTypes as $row) {
            $shopTypeId     = $row['shop_type_id'];
            $shopTypeName   = $row['shop_type_name'];

            $shopTypeIdEncrypted = $this->security->encryptData($shopTypeId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                    <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $shopTypeId .'">
                                                </div>',
                'SHOP_TYPE_NAME'   => $shopTypeName,
                'LINK'                  => $pageLink .'&id='. $shopTypeIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateShopTypeOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $shopTypes = $this->shopType->generateShopTypeOptions();

        foreach ($shopTypes as $row) {
            $response[] = [
                'id'    => $row['shop_type_id'],
                'text'  => $row['shop_type_name']
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

$controller = new ShopTypeController(
    new ShopType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();