<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">User Account Details</h5>
    </div>
    <div class="card-body">
        <form id="user_account_form" method="post" action="#">
            <?= $security->csrfInput('user_account_form'); ?>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="file_as">
                            Full Name  
                        </label>

                        <input type="text" class="form-control maxlength" id="file_as" name="file_as" maxlength="300" autocomplete="off">
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="email">
                            Email
                        </label>

                        <input type="email" class="form-control maxlength" id="email" name="email" maxlength="255" autocomplete="off">
                    </div>
                </div>
            </div>
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="phone">
                            <span>Phone</span>
                        </label>

                        <input type="text" class="form-control maxlength" id="phone" name="phone" maxlength="50" autocomplete="off">
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="password">
                            Password
                        </label>

                        <div class="position-relative mb-3">
                            <input class="form-control" type="password" id="password" name="password" autocomplete="off" />

                            <span class="btn btn-sm btn-icon position-absolute translate-middle top-50 end-0 me-n2 password-addon">
                                <i class="ki-outline ki-eye-slash fs-2 p-0"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="user_account_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>