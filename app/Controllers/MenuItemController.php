<?php
namespace App\Controllers;

session_start();

use App\Models\MenuItem;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class MenuItemController
{
    protected MenuItem $menuItem;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        MenuItem $menuItem,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
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

        $loginCredentialsDetails = $this->authentication->fetchLoginCredentials($lastLogBy);       
        $multipleSession    = $loginCredentialsDetails['multiple_session'] ?? 'No';
        $isActive           = $loginCredentialsDetails['active'] ?? 'No';

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
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
