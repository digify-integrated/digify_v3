<?php
namespace App\Controllers;


session_start();

use App\Models\CredentialType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class CredentialTypeController
{
    protected CredentialType $credentialType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        CredentialType $credentialType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->credentialType   = $credentialType;
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
            'save credential type'               => $this->saveCredentialType($lastLogBy),
            'delete credential type'             => $this->deleteCredentialType(),
            'delete multiple credential type'    => $this->deleteMultipleCredentialType(),
            'fetch credential type details'      => $this->fetchCredentialTypeDetails(),
            'generate credential type table'     => $this->generateCredentialTypeTable(),
            'generate credential type options'   => $this->generateCredentialTypeOptions(),
            default                              => $this->systemHelper::sendErrorResponse(
                                                        'Transaction Failed',
                                                        'We encountered an issue while processing your request.'
                                                    )
        };
    }

    public function saveCredentialType($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'credential_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $credentialTypeId      = $_POST['credential_type_id'] ?? null;
        $credentialTypeName    = $_POST['credential_type_name'] ?? null;

        $credentialTypeId              = $this->credentialType->saveCredentialType($credentialTypeId, $credentialTypeName, $lastLogBy);
        $encryptedCredentialTypeId     = $this->security->encryptData($credentialTypeId);

        $this->systemHelper->sendSuccessResponse(
            'Save Credential Type Success',
            'The credential type has been saved successfully.',
            ['credential_type_id' => $encryptedCredentialTypeId]
        );
    }

    public function deleteCredentialType(){
        $credentialTypeId = $_POST['credential_type_id'] ?? null;

        $this->credentialType->deleteCredentialType($credentialTypeId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Credential Type Success',
            'The credential type has been deleted successfully.'
        );
    }

    public function deleteMultipleCredentialType(){
        $credentialTypeIds = $_POST['credential_type_id'] ?? null;

        foreach($credentialTypeIds as $credentialTypeId){
            $this->credentialType->deleteCredentialType($credentialTypeId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Credential Types Success',
            'The selected credential types have been deleted successfully.'
        );
    }

    public function fetchCredentialTypeDetails(){
        $credentialTypeId           = $_POST['credential_type_id'] ?? null;
        $checkCredentialTypeExist   = $this->credentialType->checkCredentialTypeExist($credentialTypeId);
        $total                      = $checkCredentialTypeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Credential Type Details',
                'The credential type does not exist'
            );
        }

        $credentialTypeDetails   = $this->credentialType->fetchCredentialType($credentialTypeId);

        $response = [
            'success'               => true,
            'credentialTypeName'    => $credentialTypeDetails['credential_type_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateCredentialTypeTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $countries = $this->credentialType->generateCredentialTypeTable();

        foreach ($countries as $row) {
            $credentialTypeId      = $row['credential_type_id'];
            $credentialTypeName    = $row['credential_type_name'];

            $credentialTypeIdEncrypted = $this->security->encryptData($credentialTypeId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $credentialTypeId .'">
                                            </div>',
                'CREDENTIAL_TYPE_NAME'  => $credentialTypeName,
                'LINK'                  => $pageLink .'&id='. $credentialTypeIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateCredentialTypeOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $countries = $this->credentialType->generateCredentialTypeOptions();

        foreach ($countries as $row) {
            $response[] = [
                'id'    => $row['credential_type_id'],
                'text'  => $row['credential_type_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new CredentialTypeController(
    new CredentialType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
