<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">Scrap Reason Details</h5>
    </div>
    <div class="card-body">
        <form id="scrap_reason_form" method="post" action="#">
            <?= $security->csrfInput('scrap_reason_form'); ?>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold required form-label mt-3" for="scrap_reason_name">
                    Display Name
                </label>

                <input type="text" class="form-control" id="scrap_reason_name" name="scrap_reason_name" maxlength="100" autocomplete="off">
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="scrap_reason_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>