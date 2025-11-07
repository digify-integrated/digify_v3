<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">Notification Setting Details</h5>
    </div>
    <div class="card-body">
        <form id="notification_setting_form" method="post" action="#">
            <?= $security->csrfInput('notification_setting_form'); ?>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold required form-label mt-3" for="notification_setting_name">
                    Display Name
                </label>

                <input type="text" class="form-control" id="notification_setting_name" name="notification_setting_name" maxlength="100" autocomplete="off">
            </div>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold required form-label mt-3" for="notification_setting_description">
                    Description
                </label>

                <input type="text" class="form-control" id="notification_setting_description" name="notification_setting_description" maxlength="200" autocomplete="off">
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="notification_setting_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>