import { disableButton, enableButton, resetForm } from '../../utilities/form-utilities.js';
import { attachLogNotesHandler, attachLogNotesClassHandler  } from '../../utilities/log-notes.js';
import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    const page_link     = document.getElementById('page-link')?.getAttribute('href') || 'apps.php';
    const floor_plan_id = document.getElementById('details-id')?.textContent.trim();
    const page_id       = document.getElementById('page-id')?.value || '';
    
    const displayDetails = async () => {
        const transaction = 'fetch floor plan details';

        try {
            resetForm('floor_plan_form');
            
            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('floor_plan_id', floor_plan_id);

            const response = await fetch('./app/Controllers/FloorPlanController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`Request failed with status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success) {
                document.getElementById('floor_plan_name').value = data.floorPlanName || '';
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

     const displayFloorPlanTableDetails = async (floor_plan_table_id) => {
        const transaction = 'fetch floor plan table details';

        try {
            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('floor_plan_id', floor_plan_id);
            formData.append('floor_plan_table_id', floor_plan_table_id);

            const response = await fetch('./app/Controllers/FloorPlanController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) throw new Error(`Request failed with status ${response.status}`);

            const data = await response.json();

            if (data.success) {
                $('#floor_plan_table_id').val(floor_plan_table_id);
                $('#table_number').val(data.tableNumber || '1');
                $('#seats').val(data.seats || '1');
            } 
            else if (data.notExist) {
                setNotification(data.title, data.message, data.message_type);
                window.location = page_link;
            } 
            else {
                showNotification(data.title, data.message, data.message_type);
            }
        } catch (error) {
            handleSystemError(error, 'fetch_failed', `Failed to fetch floor plan table details: ${error.message}`);
        }
    }

    attachLogNotesHandler('#log-notes-main', '#details-id', 'floor_plan');
    displayDetails();

    initializeDatatable({
        selector: '#floor-plan-table',
        ajaxUrl: './app/Controllers/FloorPlanController.php',
        transaction: 'generate floor plan tables table',
        ajaxData: {
            floor_plan_id: floor_plan_id,
            page_id: page_id
        },
        columns: [
            { data: 'TABLE_NUMBER' },
            { data: 'SEATS' },
            { data: 'ACTION' }
        ],
        columnDefs: [
            { width: 'auto', targets: 0, responsivePriority: 1 },
            { width: 'auto', bSortable: false, targets: 1, responsivePriority: 2 },
            { width: 'auto', bSortable: false, targets: 2, responsivePriority: 3 }
        ],
        order : [[0, 'asc']]
    });
    
    initializeDatatableControls('#floor-plan-table');

    $('#floor_plan_form').validate({
        rules: {
            floor_plan_name: { required: true }
        },
        messages: {
            floor_plan_name: { required: 'Enter the display name' }
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

            const transaction = 'save floor plan';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('floor_plan_id', floor_plan_id);

            disableButton('submit-data');

            try {
                const response = await fetch('./app/Controllers/FloorPlanController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save floor plan failed with status: ${response.status}`);
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

    $('#floor_plan_table_form').validate({
        rules: {
            table_number: { required: true },
            seats: { required: true },
        },
        messages: {
            table_number: { required: 'Enter the table number' },
            seats: { required: 'Enter the number of seats' }
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
    
            const transaction = 'save floor plan table';
    
            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('floor_plan_id', floor_plan_id);

            disableButton('submit-floor-plan-table');
    
            try {
                const response = await fetch('./app/Controllers/FloorPlanController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save floor plan table failed with status: ${response.status}`);
                }
    
                const data = await response.json();
    
                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    reloadDatatable('#floor-plan-table');
                    enableButton('submit-floor-plan-table');
                    $('#floor_plan_table_modal').modal('hide');
                    resetForm('floor_plan_table_form');
                }
                else if(data.invalid_session){
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else{
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-floor-plan-table');
                }
            } catch (error) {
                enableButton('submit-floor-plan-table');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    document.addEventListener('click', async (event) => {
        if (event.target.closest('#delete-floor-plan')) {
            const transaction = 'delete floor plan';

            const result = await Swal.fire({
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
            });

            if (result.isConfirmed) {
                try {
                    const formData = new URLSearchParams();
                    formData.append('transaction', transaction);
                    formData.append('floor_plan_id', floor_plan_id);

                    const response = await fetch('./app/Controllers/FloorPlanController.php', {
                        method: 'POST',
                        body: formData
                    });

                    if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                    const data = await response.json();

                    if (data.success) {
                        setNotification(data.title, data.message, data.message_type);
                        window.location.href = page_link;
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
        }        

        if (event.target.closest('#add-floor-plan-table')){
            resetForm('floor_plan_table_form');
        }
                
        if (event.target.closest('.update-floor-plan-table')){
            const button                = event.target.closest('.update-floor-plan-table');
            const floor_plan_table_id    = button.dataset.floorPlanTableId;
                
            displayFloorPlanTableDetails(floor_plan_table_id);
        }
                
        if (event.target.closest('.view-floor-plan-table-log-notes')){
            const button                = event.target.closest('.view-floor-plan-table-log-notes');
            const floor_plan_table_id    = button.dataset.floorPlanTableId;
                
            attachLogNotesClassHandler('floor_plan_table', floor_plan_table_id);
        }
                
        if (event.target.closest('.delete-floor-plan-table')){
            const transaction           = 'delete floor plan table';
            const button                = event.target.closest('.delete-floor-plan-table');
            const floor_plan_table_id    = button.dataset.floorPlanTableId;
                
            Swal.fire({
                title: 'Confirm Floor Plan Table Deletion',
                text: 'Are you sure you want to delete this floor plan table?',
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
                formData.append('floor_plan_table_id', floor_plan_table_id);
                
                try {
                    const response = await fetch('./app/Controllers/FloorPlanController.php', {
                        method: 'POST',
                        body: formData
                    });
                
                    if (!response.ok) throw new Error(`Request failed: ${response.status}`);
                
                    const data = await response.json();
                
                    if (data.success) {
                        showNotification(data.title, data.message, data.message_type);
                        reloadDatatable('#floor-plan-table');
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
    });
});