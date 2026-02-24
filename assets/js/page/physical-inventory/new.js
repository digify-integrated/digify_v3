import { disableButton, enableButton, generateDropdownOptions, initializeDatePicker } from '../../utilities/form-utilities.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    generateDropdownOptions({
        url: './app/Controllers/ProductController.php',
        dropdownSelector: '#product_id',
        data: { transaction: 'generate active product options' }
    });

    initializeDatePicker('#inventory_date');

    const displayDetails = async () => {
        const product_id = document.querySelector("#product_id").value;
        const inventoryCount = document.querySelector("#inventory_count").value;
        const transaction = 'fetch product details';

        if (!product_id) {
            $('#quantity_on_hand').val(0);
            return;
        }

        try {
            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('product_id', product_id);

            const response = await fetch('./app/Controllers/ProductController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) throw new Error(`Request failed with status ${response.status}`);

            const data = await response.json();

            if (data.success) {
                $('#quantity_on_hand').val(data.quantityOnHand || 0);

                calculateInventoryDifference(data.quantityOnHand, inventoryCount);
            } 
            else if (data.notExist) {
                setNotification(data.title, data.message, data.message_type);
                window.location = page_link;
            } 
            else {
                showNotification(data.title, data.message, data.message_type);
            }
        } catch (error) {
            handleSystemError(error, 'fetch_failed', `Failed to fetch product details: ${error.message}`);
        }
    }

    $('#physical_inventory_form').validate({
        rules: {
            product_id: { required: true },
            inventory_date: { required: true }
        },
        messages: {
            product_id: { required: 'Choose the product' },
            inventory_date: { required: 'Choose the inventory date' }
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

            const transaction   = 'insert physical inventory';
            const page_link     = document.getElementById('page-link').getAttribute('href') || 'apps.php';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);

            disableButton('submit-data');

            try {
                const response = await fetch('./app/Controllers/PhysicalInventoryController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save physical inventory failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location = `${page_link}&id=${data.physical_inventory_id}`;
                }
                else if(data.invalid_session){
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else{
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-data');
                }
            } catch (error) {
                enableButton('submit-data');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $(document).on('select2:select select2:clear', '#product_id', function () {
        displayDetails();
    });

    const calculateInventoryDifference = (quantityOnHand, inventoryCount, decimals = 4) => {
        const toNumber = (v) => {
            if (v === null || v === undefined || v === "") return 0;
            const n = typeof v === "number" ? v : Number(v);
            return Number.isFinite(n) ? n : NaN;
        };

        const qoh = toNumber(quantityOnHand);
        const ic = toNumber(inventoryCount);

        if (!Number.isFinite(qoh) || !Number.isFinite(ic)) return 0;

        const diff = ic - qoh;

        const factor = 10 ** decimals;

        const inventoryDiffEl = document.querySelector("#inventory_difference");

        inventoryDiffEl.value = Math.round((diff + Number.EPSILON) * factor) / factor;
    };

    document.addEventListener("change", async (event) => {
        if (!event.target.matches("#inventory_count, #quantity_on_hand")) return;

        const quantityOnHandEl = document.querySelector("#quantity_on_hand");
        const inventoryCountEl = document.querySelector("#inventory_count");

        const quantityOnHand = quantityOnHandEl?.value ?? 0;
        const inventoryCount = inventoryCountEl?.value ?? 0;

        calculateInventoryDifference(quantityOnHand, inventoryCount);        
    });
});
