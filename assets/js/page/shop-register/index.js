import { generateElements } from '../../utilities/log-notes.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    const shop_id = $('#shop_id').val();

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

    const fetchRegisterDetails = async () => {
        const transaction = 'fetch shop register table details';
        
        try {
            const shop_id               = $('#shop_id').val();
            const floor_plan_table_id   = sessionStorage.getItem('floor_plan_table_id');

            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('shop_id', shop_id);
            formData.append('floor_plan_table_id', floor_plan_table_id);

            const response = await fetch('./app/Controllers/ShopController.php', {
                method: 'POST',
                body: formData
            });
        
            if (!response.ok) {
                throw new Error(`Request failed with status: ${response.status}`);
            }
        
            const data = await response.json();
        
            if (data.success) {
                $('#order-details-title').text(`Order Details (Table No. ${data.tableNumber})`);
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

    loadShopFloorPlan(shop_id);
    loadShopProductCategories(shop_id);
    loadShopProducts(shop_id);

    document.addEventListener('click', async (event) => {
        if (event.target.closest('.add-shop-order')){
            const transaction           = 'insert shop order';
            const button                = event.target.closest('.add-shop-order');
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
                    loadShopFloorPlan();
                    disableTab();
                    sessionStorage.setItem('floor_plan_table_id', floor_plan_table_id);

                    const registerTab = document.querySelector('a[href="#register_tab"]');

                    if (registerTab) {
                        const tab = new bootstrap.Tab(registerTab);
                        tab.show();
                    }
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

            sessionStorage.setItem('floor_plan_table_id', floor_plan_table_id);
            disableTab();
            fetchRegisterDetails();

            const registerTab = document.querySelector('a[href="#register_tab"]');

            if (registerTab) {
                const tab = new bootstrap.Tab(registerTab);
                tab.show();
            }
        }

        if (event.target.closest('.product-category-filter')){
            const button            = event.target.closest('.product-category-filter');
            const product_filter    = button.dataset.productFilter;

            loadShopProducts(shop_id, product_filter);
        }

        if (event.target.closest('#new-order')){
            const button = event.target.closest('#new-order');

            sessionStorage.setItem('floor_plan_table_id', null);
            enableTab();

            const tablesTab = document.querySelector('a[href="#tables_tab"]');

            if (tablesTab) {
                const tab = new bootstrap.Tab(tablesTab);
                tab.show();
            }
        }
    });
});