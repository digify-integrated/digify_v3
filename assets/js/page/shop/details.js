import { disableButton, enableButton, generateDropdownOptions, generateDualListBox, resetForm } from '../../utilities/form-utilities.js';
import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { attachLogNotesHandler, attachLogNotesClassHandler  } from '../../utilities/log-notes.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    const page_link = document.getElementById('page-link')?.getAttribute('href') || 'apps.php';
    const shop_id   = document.getElementById('details-id')?.textContent.trim();
    
    const displayDetails = async () => {
        const transaction = 'fetch shop details';

        try {
            resetForm('shop_form');

            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('shop_id', shop_id);

            const response = await fetch('./app/Controllers/ShopController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

            const data = await response.json();

            if (data.success) {
                document.getElementById('shop_name').value      = data.shopName || '';
                document.getElementById('shop').textContent     = data.shopName || '';
                document.getElementById('company').textContent  = data.companyName || '';

                $('#company_id').val(data.companyId || '').trigger('change');
                $('#shop_type_id').val(data.shopTypeId || '').trigger('change');
            } 
            else if (data.notExist) {
                setNotification(data.title, data.message, data.message_type);
                window.location = page_link;
            }
            else {
                showNotification(data.title, data.message, data.message_type);
            }
        } catch (error) {
            handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
        }
    };

    (async () => {
        const dropdownConfigs = [
            { url: './app/Controllers/CompanyController.php', selector: '#company_id', transaction: 'generate company options' },
            { url: './app/Controllers/ShopTypeController.php', selector: '#shop_type_id', transaction: 'generate shop type options' }
        ];
        
        for (const cfg of dropdownConfigs) {
            await generateDropdownOptions({
                url: cfg.url,
                dropdownSelector: cfg.selector,
                data: { 
                    transaction: cfg.transaction, 
                    ...(cfg.extraData || {})
                }
            });
        }

        await displayDetails();
    })();

    initializeDatatable({
        selector: '#shop-payment-method-table',
        ajaxUrl: './app/Controllers/ShopController.php',
        transaction: 'generate shop payment method table',
        ajaxData: {
            shop_id: shop_id
        },
        columns: [
            { data: 'PAYMENT_METHOD' },
            { data: 'ACTION' }
        ],
        columnDefs: [
            { width: 'auto', targets: 0, responsivePriority: 1 },
            { width: 'auto', bSortable: false, targets: 1, responsivePriority: 2 }
        ],
        order : [[0, 'asc']]
    });

    initializeDatatable({
        selector: '#shop-floor-plan-table',
        ajaxUrl: './app/Controllers/ShopController.php',
        transaction: 'generate shop floor plan table',
        ajaxData: {
            shop_id: shop_id
        },
        columns: [
            { data: 'FLOOR_PLAN_NAME' },
            { data: 'TABLES' },
            { data: 'SEATS' },
            { data: 'ACTION' }
        ],
        columnDefs: [
            { width: 'auto', targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 },
            { width: 'auto', targets: 2, responsivePriority: 3 },
            { width: 'auto', bSortable: false, targets: 3, responsivePriority: 4 }
        ],
        order : [[0, 'asc']]
    });

    initializeDatatable({
        selector: '#shop-access-table',
        ajaxUrl: './app/Controllers/ShopController.php',
        transaction: 'generate shop access table',
        ajaxData: {
            shop_id: shop_id
        },
        columns: [
            { data: 'USER_ACCOUNT' },
            { data: 'ACTION' }
        ],
        columnDefs: [
            { width: 'auto', targets: 0, responsivePriority: 1 },
            { width: 'auto', bSortable: false, targets: 1, responsivePriority: 2 }
        ],
        order : [[0, 'asc']]
    });

    initializeDatatable({
        selector: '#shop-product-table',
        ajaxUrl: './app/Controllers/ShopController.php',
        transaction: 'generate shop product table',
        ajaxData: {
            shop_id: shop_id
        },
        columns: [
            { data: 'PRODUCT' },
            { data: 'QUANTITY' },
            { data: 'SALES_PRICE' },
            { data: 'COST' },
            { data: 'ACTION' }
        ],
        columnDefs: [
            { width: 'auto', targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 },
            { width: 'auto', targets: 2, responsivePriority: 3 },
            { width: 'auto', targets: 3, responsivePriority: 4 },
            { width: 'auto', bSortable: false, targets: 4, responsivePriority: 5 }
        ],
        order : [[0, 'asc']]
    });

    attachLogNotesHandler('#log-notes-main', '#details-id', 'shop');
    
    $('#shop_form').validate({
        rules: {
            shop_name: { required: true },
            company_id: { required: true },
            shop_type_id: { required: true }
        },
        messages: {
            shop_name: { required: 'Enter the display name' },
            company_id: { required: 'Choose the company' },
            shop_type_id: { required: 'Choose the shop type' }
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
            const $element  = $(element);
            const $target   = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.removeClass('is-invalid');
        },
        submitHandler: async (form, event) => {
            event.preventDefault();

            const transaction = 'save shop';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('shop_id', shop_id);

            disableButton('submit-data');

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
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-data');
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
    
    document.addEventListener('click', async (event) => {
        if (event.target.closest('#delete-shop')){
            const transaction = 'delete shop';

            if (!shop_id) {
                showNotification('Error', 'Shop ID not found', 'error');
                return;
            }

            const result = await Swal.fire({
                title: 'Confirm Shop Deletion',
                text: 'Are you sure you want to delete this shop?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Delete',
                cancelButtonText: 'Cancel',
                customClass: {
                    confirmButton: 'btn btn-danger mt-2',
                    cancelButton: 'btn btn-secondary ms-2 mt-2'
                },
                buttonsStyling: false
            });

            if (result.value) {
                try {
                    const formData = new URLSearchParams();
                    formData.append('transaction', transaction);
                    formData.append('shop_id', shop_id);

                    const response = await fetch('./app/Controllers/ShopController.php', {
                        method: 'POST',
                        body: formData
                    });

                    if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                    const data = await response.json();

                    if (data.success) {
                        setNotification(data.title, data.message, data.message_type);
                        window.location = page_link;
                    }
                    else if (data.invalid_session) {
                        setNotification(data.title, data.message, data.message_type);
                        window.location.href = data.redirect_link;
                    }
                    else {
                        showNotification(data.title, data.message, data.message_type);
                    }
                } catch (error) {
                    handleSystemError(error, 'fetch_failed', `Failed to delete shop: ${error.message}`);
                }
            }
        }
    });
});