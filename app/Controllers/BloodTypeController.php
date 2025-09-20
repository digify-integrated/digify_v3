<?php
namespace App\Controllers;


session_start();

use App\Models\BloodType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class BloodTypeController
{
    protected BloodType $bloodType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        BloodType $bloodType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->bloodType        = $bloodType;
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
            'save blood type'               => $this->saveBloodType($lastLogBy),
            'delete blood type'             => $this->deleteBloodType(),
            'delete multiple blood type'    => $this->deleteMultipleBloodType(),
            'fetch blood type details'      => $this->fetchBloodTypeDetails(),
            'generate blood type table'     => $this->generateBloodTypeTable(),
            'generate blood type options'   => $this->generateBloodTypeOptions(),
            default                      => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    public function saveBloodType($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'blood_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $bloodTypeId      = $_POST['blood_type_id'] ?? null;
        $bloodTypeName    = $_POST['blood_type_name'] ?? null;

        $bloodTypeId              = $this->bloodType->saveBloodType($bloodTypeId, $bloodTypeName, $lastLogBy);

        $encryptedBloodTypeId     = $this->security->encryptData($bloodTypeId);

        $this->systemHelper->sendSuccessResponse(
            'Save Blood Type Success',
            'The blood type has been saved successfully.',
            ['blood_type_id' => $encryptedBloodTypeId]
        );
    }

    public function deleteBloodType(){
        $bloodTypeId = $_POST['blood_type_id'] ?? null;

        $this->bloodType->deleteBloodType($bloodTypeId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Blood Type Success',
            'The blood type has been deleted successfully.'
        );
    }

    public function deleteMultipleBloodType(){
        $bloodTypeIds  = $_POST['blood_type_id'] ?? null;

        foreach($bloodTypeIds as $bloodTypeId){
            $this->bloodType->deleteBloodType($bloodTypeId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Blood Types Success',
            'The selected blood types have been deleted successfully.'
        );
    }

    public function fetchBloodTypeDetails(){
        $bloodTypeId            = $_POST['blood_type_id'] ?? null;
        $checkBloodTypeyExist   = $this->bloodType->checkBloodTypeExist($bloodTypeId);
        $total                  = $checkBloodTypeyExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Blood Type Details',
                'The blood type does not exist'
            );
        }

        $bloodTypeDetails   = $this->bloodType->fetchBloodType($bloodTypeId);

        $response = [
            'success'       => true,
            'bloodTypeName'   => $bloodTypeDetails['blood_type_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateBloodTypeTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $countries = $this->bloodType->generateBloodTypeTable();

        foreach ($countries as $row) {
            $bloodTypeId      = $row['blood_type_id'];
            $bloodTypeName    = $row['blood_type_name'];

            $bloodTypeIdEncrypted = $this->security->encryptData($bloodTypeId);

            $response[] = [
                'CHECK_BOX' => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $bloodTypeId .'">
                                    </div>',
                'BLOOD_TYPE_NAME' => $bloodTypeName,
                'LINK'          => $pageLink .'&id='. $bloodTypeIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateBloodTypeOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $countries = $this->bloodType->generateBloodTypeOptions();

        foreach ($countries as $row) {
            $response[] = [
                'id'    => $row['blood_type_id'],
                'text'  => $row['blood_type_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new BloodTypeController(
    new BloodType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
