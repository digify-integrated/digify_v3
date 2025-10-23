import { disableButton, enableButton, generateDropdownOptions, resetForm, initializeDatePicker } from '../../utilities/form-utilities.js';
import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { attachLogNotesHandler, attachLogNotesClassHandler } from '../../utilities/log-notes.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    const page_link     = document.getElementById('page-link').getAttribute('href') || 'apps.php';
    const product_id    = document.getElementById('details-id')?.textContent.trim() || '';
    const page_id       = document.getElementById('page-id')?.value || '';

    const displayDetails = async () => {
        const transaction = 'fetch product details';

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
                $('#product_name').val(data.productName || '');
                $('#product_description').val(data.productDescription || '');
                $('#sales_price').val(data.salesPrice || 0);
                $('#discount_rate').val(data.discountRate || 0);
                $('#sku').val(data.sku || '');
                $('#barcode').val(data.barcode || '');
                $('#quantity_on_hand').val(data.quantityOnHand || 0);
                $('#weight').val(data.weight || 0);
                $('#width').val(data.width || 0);
                $('#height').val(data.height || 0);
                $('#length').val(data.length || 0);

                $('#product_type').val(data.productType || '').trigger('change');

                document.getElementById('is-sellable').checked = data.isSellable === 'Yes';
                document.getElementById('is-purchasable').checked = data.isPurchasable === 'Yes';
                document.getElementById('show-on-pos').checked = data.showOnPos === 'Yes';
                
                document.getElementById('product_image_thumbnail').style.backgroundImage = `url(${data.productImage})`;

                if (data.discountType) {
                    document.querySelectorAll('[data-kt-button="true"]').forEach(label => {
                        label.classList.remove('active');
                    });

                    const radio = document.querySelector(`input[name="discount_option"][value="${data.discountType}"]`);

                    if (radio) {
                        radio.checked = true;
                        radio.closest('label')?.classList.add('active');
                    }
                    else {
                        const defaultRadio = document.querySelector('input[name="discount_option"][value="None"]');
                        if (defaultRadio) {
                            defaultRadio.checked = true;
                            defaultRadio.closest('label')?.classList.add('active');
                        }
                    }
                }

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

    const displayProductCategoriesDetails = async () => {
        const transaction = 'fetch product categories details';

        try {
            resetForm('product_category_form');
            
            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('product_id', product_id);

            const response = await fetch('./app/Controllers/ProductController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`Request failed with status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success) {
               $('#product_category_id').val(data.productCategories || '').trigger('change');
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
    };

    (async () => {
        const dropdownConfigs = [
            { url: './app/Controllers/ProductCategoryController.php', selector: '#product_category_id', transaction: 'generate product category options' },
            { url: './app/Controllers/TaxController.php', selector: '#sales_tax_id', transaction: 'generate sales tax options' },
            { url: './app/Controllers/TaxController.php', selector: '#purchase_tax_id', transaction: 'generate purchase tax options' },
        ];
            
        for (const cfg of dropdownConfigs) {
            await generateDropdownOptions({
                url: cfg.url,
                dropdownSelector: cfg.selector,
                data: { transaction: cfg.transaction, multiple: true }
            });
        }
    
        await displayDetails();
        await displayProductCategoriesDetails();
    })();

    $('#product_category_form').validate({
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

            const transaction = 'save product category';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('product_id', product_id);

            disableButton('submit-product-category');

            try {
                const response = await fetch('./app/Controllers/ProductController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save product category failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-product-category');
                }
                else if(data.invalid_session){
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else{
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-product-category');
                }
            } catch (error) {
                enableButton('submit-product-category');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#product_general_form').validate({
        rules: {
            product_name: { required: true }
        },
        messages: {
            product_name: { required: 'Enter the product name' }
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

            const transaction = 'update product general';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('product_id', product_id);

            disableButton('submit-general');

            try {
                const response = await fetch('./app/Controllers/ProductController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-general');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-general');
                }
            } catch (error) {
                enableButton('submit-general');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#product_inventory_form').validate({
        rules: {
            sku: { required: true },
            barcode: { required: true },
            product_type: { required: true },
            quantity_on_hand: { required: true },
        },
        messages: {
            sku: { required: 'Enter the SKU' },
            barcode: { required: 'Enter the barcode' },
            product_type: { required: 'Choose the product type' },
            quantity_on_hand: { required: 'Enter the quantity on hand' },
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

            const transaction = 'update product inventory';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('product_id', product_id);

            disableButton('submit-inventory');

            try {
                const response = await fetch('./app/Controllers/ProductController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-inventory');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-inventory');
                }
            } catch (error) {
                enableButton('submit-inventory');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#product_shipping_form').validate({
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

            const transaction = 'update product shipping';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('product_id', product_id);

            disableButton('submit-shipping');

            try {
                const response = await fetch('./app/Controllers/ProductController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-shipping');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-shipping');
                }
            } catch (error) {
                enableButton('submit-shipping');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    document.addEventListener('click', async (event) => {    
        if (event.target.closest('#is-sellable')){
            const transaction = 'update product is sellable';
    
            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('product_id', product_id);
    
            try {
                const response = await fetch('./app/Controllers/ProductController.php', {
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
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }
        }

        if (event.target.closest('#is-purchasable')){
            const transaction = 'update product is purchasable';
    
            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('product_id', product_id);
    
            try {
                const response = await fetch('./app/Controllers/ProductController.php', {
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
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }
        }

        if (event.target.closest('#show-on-pos')){
            const transaction = 'update product show on pos';
    
            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('product_id', product_id);
    
            try {
                const response = await fetch('./app/Controllers/ProductController.php', {
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
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }
        }
    });

    document.addEventListener('change', async (event) => {
        const input = event.target.closest('#product_image');
        if (!input || !input.files.length) return;

        const transaction = 'update product image';

        const formData = new FormData();
        formData.append('transaction', transaction);
        formData.append('product_id', product_id);
        formData.append('product_image', input.files[0]);

        try {
            const response = await fetch('./app/Controllers/ProductController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

            const data = await response.json();

            if (data.success) {
                showNotification(data.title, data.message, data.message_type);
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
});