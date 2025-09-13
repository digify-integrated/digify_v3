<?php
namespace App\Controllers;

session_start();

use App\Models\AppModule;
use App\Models\MenuItem;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class AppModuleController
{
    protected AppModule $appModule;
    protected MenuItem $menuItem;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        AppModule $appModule,
        MenuItem $menuItem,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->appModule        = $appModule;
        $this->menuItem         = $menuItem;
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

        $transaction = $_POST['transaction'] ?? null;
        $lastLogBy = $_SESSION['user_account_id'];

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
        $encryptedAppModuleId = $this->security->encryptData($appModuleId);

        $this->systemHelper->sendSuccessResponse(
            'Save App Module Success',
            'The app module has been saved successfully.',
            ['app_module_id' => $encryptedAppModuleId]
        );
    }

    public function updateAppModuleLogo($lastLogBy){

        $appModuleId   = $_POST['app_module_id'] ?? null;
        $appModuleName   = $_POST['app_module_name'] ?? null;
        $menuItemId   = $_POST['menu_item_id'] ?? null;
        $orderSequence   = $_POST['order_sequence'] ?? null;
        $appModuleDescription   = $_POST['app_module_description'] ?? null;

        $menuItemDetains = $this->menuItem->fetchMenuItem($menuItemId);
        $menuItemName = $menuItemDetains['menu_item_name'] ?? '';

        $appModuleId = $this->appModule->saveAppModule($appModuleId, $appModuleName, $appModuleDescription, $menuItemId, $menuItemName, $orderSequence, $lastLogBy);
        $encryptedAppModuleId = $this->security->encryptData($appModuleId);

        $this->systemHelper->sendSuccessResponse(
            'Save App Module Success',
            'The app module has been saved successfully.',
            ['app_module_id' => $encryptedAppModuleId]
        );
    }

    public function deleteAppModule(){
        $appModuleId        = $_POST['app_module_id'] ?? null;
        $appModuleDetails   = $this->appModule->fetchAppModule($appModuleId);
        $appLogo            = $this->systemHelper->checkImageExist($appModuleDetails['app_logo'] ?? null, 'null');

        $this->systemHelper->deleteImageIfExist($appLogo);

        $this->appModule->deleteAppModule($appModuleId);

        $this->systemHelper->sendSuccessResponse(
            'Save App Module Success',
            'The app module has been deleted successfully.'
        );
    }

    public function deleteMultipleAppModule(){
        $appModuleIds  = $_POST['app_module_id'] ?? null;

        foreach($appModuleIds as $appModuleId){
            $appModuleDetails   = $this->appModule->fetchAppModule($appModuleId);
            $appLogo            = $this->systemHelper->checkImageExist($appModuleDetails['app_logo'] ?? null, 'null');

            $this->systemHelper->deleteImageIfExist($appLogo);

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

        $appModuleDetails = $this->appModule->fetchAppModule($appModuleId);
        $appLogo = $this->systemHelper->checkImageExist($appModuleDetails['app_logo'] ?? null, 'app module logo');

        $response = [
            'success' => true,
            'appModuleName' => $appModuleDetails['app_module_name'] ?? null,
            'appModuleDescription' => $appModuleDetails['app_module_description'] ?? null,
            'menuItemID' => $appModuleDetails['menu_item_id'] ?? null,
            'menuItemName' => $appModuleDetails['menu_item_name'] ?? null,
            'orderSequence' => $appModuleDetails['order_sequence'] ?? null,
            'appLogo' => $appLogo
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
            $appModuleID            = $row['app_module_id'];
            $appModuleName          = $row['app_module_name'];
            $appModuleDescription   = $row['app_module_description'];
            $appLogo                = $this->systemHelper->checkImageExist(str_replace('../', './apps/', $row['app_logo'])  ?? null, 'app module logo');
            $appModuleIDEncrypted   = $this->security->encryptData($appModuleID);

            $response[] = [
                'CHECK_BOX' => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                    <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $appModuleID .'">
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
                'LINK' => $pageLink .'&id='. $appModuleIDEncrypted
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
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
