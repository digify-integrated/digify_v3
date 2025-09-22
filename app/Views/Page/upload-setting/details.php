<div class="d-flex flex-column flex-lg-row">
    <div class="d-flex flex-column gap-7 gap-lg-10 w-100 mb-7 me-lg-10">
        <div class="card card-flush">
            <div class="card-header border-0">
                <div class="card-title m-0">
                    <h3 class="fw-bold m-0">Upload Setting Details</h3>
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
                                            <a href="javascript:void(0);" class="menu-link px-3" id="delete-upload-setting">
                                                Delete
                                            </a>
                                        </div>';
                        }
                    
                        $action .= '</div>';
                    
                        echo $action;
                    }
                ?>
            </div>

            <form id="upload_setting_form" class="form" method="post" action="#">
                <?= $security->csrfInput('upload_setting_form'); ?>
                <div class="card-body border-top p-9">
                    <div class="fv-row mb-4">
                        <label class="fs-6 fw-semibold form-label mt-3" for="upload_setting_name">
                            <span class="required">Display Name</span>
                        </label>

                        <input type="text" class="form-control" id="upload_setting_name" name="upload_setting_name" maxlength="100" autocomplete="off" <?php echo $disabled; ?>>
                    </div>
                    <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                        <div class="col">
                            <div class="fv-row mb-7">
                                <label class="fs-6 fw-semibold form-label mt-3" for="menu_item_id">
                                    <span class="required">Description</span>
                                </label>

                                <input type="text" class="form-control" id="upload_setting_description" name="upload_setting_description" maxlength="200" autocomplete="off" <?php echo $disabled; ?>>
                            </div>

                        </div>

                        <div class="col">
                            <div class="fv-row mb-7">
                                <label class="fs-6 fw-semibold form-label mt-3" for="max_file_size">
                                    <span class="required">Max File Size</span>
                                </label>
                                
                                <div class="input-group mb-5">
                                    <input type="number" class="form-control" id="max_file_size" name="max_file_size" min="1" step="1" <?php echo $disabled; ?>>
                                    <span class="input-group-text">kb</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <?php
                    echo ($permissions['write'] > 0) ? '<div class="card-footer d-flex justify-content-end py-6 px-9">
                                                            <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
                                                            <button type="submit" form="upload_setting_form" class="btn btn-primary" id="submit-data">Save Changes</button>
                                                        </div>' : '';
                ?>
            </form>
        </div>
    </div>
    <div class="d-flex flex-column gap-7 gap-lg-10 w-100 w-lg-700px">
        <div class="card card-flush py-4">
            <div class="card-header border-0">
                <div class="card-title">
                    <h3 class="fw-bold m-0">Allowed File Extensions</h3>
                </div>
                <div class="card-toolbar">
                    <div class="d-flex justify-content-end" data-kt-customer-table-toolbar="base">
                        <?php
                            echo $permissions['write'] > 0 ? '<button type="button" class="btn btn-light-primary" data-bs-toggle="modal" data-bs-target="#file-extension-add-modal" id="add-file-extension"><i class="ki-outline ki-plus fs-2"></i> Add</button>' : '';
                        ?>
                    </div>
                </div>
            </div>

           <div class="card-body border-top" id="file-extension-list"></div>
        </div>
    </div>
</div>

<div id="file-extension-add-modal" class="modal fade" tabindex="-1" aria-labelledby="file-extension-add-modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Add File Extension</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="file_extension_add_form" method="post" action="#">
                    <?= $security->csrfInput('file_extension_add_form'); ?>
                    <div class="row">
                        <div class="col-12">
                            <select multiple="multiple" size="20" id="file_extension_id" name="file_extension_id[]"></select>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="file_extension_add_form" class="btn btn-primary" id="submit-add">Assign</button>
            </div>
        </div>
    </div>
</div>

<?php require_once './app/Views/Partials/log-notes-modal.php'; ?>