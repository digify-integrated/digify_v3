<?php
namespace App\Controllers;

session_start();

use App\Models\UserAccount;
use App\Models\Role;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class UserAccountController
{
    protected UserAccount $userAccount;
    protected Role $role;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        UserAccount $userAccount,
        Role $role,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->userAccount         = $userAccount;
        $this->role             = $role;
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
                    'invalid_session' => true,
                    'redirect_link' => 'logout.php?logout'
                    ]
            );
        }

        $transaction = strtolower(trim($transaction));

        match ($transaction) {
            'save user account'                                 => $this->saveUserAccount($lastLogBy),
            'update user account full name'                     => $this->updateUserAccountFullName($lastLogBy),
            'update user account email'                         => $this->updateUserAccountEmail($lastLogBy),
            'update user account phone'                         => $this->updateUserAccountPhone($lastLogBy),
            'update user account password'                      => $this->updateUserAccountPassword($lastLogBy),
            'update user account two factor authentication'     => $this->updateUserAccountTwoFactorAuthentication($lastLogBy),
            'update user account multiple login sessions'       => $this->updateUserAccountMultipleLoginSession($lastLogBy),
            'fetch user account details'                        => $this->fetchUserAccountDetails(),
            'generate user account table'                       => $this->generateUserAccountTable(),
            default                                             => $this->systemHelper::sendErrorResponse(
                                                                        'Transaction Failed',
                                                                        'We encountered an issue while processing your request.'
                                                                    )
        };
    }

    public function saveUserAccount($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'user_account_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $fileAs     = $_POST['file_as'] ?? null;
        $email      = $_POST['email'] ?? null;
        $phone      = $_POST['phone'] ?? null;
        $password   = $_POST['password'] ?? null;

        $hashedPassword = password_hash($password, PASSWORD_BCRYPT);

        $userAccountId = $this->userAccount->insertUserAccount($fileAs, $email, $hashedPassword, $phone, $lastLogBy);
        $encryptedUserAccountId = $this->security->encryptData($userAccountId);

        $this->systemHelper->sendSuccessResponse(
            'Save User Account Success',
            'The user account has been saved successfully.',
            ['user_account_id' => $encryptedUserAccountId]
        );
    }

    public function updateUserAccountFullName($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_full_name_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $userAccountId  = $_POST['user_account_id'] ?? null;
        $fullName       = $_POST['full_name'] ?? null;

        $this->userAccount->updateUserAccount($userAccountId, $fullName, 'full name', $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save User Account Full Name Success',
            'The full name has been saved successfully.'
        );
    }

    public function updateUserAccountEmail($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_email_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $userAccountId  = $_POST['user_account_id'] ?? null;
        $email          = $_POST['email'] ?? null;

        $checkUserAccountEmailExist = $this->userAccount->checkUserAccountEmailExist($userAccountId, $email);
        $total                      = $checkUserAccountEmailExist['total'] ?? 0;

        if($total > 0){
            $this->systemHelper::sendErrorResponse(
                'Save User Account Email Error',
                'The new email address already exists.'
            );  
        }

        $this->userAccount->updateUserAccount($userAccountId, $email, 'email', $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save User Account Email Success',
            'The email has been saved successfully.'
        );
    }

    public function updateUserAccountPhone($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_phone_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $userAccountId  = $_POST['user_account_id'] ?? null;
        $phone          = $_POST['phone'] ?? null;

        $checkUserAccountPhoneExist = $this->userAccount->checkUserAccountPhoneExist($userAccountId, $phone);
        $total                      = $checkUserAccountPhoneExist['total'] ?? 0;

        if($total > 0){
            $this->systemHelper::sendErrorResponse(
                'Save User Account Phone Error',
                'The new phone already exists.'
            );  
        }

        $this->userAccount->updateUserAccount($userAccountId, $phone, 'phone', $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save User Account Phone Success',
            'The phone has been saved successfully.'
        );
    }

    public function updateUserAccountPassword($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_password_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $userAccountId  = $_POST['user_account_id'] ?? null;
        $newPassword    = $_POST['new_password'] ?? null;

        $hashedPassword = password_hash($newPassword, PASSWORD_BCRYPT);

        $this->userAccount->updateUserAccount($userAccountId, $hashedPassword, 'password', $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save User Account Password Success',
            'The password has been saved successfully.'
        );
    }

    public function updateUserAccountTwoFactorAuthentication($lastLogBy){
        $userAccountId          = $_POST['user_account_id'] ?? null;
        $userAccountDetails     = $this->userAccount->fetchUserAccount($userAccountId);
        $twoFactorAuth          = $userAccountDetails['two_factor_auth'] ?? 'Yes';
        $twoFactorAuth          = ($twoFactorAuth === 'Yes') ? 'No' : 'Yes';

        $this->userAccount->updateUserAccount($userAccountId, $twoFactorAuth, 'two factor auth', $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Update Two-factor Authentication Success',
            'The two-factor authentication has been updated successfully.'
        );
    }

    public function updateUserAccountMultipleLoginSession($lastLogBy){
        $userAccountId          = $_POST['user_account_id'] ?? null;
        $userAccountDetails     = $this->userAccount->fetchUserAccount($userAccountId);
        $multipleSession        = $userAccountDetails['multiple_session'] ?? 'Yes';
        $multipleSession        = ($multipleSession === 'Yes') ? 'No' : 'Yes';

        $this->userAccount->updateUserAccount($userAccountId, $multipleSession, 'multiple session', $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Update Multiple Login Session Success',
            'The multiple login session has been updated successfully.'
        );
    }

    public function fetchUserAccountDetails(){
        $userAccountId             = $_POST['user_account_id'] ?? null;
        $checkUserAccountExist     = $this->userAccount->checkUserAccountExist($userAccountId);
        $total                     = $checkUserAccountExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get User Account Details',
                'The user account does not exist'
            );
        }

        $userAccountDetails = $this->userAccount->fetchUserAccount($userAccountId);
        $profilePicture = $this->systemHelper->checkImageExist($userAccountDetails['profile_picture'] ?? null, 'profile');
        $lastConnectionDate = (!empty($userAccountDetails['last_connection_date'])) ? date('d M Y h:i a', strtotime($userAccountDetails['last_connection_date'])) : 'Never Connected';
        $lastFailedConnectionDate = (!empty($userAccountDetails['last_failed_connection_date'])) ? date('d M Y h:i a', strtotime($userAccountDetails['last_failed_connection_date'])) : 'No record';
        $lastPasswordChange = (!empty($userAccountDetails['last_password_change'])) ? date('d M Y h:i a', strtotime($userAccountDetails['last_password_change'])) : 'Never Changed';
        $lastPasswordResetRequest = (!empty($userAccountDetails['last_password_reset_request'])) ? date('d M Y h:i a', strtotime($userAccountDetails['last_password_reset_request'])) : 'Never Requested';

        $activeBadge = $userAccountDetails['active'] ?? 'No' == 'Yes' ? '<span class="badge badge-light-success">Active</span>' : '<span class="badge badge-light-danger">Inactive</span>';

        $response = [
            'success' => true,
            'fileAs' => $userAccountDetails['file_as'] ?? null,
            'email' => $userAccountDetails['email'] ?? null,
            'phone' => $userAccountDetails['phone'] ?? null,
            'phoneSummary' => $userAccountDetails['phone'] ?? '-',
            'lastConnectionDate' => $lastConnectionDate,
            'lastFailedConnectionDate' => $lastFailedConnectionDate,
            'lastPasswordChange' => $lastPasswordChange,
            'lastPasswordResetRequest' => $lastPasswordResetRequest,
            'profilePicture' => $profilePicture,
            'activeBadge' => $activeBadge,
            'twoFactorAuthentication' => $userAccountDetails['two_factor_auth'],
            'multipleSession' => $userAccountDetails['multiple_session']
        ];

        echo json_encode($response);
        exit;
    }

    public function generateUserAccountTable()
    {
        $filterStatus   = $_POST['user_account_status_filter'] ?? null;
        $pageLink       = $_POST['page_link'] ?? null;
        $response       = [];

        $userAccounts = $this->userAccount->generateUserAccountTable($filterStatus);

        foreach ($userAccounts as $row) {
            $userAccountId = $row['user_account_id'];
            $fileAs = $row['file_as'];
            $email = $row['email'];
            $active = $row['active'];
            $lastConnectionDate = empty($row['last_connection_date']) ? 'Never Connected' : $this->systemHelper->checkDate('empty', $row['last_connection_date'], '', 'd M Y h:i:s a', '');
            $profilePicture = $this->systemHelper->checkImageExist($row['profile_picture'], 'profile');

            $activeBadge = $active == 'Yes' ? '<span class="badge badge-light-success">Active</span>' : '<span class="badge badge-light-danger">Inactive</span>';

            $userAccountIdEncrypted = $this->security->encryptData($userAccountId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $userAccountId .'">
                                            </div>',
                'USER_ACCOUNT'          => '<div class="d-flex align-items-center">
                                                <div class="symbol symbol-circle symbol-50px overflow-hidden me-3">
                                                    <div class="symbol-label">
                                                        <img src="'. $profilePicture .'" alt="'. $fileAs .'" class="w-100">
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-column">
                                                    <span class="text-gray-800 fw-bold mb-1">'. $fileAs .'</span>
                                                    <small class="text-gray-600">'. $email .'</small>
                                                </div>
                                            </div>',
                'USER_ACCOUNT_STATUS'   => $activeBadge,
                'LAST_CONNECTION_DATE'  => $lastConnectionDate,
                'LINK'                  => $pageLink .'&id='. $userAccountIdEncrypted
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new UserAccountController(
    new UserAccount(),
    new Role(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
