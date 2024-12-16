<?php
namespace App\Core;

use PDO;
use PDOException;
use RuntimeException;

class Database {
    private static $instance = null; // Singleton instance for reusing connections
    private $connection;

    private function __construct($host, $dbname, $username, $password) {
        // Use environment variables for sensitive data (already partially implemented)
        try {
            $options = [
                PDO::ATTR_EMULATE_PREPARES => false, // Use native prepared statements for security
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, // Throw exceptions for errors
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, // Fetch results as associative arrays by default
                PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci", // Set proper charset for security
                PDO::ATTR_PERSISTENT => true // Enable persistent connections for performance
            ];

            // Initialize the PDO connection
            $this->connection = new PDO(
                "mysql:host=$host;dbname=$dbname;charset=utf8mb4",
                $username,
                $password,
                $options
            );

        } catch (PDOException $e) {
            // Log the error securely without exposing sensitive details
            error_log('Database connection failed: ' . $e->getMessage());
            throw new RuntimeException('Database connection error.');
        }
    }

    /**
     * Get the singleton instance of the database connection.
     */
    public static function getInstance($host, $dbname, $username, $password) {
        if (self::$instance === null) {
            self::$instance = new self($host, $dbname, $username, $password);
        }
        return self::$instance;
    }

    /**
     * Get the PDO connection.
     */
    public function getConnection() {
        return $this->connection;
    }
}
