<?php
namespace App\Controllers;


session_start();

use App\Models\Gender;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class GenderController
{
    protected Gender $gender;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Gender $gender,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->gender           = $gender;
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
            'save gender'               => $this->saveGender($lastLogBy),
            'delete gender'             => $this->deleteGender(),
            'delete multiple gender'    => $this->deleteMultipleGender(),
            'fetch gender details'      => $this->fetchGenderDetails(),
            'generate gender table'     => $this->generateGenderTable(),
            'generate gender options'   => $this->generateGenderOptions(),
            default                     => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    public function saveGender($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'gender_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $genderId      = $_POST['gender_id'] ?? null;
        $genderName    = $_POST['gender_name'] ?? null;

        $genderId           = $this->gender->saveGender($genderId, $genderName, $lastLogBy);
        $encryptedGenderId  = $this->security->encryptData($genderId);

        $this->systemHelper->sendSuccessResponse(
            'Save Gender Success',
            'The gender has been saved successfully.',
            ['gender_id' => $encryptedGenderId]
        );
    }

    public function deleteGender(){
        $genderId = $_POST['gender_id'] ?? null;

        $this->gender->deleteGender($genderId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Gender Success',
            'The gender has been deleted successfully.'
        );
    }

    public function deleteMultipleGender(){
        $genderIds  = $_POST['gender_id'] ?? null;

        foreach($genderIds as $genderId){
            $this->gender->deleteGender($genderId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Genders Success',
            'The selected genders have been deleted successfully.'
        );
    }

    public function fetchGenderDetails(){
        $genderId            = $_POST['gender_id'] ?? null;
        $checkGenderyExist   = $this->gender->checkGenderExist($genderId);
        $total               = $checkGenderyExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Gender Details',
                'The gender does not exist'
            );
        }

        $genderDetails   = $this->gender->fetchGender($genderId);

        $response = [
            'success'       => true,
            'genderName'    => $genderDetails['gender_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateGenderTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $countries = $this->gender->generateGenderTable();

        foreach ($countries as $row) {
            $genderId      = $row['gender_id'];
            $genderName    = $row['gender_name'];

            $genderIdEncrypted = $this->security->encryptData($genderId);

            $response[] = [
                'CHECK_BOX'     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $genderId .'">
                                    </div>',
                'GENDER_NAME'   => $genderName,
                'LINK'          => $pageLink .'&id='. $genderIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateGenderOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $countries = $this->gender->generateGenderOptions();

        foreach ($countries as $row) {
            $response[] = [
                'id'    => $row['gender_id'],
                'text'  => $row['gender_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new GenderController(
    new Gender(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
