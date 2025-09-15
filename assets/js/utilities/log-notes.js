import { handleSystemError } from '../modules/system-errors.js';
import { showNotification } from '../modules/notifications.js';

export const attachLogNotesHandler = (triggerSelector, sourceSelector, type) => {
    $(document).on('click', triggerSelector, () => {
        const id = $(sourceSelector).text().trim();
        logNotes(type, id);
    });
};

export const attachLogNotesClassHandler = (sourceSelector, id) => {
    logNotes(sourceSelector, id);
};

export const logNotes = (database_table, reference_id) => {
    const transaction = 'fetch log notes';

    $.ajax({
        type: 'POST',
        url: './app/Controllers/LogNotesController.php',
        dataType: 'json',
        data: {
            transaction : transaction, 
            database_table : database_table, 
            reference_id : reference_id 
        },
        success: function (response) {
            if(response.success){
                document.getElementById('log-notes').innerHTML = response.log_notes;
            }
            else{
                if(response.invalid_session){
                    setNotification(response.title, response.message, response.message_type);
                    window.location.href = response.redirect_link;
                }
                else{
                    showNotification(response.title, response.message, response.message_type);
                }
            }
        },
        error: function(xhr, status, error) {
            handleSystemError(xhr, status, error);
        }
    });
}