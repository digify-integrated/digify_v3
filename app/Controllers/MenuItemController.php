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
        $this->menuItem         = $menuItem;
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
            'generate menu item options'    => $this->generateMenuItemOptions(),
            default                         => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    public function generateMenuItemOptions()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $multiple   = $_POST['multiple'] ?? false;
        $menuItemId   = $_POST['menu_item_id'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id' => '',
                'text' => '--'
            ];
        }

        $menuItems = $this->menuItem->generateMenuItemOptions($menuItemId);

        foreach ($menuItems as $row) {
            $response[] = [
                'id' => $row['menu_item_id'],
                'text' => $row['menu_item_name']
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
