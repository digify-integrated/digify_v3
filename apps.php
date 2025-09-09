<?php
    require_once './app/Views/Partials/required-files.php';
    
    use App\Helpers\SystemHelper;

    $pageTitle = 'Apps';
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <?php 
        require_once './app/Views/Partials/head-meta-tags.php'; 
        require_once './app/Views/Partials/head-stylesheet.php';
    ?>
</head>

<?php require_once './app/Views/Partials/theme-script.php'; ?>

<body id="kt_body" class="app-blank bgi-size-cover bgi-attachment-fixed bgi-position-center bgi-no-repeat" data-kt-app-page-loading-enabled="true" data-kt-app-page-loading="on">
    <?php require_once './app/Views/Partials/preloader.php'; ?>

    <div class="d-flex flex-column flex-root app-root" id="kt_app_root">
        <div class="app-page flex-column flex-column-fluid" id="kt_app_page">
            <?php 
                require_once('./app/Views/Partials/header.php');
            ?>
            <div class="app-wrapper flex-column flex-row-fluid" id="kt_app_wrapper">
                <div id="kt_app_toolbar" class="app-toolbar py-6">
                    <div id="kt_app_toolbar_container" class="app-container container-xxl d-flex align-items-start">
                        <div class="d-flex flex-column flex-row-fluid">
                            <div class="d-flex flex-stack flex-wrap flex-lg-nowrap gap-4 gap-lg-10 pt-8 pb-6 mb-lg-0 mb-8">
                                <div class="page-title me-5">
                                    <h1 class="page-heading d-flex text-white fw-bold fs-2 flex-column justify-content-center my-0">
                                        <?php echo $pageTitle; ?>
                                    </h1>
                                </div>
                                <div class="d-flex align-self-center flex-center flex-shrink-0">
                                    <a href="app-installer.php" class="btn btn-flex btn-sm btn-outline btn-active-color-primary btn-custom px-4">
                                        <i class="ki-outline ki-plus-square fs-4 me-2"></i> Install Apps
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="app-container container-xxl">
                    <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
                        <div class="d-flex flex-column flex-column-fluid">
                            <div id="kt_app_content" class="app-content flex-column-fluid">
                                <div class="row g-5 g-xl-8">
                                    <div class="col-xl-12">
                                        <div class="row mb-5 mb-xl-8 g-5 g-xl-8">
                                             <?php
                                                $apps = '';
                                                    
                                                $appModules = $authentication->fetchAppModuleStack($userID);

                                                foreach ($appModules as $row) {
                                                    $appModuleID = $row['app_module_id'];
                                                    $appModuleName = $row['app_module_name'];
                                                    $appModuleDescription = $row['app_module_description'];
                                                    $menuItemID = $row['menu_item_id'];
                                                    $appLogo = SystemHelper::checkImageExist($row['app_logo'], 'app module logo');

                                                    $menuItemDetails = $menuItemModel->fetchMenuItem($menuItemID);
                                                    $menuItemURL = $menuItemDetails['menu_item_url'] ?? null;
                                                        
                                                    $apps .= ' <div class="col-lg-2" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="'. $appModuleDescription .'">
                                                                    <a class="card d-flex justify-content-between flex-column flex-center w-100 text-gray-800 p-10 text-center" href="'. $menuItemURL .'?app_module_id='. Security::encryptData($appModuleID) .'&page_id='. Security::encryptData($menuItemID) .'">
                                                                        <img src="'. $appLogo .'" alt="app-logo" class="img-fluid position-relative mb-5" width="75" height="75">
                                                                        <span class="fs-2 fw-bold">'. $appModuleName .'</span>
                                                                    </a>
                                                                </div>';
                                                }
                                                
                                                echo $apps;
                                            ?>
                                        </div>
                                    </div>
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
</body>
</html>