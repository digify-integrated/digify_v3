<?php
require_once '../../config/config.php';

spl_autoload_register(function ($class) {
    // Set the base directory to the project root
    $baseDir = __DIR__ . '/';

    // Convert namespace to file path
    $file = $baseDir . str_replace('\\', '/', $class) . '.php';

    // Check if the file exists
    if (file_exists($file)) {
        require_once $file;
    } else {
        throw new Exception("Class file not found: $file");
    }
});

?>