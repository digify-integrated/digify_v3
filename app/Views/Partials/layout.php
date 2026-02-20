<?php
declare(strict_types=1);

require_once './app/Views/Partials/required-files.php';
require_once './app/Views/Partials/page-details.php';

use App\Helpers\SystemHelper;

$view = $view ?? [];

// folder is required (fall back to old $folder usage if you still do that)
$folder = $view['folder'] ?? ($folder ?? '');

// IMPORTANT: after page-details.php, $newRecord/$detailID should be available
// Let $view override them, otherwise use the ones set by page-details.php
$newRecord = $view['options']['newRecord'] ?? ($newRecord ?? false);
$detailID  = $view['options']['detailID']  ?? ($detailID ?? null);

// Determine page exactly like your original logic
$page = 'index';
if (!empty($_GET['import'])) {
    $page = 'import';
    $folderForImport = 'import';
} elseif (!empty($newRecord)) {
    $page = 'new';
} elseif (isset($detailID) && $detailID !== '' && $detailID !== null) {
    $page = 'details';
}

$overrides = $view['overrides'] ?? [];

// Build file paths (import uses its own folder)
if ($page === 'import') {
    $contentFile = "./app/Views/Page/import/import.php";
    $scriptFile  = "./assets/js/page/import/import.js";
} else {
    $contentFile = "./app/Views/Page/{$folder}/{$page}.php";
    $scriptFile  = "./assets/js/page/{$folder}/{$page}.js";
}

// Optional overrides
if (!empty($overrides['content'])) $contentFile = $overrides['content'];
if (!empty($overrides['script']))  $scriptFile  = $overrides['script'];

// Optional data extraction for views
$data = $view['data'] ?? [];
if (is_array($data) && !empty($data)) {
    extract($data, EXTR_SKIP);
}

$assetVersion = static function (string $path): string {
    return is_file($path) ? (string) filemtime($path) : (string) time();
};
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

<body id="kt_body" class="app-blank bgi-size-cover bgi-attachment-fixed bgi-position-center bgi-no-repeat"
      data-kt-app-page-loading-enabled="true" data-kt-app-page-loading="off">
<div class="d-flex flex-column flex-root app-root" id="kt_app_root">
    <div class="app-page flex-column flex-column-fluid" id="kt_app_page">
        <?php require_once './app/Views/Partials/header.php'; ?>
        <div class="app-wrapper flex-column flex-row-fluid" id="kt_app_wrapper">
            <?php require_once './app/Views/Partials/breadcrumbs.php'; ?>
            <div class="app-container container-xxl">
                <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
                    <div class="d-flex flex-column flex-column-fluid">
                        <div id="kt_app_content" class="app-content flex-column-fluid">
                            <?php if (is_file($contentFile)) require $contentFile; ?>
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

<?php if (is_file($scriptFile)): ?>
    <script type="module" src="<?= htmlspecialchars($scriptFile) ?>?v=<?= $assetVersion($scriptFile) ?>"></script>
<?php endif; ?>

</body>
</html>