<?php
$plainPassword = 'P@ssw0rd'; // 8 random hex chars (~8 chars long)

// Hash the password using bcrypt
$hashedPassword = password_hash($plainPassword, PASSWORD_BCRYPT);

// Output both
echo "Plain Password: " . $plainPassword . PHP_EOL;
echo "Hashed Password: " . $hashedPassword . PHP_EOL;