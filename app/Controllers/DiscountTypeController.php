<?php
namespace App\Controllers;

session_start();

use App\Models\DiscountType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class DiscountTypeController {
    protected DiscountType $discountType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        DiscountType $discountType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->discountType  = $discountType;
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
            'save discount type'                => $this->saveDiscountType($lastLogBy),
            'delete discount type'              => $this->deleteDiscountType(),
            'delete multiple discount type'     => $this->deleteMultipleDiscountType(),
            'fetch discount type details'       => $this->fetchDiscountTypeDetails(),
            'generate discount type table'      => $this->generateDiscountTypeTable(),
            'generate discount type options'    => $this->generateDiscountTypeOptions(),
            default                             => $this->systemHelper::sendErrorResponse(
                                                        'Transaction Failed',
                                                        'We encountered an issue while processing your request.'
                                                    )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveDiscountType(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'discount_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $discountTypeId     = $_POST['discount_type_id'] ?? null;
        $discountTypeName   = $_POST['discount_type_name'] ?? null;
        $valueType          = $_POST['value_type'] ?? null;
        $discountValue      = $_POST['discount_value'] ?? null;
        $isVariable         = $_POST['is_variable'] ?? null;
        $affectsTax         = $_POST['affects_tax'] ?? null;

        $discountTypeId = $this->discountType->saveDiscountType(
            $discountTypeId,
            $discountTypeName,
            $valueType,
            $discountValue,
            $isVariable,
            $affectsTax,
            $lastLogBy
        );

        $encryptedDiscountTypeId = $this->security->encryptData($discountTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Save Discount Type Success',
            'The discount type has been saved successfully.',
            ['discount_type_id' => $encryptedDiscountTypeId]
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

    public function fetchDiscountTypeDetails() {
        $discountTypeId          = $_POST['discount_type_id'] ?? null;
        $checkDiscountTypeExist  = $this->discountType->checkDiscountTypeExist($discountTypeId);
        $total                      = $checkDiscountTypeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Discount Type Details',
                'The discount type does not exist',
                ['notExist' => true]
            );
        }

        $discountTypeDetails = $this->discountType->fetchDiscountType($discountTypeId);

        $response = [
            'success'           => true,
            'discountTypeName'  => $discountTypeDetails['discount_type_name'] ?? null,
            'valueType'         => $discountTypeDetails['value_type'] ?? null,
            'discountValue'     => $discountTypeDetails['discount_value'] ?? null,
            'isVariable'        => $discountTypeDetails['is_variable'] ?? null,
            'affectsTax'        => $discountTypeDetails['affects_tax'] ?? null,
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteDiscountType() {
        $discountTypeId = $_POST['discount_type_id'] ?? null;

        $this->discountType->deleteDiscountType($discountTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Discount Type Success',
            'The discount type has been deleted successfully.'
        );
    }

    public function deleteMultipleDiscountType() {
        $discountTypeIds = $_POST['discount_type_id'] ?? null;

        foreach($discountTypeIds as $discountTypeId){
            $this->discountType->deleteDiscountType($discountTypeId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Discount Types Success',
            'The selected discount types have been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateDiscountTypeTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $discountTypes = $this->discountType->generateDiscountTypeTable();

        foreach ($discountTypes as $row) {
            $discountTypeId     = $row['discount_type_id'];
            $discountTypeName   = $row['discount_type_name'];
            $valueType          = $row['value_type'];
            $discountValue      = $row['discount_value'];
            $isVariable         = $row['is_variable'];
            $affectsTax         = $row['affects_tax'];

            $discountTypeIdEncrypted = $this->security->encryptData($discountTypeId);

            $response[] = [
                'CHECK_BOX'         => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                            <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $discountTypeId .'">
                                        </div>',
                'DISCOUNT_NAME'     => $discountTypeName,
                'VALUE_TYPE'        => $valueType,
                'DISCOUNT_VALUE'    => $discountValue,
                'IS_VARIABLE'       => $isVariable,
                'AFFECTS_TAX'       => $affectsTax,
                'LINK'              => $pageLink .'&id='. $discountTypeIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateDiscountTypeOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $discountTypes = $this->discountType->generateDiscountTypeOptions();

        foreach ($discountTypes as $row) {
            $response[] = [
                'id'    => $row['discount_type_id'],
                'text'  => $row['discount_type_name']
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

$controller = new DiscountTypeController(
    new DiscountType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();