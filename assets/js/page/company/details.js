import { disableButton, enableButton, generateDropdownOptions, generateDualListBox, resetForm } from '../../utilities/form-utilities.js';
import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { attachLogNotesHandler, attachLogNotesClassHandler  } from '../../utilities/log-notes.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    const page_link     = document.getElementById('page-link')?.getAttribute('href') || 'apps.php';
    const company_id    = document.getElementById('details-id')?.textContent.trim();
    
    const displayDetails = async () => {
        const transaction = 'fetch company details';

        try {
            resetForm('company_form');

            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('company_id', company_id);

            const response = await fetch('./app/Controllers/CompanyController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

            const data = await response.json();

            if (data.success) {
                document.getElementById('company_name').value   = data.companyName || '';
                document.getElementById('address').value        = data.address || '';
                document.getElementById('tax_id').value         = data.taxID || '';
                document.getElementById('phone').value          = data.phone || '';
                document.getElementById('telephone').value      = data.telephone || '';
                document.getElementById('email').value          = data.email || '';
                document.getElementById('website').value        = data.website || '';

                $('#city_id').val(data.cityID || '').trigger('change');
                $('#currency_id').val(data.currencyID || '').trigger('change');

                const thumbnail = document.getElementById('company_logo_thumbnail');
                if (thumbnail) thumbnail.style.backgroundImage = `url(${data.companyLogo || ''})`;
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
            { url: './app/Controllers/CityController.php', selector: '#city_id', transaction: 'generate city options' },
            { url: './app/Controllers/CurrencyController.php', selector: '#currency_id', transaction: 'generate currency options' }
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

    initializeDatatable({
        selector: '#role-permission-table',
        ajaxUrl: './app/Controllers/CompanyController.php',
        transaction: 'generate company assigned role table',
        ajaxData: {
            company_id: company_id
        },
        columns: [
            { data: 'ROLE_NAME' },
            { data: 'READ_ACCESS' },
            { data: 'CREATE_ACCESS' },
            { data: 'WRITE_ACCESS' },
            { data: 'DELETE_ACCESS' },
            { data: 'IMPORT_ACCESS' },
            { data: 'EXPORT_ACCESS' },
            { data: 'LOG_NOTES_ACCESS' },
            { data: 'ACTION' }
        ],
        columnDefs: [
            { width: 'auto', targets: 0, responsivePriority: 1 },
            { width: 'auto', bSortable: false, targets: 1, responsivePriority: 2 },
            { width: 'auto', bSortable: false, targets: 2, responsivePriority: 3 },
            { width: 'auto', bSortable: false, targets: 3, responsivePriority: 4 },
            { width: 'auto', bSortable: false, targets: 4, responsivePriority: 5 },
            { width: 'auto', bSortable: false, targets: 5, responsivePriority: 6 },
            { width: 'auto', bSortable: false, targets: 6, responsivePriority: 7 },
            { width: 'auto', bSortable: false, targets: 7, responsivePriority: 8 },
            { width: 'auto', bSortable: false, targets: 8, responsivePriority: 1 }
        ],
        order : [[0, 'asc']]
    });    

    initializeDatatableControls('#role-permission-table');
    attachLogNotesHandler('#log-notes-main', '#details-id', 'company');
    
    $('#company_form').validate({
        rules: {
            company_name: { required: true },
            company_id: { required: true },
            order_sequence: { required: true }
        },
        messages: {
            company_name: { required: 'Enter the display name' },
            company_id: { required: 'Choose the company' },
            order_sequence: { required: 'Enter the order sequence' }
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

            const transaction = 'save company';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('company_id', company_id);

            disableButton('submit-data');

            try {
                const response = await fetch('./app/Controllers/CompanyController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save company failed with status: ${response.status}`);
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
    
    $('#role_permission_assignment_form').validate({
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

            const transaction = 'save company role permission';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('company_id', company_id);

            disableButton('submit-assignment');

            try {
                const response = await fetch('./app/Controllers/CompanyController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save role failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-assignment');
                    reloadDatatable('#role-permission-table');
                    $('#role-permission-assignment-modal').modal('hide');
                }
                else if(data.invalid_session){
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else{
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-assignment');
                }
            } catch (error) {
                enableButton('submit-assignment');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    document.addEventListener('click', async (event) => {
        if (event.target.closest('#delete-company')){
            const transaction = 'delete company';

            const result = await Swal.fire({
                title: 'Confirm Company Deletion',
                text: 'Are you sure you want to delete this company?',
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
                    formData.append('company_id', company_id);

                    const response = await fetch('./app/Controllers/CompanyController.php', {
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
                    handleSystemError(error, 'fetch_failed', `Failed to delete company: ${error.message}`);
                }
            }
        }

        if (event.target.closest('#assign-role-permission')){
            generateDualListBox({
                url: './app/Controllers/CompanyController.php',
                selectSelector: 'role_id',
                data: {
                    transaction: 'generate company role dual listbox options',
                    company_id: company_id
                }
            });
        }

        if (event.target.closest('.update-role-permission')){
            const transaction           = 'update company role permission';
            const button                = event.target.closest('.update-role-permission');
            const role_permission_id    = button.dataset.rolePermissionId;
            const access_type           = button.dataset.accessType;
            const access                = button.checked ? '1' : '0';

            try {
                const formData = new URLSearchParams();
                formData.append('transaction', transaction);
                formData.append('role_permission_id', role_permission_id);
                formData.append('access_type', access_type);
                formData.append('access', access);

                const response = await fetch('./app/Controllers/CompanyController.php', {
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
                handleSystemError(error, 'fetch_failed', `Failed to update role permission: ${error.message}`);
            }
        }

        if (event.target.closest('.delete-role-permission')){
            const transaction           = 'delete company role permission';
            const button                = event.target.closest('.delete-role-permission');
            const role_permission_id    = button.dataset.rolePermissionId;

            const result = await Swal.fire({
                title: 'Confirm Role Permission Deletion',
                text: 'Are you sure you want to delete this role permission?',
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
                    formData.append('role_permission_id', role_permission_id);

                    const response = await fetch('./app/Controllers/CompanyController.php', {
                        method: 'POST',
                        body: formData
                    });

                    if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                    const data = await response.json();

                    if (data.success) {
                        showNotification(data.title, data.message, data.message_type);
                        reloadDatatable('#role-permission-table');
                    }
                    else if (data.invalid_session) {
                        setNotification(data.title, data.message, data.message_type);
                        window.location.href = data.redirect_link;
                    }
                    else{
                        showNotification(data.title, data.message, data.message_type);
                    }
                } catch (error) {
                    handleSystemError(error, 'fetch_failed', `Failed to delete role permission: ${error.message}`);
                }
            }
        }

        if (event.target.closest('.view-role-permission-log-notes')){
            const button                = event.target.closest('.view-role-permission-log-notes');
            const role_permission_id    = button.dataset.rolePermissionId;
            attachLogNotesClassHandler('role_permission', role_permission_id);
        }
    });

    document.addEventListener('change', async (event) => {
        if (!event.target.closest('#company_logo')) return;
    
        const input = event.target;
        if (input.files && input.files.length > 0) {
            const transaction = 'update company logo';
    
            if (!company_id) {
                showNotification('Error', 'Company ID not found', 'error');
                return;
            }
    
            const formData = new FormData();
            formData.append('transaction', transaction);
            formData.append('company_id', company_id);
            formData.append('company_logo', input.files[0]);
    
            try {
                const response = await fetch('./app/Controllers/CompanyController.php', {
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