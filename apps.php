<?php
    require_once './app/Views/Partials/required-files.php';

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

<body id="kt_body" class="app-default bgi-size-cover bgi-attachment-fixed bgi-position-center bgi-no-repeat" data-kt-app-page-loading-enabled="true" data-kt-app-page-loading="off">
    <div class="d-flex flex-column flex-root app-root" id="kt_app_root">
        <div class="app-page flex-column flex-column-fluid" id="kt_app_page">
            <?php 
                require_once './app/Views/Partials/header.php';
            ?>
            <div class="app-wrapper flex-column flex-row-fluid" id="kt_app_wrapper">
                <div id="kt_app_toolbar" class="app-toolbar py-6">
                    <div id="kt_app_toolbar_container" class="app-container container-xxl d-flex align-items-start">
                        <div class="d-flex flex-column flex-row-fluid">                                
                            <div class="d-flex flex-stack flex-wrap flex-lg-nowrap gap-4 gap-lg-10 pt-0 pb-6">
                                <div class="page-title me-5">
                                    <h1 class="page-heading d-flex text-white fw-bold fs-2 flex-column justify-content-center my-0">
                                        <span class="page-desc text-gray-600 fw-semibold fs-6 pt-3">
                                           <?= $pageTitle ?>
                                        </span>
                                    </h1>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="app-container container-xxl">
                    <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
                        <div class="d-flex flex-column flex-column-fluid">
                            <div id="kt_app_content" class="app-content flex-column-fluid">
                                <div class="row g-5 g-xl-9">
                                    <?php
                                        $apps = '';
                                                    
                                        $appModules = $authentication->fetchAppModuleStack($userID);

                                        foreach ($appModules as $row) {
                                            $appModuleID = $row['app_module_id'];
                                            $appModuleName = $row['app_module_name'];
                                            $appModuleDescription = $row['app_module_description'];
                                            $menuItemID = $row['menu_item_id'];
                                            $appLogo = $systemHelper->checkImageExist($row['app_logo'], 'app module logo');

                                            $menuItemDetails = $menuItem->fetchMenuItem($menuItemID);
                                            $menuItemURL = $menuItemDetails['menu_item_url'] ?? null;
                                                        
                                            $apps .= '<div class="col-md-6 col-xl-4">
                                                        <a href="'. $menuItemURL .'?app_module_id='. $security->encryptData($appModuleID) .'&page_id='. $security->encryptData($menuItemID) .'" class="card border-hover-primary">
                                                            <div class="card-header border-0 pt-9">
                                                                <div class="card-title m-0">
                                                                    <div class="symbol symbol-50px w-50px bg-light">
                                                                        <img src="'. $appLogo .'" alt="image" class="p-3" />
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="card-body p-9">
                                                                <div class="fs-1 fw-bold text-gray-900">
                                                                    '. $appModuleName .'
                                                                </div>
                                                                <p class="text-gray-500 fw-semibold fs-7 mt-1">
                                                                    '. $appModuleDescription .'
                                                                </p>
                                                            </div>
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
    <?php 
        require_once './app/Views/Partials/error-modal.php';
        require_once './app/Views/Partials/required-js.php';        
    ?>
</body>
</html>