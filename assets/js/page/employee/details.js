import { disableButton, enableButton, generateDropdownOptions, resetForm } from '../../utilities/form-utilities.js';
import { attachLogNotesHandler  } from '../../utilities/log-notes.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    const displayDetails = async () => {
        const transaction   = 'fetch employee details';
        const page_link     = document.getElementById('page-link').getAttribute('href');
        const employee_id   = document.getElementById('details-id')?.textContent.trim() || '';

        try {
            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            const response = await fetch('./app/Controllers/EmployeeController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) throw new Error(`Request failed with status ${response.status}`);

            const data = await response.json();

            if (data.success) {
                $('#first_name').val(data.firstName);
                $('#middle_name').val(data.middleName);
                $('#last_name').val(data.lastName);
                $('#suffix').val(data.suffix);
                $('#private_address').val(data.privateAddress);
                $('#nickname').val(data.nickname);
                $('#dependents').val(data.dependents);
                $('#home_work_distance').val(data.homeWorkDistance);
                $('#height').val(data.height);
                $('#weight').val(data.weight);

                $('#employee_name_summary').text(data.fullName || '--');
                $('#nickname_summary').text(data.nickname || '--');
                $('#private_address_summary').text(data.employeeAddress || '--');
                $('#home_work_distance_summary').text((data.homeWorkDistance || 0) + ' km');
                $('#civil_status_summary').text(data.civilStatusName || '--');
                $('#dependents_summary').text(data.dependents || 0);
                $('#religion_summary').text(data.religionName || '--');
                $('#blood_type_summary').text(data.bloodTypeName || '--');
                $('#height_summary').text((data.height || 0) + ' cm');
                $('#weight_summary').text((data.weight || 0) + ' kg');
                $('#badge_id_summary').text(data.badgeID || '--');
                $('#private_email_summary').text(data.privateEmail || '--');
                $('#private_phone_summary').text(data.privatePhone || '--');
                $('#private_telephone_summary').text(data.privateTelephone || '--');
                $('#nationality_summary').text(data.nationalityName || '--');
                $('#gender_summary').text(data.genderName || '--');
                $('#birthday_summary').text(data.birthday || '--');
                $('#place_of_birth_summary').text(data.placeOfBirth || '--');

                $('#company_summary').text(data.companyName || '--');
                $('#department_summary').text(data.departmentName || '--');
                $('#job_position_title_summary').text(data.jobPositionName || '--');
                $('#job_position_summary').text(data.jobPositionName || '--');
                $('#manager_summary').text(data.managerName || '--');
                $('#time_off_approver_summary').text(data.timeOffApproverName || '--');
                $('#work_location_summary').text(data.workLocationName || '--');
                $('#on_board_date_summary').text(data.onBoardDate || '--');
                $('#work_email_summary').text(data.workEmail || '--');
                $('#work_phone_summary').text(data.workPhone || '--');
                $('#work_telephone_summary').text(data.workTelephone || '--');

                $('#private_address_city_id').val(data.privateAddressCityID).trigger('change');
                $('#civil_status_id').val(data.civilStatusID).trigger('change');
                $('#religion_id').val(data.religionID).trigger('change');
                $('#blood_type_id').val(data.bloodTypeID).trigger('change');
                
                document.getElementById('employee_image_thumbnail').style.backgroundImage = `url(${data.employeeImage})`;
            } 
            else if (data.notExist) {
                setNotification(data.title, data.message, data.message_type);
                window.location = page_link;
            } 
            else {
                showNotification(data.title, data.message, data.message_type);
            }
        } catch (error) {
            handleSystemError(error, 'fetch_failed', `Failed to fetch employee details: ${error.message}`);
        }
    }

    const dropdownConfigs = [
        { url: './app/Controllers/CityController.php', selector: '#private_address_city_id', transaction: 'generate city options' },
        { url: './app/Controllers/NationalityController.php', selector: '#nationality_id', transaction: 'generate nationality options' },
        { url: './app/Controllers/CivilStatusController.php', selector: '#civil_status_id', transaction: 'generate civil status options' },
        { url: './app/Controllers/ReligionController.php', selector: '#religion_id', transaction: 'generate religion options' },
        { url: './app/Controllers/BloodTypeController.php', selector: '#blood_type_id', transaction: 'generate blood type options' },
        { url: './app/Controllers/GenderController.php', selector: '#gender_id', transaction: 'generate gender options' },
        { url: './app/Controllers/CompanyController.php', selector: '#company_id', transaction: 'generate company options' },
        { url: './app/Controllers/DepartmentController.php', selector: '#department_id', transaction: 'generate department options' },
        { url: './app/Controllers/JobPositionController.php', selector: '#job_position_id', transaction: 'generate job position options' },
        { url: './app/Controllers/WorkLocationController.php', selector: '#work_location_id', transaction: 'generate work location options' },
        { url: './app/Controllers/LanguageController.php', selector: '#language_id', transaction: 'generate language options' },
        { url: './app/Controllers/LanguageProficiencyController.php', selector: '#language_proficiency_id', transaction: 'generate language proficiency options' },
    ];
    
    dropdownConfigs.forEach(cfg => {
        generateDropdownOptions({
            url: cfg.url,
            dropdownSelector: cfg.selector,
            data: { transaction: cfg.transaction }
        });
    });

    const roleList = async () => {
        const transaction   = 'generate assigned employee role list';
        const employee_id   = document.getElementById('details-id')?.textContent.trim() || '';

        try {
            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            const response = await fetch('./app/Controllers/EmployeeController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) throw new Error(`Request failed with status ${response.status}`);

            const data = await response.json();
            
            document.getElementById('role-list').innerHTML = data[0].ROLE_employee;

        } catch (error) {
            handleSystemError(error, 'fetch_failed', `Failed to fetch role list: ${error.message}`);
        }
    }

    const toggleSection = (section) => {
        $(`#${section}_button`).toggleClass('d-none');
        $(`#${section}`).toggleClass('d-none');
        $(`#${section}_edit`).toggleClass('d-none');

        const formName = section.replace(/^change_/, '');
        resetForm(`update_${formName}_form`);
    }

    attachLogNotesHandler('#log-notes-main', '#details-id', 'employee');
    //roleList();
    displayDetails();

    $('#personal_details_form').validate({
        rules: {
            first_name: { 
                required: true 
            },
            last_name: { 
                required: true 
            },
            private_address: { 
                required: true 
            },
            private_address_city_id: { 
                required: true 
            },
            civil_status_id: { 
                required: true 
            }
        },
        messages: {
            first_name: { 
                required: 'Enter the first name' 
            },
            last_name: { 
                required: 'Enter the last name' 
            },
            private_address: { 
                required: 'Enter the private address' 
            },
            private_address_city_id: { 
                required: 'Choose the private address city' 
            },
            civil_status_id: { 
                required: 'Choose the civil status' 
            }
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

            const transaction   = 'update employee personal details';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('submit-personal-details');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    displayDetails();
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    enableButton('submit-personal-details');
                    showNotification(data.title, data.message, data.message_type);
                }
            } catch (error) {
                enableButton('submit-personal-details');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    /*$('#update_email_form').validate({
        rules: {
            email: { required: true }
        },
        messages: {
            email: { required: 'Enter the email' }
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

            const transaction   = 'update employee email';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_email_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_email');
                    displayDetails();
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_email_submit');
                }
            } catch (error) {
                enableButton('update_email_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_phone_form').validate({
        rules: {
            phone: { required: true }
        },
        messages: {
            phone: { required: 'Enter the phone' }
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

            const transaction   = 'update employee phone';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_phone_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_phone');
                    displayDetails();
                } 
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_phone_submit');
                }
            } catch (error) {
                enableButton('update_phone_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_password_form').validate({
        rules: {
            new_password: {
                required: true,
                password_strength: true
            }
        },
        messages: {
            new_password: { required: 'Enter the new password' }
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

            const transaction   = 'update employee password';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', encodeURIComponent(employee_id));

            disableButton('update_password_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    displayDetails();
                    toggleSection('change_password');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                }
            } catch (error) {
                enableButton('update_password_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#role_assignment_form').validate({
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

            const transaction   = 'save employee role';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', encodeURIComponent(employee_id));

            disableButton('submit-assignment');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    $('#role-assignment-modal').modal('hide');
                    roleList();
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-assignment');
                }
            } catch (error) {
                enableButton('submit-assignment');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });*/

    document.addEventListener('click', async (event) => {
        if (event.target.closest('[data-toggle-section]')){
            const section           = event.target.closest('[data-toggle-section]');
            const toggle_section    = section.dataset.toggleSection;
            toggleSection(toggle_section);
        }
    });

    document.addEventListener('change', async (event) => {
        const input = event.target.closest('#profile_picture');
        if (!input || !input.files.length) return;

        const transaction   = 'update employee profile picture';
        const employee_id   = document.getElementById('details-id')?.textContent.trim();

        const formData = new FormData();
        formData.append('transaction', transaction);
        formData.append('employee_id', employee_id);
        formData.append('profile_picture', input.files[0]);

        try {
            const response = await fetch('./app/Controllers/EmployeeController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

            const data = await response.json();

            if (data.success) {
                showNotification(data.title, data.message, data.message_type);
                displayDetails();
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