<?php
$host = 'mysql';
$user = 'root';
$pass = 'rootpassword';
$dbname = 'testdb';

$conn = new mysqli($host, $user, $pass, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
echo "Hello, World! Your MySQL connection is successful.";
?>
