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
  <!-- Custom Layout Styles (No Navbar) -->
  <link rel="stylesheet" href="{{ url('adminlte/custom/layout-no-navbar.css') }}">
  
  <!-- Dynamic CSS Assets -->
  {{ assets.outputCss() }}
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<script type="text/javascript">
	var baseUrl = "{{ url() }}";
	var acls = {{ acceptAcl | json_encode }};
</script>

<div class="wrapper">

  <!-- Main Sidebar Container -->
  {{ partial("partials/sidebar-adminlte") }}

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <button class="btn btn-link text-dark p-0 mr-2" data-widget="pushmenu" href="#" role="button" aria-label="Toggle Sidebar">
              <i class="fas fa-bars"></i>
            </button>
            <h1 class="m-0 d-inline">{{ get_title() }}</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="{{ url('server/index') }}">Home</a></li>
              <li class="breadcrumb-item active">{{ get_title() }}</li>
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

<!-- Dynamic JS Assets -->
{{ assets.outputJs() }}

</body>
</html>

