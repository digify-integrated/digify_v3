<?php
declare(strict_types=1);

spl_autoload_register(function (string $class): void {
    // Define base directory for your project classes
    $baseDir = __DIR__ . '/../';

    // Replace namespace separators with directory separators
    $relativePath = str_replace('\\', DIRECTORY_SEPARATOR, $class) . '.php';

    $file = $baseDir . $relativePath;

    if (is_file($file)) {
        require $file;
    } else {
        // Fail loudly so mistakes surface during dev
        throw new RuntimeException("Autoloader: Class file not found for [$class] at path [$file]");
    }
});
