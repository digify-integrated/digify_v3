<?php
namespace App\Core;

use App\Core\Database; // Assuming Database.php is in the same namespace
use PDO;

abstract class Model {
    protected $db;

    /**
     * Constructor to initialize the database connection.
     */
    public function __construct() {
        $dbInstance = Database::getInstance(
            DB_HOST, 
            DB_NAME, 
            DB_USER, 
            DB_PASS
        );
        $this->db = $dbInstance->getConnection();
    }

    /**
     * Execute a raw SQL query and return the result.
     *
     * @param string $query The SQL query to execute.
     * @param array $params Optional parameters for prepared statements.
     * @return mixed The query result.
     */
    public function query(string $query, array $params = []) {
        try {
            $stmt = $this->db->prepare($query);
            $stmt->execute($params);
            return $stmt;
        } catch (\PDOException $e) {
            // Log the error for debugging
            error_log("Database query error: " . $e->getMessage());
            return false;
        }
    }

    /**
     * Fetch all rows from a query.
     *
     * @param string $query The SQL query to execute.
     * @param array $params Optional parameters for prepared statements.
     * @return array|false Array of rows or false on failure.
     */
    public function fetchAll(string $query, array $params = []) {
        $stmt = $this->query($query, $params);
        return $stmt ? $stmt->fetchAll(PDO::FETCH_ASSOC) : false;
    }

    /**
     * Fetch a single row from a query.
     *
     * @param string $query The SQL query to execute.
     * @param array $params Optional parameters for prepared statements.
     * @return array|false A single row or false on failure.
     */
    public function fetch(string $query, array $params = []) {
        $stmt = $this->query($query, $params);
        return $stmt ? $stmt->fetch(PDO::FETCH_ASSOC) : false;
    }

    /**
     * Insert a record into the database.
     *
     * @param string $table The name of the table.
     * @param array $data An associative array of column names and values.
     * @return bool Whether the insert was successful.
     */
    public function insert(string $table, array $data) {
        $columns = implode(',', array_keys($data));
        $placeholders = implode(',', array_fill(0, count($data), '?'));

        $query = "INSERT INTO $table ($columns) VALUES ($placeholders)";
        return $this->query($query, array_values($data));
    }

    /**
     * Update a record in the database.
     *
     * @param string $table The name of the table.
     * @param array $data Associative array of column names and values to update.
     * @param string $where SQL WHERE clause.
     * @param array $params Parameters for the WHERE clause.
     * @return bool Whether the update was successful.
     */
    public function update(string $table, array $data, string $where, array $params = []) {
        $setClause = implode(',', array_map(fn($key) => "$key = ?", array_keys($data)));
        $query = "UPDATE $table SET $setClause WHERE $where";

        return $this->query($query, array_merge(array_values($data), $params));
    }

    /**
     * Delete a record from the database.
     *
     * @param string $table The name of the table.
     * @param string $where SQL WHERE clause.
     * @param array $params Parameters for the WHERE clause.
     * @return bool Whether the delete was successful.
     */
    public function delete(string $table, string $where, array $params = []) {
        $query = "DELETE FROM $table WHERE $where";
        return $this->query($query, $params);
    }
}

?>