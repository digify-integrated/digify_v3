<?php
    session_start();
    require_once './config/config.php';

    use App\Core\Security;

    $pageTitle = APP_NAME;
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
        <div class="d-flex flex-column flex-lg-row-fluid w-lg-50 p-10 order-2 order-lg-1">
            <div class="d-flex flex-center flex-column flex-lg-row-fluid">
                <div class="w-lg-500px p-10">
                    <form class="form w-100" id="login_form" method="post" action="#">
                        <?= Security::csrfInput('login_form'); ?>
                        <img src="./assets/images/logos/logo-dark.svg" class="mb-5" alt="Logo-Dark" />
                        <h2 class="mb-2 mt-4 fs-1 fw-bolder">Login to your account</h2>
                        <p class="mb-10 fs-5">Enter your email below to login to your account</p>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="text" class="form-control" id="email" name="email" autocomplete="off">
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="password" name="password">
                                <button class="btn btn-light bg-transparent password-addon" type="button">
                                    <i class="ki-outline ki-eye-slash fs-2 p-0"></i>
                                </button>
                            </div>
                        </div>
                        <div class="d-flex flex-stack flex-wrap gap-3 fs-base fw-semibold mb-8">
                            <a href="forgot-password.php" class="link-primary">Forgot Password?</a>
                        </div>

                        <div class="d-grid">
                            <button id="signin" type="submit" class="btn btn-primary">Sign In</button>
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

    <script type="module" src="./assets/js/auth/login.js?v=<?php echo rand(); ?>"></script>
</body>
</html>