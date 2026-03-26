import { disableButton, enableButton } from '../../utilities/form-utilities.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {    
    $('#discount_type_form').validate({
        rules: {
            discount_type_name: { required: true },
            value_type: { required: true },
            discount_value: {  
                required: function() {
                    return $('#value_type').val() != '';
                },
                number: true,
                maxPercentage: true 
            },
            is_variable: { required: true },
            application_order: { required: true },
            is_vat_exempt: { required: true },
        },
        messages: {
            discount_type_name: { required: 'Enter the display name' },
            value_type: { required: 'Choose the value type' },
            discount_value: {
                required: 'Enter discount value',
                number: 'Please enter a valid number'
            },
            is_variable: { required: 'Choose is variable' },
            application_order: { required: 'Choose is variable' },
            is_vat_exempt: { required: 'Choose affects tax' }
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

            const transaction   = 'save discount type';
            const page_link     = document.getElementById('page-link').getAttribute('href') || 'apps.php';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);

            disableButton('submit-data');

            try {
                const response = await fetch('./app/Controllers/DiscountTypeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save discount type failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location = `${page_link}&id=${data.discount_type_id}`;
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

    $('#is_variable').on('change', function () {
        const isYes = $(this).val() === 'Yes';
        const $discountInput = $('#discount_value');

        if (isYes) $discountInput.val(0);
        
        $discountInput.prop('readonly', isYes);
    });

    $.validator.addMethod("maxPercentage", function(value, element) {
        let discountType = $('#value_type').val();

        if (discountType === 'Percentage') {
            return parseFloat(value) <= 100;
        }
        return true;
    }, "Percentage discount cannot exceed 100%");
});
