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
    <input type="hidden" id="shop_id" value="<?= $shopId ?>">
    <div class="d-flex flex-column flex-root app-root" id="kt_app_root">
        <div class="app-page flex-column flex-column-fluid mb-0 pb-0" id="kt_app_page">
            <div id="kt_app_header" class="app-header" data-kt-sticky="true" data-kt-sticky-activate="{default: false, lg: true}" data-kt-sticky-name="app-header-sticky" data-kt-sticky-offset="{default: false, lg: '300px'}">
                <div class="app-container container-xxl d-flex align-items-stretch justify-content-between" id="kt_app_header_container">
                    <div class="d-flex align-items-center flex-grow-1 flex-lg-grow-0">
                        <img alt="Logo" src="./assets/images/logos/logo-light.svg" class="h-30px d-sm-none" />
                        <img alt="Logo" src="./assets/images/logos/logo-light.svg" class="h-30px d-none d-sm-block" />
                        <ul class="nav nav-stretch nav-line-tabs border-transparent ms-10 h-100" role="tablist">
                            <?php include_once './app/Views/Partials/shop-register-tabs.php'; ?>
                        </ul>
                    </div>
                    <div class="d-flex align-items-center justify-content-between flex-lg-grow-1" id="kt_app_header_wrapper">
                        <div></div>
                        <a href="#" class="btn btn-light-primary btn-flex btn-center btn-active-light-primary show menu-dropdown align-self-center" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
                            Actions
                        </a>
                        <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true" style="z-index: 107; position: fixed; inset: 0px 0px auto auto; margin: 0px; transform: translate(-60px, 539px);" data-popper-placement="bottom-end">
                            <div class="menu-item px-3">
                                <a href="apps.php" class="menu-link px-3">
                                    Backend
                                </a>
                            </div>
                            <div class="menu-item px-3">
                                <a href="javascript:void(0);" class="menu-link px-3" id="closer-register">
                                    Close Register
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
             <div class="app-container container-xxl">
                <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
                    <div class="d-flex flex-column flex-column-fluid">
                        <div id="kt_app_content" class="app-content flex-column-fluid mt-0">
                            <div class="tab-content">
                                <?php include_once './app/Views/Partials/shop-register-tab-contents.php'; ?>                                    
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

<script type="module" src="./assets/js/page/shop-register/index.js?v=<?= rand(); ?>"></script>

</body>
</html>