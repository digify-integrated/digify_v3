<div class="card mb-10">
    <div class="card-header border-0">
        <div class="card-title m-0">
            <h3 class="fw-bold m-0">Charge Type Details</h3>
        </div>
        <?php
            if ($permissions['delete'] > 0) {
                $action = '<a href="#" class="btn btn-light-primary btn-flex btn-center btn-active-light-primary show menu-dropdown align-self-center" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
                                        Actions
                                        <i class="ki-outline ki-down fs-5 ms-1"></i>
                                    </a>
                                    <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true" style="z-index: 107; position: fixed; inset: 0px 0px auto auto; margin: 0px; transform: translate(-60px, 539px);" data-popper-placement="bottom-end">';
                    
                if ($permissions['delete'] > 0) {
                    $action .= '<div class="menu-item px-3">
                                    <a href="javascript:void(0);" class="menu-link px-3" id="delete-charge-type">
                                        Delete
                                    </a>
                                </div>';
                }
                        
                $action .= '</div>';
                        
                echo $action;
            }
        ?>
    </div>
    <div class="card-body">
        <form id="charge_type_form" method="post" action="#">
            <?= $security->csrfInput('charge_type_form'); ?>
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="charge_type_name">
                            Display Name
                        </label>

                        <input type="text" class="form-control" id="charge_type_name" name="charge_type_name" maxlength="100" autocomplete="off" <?php echo $disabled; ?>>
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="value_type">
                            Value Type
                        </label>

                        <select id="value_type" name="value_type" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>>
                            <option value="">--</option>
                            <option value="Percentage">Percentage</option>
                            <option value="Fixed Amount">Fixed Amount</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="charge_value">
                            Charge Value
                        </label>

                        <input type="number" class="form-control" id="charge_value" name="charge_value" min="0" step="0.01" <?php echo $disabled; ?>>
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="is_variable">
                            Is Variable? <i class="ki-outline ki-information-2" data-bs-toggle="tooltip" title="Allows the cashier to enter the charge amount during the transaction.

                            Yes → Flexible amount (e.g. corkage fee)
                            No → Uses a fixed value set by admin"></i>
                        </label>

                        <select id="is_variable" name="is_variable" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>>
                            <option value="">--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="application_order">
                            Application Order <i class="ki-outline ki-information-2" data-bs-toggle="tooltip" title="Controls when the charge is added to the total.

                            Before Tax → Included in tax computation (rare)
                            After Tax → Added after tax (standard use)"></i>
                        </label>

                        <select id="application_order" name="application_order" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>>
                            <option value="">--</option>
                            <option value="Before Tax">Before Tax</option>
                            <option value="After Tax">After Tax</option>
                        </select>
                    </div>
                </div>
                
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="tax_type">
                            Tax Type <i class="ki-outline ki-information-2" data-bs-toggle="tooltip" title="Determines if the charge is subject to VAT.

                            Vatable → Included in VAT computation
                            Non Vatable → Not subject to VAT (e.g. service charge)"></i>
                        </label>

                        <select id="tax_type" name="tax_type" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>>
                            <option value="">--</option>
                            <option value="Vatable">Vatable</option>
                            <option value="Non Vatable">Non Vatable</option>
                        </select>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <?php
        echo ($permissions['write'] > 0) ? ' <div class="card-footer d-flex justify-content-end py-6 px-9">
                                                <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
                                                <button type="submit" form="charge_type_form" class="btn btn-primary" id="submit-data">Save</button>
                                            </div>' : '';
    ?>
</div>

<?php require_once './app/Views/Partials/log-notes-modal.php'; ?>