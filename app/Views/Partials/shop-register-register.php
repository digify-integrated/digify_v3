<div class="row">
    <div class="col-lg-8" id="">
        <div class="row nav nav-pills nav-pills-custom" id="shop-product-category-container"></div>

        <div class="row mt-3" id="shop-products-container"></div>
    </div>
    
    <div class="col-lg-4">
        <div class="card card-flush bg-body"> 
            <div class="card-header pt-2">
                <h3 class="card-title fw-bold text-gray-800 fs-1qx">Order Details</h3>

                <div class="card-toolbar">
                    <div class="d-flex justify-content-end fs-2" data-kt-customer-table-toolbar="base" id="order-details-title"></div>
                </div>
            </div>

            <div class="card-body pt-0">
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
                                <span class="d-block lh-1 mb-2" id="shop-order-subtotal">&#8369; 100.50</span>
                                <span class="d-block mb-2" id="shop-order-discounts">&#8369; 8.00</span>
                                <span class="d-block fs-2 lh-1" id="shop-order-total">&#8369; 93.46</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="separator separator-dashed mb-4"></div>

                    <div class="btn-group w-100 mb-4 d-none" id="order-preference" data-kt-buttons="true" data-kt-buttons-target="[data-kt-button]">
                        <label class="btn btn-outline btn-color-muted btn-active-primary active" data-kt-button="true">
                            <input class="btn-check" type="radio" name="method" value="On-Site"/>
                            On-Site
                        </label>
                        <label class="btn btn-outline btn-color-muted btn-active-primary" data-kt-button="true">
                            <input class="btn-check" type="radio" name="method" checked="checked" value="Pickup"/>
                            Pickup
                        </label>
                        <label class="btn btn-outline btn-color-muted btn-active-primary" data-kt-button="true">
                            <input class="btn-check" type="radio" name="method" checked="checked" value="Delivery"/>
                            Delivery
                        </label>
                    </div>
                    
                    <div class="d-flex flex-equal gap-3 px-0 mb-0">
                        <?php if ($floorPlanCount > 0): ?>
                           <button class="btn btn-light w-100 p-5" id="set-table-button">
                                Set Table
                            </button>
                        <?php endif; ?>
                        <button class="btn btn-light w-100 p-5" id="set-tab-button">
                            Set Tab
                        </button>
                        <button class="btn btn-light w-100 p-5 d-none" id="new-order-button">
                            New
                        </button>
                        <?php if ($floorPlanCount > 0): ?>
                            <button class="btn btn-warning w-100 p-5 d-none" id="send-kitchen-button">
                                Kitchen
                            </button>
                        <?php endif; ?>
                        <button class="btn btn-success w-100 p-5 d-none" id="payment-button">
                            Payment
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>