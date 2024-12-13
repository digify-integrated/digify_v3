<?php

// Base model class
class Model {

    // Property to hold the database connection
    protected $db;

    // Constructor
    public function __construct() {
        // Initialize the database connection
        $this->db = new Database();
    }

    /**
     * Fetch a single record by its ID
     * @param string $table The table name
     * @param int $id The ID of the record
     * @return array|null The record data or null if not found
     */
    public function getById($table, $id) {
        $sql = "SELECT * FROM $table WHERE id = :id LIMIT 1";
        $params = ['id' => $id];
        $result = $this->db->fetch($sql, $params);
        return $result;
    }

    /**
     * Fetch all records from a table
     * @param string $table The table name
     * @return array The list of records
     */
    public function getAll($table) {
        $sql = "SELECT * FROM $table";
        $result = $this->db->fetchAll($sql);
        return $result;
    }

    /**
     * Insert a new record into a table
     * @param string $table The table name
     * @param array $data The data to insert (associative array of column => value)
     * @return bool Whether the insert was successful
     */
    public function insert($table, $data) {
        // Prepare the SQL insert query dynamically
        $columns = implode(", ", array_keys($data));
        $values = ":" . implode(", :", array_keys($data));
        
        $sql = "INSERT INTO $table ($columns) VALUES ($values)";
        return $this->db->exec($sql, $data);
    }

    /**
     * Update a record in a table
     * @param string $table The table name
     * @param array $data The data to update (associative array of column => value)
     * @param int $id The ID of the record to update
     * @return bool Whether the update was successful
     */
    public function update($table, $data, $id) {
        $set = "";
        foreach ($data as $column => $value) {
            $set .= "$column = :$column, ";
        }
        $set = rtrim($set, ", ");
        
        $data['id'] = $id; // Add the ID to the data array for the WHERE clause
        
        $sql = "UPDATE $table SET $set WHERE id = :id";
        return $this->db->exec($sql, $data);
    }

    /**
     * Delete a record from a table
     * @param string $table The table name
     * @param int $id The ID of the record to delete
     * @return bool Whether the delete was successful
     */
    public function delete($table, $id) {
        $sql = "DELETE FROM $table WHERE id = :id";
        $params = ['id' => $id];
        return $this->db->exec($sql, $params);
    }

    /**
     * Count the number of records in a table
     * @param string $table The table name
     * @return int The number of records
     */
    public function count($table) {
        $sql = "SELECT COUNT(*) FROM $table";
        $result = $this->db->fetch($sql);
        return $result ? $result['COUNT(*)'] : 0;
    }
}

?>