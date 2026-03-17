import { generateElements } from '../../utilities/log-notes.js';

import { handleSystemError } from '../../modules/system-errors.js';

import { showNotification, setNotification } from '../../modules/notifications.js';

import { disableButton, enableButton, resetForm} from '../../utilities/form-utilities.js';



document.addEventListener('DOMContentLoaded', () => {

    const shop_id = $('#shop_id').val();



    const setTab = () => {

        const shopOrderId = sessionStorage.getItem('shop_order_id');

        if (!shopOrderId) return;



        traverseToRegisterTab();

        disableTab();

        loadOrderList(shopOrderId);

        fetchOrderTotal(shopOrderId);
        fetchRegisterDetails(shopOrderId);
        



        initializeRegister();

    };



    const loadShopFloorPlan = (shop_id) => {

        const requests = [

            ['floor-plan-tab', 'generate shop register tabs'],

            ['floor-plan-tables', 'generate shop register tables']

        ];



        requests.forEach(([container, transaction]) => {

            generateElements({

                container,

                controller: 'ShopController',

                transaction,

                reference_id: shop_id

            });

        });

    }

    

    const loadShopProductCategories = (shop_id) => {

        const requests = [

            ['shop-product-category-container', 'generate shop product categories']

        ];



        requests.forEach(([container, transaction]) => {

            generateElements({

                container,

                controller: 'ShopController',

                transaction,

                reference_id: shop_id

            });

        });

    }

    

    const loadShopProducts = (shop_id, product_category_id = null) => {

        const requests = [

            ['shop-products-container', 'generate shop products']

        ];



        requests.forEach(([container, transaction]) => {

            generateElements({

                container,

                controller: 'ShopController',

                transaction,

                reference_id: shop_id,

                product_category_id : product_category_id

            });

        });

    }



    const loadOrderList = (shop_order_id) => {

        const requests = [

            ['shop-order-list', 'generate shop order list']

        ];



        requests.forEach(([container, transaction]) => {

            generateElements({

                container,

                controller: 'ShopController',

                transaction,

                reference_id: null,

                shop_order_id : shop_order_id

            });

        });

    }



    const fetchRegisterDetails = async (shop_order_id) => {

        const transaction = 'fetch shop register table details';

        

        try {

            const shop_id = $('#shop_id').val();



            const formData = new URLSearchParams();

            formData.append('transaction', transaction);

            formData.append('shop_id', shop_id);

            formData.append('shop_order_id', shop_order_id);



            const response = await fetch('./app/Controllers/ShopController.php', {

                method: 'POST',

                body: formData

            });

        

            if (!response.ok) {

                throw new Error(`Request failed with status: ${response.status}`);

            }

        

            const data = await response.json();

        

            if (data.success) {

                $('#order-details-title').text(`${data.title}`);



                if (data.tableNumber == null && data.orderFor == null){
                    $('#set-table-button').removeClass('d-none');
                    $('#set-tab-button').removeClass('d-none');
                }
                else if (data.tableNumber != null && data.orderFor == null){
                    $('#set-tab-button').addClass('d-none');
                    $('#set-table-button').removeClass('d-none');
                }
                else{
                    $('#set-table-button').addClass('d-none');
                    $('#set-tab-button').addClass('d-none');
                }

            }

            else if (data.notExist) {

                setNotification(data.title, data.message, data.message_type);

                window.location.href = page_link;

            }

            else {

                showNotification(data.title, data.message, data.message_type);

            }

        } catch (error) {

            handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);

        }

    }



    const fetchOrderTotal = async (shop_order_id) => {

        const transaction = 'fetch shop order total';

        

        try {

            const formData = new URLSearchParams();

            formData.append('transaction', transaction);

            formData.append('shop_order_id', shop_order_id);



            const response = await fetch('./app/Controllers/ShopController.php', {

                method: 'POST',

                body: formData

            });

        

            if (!response.ok) {

                throw new Error(`Request failed with status: ${response.status}`);

            }

        

            const data = await response.json();

        

            if (data.success) {

                $('#shop-order-subtotal').html(`&#8369; ${data.subTotal}`);

                $('#shop-order-discounts').html(`&#8369; ${data.discount}`);

                $('#shop-order-total').html(`&#8369; ${data.total}`);

            }

            else if (data.notExist) {

                setNotification(data.title, data.message, data.message_type);

                window.location.href = page_link;

            }

            else {

                showNotification(data.title, data.message, data.message_type);

            }

        } catch (error) {

            handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);

        }

    }



    const enableTab = () => {

        $('.nav-line-tabs .nav-link').removeClass('disabled');

    }



    const disableTab = () => {

        $('.nav-line-tabs .nav-link').addClass('disabled');

    }



    const resetRegister = () => {

        $('#shop-order-subtotal').html('&#8369; 0.00');

        $('#shop-order-discounts').html('&#8369; 0.00');

        $('#shop-order-total').html('&#8369; 0.00');

        $('#order-details-title').text('');



        $('#shop-order-list').empty();



        sessionStorage.removeItem('shop_order_id');



        $('#new-order-button').addClass('d-none');

        $('#send-kitchen-button').addClass('d-none');

        $('#payment-button').addClass('d-none');



        $('#set-table-button').addClass('d-none');

        $('#set-tab-button').addClass('d-none');

        

        enableTab();

    }



    const initializeRegister = () => {

        $('#new-order-button').removeClass('d-none');

        $('#send-kitchen-button').removeClass('d-none');

        $('#payment-button').removeClass('d-none');

    }



    const traverseToTablesTab = () => {

        const tablesTab = document.querySelector('a[href="#tables_tab"]');



        if (tablesTab) {

            const tab = new bootstrap.Tab(tablesTab);

            tab.show();

        }

    }



    const traverseToRegisterTab = () => {

        const registerTab = document.querySelector('a[href="#register_tab"]');



        if (registerTab) {

            const tab = new bootstrap.Tab(registerTab);

            tab.show();

        }

    }



    setTab();

    loadShopFloorPlan(shop_id);

    loadShopProductCategories(shop_id);

    loadShopProducts(shop_id);



    document.addEventListener('click', async (event) => {

        if (event.target.closest('.add-shop-table-order')){

            const transaction           = 'insert shop order';

            const button                = event.target.closest('.add-shop-table-order');

            const shop_id               = button.dataset.shopId;

            const floor_plan_table_id   = button.dataset.floorPlanTableId;

   

            try {

                const formData = new URLSearchParams();

                formData.append('transaction', transaction);

                formData.append('shop_id', shop_id);

                formData.append('floor_plan_table_id', floor_plan_table_id);

    

                const response = await fetch('./app/Controllers/ShopController.php', {

                    method: 'POST',

                    body: formData

                });

    

                if (!response.ok) { 

                    throw new Error(`Add order with status: ${response.status}`);

                }

    

                const data = await response.json();

    

                if (data.success) {

                    loadShopFloorPlan(shop_id);

                    disableTab();

                    initializeRegister();

                    traverseToRegisterTab();

                    

                    sessionStorage.setItem('shop_order_id', data.shop_order_id);

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

        }



        if (event.target.closest('.set-shop-table-order')){

            const transaction           = 'update shop order table';

            const button                = event.target.closest('.set-shop-table-order');

            const shop_id               = button.dataset.shopId;

            const floor_plan_table_id   = button.dataset.floorPlanTableId;

            const shop_order_id         = sessionStorage.getItem('shop_order_id');

   

            try {

                const formData = new URLSearchParams();

                formData.append('transaction', transaction);

                formData.append('shop_id', shop_id);

                formData.append('floor_plan_table_id', floor_plan_table_id);

                formData.append('shop_order_id', shop_order_id);

    

                const response = await fetch('./app/Controllers/ShopController.php', {

                    method: 'POST',

                    body: formData

                });

    

                if (!response.ok) { 

                    throw new Error(`Add order with status: ${response.status}`);

                }

    

                const data = await response.json();

    

                if (data.success) {

                    loadShopFloorPlan(shop_id);

                    disableTab();

                    

                    loadOrderList(shop_order_id);

                    fetchOrderTotal(shop_order_id);

                    fetchRegisterDetails(shop_order_id);

                    initializeRegister();

                    traverseToRegisterTab();

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

        }



        if (event.target.closest('.add-shop-order')){

            const transaction   = 'insert shop order product';

            const button        = event.target.closest('.add-shop-order');

            const shop_id       = button.dataset.shopId;

            const product_id    = button.dataset.productId;

            const shop_order_id = sessionStorage.getItem('shop_order_id');

   

            try {

                const formData = new URLSearchParams();

                formData.append('transaction', transaction);

                formData.append('shop_id', shop_id);

                formData.append('product_id', product_id);

                formData.append(

                    'shop_order_id',

                    shop_order_id === null || shop_order_id === 'null' ? '' : shop_order_id

                );

    

                const response = await fetch('./app/Controllers/ShopController.php', {

                    method: 'POST',

                    body: formData

                });

    

                if (!response.ok) { 

                    throw new Error(`Add order with status: ${response.status}`);

                }

    

                const data = await response.json();

    

                if (data.success) {

                    sessionStorage.setItem('shop_order_id', data.shop_order_id);



                    loadOrderList(data.shop_order_id);

                    fetchOrderTotal(data.shop_order_id);

                    fetchRegisterDetails(data.shop_order_id);

                    initializeRegister();

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

        }



        if (event.target.closest('.view-shop-table-orders')){

            const button                = event.target.closest('.view-shop-table-orders');

            const shop_id               = button.dataset.shopId;

            const floor_plan_table_id   = button.dataset.floorPlanTableId;

            const shop_order_id         = button.dataset.shopOrderId;



            $('.set-shop-table-order').addClass('d-none');

            $('.add-shop-table-order').removeClass('d-none');



            sessionStorage.setItem('shop_order_id', shop_order_id);

            disableTab();

            fetchRegisterDetails(shop_order_id);

            initializeRegister();

            traverseToRegisterTab();

        }



        if (event.target.closest('.product-category-filter')){

            const button            = event.target.closest('.product-category-filter');

            const product_filter    = button.dataset.productFilter;



            loadShopProducts(shop_id, product_filter);

        }



        if (event.target.closest('#new-order-button')){

            resetRegister();



            traverseToTablesTab();

        }



        if (event.target.closest('#set-table-button')){

            traverseToTablesTab();

            enableTab();



            $('.set-shop-table-order').removeClass('d-none');

            $('.add-shop-table-order').addClass('d-none');

        }

    });



    $('#set_tab_form').validate({

        rules: {

            order_for: { required: true }

        },

        messages: {

            order_for: { required: 'Enter the order for' }

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

    

            const transaction       = 'update shop order tab';

            const shop_order_id     = sessionStorage.getItem('shop_order_id');

    

            const formData = new URLSearchParams(new FormData(form));

            formData.append('transaction', transaction);

            formData.append('shop_order_id', shop_order_id);

    

            disableButton('submit-set-tab');

    

            try {

                const response = await fetch('./app/Controllers/ShopController.php', {

                    method: 'POST',

                    body: formData

                });

    

                if (!response.ok) {

                    throw new Error(`Save shop failed with status: ${response.status}`);

                }

    

                const data = await response.json();

    

                if (data.success) {

                    $('#set-tab-modal').modal('hide');

                    resetForm('set_tab_form');

                    disableTab();

                    

                    loadOrderList(shop_order_id);

                    fetchOrderTotal(shop_order_id);

                    fetchRegisterDetails(shop_order_id);

                    initializeRegister();



                    enableButton('submit-set-tab');

                }

                else if(data.invalid_session){

                    setNotification(data.title, data.message, data.message_type);

                    window.location.href = data.redirect_link;

                }

                else{

                    showNotification(data.title, data.message, data.message_type);

                    enableButton('submit-set-tab');

                }

            } catch (error) {

                enableButton('submit-set-tab');

                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);

            }

    

            return false;

        }

    });

});