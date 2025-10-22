<?php
    use App\Models\Warehouse;

    $warehouse = new Warehouse();

    $archiveWarehouse    = $authentication->checkUserSystemActionPermission($userID, 17);
    $unarchiveWarehouse  = $authentication->checkUserSystemActionPermission($userID, 18);

    $warehouseDetails    = $warehouse->fetchWarehouse($detailID);
    $warehouseStatus     = $warehouseDetails['warehouse_status'] ?? 'Active';
?>
<div class="card card-flush">
    <div class="card-header border-0">
        <div class="card-title m-0">
            <h3 class="fw-bold m-0">Warehouse Details</h3>
        </div>
        <?php
            if ($permissions['delete'] > 0 || ($archiveWarehouse['total'] > 0 && $warehouseStatus === 'Active') || ($unarchiveWarehouse['total'] > 0 && $warehouseStatus === 'Archived')) {
                $action = '<a href="#" class="btn btn-light-primary btn-flex btn-center btn-active-light-primary show menu-dropdown align-self-center" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
                                Actions
                                <i class="ki-outline ki-down fs-5 ms-1"></i>
                            </a>
                            <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true" style="z-index: 107; position: fixed; inset: 0px 0px auto auto; margin: 0px; transform: translate(-60px, 539px);" data-popper-placement="bottom-end">';
                    

                if($archiveWarehouse['total'] > 0 && $warehouseStatus === 'Active'){
                    $action .= ' <div class="menu-item px-3">
                                    <a href="javascript:void(0);" class="menu-link px-3" id="archive-warehouse">
                                        Archive
                                    </a>
                                </div>';
                }
                            
                if($unarchiveWarehouse['total'] > 0 && $warehouseStatus === 'Archived'){
                    $action .= ' <div class="menu-item px-3">
                                    <a href="javascript:void(0);" class="menu-link px-3" id="unarchive-warehouse">
                                        Unarchive
                                    </a>
                                </div>';
                }

                if ($permissions['delete'] > 0) {
                    $action .= '<div class="menu-item px-3">
                                    <a href="javascript:void(0);" class="menu-link px-3" id="delete-warehouse">
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
        <form id="warehouse_form" class="form" method="post" action="#">
            <?= $security->csrfInput('warehouse_form'); ?>
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="warehouse_name">
                            <span class="required">Display Name</span>
                        </label>

                        <input type="text" class="form-control" id="warehouse_name" name="warehouse_name" maxlength="200" autocomplete="off" <?php echo $disabled; ?>>
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="short_name">
                            Short Name
                        </label>

                        <input type="text" class="form-control" id="short_name" name="short_name" maxlength="200" autocomplete="off" <?php echo $disabled; ?>>
                    </div>
                </div>
            </div>
            
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="warehouse_type_id">
                            <span class="required">Warehouse Type</span>
                        </label>

                        <select id="warehouse_type_id" name="warehouse_type_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="contact_person">
                            Contact Person
                        </label>

                        <input type="text" class="form-control" id="contact_person" name="contact_person" maxlength="500" autocomplete="off" <?php echo $disabled; ?>>
                    </div>
                </div>
            </div>
                    
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="address">
                            <span class="required">Address</span>
                        </label>

                        <input type="text" class="form-control" id="address" name="address" maxlength="1000" autocomplete="off" <?php echo $disabled; ?>>
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="city_id">
                            <span class="required">City</span>
                        </label>

                        <select id="city_id" name="city_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="phone">
                            Phone
                        </label>

                        <input type="text" class="form-control" id="phone" name="phone" maxlength="20" autocomplete="off" <?php echo $disabled; ?>>
                    </div>
                </div>
                        
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="telephone">
                            Telephone
                        </label>

                        <input type="text" class="form-control" id="telephone" name="telephone" maxlength="20" autocomplete="off" <?php echo $disabled; ?>>
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="email">
                            Email
                        </label>

                        <input type="email" class="form-control" id="email" name="email" maxlength="250" autocomplete="off" <?php echo $disabled; ?>>
                    </div>
                </div>
            </div>

            <?php
                echo ($permissions['write'] > 0) ? '<div class="card-footer d-flex justify-content-end py-6 px-9">
                                                        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
                                                        <button type="submit" form="warehouse_form" class="btn btn-primary" id="submit-data">Save Changes</button>
                                                    </div>' : '';
            ?>
        </form>
    </div>
</div>

<?php require_once './app/Views/Partials/log-notes-modal.php'; ?>