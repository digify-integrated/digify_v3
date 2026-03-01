import { disableButton, enableButton, generateDropdownOptions } from '../../utilities/form-utilities.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    const dropdownConfigs = [
        { url: './app/Controllers/CompanyController.php', selector: '#company_id', transaction: 'generate company options' },
        { url: './app/Controllers/ShopTypeController.php', selector: '#shop_type_id', transaction: 'generate shop type options' }
    ];
    
    dropdownConfigs.forEach(cfg => {
        generateDropdownOptions({
            url: cfg.url,
            dropdownSelector: cfg.selector,
            data: { transaction: cfg.transaction }
        });
    });
    
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
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.removeClass('is-invalid');
        },
        submitHandler: async (form, event) => {
            event.preventDefault();

            const transaction   = 'save shop';
            const page_link     = document.getElementById('page-link').getAttribute('href') || 'apps.php';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);

            disableButton('submit-data');

            try {
                const response = await fetch('./app/Controllers/MenuItemController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save shop failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location = `${page_link}&id=${data.shop_id}`;
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
});
