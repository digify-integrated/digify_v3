import { disableButton, enableButton, resetForm } from '../../utilities/form-utilities.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

$(document).ready(function () {
    $(document).on('click','#reset-import',function() {
        $('.upload-file-default-preview').removeClass('d-none');
        $('.upload-file-preview').addClass('d-none');

        resetForm('upload_form');

        document.getElementById('upload-file-preview-table').innerHTML = '';
    });

    $('#upload_form').validate({
        rules: {
            import_file: {
                required: true
            }
        },
        messages: {
            import_file: {
                required: 'Choose the import file'
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

            const page_link = document.getElementById('page-link').getAttribute('href');
            
            let transaction = $('.upload-file-preview').hasClass('d-none') 
            ? 'generate import data preview' 
            : 'save import data';

            var formData = new FormData(form);
            formData.append('transaction', transaction);

            $.ajax({
                type: 'POST',
                url: './app/Controllers/ImportController.php',
                data: formData,
                processData: false,
                contentType: false,
                dataType: 'JSON',
                beforeSend: function() {
                    disableButton(['submit-upload', 'import', 'reset-import']);
                },
                success: function(response) {
                    if (response.success) {
                        const $preview = $('.upload-file-preview');
                        const $defaultPreview = $('.upload-file-default-preview');

                        if ($preview.hasClass('d-none')) {
                            $defaultPreview.addClass('d-none');
                            $preview.removeClass('d-none');

                            document.getElementById('upload-file-preview-table').innerHTML = response.preview;

                            $('#upload-modal').modal('hide');
                            enableButton(['submit-upload', 'import', 'reset-import']);
                        } else {
                            setNotification(response.title, response.message, response.message_type);
                            window.location.href = page_link;
                        }
                    }
                    else {
                        showNotification(response.title, response.message, response.message_type);
                        enableButton(['submit-upload', 'import', 'reset-import']);
                    }
                },
                error: function(xhr, status, error) {
                    enableButton(['submit-upload', 'import', 'reset-import']);
                    handleSystemError(xhr, status, error);
                }
            });

            return false;
        }
    });
});
