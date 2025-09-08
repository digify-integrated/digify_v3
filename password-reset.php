<?php
    require_once './config/config.php';
    require_once './config/session-check.php';

    use App\Core\Security;
    use App\Models\Authentication;

    $authentication = new Authentication();

    $pageTitle = 'Password Reset';

   if (isset($_GET['id']) && !empty($_GET['id']) && isset($_GET['token']) && !empty($_GET['token'])) {
        $id = $_GET['id'];
        $token = $_GET['token'];
        $userAccountId = Security::decryptData($id);
 
        $resetTokenDetails = $authentication->fetchResetToken($userAccountId);
        $resetToken = $resetTokenDetails['reset_token'] ?? null;
        $resetTokenExpiryDate = $resetTokenDetails['reset_token_expiry_date'] ?? null;

        if(!Security::verifyToken($token, $resetToken) || strtotime(date('Y-m-d H:i:s')) > strtotime($resetTokenExpiryDate)){
            header('location: 404.php');
            exit;
        }
    }
    else {
        header('location: 404.php');
        exit;
    }
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
                <div class="w-lg-600px p-10">
                    <form class="form w-100" id="password_reset_form" method="post" action="#">
                        <?= Security::csrfInput('password_reset_form'); ?>
                        <img src="./assets/images/logos/logo-dark.svg" class="mb-5" alt="Logo-Dark" />
                        <h2 class="mb-2 mt-4 fs-1 fw-bolder">Password Reset</h2>
                        <p class="mb-10 fs-5">Enter your new password</p>                        
                        <input type="hidden" id="user_account_id" name="user_account_id" value="<?php echo $userAccountId; ?>">
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
        
        <div class="d-flex flex-lg-row-fluid w-lg-50 bgi-size-cover bgi-position-center order-1 order-lg-2" style="background-image: url(./assets/images/background/login-bg.jpg);">
        </div>
    </div>
    <?php 
        require_once './app/Views/Partials/error-modal.php';
        require_once './app/Views/Partials/required-js.php';        
    ?>

    <script type="module" src="./assets/js/auth/password-reset.js?v=<?php echo rand(); ?>"></script>
</body>
</html>