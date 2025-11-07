<?php
    use App\Models\Tax;

    $tax = new Tax();

    $archiveTax    = $authentication->checkUserSystemActionPermission($userID, 15);
    $unarchiveTax  = $authentication->checkUserSystemActionPermission($userID, 16);

    $taxDetails    = $tax->fetchTax($detailID);
    $taxStatus     = $taxDetails['tax_status'] ?? 'Active';
?>
<div class="card card-flush">
    <div class="card-header border-0">
        <div class="card-title m-0">
            <h3 class="fw-bold m-0">Tax Details</h3>
        </div>
        <?php
            if ($permissions['delete'] > 0 || ($archiveTax['total'] > 0 && $taxStatus === 'Active') || ($unarchiveTax['total'] > 0 && $taxStatus === 'Archived')) {
                $action = '<a href="#" class="btn btn-light-primary btn-flex btn-center btn-active-light-primary show menu-dropdown align-self-center" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
                                Actions
                                <i class="ki-outline ki-down fs-5 ms-1"></i>
                            </a>
                            <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true" style="z-index: 107; position: fixed; inset: 0px 0px auto auto; margin: 0px; transform: translate(-60px, 539px);" data-popper-placement="bottom-end">';
                    

                if($archiveTax['total'] > 0 && $taxStatus === 'Active'){
                    $action .= ' <div class="menu-item px-3">
                                    <a href="javascript:void(0);" class="menu-link px-3" id="archive-tax">
                                        Archive
                                    </a>
                                </div>';
                }
                            
                if($unarchiveTax['total'] > 0 && $taxStatus === 'Archived'){
                    $action .= ' <div class="menu-item px-3">
                                    <a href="javascript:void(0);" class="menu-link px-3" id="unarchive-tax">
                                        Unarchive
                                    </a>
                                </div>';
                }

                if ($permissions['delete'] > 0) {
                    $action .= '<div class="menu-item px-3">
                                    <a href="javascript:void(0);" class="menu-link px-3" id="delete-tax">
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
        <form id="tax_form" class="form" method="post" action="#">
            <?= $security->csrfInput('tax_form'); ?>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold required form-label mt-3" for="tax_name">
                    Display Name
                </label>

                <input type="text" class="form-control" id="tax_name" name="tax_name" maxlength="100" autocomplete="off" <?php echo $disabled; ?>>
            </div>
            
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="tax_computation">
                            Tax Computation
                        </label>

                        <select id="tax_computation" name="tax_computation" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>>
                            <option value="">--</option>
                            <option value="Fixed">Fixed</option>
                            <option value="Percentage">Percentage</option>
                        </select>
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="tax_rate">
                            Tax Rate
                        </label>

                        <input type="number" class="form-control" id="tax_rate" name="tax_rate" min="0" step="0.01" <?php echo $disabled; ?>>
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="tax_type">
                            Tax Type
                        </label>

                        <select id="tax_type" name="tax_type" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>>
                            <option value="">--</option>
                            <option value="None">None</option>
                            <option value="Purchases">Purchases</option>
                            <option value="Sales">Sales</option>
                        </select>
                    </div>
                </div>
                
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="tax_scope">
                            Tax Scope
                        </label>

                        <select id="tax_scope" name="tax_scope" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>>
                            <option value="">--</option>
                            <option value="Goods">Goods</option>
                            <option value="Services">Services</option>
                        </select>
                    </div>
                </div>
            </div>

            <?php
                echo ($permissions['write'] > 0) ? '<div class="card-footer d-flex justify-content-end py-6 px-9">
                                                        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
                                                        <button type="submit" form="tax_form" class="btn btn-primary" id="submit-data">Save Changes</button>
                                                    </div>' : '';
            ?>
        </form>
    </div>
</div>

<?php require_once './app/Views/Partials/log-notes-modal.php'; ?>