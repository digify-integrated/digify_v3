import { generateElements } from '../../utilities/log-notes.js';
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

    const loadComponent = (container, transaction, extraParams = {}) => {
        generateElements({
            container,
            controller: 'ShopController',
            transaction,
            reference_id: getShopId(),
            ...extraParams
        });
    };

    const refreshRegisterUI = async (orderId) => {
        // This is the "Truth" refresh that syncs with DB
        loadComponent('shop-order-list', 'generate shop order list', { 
            reference_id: null, 
            shop_order_id: orderId 
        });

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
        }
    };

    const fetchOrderTotal = async (shop_order_id) => {
        const data = await apiRequest('fetch shop order total', { shop_order_id });
        if (data?.success) {
            $('#shop-order-subtotal').html(`&#8369; ${data.subTotal}`);
            $('#shop-order-discounts').html(`&#8369; ${data.discount}`);
            $('#shop-order-total').html(`&#8369; ${data.total}`);
        }
    };

    const enableTab = () => $('.nav-line-tabs .nav-link').removeClass('disabled');
    const disableTab = () => $('.nav-line-tabs .nav-link').addClass('disabled');

    const resetRegister = () => {
        $('#shop-order-subtotal, #shop-order-discounts, #shop-order-total').html('&#8369; 0.00');
        $('#order-details-title').text('');
        $('#shop-order-list').empty();
        sessionStorage.removeItem('shop_order_id');
        $('#new-order-button, #send-kitchen-button, #payment-button, #set-table-button, #set-tab-button, .set-shop-table-order, #order-preference').addClass('d-none');
        $('.add-shop-table-order').removeClass('d-none');
        enableTab();
    };

    const initializeRegister = () => {
        $('#new-order-button, #send-kitchen-button, #payment-button, #order-preference').removeClass('d-none');
    };

    const traverseTab = (target) => {
        const tabEl = document.querySelector(`a[href="${target}"]`);
        if (tabEl) new bootstrap.Tab(tabEl).show();
    };

    const traverseToTablesTab = () => traverseTab("#tables_tab");
    const traverseToRegisterTab = () => traverseTab("#register_tab");

    // Initial Load
    setTab();
    loadComponent('floor-plan-tab', 'generate shop register tabs');
    loadComponent('floor-plan-tables', 'generate shop register tables');
    loadComponent('shop-product-category-container', 'generate shop product categories');
    loadComponent('shop-products-container', 'generate shop products');

    /**
     * EVENT DELEGATION
     */
    document.addEventListener('click', async (event) => {
        const target = event.target;

        const addProductBtn = target.closest('.add-shop-order');
        if (addProductBtn) {
            const currentOrderId = getOrderId();
            const productId = addProductBtn.dataset.productId;
            const productPrice = addProductBtn.dataset.productPrice || 0;
            const productName = addProductBtn.dataset.productName || '';

            // 1. INSTANT UI UPDATE (Total & Quantity)
            updateUIOptimistically(productId, productPrice, productName);
            
            // 2. BACKGROUND SERVER SYNC
            // Notice we don't 'await' the refresh logic inside the loop
            apiRequest('insert shop order product', {
                shop_id: addProductBtn.dataset.shopId,
                product_id: productId,
                shop_order_id: (currentOrderId === 'null' || !currentOrderId) ? '' : currentOrderId
            }).then(data => {
                if (data?.success) {
                    sessionStorage.setItem('shop_order_id', data.shop_order_id);
                    // 3. FINAL SYNC (Corrects any rounding or tax logic from server)
                    refreshRegisterUI(data.shop_order_id);
                }
            });
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
                loadComponent('floor-plan-tables', 'generate shop register tables');
                refreshRegisterUI(getOrderId());
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
            loadComponent('shop-products-container', 'generate shop products', { product_category_id: filter });
        }

        if (target.closest('#new-order-button')) {
            resetRegister();
            traverseToTablesTab();
        }

        if (target.closest('#set-table-button')) {
            traverseToTablesTab();
            enableTab();
            $('.set-shop-table-order').removeClass('d-none');
            $('.add-shop-table-order').addClass('d-none');
        }
    });

    // Form Validation logic remains the same...
    $('#set_tab_form').validate({
        rules: { order_for: { required: true } },
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
});