import { disableButton, enableButton } from '../utilities/form-utilities.js';
import { handleSystemError } from '../modules/system-errors.js';
import { showNotification } from '../modules/notifications.js';

export const initializeDualListBoxIcon = () => {
    $('.moveall i').removeClass().addClass('ki-duotone ki-right');
    $('.removeall i').removeClass().addClass('ki-duotone ki-left');
    $('.move i').removeClass().addClass('ki-duotone ki-right');
    $('.remove i').removeClass().addClass('ki-duotone ki-left');

    $('.moveall').removeClass('btn-default').addClass('btn-primary');
    $('.removeall').removeClass('btn-default').addClass('btn-primary');
    $('.move').removeClass('btn-default').addClass('btn-primary');
    $('.remove').removeClass('btn-default').addClass('btn-primary');
}

export const generateExportColumns = (table_name) => {
    $(document).on('click','#export-data',function() {
        const transaction = 'generate export column option';
    
        $.ajax({
            url: './app/Controllers/ExportController.php',
            method: 'POST',
            dataType: 'json',
            data: {
                transaction: transaction,
                table_name: table_name
            },
            success: function(response) {
                var select = document.getElementById('table_column');
                select.options.length = 0;

                response.forEach(function(opt) {
                    var option = new Option(opt.text, opt.id);
                    select.appendChild(option);
                });
            },
            error: function(xhr, status, error) {
                handleSystemError(xhr, status, error);
            },
            complete: function() {
                if ($('#table_column').length) {
                    $('#table_column').bootstrapDualListbox({
                        nonSelectedListLabel: 'Non-selected',
                        selectedListLabel: 'Selected',
                        preserveSelectionOnMove: 'moved',
                        moveOnSelect: false,
                        helperSelectNamePostfix: false,
                        sortByInputOrder: true
                    });

                    $('#table_column').on('change', function() {
                        $('#table_column option:selected').each(function() {
                            let value = $(this).val();
                            if (!selectedColumnsOrder.includes(value)) {
                                selectedColumnsOrder.push(value);
                            }
                        });

                        $('#table_column option:not(:selected)').each(function() {
                            let value = $(this).val();
                            selectedColumnsOrder = selectedColumnsOrder.filter(item => item !== value);
                        });
                    });

                    $('#table_column').bootstrapDualListbox('refresh', true);
                    initializeDualListBoxIcon();
                }
            }
        });     
    });
}

let selectedColumnsOrder = [];

export const exportData = (table_name) => {
    $(document).on('click','#submit-export',function() {

        const transaction = 'export data';
        var export_to = $('input[name="export_to"]:checked').val();

        var table_column = selectedColumnsOrder;

        let export_id = [];

        $('.datatable-checkbox-children').each((index, element) => {
            if ($(element).is(':checked')) {
                export_id.push(element.value);
            }
        });

        if (export_id.length === 0) {
            showNotification('Export Data', 'Choose the data you want to export.', 'error');
            return;
        }

        if (table_column.length === 0) {
            showNotification('Export Data', 'Choose the columns you want to export.', 'error');
            return;
        }

        $.ajax({
            type: 'POST',
            url: './app/Controllers/ExportController.php',
            data: {
                transaction: transaction,
                export_id: export_id,
                export_to: export_to,
                table_column: table_column,
                table_name: table_name  
            },
            xhrFields: {
                responseType: 'blob'
            },
            beforeSend: function() {
                disableButton('submit-export');
            },
            success: function (response, status, xhr) {
                var filename = "";                   
                var disposition = xhr.getResponseHeader('Content-Disposition');

                if (disposition && disposition.indexOf('attachment') !== -1) {
                    var matches = /filename="(.+)"/.exec(disposition);
                    if (matches != null && matches[1]) {
                        filename = matches[1];
                    }
                }

                var blob = new Blob([response], { type: xhr.getResponseHeader('Content-Type') });
                var link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = filename || "export." + export_to;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            },
            error: function(xhr, status, error) {
                handleSystemError(xhr, status, error);
            },
            complete: function() {
                enableButton('submit-export');
            }
        });
    });
}