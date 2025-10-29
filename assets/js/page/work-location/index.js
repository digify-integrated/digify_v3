import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';
import { generateDropdownOptions } from '../../utilities/form-utilities.js';

document.addEventListener('DOMContentLoaded', () => {
    initializeExportFeature('work_location');

    const datatableConfig = () => ({
        selector: '#work-location-table',
        ajaxUrl: './app/Controllers/WorkLocationController.php',
        transaction: 'generate work location table',
        ajaxData: {
            city_filter: $('#city_filter').val(),
            state_filter: $('#state_filter').val(),
            country_filter: $('#country_filter').val()
        },
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'WORK_LOCATION_NAME' }
        ],
        columnDefs: [
            { width: '5%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 }
        ],
        onRowClick: (rowData) => {
            if (rowData?.LINK) window.open(rowData.LINK, '_blank');
        }
    });

    const dropdownConfigs = [
        { url: './app/Controllers/CityController.php', selector: '#city_filter', transaction: 'generate filter city options' },
        { url: './app/Controllers/StateController.php', selector: '#state_filter', transaction: 'generate state options' },
        { url: './app/Controllers/CountryController.php', selector: '#country_filter', transaction: 'generate country options' }
    ];
    
    dropdownConfigs.forEach(cfg => {
        generateDropdownOptions({
            url: cfg.url,
            dropdownSelector: cfg.selector,
            data: { transaction: cfg.transaction, multiple : true }
        });
    });
    
    initializeDatatable(datatableConfig());
    initializeDatatableControls('#work-location-table');

    document.addEventListener('click', async (event) => {
        if (event.target.closest('#apply-filter')) {
            initializeDatatable(datatableConfig());
        }

        if (event.target.closest('#reset-filter')) {
            $('#city_filter').val(null).trigger('change');
            $('#state_filter').val(null).trigger('change');
            $('#country_filter').val(null).trigger('change');

            initializeDatatable(datatableConfig());
        }
        
        if (event.target.closest('#delete-work-location')){
            const transaction       = 'delete multiple work location';
            const work_location_id  = Array.from(document.querySelectorAll('.datatable-checkbox-children'))
                                            .filter(el => el.checked)
                                            .map(el => el.value);

            if (work_location_id.length === 0) {
                showNotification('Deletion Multiple Work Locations Error', 'Please select the work locations you wish to delete.', 'error');
                return;
            }

            const result = await Swal.fire({
                title: 'Confirm Multiple Work Locations Deletion',
                text: 'Are you sure you want to delete these work locations?',
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
                work_location_id.forEach(id => formData.append('work_location_id[]', id));

                const response = await fetch('./app/Controllers/WorkLocationController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Deletion failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    reloadDatatable('#work-location-table');
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