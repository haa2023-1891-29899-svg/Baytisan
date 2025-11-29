<?php
session_start();
require 'database.php';
$user_id = $_SESSION['user_id'] ?? null;
if (!$user_id) { die('Login required.'); }

// Always get the full cart array, but we'll only use selected items for the order.
$cart = $_SESSION['cart'] ?? [];
// Get only the selected products from POST if available
$selectedIds = [];
if (isset($_POST['checkout_ids']) && is_array($_POST['checkout_ids'])) {
    foreach ($_POST['checkout_ids'] as $pid) {
        $pid = (int)$pid;
        if (isset($cart[$pid])) $selectedIds[$pid] = $cart[$pid];
    }
} else {
    $selectedIds = $cart;
}

if (!$selectedIds) { die('Cart empty.'); }

$addr = trim($_POST['shipping_address'] ?? '');
if (!$addr) { die('Address required.'); }

$pdo->beginTransaction();
try {
  $total = 0;
  $sel = $pdo->prepare("SELECT * FROM products WHERE id = ?");
  foreach ($selectedIds as $pid => $qty) {
    $sel->execute([$pid]);
    $p = $sel->fetch();
    if (!$p) throw new Exception("Product not found");
    $total += $p['price'] * $qty;
  }
  $ins = $pdo->prepare("INSERT INTO orders (user_id,total_amount,shipping_address,status) VALUES (?,?,?,?)");
  $ins->execute([$user_id,$total,$addr,'pending']);
  $order_id = $pdo->lastInsertId();
  $ins2 = $pdo->prepare("INSERT INTO order_items (order_id,product_id,unit_price,quantity,subtotal) VALUES (?,?,?,?,?)");
  foreach ($selectedIds as $pid => $qty) {
    $sel->execute([$pid]); $p = $sel->fetch();
    $sub = $p['price'] * $qty;
    $ins2->execute([$order_id,$pid,$p['price'],$qty,$sub]);
    $pdo->prepare("UPDATE products SET stock = stock - ? WHERE id = ?")->execute([$qty,$pid]);
  }
  $pdo->prepare("INSERT INTO order_tracking (order_id,status,note) VALUES (?,?,?)")->execute([$order_id,'pending','Order placed']);

  // Remove only the ordered items from cart session and DB
  foreach ($selectedIds as $pid => $_) {
      unset($_SESSION['cart'][$pid]);
  }
  // Update DB cart to reflect only remaining items
  $cartRow = $pdo->prepare("SELECT id FROM carts WHERE user_id=?"); $cartRow->execute([$user_id]);
  if ($r = $cartRow->fetch()) {
    $pdo->prepare("DELETE FROM cart_items WHERE cart_id=?")->execute([$r['id']]);
    foreach ($_SESSION['cart'] as $pid => $qty) {
        $pdo->prepare("INSERT INTO cart_items (cart_id,product_id,quantity) VALUES (?,?,?)")->execute([$r['id'], $pid, $qty]);
    }
  }
  $pdo->commit();
  header('Location: order_summary.php?order_id=' . $order_id);
  exit;
} catch (Exception $e) {
  $pdo->rollBack();
  die('Error: ' . $e->getMessage());
}