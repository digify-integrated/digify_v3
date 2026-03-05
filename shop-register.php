<?php
declare(strict_types=1);
$pageTitle = 'Shop Register';

require_once './app/Views/Partials/required-files.php';

$shopId = $_GET['shop_id'] ?? null;

if(empty($shopId)) {
    $systemHelper->redirect('apps.php');
}

use App\Models\Shop;
use App\Models\FloorPlan;

$shop       = new Shop();
$floorPlan  = new FloorPlan();

$shopDetails    = $shop->fetchShop($shopId);
$shopName       = $shopDetails['shop_name'] ?? '';
$shopStatus     = $shopDetails['shop_status'] ?? 'Active';

if($shopStatus !== 'Active') {
    $systemHelper->redirect('apps.php');
}

$floorPlanCount = $shop->fetchShopFloorPlanCount($shopId)['total'] ?? 0;

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <?php
        require_once './app/Views/Partials/head-meta-tags.php';
        require_once './app/Views/Partials/head-stylesheet.php';
    ?>
    <link href="./vendor/datatables/datatables.bundle.css" rel="stylesheet" type="text/css"/>
</head>

<?php require_once './app/Views/Partials/theme-script.php'; ?>

<body id="kt_body" class="app-default bgi-size-cover bgi-attachment-fixed bgi-position-center bgi-no-repeat" data-kt-app-page-loading-enabled="true" data-kt-app-page-loading="off">
    <div class="d-flex flex-column flex-root app-root" id="kt_app_root">
        <div class="app-page flex-column flex-column-fluid" id="kt_app_page">
            <div class="app-wrapper flex-column flex-row-fluid" id="kt_app_wrapper">
                <div class="app-container container-xxl">
                    <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
                        <div class="d-flex flex-column flex-column-fluid">
                            <div id="kt_app_content" class="app-content flex-column-fluid mt-0">
                                <div class="card mb-5 mb-xxl-8">
                                    <div class="card-header card-header-stretch pb-0">
                                        <div class="card-title">
                                            <ul class="nav nav-stretch nav-line-tabs border-transparent" role="tablist">
                                                <?php include_once './app/Views/Partials/shop-register-tabs.php'; ?>
                                            </ul>
                                        </div>
                                        <div class="card-toolbar mt-5 mb-5">
                                             <a href="#" class="btn btn-primary ps-7" data-kt-menu-trigger="click" data-kt-menu-attach="parent" data-kt-menu-placement="bottom-end">
                                                Actions
                                                <i class="ki-outline ki-down fs-2 me-0"></i>
                                            </a>
                                            <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true">
                                               <div class="menu-item px-3">
                                                    <a href="javascript:void(0);" class="menu-link px-3">
                                                        Go to Table
                                                    </a>
                                                </div>
                                                <div class="menu-item px-3">
                                                    <a href="apps.php" class="menu-link px-3">
                                                        Backend
                                                    </a>
                                                </div>
                                               <div class="menu-item px-3">
                                                    <a href="javascript:void(0);" class="menu-link px-3">
                                                        Close Register
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="tab-content">
                                    <?php include_once './app/Views/Partials/shop-register-tab-contents.php'; ?>                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<?php
    require_once './app/Views/Partials/error-modal.php';
    require_once './app/Views/Partials/required-js.php';
?>
<script src="./vendor/datatables/datatables.bundle.js"></script>

<script type="module" src=""></script>

</body>
</html>