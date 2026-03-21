import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';
import { disableButton, enableButton, resetForm } from '../../utilities/form-utilities.js';

document.addEventListener('DOMContentLoaded', () => {
    // --- UTILITIES ---
    const debounce = (func, delay) => {
        let timeoutId;
        return (...args) => {
            clearTimeout(timeoutId);
            timeoutId = setTimeout(() => func(...args), delay);
        };
    };

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

        const formatPeso = (value) => `&#8369; ${pesoFormatter.format(Number(value || 0))}`;

        const isValidNote = (note) => {
            return note && note !== 'null' && note.toString().trim() !== '';
        };

        const hasDiscount = (order) => {
            return Number(order.discount_value) > 0 && order.discount_type !== '';
        };

        const formatDiscount = (order) => {
            if (order.discount_type === 'Percentage') {
                return `${pesoFormatter.format(Number(order.discount_value))}%`;
            }
            return formatPeso(order.discount_value);
        };

        const formatTotal = (total) => {
            return Number(total) === 0 ? 'Free' : total;
        };

        // =========================
        // Template Builders
        // =========================
        const buildDiscountHTML = (order) => {
            return `
                <div class="row">
                    <div class="col-12">
                        <span class="badge badge-warning text-wrap">
                            ${formatDiscount(order)} discount on ${formatPeso(order.subtotal)}
                        </span>
                    </div>
                </div>`;
        };

        const buildNoteHTML = (note) => {
            return `
                <div class="row mt-2">
                    <div class="col-12">
                        <span class="badge badge-danger text-wrap text-start">
                            Note: ${note}
                        </span>
                    </div>
                </div>`;
        };

        const buildDetailsHTML = (order) => {
            const noteValid = isValidNote(order.note);
            const discountValid = hasDiscount(order);

            if (!noteValid && !discountValid) return '';

            let html = '<div class="separator separator-dashed mb-2 mt-2"></div>';

            if (discountValid) {
                html += buildDiscountHTML(order);
            }

            if (noteValid) {
                html += buildNoteHTML(order.note);
            }

            return html;
        };

        const buildOrderHTML = (order) => {
            return `
                <div class="border border-dashed border-gray-300 rounded px-7 bg-hover-secondary py-5 mb-2 shop-order" 
                    data-shop-order-details-id="${order.shop_order_details_id}" 
                    data-bs-toggle="modal" 
                    data-bs-target="#update-order-details-modal">

                    <div class="row align-items-center">
                        <div class="col-6">
                            <span class="fw-semibold d-block fs-4">${order.product_name}</span>
                        </div>
                        <div class="col-3 text-center fw-bold">
                            ${order.formatted_qty}
                        </div>
                        <div class="col-3 text-end fw-bold">
                            ${formatTotal(order.formatted_total)}
                        </div>
                    </div>

                    ${buildDetailsHTML(order)}
                </div>`;
        };

        // =========================
        // Render
        // =========================
        const html = data.orders.map(buildOrderHTML).join('');
        $container.html(html);
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

    const fetchOrderTotal = async (shop_order_id) => {
        const data = await apiRequest('fetch shop order total', { shop_order_id });
        if (data?.success) {
            $('#shop-order-subtotal').html(`&#8369; ${data.subTotal}`);
            $('#shop-order-taxes').html(`&#8369; ${data.additiveTaxTotal}`);
            $('#shop-order-transaction-discounts').html(`&#8369; ${data.totalDiscount}`);
            $('#shop-order-total').html(`&#8369; ${data.totalPrice}`);
        }
    };

    const fetchShopOrderDetails = async (shop_order_details_id) => {
        const data = await apiRequest('fetch shop order details', { shop_order_details_id });
        if (data?.success) {
            $('#shop_order_details_id').val(shop_order_details_id);
            $('#quantity').val(data.quantity);
            $('#discount_value').val(data.discountValue);
            $('#note').val(data.note);

            $('#discount_type').val(data.discountType || '').trigger('change');
        }
    };

    const fetchShopOrderDiscountDetails = async (shop_order_id) => {
        const data = await apiRequest('fetch shop order discount details', { shop_order_id });
        if (data?.success) {
            $('#transaction_discount_value').val(data.transactionDiscountValue);

            $('#transaction_discount_type').val(data.transactionDiscountType || '').trigger('change');
        }
    };

    const enableTab = () => $('.nav-line-tabs .nav-link').removeClass('disabled');
    const disableTab = () => $('.nav-line-tabs .nav-link').addClass('disabled');

    const resetRegister = () => {
        $('#shop-order-subtotal, #shop-order-discounts, #shop-order-total').html('&#8369; 0.00');
        $('#order-details-title').text('');
        $('#shop-order-list').empty();
        sessionStorage.removeItem('shop_order_id');
        $('#new-order-button, #cancel-order-button, #send-kitchen-button, #payment-button, #print-bill, #discount-button, #set-table-button, #set-tab-button, .set-shop-table-order, #order-preset').addClass('d-none');
        $('.add-shop-table-order').removeClass('d-none');
        loadRegisterTables();
        enableTab();
    };

    const initializeRegister = () => {
        $('#new-order-button, #cancel-order-button, #send-kitchen-button, #payment-button, #print-bill, #discount-button, #order-preset').removeClass('d-none');
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

        const deleteOrderDetailsBtn = target.closest('#delete-order-details');
        if (deleteOrderDetailsBtn) {
            const shop_order_details_id = $('#shop_order_details_id').val();
            const data = await apiRequest('delete shop order details', {
                shop_order_details_id: shop_order_details_id
            });
            if (data?.success) {
                $('#update-order-details-modal').modal('hide');
                resetForm('update_order_details_form');
                loadOrderList(getOrderId());
                fetchOrderTotal(getOrderId());
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

        if (target.closest('.shop-order')) {
            const shopOrderDetailsId = target.closest('.shop-order').dataset.shopOrderDetailsId;
            fetchShopOrderDetails(shopOrderDetailsId);
        }

        if (target.closest('#discount-button')) {
            fetchShopOrderDiscountDetails(getOrderId());
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

    $('#update_order_details_form').validate({
        rules: {
            quantity: {
                required: true
            },
            discount_value: {
                required: function() {
                    return $('#discount_type').val() != '';
                },
                number: true,
                maxPercentage: true
            }
        },
        messages: {
            quantity: {
                required: 'Enter the quantity'
            },
            discount_value: {
                required: 'Enter discount value',
                number: 'Please enter a valid number'
            }
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
            const shop_order_details_id = $('#shop_order_details_id').val();
            event.preventDefault();
            disableButton('submit-order-details');
            const data = await apiRequest('update shop order details', {
                ...Object.fromEntries(new FormData(form)),
                shop_order_details_id: shop_order_details_id
            });
            if (data?.success) {
                $('#update-order-details-modal').modal('hide');
                resetForm('update_order_details_form');
                loadOrderList(getOrderId());
                fetchOrderTotal(getOrderId());
            }
            else{
                showNotification(data.title, data.message, data.message_type);
            }
            enableButton('submit-order-details');
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