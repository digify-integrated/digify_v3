import { disableButton, enableButton, generateDropdownOptions, generateDualListBox, resetForm } from '../../utilities/form-utilities.js';
import { initializeDatatable, initializeSubDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
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

    const paymentMethodDropdown = async () => {
        await generateDropdownOptions({
            url: './app/Controllers/PaymentMethodController.php',
            dropdownSelector: '#payment_method_id',
            data: { 
                transaction: 'generate shop payment method options', 
                multiple: true,
                shop_id: shop_id
            }
        });
    };

    const floorPlanDropdown = async () => {
        await generateDropdownOptions({
            url: './app/Controllers/FloorPlanController.php',
            dropdownSelector: '#floor_plan_id',
            data: { 
                transaction: 'generate shop floor plan options', 
                multiple: true,
                shop_id: shop_id
            }
        });
    };

    const userAccountDropdown = async () => {
        await generateDropdownOptions({
            url: './app/Controllers/UserAccountController.php',
            dropdownSelector: '#user_account_id',
            data: { 
                transaction: 'generate shop user account options', 
                multiple: true,
                shop_id: shop_id
            }
        });
    };

    const productDropdown = async () => {
        await generateDropdownOptions({
            url: './app/Controllers/ProductController.php',
            dropdownSelector: '#product_id',
            data: { 
                transaction: 'generate shop product options', 
                multiple: true,
                shop_id: shop_id
            }
        });
    };

    const discountsDropdown = async () => {
        await generateDropdownOptions({
            url: './app/Controllers/DiscountTypeController.php',
            dropdownSelector: '#discount_type_id',
            data: { 
                transaction: 'generate shop discount type options', 
                multiple: true,
                shop_id: shop_id
            }
        });
    };

    const chargesDropdown = async () => {
        await generateDropdownOptions({
            url: './app/Controllers/ChargeTypeController.php',
            dropdownSelector: '#charge_type_id',
            data: { 
                transaction: 'generate shop charge type options', 
                multiple: true,
                shop_id: shop_id
            }
        });
    };

    (async () => {
        const dropdownConfigs = [
            { url: './app/Controllers/CompanyController.php', selector: '#company_id', transaction: 'generate company options' },
            { url: './app/Controllers/ShopTypeController.php', selector: '#shop_type_id', transaction: 'generate shop type options' },
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

    initializeDatatable({
        selector: '#shop-discounts-table',
        ajaxUrl: './app/Controllers/ShopController.php',
        transaction: 'generate shop discounts table',
        ajaxData: {
            shop_id: shop_id
        },
        columns: [
            { data: 'DISCOUNT' },
            { data: 'VALUE_TYPE' },
            { data: 'DISCOUNT_VALUE' },
            { data: 'AUTOMATIC_APPLICATION' },
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

    initializeDatatable({
        selector: '#shop-charges-table',
        ajaxUrl: './app/Controllers/ShopController.php',
        transaction: 'generate shop charges table',
        ajaxData: {
            shop_id: shop_id
        },
        columns: [
            { data: 'CHARGES' },
            { data: 'VALUE_TYPE' },
            { data: 'CHARGE_VALUE' },
            { data: 'AUTOMATIC_APPLICATION' },
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

    initializeSubDatatableControls('#shop-payment-method-datatable-search', '#shop-payment-method-datatable-length', '#shop-payment-method-table');
    initializeSubDatatableControls('#shop-floor-plan-datatable-search', '#shop-floor-plan-datatable-length', '#shop-floor-plan-table');
    initializeSubDatatableControls('#shop-access-datatable-search', '#shop-access-datatable-length', '#shop-access-table');
    initializeSubDatatableControls('#shop-product-datatable-search', '#shop-product-datatable-length', '#shop-product-table');
    initializeSubDatatableControls('#shop-discounts-datatable-search', '#shop-discounts-datatable-length', '#shop-discounts-table');
    initializeSubDatatableControls('#shop-charges-datatable-search', '#shop-charges-datatable-length', '#shop-charges-table');
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

    $('#shop_payment_method_form').validate({
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

            const transaction = 'save shop payment method';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('shop_id', shop_id);

            disableButton('submit-shop-payment-method');

            try {
                const response = await fetch('./app/Controllers/ShopController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save shop payment method failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-shop-payment-method');
                    reloadDatatable('#shop-payment-method-table');
                    $('#shop-payment-method-modal').modal('hide');
                    resetForm('shop_payment_method_form');
                }
                else if(data.invalid_session){
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else{
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-shop-payment-method');
                }
            } catch (error) {
                enableButton('submit-shop-payment-method');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#shop_floor_plan_form').validate({
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

            const transaction = 'save shop floor plan';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('shop_id', shop_id);

            disableButton('submit-shop-floor-plan');

            try {
                const response = await fetch('./app/Controllers/ShopController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save shop floor plan failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-shop-floor-plan');
                    reloadDatatable('#shop-floor-plan-table');
                    $('#shop-floor-plan-modal').modal('hide');
                    resetForm('shop_floor_plan_form');
                }
                else if(data.invalid_session){
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else{
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-shop-floor-plan');
                }
            } catch (error) {
                enableButton('submit-shop-floor-plan');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#shop_access_form').validate({
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

            const transaction = 'save shop access';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('shop_id', shop_id);

            disableButton('submit-shop-access');

            try {
                const response = await fetch('./app/Controllers/ShopController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save shop access failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-shop-access');
                    reloadDatatable('#shop-access-table');
                    $('#shop-access-modal').modal('hide');
                    resetForm('shop_access_form');
                }
                else if(data.invalid_session){
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else{
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-shop-access');
                }
            } catch (error) {
                enableButton('submit-shop-access');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#shop_product_form').validate({
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

            const transaction = 'save shop product';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('shop_id', shop_id);

            disableButton('submit-shop-product');

            try {
                const response = await fetch('./app/Controllers/ShopController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save shop product failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-shop-product');
                    reloadDatatable('#shop-product-table');
                    $('#shop-product-modal').modal('hide');
                    resetForm('shop_product_form');
                }
                else if(data.invalid_session){
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else{
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-shop-product');
                }
            } catch (error) {
                enableButton('submit-shop-product');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#shop_discounts_form').validate({
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

            const transaction = 'save shop discounts';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('shop_id', shop_id);

            disableButton('submit-shop-discounts');

            try {
                const response = await fetch('./app/Controllers/ShopController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save shop discounts failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-shop-discounts');
                    reloadDatatable('#shop-discounts-table');
                    $('#shop-discounts-modal').modal('hide');
                    resetForm('shop_discounts_form');
                }
                else if(data.invalid_session){
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else{
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-shop-discounts');
                }
            } catch (error) {
                enableButton('submit-shop-discounts');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#shop_charges_form').validate({
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

            const transaction = 'save shop charges';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('shop_id', shop_id);

            disableButton('submit-shop-charges');

            try {
                const response = await fetch('./app/Controllers/ShopController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save shop charges failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-shop-charges');
                    reloadDatatable('#shop-charges-table');
                    $('#shop-charges-modal').modal('hide');
                    resetForm('shop_charges_form');
                }
                else if(data.invalid_session){
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else{
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-shop-charges');
                }
            } catch (error) {
                enableButton('submit-shop-charges');
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

        if (event.target.closest('#archive-shop')){
            const transaction = 'update shop archive';

            Swal.fire({
                title: 'Confirm Shop Archive',
                text: 'Are you sure you want to archive this shop?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Archive',
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
                formData.append('shop_id', shop_id);

                try {
                    const response = await fetch('./app/Controllers/ShopController.php', {
                        method: 'POST',
                        body: formData
                    });

                    if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                    const data = await response.json();

                    if (data.success) {
                        setNotification(data.title, data.message, data.message_type);
                        window.location.reload();
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

        if (event.target.closest('#unarchive-shop')){
            const transaction = 'update shop unarchive';

            Swal.fire({
                title: 'Confirm Shop Unarchive',
                text: 'Are you sure you want to unarchive this shop?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Unarchive',
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
                formData.append('shop_id', shop_id);

                try {
                    const response = await fetch('./app/Controllers/ShopController.php', {
                        method: 'POST',
                        body: formData
                    });

                    if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                    const data = await response.json();

                    if (data.success) {
                        setNotification(data.title, data.message, data.message_type);
                        window.location.reload();
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

        if (event.target.closest('#add-shop-payment-method')){
            await paymentMethodDropdown();
        }

        if (event.target.closest('.view-shop-payment-method-log-notes')){
            const button                    = event.target.closest('.view-shop-payment-method-log-notes');
            const shop_payment_method_id    = button.dataset.shopPaymentMethodId;
        
            attachLogNotesClassHandler('shop_payment_method', shop_payment_method_id);
        }
        
        if (event.target.closest('.delete-shop-payment-method')){
            const transaction               = 'delete shop payment method';
            const button                    = event.target.closest('.delete-shop-payment-method');
            const shop_payment_method_id    = button.dataset.shopPaymentMethodId;
        
            Swal.fire({
                title: 'Confirm Payment Method Deletion',
                text: 'Are you sure you want to delete this payment method?',
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
                formData.append('shop_payment_method_id', shop_payment_method_id);
        
                try {
                    const response = await fetch('./app/Controllers/ShopController.php', {
                        method: 'POST',
                        body: formData
                    });
        
                    if (!response.ok) throw new Error(`Request failed: ${response.status}`);
        
                    const data = await response.json();
        
                    if (data.success) {
                        showNotification(data.title, data.message, data.message_type);
                        reloadDatatable('#shop-payment-method-table');
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

        if (event.target.closest('#add-shop-floor-plan')){
            await floorPlanDropdown();
        }

        if (event.target.closest('.view-shop-floor-plan-log-notes')){
            const button                = event.target.closest('.view-shop-floor-plan-log-notes');
            const shop_floor_plan_id    = button.dataset.shopFloorPlanId;
        
            attachLogNotesClassHandler('shop_floor_plan', shop_floor_plan_id);
        }
        
        if (event.target.closest('.delete-shop-floor-plan')){
            const transaction           = 'delete shop floor plan';
            const button                = event.target.closest('.delete-shop-floor-plan');
            const shop_floor_plan_id    = button.dataset.shopFloorPlanId;
        
            Swal.fire({
                title: 'Confirm Floor Plan Deletion',
                text: 'Are you sure you want to delete this floor plan?',
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
                formData.append('shop_floor_plan_id', shop_floor_plan_id);
        
                try {
                    const response = await fetch('./app/Controllers/ShopController.php', {
                        method: 'POST',
                        body: formData
                    });
        
                    if (!response.ok) throw new Error(`Request failed: ${response.status}`);
        
                    const data = await response.json();
        
                    if (data.success) {
                        showNotification(data.title, data.message, data.message_type);
                        reloadDatatable('#shop-floor-plan-table');
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

        if (event.target.closest('#add-shop-access')){
            await userAccountDropdown();
        }

        if (event.target.closest('.view-shop-access-log-notes')){
            const button            = event.target.closest('.view-shop-access-log-notes');
            const shop_access_id    = button.dataset.shopAccessId;
        
            attachLogNotesClassHandler('shop_access', shop_access_id);
        }
        
        if (event.target.closest('.delete-shop-access')){
            const transaction       = 'delete shop access';
            const button            = event.target.closest('.delete-shop-access');
            const shop_access_id    = button.dataset.shopAccessId;
        
            Swal.fire({
                title: 'Confirm Access Deletion',
                text: 'Are you sure you want to delete this access?',
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
                formData.append('shop_access_id', shop_access_id);
        
                try {
                    const response = await fetch('./app/Controllers/ShopController.php', {
                        method: 'POST',
                        body: formData
                    });
        
                    if (!response.ok) throw new Error(`Request failed: ${response.status}`);
        
                    const data = await response.json();
        
                    if (data.success) {
                        showNotification(data.title, data.message, data.message_type);
                        reloadDatatable('#shop-access-table');
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

        if (event.target.closest('#add-shop-product')){
            await productDropdown();
        }

        if (event.target.closest('.view-shop-product-log-notes')){
            const button            = event.target.closest('.view-shop-product-log-notes');
            const shop_product_id   = button.dataset.shopProductId;
        
            attachLogNotesClassHandler('shop_product', shop_product_id);
        }
        
        if (event.target.closest('.delete-shop-product')){
            const transaction       = 'delete shop product';
            const button            = event.target.closest('.delete-shop-product');
            const shop_product_id    = button.dataset.shopProductId;
        
            Swal.fire({
                title: 'Confirm Product Deletion',
                text: 'Are you sure you want to delete this product?',
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
                formData.append('shop_product_id', shop_product_id);
        
                try {
                    const response = await fetch('./app/Controllers/ShopController.php', {
                        method: 'POST',
                        body: formData
                    });
        
                    if (!response.ok) throw new Error(`Request failed: ${response.status}`);
        
                    const data = await response.json();
        
                    if (data.success) {
                        showNotification(data.title, data.message, data.message_type);
                        reloadDatatable('#shop-product-table');
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

        if (event.target.closest('#add-shop-discounts')){
            await discountsDropdown();
        }

        if (event.target.closest('.view-shop-discounts-log-notes')){
            const button            = event.target.closest('.view-shop-discounts-log-notes');
            const shop_discounts_id = button.dataset.shopDiscountsId;
        
            attachLogNotesClassHandler('shop_discounts', shop_discounts_id);
        }

        if (event.target.closest('.delete-shop-discounts')){
            const transaction       = 'delete shop discounts';
            const button            = event.target.closest('.delete-shop-discounts');
            const shop_discounts_id = button.dataset.shopDiscountsId;
        
            Swal.fire({
                title: 'Confirm Discount Deletion',
                text: 'Are you sure you want to delete this discount?',
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
                formData.append('shop_discounts_id', shop_discounts_id);
        
                try {
                    const response = await fetch('./app/Controllers/ShopController.php', {
                        method: 'POST',
                        body: formData
                    });
        
                    if (!response.ok) throw new Error(`Request failed: ${response.status}`);
        
                    const data = await response.json();
        
                    if (data.success) {
                        showNotification(data.title, data.message, data.message_type);
                        reloadDatatable('#shop-discounts-table');
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

        if (event.target.closest('#add-shop-charges')){
            await chargesDropdown();
        }        

        if (event.target.closest('.view-shop-charges-log-notes')){
            const button            = event.target.closest('.view-shop-charges-log-notes');
            const shop_charges_id = button.dataset.shopChargesId;
        
            attachLogNotesClassHandler('shop_charges', shop_charges_id);
        }

        if (event.target.closest('.delete-shop-charges')){
            const transaction       = 'delete shop charges';
            const button            = event.target.closest('.delete-shop-charges');
            const shop_charges_id   = button.dataset.shopChargesId;
        
            Swal.fire({
                title: 'Confirm Charge Deletion',
                text: 'Are you sure you want to delete this charge?',
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
                formData.append('shop_charges_id', shop_charges_id);
        
                try {
                    const response = await fetch('./app/Controllers/ShopController.php', {
                        method: 'POST',
                        body: formData
                    });
        
                    if (!response.ok) throw new Error(`Request failed: ${response.status}`);
        
                    const data = await response.json();
        
                    if (data.success) {
                        showNotification(data.title, data.message, data.message_type);
                        reloadDatatable('#shop-charges-table');
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

        if (event.target.closest('.update-discount-application')){
            const transaction           = 'update shop discount application';
            const button                = event.target.closest('.update-discount-application');
            const shop_discounts_id     = button.dataset.shopDiscountsId;
            const automatic_application = button.checked ? 'Yes' : 'No';

            try {
                const formData = new URLSearchParams();
                formData.append('transaction', transaction);
                formData.append('shop_discounts_id', shop_discounts_id);
                formData.append('automatic_application', automatic_application);

                const response = await fetch('./app/Controllers/ShopController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed: ${response.status}`);

                const data = await response.json();

                if (!data.success) {
                    if (data.invalid_session) {
                        setNotification(data.title, data.message, data.message_type);
                        window.location.href = data.redirect_link;
                    }
                    else {
                        showNotification(data.title, data.message, data.message_type);
                    }
                }
            } catch (error) {
                handleSystemError(error, 'fetch_failed', `Update shop discount application failed: ${error.message}`);
            }
        }

        if (event.target.closest('.update-charge-application')){
            const transaction           = 'update shop charge application';
            const button                = event.target.closest('.update-charge-application');
            const shop_charges_id       = button.dataset.shopChargesId;
            const automatic_application = button.checked ? 'Yes' : 'No';

            try {
                const formData = new URLSearchParams();
                formData.append('transaction', transaction);
                formData.append('shop_charges_id', shop_charges_id);
                formData.append('automatic_application', automatic_application);

                const response = await fetch('./app/Controllers/ShopController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed: ${response.status}`);

                const data = await response.json();

                if (!data.success) {
                    if (data.invalid_session) {
                        setNotification(data.title, data.message, data.message_type);
                        window.location.href = data.redirect_link;
                    }
                    else {
                        showNotification(data.title, data.message, data.message_type);
                    }
                }
            } catch (error) {
                handleSystemError(error, 'fetch_failed', `Update shop discount application failed: ${error.message}`);
            }
        }
    });
});