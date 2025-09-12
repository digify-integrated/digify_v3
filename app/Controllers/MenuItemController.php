<?php
namespace App\Controllers;

session_start();

use App\Models\MenuItem;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class MenuItemController
{
    protected MenuItem $menuItem;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        MenuItem $menuItem,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->menuItem             = $menuItem;
        $this->security             = $security;
        $this->systemHelper         = $systemHelper;
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
            'generate app module table'     => $this->generateMenuItemTable(),
            default             => $this->systemHelper::sendErrorResponse(
                'Transaction Failed',
                'We encountered an issue while processing your request.'
            ),
        };
    }

    public function generateMenuItemTable()
    {
        $pageID = isset($_POST['page_id']) ? $_POST['page_id'] : null;
        $pageLink = isset($_POST['page_link']) ? $_POST['page_link'] : null;
        $response = [];

        $menuItems = $this->menuItem->generateMenuItemTable();

        foreach ($menuItems as $row) {
            $menuItemID = $row['app_module_id'];
            $menuItemName = $row['app_module_name'];
            $menuItemDescription = $row['app_module_description'];
            $appLogo = $this->systemHelper->checkImageExist(str_replace('../', './apps/', $row['app_logo'])  ?? null, 'app module logo');

            $menuItemIDEncrypted = $this->security->encryptData($menuItemID);

            $response[] = [
                'CHECK_BOX' => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                    <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $menuItemID .'">
                                 </div>',
                'APP_MODULE_NAME' => '<div class="d-flex align-items-center">
                                        <img src="'. $appLogo .'" alt="app-logo" width="45" />
                                        <div class="ms-3">
                                            <div class="user-meta-info">
                                                <h6 class="mb-0">'. $menuItemName .'</h6>
                                                <small class="text-wrap fs-7 text-gray-500">'. $menuItemDescription .'</small>
                                            </div>
                                        </div>
                                    </div>',
                'LINK' => $pageLink .'&id='. $menuItemIDEncrypted
            ];
        }

        echo json_encode($response);
    }
    
   

}

# Bootstrap the controller
$controller = new MenuItemController(
    new MenuItem(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
