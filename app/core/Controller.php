<?php

// Base controller class
class Controller {

    // Property to hold the model instance
    protected $model;
    // Property to hold data passed to the view
    protected $data = [];

    // Constructor
    public function __construct() {
        // Start the session to enable flash messaging and session handling
        session_start();
    }

    /**
     * Load the model for the controller
     * This method will automatically load a model based on the controller name
     */
    protected function loadModel($model) {
        $modelPath = 'models/' . $model . '.php'; // Define the path to the model
        
        if (file_exists($modelPath)) {
            require_once $modelPath; // Include the model
            $this->model = new $model(); // Instantiate the model
        } else {
            die("Model not found: $model");
        }
    }

    /**
     * Render a view
     * @param string $view Name of the view to render
     * @param array $data Data to pass to the view
     */
    protected function render($view, $data = []) {
        // Merge data passed to the view with the controller's data
        $this->data = array_merge($this->data, $data);
        
        // Define the path to the view
        $viewPath = 'views/' . $view . '.php';
        
        // Check if the view exists and include it
        if (file_exists($viewPath)) {
            // Extract data to make variables available inside the view
            extract($this->data);
            require_once $viewPath;
        } else {
            die("View not found: $view");
        }
    }

    /**
     * Redirect the user to another page
     * @param string $url The URL to redirect to
     */
    protected function redirect($url) {
        header("Location: " . $url);
        exit;
    }

    /**
     * Set a flash message
     * Flash messages are temporary messages that are shown once and then removed
     * @param string $key The key to identify the flash message
     * @param string $message The message content
     */
    public function setFlash($key, $message) {
        $_SESSION[$key] = $message;
    }

    /**
     * Get a flash message
     * Retrieves a flash message and removes it from the session
     * @param string $key The key of the flash message
     * @return string|null The message or null if not set
     */
    public function getFlash($key) {
        if (isset($_SESSION[$key])) {
            $message = $_SESSION[$key];
            unset($_SESSION[$key]); // Remove the flash message
            return $message;
        }
        return null;
    }
}

?>