<?php

// View class for rendering templates
class View {

    // Property to hold data to be passed to views
    private $data = [];

    /**
     * Set data to be passed to the view
     * @param array $data The data to pass to the view
     */
    public function setData($data) {
        $this->data = $data;
    }

    /**
     * Render a view file and pass the data to it
     * @param string $view The name of the view file
     */
    public function render($view) {
        $viewPath = 'views/' . $view . '.php';
        
        if (file_exists($viewPath)) {
            // Extract data to make variables available inside the view
            extract($this->data);
            
            // Include the view file
            include $viewPath;
        } else {
            die("View not found: $view");
        }
    }

    /**
     * Include a partial view (like a header, footer, etc.)
     * @param string $partial The name of the partial view
     */
    public function includePartial($partial) {
        $partialPath = 'views/partials/' . $partial . '.php';
        
        if (file_exists($partialPath)) {
            include $partialPath;
        } else {
            die("Partial view not found: $partial");
        }
    }
}
