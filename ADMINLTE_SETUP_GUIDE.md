# AdminLTE 3 Integration Guide for CMM-Web Project

## ✅ What Has Been Completed

### 1. AdminLTE Assets Installation
- ✅ Copied AdminLTE 3.2.0-rc to `public/adminlte/`
- ✅ Directory structure:
  - `public/adminlte/dist/` - Core CSS and JS files
  - `public/adminlte/plugins/` - All required plugins (jQuery, Bootstrap, DataTables, etc.)
  - `public/adminlte/custom/` - Custom scripts for your project

### 2. Layout Files Created

#### Main Admin Layout
- ✅ **File**: `app/views/layouts/adminlte.volt`
- Features:
  - Modern sidebar navigation
  - Top navbar with user dropdown
  - Content wrapper with breadcrumbs
  - Responsive design
  - Fullscreen toggle

#### Sidebar Menu
- ✅ **File**: `app/views/partials/sidebar-adminlte.volt`
- Features:
  - Collapsible menu items
  - Font Awesome icons
  - ACL-based menu visibility
  - Active menu highlighting
  - Categorized sections:
    - Dashboard
    - Server Manager (with submenus)
    - Member Management (with submenus)
    - Logs (with submenus)

#### Login Page
- ✅ **File**: `app/views/layouts/login-adminlte.volt`
- ✅ **File**: `app/views/session/index-adminlte.volt`
- Features:
  - Beautiful gradient background
  - Card-based login form
  - Font Awesome icons
  - CA certificate support
  - Server time display
  - Responsive design

### 3. Dashboard View
- ✅ **File**: `app/views/dashboard/index-adminlte.volt`
- Features:
  - 4 info boxes (Total Users, CPU Usage, RAM, Disk)
  - Registration chart with date filtering
  - Login chart with date filtering
  - Card-based layout
  - Collapsible cards

### 4. Custom JavaScript Files
- ✅ `public/adminlte/custom/dashboard-adminlte.js` - Dashboard charts and interactions
- ✅ `public/adminlte/custom/sidebar-active.js` - Automatic active menu highlighting

### 5. Language Keys Updated
- ✅ Added missing menu translations in `app/messages/messages.php`
- ✅ Added login page translations

---

## 🚀 How to Use AdminLTE in Your Project

### Option 1: Update Existing Controller (Recommended for Testing)

Update your `DashboardController.php` to use AdminLTE layout:

```php
public function indexAction()
{
    // Change the view to use AdminLTE layout
    $this->view->setLayout('adminlte');
    $this->view->pick('dashboard/index-adminlte');
    
    // Add AdminLTE-specific assets
    $this->assets->addJs("adminlte/plugins/flot/jquery.flot.min.js");
    $this->assets->addJs("adminlte/plugins/flot/jquery.flot.resize.min.js");
    $this->assets->addJs("adminlte/custom/dashboard-adminlte.js");
    
    // ... rest of your existing code ...
}
```

### Option 2: Update Base Controller (Applies to All Pages)

Edit `app/controllers/ControllerUIBase.php`:

```php
protected function initialize()
{
    $this->tag->prependTitle($this->lang['site_title'].'| ');
    $this->view->lang = $this->lang;
    
    // Set AdminLTE as default layout
    $this->view->setLayout('adminlte');
    
    // ... rest of your code ...
}
```

### Option 3: Update Session Controller for Login Page

Edit `app/controllers/SessionController.php`:

```php
public function indexAction()
{
    // Set AdminLTE login layout
    $this->view->setLayout('login-adminlte');
    $this->view->pick('session/index-adminlte');
    
    // ... rest of your existing code ...
}
```

---

## 📋 Step-by-Step Migration Plan

### Phase 1: Test with Dashboard (START HERE)
1. ✅ AdminLTE assets installed
2. ✅ Layouts and views created
3. ⏳ **NEXT STEP**: Update `DashboardController.php` - see Option 1 above
4. ⏳ Test dashboard page - visit `/adminpage/dashboard/index`
5. ⏳ Check charts, menu, and styling

### Phase 2: Migrate Login Page
1. ⏳ Update `SessionController.php` - see Option 3 above
2. ⏳ Test login functionality
3. ⏳ Verify CA certificate login still works

### Phase 3: Migrate Other Pages (One at a Time)
1. ⏳ Server pages (`ServerController.php`)
2. ⏳ Member pages (`MemberController.php`)
3. ⏳ Log pages (`LogController.php`)

### Phase 4: Convert All Views
For each existing view file, wrap content in AdminLTE card structure:

**Before:**
```html
<div class="page-content-wrapper">
    <div class="page-content">
        <!-- Your content -->
    </div>
</div>
```

**After:**
```html
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Page Title</h3>
            </div>
            <div class="card-body">
                <!-- Your content -->
            </div>
        </div>
    </div>
</div>
```

---

## 🎨 Color Schemes Available

AdminLTE supports multiple color schemes. To change the sidebar color, edit `app/views/partials/sidebar-adminlte.volt`:

