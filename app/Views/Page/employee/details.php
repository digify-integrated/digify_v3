<div class="d-flex flex-column flex-lg-row">
    <div class="flex-column flex-lg-row-auto w-lg-250px w-xl-350px mb-10">
        <div class="card mb-5 mb-xl-8">
            <div class="card-body">
                <div class="d-flex flex-center flex-column py-5">
                    <div class="image-input image-input-outline mb-7" data-kt-image-input="true">
                        <div class="image-input-wrapper w-120px h-120px" id="employee_image_thumbnail" style="background-image: url(./assets/images/default/default-avatar.jpg)"></div>

                        <?php
                            echo ($permissions['write'] > 0) ? '<label class="btn btn-icon btn-circle btn-active-color-primary w-25px h-25px bg-body shadow" data-kt-image-input-action="change" data-bs-toggle="tooltip" aria-label="Change employee image" data-bs-original-title="Change employee image" data-kt-initialized="1">
                                                                    <i class="ki-outline ki-pencil fs-7"></i>
                                                                    <input type="file" id="employee_image" name="employee_image" accept=".png, .jpg, .jpeg">
                                                                </label>' : '';
                        ?>
                    </div>

                    <span class="fs-3 text-gray-800 fw-bold mb-3" id="employee_name_summary">--</span>

                    <div class="mb-0">
                        <div class="badge badge-lg badge-light-primary d-inline" id="job_position_title_summary">--</div>
                    </div>
                </div>
                
                <div class="d-flex flex-stack fs-4 py-3">
                    <div class="fw-bold rotate collapsible active" data-bs-toggle="collapse" href="#employee_view_details" role="button" aria-expanded="true" aria-controls="employee_view_details">
                        Details
                        <span class="ms-2 rotate-180"><i class="ki-outline ki-down fs-3"></i></span>
                    </div>

                    <?php
                        echo ($permissions['write'] > 0) ? '<span data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-original-title="Edit employee details" data-kt-initialized="1">
                                                                <a href="javascript:void(0);" class="btn btn-sm btn-light-primary" id="update-personal-details-button" data-bs-toggle="modal" data-bs-target="#update_personal_details_modal">
                                                                    Edit
                                                                </a>
                                                            </span>' : '';
                    ?>
                </div>

                <div class="separator"></div>

                <div id="employee_view_details" class="collapse show">
                    <div class="pb-5 fs-6">
                        <div class="personal-information-group">
                            <div class="fw-bold mt-5">Nickname</div>
                            <div class="text-gray-600" id="nickname_summary">--</div>
                        </div>

                        <div class="personal-information-group">
                            <div class="fw-bold mt-5">Private Address</div>
                            <div class="text-gray-600" id="private_address_summary">--</div>
                        </div>

                        <div class="personal-information-group">
                            <div class="fw-bold mt-5">Civil Status</div>
                            <div class="text-gray-600" id="civil_status_summary">--</div>
                        </div>

                        <div class="personal-information-group">
                            <div class="fw-bold mt-5">Number of Dependents</div>
                            <div class="text-gray-600" id="dependents_summary">--</div>
                        </div>

                        <div class="personal-information-group">
                            <div class="fw-bold mt-5">Religion</div>
                            <div class="text-gray-600" id="religion_summary">--</div>
                        </div>

                        <div class="personal-information-group">
                            <div class="fw-bold mt-5">Blood Type</div>
                            <div class="text-gray-600" id="blood_type_summary">--</div>
                        </div>
                        
                        <div class="personal-information-group">
                            <div class="fw-bold mt-5">Home-Work Distance</div>
                            <div class="text-gray-600" id="home_work_distance_summary">--</div>
                        </div>

                        <div class="personal-information-group">
                            <div class="fw-bold mt-5">Height</div>
                            <div class="text-gray-600" id="height_summary">--</div>
                        </div>

                        <div class="personal-information-group">
                            <div class="fw-bold mt-5">Weight</div>
                            <div class="text-gray-600" id="weight_summary">--</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card pt-4 mb-6 mb-xl-9">
            <div class="card-header">
                <div class="card-title">
                    <h2>Settings</h2>
                </div>
            </div>
                            
            <div class="card-body pb-5">
                <div class="d-flex flex-wrap align-items-center">
                    <div id="change_pin_code">
                        <div class="fs-6 fw-bold mb-1">PIN Code</div>
                        <div class="fw-semibold text-gray-600">************</div>
                    </div>
                                        
                    <div id="change_pin_code_edit" class="flex-row-fluid d-none">
                        <form id="update_pin_code_form" method="post" action="#">
                            <?= $security->csrfInput('update_pin_code_form'); ?>
                            <div class="row mb-6">
                                <div class="col-lg-12 mb-4 mb-lg-0">
                                    <div class="fv-row mb-0 fv-plugins-icon-container">
                                        <label for="pin_code" class="form-label fs-6 fw-bold mb-3">Enter New PIN Code</label>
                                        <input type="text" class="form-control mb-3 mb-lg-0" id="pin_code" name="pin_code" maxlength="100" autocomplete="off" <?php echo $disabled; ?>>
                                    </div>
                                </div>
                            </div>
                                        
                            <?php
                                echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                        <button id="update_pin_code_submit" form="update_pin_code_form" type="submit" class="btn btn-primary me-2 px-6">Update PIN Code</button>
                                                                        <button id="update_pin_code_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_pin_code">Cancel</button>
                                                                    </div>' : '';
                            ?>
                        </form>
                    </div>

                    <?php
                        echo ($permissions['write'] > 0) ? '<div id="change_pin_code_button" class="ms-auto" data-toggle-section="change_pin_code">
                                                                <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                            </div>' : '';
                    ?>
                </div>

                <div class="separator separator-dashed my-6"></div>
                
                <div class="d-flex flex-wrap align-items-center">
                    <div id="change_badge_id">
                        <div class="fs-6 fw-bold mb-1">Badge ID</div>
                        <div class="fw-semibold text-gray-600" id="badge_id_summary">--</div>
                    </div>
                                        
                    <div id="change_badge_id_edit" class="flex-row-fluid d-none">
                        <form id="update_badge_id_form" method="post" action="#">
                            <?= $security->csrfInput('update_badge_id_form'); ?>
                            <div class="row mb-6">
                                <div class="col-lg-12 mb-4 mb-lg-0">
                                    <div class="fv-row mb-0 fv-plugins-icon-container">
                                        <label for="badge_id" class="form-label fs-6 fw-bold mb-3">Enter New Badge ID</label>
                                        <input type="text" class="form-control mb-3 mb-lg-0" id="badge_id" name="badge_id" maxlength="100" autocomplete="off" <?php echo $disabled; ?>>
                                    </div>
                                </div>
                            </div>
                                        
                            <?php
                                echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                        <button id="update_badge_id_submit" form="update_badge_id_form" type="submit" class="btn btn-primary me-2 px-6">Update Badge ID</button>
                                                                        <button id="update_badge_id_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_badge_id">Cancel</button>
                                                                    </div>' : '';
                            ?>
                        </form>
                    </div>

                    <?php
                        echo ($permissions['write'] > 0) ? '<div id="change_badge_id_button" class="ms-auto" data-toggle-section="change_badge_id">
                                                                <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                            </div>' : '';
                    ?>
                </div>
            </div>
        </div>
        
        <div class="card pt-4 mb-6 mb-xl-9">
            <div class="card-header">
                <div class="card-title flex-column">
                    <h2 class="mb-1">Language</h2>
                </div>

                <div class="card-toolbar">
                    <?php
                        echo ($permissions['write'] > 0) ? '<button type="button" class="btn btn-light-primary btn-sm" id="add-language" data-bs-toggle="modal" data-bs-target="#employee_language_modal">
                                                                Add Language
                                                            </button>' : '';
                    ?>
                </div>
            </div>
            
            <div class="card-body pb-5" id="language_summary">
                <div class="d-flex flex-stack">
                    <div class="d-flex align-items-center flex-row-fluid flex-wrap mb-4">
                        <div class="flex-grow-1 me-2">
                             <div class="text-gray-800 fs-5 fw-bold">No language found</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="flex-lg-row-fluid ms-lg-15">
        <ul class="nav nav-custom nav-tabs nav-line-tabs nav-line-tabs-2x border-0 fs-4 fw-semibold mb-8" role="tablist">
            <li class="nav-item" role="presentation">
                <a class="nav-link text-active-primary pb-4 active" data-bs-toggle="tab" href="#private_details_tab" aria-selected="false" role="tab" tabindex="-1">Private Details</a>
            </li>
            
            <li class="nav-item" role="presentation">
                <a class="nav-link text-active-primary pb-4" data-kt-countup-tabs="true" data-bs-toggle="tab" href="#work_information_tab" data-kt-initialized="1" aria-selected="true" role="tab">Work Information</a>
            </li>            
            
            <li class="nav-item" role="presentation">
                <a class="nav-link text-active-primary pb-4" data-bs-toggle="tab" href="#work_experience_tab" aria-selected="false" tabindex="-1" role="tab">Work Experience</a>
            </li>
            
            <li class="nav-item" role="presentation">
                <a class="nav-link text-active-primary pb-4" data-bs-toggle="tab" href="#employee_document_tab" aria-selected="false" tabindex="-1" role="tab">Employee Documents</a>
            </li>
            
            <li class="nav-item ms-auto">
                <a href="#" class="btn btn-primary ps-7" data-kt-menu-trigger="click" data-kt-menu-attach="parent" data-kt-menu-placement="bottom-end">
                    Actions
                    <i class="ki-outline ki-down fs-2 me-0"></i>
                </a>
                <!--begin::Menu-->
                <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-800 menu-state-bg-light-primary fw-semibold py-4 w-250px fs-6" data-kt-menu="true">
                    <!--begin::Menu item-->
                    <div class="menu-item px-5">
                        <div class="menu-content text-muted pb-2 px-5 fs-7 text-uppercase">
                            Payments
                        </div>
                    </div>
                    <!--end::Menu item-->

                    <!--begin::Menu item-->
                    <div class="menu-item px-5">
                        <a href="#" class="menu-link px-5">
                            Create invoice
                        </a>
                    </div>
                    <!--end::Menu item-->

                    <!--begin::Menu item-->
                    <div class="menu-item px-5">
                        <a href="#" class="menu-link flex-stack px-5">
                            Create payments

                            <span class="ms-2" data-bs-toggle="tooltip" aria-label="Specify a target name for future usage and reference" data-bs-original-title="Specify a target name for future usage and reference" data-kt-initialized="1">
                                <i class="ki-outline ki-information fs-7"></i>
                            </span>
                        </a>
                    </div>
                    <!--end::Menu item-->

                    <!--begin::Menu item-->
                    <div class="menu-item px-5" data-kt-menu-trigger="hover" data-kt-menu-placement="left-start">
                        <a href="#" class="menu-link px-5">
                            <span class="menu-title">Subscription</span>
                            <span class="menu-arrow"></span>
                        </a>

                        <!--begin::Menu sub-->
                        <div class="menu-sub menu-sub-dropdown w-175px py-4">
                            <!--begin::Menu item-->
                            <div class="menu-item px-3">
                                <a href="#" class="menu-link px-5">
                                    Apps
                                </a>
                            </div>
                            <!--end::Menu item-->

                            <!--begin::Menu item-->
                            <div class="menu-item px-3">
                                <a href="#" class="menu-link px-5">
                                    Billing
                                </a>
                            </div>
                            <!--end::Menu item-->

                            <!--begin::Menu item-->
                            <div class="menu-item px-3">
                                <a href="#" class="menu-link px-5">
                                    Statements
                                </a>
                            </div>
                            <!--end::Menu item-->

                            <!--begin::Menu separator-->
                            <div class="separator my-2"></div>
                            <!--end::Menu separator-->

                            <!--begin::Menu item-->
                            <div class="menu-item px-3">
                                <div class="menu-content px-3">
                                    <label class="form-check form-switch form-check-custom form-check-solid">
                                        <input class="form-check-input w-30px h-20px" type="checkbox" value="" name="notifications" checked="" id="kt_user_menu_notifications" />
                                        <span class="form-check-label text-muted fs-6" for="kt_user_menu_notifications">
                                            Notifications
                                        </span>
                                    </label>
                                </div>
                            </div>
                            <!--end::Menu item-->
                        </div>
                        <!--end::Menu sub-->
                    </div>
                    <!--end::Menu item-->

                    <!--begin::Menu separator-->
                    <div class="separator my-3"></div>
                    <!--end::Menu separator-->

                    <!--begin::Menu item-->
                    <div class="menu-item px-5">
                        <div class="menu-content text-muted pb-2 px-5 fs-7 text-uppercase">
                            Account
                        </div>
                    </div>
                    <!--end::Menu item-->

                    <!--begin::Menu item-->
                    <div class="menu-item px-5">
                        <a href="#" class="menu-link px-5">
                            Reports
                        </a>
                    </div>
                    <!--end::Menu item-->

                    <!--begin::Menu item-->
                    <div class="menu-item px-5 my-1">
                        <a href="#" class="menu-link px-5">
                            Account Settings
                        </a>
                    </div>
                    <!--end::Menu item-->

                    <!--begin::Menu item-->
                    <div class="menu-item px-5">
                        <a href="#" class="menu-link text-danger px-5">
                            Delete customer
                        </a>
                    </div>
                    <!--end::Menu item-->
                </div>
                <!--end::Menu-->
                <!--end::Menu-->
            </li>            
        </ul>

        <div class="tab-content">
            <div class="tab-pane fade active show" id="private_details_tab" role="tabpanel">
                <div class="card pt-4 mb-6 mb-xl-9">
                    <div class="card-header">
                        <div class="card-title">
                            <h2>Private Contact</h2>
                        </div>
                    </div>
                    
                    <div class="card-body pb-5">
                        <div class="d-flex flex-wrap align-items-center">
                            <div id="change_private_email">
                                <div class="fs-6 fw-bold mb-1">Private Email</div>
                                <div class="fw-semibold text-gray-600" id="private_email_summary">--</div>
                            </div>
                                        
                            <div id="change_private_email_edit" class="flex-row-fluid d-none">
                                <form id="update_private_email_form" method="post" action="#">
                                    <?= $security->csrfInput('update_private_email_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="private_email" class="form-label fs-6 fw-bold mb-3">Enter New Private Email</label>
                                                <input type="email" class="form-control" maxlength="300" id="private_email" name="private_email" autocomplete="off" <?php echo $disabled; ?>>
                                            </div>
                                        </div>
                                    </div>
                                        
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_private_email_submit" form="update_private_email_form" type="submit" class="btn btn-primary me-2 px-6">Update Private Email</button>
                                                                                <button id="update_private_email_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_private_email">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_private_email_button" class="ms-auto" data-toggle-section="change_private_email">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>

                        <div class="separator separator-dashed my-6"></div>

                        <div class="d-flex flex-wrap align-items-center">
                            <div id="change_private_phone">
                                <div class="fs-6 fw-bold mb-1">Private Phone</div>
                                <div class="fw-semibold text-gray-600" id="private_phone_summary">--</div>
                            </div>
                                        
                            <div id="change_private_phone_edit" class="flex-row-fluid d-none">
                                <form id="update_private_phone_form" method="post" action="#">
                                    <?= $security->csrfInput('update_private_phone_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="private_phone" class="form-label fs-6 fw-bold mb-3">Enter New Private Phone</label>
                                                <input type="text" class="form-control" maxlength="300" id="private_phone" name="private_phone" autocomplete="off" <?php echo $disabled; ?>>
                                            </div>
                                        </div>
                                    </div>
                                        
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_private_phone_submit" form="update_private_phone_form" type="submit" class="btn btn-primary me-2 px-6">Update Private Phone</button>
                                                                                <button id="update_private_phone_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_private_phone">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_private_phone_button" class="ms-auto" data-toggle-section="change_private_phone">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>

                        <div class="separator separator-dashed my-6"></div>

                        <div class="d-flex flex-wrap align-items-center mb-6">
                            <div id="change_private_telephone">
                                <div class="fs-6 fw-bold mb-1">Private Telephone</div>
                                <div class="fw-semibold text-gray-600" id="private_telephone_summary">--</div>
                            </div>
                                        
                            <div id="change_private_telephone_edit" class="flex-row-fluid d-none">
                                <form id="update_private_telephone_form" method="post" action="#">
                                    <?= $security->csrfInput('update_private_telephone_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="private_telephone" class="form-label fs-6 fw-bold mb-3">Enter New Private Telephone</label>
                                                <input type="text" class="form-control" maxlength="300" id="private_telephone" name="private_telephone" autocomplete="off" <?php echo $disabled; ?>>
                                            </div>
                                        </div>
                                    </div>
                                        
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_private_telephone_submit" form="update_private_telephone_form" type="submit" class="btn btn-primary me-2 px-6">Update Private Telephone</button>
                                                                                <button id="update_private_telephone_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_private_telephone">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_private_telephone_button" class="ms-auto" data-toggle-section="change_private_telephone">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>
                    </div>
                </div>

                <div class="card pt-4 mb-6 mb-xl-9">
                    <div class="card-header">
                        <div class="card-title">
                            <h2>Citizenship</h2>
                        </div>
                    </div>
                    
                    <div class="card-body pb-5">
                        <div class="d-flex flex-wrap align-items-center">
                            <div id="change_nationality">
                                <div class="fs-6 fw-bold mb-1">Nationality</div>
                                <div class="fw-semibold text-gray-600" id="nationality_summary">--</div>
                            </div>
                                        
                            <div id="change_nationality_edit" class="flex-row-fluid d-none">
                                <form id="update_nationality_form" method="post" action="#">
                                    <?= $security->csrfInput('update_nationality_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="nationality_id" class="form-label fs-6 fw-bold mb-3">Select New Nationality</label>
                                                <select id="nationality_id" name="nationality_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                                            </div>
                                        </div>
                                    </div>
                                        
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_nationality_submit" form="update_nationality_form" type="submit" class="btn btn-primary me-2 px-6">Update Nationality</button>
                                                                                <button id="update_nationality_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_nationality">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_nationality_button" class="ms-auto" data-toggle-section="change_nationality">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>

                        <div class="separator separator-dashed my-6"></div>

                        <div class="d-flex flex-wrap align-items-center">
                            <div id="change_gender">
                                <div class="fs-6 fw-bold mb-1">Gender</div>
                                <div class="fw-semibold text-gray-600" id="gender_summary">--</div>
                            </div>
                                        
                            <div id="change_gender_edit" class="flex-row-fluid d-none">
                                <form id="update_gender_form" method="post" action="#">
                                    <?= $security->csrfInput('update_gender_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="gender_id" class="form-label fs-6 fw-bold mb-3">Enter New Gender</label>
                                                <select id="gender_id" name="gender_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                                            </div>
                                        </div>
                                    </div>
                                        
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_gender_submit" form="update_gender_form" type="submit" class="btn btn-primary me-2 px-6">Update Gender</button>
                                                                                <button id="update_gender_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_gender">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_gender_button" class="ms-auto" data-toggle-section="change_gender">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>

                        <div class="separator separator-dashed my-6"></div>

                        <div class="d-flex flex-wrap align-items-center">
                            <div id="change_birthday">
                                <div class="fs-6 fw-bold mb-1">Date of Birth</div>
                                <div class="fw-semibold text-gray-600" id="birthday_summary">--</div>
                            </div>
                                        
                            <div id="change_birthday_edit" class="flex-row-fluid d-none">
                                <form id="update_birthday_form" method="post" action="#">
                                    <?= $security->csrfInput('update_birthday_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="birthday" class="form-label fs-6 fw-bold mb-3">Enter New Date of Birth</label>
                                                <input class="form-control mb-3 mb-lg-0" id="birthday" name="birthday" type="text" readonly="readonly" <?php echo $disabled; ?>>
                                            </div>
                                        </div>
                                    </div>
                                        
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_birthday_submit" form="update_birthday_form" type="submit" class="btn btn-primary me-2 px-6">Update Date of Birth</button>
                                                                                <button id="update_birthday_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_birthday">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_birthday_button" class="ms-auto" data-toggle-section="change_birthday">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>

                        <div class="separator separator-dashed my-6"></div>

                        <div class="d-flex flex-wrap align-items-center mb-6">
                            <div id="change_place_of_birth">
                                <div class="fs-6 fw-bold mb-1">Place of Birth</div>
                                <div class="fw-semibold text-gray-600" id="place_of_birth_summary">--</div>
                            </div>
                                        
                            <div id="change_place_of_birth_edit" class="flex-row-fluid d-none">
                                <form id="update_place_of_birth_form" method="post" action="#">
                                    <?= $security->csrfInput('update_place_of_birth_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="place_of_birth" class="form-label fs-6 fw-bold mb-3">Enter New Place of Birth</label>
                                                <input type="text" class="form-control mb-3 mb-lg-0" id="place_of_birth" name="place_of_birth" maxlength="100" autocomplete="off" <?php echo $disabled; ?>>
                                            </div>
                                        </div>
                                    </div>
                                        
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_place_of_birth_submit" form="update_place_of_birth_form" type="submit" class="btn btn-primary me-2 px-6">Update Place of Birth</button>
                                                                                <button id="update_place_of_birth_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_place_of_birth">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_place_of_birth_button" class="ms-auto" data-toggle-section="change_place_of_birth">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>
                    </div>
                </div>

                <div class="card pt-4 mb-6 mb-xl-9">
                    <div class="card-header">
                        <div class="card-title">
                            <h3>Educational Background</h3>
                        </div>
                    </div>
                    
                    <div class="card-body">
                        <div class="row gx-9 gy-6" id="educational_background_summary">
                            <span class="text-center">
                                <span class="spinner-grow spinner-grow-md align-middle ms-0"></span>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="card pt-4 mb-6 mb-xl-9">
                    <div class="card-header">
                        <div class="card-title">
                            <h3>Emergency Contact</h3>
                        </div>
                    </div>
                    
                    <div class="card-body">
                        <div class="row gx-9 gy-6" id="emergency_contact_summary">
                            <span class="text-center">
                                <span class="spinner-grow spinner-grow-md align-middle ms-0"></span>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="card pt-4 mb-6 mb-xl-9">
                    <div class="card-header">
                        <div class="card-title">
                            <h3>License</h3>
                        </div>
                    </div>
                    
                    <div class="card-body">
                       <div class="row gx-9 gy-6" id="license_summary">
                            <span class="text-center">
                                <span class="spinner-grow spinner-grow-md align-middle ms-0"></span>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="tab-pane fade" id="work_information_tab" role="tabpanel">
                <div class="card pt-4 mb-6 mb-xl-9">
                    <div class="card-header">
                        <div class="card-title">
                            <h2>Work Information</h2>
                        </div>
                    </div>
                            
                    <div class="card-body pb-5">
                        <div class="d-flex flex-wrap align-items-center">
                            <div id="change_company">
                                <div class="fs-6 fw-bold mb-1">Company</div>
                                <div class="fw-semibold text-gray-600" id="company_summary">--</div>
                            </div>
                                                
                            <div id="change_company_edit" class="flex-row-fluid d-none">
                                <form id="update_company_form" method="post" action="#">
                                    <?= $security->csrfInput('update_company_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="company_id" class="form-label fs-6 fw-bold mb-3">Choose New Company</label>
                                                <select id="company_id" name="company_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                                            </div>
                                        </div>
                                    </div>
                                                
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_company_submit" form="update_company_form" type="submit" class="btn btn-primary me-2 px-6">Update Company</button>
                                                                                <button id="update_company_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_company">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_company_button" class="ms-auto" data-toggle-section="change_company">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>

                        <div class="separator separator-dashed my-6"></div>

                        <div class="d-flex flex-wrap align-items-center">
                            <div id="change_department">
                                <div class="fs-6 fw-bold mb-1">Department</div>
                                <div class="fw-semibold text-gray-600" id="department_summary">--</div>
                            </div>
                                                
                            <div id="change_department_edit" class="flex-row-fluid d-none">
                                <form id="update_department_form" method="post" action="#">
                                    <?= $security->csrfInput('update_department_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="department_id" class="form-label fs-6 fw-bold mb-3">Choose New Department</label>
                                                <select id="department_id" name="department_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                                            </div>
                                        </div>
                                    </div>
                                                
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_department_submit" form="update_department_form" type="submit" class="btn btn-primary me-2 px-6">Update Department</button>
                                                                                <button id="update_department_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_department">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_department_button" class="ms-auto" data-toggle-section="change_department">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>

                        <div class="separator separator-dashed my-6"></div>

                        <div class="d-flex flex-wrap align-items-center">
                            <div id="change_job_position">
                                <div class="fs-6 fw-bold mb-1">Job Position</div>
                                <div class="fw-semibold text-gray-600" id="job_position_summary">--</div>
                            </div>
                                                
                            <div id="change_job_position_edit" class="flex-row-fluid d-none">
                                <form id="update_job_position_form" method="post" action="#">
                                    <?= $security->csrfInput('update_job_position_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="job_position_id" class="form-label fs-6 fw-bold mb-3">Choose New Job Position</label>
                                                <select id="job_position_id" name="job_position_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                                            </div>
                                        </div>
                                    </div>
                                                
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_job_position_submit" form="update_job_position_form" type="submit" class="btn btn-primary me-2 px-6">Update Job Position</button>
                                                                                <button id="update_job_position_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_job_position">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_job_position_button" class="ms-auto" data-toggle-section="change_job_position">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>

                        <div class="separator separator-dashed my-6"></div>

                        <div class="d-flex flex-wrap align-items-center">
                            <div id="change_manager">
                                <div class="fs-6 fw-bold mb-1">Manager</div>
                                <div class="fw-semibold text-gray-600" id="manager_summary">--</div>
                            </div>
                                                
                            <div id="change_manager_edit" class="flex-row-fluid d-none">
                                <form id="update_manager_form" method="post" action="#">
                                    <?= $security->csrfInput('update_manager_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="manager_id" class="form-label fs-6 fw-bold mb-3">Choose New Manager</label>
                                                <select id="manager_id" name="manager_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                                            </div>
                                        </div>
                                    </div>
                                                
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_manager_submit" form="update_manager_form" type="submit" class="btn btn-primary me-2 px-6">Update Manager</button>
                                                                                <button id="update_manager_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_manager">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_manager_button" class="ms-auto" data-toggle-section="change_manager">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>

                        <div class="separator separator-dashed my-6"></div>

                        <div class="d-flex flex-wrap align-items-center">
                            <div id="change_time_off_approver">
                                <div class="fs-6 fw-bold mb-1">Time-Off Approver</div>
                                <div class="fw-semibold text-gray-600" id="time_off_approver_summary">--</div>
                            </div>
                                                
                            <div id="change_time_off_approver_edit" class="flex-row-fluid d-none">
                                <form id="update_time_off_approver_form" method="post" action="#">
                                    <?= $security->csrfInput('update_time_off_approver_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="time_off_approver_id" class="form-label fs-6 fw-bold mb-3">Choose New Time-Off Approver</label>
                                                <select id="time_off_approver_id" name="time_off_approver_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                                            </div>
                                        </div>
                                    </div>
                                                
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_time_off_approver_submit" form="update_time_off_approver_form" type="submit" class="btn btn-primary me-2 px-6">Update Time-Off Approver</button>
                                                                                <button id="update_time_off_approver_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_time_off_approver">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_time_off_approver_button" class="ms-auto" data-toggle-section="change_time_off_approver">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>

                        <div class="separator separator-dashed my-6"></div>

                        <div class="d-flex flex-wrap align-items-center">
                            <div id="change_employment_type">
                                <div class="fs-6 fw-bold mb-1">Employment Type</div>
                                <div class="fw-semibold text-gray-600" id="employment_type_summary">--</div>
                            </div>
                                                
                            <div id="change_employment_type_edit" class="flex-row-fluid d-none">
                                <form id="update_employment_type_form" method="post" action="#">
                                    <?= $security->csrfInput('update_employment_type_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="employment_type_id" class="form-label fs-6 fw-bold mb-3">Choose New Employment Type</label>
                                                <select id="employment_type_id" name="employment_type_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                                            </div>
                                        </div>
                                    </div>
                                                
                                    <?php 
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_employment_type_submit" form="update_employment_type_form" type="submit" class="btn btn-primary me-2 px-6">Update Employment Type</button>
                                                                                <button id="update_employment_type_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_employment_type">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_employment_type_button" class="ms-auto" data-toggle-section="change_employment_type">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>

                        <div class="separator separator-dashed my-6"></div>

                        <div class="d-flex flex-wrap align-items-center">
                            <div id="change_employment_location_type">
                                <div class="fs-6 fw-bold mb-1">Employment Location Type</div>
                                <div class="fw-semibold text-gray-600" id="employment_location_type_summary">--</div>
                            </div>
                                                
                            <div id="change_employment_location_type_edit" class="flex-row-fluid d-none">
                                <form id="update_employment_location_type_form" method="post" action="#">
                                    <?= $security->csrfInput('update_employment_location_type_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="employment_location_type_id" class="form-label fs-6 fw-bold mb-3">Choose New Employment Location Type</label>
                                                <select id="employment_location_type_id" name="employment_location_type_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                                            </div>
                                        </div>
                                    </div>
                                                
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_employment_location_type_submit" form="update_employment_location_type_form" type="submit" class="btn btn-primary me-2 px-6">Update Employment Location Type</button>
                                                                                <button id="update_employment_location_type_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_employment_location_type">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_employment_location_type_button" class="ms-auto" data-toggle-section="change_employment_location_type">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>

                        <div class="separator separator-dashed my-6"></div>

                        <div class="d-flex flex-wrap align-items-center">
                            <div id="change_work_location">
                                <div class="fs-6 fw-bold mb-1">Work Location</div>
                                <div class="fw-semibold text-gray-600" id="work_location_summary">--</div>
                            </div>
                                                
                            <div id="change_work_location_edit" class="flex-row-fluid d-none">
                                <form id="update_work_location_form" method="post" action="#">
                                    <?= $security->csrfInput('update_work_location_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="work_location_id" class="form-label fs-6 fw-bold mb-3">Choose New Work Location</label>
                                                <select id="work_location_id" name="work_location_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                                            </div>
                                        </div>
                                    </div>
                                                
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_work_location_submit" form="update_work_location_form" type="submit" class="btn btn-primary me-2 px-6">Update Work Location</button>
                                                                                <button id="update_work_location_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_work_location">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_work_location_button" class="ms-auto" data-toggle-section="change_work_location">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>

                        <div class="separator separator-dashed my-6"></div>

                        <div class="d-flex flex-wrap align-items-center mb-6">
                            <div id="change_on_board_date">
                                <div class="fs-6 fw-bold mb-1">On-Board Date</div>
                                <div class="fw-semibold text-gray-600" id="on_board_date_summary">--</div>
                            </div>
                                                
                            <div id="change_on_board_date_edit" class="flex-row-fluid d-none">
                                <form id="update_on_board_date_form" method="post" action="#">
                                    <?= $security->csrfInput('update_on_board_date_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="on_board_date" class="form-label fs-6 fw-bold mb-3">Choose New On-Board Date</label>
                                                <input class="form-control mb-3 mb-lg-0 datepicker" id="on_board_date" name="on_board_date" type="text" readonly="readonly" <?php echo $disabled; ?>>
                                            </div>
                                        </div>
                                    </div>
                                                
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_on_board_date_submit" form="update_on_board_date_form" type="submit" class="btn btn-primary me-2 px-6">Update On-Board Date</button>
                                                                                <button id="update_on_board_date_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_on_board_date">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_on_board_date_button" class="ms-auto" data-toggle-section="change_on_board_date">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>
                    </div>
                </div>

                <div class="card pt-4 mb-6 mb-xl-9">
                    <div class="card-header">
                        <div class="card-title">
                            <h2>Work Contact</h2>
                        </div>
                    </div>
                            
                    <div class="card-body pb-5">
                        <div class="d-flex flex-wrap align-items-center">
                            <div id="change_work_email">
                                <div class="fs-6 fw-bold mb-1">Work Email</div>
                                <div class="fw-semibold text-gray-600" id="work_email_summary">--</div>
                            </div>
                                        
                            <div id="change_work_email_edit" class="flex-row-fluid d-none">
                                <form id="update_work_email_form" method="post" action="#">
                                    <?= $security->csrfInput('update_work_email_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="work_email" class="form-label fs-6 fw-bold mb-3">Enter New Work Email</label>
                                                <input type="email" class="form-control" maxlength="300" id="work_email" name="work_email" autocomplete="off" <?php echo $disabled; ?>>
                                            </div>
                                        </div>
                                    </div>
                                        
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_work_email_submit" form="update_work_email_form" type="submit" class="btn btn-primary me-2 px-6">Update Work Email</button>
                                                                                <button id="update_work_email_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_work_email">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_work_email_button" class="ms-auto" data-toggle-section="change_work_email">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>

                        <div class="separator separator-dashed my-6"></div>

                        <div class="d-flex flex-wrap align-items-center">
                            <div id="change_work_phone">
                                <div class="fs-6 fw-bold mb-1">Work Phone</div>
                                <div class="fw-semibold text-gray-600" id="work_phone_summary">--</div>
                            </div>
                                        
                            <div id="change_work_phone_edit" class="flex-row-fluid d-none">
                                <form id="update_work_phone_form" method="post" action="#">
                                    <?= $security->csrfInput('update_work_phone_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="work_phone" class="form-label fs-6 fw-bold mb-3">Enter New Work Phone</label>
                                                <input type="text" class="form-control" maxlength="300" id="work_phone" name="work_phone" autocomplete="off" <?php echo $disabled; ?>>
                                            </div>
                                        </div>
                                    </div>
                                        
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_work_phone_submit" form="update_work_phone_form" type="submit" class="btn btn-primary me-2 px-6">Update Work Phone</button>
                                                                                <button id="update_work_phone_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_work_phone">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_work_phone_button" class="ms-auto" data-toggle-section="change_work_phone">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>

                        <div class="separator separator-dashed my-6"></div>

                        <div class="d-flex flex-wrap align-items-center mb-6">
                            <div id="change_work_telephone">
                                <div class="fs-6 fw-bold mb-1">Work Telephone</div>
                                <div class="fw-semibold text-gray-600" id="work_telephone_summary">--</div>
                            </div>
                                        
                            <div id="change_work_telephone_edit" class="flex-row-fluid d-none">
                                <form id="update_work_telephone_form" method="post" action="#">
                                    <?= $security->csrfInput('update_work_telephone_form'); ?>
                                    <div class="row mb-6">
                                        <div class="col-lg-12 mb-4 mb-lg-0">
                                            <div class="fv-row mb-0 fv-plugins-icon-container">
                                                <label for="work_telephone" class="form-label fs-6 fw-bold mb-3">Enter New Work Telephone</label>
                                                <input type="text" class="form-control" maxlength="300" id="work_telephone" name="work_telephone" autocomplete="off" <?php echo $disabled; ?>>
                                            </div>
                                        </div>
                                    </div>
                                        
                                    <?php
                                        echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                <button id="update_work_telephone_submit" form="update_work_telephone_form" type="submit" class="btn btn-primary me-2 px-6">Update Work Telephone</button>
                                                                                <button id="update_work_telephone_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_work_telephone">Cancel</button>
                                                                            </div>' : '';
                                    ?>
                                </form>
                            </div>

                            <?php
                                echo ($permissions['write'] > 0) ? '<div id="change_work_telephone_button" class="ms-auto" data-toggle-section="change_work_telephone">
                                                                        <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                    </div>' : '';
                            ?>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="tab-pane fade" id="work_experience_tab" role="tabpanel">
                <div class="card pt-4 mb-6 mb-xl-9">
                    <div class="card-header">
                        <div class="card-title">
                            <h3>Work Experience</h3>
                        </div>
                    </div>
                    
                    <div class="card-body">
                        <div class="row gx-9 gy-6" id="work_experience_summary">
                            <span class="text-center">
                                <span class="spinner-grow spinner-grow-md align-middle ms-0"></span>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="tab-pane fade" id="employee_document_tab" role="tabpanel">
                <div class="card">
                    <div class="card-header border-0 pt-6">
                        <div class="card-title">
                            <?php require './app/Views/Partials/datatable-search.php'; ?>
                        </div>
                        <div class="card-toolbar">
                            <div class="d-flex justify-content-end" data-kt-customer-table-toolbar="base">
                                <?php
                                    echo ($permissions['write'] > 0) ? '<button type="button" class="btn btn-light-primary btn-sm" id="add-document" data-bs-toggle="modal" data-bs-target="#employee_document_modal">
                                                                            Add Document
                                                                        </button>' : '';
                                ?>
                            </div>
                        </div>
                    </div>
                    <div class="card-body pt-9">
                        <table class="table align-middle table-row-dashed fs-6 gy-5 gs-7" id="employee-document-table">
                            <thead>
                                <tr class="fw-semibold fs-6 text-gray-800">
                                    <th>Document</th>
                                    <th>Size</th>
                                    <th>Upload Date</th>
                                    <th>Last Modified</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody class="fw-semibold text-gray-600"></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="update_personal_details_modal" class="modal fade" tabindex="-1" aria-labelledby="update_personal_details_modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Personal Details</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="personal_details_form" method="post" action="#">
                    <?= $security->csrfInput('personal_details_form'); ?>
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="first_name">First Name</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="first_name" name="first_name" maxlength="300" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="middle_name">Middle Name</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="middle_name" name="middle_name" maxlength="300" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="last_name">Last Name</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="last_name" name="last_name" maxlength="300" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="suffix">Suffix</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="suffix" name="suffix" maxlength="10" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6">Private Address</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <textarea class="form-control mb-3 mb-lg-0" id="private_address" name="private_address" maxlength="500" autocomplete="off"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <div class="col-lg-4"></div>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="private_address_city_id" name="private_address_city_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="nickname">Nickname</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="nickname" name="nickname" maxlength="100" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="civil_status_id">Civil Status</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="civil_status_id" name="civil_status_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="dependents">Number of Dependents</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="number" class="form-control" id="dependents" name="dependents" min="0" step="1">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="religion_id">Religion</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="religion_id" name="religion_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="blood_type_id">Blood Type</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="blood_type_id" name="blood_type_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="home_work_distance">Home-Work Distance</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="home_work_distance" name="home_work_distance" min="0" step="0.01">
                                        <span class="input-group-text">km</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="height">Height</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="height" name="height" min="0" step="0.01">
                                        <span class="input-group-text">cm</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="weight">Weight</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="weight" name="weight" min="0" step="0.01">
                                        <span class="input-group-text">kg</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="personal_details_form" class="btn btn-primary" id="submit-personal-details">Save</button>
            </div>
        </div>
    </div>
</div>

<div id="employee_language_modal" class="modal fade" tabindex="-1" aria-labelledby="employee_language_modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Employee Language</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="employee_language_form" method="post" action="#">
                    <?= $security->csrfInput('employee_language_form'); ?>
                    <input type="hidden" id="employee_language_id" name="employee_language_id">
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="language_id">Language</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="language_id" name="language_id" class="form-select" data-dropdown-parent="#employee_language_modal" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="language_proficiency_id">Language Proficiency</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="language_proficiency_id" name="language_proficiency_id" data-dropdown-parent="#employee_language_modal" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="employee_language_form" class="btn btn-primary" id="submit_employee_language">Save</button>
            </div>
        </div>
    </div>
</div>

<div id="employee_education_modal" class="modal fade" tabindex="-1" aria-labelledby="employee_education_modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Employee Educational Background</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="employee_education_form" method="post" action="#">
                    <?= $security->csrfInput('employee_education_form'); ?>
                    <input type="hidden" id="employee_education_id" name="employee_education_id">
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="school">School</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="school" name="school" maxlength="100" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="degree">Degree</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="degree" name="degree" maxlength="100" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="field_of_study">Field of Study</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="field_of_study" name="field_of_study" maxlength="100" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="start_month">Start Date</label>
                        <div class="col-lg-4">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="start_month" name="start_month" class="form-select" data-dropdown-parent="#employee_education_modal" data-control="select2" data-allow-clear="false">
                                        <option value="">--</option>
                                        <?php echo $systemHelper->generateMonthOptions(); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="start_year" name="start_year" class="form-select" data-dropdown-parent="#employee_education_modal" data-control="select2" data-allow-clear="false">
                                        <option value="">--</option>
                                        <?php echo $systemHelper->generateYearOptions(date('Y'), date('Y', strtotime('-100 years'))); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="end_month">End Date (or expected)</label>
                        <div class="col-lg-4">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="end_month" name="end_month" class="form-select" data-dropdown-parent="#employee_education_modal" data-control="select2" data-allow-clear="false">
                                        <option value="">--</option>
                                        <?php echo $systemHelper->generateMonthOptions(); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="end_year" name="end_year" class="form-select" data-dropdown-parent="#employee_education_modal" data-control="select2" data-allow-clear="false">
                                        <option value="">--</option>
                                       <?php echo $systemHelper->generateYearOptions(date('Y'), date('Y', strtotime('-100 years'))); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="activities_societies">Activities and Societies</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <textarea class="form-control" id="activities_societies" name="activities_societies" maxlength="5000"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="education_description">Description</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <textarea class="form-control" id="education_description" name="education_description" maxlength="5000"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="employee_education_form" class="btn btn-primary" id="submit_employee_education">Save</button>
            </div>
        </div>
    </div>
</div>

<div id="employee_emergency_contact_modal" class="modal fade" tabindex="-1" aria-labelledby="employee_emergency_contact_modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Employee Emergency Contact</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="employee_emergency_contact_form" method="post" action="#">
                    <?= $security->csrfInput('employee_emergency_contact_form'); ?>
                    <input type="hidden" id="employee_emergency_contact_id" name="employee_emergency_contact_id">
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="emergency_contact_name">Emergency Contact Name</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="emergency_contact_name" name="emergency_contact_name" maxlength="500" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="relationship_id">Relationship</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="relationship_id" name="relationship_id" data-dropdown-parent="#employee_emergency_contact_modal" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="emergency_contact_telephone">Telephone</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0 contact-group" id="emergency_contact_telephone" name="emergency_contact_telephone" maxlength="50" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="emergency_contact_mobile">Mobile</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0 contact-group" id="emergency_contact_mobile" name="emergency_contact_mobile" maxlength="50" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="emergency_contact_email">Email</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0 contact-group" id="emergency_contact_email" name="emergency_contact_email" maxlength="200" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="employee_emergency_contact_form" class="btn btn-primary" id="submit_employee_emergency_contact">Save</button>
            </div>
        </div>
    </div>
</div>

<div id="employee_license_modal" class="modal fade" tabindex="-1" aria-labelledby="employee_license_modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Employee License</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="employee_license_form" method="post" action="#">
                    <?= $security->csrfInput('employee_license_form'); ?>
                    <input type="hidden" id="employee_license_id" name="employee_license_id">
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="licensed_profession">Licensed Profession</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="licensed_profession" name="licensed_profession" maxlength="200" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="licensing_body">Licensing Body</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="licensing_body" name="licensing_body" maxlength="500" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="license_number">License Number</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="license_number" name="license_number" maxlength="500" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="issue_date">Issuance Date</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input class="form-control mb-3 mb-lg-0" id="issue_date" name="issue_date" type="text">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="expiration_date">Expiration Date</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input class="form-control mb-3 mb-lg-0" id="expiration_date" name="expiration_date" type="text">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="employee_license_form" class="btn btn-primary" id="submit_employee_license">Save</button>
            </div>
        </div>
    </div>
</div>

<div id="employee_experience_modal" class="modal fade" tabindex="-1" aria-labelledby="employee_experience_modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Employee Work Experience</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="employee_experience_form" method="post" action="#">
                    <?= $security->csrfInput('employee_experience_form'); ?>
                    <input type="hidden" id="employee_experience_id" name="employee_experience_id">
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="job_title">Job Title</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="job_title" name="job_title" maxlength="100" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="company_name">Company Name</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="company_name" name="company_name" maxlength="100" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="location">Location</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="location" name="location" maxlength="100" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="employee_experience_employment_type_id">Employment Type</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="employee_experience_employment_type_id" name="employee_experience_employment_type_id" data-dropdown-parent="#employee_experience_modal" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="start_month">Start Date</label>
                        <div class="col-lg-4">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="employee_experience_start_month" name="employee_experience_start_month" class="form-select" data-dropdown-parent="#employee_experience_modal" data-control="select2" data-allow-clear="false">
                                        <option value="">--</option>
                                        <?php echo $systemHelper->generateMonthOptions(); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="employee_experience_start_year" name="employee_experience_start_year" class="form-select" data-dropdown-parent="#employee_experience_modal" data-control="select2" data-allow-clear="false">
                                        <option value="">--</option>
                                        <?php echo $systemHelper->generateYearOptions(date('Y'), date('Y', strtotime('-100 years'))); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="end_month">End Date (or expected)</label>
                        <div class="col-lg-4">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="employee_experience_end_month" name="employee_experience_end_month" class="form-select" data-dropdown-parent="#employee_experience_modal" data-control="select2" data-allow-clear="false">
                                        <option value="">--</option>
                                        <?php echo $systemHelper->generateMonthOptions(); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="employee_experience_end_year" name="employee_experience_end_year" class="form-select" data-dropdown-parent="#employee_experience_modal" data-control="select2" data-allow-clear="false">
                                        <option value="">--</option>
                                       <?php echo $systemHelper->generateYearOptions(date('Y'), date('Y', strtotime('-100 years'))); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="job_description">Job Description</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <textarea class="form-control" id="job_description" name="job_description" maxlength="5000"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="employee_experience_form" class="btn btn-primary" id="submit_employee_experience">Save</button>
            </div>
        </div>
    </div>
</div>

<div id="employee_document_modal" class="modal fade" tabindex="-1" aria-labelledby="employee_document_modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Employee Document</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="employee_document_form" method="post" action="#">
                    <?= $security->csrfInput('employee_document_form'); ?>
                    <input type="hidden" id="employee_document_id" name="employee_document_id">
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="document_name">Document Name</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="document_name" name="document_name" maxlength="200" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="document_file">Document File</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="file" class="form-control mb-3 mb-lg-0" id="document_file" name="document_file" >
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="employee_document_type_id">Document Type</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="employee_document_type_id" name="employee_document_type_id" data-dropdown-parent="#employee_document_modal" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="employee_document_form" class="btn btn-primary" id="submit_employee_document">Save</button>
            </div>
        </div>
    </div>
</div>


<?php require_once './app/Views/Partials/log-notes-modal.php'; ?>