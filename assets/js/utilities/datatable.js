import { handleSystemError } from '../modules/system-errors.js';

export const reloadDatatable = (datatableSelector) => {
    toggleHideActionDropdown();

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

    $('a[data-bs-toggle="tab"], a[data-bs-toggle="pill"], #System-Modal')
        .on('shown.bs.tab shown.bs.modal', adjustColumns);
};

export const manageActionDropdown = (options = { hideOnly: false }) => {
    const actionDropdown    = document.querySelector('.action-dropdown');
    const masterCheckbox    = document.getElementById('datatable-checkbox');
    const childCheckboxes   = Array.from(document.querySelectorAll('.datatable-checkbox-children'));

    if (!actionDropdown) return;

    if (options.hideOnly) {
        actionDropdown.classList.add('d-none');
        if (masterCheckbox) masterCheckbox.checked = false;
        childCheckboxes.forEach(chk => (chk.checked = false));
    } else {
        const checkedCount = childCheckboxes.filter(chk => chk.checked).length;
        actionDropdown.classList.toggle('d-none', checkedCount === 0);
    }
};

export const toggleHideActionDropdown = () =>{
    const actionDropdown    = document.querySelector('.action-dropdown');
    const masterCheckbox    = document.getElementById('datatable-checkbox');

    if (actionDropdown && masterCheckbox) {
        actionDropdown.classList.add('d-none');
        masterCheckbox.checked = false;
    }
}

export const initializeDatatable = ({
    selector,
    ajaxUrl,
    transaction,
    ajaxData        = {},
    columns         = [],
    columnDefs      = [],
    lengthMenu      = [[10, 5, 25, 50, 100, -1], [10, 5, 25, 50, 100, 'All']],
    order           = [[1, 'asc']],
    onRowClick      = null
}) => {
    const tableElement = document.querySelector(selector);

    if (!tableElement) return;

    manageActionDropdown();

    const pageId    = document.getElementById('page-id')?.value || '';
    const pageLink  = document.getElementById('page-link')?.getAttribute('href') || '';

    const settings = {
        ajax: {
            url: ajaxUrl,
            method: 'POST',
            dataType: 'json',
            data: { 
                transaction : transaction,
                page_id: pageId,
                page_link: pageLink,
                ...ajaxData
            },
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

export const initializeDatatableControls = (selector) => {
    const $lengthDropdown = $('#datatable-length');
    const $searchInput    = $('#datatable-search');

    if ($lengthDropdown.length) {
        $lengthDropdown.off('change').on('change', function () {
            const table = $(selector).DataTable();
            table.page.len($(this).val()).draw();
        });
    }

    if ($searchInput.length) {
        $searchInput.off('keyup').on('keyup', function () {
            const table = $(selector).DataTable();
            table.search(this.value).draw();
        });
    }

    $(document)
        .off('click.datatableCheckbox')
        .on('click.datatableCheckbox', '.datatable-checkbox-children', manageActionDropdown)
        .on('click.datatableCheckbox', '#datatable-checkbox', function () {
            const status = $(this).is(':checked');
            $('.datatable-checkbox-children').prop('checked', status);
            manageActionDropdown();
        });
};

export const initializeSubDatatableControls = (search, length, selector) => {
    $(length).off('change').on('change', function() {
        const table = $(selector).DataTable();
        const length = $(this).val();
        table.page.len(length).draw();
    });

    $(search).off('keyup').on('keyup', function () {
        const table = $(selector).DataTable();
        table.search(this.value).draw();
    });
};
