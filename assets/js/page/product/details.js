import { disableButton, enableButton, generateDropdownOptions, generateDualListBox, resetForm } from '../../utilities/form-utilities.js';
import { attachLogNotesHandler  } from '../../utilities/log-notes.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    const page_link     = document.getElementById('page-link')?.getAttribute('href') || 'apps.php';
    const product_id    = document.getElementById('details-id')?.textContent.trim();
    
    const displayDetails = async () => {
        const transaction = 'fetch product details';

        try {
            resetForm('product_form');

            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('product_id', product_id);

            const response = await fetch('./app/Controllers/ProductController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

            const data = await response.json();

            if (data.success) {
                document.getElementById('product_name').value   = data.productName || '';
                document.getElementById('barcode').value        = data.barcode || '';
                document.getElementById('quantity').value       = data.quantity || '';
                document.getElementById('sales_price').value    = data.salesPrice || '';
                document.getElementById('cost').value           = data.cost || '';

                $('#product_type_id').val(data.productTypeId || '').trigger('change');
                $('#product_category_id').val(data.productCategoryId || '').trigger('change');

                const thumbnail = document.getElementById('product_image_thumbnail');
                if (thumbnail) thumbnail.style.backgroundImage = `url(${data.productImage || ''})`;
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
            { url: './app/Controllers/ProductTypeController.php', selector: '#product_type_id', transaction: 'generate product type options' },
            { url: './app/Controllers/ProductCategoryController.php', selector: '#product_category_id', transaction: 'generate product category options' }
        ];
        
        for (const cfg of dropdownConfigs) {
            await generateDropdownOptions({
                url: cfg.url,
                dropdownSelector: cfg.selector,
                data: { transaction: cfg.transaction }
            });
        }

        await displayDetails();
    })();

    attachLogNotesHandler('#log-notes-main', '#details-id', 'product');
    
    $('#product_form').validate({
        rules: {
            product_name: { required: true },
            product_type_id: { required: true },
            product_category_id: { required: true },
            quantity: { required: true },
            sales_price: { required: true },
            cost: { required: true }
        },
        messages: {
            product_name: { required: 'Enter the product name' },
            product_type_id: { required: 'Choose the product type' },
            product_category_id: { required: 'Choose the product category' },
            quantity: { required: 'Enter the quantity on-hand' },
            sales_price: { required: 'Enter the sales price' },
            cost: { required: 'Enter the cost' }
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

            const transaction = 'save product';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('product_id', product_id);

            disableButton('submit-data');

            try {
                const response = await fetch('./app/Controllers/ProductController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save product failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-data');
                    displayDetails();
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
        if (event.target.closest('#delete-product')){
            const transaction = 'delete product';

            const result = await Swal.fire({
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
            });

            if (result.value) {
                try {
                    const formData = new URLSearchParams();
                    formData.append('transaction', transaction);
                    formData.append('product_id', product_id);

                    const response = await fetch('./app/Controllers/ProductController.php', {
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
                    handleSystemError(error, 'fetch_failed', `Failed to delete product: ${error.message}`);
                }
            }
        }
    });

    document.addEventListener('change', async (event) => {
        if (!event.target.closest('#product_image')) return;
    
        const input = event.target;
        if (input.files && input.files.length > 0) {
            const transaction = 'update product image';
    
            if (!product_id) {
                showNotification('Error', 'Product not found', 'error');
                return;
            }
    
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
        }
    });
});