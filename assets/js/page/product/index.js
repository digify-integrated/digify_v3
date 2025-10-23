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
        selector: '#product-table',
        ajaxUrl: './app/Controllers/ProductController.php',
        transaction: 'generate product table',
        ajaxData: {
            filter_by_product_type: $('#product_type_filter').val(),
            filter_by_product_category: $('#product_category_filter').val(),
            filter_by_is_sellable: $('#is_sellable_filter').val(),
            filter_by_is_purchasable: $('#is_purchasable_filter').val(),
            filter_by_show_on_pos: $('#show_on_pos_filter').val(),
            filter_by_product_status: $('#product_status_filter').val()
        },
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'PRODUCT' },
            { data: 'BARCODE' },
            { data: 'PRODUCT_TYPE' },
            { data: 'PRODUCT_CATEGORY' },
            { data: 'QUANTITY' },
            { data: 'SALES_PRICE' },
            { data: 'COST' },
            { data: 'STATUS' }
        ],
        columnDefs: [
            { width: '5%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 },
            { width: 'auto', targets: 2, responsivePriority: 3 },
            { width: 'auto', targets: 3, responsivePriority: 4 },
            { width: 'auto', targets: 4, responsivePriority: 5 },
            { width: 'auto', targets: 5, responsivePriority: 6 },
            { width: 'auto', targets: 6, responsivePriority: 7 },
            { width: 'auto', targets: 7, responsivePriority: 8 },
            { width: 'auto', targets: 8, responsivePriority: 9 }
        ],
        onRowClick: (rowData) => {
            if (rowData?.LINK) window.open(rowData.LINK, '_blank');
        }
    });

    initializeDatatable(datatableConfig());
    initializeDatatableControls('#product-table');
    initializeExportFeature('product');

    const containerId = 'product-card';
    const container = document.querySelector(`#${containerId}`);

    generateDropdownOptions({
        url: './app/Controllers/ProductCategoryController.php',
        dropdownSelector: '#product_category_filter',
        data: { transaction: 'generate product category options', multiple: true }
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

    const fetchProductCards = async ({ clearExisting = false } = {}) => {
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
                container.appendChild(sentinel);
                offset = 0;
            }

            const payload = {
                page_id: document.querySelector('#page-id')?.value,
                page_link: document.querySelector('#page-link')?.getAttribute('href'),
                transaction: 'generate product card',
                limit: LIMIT,
                offset,
                search_value: document.querySelector('#datatable-search')?.value || '',
                filter_by_product_type: $('#product_type_filter').val(),
                filter_by_product_category: $('#product_category_filter').val(),
                filter_by_is_sellable: $('#is_sellable_filter').val(),
                filter_by_is_purchasable: $('#is_purchasable_filter').val(),
                filter_by_show_on_pos: $('#show_on_pos_filter').val(),
                filter_by_product_status: $('#product_status_filter').val()
            };

            const response = await fetch('./app/Controllers/ProductController.php', {
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
            console.error('Error fetching product cards:', error);
        } finally {
            isFetching = false;
            hideSpinner();

            if (hasQueuedRequest) {
                hasQueuedRequest = false;
                fetchProductCards({ clearExisting: false });
            }
        }
    };

    const sentinel  = document.createElement('div');
    sentinel.id     = 'scroll-sentinel';
    container.appendChild(sentinel);

    const observer = new IntersectionObserver(entries => {
        if (entries.some(entry => entry.isIntersecting)) {
            fetchProductCards();
        }
    }, { rootMargin: '300px' });

    observer.observe(sentinel);

    function stopInfiniteScroll() {
        observer.disconnect();
    }

    async function ensureScrollable() {
        if (container.scrollHeight <= window.innerHeight && !isFetching) {
            await fetchProductCards();
        }
    }

    document.addEventListener('click', async (event) => {
        if (event.target.closest('#apply-filter')) {
            observer.observe(sentinel);
            fetchProductCards({ clearExisting: true });

            initializeDatatable(datatableConfig());
        }

        if (event.target.closest('#reset-filter')) {
            $('#product_type_filter').val(null).trigger('change');
            $('#product_category_filter').val(null).trigger('change');
            $('#is_sellable_filter').val(null).trigger('change');
            $('#is_purchasable_filter').val(null).trigger('change');
            $('#show_on_pos_filter').val(null).trigger('change');
            $('#product_status_filter').val('Active').trigger('change');

            observer.observe(sentinel);
            fetchProductCards({ clearExisting: true });

            initializeDatatable(datatableConfig());
        }

        if (event.target.closest('#delete-product')) {
            const transaction   = 'delete multiple product';
            const product_id    = Array.from(document.querySelectorAll('.datatable-checkbox-children'))
                                        .filter(el => el.checked)
                                        .map(el => el.value);

            if (product_id.length === 0) {
                showNotification('Deletion Multiple Products Error', 'Please select the products you wish to delete.', 'error');
                return;
            }

            const result = await Swal.fire({
                title: 'Confirm Multiple Products Deletion',
                text: 'Are you sure you want to delete these products?',
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
                product_id.forEach(id => formData.append('product_id[]', id));

                const response = await fetch('./app/Controllers/ProductController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Deletion failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    observer.observe(sentinel);
                    fetchProductCards({ clearExisting: true });

                    reloadDatatable('#product-table');
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

    document.addEventListener('keyup', event => {
        const productTable  = $('#product-table').DataTable();
        const searchInput   = event.target.closest('#datatable-search');

        if (searchInput) {
            productTable.search(searchInput.value).draw();

            observer.observe(sentinel);
            fetchProductCards({ clearExisting: true });
        }
    });

    document.addEventListener('change', event => {
        const productTable  = $('#product-table').DataTable();
        const lengthSelect  = event.target.closest('#datatable-length');

        if (lengthSelect) {
            const newLength = lengthSelect.value;
            productTable.page.len(newLength).draw();
        }
    });

    fetchProductCards({ clearExisting: true });
});
