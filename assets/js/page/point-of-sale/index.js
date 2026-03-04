import { disableButton, enableButton } from '../../utilities/form-utilities.js';
import { showNotification, setNotification } from '../../modules/notifications.js';
import { handleSystemError } from '../../modules/system-errors.js';

document.addEventListener('DOMContentLoaded', () => {
    const DENOMS_CENTAVOS = new Map([
        ["open_1000", 100000],
        ["open_500",   50000],
        ["open_200",   20000],
        ["open_100",   10000],
        ["open_50",     5000],
        ["open_20",     2000],
        ["open_10",     1000],
        ["open_5",       500],
        ["open_1",       100],
        ["open_0_50",     50],
        ["open_0_25",     25],
        ["open_0_10",     10],
        ["open_0_05",      5],
        ["open_0_01",      1],
    ]);

    const form = document.getElementById('open_register_form');
    if (!form) return;

    const totalEl = form.querySelector('#open_total');
    if (!totalEl) return;

    const toCount = (value) => {
        const n = Number.parseInt(String(value ?? '').trim(), 10);
        return Number.isFinite(n) && n > 0 ? n : 0;
    };

    const formatPeso = (amount) =>
        new Intl.NumberFormat('en-PH', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2,
        }).format(amount);

    const calculateTotal = () => {
        let totalCentavos = 0;

        DENOMS_CENTAVOS.forEach((denomCentavos, id) => {
        const input = form.querySelector(`#${CSS.escape(id)}`);
        if (!input) return;
            totalCentavos += toCount(input.value) * denomCentavos;
        });

        totalEl.value = formatPeso(totalCentavos / 100);
    };

    const onNumberInput = (e) => {
        const el = e.target;
        if (!(el instanceof HTMLInputElement)) return;
        if (el.type !== 'number') return;
        if (!DENOMS_CENTAVOS.has(el.id)) return;

        calculateTotal();
    };

    form.addEventListener('input', onNumberInput);
    form.addEventListener('change', onNumberInput);

    calculateTotal();

    $('#open_register_form').validate({
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
  
            const transaction   = 'insert shop session';
            const page_link     = document.getElementById('page-link').getAttribute('href') || 'apps.php';
            const shopId = $('#shop_id').val();
  
            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
  
            disableButton('submit-data');
  
            try {
                const response = await fetch('./app/Controllers/ShopController.php', {
                    method: 'POST',
                    body: formData
                });
  
                if (!response.ok) {
                    throw new Error(`Save shop session failed with status: ${response.status}`);
                }
  
                const data = await response.json();
  
                if (data.success) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location = `shop-register.php?id=${shopId}`;
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
        if (event.target.closest('.open-shop')){
            const shopId = event.target.closest('.open-shop').dataset.shopId;
            $('#shop_id').val(shopId);
        }
    });
});