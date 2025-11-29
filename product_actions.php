<?php
// product_actions.php - converted to use PDO and unified session keys
session_start();
require_once 'database.php'; // uses $pdo

if (!isset($_SESSION['user_id']) || ($_SESSION['role'] ?? '') !== 'seller') {
    header('HTTP/1.1 403 Forbidden');
    echo "Login required.";
    exit;
}

$seller_id = (int)$_SESSION['user_id'];
$action = $_GET['action'] ?? '';
$folder = __DIR__ . '/images/';

function back() {
    if (!empty($_SERVER['HTTP_REFERER'])) {
        header('Location: ' . $_SERVER['HTTP_REFERER']);
    } else {
        header('Location: seller_dashboard.php');
    }
    exit;
}

if ($action === 'add') {
    $name = trim($_POST['name'] ?? '');
    $sku = trim($_POST['sku'] ?? '');
    $description = trim($_POST['description'] ?? '');
    $category_id = (int)($_POST['category_id'] ?? 0);
    $origin_location_id = $_POST['origin_location_id'] ? (int)$_POST['origin_location_id'] : null;
    $price = (float)($_POST['price'] ?? 0);
    $stock = (int)($_POST['stock'] ?? 0);

    $img = null;
    if (!empty($_FILES['image_file']['name'])) {
        $ext = strtolower(pathinfo($_FILES['image_file']['name'], PATHINFO_EXTENSION));
        $allowed = ['jpg','jpeg','png','gif'];
        if (in_array($ext, $allowed)) {
            $img = uniqid('prod_') . '.' . $ext;
            if (!move_uploaded_file($_FILES['image_file']['tmp_name'], $folder . $img)) {
                $img = null;
            }
        }
    }

    $stmt = $pdo->prepare("
        INSERT INTO products (sku, name, description, category_id, origin_location_id, price, stock, image_filename, seller_id)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    ");
    $stmt->execute([$sku, $name, $description, $category_id, $origin_location_id, $price, $stock, $img, $seller_id]);
    back();
}

if ($action === 'edit') {
    $id = (int)($_POST['id'] ?? 0);
    if (!$id) back();

    // Verify ownership
    $stmt = $pdo->prepare("SELECT image_filename, seller_id FROM products WHERE id=?");
    $stmt->execute([$id]);
    $row = $stmt->fetch();
    if (!$row || (int)$row['seller_id'] !== $seller_id) {
        // not found or not owned by seller
        header('HTTP/1.1 403 Forbidden');
        echo "Unauthorized";
        exit;
    }

    $old = $row['image_filename'];
    $img = $old;
    if (!empty($_FILES['image_file']['name'])) {
        // remove old file if present
        if ($old && file_exists($folder.$old)) @unlink($folder.$old);
        $ext = strtolower(pathinfo($_FILES['image_file']['name'], PATHINFO_EXTENSION));
        $allowed = ['jpg','jpeg','png','gif'];
        if (in_array($ext, $allowed)) {
            $img = uniqid('prod_') . '.' . $ext;
            move_uploaded_file($_FILES['image_file']['tmp_name'], $folder.$img);
        }
    }

    $sku = trim($_POST['sku'] ?? '');
    $name = trim($_POST['name'] ?? '');
    $description = trim($_POST['description'] ?? '');
    $category_id = (int)($_POST['category_id'] ?? 0);
    $origin_location_id = $_POST['origin_location_id'] ? (int)$_POST['origin_location_id'] : null;
    $price = (float)($_POST['price'] ?? 0);
    $stock = (int)($_POST['stock'] ?? 0);

    $stmt = $pdo->prepare("
        UPDATE products SET sku=?, name=?, description=?, category_id=?, origin_location_id=?, price=?, stock=?, image_filename=?
        WHERE id=? AND seller_id=?
    ");
    $stmt->execute([$sku, $name, $description, $category_id, $origin_location_id, $price, $stock, $img, $id, $seller_id]);
    back();
}

if ($action === 'delete') {
    $id = (int)($_POST['id'] ?? 0);
    if (!$id) back();

    // Verify ownership and get image filename
    $stmt = $pdo->prepare("SELECT image_filename, seller_id FROM products WHERE id=?");
    $stmt->execute([$id]);
    $row = $stmt->fetch();
    if (!$row || (int)$row['seller_id'] !== $seller_id) {
        header('HTTP/1.1 403 Forbidden');
        echo "Unauthorized";
        exit;
    }

    $img = $row['image_filename'] ?? null;
    if ($img && file_exists($folder.$img)) @unlink($folder.$img);

    $stmt = $pdo->prepare("DELETE FROM products WHERE id=? AND seller_id=?");
    $stmt->execute([$id, $seller_id]);
    back();
}

// default redirect
back();
?>