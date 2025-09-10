<?php

require_once './config/config.php';
require_once './config/session.php';

use App\Core\Security;
use App\Models\Authentication;
use App\Models\MenuItem;
use App\Models\AppModule;
use App\Helpers\SystemHelper;

$authentication     = new Authentication();
$security           = new Security();
$menuItem           = new MenuItem();
$appModule          = new AppModule();
$systemHelper       = new SystemHelper();

$loginCredentialsDetails = $authentication->fetchLoginCredentials($userID);
$userFileAs              = $loginCredentialsDetails['file_as'] ?? '';
$userEmail               = $loginCredentialsDetails['email'] ?? '';
$multipleSession         = $loginCredentialsDetails['multiple_session'] ?? 'No';
$isActive                = $loginCredentialsDetails['active'] ?? 'No';
$profilePicture          = $systemHelper->checkImageExist($loginCredentialsDetails['profile_picture'] ?? null, 'profile');

$sessionTokenDetails = $authentication->fetchSession($userID);
$sessionToken = $sessionTokenDetails['session_token'] ?? '';

if ($isActive === 'No' || (!$security->verifyToken($_SESSION['session_token'], $sessionToken) && $multipleSession === 'No')) {
    header('location: logout.php?logout');
    exit;
}