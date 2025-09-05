<?php
    require_once './config/config.php';
    require_once './config/session-check.php';

    use App\Core\Security;

    $pageTitle = 'Forgot Password';
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

    <div class="d-flex flex-column flex-lg-row flex-column-fluid">
        <div class="d-flex flex-column flex-sm-center flex-lg-row-fluid w-lg-50 p-10 order-2 order-lg-1">
            <div class="d-flex flex-center flex-column flex-lg-row-fluid">
                <div class="w-lg-500px p-10">
                    <form class="form w-100" id="forgot_password_form" method="post" action="#">
                        <?= Security::csrfInput('forgot_password_form'); ?>
                        <img src="./assets/images/logos/logo-dark.svg" class="mb-5" alt="Logo-Dark" />
                        <h2 class="mb-2 mt-4 fs-1 fw-bolder">Forgot Password?</h2>
                        <p class="mb-10 fs-5">Please enter the email address associated with your account. We will send you a link to reset your password.</p>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="text" class="form-control" id="email" name="email" autocomplete="off">
                        </div>

                        <div class="d-flex flex-wrap justify-content-center pb-lg-0">
                            <button id="forgot-password" type="submit" class="btn btn-primary me-4">Submit</button>
                            <a href="index.php" class="btn btn-light">Cancel</a>                                
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <div class="d-flex flex-lg-row-fluid w-lg-50 bgi-size-cover bgi-position-center order-1 order-lg-2" style="background-image: url(./assets/images/background/login-bg.jpg);">
        </div>
    </div>
    <?php 
        require_once './app/Views/Partials/error-modal.php';
        require_once './app/Views/Partials/required-js.php';        
    ?>

    <script type="module" src="./assets/js/auth/forgot-password.js?v=<?php echo rand(); ?>"></script>
</body>
</html>