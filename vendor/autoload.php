<?php
declare(strict_types=1);

spl_autoload_register(function (string $class): void {
    $baseDir = __DIR__ . '/../';

    // Special handling for PHPMailer
    if (str_starts_with($class, 'PHPMailer\\PHPMailer')) {
        $relativePath = 'vendor/phpmailer/phpmailer/src/' . str_replace('PHPMailer\\PHPMailer\\', '', $class) . '.php';
    } else {
        $relativePath = str_replace('\\', DIRECTORY_SEPARATOR, $class) . '.php';
    }

    $file = $baseDir . $relativePath;

    if (is_file($file)) {
        require $file;
    } else {
        throw new RuntimeException("Autoloader: Class file not found for [$class] at path [$file]");
    }
});
