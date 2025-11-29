<?php
// seller_register.php
require 'database.php';
session_start();
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['ok'=>false,'msg'=>'Invalid request']); exit;
}

$first = trim($_POST['first_name'] ?? '');
$last  = trim($_POST['last_name'] ?? '');
$email = strtolower(trim($_POST['email'] ?? ''));
$pass  = $_POST['password'] ?? '';
$confirm = $_POST['confirm_password'] ?? '';

if (!$first || !$email || !$pass) {
    echo json_encode(['ok'=>false,'msg'=>'Please fill required fields']); exit;
}
if ($pass !== $confirm) {
    echo json_encode(['ok'=>false,'msg'=>'Passwords do not match']); exit;
}

// check duplicate
$stmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
$stmt->execute([$email]);
if ($stmt->fetch()) {
    echo json_encode(['ok'=>false,'msg'=>'Email already registered']); exit;
}

$hash = password_hash($pass, PASSWORD_DEFAULT);
$ins = $pdo->prepare("INSERT INTO users (first_name,last_name,email,password_hash,role) VALUES (?,?,?,?,?)");
try {
    $ins->execute([$first,$last,$email,$hash,'seller']);
} catch (PDOException $e) {
    echo json_encode(['ok'=>false,'msg'=>'Error creating account','err'=>$e->getMessage()]);
    exit;
}
$userId = $pdo->lastInsertId();

// auto-login
session_regenerate_id(true);
$_SESSION['user_id'] = $userId;
$_SESSION['first_name'] = $first;
$_SESSION['role'] = 'seller';

echo json_encode(['ok'=>true,'msg'=>'Seller account created','user'=>['id'=>$userId,'first_name'=>$first,'role'=>'seller']]);
exit;
?>