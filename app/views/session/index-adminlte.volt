{{ content() }}

<div class="login-box">
  <div class="card card-outline card-primary">
    <div class="card-header text-center">
      <h4 class="mb-0"><b>{{ lang._('site_title') }}</b></h4>
    </div>
    <div class="card-body">
      <p class="login-box-msg">{{ lang._('session_login_message') }}</p>

      <?php if ($caFlag == 1) { ?>
      <!-- CA Certificate Login -->
      <div class="alert alert-info">
        <i class="fas fa-certificate"></i> Certificate Authentication Detected
        <br><strong>User: {{ userId }}</strong>
      </div>
      <form action="{{ url('session/start') }}" method="post" id="loginForm">
        <input type="hidden" name="memberLoginId" value="{{ userId }}">
        <div class="form-group">
          <button type="submit" class="btn btn-primary btn-block">
            <i class="fas fa-sign-in-alt"></i> Sign In with Certificate
          </button>
        </div>
      </form>
      <?php } else { ?>
      
      <!-- Regular Login Form -->
      {{ flash.output() }}
      
      <form action="{{ url('session/start') }}" method="post" id="loginForm">
        <!-- Login ID -->
        <div class="input-group mb-3">
          {{ form.render('memberLoginId', ['class': 'form-control', 'placeholder': lang._('login_id_placeholder'), 'id': 'memberLoginId']) }}
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user"></span>
            </div>
          </div>
        </div>
        
        <!-- Password -->
        <div class="input-group mb-3">
          {{ form.render('memberPassword', ['class': 'form-control', 'placeholder': lang._('login_password_placeholder'), 'id': 'memberPassword']) }}
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        
        <div class="row">
          <div class="col-8">
            <div class="icheck-primary">
              <input type="checkbox" id="remember">
              <label for="remember">
                {{ lang._('login_remember_me') }}
              </label>
            </div>
          </div>
          <!-- /.col -->
          <div class="col-4">
            <button type="submit" class="btn btn-primary btn-block">
              <i class="fas fa-sign-in-alt"></i> {{ lang._('login_signin') }}
            </button>
          </div>
          <!-- /.col -->
        </div>
      </form>
      
      <?php } ?>
    </div>
    <!-- /.card-body -->
  </div>
  <!-- /.card -->
</div>
<!-- /.login-box -->

<script>
// Update server time
function updateServerTime() {
  $.ajax({
    url: baseUrl + 'session/getTime',
    success: function(data) {
      try {
        var timeData = JSON.parse(data);
        $('#serverTime').text(timeData);
      } catch(e) {
        $('#serverTime').text(data);
      }
    }
  });
}

// Update time every 30 seconds
updateServerTime();
setInterval(updateServerTime, 30000);
</script>

