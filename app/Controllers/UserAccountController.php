<?php
namespace App\Controllers;

session_start();

use App\Models\UserAccount;
use App\Models\Role;
use App\Models\Authentication;
use App\Models\UploadSetting;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class UserAccountController
{
    protected UserAccount $userAccount;
    protected Role $role;
    protected Authentication $authentication;
    protected UploadSetting $uploadSetting;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        UserAccount $userAccount,
        Role $role,
        Authentication $authentication,
        UploadSetting $uploadSetting,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->userAccount      = $userAccount;
        $this->role             = $role;
        $this->authentication   = $authentication;
        $this->uploadSetting    = $uploadSetting;
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
            'save user account role'                            => $this->saveUserAccountRole($lastLogBy),
            'update user account full name'                     => $this->updateUserAccountFullName($lastLogBy),
            'update user account email'                         => $this->updateUserAccountEmail($lastLogBy),
            'update user account phone'                         => $this->updateUserAccountPhone($lastLogBy),
            'update user account password'                      => $this->updateUserAccountPassword($lastLogBy),
            'update user account two factor authentication'     => $this->updateUserAccountTwoFactorAuthentication($lastLogBy),
            'update user account multiple login sessions'       => $this->updateUserAccountMultipleLoginSession($lastLogBy),
            'update user account profile picture'               => $this->updateUserAccountProfilePicture($lastLogBy),
            'activate user account'                             => $this->activateUserAccount($lastLogBy),
            'activate multiple user account'                    => $this->activateMultipleUserAccount($lastLogBy),
            'deactivate user account'                           => $this->deactivateUserAccount($lastLogBy),
            'deactivate multiple user account'                  => $this->deactivateMultipleUserAccount($lastLogBy),
            'delete user account'                               => $this->deleteUserAccount(),
            'delete multiple user account'                      => $this->deleteMultipleUserAccount(),
            'delete user account role'                          => $this->deleteUserAccountRole(),
            'fetch user account details'                        => $this->fetchUserAccountDetails(),
            'generate user account table'                       => $this->generateUserAccountTable(),
            'generate assigned user account role list'          => $this->generateAssignedUserAccountRoleList($lastLogBy),
            'user account role dual listbox options'            => $this->generateUserAccountRoleDualListBoxOptions(),
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

        $fileAs             = $_POST['file_as'] ?? null;
        $email              = $_POST['email'] ?? null;
        $phone              = $_POST['phone'] ?? null;
        $password           = $_POST['password'] ?? null;
        $hashedPassword     = password_hash($password, PASSWORD_BCRYPT);

        $userAccountId              = $this->userAccount->insertUserAccount($fileAs, $email, $hashedPassword, $phone, $lastLogBy);
        $encryptedUserAccountId     = $this->security->encryptData($userAccountId);

        $this->systemHelper->sendSuccessResponse(
            'Save User Account Success',
            'The user account has been saved successfully.',
            ['user_account_id' => $encryptedUserAccountId]
        );
    }

    public function saveUserAccountRole($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'role_assignment_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $userAccountId  = $_POST['user_account_id'] ?? null;
        $roleIds        = $_POST['role_id'] ?? null;

        if(empty($roleIds)){
            $this->systemHelper::sendErrorResponse(
                'Assign Role Error',
                'Please select the role(s) you wish to assign to the user account.'
            );
        }

        $userAccountDetails = $this->userAccount->fetchUserAccount($userAccountId);
        $fileAs = $userAccountDetails['file_as'] ?? '';     

        foreach ($roleIds as $roleId) {
        $roleDetails    = $this->role->fetchRole($roleId);
        $roleName       = $roleDetails['role_name'] ?? null;

            $this->role->insertRoleUserAccount($roleId, $roleName, $userAccountId, $fileAs, $lastLogBy);
        }

        $this->systemHelper->sendSuccessResponse(
            'Assign Role Success',
            'The role has been assigned successfully.'
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

        $userAccountId      = $_POST['user_account_id'] ?? null;
        $newPassword        = $_POST['new_password'] ?? null;
        $hashedPassword     = password_hash($newPassword, PASSWORD_BCRYPT);

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

    public function updateUserAccountProfilePicture($lastLogBy){

        $userAccountId = $_POST['user_account_id'] ?? null;
       
        $profilePictureFileName                = $_FILES['profile_picture']['name'];
        $profilePictureFileSize                = $_FILES['profile_picture']['size'];
        $profilePictureFileError               = $_FILES['profile_picture']['error'];
        $profilePictureTempName                = $_FILES['profile_picture']['tmp_name'];
        $profilePictureFileExtension           = explode('.', $profilePictureFileName);
        $profilePictureActualFileExtension     = strtolower(end($profilePictureFileExtension));

        $uploadSetting  = $this->uploadSetting->fetchUploadSetting(4);
        $maxFileSize    = $uploadSetting['max_file_size'];

        $uploadSettingFileExtension     = $this->uploadSetting->fetchUploadSettingFileExtension(4);
        $allowedFileExtensions          = [];

        foreach ($uploadSettingFileExtension as $row) {
            $allowedFileExtensions[] = $row['file_extension'];
        }

        if (!in_array($profilePictureActualFileExtension, $allowedFileExtensions)) {              
            $this->systemHelper::sendErrorResponse(
                'Update User Account Profile Picture Error', 
                'The file uploaded is not supported.'
            );
        }
            
        if(empty($profilePictureTempName)){
            $this->systemHelper::sendErrorResponse(
                'Update User Account Profile Picture Error', 
                'Please choose the profile picture.'
            );
        }
            
        if($profilePictureFileError){                
            $this->systemHelper::sendErrorResponse(
                'Update User Account Profile Picture Error', 
                'An error occurred while uploading the file.'
            );
        }
            
        if($profilePictureFileSize > ($maxFileSize * 1024)){
            $this->systemHelper::sendErrorResponse(
                'Update User Account Profile Picture Error', 
                'The user account profile image exceeds the maximum allowed size of ' . $maxFileSize . ' mb.'
            );
        }

        $fileName   = $this->security->generateFileName();
        $fileNew    = $fileName . '.' . $profilePictureActualFileExtension;
            
        define('PROJECT_BASE_DIR', dirname(__DIR__, 2));

        $uploadsDir         = PROJECT_BASE_DIR . '/storage/uploads/';
        $directory          = $uploadsDir . 'user_account/' . $userAccountId . '/';
        $fileDestination    = $directory . $fileNew;
        $filePath           = 'storage/uploads/user_account/' . $userAccountId . '/' . $fileNew;

        $directoryChecker = $this->security->directoryChecker($directory);

        if ($directoryChecker !== true) {
            $this->systemHelper::sendErrorResponse(
                'Update User Account Profile Picture Error',
                $directoryChecker
            );
        }

        $userAccountIdDetails   = $this->userAccount->fetchUserAccount($userAccountId);
        $profilePicture         = $this->systemHelper->checkImageExist($userAccountIdDetails['profile_picture'] ?? null, 'null');
        $deleteImageFile        = $this->systemHelper->deleteFileIfExist($profilePicture);

        if(!$deleteImageFile){
            $this->systemHelper::sendErrorResponse(
                'Update User Account Profile Picture Error', 
                'The user account profile image cannot be deleted due to an error'
            );
        }

        if(!move_uploaded_file($profilePictureTempName, $fileDestination)){
            $this->systemHelper::sendErrorResponse(
                'Update User Account Profile Picture Error', 
                'The user account profile image cannot be uploaded due to an error'
            );
        }

        $this->userAccount->updateUserAccount($userAccountId, $filePath, 'profile picture', $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Update User Account Profile Picture Success',
            'The user account profile picture has been updated successfully.'
        );
    }

    public function activateUserAccount($lastLogBy){
        $userAccountId = $_POST['user_account_id'] ?? null;

        $this->userAccount->updateUserAccount($userAccountId, 'Yes', 'status', $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Activate User Account Success',
            'The user account has been activated successfully.'
        );
    }
    
    public function activateMultipleUserAccount($lastLogBy){
        $userAccountIds = $_POST['user_account_id'] ?? null;

        foreach($userAccountIds as $userAccountId){
            $this->userAccount->updateUserAccount($userAccountId, 'Yes', 'status', $lastLogBy);
        }

        $this->systemHelper->sendSuccessResponse(
            'Activate Multiple User Accounts Success',
            'The selected user accounts have been activated successfully.'
        );
    }

    public function deactivateUserAccount($lastLogBy){
        $userAccountId = $_POST['user_account_id'] ?? null;

        if($userAccountId == $lastLogBy){
            $this->systemHelper::sendErrorResponse(
                'Deactivate User Account Error',
                'You cannot deactivate the user account you are currently logged in as.'
            );
        }

        $this->userAccount->updateUserAccount($userAccountId, 'No', 'status', $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Deactivate User Account Success',
            'The user account has been deactivated successfully.'
        );
    }
    
    public function deactivateMultipleUserAccount($lastLogBy){
        $userAccountIds  = $_POST['user_account_id'] ?? null;

        foreach($userAccountIds as $userAccountId){
            if($userAccountId != $lastLogBy){
                $this->userAccount->updateUserAccount($userAccountId, 'No', 'status', $lastLogBy);
            }
        }

        $this->systemHelper->sendSuccessResponse(
            'Deactivate Multiple User Accounts Success',
            'The selected user accounts have been deactivated successfully.'
        );
    }

    public function deleteUserAccount(){
        $userAccountId = $_POST['user_account_id'] ?? null;

        $this->userAccount->deleteUserAccount($userAccountId);

        $this->systemHelper->sendSuccessResponse(
            'Delete User Account Success',
            'The user account has been deleted successfully.'
        );
    }

    public function deleteMultipleUserAccount(){
        $userAccountIds  = $_POST['user_account_id'] ?? null;

        foreach($userAccountIds as $userAccountId){
            $this->userAccount->deleteUserAccount($userAccountId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple User Accounts Success',
            'The selected user accounts have been deleted successfully.'
        );
    }

    public function deleteUserAccountRole(){
        $roleUserAccountId = $_POST['role_user_account_id'] ?? null;

        $this->role->deleteRoleUserAccount($roleUserAccountId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Role Success',
            'The role has been deleted successfully.'
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

        $userAccountDetails         = $this->userAccount->fetchUserAccount($userAccountId);
        $profilePicture             = $this->systemHelper->checkImageExist($userAccountDetails['profile_picture'] ?? null, 'profile');
        $lastConnectionDate         = (!empty($userAccountDetails['last_connection_date'])) ? date('d M Y h:i a', strtotime($userAccountDetails['last_connection_date'])) : 'Never Connected';
        $lastFailedConnectionDate   = (!empty($userAccountDetails['last_failed_connection_date'])) ? date('d M Y h:i a', strtotime($userAccountDetails['last_failed_connection_date'])) : 'No record';
        $lastPasswordChange         = (!empty($userAccountDetails['last_password_change'])) ? date('d M Y h:i a', strtotime($userAccountDetails['last_password_change'])) : 'Never Changed';
        $lastPasswordResetRequest   = (!empty($userAccountDetails['last_password_reset_request'])) ? date('d M Y h:i a', strtotime($userAccountDetails['last_password_reset_request'])) : 'Never Requested';
        $activeBadge                = $userAccountDetails['active'] == 'Yes' ? '<span class="badge badge-light-success">Active</span>' : '<span class="badge badge-light-danger">Inactive</span>';

        $response = [
            'success'                   => true,
            'fileAs'                    => $userAccountDetails['file_as'] ?? null,
            'email'                     => $userAccountDetails['email'] ?? null,
            'phone'                     => $userAccountDetails['phone'] ?? null,
            'phoneSummary'              => $userAccountDetails['phone'] ?? '-',
            'lastConnectionDate'        => $lastConnectionDate,
            'lastFailedConnectionDate'  => $lastFailedConnectionDate,
            'lastPasswordChange'        => $lastPasswordChange,
            'lastPasswordResetRequest'  => $lastPasswordResetRequest,
            'profilePicture'            => $profilePicture,
            'activeBadge'               => $activeBadge,
            'twoFactorAuthentication'   => $userAccountDetails['two_factor_auth'],
            'multipleSession'           => $userAccountDetails['multiple_session']
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
            $userAccountId          = $row['user_account_id'];
            $fileAs                 = $row['file_as'];
            $email                  = $row['email'];
            $active                 = $row['active'];
            $lastConnectionDate     = empty($row['last_connection_date']) ? 'Never Connected' : $this->systemHelper->checkDate('empty', $row['last_connection_date'], '', 'd M Y h:i:s a', '');
            $profilePicture         = $this->systemHelper->checkImageExist($row['profile_picture'], 'profile');
            $activeBadge            = $active == 'Yes' ? '<span class="badge badge-light-success">Active</span>' : '<span class="badge badge-light-danger">Inactive</span>';

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

    public function generateAssignedUserAccountRoleList($lastLogBy)
    {
        $userAccountId          = $_POST['user_account_id'] ?? null;
        $deleteRoleUserAccount  = $this->authentication->checkUserSystemActionPermission($lastLogBy, 4);
        $list                   = '';

        $roles = $this->userAccount->generateUserAccountRoleList($userAccountId);

        foreach ($roles as $row) {
            $roleUserAccountID  = $row['role_user_account_id'];
            $roleName           = $row['role_name'];
            $assignmentDate     = $this->systemHelper->checkDate('empty', $row['date_assigned'], '', 'd M Y h:i a', '');

            $deleteButton = '';
            if($deleteRoleUserAccount['total'] > 0){
                $deleteButton = '<button class="btn btn-sm btn-danger btn-active-light-danger me-3 delete-role-user-account" data-role-user-account-id="' . $roleUserAccountID . '">Delete</button>';
            }

            $list .= '<div class="d-flex flex-stack">
                        <div class="d-flex align-items-center flex-row-fluid flex-wrap">
                            <div class="flex-grow-1 me-2">
                                <div class="text-gray-800 fs-4 fw-bold">'. $roleName .'</div>
                                                    
                                <span class="text-gray-500 fw-semibold d-block fs-7">Date Assigned : '. $assignmentDate .'</span>
                            </div>
                            '. $deleteButton .'
                        </div>
                    </div>';
        }

        if(empty($list)){
            $list = '<div class="d-flex flex-stack">
                        <div class="d-flex align-items-center flex-row-fluid flex-wrap">
                            <div class="flex-grow-1 me-2">
                                <div class="text-gray-800 fs-4 fw-bold">No role found</div>
                            </div>
                        </div>
                    </div>';
        }

        $response[] = [
            'ROLE_USER_ACCOUNT' => $list
        ];


        echo json_encode($response);
    }

    public function generateUserAccountRoleDualListBoxOptions()
    {
        $userAccountId  = $_POST['user_account_id'] ?? null;
        $response       = [];
        $roles          = $this->role->generateUserAccountRoleDualListBoxOptions($userAccountId);

        foreach ($roles as $row) {
            $response[] = [
                'id'    => $row['role_id'],
                'text'  => $row['role_name']
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
    new UploadSetting(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
