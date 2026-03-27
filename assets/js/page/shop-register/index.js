import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';
import { disableButton, enableButton, resetForm } from '../../utilities/form-utilities.js';

document.addEventListener('DOMContentLoaded', () => {
    const CONTROLLER_PATH = './app/Controllers/ShopController.php';
    const $shopIdInput = $('#shop_id');
    const getShopId = () => $shopIdInput.val();
    const getOrderId = () => sessionStorage.getItem('shop_order_id');

    /**
     * REAL-TIME UI UPDATER
     * Manages totals AND list quantities instantly without waiting for PHP.
     */
    const updateUIOptimistically = (productId, price, name) => {
        // 1. Update Totals
        const $totalEl = $('#shop-order-total');
        const $subTotalEl = $('#shop-order-subtotal');
        
        const currentTotal = parseFloat($totalEl.text().replace(/[^\d.-]/g, '')) || 0;
        const currentSub = parseFloat($subTotalEl.text().replace(/[^\d.-]/g, '')) || 0;
        const addedPrice = parseFloat(price) || 0;

        const format = (num) => num.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2});
        
        $totalEl.html(`&#8369; ${format(currentTotal + addedPrice)}`);
        $subTotalEl.html(`&#8369; ${format(currentSub + addedPrice)}`);

        // 2. Update List/Quantity Instantly
        // We look for a row in your shop-order-list container that matches this product
        let $row = $(`#shop-order-list [data-product-id="${productId}"]`).closest('tr');
        
        if ($row.length) {
            // Increment existing quantity
            const $qtyEl = $row.find('.product-quantity'); // Ensure your template has this class
            const currentQty = parseInt($qtyEl.text()) || 0;
            $qtyEl.text(currentQty + 1);
            
            // Update row subtotal if you have one
            const $rowTotalEl = $row.find('.product-subtotal');
            if ($rowTotalEl.length) {
                const newRowSub = (currentQty + 1) * addedPrice;
                $rowTotalEl.html(`&#8369; ${format(newRowSub)}`);
            }
        } else {
            // Optional: If product isn't in list, append a temporary row or just let debounce handle it
            // Most POS systems just wait for the debounce refresh if it's a brand-new item
        }
    };

    const apiRequest = async (transaction, additionalData = {}) => {
        try {
            const formData = new URLSearchParams({ transaction, ...additionalData });
            const response = await fetch(CONTROLLER_PATH, { method: 'POST', body: formData });
            if (!response.ok) throw new Error(`HTTP ${response.status}`);
            const data = await response.json();

            if (data.invalid_session && data.redirect_link) {
                setNotification(data.title, data.message, data.message_type);
                window.location.href = data.redirect_link;
                return null;
            }
            if (data.notExist) {
                setNotification(data.title, data.message, data.message_type);
                window.location.href = window.page_link || '#';
                return null;
            }
            return data;
        } catch (error) {
            handleSystemError(error, 'fetch_failed', `Request failed: ${error.message}`);
            throw error;
        }
    };

    const loadOrderList = async (orderId) => {
        const data = await apiRequest('generate shop order list', { shop_order_id: orderId });

        if (!data?.success) return;

        const $container = $('#shop-order-list');

        // =========================
        // Helpers
        // =========================
        const pesoFormatter = new Intl.NumberFormat('en-PH', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        });

        const isValidNote = (note) => {
            return note && note !== 'null' && note.toString().trim() !== '';
        };

        const formatTotal = (total) => {
            return Number(total) === 0 ? 'Free' : `&#8369; ${total}`;
        };

        // =========================
        // Template Builders
        // =========================
        const buildEmptyStateHTML = () => {
            return `
                <div class="d-flex flex-column flex-center border border-dashed border-gray-300 rounded py-10 px-5">
                    <i class="ki-outline ki-basket fs-3x text-gray-400 mb-3"></i>
                    <span class="fs-6 fw-bold text-gray-500">No items added in this order yet.</span>
                </div>`;
        };

        const buildNoteHTML = (note) => {
            return `
                <div class="row mb-0">
                    <div class="col-12">
                        <span class="badge badge-warning text-wrap text-start">
                            Note: ${note}
                        </span>
                    </div>
                </div>`;
        };

        const buildDetailsHTML = (order) => {
            const noteValid = isValidNote(order.note);
            if (!noteValid) return '';

            let html = '<div class="separator separator-dashed mb-4 mt-4"></div>';
            html += buildNoteHTML(order.note);

            return html;
        };

        const buildOrderHTML = (order) => {
            return `
                <div class="border border-dashed border-gray-300 rounded px-7 py-3 mb-2">
                    <div class="row align-items-center g-3">
                        
                        <div class="col-md-3 col-12">
                            <div class="fs-6 text-gray-900 fw-semibold text-truncate" title="${order.product_name}">
                                ${order.product_name}
                            </div>
                        </div>

                        <div class="col-md-4 col-6 d-flex justify-content-center">
                            <div class="position-relative w-100 order-quantity" 
                                style="max-width: 180px;"
                                data-kt-dialer="true" 
                                data-kt-dialer-min="0.01" 
                                data-kt-dialer-step="1" 
                                data-kt-dialer-decimals="2">
                                
                                <button type="button" class="btn btn-icon btn-active-color-gray-700 position-absolute translate-middle-y top-50 start-0" data-kt-dialer-control="decrease">
                                    <i class="ki-outline ki-minus-circle fs-1"></i>
                                </button>

                                <input type="text" class="form-control form-control-solid border-0 ps-12 pe-12 text-center fs-6 fw-bold" 
                                    data-kt-dialer-control="input" 
                                    placeholder="Amount" 
                                    data-shop-order-details-id="${order.shop_order_details_id}" 
                                    value="${order.formatted_qty.trim()}"/>

                                <button type="button" class="btn btn-icon btn-active-color-gray-700 position-absolute translate-middle-y top-50 end-0" data-kt-dialer-control="increase">
                                    <i class="ki-outline ki-plus-circle fs-1"></i>
                                </button>
                            </div>
                        </div>

                        <div class="col-md-3 col-3 text-end">
                            <div class="fs-6 text-gray-900 fw-semibold">
                                ${formatTotal(order.formatted_total)}
                            </div>
                        </div>

                        <div class="col-md-2 col-3 text-end">
                            <div class="d-flex justify-content-end gap-2">
                                <a href="#" class="btn btn-icon btn-active-light-warning w-35px h-35px shop-order-notes" data-shop-order-details-id="${order.shop_order_details_id}" data-bs-toggle="modal" data-bs-target="#order-notes-modal">
                                    <i class="ki-outline ki-notepad-edit fs-2"></i>
                                </a>
                                <a href="#" class="btn btn-icon btn-active-light-danger w-35px h-35px delete-order-details" data-shop-order-details-id="${order.shop_order_details_id}">
                                    <i class="ki-outline ki-trash fs-2"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    ${buildDetailsHTML(order)}
                </div>`;
        };

        // =========================
        // Render Logic
        // =========================
        if (!data.orders || data.orders.length === 0) {
            $container.html(buildEmptyStateHTML());
            return; // Stop here if empty
        }

        const html = data.orders.map(buildOrderHTML).join('');
        $container.html(html);

        // =========================
        // Initialization
        // =========================
        
        // Combined loop for performance
        $container.find('[data-kt-dialer="true"]').each(function() {
            const dialerElement = this;
            let dialerObject = KTDialer.getInstance(dialerElement) || new KTDialer(dialerElement);

            const orderDetailsId = $(dialerElement).find('input').attr('data-shop-order-details-id');

            dialerObject.on('kt.dialer.changed', async function() {
                const quantity = dialerObject.getValue();
                
                try {
                    const result = await apiRequest('update shop order quantity', {
                        shop_order_details_id: orderDetailsId,
                        quantity: quantity
                    });

                    if(result?.success){
                        // Reload the list and totals to reflect price changes
                        loadOrderList(getOrderId());
                        fetchOrderTotal(getOrderId());
                    }
                } catch (error) {
                    console.error("Critical: Could not sync order.", error);
                }
            });
        });
    };

    const loadRegisterTabs = async () => {
        const data = await apiRequest('generate shop register tabs', { shop_id: getShopId() });

        if (data?.success && data.floorPlans) {
            const $container = $('#floor-plan-tab');
            
            const html = data.floorPlans.map((plan, i) => {
                const activeClass = (i === 0) ? 'active' : '';
                
                return `
                    <div class="col-6 col-lg-2 mb-7">
                        <a class="nav-link nav-link-border-solid btn btn-outline btn-flex 
                                btn-active-color-primary flex-column flex-stack w-100 p-5 page-bg ${activeClass}"
                        data-bs-toggle="pill"
                        href="#floor_plan_${plan.id}">
                            <div>
                                <span class="text-gray-800 fw-bold fs-2 d-block">
                                    ${plan.name}
                                </span>
                                <span class="text-primary fw-semibold fs-7">
                                    Available Table: ${plan.count.toLocaleString()}
                                </span>
                            </div>
                        </a>
                    </div>`;
            }).join(''); // Join array into a single string
            
            $container.html(html);
        }
    };

    const loadRegisterTables = async () => {
        const data = await apiRequest('generate shop register tables', { shop_id: getShopId() });

        if (data?.success && data.floorPlans) {
            const $container = $('#floor-plan-tables');
            
            const html = data.floorPlans.map((plan, i) => {
                const activePane = (i === 0) ? 'show active' : '';
                
                // Generate the grid of tables for THIS floor plan
                const tablesHtml = plan.tables.map(table => {
                    const borderClass = table.isAvailable ? 'border-success' : 'border-danger';
                    const badgeClass  = table.isAvailable ? 'badge-light-success' : 'badge-light-danger';
                    const statusText  = table.isAvailable ? 'Available' : 'Occupied';

                    // Determine which button to show
                    let actionButton = '';
                    if (table.isAvailable) {
                        actionButton = `
                            <button class="btn btn-success w-100 add-shop-table-order"
                                    data-shop-id="${data.shopId}"
                                    data-floor-plan-table-id="${table.id}">
                                    Add Order
                            </button>
                            <button class="btn btn-success w-100 d-none set-shop-table-order"
                                    data-shop-id="${data.shopId}"
                                    data-floor-plan-table-id="${table.id}">
                                    Set Table
                            </button>`;
                    } else {
                        actionButton = `
                            <button class="btn btn-warning w-100 view-shop-table-orders"
                                    data-shop-id="${data.shopId}"
                                    data-floor-plan-table-id="${table.id}"
                                    data-shop-order-id="${table.shopOrderId}">
                                    View Orders
                            </button>`;
                    }

                    return `
                        <div class="col-6 col-xl-3">
                            <div class="card ${borderClass}">
                                <div class="card-header border-0 pt-9">
                                    <div class="card-title m-0">
                                        <h3 class="card-title align-items-start flex-column">
                                            <span class="card-label fw-bold">Table No. ${table.number}</span>
                                            <span class="text-gray-700 mt-1 fw-semibold fs-6">Seats: ${table.seats}</span>
                                        </h3>
                                    </div>
                                    <div class="card-toolbar">
                                        <span class="badge ${badgeClass} fw-bold me-auto px-4 py-3">${statusText}</span>
                                    </div>
                                </div>
                                <div class="card-body px-9 pt-3 pb-9">
                                    <div class="separator separator-dashed mb-7"></div>
                                    ${actionButton}
                                </div>
                            </div>
                        </div>`;
                }).join('');

                return `
                    <div class="tab-pane fade ${activePane}" id="floor_plan_${plan.floorPlanId}">
                        <div class="row g-6 g-xl-9">${tablesHtml}</div>
                    </div>`;
            }).join('');
            
            $container.html(html);
        }
    };
    
    const loadRegisterProductCategories = async () => {
        const data = await apiRequest('generate shop product categories', { shop_id: getShopId() });

        if (data?.success && data.categories) {
            const $container = $('#shop-product-category-container');
            
            // Start with the "All" category
            let categoriesHtml = `
                <div class="col-4 col-lg-2 mb-4">
                    <a class="nav-link nav-link-border-solid btn btn-outline btn-flex btn-active-color-primary flex-column flex-stack w-100 p-5 page-bg active product-category-filter" 
                    data-bs-toggle="pill" 
                    data-product-filter="">
                        <div>
                            <span class="text-gray-800 fw-bold fs-3 d-block">All</span>
                        </div>
                    </a>
                </div>`;

            // Map the rest of the dynamic categories
            const dynamicHtml = data.categories.map(cat => `
                <div class="col-4 col-lg-2 mb-4">
                    <a class="nav-link nav-link-border-solid btn btn-outline btn-flex btn-active-color-primary flex-column flex-stack w-100 p-5 page-bg product-category-filter" 
                    data-bs-toggle="pill" 
                    data-product-filter="${cat.id}">
                        <div>
                            <span class="text-gray-800 fw-bold fs-3 d-block">${cat.name}</span>
                        </div>
                    </a>
                </div>
            `).join('');

            $container.html(categoriesHtml + dynamicHtml);
        }
    };
    
    const loadRegisterProducts = async (product_category_id = null) => {
        const data = await apiRequest('generate shop products', { 
            shop_id: getShopId(), 
            product_category_id: product_category_id 
        });

        if (data?.success && data.products) {
            const $container = $('#shop-products-container');
            
            const html = data.products.map(product => `
                <div class="col-6 col-lg-3 mb-5">
                    <div class="card card-flush flex-row-fluid p-0 w-100 border border-hover-primary cursor-pointer add-shop-order" 
                        data-product-id="${product.id}" 
                        data-shop-id="${data.shopId}">
                        <div class="card-body text-center">
                            <img src="${product.image}" 
                                class="rounded-3 mb-4 w-100 h-120px" 
                                alt="${product.name}" 
                                loading="lazy" />  <div class="mb-2">
                                <div class="text-center">
                                    <span class="fw-bold text-gray-800 fs-3 fs-xl-1">${product.name}</span>
                                </div>
                            </div>
                            <span class="text-success text-end fw-bold fs-2">&#8369; ${product.formatted_price}</span>
                        </div>
                    </div>
                </div>
            `).join('');

            $container.html(html);
        }
    };

    const loadOrderDiscount = async () => {
        const data = await apiRequest('generate shop discounts list', { 
            shop_id: getShopId(),
            shop_order_id: getOrderId()
        });

        if (!data?.success || !data.discounts) return;

        const $container = $('#discount-lists');

        const html = data.discounts.map((discount, i) => {

            const isPercentage = discount.valueType === 'Percentage';
            const isReadonly = discount.isVariable === 'No';

            const symbol = isPercentage ? '%' : '₱';
            const maxAttr = isPercentage ? 'max="100"' : '';
            const readonlyAttr = isReadonly ? 'readonly' : '';

            return `
            <div class="row mb-4">
                
                <!-- Label -->
                <div class="col-lg-4">
                    <label class="fs-6 fw-semibold form-label mt-2">
                        ${discount.discountName}
                        <span class="text-muted">(${symbol})</span>
                    </label>
                </div>

                <!-- Input -->
                <div class="col-lg-8">
                    <input 
                        type="number"
                        class="form-control discount-input"
                        
                        name="discounts[${i}][value]"
                        value="${discount.appliedValue ?? 0}"

                        min="0"
                        step="0.01"
                        ${maxAttr}
                        ${readonlyAttr}

                        data-type="${discount.valueType}"
                        data-id="${discount.discountTypeId}"
                    >

                    <!-- Hidden ID -->
                    <input 
                        type="hidden" 
                        name="discounts[${i}][discount_type_id]" 
                        value="${discount.discountTypeId}"
                    >
                </div>

            </div>
            `;
        }).join('');

        $container.html(html);
    };

    const refreshRegisterUI = async (orderId) => {
        loadOrderList(orderId);

        await Promise.all([
            fetchOrderTotal(orderId),
            fetchRegisterDetails(orderId)
        ]);

        initializeRegister();
        disableTab();
        traverseToRegisterTab();
    };

    const setTab = () => {
        const orderId = getOrderId();
        if (orderId) refreshRegisterUI(orderId);
    };

    const fetchRegisterDetails = async (shop_order_id) => {
        const data = await apiRequest('fetch shop register table details', { shop_id: getShopId(), shop_order_id });
        if (data?.success) {
            $('#order-details-title').text(data.title);
            const showSetButtons = (shop_order_id != null && data.tableNumber == null && data.orderFor == null);
            const showTableOnly = (shop_order_id != null && data.tableNumber != null && data.orderFor == null);
            $('#set-table-button').toggleClass('d-none', !(showSetButtons || showTableOnly));
            $('#set-tab-button').toggleClass('d-none', !showSetButtons);

            document.querySelector(`.order-preset-option[value="${data.orderPreset}"]`)?.click();
        }
    };

    const formatPeso = (amount) => `₱ ${parseFloat(amount).toFixed(2)}`;

    const fetchOrderTotal = async (shop_order_id) => {
        const data = await apiRequest('fetch shop order total', { shop_order_id });

        if (!data?.success) return;

        let html = '';

        // 🔹 Subtotal
        html += `
            <div class="d-flex flex-stack mb-2">
                <span>Subtotal</span>
                <span>${formatPeso(data.subtotal)}</span>
            </div>
        `;

        // 🔹 VAT Sales
        html += `
            <div class="d-flex flex-stack mb-2">
                <span>VAT Sales</span>
                <span>${formatPeso(data.vat_sales)}</span>
            </div>
        `;

        // 🔹 VAT
        html += `
            <div class="d-flex flex-stack mb-2">
                <span>VAT (12%)</span>
                <span>${formatPeso(data.vat_amount)}</span>
            </div>
        `;

        // 🔹 Charges (ONLY if exist)
        if (data.charges.length > 0) {
            data.charges.forEach(charge => {
                html += `
                    <div class="d-flex flex-stack mb-2 text-primary">
                        <span>${charge.name}</span>
                        <span>${formatPeso(charge.amount)}</span>
                    </div>
                `;
            });
        }

        // 🔹 Discounts (ONLY if exist)
        if (data.discounts.length > 0) {
            data.discounts.forEach(discount => {
                html += `
                    <div class="d-flex flex-stack mb-2 text-danger">
                        <span>${discount.name}</span>
                        <span>-${formatPeso(discount.amount)}</span>
                    </div>
                `;
            });
        }

        // Inject
        $('#order-summary-list').html(html);

        // 🔹 Total
        $('#shop-order-total').html(formatPeso(data.total));
    };

    const fetchShopOrderDetails = async (shop_order_details_id) => {
        const data = await apiRequest('fetch shop order details', { shop_order_details_id });
        if (data?.success) {
            $('#shop_order_details_id').val(shop_order_details_id);
            $('#note').val(data.note);
        }
    };

    const enableTab = () => $('.nav-line-tabs .nav-link').removeClass('disabled');
    const disableTab = () => $('.nav-line-tabs .nav-link').addClass('disabled');

    const resetRegister = () => {
        $('#shop-order-subtotal, #shop-order-discounts, #shop-order-total').html('&#8369; 0.00');
        $('#order-details-title').text('');
        $('#shop-order-list').empty();
        sessionStorage.removeItem('shop_order_id');
        $('#new-order-button, #cancel-order-button, #send-kitchen-button, #payment-button, #print-bill, #discount-button, #charges-button, #set-table-button, #set-tab-button, .set-shop-table-order, #order-preset').addClass('d-none');
        $('.add-shop-table-order').removeClass('d-none');
        loadRegisterTables();
        enableTab();
    };

    const initializeRegister = () => {
        $('#new-order-button, #cancel-order-button, #send-kitchen-button, #payment-button, #print-bill, #discount-button, #charges-button, #order-preset').removeClass('d-none');
    };

    const traverseTab = (target) => {
        const tabEl = document.querySelector(`a[href="${target}"]`);
        if (tabEl) new bootstrap.Tab(tabEl).show();
    };

    const traverseToTablesTab = () => traverseTab("#tables_tab");
    const traverseToRegisterTab = () => traverseTab("#register_tab");

    // Initial Load
    setTab();
    loadRegisterTabs();
    loadRegisterTables();
    loadRegisterProductCategories();
    loadRegisterProducts();

    /**
     * EVENT DELEGATION
     */
    document.addEventListener('click', async (event) => {
        const target = event.target;

        const addProductBtn = target.closest('.add-shop-order');
        if (addProductBtn) {
            if ($('.add-shop-order.is-loading').length > 0) {
                return;
            }

            // 2. LOCK ALL: Disable every product card immediately
            const $allProducts = $('.add-shop-order');
            $allProducts.addClass(  'is-loading');

            const currentOrderId = getOrderId();
            const productId = addProductBtn.dataset.productId;
            const productPrice = addProductBtn.dataset.productPrice || 0;
            const productName = addProductBtn.dataset.productName || '';

            // Optimistic UI Update (instant feedback for the one clicked)
            updateUIOptimistically(productId, productPrice, productName);

            try {
                const data = await apiRequest('insert shop order product', {
                    shop_id: addProductBtn.dataset.shopId,
                    product_id: productId,
                    shop_order_id: (currentOrderId === 'null' || !currentOrderId) ? '' : currentOrderId
                });

                if (data?.success) {
                    sessionStorage.setItem('shop_order_id', data.shop_order_id);
                    
                    // 3. SYNC TRUTH: Wait for the list and totals to fully refresh from DB
                    await refreshRegisterUI(data.shop_order_id);
                }
            } catch (error) {
                console.error("Critical: Could not sync order.", error);
                // Optional: showNotification('Error', 'Failed to add item', 'error');
            } finally {
                // 4. UNLOCK ALL: Re-enable everything once the UI refresh is finished
                $allProducts.removeClass('is-loading');
            }
            return;
        }

        // Add/Set Table Order
        const tableBtn = target.closest('.add-shop-table-order, .set-shop-table-order');
        if (tableBtn) {
            const isUpdate = tableBtn.classList.contains('set-shop-table-order');
            const data = await apiRequest(isUpdate ? 'update shop order table' : 'insert shop order', {
                shop_id: tableBtn.dataset.shopId,
                floor_plan_table_id: tableBtn.dataset.floorPlanTableId,
                shop_order_id: getOrderId()
            });
            if (data?.success) {
                if (!isUpdate) sessionStorage.setItem('shop_order_id', data.shop_order_id);
                refreshRegisterUI(getOrderId());
                loadRegisterTables();
            }
            return;
        }

        // View Existing Table Order
        const viewOrderBtn = target.closest('.view-shop-table-orders');
        if (viewOrderBtn) {
            const orderId = viewOrderBtn.dataset.shopOrderId;
            sessionStorage.setItem('shop_order_id', orderId);
            refreshRegisterUI(orderId);
            return;
        }

        // Filters
        if (target.closest('.product-category-filter')) {
            const filter = target.closest('.product-category-filter').dataset.productFilter;
            loadRegisterProducts(filter)
        }

        if (target.closest('#new-order-button')) {
            resetRegister();
            traverseToTablesTab();
        }

        if (target.closest('#print-bill')) {
            const width = 800;
            const height = 600;

            const left = (screen.width - width) / 2;
            const top = (screen.height - height) / 2;

            const url = `print-shop-order-bill.php?id=${getOrderId()}`;

            window.open(
                url,
                '_blank',
                `width=${width},height=${height},top=${top},left=${left}`
            );
        }

        if (target.closest('#set-table-button')) {
            traverseToTablesTab();
            enableTab();
            $('.set-shop-table-order').removeClass('d-none');
            $('.add-shop-table-order').addClass('d-none');
        }

        if (target.closest('.shop-order-notes')) {
            const shopOrderDetailsId = target.closest('.shop-order-notes').dataset.shopOrderDetailsId;
            fetchShopOrderDetails(shopOrderDetailsId);
        }

        if (target.closest('#discount-button')) {
            loadOrderDiscount(getOrderId());
        }

        if (target.closest('#charge-button')) {
            loadOrderCharge(getOrderId());
        }

        if (target.closest('.delete-order-details')){
            const transaction           = 'delete shop order details';
            const button                = event.target.closest('.delete-order-details');
            const shop_order_details_id = button.dataset.shopOrderDetailsId;
                
            Swal.fire({
                title: 'Confirm Order Deletion',
                text: 'Are you sure you want to delete this order?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Delete',
                cancelButtonText: 'Cancel',
                customClass: {
                    confirmButton: 'btn btn-danger mt-2',
                    cancelButton: 'btn btn-secondary ms-2 mt-2'
                },
                buttonsStyling: false
            }).then(async (result) => {
                if (!result.value) return;
                
                const formData = new URLSearchParams();
                formData.append('transaction', transaction);
                formData.append('shop_order_details_id', shop_order_details_id);
                
                try {
                    const response = await fetch('./app/Controllers/ShopController.php', {
                        method: 'POST',
                        body: formData
                    });
                
                    if (!response.ok) throw new Error(`Request failed: ${response.status}`);
                
                    const data = await response.json();
                
                    if (data.success) {
                        loadOrderList(getOrderId());
                        fetchOrderTotal(getOrderId());
                    }
                    else if (data.invalid_session) {
                        setNotification(data.title, data.message, data.message_type);
                        window.location.href = data.redirect_link;
                    }
                    else {
                        showNotification(data.title, data.message, data.message_type);
                    }
                } catch (error) {
                    handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
                }
            });
                }
    });

    document.querySelectorAll('.order-preset-option').forEach((radio) => {
        radio.addEventListener('change', async function () {
            await apiRequest('update shop order preset', {
                shop_order_id: getOrderId(),
                order_preset: this.value
            });
        });
    });

    // Form Validation logic remains the same...
    $('#set_tab_form').validate({
        rules: { order_for: { required: true } },
        messages: { order_for: { required: 'Enter the name' } },
        errorPlacement: (error, element) => {
            showNotification('Action Needed: Issue Detected', error.text(), 'error', 2500);
        },
        highlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.addClass('is-invalid');
        },
        unhighlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.removeClass('is-invalid');
        },
        submitHandler: async (form, event) => {
            event.preventDefault();
            disableButton('submit-set-tab');
            const data = await apiRequest('update shop order tab', {
                ...Object.fromEntries(new FormData(form)),
                shop_order_id: getOrderId()
            });
            if (data?.success) {
                $('#set-tab-modal').modal('hide');
                resetForm('set_tab_form');
                refreshRegisterUI(getOrderId());
            }
            enableButton('submit-set-tab');
            return false;
        }
    });

    $('#cancel_order_form').validate({
        submitHandler: async (form, event) => {
            event.preventDefault();
            disableButton('submit-cancel-order');
            const data = await apiRequest('update shop order to cancel', {
                ...Object.fromEntries(new FormData(form)),
                shop_order_id: getOrderId()
            });
            if (data?.success) {
                $('#cancel-order-modal').modal('hide');
                resetForm('cancel_order_form');
                resetRegister();
                traverseToTablesTab();
            }
            enableButton('submit-cancel-order');
            return false;
        }
    });

    $('#order_notes_form').validate({
        submitHandler: async (form, event) => {
            const shop_order_details_id = $('#shop_order_details_id').val();
            event.preventDefault();
            disableButton('submit-order-notes');
            const data = await apiRequest('update shop order note', {
                ...Object.fromEntries(new FormData(form)),
                shop_order_details_id: shop_order_details_id
            });
            if (data?.success) {
                $('#order-notes-modal').modal('hide');
                resetForm('order_notes_form');
                loadOrderList(getOrderId());
                fetchOrderTotal(getOrderId());
            }
            else{
                showNotification(data.title, data.message, data.message_type);
            }
            enableButton('submit-order-notes');
            return false;
        }
    });

    $('#transaction_discount_form').validate({
        rules: {
            transaction_discount_value: {
                required: function() {
                    return $('#transaction_discount_type').val() != '';
                },
                number: true,
                maxPercentage: true
            }
        },
        messages: {
            transaction_discount_value: {
                required: 'Enter discount value',
                number: 'Please enter a valid number'
            }
        },
        errorPlacement: (error, element) => {
            showNotification('Action Needed: Issue Detected', error.text(), 'error', 2500);
        },
        highlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.addClass('is-invalid');
        },
        unhighlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.removeClass('is-invalid');
        },
        submitHandler: async (form, event) => {
            event.preventDefault();
            disableButton('submit-transaction-discount');
            const data = await apiRequest('update shop order discount', {
                ...Object.fromEntries(new FormData(form)),
                shop_order_id: getOrderId()
            });
            if (data?.success) {
                $('#discount-modal').modal('hide');
                resetForm('transaction_discount_form');
                fetchOrderTotal(getOrderId());
            }
            else{
                showNotification(data.title, data.message, data.message_type);
            }
            enableButton('submit-transaction-discount');
            return false;
        }
    });

    $.validator.addMethod("maxPercentage", function(value, element) {
        let discountType = $('#discount_type').val();

        if (discountType === 'Percentage') {
            return parseFloat(value) <= 100;
        }
        return true;
    }, "Percentage discount cannot exceed 100%");
});