import { disableButton, enableButton, generateDropdownOptions, initializeDatePicker } from '../../utilities/form-utilities.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    generateDropdownOptions({
        url: './app/Controllers/ProductController.php',
        dropdownSelector: '#product_id',
        data: { transaction: 'generate active product options' }
    });

    generateDropdownOptions({
        url: './app/Controllers/ScrapReasonController.php',
        dropdownSelector: '#scrap_reason_id',
        data: { transaction: 'generate scrap reason options' }
    });

    initializeDatePicker('#inventory_date');

    const displayDetails = async () => {
        const product_id = document.querySelector("#product_id").value;
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

    $('#scrap_form').validate({
        rules: {
            product_id: { required: true },
            reference_number: { required: true },
            scrap_quantity: { required: true },
            scrap_reason_id: { required: true },
        },
        messages: {
            product_id: { required: 'Choose the product' },
            reference_number: { required: 'Enter the reference number' },
            scrap_quantity: { required: 'Enter the scrap quantity' },
            scrap_reason_id: { required: 'Choose the scrap reason' },
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

            const transaction   = 'insert scrap';
            const page_link     = document.getElementById('page-link').getAttribute('href') || 'apps.php';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);

            disableButton('submit-data');

            try {
                const response = await fetch('./app/Controllers/ScrapController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save scrap failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location = `${page_link}&id=${data.scrap_id}`;
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
});
