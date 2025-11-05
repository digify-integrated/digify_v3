<?php
namespace App\Controllers;

session_start();

use App\Models\AddressType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class AddressTypeController {
    protected AddressType $addressType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        AddressType $addressType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->addressType      = $addressType;
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
                    'invalid_session' => true,
                    'redirect_link' => 'logout.php?logout'
                ]
            );
        }

        $transaction = strtolower(trim($transaction));

        match ($transaction) {
            'save address type'                 => $this->saveAddressType($lastLogBy),
            'delete address type'               => $this->deleteAddressType(),
            'delete multiple address type'      => $this->deleteMultipleAddressType(),
            'fetch address type details'        => $this->fetchAddressTypeDetails(),
            'generate address type table'       => $this->generateAddressTypeTable(),
            'generate address type options'     => $this->generateAddressTypeOptions(),
            default                             => $this->systemHelper::sendErrorResponse(
                                                        'Transaction Failed',
                                                        'We encountered an issue while processing your request.'
                                                    )
        };
    }

    public function saveAddressType(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'address_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $addressTypeId      = $_POST['address_type_id'] ?? null;
        $addressTypeName    = $_POST['address_type_name'] ?? null;

        $addressTypeId = $this->addressType->saveAddressType(
            $addressTypeId, 
            $addressTypeName, 
            $lastLogBy
        );

        $encryptedAddressTypeId = $this->security->encryptData($addressTypeId);

        $this->systemHelper->sendSuccessResponse(
            'Save Address Type Success',
            'The address type has been saved successfully.',
            ['address_type_id' => $encryptedAddressTypeId]
        );
    }

    public function deleteAddressType(){
        $addressTypeId = $_POST['address_type_id'] ?? null;

        $this->addressType->deleteAddressType($addressTypeId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Address Type Success',
            'The address type has been deleted successfully.'
        );
    }

    public function deleteMultipleAddressType(){
        $addressTypeIds = $_POST['address_type_id'] ?? null;

        foreach($addressTypeIds as $addressTypeId){
            $this->addressType->deleteAddressType($addressTypeId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Address Types Success',
            'The selected address types have been deleted successfully.'
        );
    }

    public function fetchAddressTypeDetails(){
        $addressTypeId          = $_POST['address_type_id'] ?? null;
        $checkAddressTypeExist  = $this->addressType->checkAddressTypeExist($addressTypeId);
        $total                  = $checkAddressTypeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Address Type Details',
                'The address type does not exist',
                ['notExist' => true]
            );
        }

        $addressTypeDetails = $this->addressType->fetchAddressType($addressTypeId);

        $response = [
            'success'           => true,
            'addressTypeName'   => $addressTypeDetails['address_type_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateAddressTypeTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $addressTypes = $this->addressType->generateAddressTypeTable();

        foreach ($addressTypes as $row) {
            $addressTypeId      = $row['address_type_id'];
            $addressTypeName    = $row['address_type_name'];

            $addressTypeIdEncrypted = $this->security->encryptData($addressTypeId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $addressTypeId .'">
                                            </div>',
                'ADDRESS_TYPE_NAME'     => $addressTypeName,
                'LINK'                  => $pageLink .'&id='. $addressTypeIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateAddressTypeOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $countries = $this->addressType->generateAddressTypeOptions();

        foreach ($countries as $row) {
            $response[] = [
                'id'    => $row['address_type_id'],
                'text'  => $row['address_type_name']
            ];
        }

        echo json_encode($response);
    }
}

$controller = new AddressTypeController(
    new AddressType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();