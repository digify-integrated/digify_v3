<?php
namespace App\Controllers;


session_start();

use App\Models\ContactInformationType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class ContactInformationTypeController
{
    protected ContactInformationType $contactInformationType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        ContactInformationType $contactInformationType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->contactInformationType   = $contactInformationType;
        $this->authentication           = $authentication;
        $this->security                 = $security;
        $this->systemHelper             = $systemHelper;
    }

    public function handleRequest() 
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
            'save contact information type'                 => $this->saveContactInformationType($lastLogBy),
            'delete contact information type'               => $this->deleteContactInformationType(),
            'delete multiple contact information type'      => $this->deleteMultipleContactInformationType(),
            'fetch contact information type details'        => $this->fetchContactInformationTypeDetails(),
            'generate contact information type table'       => $this->generateContactInformationTypeTable(),
            'generate contact information type options'     => $this->generateContactInformationTypeOptions(),
            default                                         => $this->systemHelper::sendErrorResponse(
                                                                    'Transaction Failed',
                                                                    'We encountered an issue while processing your request.'
                                                                )
        };
    }

    public function saveContactInformationType($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'contact_information_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $contactInformationTypeId       = $_POST['contact_information_type_id'] ?? null;
        $contactInformationTypeName     = $_POST['contact_information_type_name'] ?? null;

        $contactInformationTypeId           = $this->contactInformationType->saveContactInformationType($contactInformationTypeId, $contactInformationTypeName, $lastLogBy);
        $encryptedContactInformationTypeId  = $this->security->encryptData($contactInformationTypeId);

        $this->systemHelper->sendSuccessResponse(
            'Save Contact Information Type Success',
            'The contact information type has been saved successfully.',
            ['contact_information_type_id' => $encryptedContactInformationTypeId]
        );
    }

    public function deleteContactInformationType(){
        $contactInformationTypeId = $_POST['contact_information_type_id'] ?? null;

        $this->contactInformationType->deleteContactInformationType($contactInformationTypeId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Contact Information Type Success',
            'The contact information type has been deleted successfully.'
        );
    }

    public function deleteMultipleContactInformationType(){
        $contactInformationTypeIds = $_POST['contact_information_type_id'] ?? null;

        foreach($contactInformationTypeIds as $contactInformationTypeId){
            $this->contactInformationType->deleteContactInformationType($contactInformationTypeId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Contact Information Types Success',
            'The selected contact information types have been deleted successfully.'
        );
    }

    public function fetchContactInformationTypeDetails(){
        $contactInformationTypeId           = $_POST['contact_information_type_id'] ?? null;
        $checkContactInformationTypeExist   = $this->contactInformationType->checkContactInformationTypeExist($contactInformationTypeId);
        $total                              = $checkContactInformationTypeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Contact Information Type Details',
                'The contact information type does not exist',
                ['notExist' => true]
            );
        }

        $contactInformationTypeDetails = $this->contactInformationType->fetchContactInformationType($contactInformationTypeId);

        $response = [
            'success'                       => true,
            'contactInformationTypeName'    => $contactInformationTypeDetails['contact_information_type_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateContactInformationTypeTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $contactInformationTypes = $this->contactInformationType->generateContactInformationTypeTable();

        foreach ($contactInformationTypes as $row) {
            $contactInformationTypeId       = $row['contact_information_type_id'];
            $contactInformationTypeName     = $row['contact_information_type_name'];

            $contactInformationTypeIdEncrypted = $this->security->encryptData($contactInformationTypeId);

            $response[] = [
                'CHECK_BOX'                         => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                            <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $contactInformationTypeId .'">
                                                        </div>',
                'CONTACT_INFORMATION_TYPE_NAME'     => $contactInformationTypeName,
                'LINK'                              => $pageLink .'&id='. $contactInformationTypeIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateContactInformationTypeOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $contactInformationTypes = $this->contactInformationType->generateContactInformationTypeOptions();

        foreach ($contactInformationTypes as $row) {
            $response[] = [
                'id'    => $row['contact_information_type_id'],
                'text'  => $row['contact_information_type_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new ContactInformationTypeController(
    new ContactInformationType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
