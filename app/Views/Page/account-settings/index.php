<div class="d-flex flex-column flex-lg-row">
    <div class="flex-column flex-lg-row-auto w-lg-250px w-xl-350px mb-10">
        <div class="card mb-5 mb-xl-8">
            <div class="card-body">
                <div class="d-flex flex-center flex-column py-5">
                    <div class="image-input image-input-outline mb-7" data-kt-image-input="true">
                        <div class="image-input-wrapper w-125px h-125px" id="profile_picture_image" style="background-image: url(./assets/images/default/default-avatar.jpg)"></div>

                        <?php
                            echo ($permissions['write'] > 0) ? '<label class="btn btn-icon btn-circle btn-active-color-primary w-25px h-25px bg-body shadow" data-kt-image-input-action="change" data-bs-toggle="tooltip" aria-label="Change image" data-bs-original-title="Change image" data-kt-initialized="1">
                                                                    <i class="ki-outline ki-pencil fs-7"></i>
                                                                    <input type="file" id="profile_picture" name="profile_picture" accept=".png, .jpg, .jpeg">
                                                                </label>' : '';
                        ?>
                    </div>
                    <div class="fs-3 text-gray-800 fw-bold mb-3" id="full_name_side_summary"></div>
                    <div class="mb-2">
                        <div class="text-gray-600" id="email_side_summary"></div>
                    </div>
                </div>
                
                <div class="d-flex flex-stack fs-4 py-3">
                    <div class="fw-bold">
                        Details
                    </div>

                    <div id="status_side_summary"></div>
                </div>

                <div class="separator separator-dashed my-3"></div>

                <div>
                    <div class="pb-5 fs-6">
                        <div class="fw-bold mt-5">Phone</div>
                        <div class="text-gray-600" id="phone_side_summary"></div>

                        <div class="fw-bold mt-5">Last Password Change</div>
                        <div class="text-gray-600" id="last_password_date_side_summary"></div>

                        <div class="fw-bold mt-5">Last Password Reset Request</div>
                        <div class="text-gray-600" id="last_password_reset_request_side_summary"></div>

                        <div class="fw-bold mt-5">Last Login</div>
                        <div class="text-gray-600" id="last_connection_date_side_summary"></div>

                        <div class="fw-bold mt-5">Last Failed Attempt</div>
                        <div class="text-gray-600" id="last_failed_connection_date_side_summary"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="flex-lg-row-fluid ms-lg-15">
        <ul class="nav nav-custom nav-tabs nav-line-tabs nav-line-tabs-2x border-0 fs-4 fw-semibold mb-8" role="tablist">
            <li class="nav-item" role="presentation">
                <a class="nav-link text-active-primary pb-4 active" data-bs-toggle="tab" href="#details_tab" aria-selected="true" role="tab">Details</a>
            </li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane fade show active" id="details_tab" role="tabpanel">
                <div class="card mb-5 mb-xl-10">
                    <div class="card-header border-0" role="button">
                        <div class="card-title m-0">
                            <h3 class="fw-bold m-0">User Account Details</h3>
                        </div>
                    </div>
                            
                    <div>
                        <div class="card-body border-top p-9">
                            <div class="d-flex flex-wrap align-items-center">
                                <div id="change_full_name">
                                    <div class="fs-6 fw-bold mb-1">Full Name</div>
                                    <div class="fw-semibold text-gray-600" id="full_name_summary"></div>
                                </div>
                                        
                                <div id="change_full_name_edit" class="flex-row-fluid d-none">
                                    <form id="update_full_name_form">
                                        <?= $security->csrfInput('update_full_name_form'); ?>
                                        <div class="row mb-6">
                                            <div class="col-lg-12 mb-4 mb-lg-0">
                                                <div class="fv-row mb-0 fv-plugins-icon-container">
                                                    <label for="full_name" class="form-label fs-6 fw-bold mb-3">Enter New Full Name</label>
                                                    <input type="text" class="form-control" maxlength="300" id="full_name" name="full_name" autocomplete="off" <?php echo $disabled; ?>>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <?php
                                            echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                    <button id="update_full_name_submit" form="update_full_name_form" type="submit" class="btn btn-primary me-2 px-6">Update Full Name</button>
                                                                                    <button id="update_full_name_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary  px-6" data-toggle-section="change_full_name">Cancel</button>
                                                                                </div>' : '';
                                        ?>
                                    </form>
                                </div>

                                <?php
                                    echo ($permissions['write'] > 0) ? '<div id="change_full_name_button" class="ms-auto" data-toggle-section="change_full_name">
                                                                            <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                        </div>' : '';
                                ?>
                            </div>

                            <div class="separator separator-dashed my-6"></div>

                            <div class="d-flex flex-wrap align-items-center">
                                <div id="change_email">
                                    <div class="fs-6 fw-bold mb-1">Email Address</div>
                                    <div class="fw-semibold text-gray-600" id="email_summary"></div>
                                </div>
                                        
                                <div id="change_email_edit" class="flex-row-fluid d-none">
                                    <form id="update_email_form">
                                        <?= $security->csrfInput('update_email_form'); ?>
                                        <div class="row mb-6">
                                            <div class="col-lg-12 mb-4 mb-lg-0">
                                                <div class="fv-row mb-0 fv-plugins-icon-container">
                                                    <label for="email" class="form-label fs-6 fw-bold mb-3">Enter New Email Address</label>
                                                    <input type="email" class="form-control" id="email" name="email" autocomplete="off" <?php echo $disabled; ?>>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <?php
                                            echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                    <button id="update_email_submit" form="update_email_form" type="submit" class="btn btn-primary me-2 px-6">Update Email</button>
                                                                                    <button id="update_email_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary px-6" data-toggle-section="change_email">Cancel</button>
                                                                                </div>' : '';
                                        ?>
                                    </form>
                                </div>

                                <?php
                                    echo ($permissions['write'] > 0) ? '<div id="change_email_button" class="ms-auto" data-toggle-section="change_email">
                                                                            <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                        </div>' : '';
                                ?>
                            </div>

                            <div class="separator separator-dashed my-6"></div>

                            <div class="d-flex flex-wrap align-items-center">
                                <div id="change_phone">
                                    <div class="fs-6 fw-bold mb-1">Phone</div>
                                    <div class="fw-semibold text-gray-600" id="phone_summary"></div>
                                </div>
                                        
                                <div id="change_phone_edit" class="flex-row-fluid d-none">
                                    <form id="update_phone_form">
                                        <?= $security->csrfInput('update_phone_form'); ?>
                                        <div class="row mb-6">
                                            <div class="col-lg-12 mb-4 mb-lg-0">
                                                <div class="fv-row mb-0 fv-plugins-icon-container">
                                                    <label for="phone" class="form-label fs-6 fw-bold mb-3">Enter New Phone</label>
                                                    <input type="text" class="form-control" id="phone" name="phone" autocomplete="off" <?php echo $disabled; ?>>
                                                </div>
                                            </div>
                                        </div>

                                        <?php
                                            echo ($permissions['write'] > 0) ? '<div class="d-flex">
                                                                                    <button id="update_phone_submit" form="update_phone_form" type="submit" class="btn btn-primary me-2 px-6">Update Phone</button>
                                                                                    <button id="update_phone_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary px-6" data-toggle-section="change_phone">Cancel</button>
                                                                                </div>' : '';
                                        ?>
                                    </form>
                                </div>
                                        
                                <?php
                                    echo ($permissions['write'] > 0) ? '<div id="change_phone_button" class="ms-auto" data-toggle-section="change_phone">
                                                                            <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                        </div>' : '';
                                ?>
                            </div>
                                    
                            <div class="separator separator-dashed my-6"></div>
                                    
                            <div class="d-flex flex-wrap align-items-center mb-0">
                                <div id="change_password" class="">
                                    <div class="fs-6 fw-bold mb-1">Password</div>
                                    <div class="fw-semibold text-gray-600">************</div>
                                </div>
                                        
                                <div id="change_password_edit" class="flex-row-fluid d-none">
                                    <form id="update_password_form">
                                        <?= $security->csrfInput('update_password_form'); ?>
                                        <div class="row mb-1">
                                            <div class="col-lg-6">
                                                <div class="fv-row mb-0 fv-plugins-icon-container">
                                                    <label for="new_password" class="form-label fs-6 fw-bold mb-3">New Password</label>
                                                    <div class="input-group">
                                                        <input type="password" class="form-control" name="new_password" id="new_password" <?php echo $disabled; ?>>
                                                        <button class="btn btn-light bg-transparent password-addon" type="button">
                                                            <i class="ki-outline ki-eye-slash fs-2 p-0"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="fv-row mb-0 fv-plugins-icon-container">
                                                    <label for="confirm_password" class="form-label fs-6 fw-bold mb-3">Confirm Password</label>
                                                    <div class="input-group">
                                                        <input type="password" class="form-control" name="confirm_password" id="confirm_password" <?php echo $disabled; ?>>
                                                        <button class="btn btn-light bg-transparent password-addon" type="button">
                                                            <i class="ki-outline ki-eye-slash fs-2 p-0"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <?php
                                            echo ($permissions['write'] > 0) ? '<div class="d-flex mt-5">
                                                                                    <button id="update_password_submit" form="update_password_form" type="submit" class="btn btn-primary me-2 px-6">Update Password</button>
                                                                                    <button id="update_password_cancel" type="button" class="btn btn-color-gray-500 btn-active-light-primary px-6" data-toggle-section="change_password">Cancel</button>
                                                                                </div>' : '';
                                        ?>
                                    </form>
                                </div>
                                        
                                <?php
                                    echo ($permissions['write'] > 0) ? '<div id="change_password_button" class="ms-auto" data-toggle-section="change_password">
                                                                            <button class="btn btn-icon btn-light btn-active-light-primary"><i class="ki-outline ki-pencil fs-3"></i></button>
                                                                        </div>' : '';
                                ?>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>