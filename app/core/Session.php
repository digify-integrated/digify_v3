<?php

class Session {

    // Start the session if it's not already started
    public static function start() {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
    }

    // Set a session variable
    public static function set($key, $value) {
        $_SESSION[$key] = $value;
    }

    // Get a session variable
    public static function get($key) {
        return isset($_SESSION[$key]) ? $_SESSION[$key] : null;
    }

    // Check if a session variable is set
    public static function has($key) {
        return isset($_SESSION[$key]);
    }

    // Remove a session variable
    public static function remove($key) {
        if (isset($_SESSION[$key])) {
            unset($_SESSION[$key]);
        }
    }

    // Destroy the entire session (logout)
    public static function destroy() {
        $_SESSION = [];
        session_destroy();
    }

    // Regenerate the session ID for security purposes
    public static function regenerate() {
        if (session_status() == PHP_SESSION_ACTIVE) {
            session_regenerate_id(true); // Replace the current session ID with a new one
        }
    }

    // Get all session data
    public static function all() {
        return $_SESSION;
    }
}

?>