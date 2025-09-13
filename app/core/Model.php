<?php
namespace App\Core;

use PDO;
use PDOStatement;
use PDOException;

/**
 * Class Model
 *
 * Abstract base class for application models.
 * Provides database query helpers and a shared PDO connection.
 *
 * Usage:
 *   class User extends Model {
 *       public function getUsers(): array {
 *           return $this->fetchAll("SELECT * FROM users");
 *       }
 *   }
 *
 * @package App\Core
 */
abstract class Model
{
    /**
     * @var PDO Active PDO database connection
     */
    protected PDO $db;

    /**
     * Model constructor.
     *
     * Initializes the PDO database connection using Database singleton.
     */
    public function __construct()
    {
        $dbInstance     = Database::getInstance(DB_HOST, DB_NAME, DB_USER, DB_PASS);
        $this->db       = $dbInstance->getConnection();
    }

    /**
     * Prepares and executes a database query.
     *
     * @param string $query  SQL query with placeholders
     * @param array  $params Parameters to bind into the query
     *
     * @return PDOStatement|false Returns PDOStatement on success, false on failure
     */
    public function query(string $query, array $params = []): PDOStatement|false
    {
        try {
            $stmt = $this->db->prepare($query);

            // Log query with masked parameters for debugging
            error_log('Executing query: ' . $this->maskQuery($query, $params));

            $stmt->execute($params);
            return $stmt;
        } catch (PDOException $e) {
            error_log('Database query error: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Fetch all rows from a query.
     *
     * @param string $query  SQL query
     * @param array  $params Parameters to bind
     *
     * @return array Returns an array of results, or empty array if none
     */
    public function fetchAll(string $query, array $params = []): array
    {
        $stmt = $this->query($query, $params);
        return $stmt ? $stmt->fetchAll(PDO::FETCH_ASSOC) : [];
    }

    /**
     * Fetch a single row from a query.
     *
     * @param string $query  SQL query
     * @param array  $params Parameters to bind
     *
     * @return array|null Returns associative array of row, or null if none
     */
    public function fetch(string $query, array $params = []): ?array
    {
        $stmt = $this->query($query, $params);
        $result = $stmt ? $stmt->fetch(PDO::FETCH_ASSOC) : null;

        // Convert false (no rows) to null
        return $result !== false ? $result : null;
    }

    /**
     * Masks parameters in SQL queries for safe logging.
     *
     * @param string $query  SQL query
     * @param array  $params Parameters to bind
     *
     * @return string Query with masked parameters
     */
    private function maskQuery(string $query, array $params): string
    {
        foreach ($params as $key => $value) {
            $valuePlaceholder   = is_numeric($value) ? '[NUMERIC_PARAM]' : '[STRING_PARAM]';
            $placeholder        = is_int($key) ? '?' : ":$key";
            $query              = str_replace($placeholder, $valuePlaceholder, $query);
        }
        return $query;
    }
}
