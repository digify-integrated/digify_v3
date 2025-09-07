<?php
    require_once './config/config.php';
    require_once './config/session-check.php';

    use App\Core\Security;
    use App\Models\Authentication;

    $authentication = new Authentication();

    $pageTitle = 'OTP Verification';

    if (isset($_GET['id']) && !empty($_GET['id'])) {
        $id = $_GET['id'];
        $userAccountId = Security::decryptData($id);
 
        $loginCredentialsDetails = $authentication->fetchLoginCredentials($userAccountId);
        $emailObscure = Security::obscureEmail($loginCredentialsDetails['email']);
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
                <div class="w-lg-700px p-10">
                    <form class="form w-100" id="otp_form" method="post" action="#">
                        <?= Security::csrfInput('otp_form'); ?>
                        <img src="./assets/images/logos/logo-dark.svg" class="mb-5" alt="Logo-Dark" />
                        <h2 class="mb-2 mt-4 fs-1 fw-bolder">Two Step Verification</h2>
                        <p class="mb-3 fs-5">Enter the verification code we sent to </p>
                        <div class="fw-bold text-gray-900 fs-4 mb-5"><?php echo $emailObscure; ?></div>
                        <input type="hidden" id="user_account_id" name="user_account_id" value="<?php echo $userAccountId; ?>">
                        <div class="mb-8">
                            <label class="form-label fw-semibold">Type your 6 digit security code</label>
                            <div class="d-flex align-items-center gap-2 gap-sm-3">
                                <input type="text" class="form-control text-center otp-input" id="otp_code_1" name="otp_code_1" autocomplete="off" maxlength="1">
                                <input type="text" class="form-control text-center otp-input" id="otp_code_2" name="otp_code_2" autocomplete="off" maxlength="1">
                                <input type="text" class="form-control text-center otp-input" id="otp_code_3" name="otp_code_3" autocomplete="off" maxlength="1">
                                <input type="text" class="form-control text-center otp-input" id="otp_code_4" name="otp_code_4" autocomplete="off" maxlength="1">
                                <input type="text" class="form-control text-center otp-input" id="otp_code_5" name="otp_code_5" autocomplete="off" maxlength="1">
                                <input type="text" class="form-control text-center otp-input" id="otp_code_6" name="otp_code_6" autocomplete="off" maxlength="1">
                            </div>
                        </div>

                        <div class="d-grid">
                            <button id="verify" type="submit" class="btn btn-primary">Verify</button>
                        </div>

                        <div class="d-flex align-items-center mt-4">
                            <p class="fs-12 mb-0 fw-medium">Didn't get the code?</p>
                            <a class="text-primary fw-semibold ms-2" id="resend-link" href="javascript:void(0)">Resend</a>
                            <span class="text-primary fw-semibold ms-2 d-none" id="countdown"></span>
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

    <script type="module" src="./assets/js/auth/otp-verification.js?v=<?php echo rand(); ?>"></script>
</body>
</html>