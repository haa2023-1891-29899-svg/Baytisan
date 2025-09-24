<?php
session_start();
$loggedIn = isset($_SESSION['user_id']);
$firstName = $_SESSION['first_name'] ?? '';
$cart = $_SESSION['cart'] ?? [];
$cartCount = array_sum($cart);
$role = $_SESSION['role'] ?? '';
?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Baytisan — Local crafts from Albay</title>
  <link rel="stylesheet" href="style.css">
  <script defer src="script.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    .modal { display: none; position: fixed; z-index: 1000; inset: 0; background: rgba(0,0,0,0.25); align-items: center; justify-content: center; }
    .modal.active { display: flex; }
    .modal-content { background: #fff; border-radius: 16px; max-width: 490px; width: 96vw; margin: 0 auto; padding: 30px 22px 20px 22px; position: relative; box-shadow: 0 16px 48px rgba(30,30,30,0.13);}
    .close { position: absolute; top: 9px; right: 13px; background: none; border: none; font-size: 1.5em; color: #8EB486; cursor: pointer; z-index:2; }
  </style>
</head>
<body>
  <header class="site-header">
    <div class="container nav">
      <a href="index.php" class="brand">
        <img src="images/logo.png" alt="Baytisan logo" class="logo">
        <span class="brand-text">Baytisan</span>
      </a>
      <nav class="main-nav">
        <a href="index.php" class="active">Home</a>
        <a href="products.php">Shop</a>
        <a href="order_history.php">Orders</a>
        <a href="admin_dashboard.php">Admin</a>
      </nav>
      <div class="nav-actions" id="navActions">
        <?php if ($loggedIn): ?>
          <span class="welcome"><i class="fa fa-user"></i> Welcome, <?= htmlspecialchars($firstName) ?></span>
          <?php if ($role === 'customer'): ?>
            <a href="profile.php" class="btn btn-primary" style="margin-left:8px;">
              <i class="fa fa-user"></i> Profile
            </a>
          <?php elseif ($role === 'admin'): ?>
            <a href="admin_profile.php" class="btn btn-primary" style="margin-left:8px;">
              <i class="fa fa-user-shield"></i> Admin Profile
            </a>
          <?php endif; ?>
          <a href="cart.php" class="btn btn-primary"><i class="fa fa-shopping-cart"></i> Cart (<?= $cartCount ?>)</a>
          <a href="logout.php" class="btn btn-danger"><i class="fa fa-sign-out-alt"></i> Logout</a>
        <?php else: ?>
          <button id="loginBtn" class="btn btn-primary"><i class="fa fa-sign-in-alt"></i> Login / Signup</button>
          <a href="admin_login.php" class="btn btn-primary"><i class="fa fa-user-shield"></i> Admin Login</a>
          <a href="admin_register.php" class="btn btn-primary"><i class="fa fa-user-plus"></i> Admin Register</a>
          <a href="cart.php" class="btn btn-primary"><i class="fa fa-shopping-cart"></i> Cart (0)</a>
        <?php endif; ?>
      </div>
    </div>
  </header>

  <main>
    <section class="hero container">
      <div class="hero-inner">
        <div class="hero-text">
          <?php if ($loggedIn): ?>
            <h1><i class="fa fa-hand-sparkles"></i> Welcome back, <?= htmlspecialchars($firstName) ?>!</h1>
            <p>Discover new handmade crafts, check your orders, and support local artisans.</p>
            <a href="products.php" class="btn btn-primary"><i class="fa fa-store"></i> Shop Now</a>
          <?php else: ?>
            <h1><i class="fa fa-spa"></i> Traditional crafts from Albay</h1>
            <p>Handmade abaca products, pots and local pili sweets — directly from the LGUs of Albay.</p>
            <a href="products.php" class="btn btn-primary"><i class="fa fa-store"></i> Shop Now</a>
          <?php endif; ?>
        </div>
        <div class="hero-image">
          <img src="images/bg-main.png" alt="Baytisan hero image">
        </div>
      </div>
    </section>

    <section class="features container">
      <article><h3><i class="fa fa-truck-fast"></i> Free local delivery</h3><p>Selected municipalities</p></article>
      <article><h3><i class="fa fa-lock"></i> Secure payments</h3><p>Encrypted checkout</p></article>
      <article><h3><i class="fa fa-heart"></i> Support local artisans</h3><p>Made in Albay</p></article>
    </section>
  </main>

  <footer class="site-footer">
    <div class="container">
      <p>© <span id="year"></span> Baytisan — Local crafts from Albay</p>
    </div>
  </footer>

  <?php if (!$loggedIn): ?>
  <div id="modal" class="modal" aria-hidden="true">
    <div class="modal-content" role="dialog" aria-modal="true">
      <button id="closeModal" class="close" aria-label="Close">✕</button>
      <div class="auth-tabs" role="tablist">
        <button class="tab-btn active" data-target="loginForm" role="tab"><i class="fa fa-sign-in-alt"></i> Customer Login</button>
        <button class="tab-btn" data-target="signupForm" role="tab"><i class="fa fa-user-plus"></i> Sign Up</button>
      </div>
      <div class="auth-forms">
        <form id="loginForm" class="auth-form active" method="post">
          <label for="login-email"><i class="fa fa-envelope"></i> Email</label>
          <input id="login-email" name="email" type="email" required>
          <label for="login-password"><i class="fa fa-key"></i> Password</label>
          <input id="login-password" name="password" type="password" required>
          <button id="loginSubmit" type="button" class="btn btn-primary"><i class="fa fa-sign-in-alt"></i> Login</button>
          <div id="loginMsg" class="auth-msg"></div>
        </form>
        <form id="signupForm" class="auth-form" method="post">
          <label for="signup-firstname"><i class="fa fa-user"></i> First name</label>
          <input id="signup-firstname" name="first_name" type="text" required>
          <label for="signup-lastname"><i class="fa fa-user"></i> Last name</label>
          <input id="signup-lastname" name="last_name" type="text">
          <label for="signup-email"><i class="fa fa-envelope"></i> Email</label>
          <input id="signup-email" name="email" type="email" required>
          <label for="signup-password"><i class="fa fa-key"></i> Password</label>
          <input id="signup-password" name="password" type="password" required>
          <button id="signupSubmit" type="button" class="btn btn-primary"><i class="fa fa-user-plus"></i> Create Account</button>
          <div id="signupMsg" class="auth-msg"></div>
        </form>
      </div>
    </div>
  </div>
  <?php endif; ?>

  <noscript><div class="noscript-warning container">JavaScript disabled — some features need JavaScript.</div></noscript>
</body>
</html>