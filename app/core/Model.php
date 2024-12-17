<?php 
namespace App\Core;

use App\Core\Database;
use PDO;

abstract class Model {
    protected $db;

    public function __construct() {
        $dbInstance = Database::getInstance(
            DB_HOST, 
            DB_NAME, 
            DB_USER, 
            DB_PASS
        );
        $this->db = $dbInstance->getConnection();
    }

    public function query(string $query, array $params = []) {
        try {
            $stmt = $this->db->prepare($query);
            $stmt->execute($params);
            return $stmt;
        }
        catch (\PDOException $e) {
            error_log("Database query error: " . $e->getMessage());
            return false;
        }
    }
    
    public function fetchAll(string $query, array $params = []) {
        $stmt = $this->query($query, $params);
        if ($stmt) {
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $stmt->closeCursor();
            return $result;
        }
        return false;
    }
    
    public function fetch(string $query, array $params = []) {
        $stmt = $this->query($query, $params);
        if ($stmt) {
            $result = $stmt->fetch(PDO::FETCH_ASSOC);
            $stmt->closeCursor();
            return $result;
        }
        return false;
    }
}
?>