import { disableButton, enableButton, generateDropdownOptions, resetForm, initializeDatePicker } from '../../utilities/form-utilities.js';
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
                $('#employment_type_summary').text(data.employmentTypeName || '--');
                $('#employment_location_type_summary').text(data.employmentLocationTypeName || '--');
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
        { url: './app/Controllers/EmploymentTypeController.php', selector: '#employment_type_id', transaction: 'generate employment type options' },
        { url: './app/Controllers/EmploymentLocationTypeController.php', selector: '#employment_location_type_id', transaction: 'generate employment location type options' },
        { url: './app/Controllers/WorkLocationController.php', selector: '#work_location_id', transaction: 'generate work location options' },
        { url: './app/Controllers/LanguageController.php', selector: '#language_id', transaction: 'generate language options' },
        { url: './app/Controllers/LanguageProficiencyController.php', selector: '#language_proficiency_id', transaction: 'generate language proficiency options' },
        { url: './app/Controllers/EmployeeController.php', selector: '#manager_id', transaction: 'generate employee options' },
        { url: './app/Controllers/EmployeeController.php', selector: '#time_off_approver_id', transaction: 'generate employee options' },
    ];
    
    dropdownConfigs.forEach(cfg => {
        generateDropdownOptions({
            url: cfg.url,
            dropdownSelector: cfg.selector,
            data: { transaction: cfg.transaction }
        });
    });

    const languageList = async () => {
        const transaction   = 'generate employee language list';
        const employee_id   = document.getElementById('details-id')?.textContent.trim() || '';
        const page_id       = document.getElementById('page-id')?.value || '';

        try {
            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);
            formData.append('page_id', page_id);

            const response = await fetch('./app/Controllers/EmployeeController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) throw new Error(`Request failed with status ${response.status}`);

            const data = await response.json();
            
            document.getElementById('language_summary').innerHTML = data[0].LANGUAGE_LIST;

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
    initializeDatePicker('#birthday');
    initializeDatePicker('#on_board_date');
    languageList();
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
                    enableButton('submit-personal-details');
                    $('#update_personal_details_modal').modal('hide');
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

    $('#update_pin_code_form').validate({
        rules: {
            pin_code: { required: true }
        },
        messages: {
            pin_code: { required: 'Enter the PIN code' }
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

            const transaction   = 'update employee pin code';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_pin_code_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_pin_code');
                    displayDetails();
                    enableButton('update_pin_code_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_pin_code_submit');
                }
            } catch (error) {
                enableButton('update_pin_code_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_badge_id_form').validate({
        rules: {
            badge_id: { required: true }
        },
        messages: {
            badge_id: { required: 'Enter the badge ID' }
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

            const transaction   = 'update employee badge id';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_badge_id_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_badge_id');
                    displayDetails();
                    enableButton('update_badge_id_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_badge_id_submit');
                }
            } catch (error) {
                enableButton('update_badge_id_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_private_email_form').validate({
        rules: {
            private_email: { required: true }
        },
        messages: {
            private_email: { required: 'Enter the private email' }
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

            const transaction   = 'update employee private email';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_private_email_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_private_email');
                    displayDetails();
                    enableButton('update_private_email_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_private_email_submit');
                }
            } catch (error) {
                enableButton('update_private_email_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_private_phone_form').validate({
        rules: {
            private_phone: { required: true }
        },
        messages: {
            private_phone: { required: 'Enter the private phone' }
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

            const transaction   = 'update employee private phone';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_private_phone_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_private_phone');
                    displayDetails();
                    enableButton('update_private_phone_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_private_phone_submit');
                }
            } catch (error) {
                enableButton('update_private_phone_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_private_telephone_form').validate({
        rules: {
            private_telephone: { required: true }
        },
        messages: {
            private_telephone: { required: 'Enter the private telephone' }
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

            const transaction   = 'update employee private telephone';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_private_telephone_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_private_telephone');
                    displayDetails();
                    enableButton('update_private_telephone_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_private_telephone_submit');
                }
            } catch (error) {
                enableButton('update_private_telephone_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_nationality_form').validate({
        rules: {
            nationality_id: { required: true }
        },
        messages: {
            nationality_id: { required: 'Choose the nationality' }
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

            const transaction   = 'update employee nationality';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_nationality_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_nationality');
                    displayDetails();
                    enableButton('update_nationality_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_nationality_submit');
                }
            } catch (error) {
                enableButton('update_nationality_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_gender_form').validate({
        rules: {
            gender_id: { required: true }
        },
        messages: {
            gender_id: { required: 'Choose the gender' }
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

            const transaction   = 'update employee gender';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_gender_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_gender');
                    displayDetails();
                    enableButton('update_gender_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_gender_submit');
                }
            } catch (error) {
                enableButton('update_gender_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_birthday_form').validate({
        rules: {
            birthday: { required: true }
        },
        messages: {
            birthday: { required: 'Choose the date of birth' }
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

            const transaction   = 'update employee birthday';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_birthday_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_birthday');
                    displayDetails();
                    enableButton('update_birthday_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_birthday_submit');
                }
            } catch (error) {
                enableButton('update_birthday_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_place_of_birth_form').validate({
        rules: {
            place_of_birth: { required: true }
        },
        messages: {
            place_of_birth: { required: 'Enter the place of birth' }
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

            const transaction   = 'update employee place of birth';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_place_of_birth_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_place_of_birth');
                    displayDetails();
                    enableButton('update_place_of_birth_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_place_of_birth_submit');
                }
            } catch (error) {
                enableButton('update_place_of_birth_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_company_form').validate({
        rules: {
            company_id: { required: true }
        },
        messages: {
            company_id: { required: 'Choose the company' }
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

            const transaction   = 'update employee company';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_company_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_company');
                    displayDetails();
                    enableButton('update_company_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_company_submit');
                }
            } catch (error) {
                enableButton('update_company_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_department_form').validate({
        rules: {
            department_id: { required: true }
        },
        messages: {
            department_id: { required: 'Choose the department' }
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

            const transaction   = 'update employee department';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_department_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_department');
                    displayDetails();
                    enableButton('update_department_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_department_submit');
                }
            } catch (error) {
                enableButton('update_department_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_job_position_form').validate({
        rules: {
            job_position_id: { required: true }
        },
        messages: {
            job_position_id: { required: 'Choose the job position' }
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

            const transaction   = 'update employee job position';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_job_position_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_job_position');
                    displayDetails();
                    enableButton('update_job_position_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_job_position_submit');
                }
            } catch (error) {
                enableButton('update_job_position_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_manager_form').validate({
        rules: {
            manager_id: { required: true }
        },
        messages: {
            manager_id: { required: 'Choose the manager' }
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

            const transaction   = 'update employee manager';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_manager_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_manager');
                    displayDetails();
                    enableButton('update_manager_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_manager_submit');
                }
            } catch (error) {
                enableButton('update_manager_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_time_off_approver_form').validate({
        rules: {
            time_off_approver_id: { required: true }
        },
        messages: {
            time_off_approver_id: { required: 'Choose the time off approver' }
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

            const transaction   = 'update employee time off approver';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_time_off_approver_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_time_off_approver');
                    displayDetails();
                    enableButton('update_time_off_approver_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_time_off_approver_submit');
                }
            } catch (error) {
                enableButton('update_time_off_approver_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_employment_type_form').validate({
        rules: {
            employment_type_id: { required: true }
        },
        messages: {
            employment_type_id: { required: 'Choose the employment type' }
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

            const transaction   = 'update employee employment type';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_employment_type_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_employment_type');
                    displayDetails();
                    enableButton('update_employment_type_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_employment_type_submit');
                }
            } catch (error) {
                enableButton('update_employment_type_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_employment_location_type_form').validate({
        rules: {
            employment_location_type_id: { required: true }
        },
        messages: {
            employment_location_type_id: { required: 'Choose the employment location type' }
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

            const transaction   = 'update employee employment location type';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_employment_location_type_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_employment_location_type');
                    displayDetails();
                    enableButton('update_employment_location_type_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_employment_location_type_submit');
                }
            } catch (error) {
                enableButton('update_employment_location_type_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_work_location_form').validate({
        rules: {
            work_location_id: { required: true }
        },
        messages: {
            work_location_id: { required: 'Choose the work location' }
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

            const transaction   = 'update employee work location';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_work_location_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_work_location');
                    displayDetails();
                    enableButton('update_work_location_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_work_location_submit');
                }
            } catch (error) {
                enableButton('update_work_location_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_on_board_date_form').validate({
        rules: {
            on_board_date: { required: true }
        },
        messages: {
            on_board_date: { required: 'Choose the on board date' }
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

            const transaction   = 'update employee on board date';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_on_board_date_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_on_board_date');
                    displayDetails();
                    enableButton('update_on_board_date_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_on_board_date_submit');
                }
            } catch (error) {
                enableButton('update_on_board_date_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_work_email_form').validate({
        rules: {
            work_email: { required: true }
        },
        messages: {
            work_email: { required: 'Enter the work email' }
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

            const transaction   = 'update employee work email';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_work_email_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_work_email');
                    displayDetails();
                    enableButton('update_work_email_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_work_email_submit');
                }
            } catch (error) {
                enableButton('update_work_email_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_work_phone_form').validate({
        rules: {
            work_phone: { required: true }
        },
        messages: {
            work_phone: { required: 'Enter the work phone' }
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

            const transaction   = 'update employee work phone';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_work_phone_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_work_phone');
                    displayDetails();
                    enableButton('update_work_phone_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_work_phone_submit');
                }
            } catch (error) {
                enableButton('update_work_phone_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#update_work_telephone_form').validate({
        rules: {
            work_telephone: { required: true }
        },
        messages: {
            work_telephone: { required: 'Enter the work telephone' }
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

            const transaction   = 'update employee work telephone';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('update_work_telephone_submit');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    toggleSection('change_work_telephone');
                    displayDetails();
                    enableButton('update_work_telephone_submit');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('update_work_telephone_submit');
                }
            } catch (error) {
                enableButton('update_work_telephone_submit');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    $('#employee_language_form').validate({
        rules: {
            language_id: { required: true },
            language_proficiency_id: { required: true }
        },
        messages: {
            language_id: { required: 'Choose the language' },
            language_proficiency_id: { required: 'Choose the language proficiency' }
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

            const transaction   = 'save employee language';
            const employee_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employee_id', employee_id);

            disableButton('submit_employee_language');

            try {
                const response = await fetch('./app/Controllers/EmployeeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    languageList();
                    $('#employee_language_modal').modal('hide');
                    enableButton('submit_employee_language');
                    resetForm('employee_language_form');
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit_employee_language');
                }
            } catch (error) {
                enableButton('submit_employee_language');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    document.addEventListener('click', async (event) => {
        if (event.target.closest('[data-toggle-section]')){
            const section           = event.target.closest('[data-toggle-section]');
            const toggle_section    = section.dataset.toggleSection;
            toggleSection(toggle_section);
        }

        if (event.target.closest('.delete-employee-language')){
            const transaction           = 'delete employee language';
            const button                = event.target.closest('.delete-employee-language');
            const employee_language_id  = button.dataset.employeeLanguageId;

            Swal.fire({
                title: 'Confirm Employee Language Deletion',
                text: 'Are you sure you want to delete this employee language?',
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
                formData.append('employee_language_id', employee_language_id);

                try {
                    const response = await fetch('./app/Controllers/EmployeeController.php', {
                        method: 'POST',
                        body: formData
                    });

                    if (!response.ok) throw new Error(`Request failed: ${response.status}`);

                    const data = await response.json();

                    if (data.success) {
                        showNotification(data.title, data.message, data.message_type);
                        languageList();
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

    document.addEventListener('change', async (event) => {
        const input = event.target.closest('#employee_image');
        if (!input || !input.files.length) return;

        const transaction   = 'update employee image';
        const employee_id   = document.getElementById('details-id')?.textContent.trim();

        const formData = new FormData();
        formData.append('transaction', transaction);
        formData.append('employee_id', employee_id);
        formData.append('employee_image', input.files[0]);

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