Replace `sidebar-dark-primary` with:
- `sidebar-dark-primary` (default blue)
- `sidebar-dark-info` (cyan)
- `sidebar-dark-success` (green)
- `sidebar-dark-warning` (orange)
- `sidebar-dark-danger` (red)
- `sidebar-dark-indigo`
- `sidebar-dark-navy`
- `sidebar-dark-purple`
- `sidebar-dark-pink`
- `sidebar-light-primary` (light theme)
- `sidebar-light-info`
- etc.

To change navbar color, edit `app/views/layouts/adminlte.volt`:

Replace `navbar-white navbar-light` with:
- `navbar-primary navbar-dark` (blue)
- `navbar-info navbar-dark` (cyan)
- `navbar-success navbar-dark` (green)
- `navbar-warning navbar-light` (orange)
- `navbar-danger navbar-dark` (red)
- etc.

---

## 📦 AdminLTE Components Available

You now have access to all AdminLTE components:

### Cards
```html
<div class="card">
    <div class="card-header">Title</div>
    <div class="card-body">Content</div>
</div>
```

### Info Boxes
```html
<div class="info-box">
    <span class="info-box-icon bg-info"><i class="fas fa-users"></i></span>
    <div class="info-box-content">
        <span class="info-box-text">Users</span>
        <span class="info-box-number">1,410</span>
    </div>
</div>
```

### Small Boxes
```html
<div class="small-box bg-info">
    <div class="inner">
        <h3>150</h3>
        <p>New Orders</p>
    </div>
    <div class="icon"><i class="fas fa-shopping-cart"></i></div>
    <a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
</div>
```

### Alerts
```html
<div class="alert alert-info alert-dismissible">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <h5><i class="icon fas fa-info"></i> Alert!</h5>
    Info alert message.
</div>
```

### Buttons
```html
<button type="button" class="btn btn-primary">Primary</button>
<button type="button" class="btn btn-success">Success</button>
<button type="button" class="btn btn-danger">Danger</button>
```

---

## 🔧 DataTables Integration

AdminLTE includes DataTables. To use it:

```javascript
// In your controller
$this->assets->addCss("adminlte/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css");
$this->assets->addJs("adminlte/plugins/datatables/jquery.dataTables.min.js");
$this->assets->addJs("adminlte/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js");

// In your view
$('#myTable').DataTable({
    responsive: true,
    autoWidth: false,
});
```

---

## 📊 Chart Libraries Available

Your existing charts (AmCharts, Flot) will work with AdminLTE. Plus you have:

- **Chart.js** - `adminlte/plugins/chart.js/`
- **Flot** - `adminlte/plugins/flot/`
- **Sparkline** - `adminlte/plugins/sparklines/`

---

## 🐛 Troubleshooting

### Issue: Charts not displaying
**Solution**: Make sure Flot plugin is loaded:
```php
$this->assets->addJs("adminlte/plugins/flot/jquery.flot.min.js");
```

### Issue: Menu not expanding
**Solution**: Check jQuery is loaded before AdminLTE:
```html
<script src="adminlte/plugins/jquery/jquery.min.js"></script>
<script src="adminlte/dist/js/adminlte.min.js"></script>
```

### Issue: Icons not showing
**Solution**: Ensure Font Awesome is loaded:
```html
<link rel="stylesheet" href="adminlte/plugins/fontawesome-free/css/all.min.css">
```

---

## 📝 Quick Start Commands

### Test Dashboard with AdminLTE:
1. Edit `app/controllers/DashboardController.php`
2. Add at the beginning of `indexAction()`:
   ```php
   $this->view->setLayout('adminlte');
   $this->view->pick('dashboard/index-adminlte');
   ```
3. Visit: `http://your-domain/adminpage/dashboard/index`

### Test Login Page with AdminLTE:
1. Edit `app/controllers/SessionController.php`
2. Add at the beginning of `indexAction()`:
   ```php
   $this->view->setLayout('login-adminlte');
   $this->view->pick('session/index-adminlte');
   ```
3. Visit: `http://your-domain/adminpage/session/index`

---

## 🎯 Next Steps

1. ✅ **Test Dashboard** - Update DashboardController and verify
2. ✅ **Test Login** - Update SessionController and verify
3. ⏳ Migrate other controllers one by one
4. ⏳ Convert existing views to AdminLTE card structure
5. ⏳ Update any custom CSS to work with AdminLTE
6. ⏳ Test all functionality thoroughly

---

## 📚 Resources

- **AdminLTE Demo**: https://adminlte.io/themes/v3/
- **AdminLTE Documentation**: https://adminlte.io/docs/3.2/
- **AdminLTE GitHub**: https://github.com/ColorlibHQ/AdminLTE
- **Bootstrap 4 Docs**: https://getbootstrap.com/docs/4.6/

---

## 💡 Tips

1. **Test incrementally** - Don't change everything at once
2. **Keep old views** - Your original views are still there (e.g., `dashboard/index.volt`)
3. **Use browser dev tools** - Check console for JavaScript errors
4. **Clear cache** - Clear Volt cache: `cache/volt/`

---

**Created**: 2025-12-09
**Version**: AdminLTE 3.2.0-rc
**Project**: CMM-Web (Phalcon Framework)

