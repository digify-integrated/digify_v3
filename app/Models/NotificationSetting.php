<?php
namespace App\Models;

use App\Core\Model;

class NotificationSettingModel extends Model {

    // Fetch all items from the database
    public function getAllItems() {
        $sql = "SELECT * FROM items";  // Assuming a table named 'items'
        return $this->fetchAll($sql);
    }

    // Get a single item by its ID
    public function getItemById($id) {
        $sql = "SELECT * FROM items WHERE id = :id";
        return $this->fetch($sql, ['id' => $id]);
    }
}
?>