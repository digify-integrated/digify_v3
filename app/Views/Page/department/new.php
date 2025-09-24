<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">Department Details</h5>
    </div>
    <div class="card-body">
        <form id="department_form" method="post" action="#">
            <?= $security->csrfInput('department_form'); ?>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold form-label mt-3" for="department_name">
                    <span class="required">Display Name</span>
                </label>

                <input type="text" class="form-control" id="department_name" name="department_name" maxlength="100" autocomplete="off">
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="parent_department_id">
                            Parent Department
                        </label>

                        <select id="parent_department_id" name="parent_department_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                    </div>
                </div>
                
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="manager_id">
                            Manager
                        </label>

                        <select id="manager_id" name="manager_id" class="form-select" data-control="select2" data-allow-clear="false">
                            <option value="">--</option>
                        </select>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="department_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>