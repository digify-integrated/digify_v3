import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    initializeDatatable({
        selector: '#payment-method-table',
        ajaxUrl: './app/Controllers/PaymentMethodController.php',
        transaction: 'generate payment method table',
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'PAYMENT_METHOD_NAME' }
        ],
        columnDefs: [
            { width: '5%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 }
        ],
        onRowClick: (rowData) => {
            if (rowData?.LINK) window.open(rowData.LINK, '_blank');
        }
    });
    
    initializeDatatableControls('#payment-method-table');
    initializeExportFeature('payment_method');

    document.addEventListener('click', async (event) => {
        if (!event.target.closest('#delete-payment-method')) return;

        const transaction           = 'delete multiple payment method';
        const payment_method_id   = Array.from(document.querySelectorAll('.datatable-checkbox-children'))
                                            .filter(el => el.checked)
                                            .map(el => el.value);

        if (payment_method_id.length === 0) {
            showNotification('Deletion Multiple Payment Methods Error', 'Please select the payment methods you wish to delete.', 'error');
            return;
        }

        const result = await Swal.fire({
            title: 'Confirm Multiple Payment Methods Deletion',
            text: 'Are you sure you want to delete these payment methods?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Delete',
            cancelButtonText: 'Cancel',
            customClass: {
                confirmButton: 'btn btn-danger',
                cancelButton: 'btn btn-secondary'
            },
            buttonsStyling: false
        });

        if (!result.isConfirmed) return;

        try {
            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            payment_method_id.forEach(id => formData.append('payment_method_id[]', id));

            const response = await fetch('./app/Controllers/PaymentMethodController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`Deletion failed with status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success) {
                showNotification(data.title, data.message, data.message_type);
                reloadDatatable('#payment-method-table');
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