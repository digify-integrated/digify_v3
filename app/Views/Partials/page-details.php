<?php
if (empty($_GET['page_id']) || empty($_GET['app_module_id'])) {
    $systemHelper->redirect('apps.php');
}

$appModuleID    = (int) $security->decryptData($_GET['app_module_id']);
$pageID         = (int) $security->decryptData($_GET['page_id']);

if (!$appModuleID || !$pageID) {
    $systemHelper->redirect('apps.php');
}

$pageDetails       = $menuItem->fetchMenuItem($pageID) ?? [];
$pageTitle         = $pageDetails['menu_item_name'] ?? '';
$pageURL           = $pageDetails['menu_item_url'] ?? '';
$tableName         = $pageDetails['table_name'] ?? '';
$pageLink          = $pageURL . '?app_module_id=' . $security->encryptData($appModuleID) . '&page_id=' . $security->encryptData($pageID);

$appModuleDetails   = $appModule->fetchAppModule($appModuleID) ?? [];
$appModuleName      = $appModuleDetails['app_module_name'] ?? '';
$appLogo            = $systemHelper->checkImageExist($appModuleDetails['app_logo'] ?? null, 'app module logo');
$accessTypes        = ['read', 'write', 'delete', 'create', 'import', 'export', 'log notes'];

$permissions = [];
foreach ($accessTypes as $type) {
    $permissions[$type] = (int) ($authentication->checkUserPermission($userID, $pageID, $type)['total'] ?? 0);
}

if ($permissions['read'] === 0) {
    $systemHelper->redirect('404.php');
}

$detailID           = null;
$newRecord          = false;
$importRecord       = false;
$importTableName    = null;

if (!empty($_GET['id'])) {
    $detailID = (int) $security->decryptData($_GET['id']);
}

if (isset($_GET['new'])) {
    if ($permissions['create'] === 0) {
        $systemHelper->redirect($pageLink);
    }

    $newRecord = true;
}

if (isset($_GET['import'])) {
    if (empty($_GET['import'])) {
        $systemHelper->redirect($pageLink);
    }

    if ($permissions['import'] === 0) {
        $systemHelper->redirect($pageLink);
    }

    $importRecord       = true;
    $importTableName    = $security->decryptData($_GET['import']);
}

$disabled = $permissions['write'] === 0 ? 'disabled' : '';
