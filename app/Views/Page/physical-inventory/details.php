<div class="card mb-10">
    <div class="card-header border-0">
        <div class="card-title m-0">
            <h3 class="fw-bold m-0">Physical Inventory Details</h3>
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
                                    <a href="javascript:void(0);" class="menu-link px-3" id="delete-physical-inventory">
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
        <form id="physical_inventory_form" method="post" action="#">
            <?= $security->csrfInput('physical_inventory_form'); ?>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="parent_category_id">
                            Product
                        </label>
                        
                        <select id="product_id" name="product_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                    </div>
                </div>
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 required fw-semibold form-label mt-3" for="inventory_date">
                            Inventory Date
                        </label>

                        <input class="form-control mb-3 mb-lg-0" id="inventory_date" name="inventory_date" type="text" autocomplete="off" <?php echo $disabled; ?>/>
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-3 rol-cols-md-1 row-cols-lg-3">
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
                        <label class="fs-6 fw-semibold required form-label mt-3" for="inventory_count">
                            Inventory Count
                        </label>

                        <input type="number" id="inventory_count" name="inventory_count" class="form-control mb-2" min="0" step="0.0001" <?php echo $disabled; ?>/>
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="inventory_difference">
                            Difference
                        </label>

                        <input type="number" id="inventory_difference" name="inventory_difference" class="form-control mb-2" min="0" step="0.0001" readonly/>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="fv-row mb-7">
                    <label class="fs-6 fw-semibold form-label mt-3" for="remarks">
                        Remarks
                    </label>

                    <textarea class="form-control" id="remarks" name="remarks" maxlength="1000" rows="3" <?php echo $disabled; ?>></textarea>
                </div>
            </div>
        </form>
    </div>

    <?php
        echo ($permissions['write'] > 0) ? ' <div class="card-footer d-flex justify-content-end py-6 px-9">
                                                <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
                                                <button type="submit" form="physical_inventory_form" class="btn btn-primary" id="submit-data">Save</button>
                                            </div>' : '';
    ?>
</div>

<?php require_once './app/Views/Partials/log-notes-modal.php'; ?>