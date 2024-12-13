<?php

class Router {

    // Array of routes with methods (GET, POST, etc.)
    private $routes = [];

    // Add a route with an HTTP method (GET, POST, etc.)
    public function add($method, $route, $controller, $action) {
        $this->routes[$method][$route] = [
            'controller' => $controller,
            'action' => $action
        ];
    }

    // Dispatch the current request to the appropriate controller and action
    public function dispatch($url, $method) {
        // Remove query strings or fragments (e.g., /home?id=1 or /home#about)
        $url = strtok($url, '?');

        // Check if the route exists for the given HTTP method
        if (isset($this->routes[$method][$url])) {
            $controllerName = $this->routes[$method][$url]['controller'];
            $actionName = $this->routes[$method][$url]['action'];

            // Include the controller file
            require_once __DIR__ . '/../controllers/' . $controllerName . '.php';

            // Instantiate the controller
            $controller = new $controllerName();

            // Call the action method
            if (method_exists($controller, $actionName)) {
                $controller->$actionName();
            } else {
                die("Action not found: $actionName");
            }
        } else {
            die("Route not found: $url");
        }
    }

    // Parse dynamic routes with parameters (same as before)
    public function parseDynamicRoute($url, $method) {
        foreach ($this->routes[$method] as $route => $info) {
            // Check for dynamic parameters (e.g., /user/{id})
            $pattern = preg_replace('/{(\w+)}/', '(\w+)', $route);
            $pattern = "#^$pattern$#"; // Create a regex pattern

            if (preg_match($pattern, $url, $matches)) {
                $controllerName = $info['controller'];
                $actionName = $info['action'];

                // Include the controller file
                require_once __DIR__ . '/../controllers/' . $controllerName . '.php';

                // Instantiate the controller
                $controller = new $controllerName();

                // Get parameters (skip first match, which is the full route)
                array_shift($matches);
                call_user_func_array([$controller, $actionName], $matches);
                return;
            }
        }

        // If no route matches, show an error
        die("Route not found: $url");
    }
}

?>