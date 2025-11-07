<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">Unit Details</h5>
    </div>
    <div class="card-body">
        <form id="unit_form" method="post" action="#">
            <?= $security->csrfInput('unit_form'); ?>
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="unit_name">
                            Display Name
                        </label>

                        <input type="text" class="form-control" id="unit_name" name="unit_name" maxlength="200" autocomplete="off">
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="unit_abbreviation">
                            Abbreviation
                        </label>

                        <input type="text" class="form-control" id="unit_abbreviation" name="unit_abbreviation" maxlength="20" autocomplete="off">
                    </div>
                </div>
            </div>
            
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="unit_type_id">
                            Unit Type
                        </label>

                        <select id="unit_type_id" name="unit_type_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="unit_type_id">
                            Ratio to Base
                        </label>

                        <input type="number" id="ratio_to_base" name="ratio_to_base" class="form-control mb-2" min="0.000001" step="0.000001"/>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="unit_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>