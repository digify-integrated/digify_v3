<?php

class Middleware {

    // Example of an authentication middleware
    public static function auth() {
        // Check if user is logged in (session check)
        if (!Session::has('logged_in') || !Session::get('logged_in')) {
            // Redirect to login page if not authenticated
            header('Location: /auth/login');
            exit;
        }
    }

    // Other middleware methods (e.g., logging, input validation, etc.) can go here
}

?>