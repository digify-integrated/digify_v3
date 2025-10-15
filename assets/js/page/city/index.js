import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';
import { generateDropdownOptions } from '../../utilities/form-utilities.js';

document.addEventListener('DOMContentLoaded', () => {
    const datatableConfig = () => ({
        selector: '#city-table',
        ajaxUrl: './app/Controllers/CityController.php',
        transaction: 'generate city table',
        ajaxData: {
            state_filter: $('#state_filter').val(),
        },
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'CITY_NAME' },
            { data: 'STATE_NAME' },
            { data: 'COUNTRY_NAME' }
        ],
        columnDefs: [
            { width: '5%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 },
            { width: 'auto', targets: 2, responsivePriority: 3 },
            { width: 'auto', targets: 3, responsivePriority: 4 }
        ],
        onRowClick: (rowData) => {
            if (rowData?.LINK) window.open(rowData.LINK, '_blank');
        }
    });

    const dropdownConfigs = [
        { url: './app/Controllers/StateController.php', selector: '#state_filter', transaction: 'generate state options' },
        { url: './app/Controllers/CountryController.php', selector: '#country_filter', transaction: 'generate country options' }
    ];

    dropdownConfigs.forEach(cfg => {
        generateDropdownOptions({
            url: cfg.url,
            dropdownSelector: cfg.selector,
            data: { transaction: cfg.transaction, multiple: true }
        });
    });

    initializeDatatableControls('#city-table');
    initializeExportFeature('city');
    initializeDatatable(datatableConfig());

    document.addEventListener('click', async (event) => {
        if (event.target.closest('#apply-filter')) {
            initializeDatatable(datatableConfig());
        }

        if (event.target.closest('#reset-filter')) {
            $('#state_filter').val(null).trigger('change');

            initializeDatatable(datatableConfig());
        }

        if (event.target.closest('#delete-city')){
            const transaction   = 'delete multiple city';
            const city_id       = Array.from(document.querySelectorAll('.datatable-checkbox-children'))
                                        .filter(checkbox => checkbox.checked)
                                        .map(checkbox => checkbox.value);

            if (city_id.length === 0) {
                showNotification('Deletion Multiple Cities Error', 'Please select the cities you wish to delete.', 'error');
                return;
            }

            const result = await Swal.fire({
                title: 'Confirm Multiple Cities Deletion',
                text: 'Are you sure you want to delete these cities?',
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

            if (!result.value) return;

            try {
                const formData = new URLSearchParams();
                formData.append('transaction', transaction);
                city_id.forEach(id => formData.append('city_id[]', id));

                const response = await fetch('./app/Controllers/CityController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    reloadDatatable('#city-table');
                } 
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                }
            } catch (error) {
                handleSystemError(error, 'fetch_failed', `Failed to delete cities: ${error.message}`);
            }
        }
    });
});