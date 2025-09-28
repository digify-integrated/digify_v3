import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';
import { generateDropdownOptions } from '../../utilities/form-utilities.js';

document.addEventListener('DOMContentLoaded', () => {
    let isFetching = false;
    let hasQueuedRequest = false;
    let offset = 0;
    const LIMIT = 16;

    const datatableConfig = () => ({
        selector: '#employee-table',
        ajaxUrl: './app/Controllers/EmployeeController.php',
        transaction: 'generate employee table',
        ajaxData: {
            filter_by_company: document.querySelector('#company_filter')?.value || [],
            filter_by_department: document.querySelector('#department_filter')?.value || [],
            filter_by_job_position: document.querySelector('#job_position_filter')?.value || [],
            filter_by_employee_status: document.querySelector('#employee_status_filter')?.value || [],
            filter_by_work_location: document.querySelector('#work_location_filter')?.value || [],
            filter_by_employment_type: document.querySelector('#employment_type_filter')?.value || [],
            filter_by_gender: document.querySelector('#gender_filter')?.value || []
        },
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'EMPLOYEE' },
            { data: 'DEPARTMENT' }
        ],
        columnDefs: [
            { width: '5%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 },
            { width: 'auto', targets: 2, responsivePriority: 3 }
        ],
        onRowClick: (rowData) => {
            if (rowData?.LINK) window.open(rowData.LINK, '_blank');
        }
    });

    initializeDatatable(datatableConfig());

    const containerId = 'employee-card';
    const container = document.querySelector(`#${containerId}`);

    const dropdownConfigs = [
        { url: './app/Controllers/CompanyController.php', selector: '#company_filter', transaction: 'generate company options' },
        { url: './app/Controllers/DepartmentController.php', selector: '#department_filter', transaction: 'generate department options' },
        { url: './app/Controllers/JobPositionController.php', selector: '#job_position_filter', transaction: 'generate job position options' },
        { url: './app/Controllers/WorkLocationController.php', selector: '#work_location_filter', transaction: 'generate work location options' },
        { url: './app/Controllers/EmploymentTypeController.php', selector: '#employment_type_filter', transaction: 'generate employment type options' },
        { url: './app/Controllers/GenderController.php', selector: '#gender_filter', transaction: 'generate gender options' }
    ];

    dropdownConfigs.forEach(cfg => {
        generateDropdownOptions({
            url: cfg.url,
            dropdownSelector: cfg.selector,
            data: { transaction: cfg.transaction, multiple: true }
        });
    });

    const spinner = document.createElement('div');
    spinner.id = 'loading-spinner';
    spinner.className = 'text-center mt-10 d-none';
    spinner.innerHTML = `
        <span>
            <span class="spinner-grow spinner-grow-md align-middle ms-0"></span>
        </span>
    `;
    container?.appendChild(spinner);

    function showSpinner() {
        spinner.classList.remove('d-none');
    }

    function hideSpinner() {
        spinner.classList.add('d-none');
    }

    const fetchEmployeeCards = async ({ clearExisting = false } = {}) => {
        if (isFetching) {
            hasQueuedRequest = true;
            return;
        }
        isFetching = true;
        showSpinner();

        try {
            if (clearExisting) {
                container.innerHTML = '';
                container.appendChild(spinner);
                offset = 0;
                container.appendChild(sentinel);
            }

            const payload = {
                page_id: document.querySelector('#page-id')?.value,
                page_link: document.querySelector('#page-link')?.getAttribute('href'),
                transaction: 'generate employee card',
                limit: LIMIT,
                offset,
                search_value: document.querySelector('#datatable-search')?.value || '',
                filter_by_company: document.querySelector('#company_filter')?.value || [],
                filter_by_department: document.querySelector('#department_filter')?.value || [],
                filter_by_job_position: document.querySelector('#job_position_filter')?.value || [],
                filter_by_employee_status: document.querySelector('#employee_status_filter')?.value || [],
                filter_by_work_location: document.querySelector('#work_location_filter')?.value || [],
                filter_by_employment_type: document.querySelector('#employment_type_filter')?.value || [],
                filter_by_gender: document.querySelector('#gender_filter')?.value || []
            };

            const response = await fetch('./app/Controllers/EmployeeController.php', {
                method: 'POST',
                body: new URLSearchParams(payload)
            });

            if (!response.ok) throw new Error(`HTTP error! Status: ${response.status}`);

            const data = await response.json();

            if (!Array.isArray(data) || data.length === 0) {
                stopInfiniteScroll();
                return;
            }

            const htmlString = data.map(card => card.EMPLOYEE_CARD).join('');
            sentinel.insertAdjacentHTML('beforebegin', htmlString);

            offset += data.length;

            if (data.length < LIMIT) {
                stopInfiniteScroll();
            } else {
                ensureScrollable();
            }

        } catch (error) {
            console.error('Error fetching employee cards:', error);
        } finally {
            isFetching = false;
            hideSpinner();

            if (hasQueuedRequest) {
                hasQueuedRequest = false;
                fetchEmployeeCards({ clearExisting: false });
            }
        }
    };

    const sentinel = document.createElement('div');
    sentinel.id = 'scroll-sentinel';
    container.appendChild(sentinel);

    const observer = new IntersectionObserver(entries => {
        if (entries.some(entry => entry.isIntersecting)) {
            fetchEmployeeCards();
        }
    }, { rootMargin: '300px' });

    observer.observe(sentinel);

    function stopInfiniteScroll() {
        observer.disconnect();
    }

    async function ensureScrollable() {
        if (container.scrollHeight <= window.innerHeight && !isFetching) {
            await fetchEmployeeCards();
        }
    }

    document.addEventListener('click', event => {
        if (event.target.closest('#apply-filter')) {
            observer.observe(sentinel);
            fetchEmployeeCards({ clearExisting: true });

            initializeDatatable(datatableConfig());
        }

        if (event.target.closest('#reset-filter')) {
            $('#company_filter').val(null).trigger('change');
            $('#department_filter').val(null).trigger('change');
            $('#job_position_filter').val(null).trigger('change');
            $('#job_position_filter').val(null).trigger('change');
            $('#employee_status_filter').val(null).trigger('change');
            $('#work_location_filter').val(null).trigger('change');
            $('#employment_type_filter').val(null).trigger('change');

            observer.observe(sentinel);
            fetchEmployeeCards({ clearExisting: true });

            initializeDatatable(datatableConfig());
        }
    });

    fetchEmployeeCards({ clearExisting: true });
});
