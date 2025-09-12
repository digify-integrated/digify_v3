<?php
namespace App\Controllers;

session_start();

use App\Models\AppModule;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class AppModuleController
{
    protected AppModule $appModule;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        AppModule $appModule,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->appModule        = $appModule;
        $this->security         = $security;
        $this->systemHelper     = $systemHelper;
    }

    public function handleRequest(): void
    {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            $this->systemHelper::sendErrorResponse('Invalid Request', 'Only POST requests are allowed.');
            return;
        }

        $transaction = $_POST['transaction'] ?? null;

        if (!$transaction) {
            $this->systemHelper::sendErrorResponse('Missing Transaction', 'No transaction type was provided.');
            return;
        }

        $transaction = strtolower(trim($transaction));

        match ($transaction) {
            'generate app module table'     => $this->generateAppModuleTable(),
            default                         => $this->systemHelper::sendErrorResponse(
                                                'Transaction Failed',
                                                'We encountered an issue while processing your request.'
                                            )
        };
    }

    public function generateAppModuleTable()
    {
        $pageLink   = isset($_POST['page_link']) ? $_POST['page_link'] : null;
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
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
