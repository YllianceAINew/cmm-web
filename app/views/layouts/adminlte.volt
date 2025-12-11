<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{ get_title() }}</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="{{ url('adminlte/plugins/fontawesome-free/css/all.min.css') }}">
  <!-- AdminLTE Theme style -->
  <link rel="stylesheet" href="{{ url('adminlte/dist/css/adminlte.min.css') }}">
  
  <!-- Dynamic CSS Assets -->
  {{ assets.outputCss() }}
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<script type="text/javascript">
	var baseUrl = "{{ url() }}";
	var acls = {{ acceptAcl | json_encode }};
</script>

<div class="wrapper">

  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button" aria-label="Toggle Sidebar">
          <i class="fas fa-bars"></i>
        </a>
      </li>
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
      <!-- Notifications Dropdown Menu -->
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" aria-label="Notifications">
          <i class="far fa-bell"></i>
          <span class="badge badge-warning navbar-badge">0</span>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
          <span class="dropdown-item dropdown-header">0 Notifications</span>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item dropdown-footer">No new notifications</a>
        </div>
      </li>
      <!-- Fullscreen Toggle -->
      <li class="nav-item">
        <a class="nav-link" data-widget="fullscreen" href="#" role="button" aria-label="Toggle Fullscreen">
          <i class="fas fa-expand-arrows-alt"></i>
        </a>
      </li>
      <!-- Dark Mode Toggle -->
      <li class="nav-item">
        <a class="nav-link" href="#" id="dark-mode-toggle" role="button" aria-label="Toggle Dark Mode" title="Toggle Dark Mode">
          <i class="far fa-moon" id="dark-mode-icon"></i>
        </a>
      </li>
    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  {{ partial("partials/sidebar-adminlte") }}

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">
              <?php
                $fullTitle = $this->tag->getTitle();
                if ($fullTitle) {
                  // Extract page title (part after the pipe)
                  $titleParts = explode('|', $fullTitle);
                  $pageTitle = trim(end($titleParts));
                  echo $pageTitle ?: 'Page';
                } else {
                  // Fallback: use controller/action to determine title
                  $controller = $this->dispatcher->getControllerName();
                  $action = $this->dispatcher->getActionName();
                  $route = strtolower($controller . '/' . $action);
                  
                  // Map routes to language keys
                  $titleMap = [
                    'dashboard/index' => $this->lang['menu_dashboard'],
                    'server/index' => $this->lang['menu_server_list'],
                    'server/serversetting' => $this->lang['menu_server_setting'],
                    'server/xmppserver' => $this->lang['menu_xmpp_server'],
                    'server/sipserver' => $this->lang['menu_sip_server'],
                    'server/proxyserver' => $this->lang['menu_proxy_server'],
                    'member/summary' => $this->lang['menu_member_summary'],
                    'member/register' => $this->lang['menu_member_register'],
                    'member/setlevel' => $this->lang['menu_member_level'],
                    'member/levelList' => $this->lang['menu_level_list'],
                    'log/calllog' => $this->lang['menu_call_log'],
                    'log/textlog' => $this->lang['menu_text_log'],
                    'log/signlog' => $this->lang['menu_sign_log'],
                    'log/xmppHistory' => $this->lang['menu_xmpp_history'],
                    'log/sipHistory' => $this->lang['menu_sip_history'],
                  ];
                  
                  echo isset($titleMap[$route]) ? $titleMap[$route] : ucfirst($action);
                }
              ?>
            </h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="{{ url('dashboard/index') }}">Home</a></li>
              <li class="breadcrumb-item active">
                <?php
                  $fullTitle = $this->tag->getTitle();
                  if ($fullTitle) {
                    // Extract page title (part after the pipe)
                    $titleParts = explode('|', $fullTitle);
                    $pageTitle = trim(end($titleParts));
                    echo $pageTitle ?: 'Page';
                  } else {
                    // Fallback: use controller/action to determine title
                    $controller = $this->dispatcher->getControllerName();
                    $action = $this->dispatcher->getActionName();
                    $route = strtolower($controller . '/' . $action);
                    
                    // Map routes to language keys
                    $titleMap = [
                      'dashboard/index' => $this->lang['menu_dashboard'],
                      'server/index' => $this->lang['menu_server_list'],
                      'server/serversetting' => $this->lang['menu_server_setting'],
                      'server/xmppserver' => $this->lang['menu_xmpp_server'],
                      'server/sipserver' => $this->lang['menu_sip_server'],
                      'server/proxyserver' => $this->lang['menu_proxy_server'],
                      'member/summary' => $this->lang['menu_member_summary'],
                      'member/register' => $this->lang['menu_member_register'],
                      'member/setlevel' => $this->lang['menu_member_level'],
                      'member/levelList' => $this->lang['menu_level_list'],
                      'log/calllog' => $this->lang['menu_call_log'],
                      'log/textlog' => $this->lang['menu_text_log'],
                      'log/signlog' => $this->lang['menu_sign_log'],
                      'log/xmppHistory' => $this->lang['menu_xmpp_history'],
                      'log/sipHistory' => $this->lang['menu_sip_history'],
                    ];
                    
                    echo isset($titleMap[$route]) ? $titleMap[$route] : ucfirst($action);
                  }
                ?>
              </li>
            </ol>
          </div>
        </div>
      </div>
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
      <div class="container-fluid">
        {{ flash.output() }}
        {{ content() }}
      </div>
    </div>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <footer class="main-footer">
    {{ partial("partials/footer") }}
  </footer>
</div>
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->

<!-- jQuery -->
<script src="{{ url('adminlte/plugins/jquery/jquery.min.js') }}"></script>
<!-- Bootstrap 4 -->
<script src="{{ url('adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js') }}"></script>
<!-- AdminLTE App -->
<script src="{{ url('adminlte/dist/js/adminlte.min.js') }}"></script>

<!-- Custom Scripts -->
<script src="{{ url('adminlte/custom/sidebar-active.js') }}"></script>
<script src="{{ url('adminlte/custom/dark-mode.js') }}"></script>

<!-- Dynamic JS Assets -->
{{ assets.outputJs() }}

</body>
</html>

