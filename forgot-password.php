<?php
    require_once 'config/config.php';
    require_once 'autoload.php';

    use App\Models\Authentication;
    use App\Core\Security;

    $security = new Security();
    $authentication = new Authentication();

    $pageTitle = APP_NAME . ' | Password Reset';

    if (!empty($_GET['id']) && !empty($_GET['token'])) {
        $userID = $security->decryptData($_GET['id']);
        $token = $security->decryptData($_GET['token']);
    
        $loginCredentials = $authentication->getLoginCredentials($userID, null);
    
        $resetToken = $security->decryptData($loginCredentials['reset_token']);
        $resetTokenExpiry = strtotime($security->decryptData($loginCredentials['reset_token_expiry_date']));
        $currentTimestamp = time();
    
        if ($token !== $resetToken || $currentTimestamp > $resetTokenExpiry) {
            header('Location: 404.php');
            exit;
        }
    }
    else {
        header('Location: index.php');
        exit;
    }
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <?php 
        require_once './app/Views/Includes/head-meta-tags.php'; 
        require_once './app/Views/Includes/head-stylesheet.php';
    ?>
</head>

<?php require_once './app/Views/Includes/theme-script.php'; ?>

<body id="kt_body" class="app-blank bgi-size-cover bgi-attachment-fixed bgi-position-center bgi-no-repeat" data-kt-app-page-loading-enabled="true" data-kt-app-page-loading="on">
    <?php require_once './app/Views/Includes/preloader.php'; ?>
    <div class="d-flex flex-column flex-root" id="kt_app_root" style="background-image: url('./assets/images/backgrounds/login-bg.jpg');">
        <div class="d-flex flex-column flex-column-fluid flex-lg-row align-items-center justify-content-center">
            <div class="d-flex flex-column-fluid flex-lg-row-auto justify-content-center justify-content-lg-end p-5">
                <div class="bg-body d-flex flex-column align-items-stretch flex-center rounded-4 w-md-600px p-10">
                    <div class="d-flex flex-center flex-column flex-column-fluid px-lg-5 pb-5">
                        <form class="form w-100" id="password-reset-form" method="post" action="#">
                            <input type="hidden" name="user_account_id" value="<?php echo $userID; ?>">
                            <img src="./assets/images/logos/logo-dark.svg" class="mb-5" alt="Logo-Dark" />
                            <h2 class="mb-2 mt-4 fs-1 fw-bolder">Password Reset</h2>
                            <p class="mb-10 fs-5">Enter your new password</p>
                            <div class="mb-3">
                                <label for="new_password" class="form-label">New Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="new_password" name="new_password">
                                    <button class="btn btn-light bg-transparent password-addon" type="button">
                                        <i class="ki-outline ki-eye-slash fs-2 p-0"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="mb-5">
                                <label for="confirm_password" class="form-label">Confirm Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="confirm_password" name="confirm_password">
                                    <button class="btn btn-light bg-transparent password-addon" type="button">
                                        <i class="ki-outline ki-eye-slash fs-2 p-0"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="d-grid">
                                <button id="reset" type="submit" class="btn btn-primary">Reset Password</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <?php 
        require_once './app/Views/Includes/error-modal.php';
        require_once './app/Views/Includes/required-js.php';        
    ?>

    <script type="module" src="./assets/js/pages/password-reset.js?v=<?php echo rand(); ?>"></script>
</body>
</html>