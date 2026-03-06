import { generateElements } from '../../utilities/log-notes.js';

document.addEventListener('DOMContentLoaded', () => {
    loadShopFloorPlan();
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