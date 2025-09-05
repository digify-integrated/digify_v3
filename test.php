<?php
require_once './config/config.php';

use App\Core\Security;

$plainPassword = 'P@ssw0rd'; // 8 random hex chars (~8 chars long)

// Hash the password using bcrypt
$hashedPassword = password_hash($plainPassword, PASSWORD_BCRYPT);

// Output both
echo "Plain Password: " . $plainPassword . PHP_EOL ."<br/>";
echo "Hashed Password: " . $hashedPassword . PHP_EOL . "<br/>";

$security = new Security();

echo "Encrypted Password: " . $security->encryptData($plainPassword) . "<br/>";

$hash = '$2y$10$OagAFFpuCIgx1ItaYbVS.u9YevbAuQiVeWfcCqgBjoRUDv4aD1xOu';

if (password_verify($plainPassword, $hash)) {
    echo "Password is valid!";
} else {
    echo "Invalid password.";
}