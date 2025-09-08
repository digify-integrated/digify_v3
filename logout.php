<?php
session_start();

function redirect(string $location): void {
    header("Location: $location");
    exit;
}

// Handle logout
if (isset($_GET['logout'])) {
    // Unset all session variables
    $_SESSION = [];

    // Finally destroy the session
    session_destroy();

    redirect('index.php');
}

// Block access if user not logged in
if (empty($_SESSION['user_account_id'])) {
    redirect('index.php');
}

// If logged in, send to app
redirect('apps.php');
