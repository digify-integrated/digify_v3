<div class="row">
    <div class="col-lg-8" id="">
        <div class="row nav nav-pills nav-pills-custom" id="shop-product-category-container"></div>

        <div class="row mt-3" id="shop-products-container"></div>
    </div>
    
    <div class="col-lg-4">
        <div class="card card-flush bg-body"> 
            <div class="card-header">
                <h3 class="card-title">
                    <span class="fw-bold text-gray-900">Order Details</span>
                </h3>

                <div class="card-toolbar">
                    <div class="d-flex justify-content-end fs-4 text-warning" data-kt-customer-table-toolbar="base">
                        <span class="text-primary fw-bold fs-5" id="order-details-title"></span>
                    </div>
                </div>
            </div>

            <div class="card-body pt-3">
                <div class="hover-scroll-overlay-y pe-6 me-n6" style="max-height: 320px" id="shop-order-list"></div>
                <div class="mt-4">
                    <div class="border border-dashed border-gray-300 rounded mb-5">
                        <div class="d-flex flex-stack p-6">
                            <div class="fs-6 fw-bold">
                                <span class="d-block lh-1 mb-2">Subtotal</span>
                                <span class="d-block mb-2">Discounts</span>
                                <span class="d-block fs-2 lh-1">Total</span>
                            </div> 
                            
                            <div class="fs-6 fw-bold text-end">
                                <span class="d-block lh-1 mb-2" id="shop-order-subtotal">&#8369; 0.00</span>
                                <span class="d-block mb-2" id="shop-order-discounts">&#8369; 0.00</span>
                                <span class="d-block fs-2 lh-1" id="shop-order-total">&#8369; 0.00</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="separator separator-dashed mb-4"></div>

                    <div class="btn-group w-100 mb-4 d-none" id="order-preference" data-kt-buttons="true" data-kt-buttons-target="[data-kt-button]">
                        <label class="btn btn-outline btn-color-muted btn-active-primary p-5 active" data-kt-button="true">
                            <input class="btn-check" type="radio" name="method" value="On-Site"/>
                            On-Site
                        </label>
                        <label class="btn btn-outline btn-color-muted btn-active-primary p-5" data-kt-button="true">
                            <input class="btn-check" type="radio" name="method" checked="checked" value="Pickup"/>
                            Pickup
                        </label>
                        <label class="btn btn-outline btn-color-muted btn-active-primary p-5" data-kt-button="true">
                            <input class="btn-check" type="radio" name="method" checked="checked" value="Delivery"/>
                            Delivery
                        </label>
                    </div>

                    <div class="d-flex flex-equal gap-3 px-0 mb-3">
                        <?php if ($floorPlanCount > 0): ?>
                            <button class="btn btn-light-warning w-100 p-5 d-none" id="send-kitchen-button">
                                Kitchen
                            </button>
                            
                            <button class="btn btn-light-primary w-100 p-5 d-none" id="set-table-button">
                                Set Table
                            </button>
                        <?php endif; ?>

                        <button class="btn btn-light-primary w-100 p-5 d-none" data-bs-toggle="modal" data-bs-target="#set-tab-modal" id="set-tab-button">
                            Set Tab
                        </button>

                        <button class="btn btn-secondary w-100 p-5 d-none" id="print-bill">
                            Print Bill
                        </button>
                    </div>

                    <div class="d-flex flex-equal gap-3 px-0">
                        <button class="btn btn-light-danger w-100 p-5 d-none" id="cancel-order-button">
                            Cancel Order
                        </button>

                        <button class="btn btn-warning w-100 p-5 d-none" id="new-order-button">
                            New Order
                        </button>

                        <button class="btn btn-success w-100 p-5 d-none" id="payment-button">
                            Payment
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="set-tab-modal" class="modal fade" tabindex="-1" aria-labelledby="set-tab-modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Order For</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="set_tab_form" method="post" action="#">
                    <?= $security->csrfInput('set_tab_form'); ?>
                    <div class="row mb-6">
                        <div class="col-lg-12">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="text" class="form-control" id="order_for" name="order_for" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="set_tab_form" class="btn btn-primary" id="submit-set-tab">Save</button>
            </div>
        </div>
    </div>
</div>
</div>

<div id="register-action-modal" class="modal fade" tabindex="-1" aria-labelledby="register-action-modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Actions</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <div class="d-flex flex-equal gap-3 px-0">
                    <button class="btn btn-light w-100 p-10 fs-2" data-bs-toggle="modal" data-bs-target="#set-tab-modal">
                       Print Bill
                    </button>
                    <button class="btn btn-light w-100 p-10 fs-2">
                        Cancel Order
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>