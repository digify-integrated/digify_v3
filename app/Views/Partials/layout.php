<?php
    require_once './app/Views/Partials/required-files.php';
    require_once './app/Views/Partials/page-details.php';

    use App\Helpers\SystemHelper;
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
                                    $options    = [
                                        'newRecord' => $newRecord ?? false, 
                                        'detailID'  => $detailID ?? null
                                    ];

                                    if($folder == 'product-variant'){
                                        if (!empty($detailID)) {
                                            $contentOverride = './app/Views/Page/product/details.php';
                                            $scriptOverride  = './assets/js/page/product/details.js';
                                        }
                                    }

                                    extract(SystemHelper::fetchPageFiles($folder, $options));
                                    
                                    if(isset($contentFile) && file_exists($contentFile)) require $contentFile; 
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

    <?php if(isset($scriptFile) && file_exists($scriptFile)): ?>
        <script type="module" src="<?= $scriptFile ?>?v=<?= rand() ?>"></script>
    <?php endif; ?>

</body>
</html>
