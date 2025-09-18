<?php
    require_once './app/Views/Partials/required-files.php';
    require_once './app/Views/Partials/page-details.php';
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

<body id="kt_body" class="app-blank bgi-size-cover bgi-attachment-fixed bgi-position-center bgi-no-repeat" data-kt-app-page-loading-enabled="true" data-kt-app-page-loading="off">
    <div class="d-flex flex-column flex-root app-root" id="kt_app_root">
        <div class="app-page flex-column flex-column-fluid" id="kt_app_page">
            <?php 
                require_once './app/Views/Partials/header.php';
            ?>
            <div class="app-wrapper flex-column flex-row-fluid" id="kt_app_wrapper">
                <?php 
                    require_once './app/Views/Partials/breadcrumbs.php';
                ?>
                <div class="app-container container-xxl">
                    <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
                        <div class="d-flex flex-column flex-column-fluid">
                            <div id="kt_app_content" class="app-content flex-column-fluid">
                                <?php 
                                    if($newRecord){
                                        require_once './app/Views/Page/religion/new.php';
                                    }
                                    else if(!empty($detailID)){
                                        require_once './app/Views/Page/religion/details.php';
                                    }
                                    else if(isset($_GET['import']) && !empty($_GET['import'])){
                                        require_once './app/Views/Page/import/import.php';
                                    }
                                    else{
                                        require_once './app/Views/Page/religion/index.php';
                                    }
                                ?>
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

    <?php
        $version = rand();
        $scriptFile = './assets/js/page/religion/index.js';

        if ($newRecord) {
            $scriptFile = './assets/js/page/religion/new.js';
        }
        else if (!empty($detailID)) {
            $scriptFile = './assets/js/page/religion/details.js';
        }
        else if (isset($_GET['import']) && !empty($_GET['import'])) {
            $scriptFile = './assets/js/page/import/import.js'; 
        }
    ?>
    
    <script type="module" src="<?= $scriptFile ?>?v=<?= $version ?>"></script>

</body>
</html>