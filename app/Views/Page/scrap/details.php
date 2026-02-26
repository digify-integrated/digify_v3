<?php
    use App\Models\Scrap;

    $scrap = new Scrap();

    $applyAdjustment = $authentication->checkUserSystemActionPermission($userID, 22);

    $scrapDetails   = $scrap->fetchScrap($detailID);
    $scrapStatus    = $scrapDetails['scrap_status'] ?? 'Draft';

    $disabled = ($scrapStatus === 'Completed') ? 'disabled' : $disabled;
?>
<div class="card mb-10">
    <div class="card-header border-0">
        <div class="card-title m-0">
            <h3 class="fw-bold m-0">Physical Inventory Details</h3>
        </div>
        <?php
            if ($permissions['delete'] > 0 || ($applyAdjustment['total'] > 0 && $scrapStatus === 'Draft')) {
                $action = '<a href="#" class="btn btn-light-primary btn-flex btn-center btn-active-light-primary show menu-dropdown align-self-center" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
                                        Actions
                                        <i class="ki-outline ki-down fs-5 ms-1"></i>
                                    </a>
                                    <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-150px py-4" data-kt-menu="true" style="z-index: 107; position: fixed; inset: 0px 0px auto auto; margin: 0px; transform: translate(-60px, 539px);" data-popper-placement="bottom-end">';
                    
                if ($applyAdjustment['total'] > 0 && $scrapStatus === 'Draft') {
                    $action .= '<div class="menu-item px-3">
                                    <a href="javascript:void(0);" class="menu-link px-3" id="apply-adjustment">
                                        Apply Adjustment
                                    </a>
                                </div>';
                }
                    
                if ($permissions['delete'] > 0) {
                    $action .= '<div class="menu-item px-3">
                                    <a href="javascript:void(0);" class="menu-link px-3" id="delete-scrap">
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
        <form id="scrap_form" method="post" action="#">
            <?= $security->csrfInput('scrap_form'); ?>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="parent_category_id">
                            Product
                        </label>
                        
                        <input type="text" id="product_name" name="product_name" class="form-control mb-2" readonly/>
                    </div>
                </div>
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 required fw-semibold form-label mt-3" for="reference_number">
                            Reference Number
                        </label>

                        <input type="text" class="form-control mb-3 mb-lg-0" id="reference_number" name="reference_number" maxlength="500" autocomplete="off" <?php echo $disabled; ?>/>
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="quantity_on_hand">
                            Quantity On Hand
                        </label>

                        <input type="number" id="quantity_on_hand" name="quantity_on_hand" class="form-control mb-2" min="0" step="0.0001" readonly/>
                    </div>
                </div>
                
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 required fw-semibold form-label mt-3" for="scrap_quantity">
                            Scrap Quantity
                        </label>
                        <input type="number" id="scrap_quantity" name="scrap_quantity" class="form-control mb-2" min="0.0001" step="0.0001" value="0.0001" <?php echo $disabled; ?>>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="scrap_reason_id">
                            Scrap Reason
                        </label>

                        <select id="scrap_reason_id" name="scrap_reason_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="fv-row mb-7">
                    <label class="fs-6 fw-semibold form-label mt-3" for="detailed_scrap_reason">
                        Detailed Scrap Reason
                    </label>

                    <textarea class="form-control" id="detailed_scrap_reason" name="detailed_scrap_reason" maxlength="5000" rows="3" <?php echo $disabled; ?>></textarea>
                </div>
            </div>
        </form>
    </div>

    <?php
        echo ($permissions['write'] > 0) ? ' <div class="card-footer d-flex justify-content-end py-6 px-9">
                                                <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
                                                <button type="submit" form="scrap_form" class="btn btn-primary" id="submit-data">Save</button>
                                            </div>' : '';
    ?>
</div>

<?php require_once './app/Views/Partials/log-notes-modal.php'; ?>