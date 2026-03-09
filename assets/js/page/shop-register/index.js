import { generateElements } from '../../utilities/log-notes.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    loadShopFloorPlan();

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
                    $('#floor_plan_table_id').val(floor_plan_table_id);

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
            const floor_plan_table_id   = button.dataset.floorPlanTableId;
   
           $('#floor_plan_table_id').val(floor_plan_table_id);

            const registerTab = document.querySelector('a[href="#register_tab"]');

            if (registerTab) {
                const tab = new bootstrap.Tab(registerTab);
                tab.show();
            }
        }
    });
});

function loadShopFloorPlan() {
    const shop_id = $('#shop_id').val();

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