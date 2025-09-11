export const reloadDatatable = (datatableSelector) => {
    manageActionDropdown();

    if ($.fn.DataTable.isDataTable(datatableSelector)) {
        $(datatableSelector).DataTable().ajax.reload(null, false);
    }
};

export const destroyDatatable = (datatableSelector) => {
    if ($.fn.DataTable.isDataTable(datatableSelector)) {
        $(datatableSelector).DataTable().clear().destroy();
    }
};

export const clearDatatable = (datatableSelector) => {
    if ($.fn.DataTable.isDataTable(datatableSelector)) {
        $(datatableSelector).DataTable().clear().draw();
    }
};

export const readjustDatatableColumn = () => {
    const adjustColumns = () => {
        const tables = $.fn.dataTable.tables({ visible: true, api: true });
        tables.columns.adjust().fixedColumns().relayout();
    };

    // Re-adjust columns on tab or modal shown
    $('a[data-bs-toggle="tab"], a[data-bs-toggle="pill"], #System-Modal')
        .on('shown.bs.tab shown.bs.modal', adjustColumns);
};

export const manageActionDropdown = (options = { hideOnly: false }) => {
    const actionDropdown = document.querySelector('.action-dropdown');
    const masterCheckbox = document.getElementById('datatable-checkbox');
    const childCheckboxes = Array.from(document.querySelectorAll('.datatable-checkbox-children'));

    if (!actionDropdown) return;

    if (options.hideOnly) {
        // Hide dropdown and uncheck master checkbox
        actionDropdown.classList.add('d-none');
        if (masterCheckbox) masterCheckbox.checked = false;
        childCheckboxes.forEach(chk => (chk.checked = false));
    } else {
        // Toggle dropdown based on checked children
        const checkedCount = childCheckboxes.filter(chk => chk.checked).length;
        actionDropdown.classList.toggle('d-none', checkedCount === 0);
    }
};

export const initializeDatatable = ({
    selector,
    ajaxUrl,
    transaction,
    columns = [],
    columnDefs = [],
    lengthMenu = [[10, 5, 25, 50, 100, -1], [10, 5, 25, 50, 100, 'All']],
    order = [[1, 'asc']],
    onRowClick = null
}) => {
    const tableElement = document.querySelector(selector);
    if (!tableElement) return;

    manageActionDropdown();

    const pageId = document.getElementById('page-id')?.value || '';
    const pageLink = document.getElementById('page-link')?.getAttribute('href') || '';

    const settings = {
        ajax: {
            url: ajaxUrl,
            method: 'POST',
            dataType: 'json',
            data: { transaction : transaction, page_id: pageId, page_link: pageLink },
            dataSrc: '',
            error: (xhr, status, error) => handleSystemError(xhr, status, error)
        },
        lengthChange: false,
        order,
        columns,
        columnDefs,
        lengthMenu,
        autoWidth: false,
        language: {
            emptyTable: 'No data found',
            sLengthMenu: '_MENU_',
            info: '_START_ - _END_ of _TOTAL_ items',
            loadingRecords: 'Just a moment while we fetch your data...'
        },
        fnDrawCallback: () => {
            readjustDatatableColumn();

            if (typeof onRowClick === 'function') {
                $(`${selector} tbody`).off('click').on('click', 'tr td:nth-child(n+2)', function () {
                    const rowData = $(selector).DataTable().row($(this).closest('tr')).data();
                    onRowClick(rowData);
                });
            }
        }
    };

    destroyDatatable(selector);
    $(selector).DataTable(settings);
};

export const datatableLength = (selector) => {
    $('#datatable-length')
    .on('change', function() {
        let table = $(selector).DataTable();
        let length = $(this).val(); 
        table.page.len(length).draw();
    });
};

export const datatableSearch = (selector) => {
    $('#datatable-search')
    .on('keyup', function () {
        let table = $(selector).DataTable();
        table.search(this.value).draw();
    });
};

export const toggleSingleTableCheckBox = () => {
    $(document).on('click','.datatable-checkbox-children',function() {
        manageActionDropdown();
    });
};

export const toggleAllTableCheckBox = () => {
    $(document).on('click','#datatable-checkbox',function() {
        let status = $(this).is(':checked') ? true : false;
        $('.datatable-checkbox-children').prop('checked',status);
    
        manageActionDropdown();
    });
};