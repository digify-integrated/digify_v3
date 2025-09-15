<?php
namespace App\Controllers;


session_start();

use App\Models\AppModule;
use App\Models\MenuItem;
use App\Models\Authentication;
use App\Models\UploadSetting;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class AppModuleController
{
    protected AppModule $appModule;
    protected MenuItem $menuItem;
    protected Authentication $authentication;
    protected UploadSetting $uploadSetting;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        AppModule $appModule,
        MenuItem $menuItem,
        Authentication $authentication,
        UploadSetting $uploadSetting,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->appModule        = $appModule;
        $this->menuItem         = $menuItem;
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
            'save app module'               => $this->saveAppModule($lastLogBy),
            'update app module logo'        => $this->updateAppModuleLogo($lastLogBy),
            'delete app module'             => $this->deleteAppModule(),
            'delete multiple app module'    => $this->deleteMultipleAppModule(),
            'fetch app module details'      => $this->fetchAppModuleDetails(),
            'generate app module table'     => $this->generateAppModuleTable(),
            'generate app module options'   => $this->generateAppModuleOptions(),
            default                         => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    public function saveAppModule($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'app_module_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $appModuleId   = $_POST['app_module_id'] ?? null;
        $appModuleName   = $_POST['app_module_name'] ?? null;
        $menuItemId   = $_POST['menu_item_id'] ?? null;
        $orderSequence   = $_POST['order_sequence'] ?? null;
        $appModuleDescription   = $_POST['app_module_description'] ?? null;

        $menuItemDetains = $this->menuItem->fetchMenuItem($menuItemId);
        $menuItemName = $menuItemDetains['menu_item_name'] ?? '';

        $appModuleId = $this->appModule->saveAppModule($appModuleId, $appModuleName, $appModuleDescription, $menuItemId, $menuItemName, $orderSequence, $lastLogBy);
        $encryptedappModuleId = $this->security->encryptData($appModuleId);

        $this->systemHelper->sendSuccessResponse(
            'Save App Module Success',
            'The app module has been saved successfully.',
            ['app_module_id' => $encryptedappModuleId]
        );
    }

    public function updateAppModuleLogo($lastLogBy){

        $appModuleId   = $_POST['app_module_id'] ?? null;
       
        $appLogoFileName                = $_FILES['app_logo']['name'];
        $appLogoFileSize                = $_FILES['app_logo']['size'];
        $appLogoFileError               = $_FILES['app_logo']['error'];
        $appLogoTempName                = $_FILES['app_logo']['tmp_name'];
        $appLogoFileExtension           = explode('.', $appLogoFileName);
        $appLogoActualFileExtension     = strtolower(end($appLogoFileExtension));

        $uploadSetting  = $this->uploadSetting->fetchUploadSetting(1);
        $maxFileSize    = $uploadSetting['max_file_size'];

        $uploadSettingFileExtension = $this->uploadSetting->fetchUploadSettingFileExtension(1);
        $allowedFileExtensions = [];

        foreach ($uploadSettingFileExtension as $row) {
            $allowedFileExtensions[] = $row['file_extension'];
        }

        if (!in_array($appLogoActualFileExtension, $allowedFileExtensions)) {              
            $this->systemHelper::sendErrorResponse(
                'Update App Module Logo Error', 
                'The file uploaded is not supported.'
            );
        }
            
        if(empty($appLogoTempName)){
            $this->systemHelper::sendErrorResponse(
                'Update App Module Logo Error', 
                'Please choose the app logo.'
            );
        }
            
        if($appLogoFileError){                
            $this->systemHelper::sendErrorResponse(
                'Update App Module Logo Error', 
                'An error occurred while uploading the file.'
            );
        }
            
        if($appLogoFileSize > ($maxFileSize * 1024)){
            $this->systemHelper::sendErrorResponse(
                'Update App Module Logo Error', 
                'The app module logo exceeds the maximum allowed size of ' . $maxFileSize . ' mb.'
            );
        }

        $fileName   = $this->security->generateFileName();
        $fileNew    = $fileName . '.' . $appLogoActualFileExtension;
            
        define('PROJECT_BASE_DIR', dirname(__DIR__, 2));

        $uploadsDir         = PROJECT_BASE_DIR . '/storage/uploads/';
        $directory          = $uploadsDir . 'app_module/' . $appModuleId . '/';
        $fileDestination    = $directory . $fileNew;
        $filePath           = 'storage/uploads/app_module/' . $appModuleId . '/' . $fileNew;

        $directoryChecker = $this->security->directoryChecker($directory);

        if ($directoryChecker !== true) {
            $this->systemHelper::sendErrorResponse(
                'Update App Module Logo Error',
                $directoryChecker
            );
        }

        $appModuleDetails   = $this->appModule->fetchAppModule($appModuleId);
        $appLogo            = $this->systemHelper->checkImageExist($appModuleDetails['app_logo'] ?? null, 'null');
        $deleteImageFile    = $this->systemHelper->deleteFileIfExist($appLogo);

        if(!$deleteImageFile){
            $this->systemHelper::sendErrorResponse(
                'Update App Module Logo Error', 
                'The app module logo cannot be deleted due to an error'
            );
        }

        if(!move_uploaded_file($appLogoTempName, $fileDestination)){
            $this->systemHelper::sendErrorResponse(
                'Update App Module Logo Error', 
                'The app module logo cannot be uploaded due to an error'
            );
        }

        $this->appModule->updateAppLogo($appModuleId, $filePath, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Yodate App Module Logo Success',
            'The app module logo has been updated successfully.'
        );
    }

    public function deleteAppModule(){
        $appModuleId        = $_POST['app_module_id'] ?? null;
        $appModuleDetails   = $this->appModule->fetchAppModule($appModuleId);
        $appLogo            = $this->systemHelper->checkImageExist($appModuleDetails['app_logo'] ?? null, 'null');

        $deleteImageFile = $this->systemHelper->deleteFileIfExist($appLogo);

        if(!$deleteImageFile){
            $this->systemHelper::sendErrorResponse(
                'Delete App Module Error', 
                'The app logo cannot be deleted due to an error'
            );
        }

        $this->appModule->deleteAppModule($appModuleId);

        $this->systemHelper->sendSuccessResponse(
            'Delete App Module Success',
            'The app module has been deleted successfully.'
        );
    }

    public function deleteMultipleAppModule(){
        $appModuleIds  = $_POST['app_module_id'] ?? null;

        foreach($appModuleIds as $appModuleId){
            $appModuleDetails   = $this->appModule->fetchAppModule($appModuleId);
            $appLogo            = $this->systemHelper->checkImageExist($appModuleDetails['app_logo'] ?? null, 'null');

            $this->systemHelper->deleteFileIfExist($appLogo);

            $this->appModule->deleteAppModule($appModuleId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple App Modules Success',
            'The selected app modules have been deleted successfully.'
        );
    }

    public function fetchAppModuleDetails(){
        $appModuleId            = $_POST['app_module_id'] ?? null;
        $checkAppModuleExist    = $this->appModule->checkAppModuleExist($appModuleId);
        $total                  = $checkAppModuleExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get App Module Details',
                'The app module does not exist'
            );
        }

        $appModuleDetails   = $this->appModule->fetchAppModule($appModuleId);
        $appLogo            = $this->systemHelper->checkImageExist($appModuleDetails['app_logo'] ?? null, 'app module logo');

        $response = [
            'success'               => true,
            'appModuleName'         => $appModuleDetails['app_module_name'] ?? null,
            'appModuleDescription'  => $appModuleDetails['app_module_description'] ?? null,
            'menuItemID'            => $appModuleDetails['menu_item_id'] ?? null,
            'menuItemName'          => $appModuleDetails['menu_item_name'] ?? null,
            'orderSequence'         => $appModuleDetails['order_sequence'] ?? null,
            'appLogo'               => $appLogo
        ];

        echo json_encode($response);
        exit;
    }

    public function generateAppModuleTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $appModules = $this->appModule->generateAppModuleTable();

        foreach ($appModules as $row) {
            $appModuleId            = $row['app_module_id'];
            $appModuleName          = $row['app_module_name'];
            $appModuleDescription   = $row['app_module_description'];
            $appLogo                = $this->systemHelper->checkImageExist(str_replace('../', './apps/', $row['app_logo'])  ?? null, 'app module logo');
            $appModuleIdEncrypted   = $this->security->encryptData($appModuleId);

            $response[] = [
                'CHECK_BOX' => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                    <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $appModuleId .'">
                                 </div>',
                'APP_MODULE_NAME' => '<div class="d-flex align-items-center">
                                        <img src="'. $appLogo .'" alt="app-logo" width="45" />
                                        <div class="ms-3">
                                            <div class="user-meta-info">
                                                <h6 class="mb-0">'. $appModuleName .'</h6>
                                                <small class="text-wrap fs-7 text-gray-500">'. $appModuleDescription .'</small>
                                            </div>
                                        </div>
                                    </div>',
                'LINK' => $pageLink .'&id='. $appModuleIdEncrypted
            ];
        }

        echo json_encode($response);
    }

    public function generateAppModuleOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $appModules = $this->appModule->generateAppModuleOptions();

        foreach ($appModules as $row) {
            $response[] = [
                'id'    => $row['app_module_id'],
                'text'  => $row['app_module_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new AppModuleController(
    new AppModule(),
    new MenuItem(),
    new Authentication(),
    new UploadSetting(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
