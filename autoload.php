<?php
spl_autoload_register(function ($class) {
    $baseDir = __DIR__ . '/';
    
    $file = $baseDir . str_replace('\\', '/', $class) . '.php';

    
    if (file_exists($file)) {
        require_once $file;
    } else {
        throw new Exception("Class file not found: $file");
    }
});