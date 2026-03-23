<?php
namespace App\Controllers;

session_start();

use App\Models\ChargeType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class ChargeTypeController {
    protected ChargeType $chargeType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        ChargeType $chargeType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->chargeType  = $chargeType;
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
            'save charge type'                  => $this->saveChargeType($lastLogBy),
            'delete charge type'                => $this->deleteChargeType(),
            'delete multiple charge type'       => $this->deleteMultipleChargeType(),
            'fetch charge type details'         => $this->fetchChargeTypeDetails(),
            'generate charge type table'        => $this->generateChargeTypeTable(),
            'generate charge type options'      => $this->generateChargeTypeOptions(),
            default                             => $this->systemHelper::sendErrorResponse(
                                                        'Transaction Failed',
                                                        'We encountered an issue while processing your request.'
                                                    )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveChargeType(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'charge_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $chargeTypeId       = $_POST['charge_type_id'] ?? null;
        $chargeTypeName     = $_POST['charge_type_name'] ?? null;
        $valueType          = $_POST['value_type'] ?? null;
        $chargeValue        = $_POST['charge_value'] ?? null;
        $isVariable         = $_POST['is_variable'] ?? null;
        $affectsTax         = $_POST['affects_tax'] ?? null;

        $chargeTypeId = $this->chargeType->saveChargeType(
            $chargeTypeId,
            $chargeTypeName,
            $valueType,
            $chargeValue,
            $isVariable,
            $affectsTax,
            $lastLogBy
        );

        $encryptedChargeTypeId = $this->security->encryptData($chargeTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Save Charge Type Success',
            'The charge type has been saved successfully.',
            ['charge_type_id' => $encryptedChargeTypeId]
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

    public function fetchChargeTypeDetails() {
        $chargeTypeId          = $_POST['charge_type_id'] ?? null;
        $checkChargeTypeExist  = $this->chargeType->checkChargeTypeExist($chargeTypeId);
        $total                      = $checkChargeTypeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Charge Type Details',
                'The charge type does not exist',
                ['notExist' => true]
            );
        }

        $chargeTypeDetails = $this->chargeType->fetchChargeType($chargeTypeId);

        $response = [
            'success'           => true,
            'chargeTypeName'    => $chargeTypeDetails['charge_type_name'] ?? null,
            'valueType'         => $chargeTypeDetails['value_type'] ?? null,
            'chargeValue'       => $chargeTypeDetails['charge_value'] ?? null,
            'isVariable'        => $chargeTypeDetails['is_variable'] ?? null,
            'affectsTax'        => $chargeTypeDetails['affects_tax'] ?? null,
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteChargeType() {
        $chargeTypeId = $_POST['charge_type_id'] ?? null;

        $this->chargeType->deleteChargeType($chargeTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Charge Type Success',
            'The charge type has been deleted successfully.'
        );
    }

    public function deleteMultipleChargeType() {
        $chargeTypeIds = $_POST['charge_type_id'] ?? null;

        foreach($chargeTypeIds as $chargeTypeId){
            $this->chargeType->deleteChargeType($chargeTypeId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Charge Types Success',
            'The selected charge types have been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateChargeTypeTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $chargeTypes = $this->chargeType->generateChargeTypeTable();

        foreach ($chargeTypes as $row) {
            $chargeTypeId     = $row['charge_type_id'];
            $chargeTypeName   = $row['charge_type_name'];
            $valueType          = $row['value_type'];
            $chargeValue      = $row['charge_value'];
            $isVariable         = $row['is_variable'];
            $affectsTax         = $row['affects_tax'];

            $chargeTypeIdEncrypted = $this->security->encryptData($chargeTypeId);

            $response[] = [
                'CHECK_BOX'     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $chargeTypeId .'">
                                    </div>',
                'CHARGE_NAME'   => $chargeTypeName,
                'VALUE_TYPE'    => $valueType,
                'CHARGE_VALUE'  => $chargeValue,
                'IS_VARIABLE'   => $isVariable,
                'AFFECTS_TAX'   => $affectsTax,
                'LINK'          => $pageLink .'&id='. $chargeTypeIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateChargeTypeOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $chargeTypes = $this->chargeType->generateChargeTypeOptions();

        foreach ($chargeTypes as $row) {
            $response[] = [
                'id'    => $row['charge_type_id'],
                'text'  => $row['charge_type_name']
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

$controller = new ChargeTypeController(
    new ChargeType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();