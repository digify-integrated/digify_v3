<?php
// Database.php
class Database {
    private $pdo; // PDO instance
    private $host = DB_HOST;
    private $dbname = DB_NAME;
    private $username = DB_USER;
    private $password = DB_PASSWORD;
    private $charset = DB_CHARSET;

    public function __construct() {
        // Establish the database connection
        $this->connect();
    }

    // Connect to the database
    private function connect() {
        try {
            // Set DSN (Data Source Name)
            $dsn = "mysql:host={$this->host};dbname={$this->dbname};charset={$this->charset}";

            // Create a PDO instance
            $this->pdo = new PDO($dsn, $this->username, $this->password);

            // Set PDO error mode to exception
            $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            // Optionally set default fetch mode
            $this->pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

        } catch (PDOException $e) {
            // Handle connection errors
            die("Database connection failed: " . $e->getMessage());
        }
    }

    // Query the database (SELECT)
    public function query($sql, $params = []) {
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt;
    }

    // Fetch data from the database (SELECT)
    public function fetch($sql, $params = []) {
        $stmt = $this->query($sql, $params);
        return $stmt->fetch();
    }

    // Fetch all rows (SELECT)
    public function fetchAll($sql, $params = []) {
        $stmt = $this->query($sql, $params);
        return $stmt->fetchAll();
    }

    // Execute an INSERT, UPDATE, DELETE query
    public function exec($sql, $params = []) {
        $stmt = $this->pdo->prepare($sql);
        return $stmt->execute($params);
    }

    // Begin a transaction
    public function beginTransaction() {
        return $this->pdo->beginTransaction();
    }

    // Commit a transaction
    public function commit() {
        return $this->pdo->commit();
    }

    // Rollback a transaction
    public function rollBack() {
        return $this->pdo->rollBack();
    }

    // Get the last insert ID
    public function lastInsertId() {
        return $this->pdo->lastInsertId();
    }
}

?>