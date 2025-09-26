import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    let isFetching = false;
    let hasQueuedRequest = false;
    let offset = 0;
    const LIMIT = 30;

    // Fetch employees in batches with queue support
    const fetchEmployeeCards = async ({ clearExisting = false, containerId = 'employee-card' } = {}) => {
        if (isFetching) {
            // 🚦 If already fetching, queue the request
            hasQueuedRequest = true;
            return;
        }
        isFetching = true;

        try {
            const pageId = document.querySelector('#page-id')?.value;
            const pageLink = document.querySelector('#page-link')?.getAttribute('href');

            const filters = {
                search_value: document.querySelector('#datatable-search')?.value || '',
                filter_by_company: document.querySelector('#company_filter')?.value || '',
                filter_by_department: document.querySelector('#department_filter')?.value || '',
                filter_by_job_position: document.querySelector('#job_position_filter')?.value || '',
                filter_by_employee_status: document.querySelector('#employee_status_filter')?.value || '',
                filter_by_work_location: document.querySelector('#work_location_filter')?.value || '',
                filter_by_employment_type: document.querySelector('#employment_type_filter')?.value || '',
                filter_by_gender: document.querySelector('#gender_filter')?.value || ''
            };

            if (clearExisting) {
                document.querySelector(`#${containerId}`).innerHTML = '';
                offset = 0;
                removeEndMessage();
            }

            const payload = {
                page_id: pageId,
                page_link: pageLink,
                transaction: 'generate employee card',
                limit: LIMIT,
                offset,
                ...filters
            };

            const response = await fetch('./app/Controllers/EmployeeController.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            });

            if (!response.ok) throw new Error(`HTTP error! Status: ${response.status}`);

            const data = await response.json();
            if (!Array.isArray(data) || data.length === 0) {
                stopInfiniteScroll();
                showEndMessage(containerId);
                return;
            }

            const container = document.querySelector(`#${containerId}`);
            const htmlString = data.map(card => card.EMPLOYEE_CARD).join('');
            container.insertAdjacentHTML('beforeend', htmlString);

            // ✅ Update offset only after successful render
            offset += data.length;

            // 🚦 If fewer than LIMIT returned, stop observing and show end message
            if (data.length < LIMIT) {
                stopInfiniteScroll();
                showEndMessage(containerId);
            }

        } catch (error) {
            console.error('Error fetching employee cards:', error);
        } finally {
            isFetching = false;

            // 🚀 Process queued request if any
            if (hasQueuedRequest) {
                hasQueuedRequest = false;
                fetchEmployeeCards({ clearExisting: false, containerId });
            }
        }
    };

    // ---- Helpers ----
    const sentinel = document.createElement('div');
    sentinel.id = 'scroll-sentinel';
    document.body.appendChild(sentinel);

    const observer = new IntersectionObserver(entries => {
        if (entries.some(entry => entry.isIntersecting)) {
            fetchEmployeeCards({ clearExisting: false });
        }
    }, { rootMargin: '200px' });

    observer.observe(sentinel);

    function stopInfiniteScroll() {
        observer.disconnect();
    }

    function showEndMessage(containerId) {
        if (!document.querySelector('#end-of-results')) {
            const container = document.querySelector(`#${containerId}`);
            const endMessage = document.createElement('div');
            endMessage.id = 'end-of-results';
            endMessage.textContent = 'No more employees to display.';
            endMessage.style.textAlign = 'center';
            endMessage.style.padding = '1rem';
            endMessage.style.color = '#666';
            container.insertAdjacentElement('afterend', endMessage);
        }
    }

    function removeEndMessage() {
        const msg = document.querySelector('#end-of-results');
        if (msg) msg.remove();
    }

    // ---- Filter button ----
    document.addEventListener('click', e => {
        if (e.target && e.target.id === 'apply-filter') {
            offset = 0;
            observer.observe(sentinel); // reset observer
            fetchEmployeeCards({ clearExisting: true });

            if (typeof employeeTable === 'function') {
                employeeTable('#employee-table');
            }
        }
    });

    // ---- Initial load ----
    fetchEmployeeCards({ clearExisting: true });


});