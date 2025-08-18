<?php
    require_once './config/config.php'; 

    $pageTitle = APP_NAME;
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

    <div class="d-flex flex-column flex-lg-row flex-column-fluid">
        <!--begin::Body-->
        <div class="d-flex flex-column flex-lg-row-fluid w-lg-50 p-10 order-2 order-lg-1">
            <!--begin::Form-->
            <div class="d-flex flex-center flex-column flex-lg-row-fluid">
                <!--begin::Wrapper-->
                <div class="w-lg-500px p-10">
                    <!--begin::Form-->
                    <form class="form w-100" id="signin-form" method="post" action="#">
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
                    <!--end::Form-->
                </div>
                <!--end::Wrapper-->
            </div>
            <!--end::Form-->

            <!--begin::Footer-->
            <div class="w-lg-500px d-flex flex-stack px-10 mx-auto">
                <!--begin::Languages-->
                <div class="me-10">
                    <!--begin::Toggle-->
                    <button class="btn btn-flex btn-link btn-color-gray-700 btn-active-color-primary rotate fs-base" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-start" data-kt-menu-offset="0px, 0px">
                        <img data-kt-element="current-lang-flag" class="w-20px h-20px rounded me-3" src="/metronic8/demo34/assets/media/flags/united-states.svg" alt="" />

                        <span data-kt-element="current-lang-name" class="me-1">English</span>

                        <span class="d-flex flex-center rotate-180"> <i class="ki-outline ki-down fs-5 text-muted m-0"></i> </span>
                    </button>
                    <!--end::Toggle-->

                    <!--begin::Menu-->
                    <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-800 menu-state-bg-light-primary fw-semibold w-200px py-4 fs-7" data-kt-menu="true" id="kt_auth_lang_menu">
                        <!--begin::Menu item-->
                        <div class="menu-item px-3">
                            <a href="#" class="menu-link d-flex px-5" data-kt-lang="English">
                                <span class="symbol symbol-20px me-4">
                                    <img data-kt-element="lang-flag" class="rounded-1" src="/metronic8/demo34/assets/media/flags/united-states.svg" alt="" />
                                </span>
                                <span data-kt-element="lang-name">English</span>
                            </a>
                        </div>
                        <!--end::Menu item-->
                        <!--begin::Menu item-->
                        <div class="menu-item px-3">
                            <a href="#" class="menu-link d-flex px-5" data-kt-lang="Spanish">
                                <span class="symbol symbol-20px me-4">
                                    <img data-kt-element="lang-flag" class="rounded-1" src="/metronic8/demo34/assets/media/flags/spain.svg" alt="" />
                                </span>
                                <span data-kt-element="lang-name">Spanish</span>
                            </a>
                        </div>
                        <!--end::Menu item-->
                        <!--begin::Menu item-->
                        <div class="menu-item px-3">
                            <a href="#" class="menu-link d-flex px-5" data-kt-lang="German">
                                <span class="symbol symbol-20px me-4">
                                    <img data-kt-element="lang-flag" class="rounded-1" src="/metronic8/demo34/assets/media/flags/germany.svg" alt="" />
                                </span>
                                <span data-kt-element="lang-name">German</span>
                            </a>
                        </div>
                        <!--end::Menu item-->
                        <!--begin::Menu item-->
                        <div class="menu-item px-3">
                            <a href="#" class="menu-link d-flex px-5" data-kt-lang="Japanese">
                                <span class="symbol symbol-20px me-4">
                                    <img data-kt-element="lang-flag" class="rounded-1" src="/metronic8/demo34/assets/media/flags/japan.svg" alt="" />
                                </span>
                                <span data-kt-element="lang-name">Japanese</span>
                            </a>
                        </div>
                        <!--end::Menu item-->
                        <!--begin::Menu item-->
                        <div class="menu-item px-3">
                            <a href="#" class="menu-link d-flex px-5" data-kt-lang="French">
                                <span class="symbol symbol-20px me-4">
                                    <img data-kt-element="lang-flag" class="rounded-1" src="/metronic8/demo34/assets/media/flags/france.svg" alt="" />
                                </span>
                                <span data-kt-element="lang-name">French</span>
                            </a>
                        </div>
                        <!--end::Menu item-->
                    </div>
                    <!--end::Menu-->
                </div>
                <!--end::Languages-->

                <!--begin::Links-->
                <div class="d-flex fw-semibold text-primary fs-base gap-5">
                    <a href="/metronic8/demo34/pages/team.html" target="_blank">Terms</a>

                    <a href="/metronic8/demo34/pages/pricing/column.html" target="_blank">Plans</a>

                    <a href="/metronic8/demo34/pages/contact.html" target="_blank">Contact Us</a>
                </div>
                <!--end::Links-->
            </div>
            <!--end::Footer-->
        </div>
        <!--end::Body-->

        <!--begin::Aside-->
        <div class="d-flex flex-lg-row-fluid w-lg-50 bgi-size-cover bgi-position-center order-1 order-lg-2" style="background-image: url(/metronic8/demo34/assets/media/misc/auth-bg.png);">
            <!--begin::Content-->
            <div class="d-flex flex-column flex-center py-7 py-lg-15 px-5 px-md-15 w-100">
                <!--begin::Logo-->
                <a href="/metronic8/demo34/index.html" class="mb-0 mb-lg-12 d-none d-lg-block">
                    <img alt="Logo" src="/metronic8/demo34/assets/media/logos/custom-1.png" class="h-60px h-lg-75px" />
                </a>
                <!--end::Logo-->

                <!--begin::Image-->
                <img class="d-none d-lg-block mx-auto w-275px w-md-50 w-xl-500px mb-10 mb-lg-20" src="/metronic8/demo34/assets/media/misc/auth-screens.png" alt="" />
                <!--end::Image-->

                <!--begin::Title-->
                <h1 class="d-none d-lg-block text-white fs-2qx fw-bolder text-center mb-7">
                    Fast, Efficient and Productive
                </h1>
                <!--end::Title-->

                <!--begin::Text-->
                <div class="d-none d-lg-block text-white fs-base text-center">
                    In this kind of post, <a href="#" class="opacity-75-hover text-warning fw-bold me-1">the blogger</a>

                    introduces a person they’ve interviewed <br />
                    and provides some background information about

                    <a href="#" class="opacity-75-hover text-warning fw-bold me-1">the interviewee</a>
                    and their <br />
                    work following this is a transcript of the interview.
                </div>
                <!--end::Text-->
            </div>
            <!--end::Content-->
        </div>
        <!--end::Aside-->
    </div>
    <?php 
        require_once './app/Views/Includes/error-modal.php';
        require_once './app/Views/Includes/required-js.php';        
    ?>

    <script type="module" src="./assets/js/auth/login.js?v=<?php echo rand(); ?>"></script>
</body>
</html>