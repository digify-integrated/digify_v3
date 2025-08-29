<?php
namespace App\Core;

use PDO;
use PDOException;
use RuntimeException;

/**
 * Class Database
 *
 * A singleton class for managing a PDO database connection.
 *
 * Usage:
 *   $db = Database::getInstance(DB_HOST, DB_NAME, DB_USER, DB_PASS)->getConnection();
 *
 * @package App\Core
 */
class Database
{
    /**
     * @var Database|null Singleton instance of the Database class
     */
    private static ?Database $instance = null;

    /**
     * @var PDO Active PDO connection
     */
    private PDO $connection;

    /**
     * Database constructor.
     *
     * Establishes a PDO connection with the provided database credentials.
     *
     * @param string $host     Database host
     * @param string $dbname   Database name
     * @param string $username Database username
     * @param string $password Database password
     *
     * @throws RuntimeException If connection fails
     */
    private function __construct(
        string $host,
        string $dbname,
        string $username,
        string $password
    ) {
        try {
            $options = [
                PDO::ATTR_EMULATE_PREPARES   => false,
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci",
                PDO::ATTR_PERSISTENT         => true
            ];

            $this->connection = new PDO(
                "mysql:host={$host};dbname={$dbname};charset=utf8mb4",
                $username,
                $password,
                $options
            );
        } catch (PDOException $e) {
            error_log('Database connection failed: ' . $e->getMessage());
            throw new RuntimeException('Database connection error.');
        }
    }

    /**
     * Returns a singleton instance of the Database class.
     *
     * @param string $host     Database host
     * @param string $dbname   Database name
     * @param string $username Database username
     * @param string $password Database password
     *
     * @return Database Singleton instance
     */
    public static function getInstance(
        string $host,
        string $dbname,
        string $username,
        string $password
    ): Database {
        if (self::$instance === null) {
            self::$instance = new self($host, $dbname, $username, $password);
        }

        return self::$instance;
    }

    /**
     * Get the active PDO connection.
     *
     * @return PDO Active PDO connection
     */
    public function getConnection(): PDO
    {
        return $this->connection;
    }
}
