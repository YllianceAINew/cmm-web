<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{ get_title() }}</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="{{ url('adminlte/plugins/fontawesome-free/css/all.min.css') }}">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="{{ url('adminlte/plugins/icheck-bootstrap/icheck-bootstrap.min.css') }}">
  <!-- Theme style -->
  <link rel="stylesheet" href="{{ url('adminlte/dist/css/adminlte.min.css') }}">
  
  <style>
    .login-page {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }
    .login-logo img {
      max-width: 80px;
      margin-bottom: 10px;
    }
    .login-logo a {
      color: #fff;
      font-size: 35px;
      font-weight: 300;
    }
    .card-primary.card-outline {
      border-top: 3px solid #007bff;
    }
    .login-box {
      width: 300px;
    }
  </style>
</head>
<body class="hold-transition login-page">

<script type="text/javascript">
  var baseUrl = "{{ url() }}";
</script>

{{ content() }}

<!-- jQuery -->
<script src="{{ url('adminlte/plugins/jquery/jquery.min.js') }}"></script>
<!-- Bootstrap 4 -->
<script src="{{ url('adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js') }}"></script>
<!-- AdminLTE App -->
<script src="{{ url('adminlte/dist/js/adminlte.min.js') }}"></script>

<!-- Custom Login Script -->
<script>
$(function() {
  // Focus on first input
  $('#memberLoginId').focus();
  
  // Handle form submission
  $('#loginForm').on('submit', function(e) {
    e.preventDefault();
    
    var loginId = $('#memberLoginId').val();
    var password = $('#memberPassword').val();
    
    if (!loginId || !password) {
      alert('Please enter both ID and password');
      return false;
    }
    
    // Submit the form
    this.submit();
  });
  
  // Submit on Enter key
  $('.form-control').keypress(function(e) {
    if (e.which == 13) {
      $('#loginForm').submit();
      return false;
    }
  });
});
</script>

</body>
</html>

