export function disableButton(buttonId) {
    const button = document.getElementById(buttonId);
    if (button) button.disabled = true;
}

export function enableButton(buttonId) {
    const button = document.getElementById(buttonId);
    if (button) button.disabled = false;
}