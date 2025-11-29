<?php
// seller_dashboard.php - improved styling and image path fixes
session_start();
require_once 'database.php';

// Ensure seller logged in
if (!isset($_SESSION['user_id']) || ($_SESSION['role'] ?? '') !== 'seller') {
    // Not a seller => redirect to login (or index) so user can sign in
    header('Location: index.php');
    exit;
}

$seller_id = (int)$_SESSION['user_id'];

// Fetch seller's products using PDO
$stmt = $pdo->prepare("
  SELECT p.*, c.name AS category_name, l.name AS location_name
  FROM products p
  LEFT JOIN categories c ON p.category_id = c.id
  LEFT JOIN locations l ON p.origin_location_id = l.id
  WHERE p.seller_id = ?
  ORDER BY p.id DESC
");
$stmt->execute([$seller_id]);
$products = $stmt->fetchAll();

// Fetch categories & locations for selects
$cats = $pdo->query("SELECT id, name FROM categories ORDER BY name")->fetchAll();
$locs = $pdo->query("SELECT id, name FROM locations ORDER BY name")->fetchAll();

// Helper to resolve product image path (tries multiple locations and extensions)
function product_image_path($filename) {
    // Prefer product image in images/products/
    if (!$filename) return "images/logo.png";
    $candidates = [];
    // if filename already contains folder part
    if (strpos($filename, 'images/') === 0 || strpos($filename, '/images/') === 0) {
        $candidates[] = ltrim($filename, '/');
    } else {
        $candidates[] = "images/products/{$filename}";
        $candidates[] = "images/{$filename}";
        // try adding common extensions if not present
        $base = pathinfo($filename, PATHINFO_FILENAME);
        $candidates[] = "images/products/{$base}.png";
        $candidates[] = "images/products/{$base}.jpg";
        $candidates[] = "images/products/{$base}.jpeg";
        $candidates[] = "images/{$base}.png";
        $candidates[] = "images/{$base}.jpg";
        $candidates[] = "images/{$base}.jpeg";
    }
    foreach ($candidates as $c) {
        if (file_exists(__DIR__ . '/' . $c)) return $c;
    }
    // fallback
    return "images/logo.png";
}
?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Seller Dashboard — Baytisan</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <link rel="stylesheet" href="style.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    :root {
      --bg: #FDF7F4;
      --primary: #8EB486;
      --accent: #997C70;
      --dark: #685752;
      --muted: #7a7a7a;
      --danger: #e05d5d;
      --table-alt: #F7FAF7;
    }
    body { background: var(--bg); }
    .dashboard-header { display: flex; align-items: center; gap: 16px; margin-bottom: 16px; margin-top: 40px; }
    .dashboard-header i { color: var(--primary); font-size: 2.2em; }
    .stat-card { background: #fff; border-radius: 12px; box-shadow: 0 4px 18px rgba(0,0,0,0.05); padding: 22px 22px 16px 22px; text-align: center; margin-bottom: 18px; min-height: 120px;}
    .stat-card .icon { font-size: 2.2em; color: var(--primary); margin-bottom:8px;}
    .stat-label { color:var(--muted); font-size:1em; }
    .stat-value { font-size:1.6em; font-weight:700; }
    .tab-pane { padding: 20px 0; }
    .table thead th { background: var(--table-alt); color: var(--dark); font-weight: 700; }
    .table-striped > tbody > tr:nth-of-type(odd) { background: #f9f6f3; }
    .btn-sm { font-size: .98em; }
    .nav-tabs .nav-link.active { background: var(--primary)!important; color: #fff !important; border: none; }
    .nav-tabs .nav-link { color: var(--primary); font-weight:600; border: none; }
    .nav-tabs .nav-link:hover { background: #e6f1e6; }
    .admin-logout { margin-left: 16px;}
    .product-img-thumb { width: 48px; height: 48px; object-fit: cover; border-radius: 9px; border:1px solid #eee; }
    .bg-light2 { background: #faf9f7 !important; }
    .modal.show { display:block; }
    .modal-backdrop.show { opacity:.5; }
    .modal.fade .modal-dialog { transition: transform .3s ease-out; }
    .modal { z-index: 1050; }
    .modal-backdrop { z-index: 1040; }
    .btn-main {
      background: var(--primary);
      color: #fff;
      border: none;
      border-radius: 13px;
      padding: 9px 24px;
      font-size: 1.05em;
      font-weight: 600;
      letter-spacing: 0.02em;
      box-shadow: 0 2px 13px rgba(120,160,120,0.07);
      transition: background .18s, color .18s, transform .18s;
    }
    .btn-main:hover, .btn-main:focus { background: #6a9c5b; color: #fff; transform: translateY(-2px); }
    .btn-danger {
      background: var(--danger)!important;
      color: #fff!important;
      border: none!important;
      border-radius: 13px!important;
      font-weight: 600;
    }
    .btn-danger:hover, .btn-danger:focus { background: #b43636!important; color:#fff!important; }
    .btn-outline-main {
      background: #fff;
      color: var(--primary);
      border: 2px solid var(--primary);
      border-radius: 13px;
      font-weight: 600;
      transition: background .18s, color .18s;
    }
    .btn-outline-main:hover, .btn-outline-main:focus {
      background: var(--primary);
      color: #fff;
    }
    .badge.bg-success {
      background: var(--primary)!important;
      color: #fff;
      font-weight: 600;
      font-size: .98em;
    }
    .badge.bg-danger {
      background: var(--danger)!important;
      color: #fff;
      font-weight: 600;
      font-size: .98em;
    }
    .actions-cell { display: flex; gap: 8px; }
    .btn-action {
      display: flex; align-items: center; gap: 6px; 
      padding: 8px 18px; font-size: 1.01em; font-weight: 600;
      border-radius: 11px; border:none;
      transition: background .16s;
    }
    .btn-action-edit {
      background: var(--primary); color:#fff;
    }
    .btn-action-edit:hover { background: #5b8f4b; }
    .btn-action-delete {
      background: var(--danger); color:#fff;
    }
    .btn-action-delete:hover { background: #b43636; }
    .table-hover tbody tr:hover {
      background: #eaf3e6;
      transition: background .18s;
    }
    .btn[disabled], .btn.disabled, .btn:disabled {
      background: #e4e4e4 !important;
      color: #b1b1b1 !important;
      border-color: #e4e4e4 !important;
      cursor: not-allowed !important;
      box-shadow: none !important;
    }
    .modal-header {
      background: var(--primary);
      color: #fff;
      border-bottom: none;
    }
    .modal-title { color: #fff; font-weight: 600; }
    .table .highlight-row { background: #e7f3e7 !important; transition: background .25s; }
    @media (max-width: 900px) {
      .modal-dialog { max-width: 97vw; margin: 1.5rem auto; }
      .modal-content, .modal-body, .modal-footer { padding: 1rem; }
    }
    @media (max-width: 600px) {
      .modal-body .row > [class^="col-"] { flex: 0 0 100%; max-width: 100%; }
      .table th, .table td { font-size: 0.97em; }
      .btn-action { padding: 7px 10px; font-size: .97em; }
    }
    h4, .section-h4 {
      color: var(--dark);
      font-size: 1.45em;
      margin-bottom: 20px;
      font-weight: 700;
      display: flex;
      align-items: center;
      gap: 12px;
    }
    .container { max-width: 1100px; margin: 0 auto; padding-top: 28px; }
    .current-image-preview img { max-width:160px; max-height:120px; object-fit:cover; border-radius:8px; }
    .table td, .table th { vertical-align: middle; }
    .btn-add { background: var(--primary); color:#fff; border:none; border-radius:10px; padding:8px 14px; }
    .btn-add:hover { background:#6a9c5b; }
    .no-image-box { width:100px;height:70px;background:#f2f2f2;display:flex;align-items:center;justify-content:center;border-radius:8px; }
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
        <a href="index.php">Home</a>
        <a href="products.php">Shop</a>
        <a href="order_history.php">Orders</a>
        <a href="admin_dashboard.php">Admin</a>
      </nav>
      <div class="nav-actions">
        <span class="welcome"><i class="fa fa-user"></i> Welcome, <?= htmlspecialchars($_SESSION['first_name'] ?? '') ?></span>
        <a href="logout.php" class="btn btn-danger admin-logout"><i class="fa fa-sign-out-alt"></i> Logout</a>
      </div>
    </div>
  </header>

<div class="container">
  <div class="dashboard-header">
    <i class="fa fa-store"></i>
    <h2 style="margin:0;">Seller Dashboard</h2>
    <button class="btn btn-main ms-auto" data-bs-toggle="modal" data-bs-target="#addModal"><i class="fa fa-plus"></i> Add Product</button>
  </div>

  <div class="table-responsive">
    <table class="table table-hover align-middle table-bordered table-striped">
      <thead>
        <tr>
          <th style="width:120px">Image</th>
          <th>Name</th>
          <th>Category</th>
          <th>Stock</th>
          <th>Price</th>
          <th style="width:220px">Actions</th>
        </tr>
      </thead>
      <tbody>
        <?php if (empty($products)): ?>
          <tr>
            <td colspan="6" class="text-center py-5" style="color:var(--muted);">
              No products yet. Use the "Add Product" button to create one.
            </td>
          </tr>
        <?php else: ?>
          <?php foreach ($products as $p): ?>
            <tr>
              <td>
                <?php
                  $imgPath = product_image_path($p['image_filename'] ?? '');
                ?>
                <?php if ($imgPath && $imgPath !== 'images/logo.png'): ?>
                  <img src="<?= htmlspecialchars($imgPath) ?>" alt="" class="product-img-thumb">
                <?php else: ?>
                  <div class="no-image-box">No image</div>
                <?php endif; ?>
              </td>
              <td><?php echo htmlspecialchars($p['name']); ?></td>
              <td><?php echo htmlspecialchars($p['category_name']); ?></td>
              <td><?= $p['stock'] > 0 ? "<span class='badge bg-success'>In Stock</span>" : "<span class='badge bg-danger'>Out of Stock</span>" ?> <?= (int)$p['stock']; ?></td>
              <td>₱<?php echo number_format($p['price'],2); ?></td>
              <td class="actions-cell">
                <button class="btn btn-action btn-action-edit btn-edit"
                  data-id="<?php echo $p['id']; ?>"
                  data-sku="<?php echo htmlspecialchars($p['sku'] ?? ''); ?>"
                  data-name="<?php echo htmlspecialchars($p['name']); ?>"
                  data-description="<?php echo htmlspecialchars($p['description']); ?>"
                  data-category_id="<?php echo $p['category_id']; ?>"
                  data-origin_location_id="<?php echo $p['origin_location_id']; ?>"
                  data-price="<?php echo $p['price']; ?>"
                  data-stock="<?php echo $p['stock']; ?>"
                  data-image="<?php echo htmlspecialchars($p['image_filename'] ?? ''); ?>"
                  data-bs-toggle="modal" data-bs-target="#editModal"
                ><i class="fa fa-edit"></i> Edit</button>

                <form method="post" action="product_actions.php?action=delete" style="display:inline;" onsubmit="return confirm('Delete this product?');">
                  <input type="hidden" name="id" value="<?php echo $p['id']; ?>">
                  <button class="btn btn-action btn-action-delete"><i class="fa fa-trash"></i> Delete</button>
                </form>
              </td>
            </tr>
          <?php endforeach; ?>
        <?php endif; ?>
      </tbody>
    </table>
  </div>
</div>

<!-- Add Modal -->
<div class="modal fade" id="addModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="product_actions.php?action=add" method="post" enctype="multipart/form-data">
        <div class="modal-header">
          <h5 class="modal-title"><i class="fa fa-plus"></i> Add Product</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <!-- fields -->
          <div class="mb-2">
            <label class="form-label">Name</label>
            <input name="name" class="form-control" required>
          </div>
          <div class="mb-2">
            <label class="form-label">SKU (optional)</label>
            <input name="sku" class="form-control">
          </div>
          <div class="mb-2">
            <label class="form-label">Category</label>
            <select name="category_id" class="form-control" required>
              <option value="">Select Category</option>
              <?php foreach ($cats as $c): ?>
                <option value="<?php echo $c['id']; ?>"><?php echo htmlspecialchars($c['name']); ?></option>
              <?php endforeach;?>
            </select>
          </div>
          <div class="mb-2">
            <label class="form-label">Origin Location</label>
            <select name="origin_location_id" class="form-control">
              <option value="">Select Location</option>
              <?php foreach ($locs as $l): ?>
                <option value="<?php echo $l['id']; ?>"><?php echo htmlspecialchars($l['name']); ?></option>
              <?php endforeach;?>
            </select>
          </div>
          <div class="mb-2">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control"></textarea>
          </div>
          <div class="row">
            <div class="col mb-2">
              <label class="form-label">Price</label>
              <input name="price" type="number" step="0.01" class="form-control" required>
            </div>
            <div class="col mb-2">
              <label class="form-label">Stock</label>
              <input name="stock" type="number" class="form-control" required>
            </div>
          </div>

          <div class="mb-2">
            <label class="form-label">Image (upload)</label>
            <input type="file" name="image_file" accept="image/*" class="form-control">
            <div class="form-text">Accepted formats: jpg, jpeg, png, gif. The uploader will store the file in the server images folder.</div>
          </div>

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-outline-main" data-bs-dismiss="modal">Cancel</button>
          <button class="btn btn-main"><i class="fa fa-plus"></i> Add</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="product_actions.php?action=edit" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" id="edit_id">
        <div class="modal-header">
          <h5 class="modal-title"><i class="fa fa-edit"></i> Edit Product</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="mb-2">
            <label class="form-label">Name</label>
            <input name="name" id="edit_name" class="form-control" required>
          </div>
          <div class="mb-2">
            <label class="form-label">SKU (optional)</label>
            <input name="sku" id="edit_sku" class="form-control">
          </div>
          <div class="mb-2">
            <label class="form-label">Category</label>
            <select name="category_id" id="edit_category" class="form-control" required>
              <option value="">Select Category</option>
              <?php foreach ($cats as $c): ?>
                <option value="<?php echo $c['id']; ?>"><?php echo htmlspecialchars($c['name']); ?></option>
              <?php endforeach;?>
            </select>
          </div>
          <div class="mb-2">
            <label class="form-label">Origin Location</label>
            <select name="origin_location_id" id="edit_origin" class="form-control">
              <option value="">Select Location</option>
              <?php foreach ($locs as $l): ?>
                <option value="<?php echo $l['id']; ?>"><?php echo htmlspecialchars($l['name']); ?></option>
              <?php endforeach;?>
            </select>
          </div>
          <div class="mb-2">
            <label class="form-label">Description</label>
            <textarea name="description" id="edit_description" class="form-control"></textarea>
          </div>
          <div class="row">
            <div class="col mb-2">
              <label class="form-label">Price</label>
              <input name="price" id="edit_price" type="number" step="0.01" class="form-control" required>
            </div>
            <div class="col mb-2">
              <label class="form-label">Stock</label>
              <input name="stock" id="edit_stock" type="number" class="form-control" required>
            </div>
          </div>

          <div class="mb-2">
            <label class="form-label">Current Image</label>
            <div id="current_image_preview" class="current-image-preview" style="margin-bottom:8px;"></div>
            <input type="hidden" name="existing_image" id="edit_existing_image">
            <label class="form-label">Upload New Image (optional)</label>
            <input type="file" name="image_file" accept="image/*" class="form-control">
            <div class="form-text">If you upload a new image the old one will be removed (if the uploader script handles deletion).</div>
          </div>

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-outline-main" data-bs-dismiss="modal">Cancel</button>
          <button class="btn btn-main"><i class="fa fa-save"></i> Save Changes</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function() {
  // populate edit modal from data attributes
  document.querySelectorAll('.btn-edit').forEach(function(btn){
    btn.addEventListener('click', function(){
      document.getElementById('edit_id').value = this.dataset.id || '';
      document.getElementById('edit_sku').value = this.dataset.sku || '';
      document.getElementById('edit_name').value = this.dataset.name || '';
      document.getElementById('edit_description').value = this.dataset.description || '';
      document.getElementById('edit_category').value = this.dataset.category_id || '';
      document.getElementById('edit_origin').value = this.dataset.origin_location_id || '';
      document.getElementById('edit_price').value = this.dataset.price || '';
      document.getElementById('edit_stock').value = this.dataset.stock || '';
      const img = this.dataset.image || '';
      document.getElementById('edit_existing_image').value = img;
      const preview = document.getElementById('current_image_preview');
      if (img) {
        const candidates = [
          'images/products/' + img,
          'images/' + img
        ];
        let found = '';
        for (let c of candidates) {
          found = c;
          break;
        }
        preview.innerHTML = '<img src="' + found + '" alt="current image">';
      } else {
        preview.innerHTML = '<div class="no-image-box">No image</div>';
      }
    });
  });
});
</script>
</body>
</html>