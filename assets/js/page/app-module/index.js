import { initializeDatatable, datatableLength, datatableSearch, toggleSingleTableCheckBox, toggleAllTableCheckBox } from '../../utilities/datatable.js';
import { generateExportColumns, exportData } from '../../utilities/export.js';

$(document).ready(function () {
    datatableLength('#app-module-table');
    datatableSearch('#app-module-table');
    toggleSingleTableCheckBox();
    toggleAllTableCheckBox();
    generateExportColumns('app_module');
    exportData('app_module');

    initializeDatatable({
        selector: '#app-module-table',
        ajaxUrl: './app/Controllers/AppModuleController.php',
        transaction: 'generate app module table',
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'APP_MODULE_NAME' }
        ],
        columnDefs: [
            { width: '5%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 }
        ],
        onRowClick: (rowData) => {
            if (rowData?.LINK) window.location.href = rowData.LINK;
        }
    });

    
});
