{{ content() }}

<script type="text/javascript">
    var memory = {{ memory | json_encode }};
    var ram = {{ ram | json_encode }};
    var cpu = {{ cpu |json_encode }};

    var regProvider = [];
    var registerData = {{ registerData | json_encode }};
        for(date in registerData){
            regProvider.push([date,registerData[date]]);
        }

    var logProvider = [];
    var loginData = {{ loginData | json_encode }};
        for(date in loginData){
            logProvider.push([date, loginData[date]]);
        }
</script>

<!-- Small boxes (Stat box) -->
<div class="row">
  <div class="col-lg-3 col-6">
    <!-- small box -->
    <div class="small-box bg-info">
      <div class="inner">
        <h3 id="totalUsers">{{ members|length }}</h3>
        <p>Total Users</p>
      </div>
      <div class="icon">
        <i class="fas fa-users"></i>
      </div>
      <a href="{{ url('member/summary') }}" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
    </div>
  </div>
  <!-- ./col -->
  <div class="col-lg-3 col-6">
    <!-- small box -->
    <div class="small-box bg-success">
      <div class="inner">
        <h3 id="cpuUsage"><span id="cpu-value">{{ cpu }}</span><sup style="font-size: 20px">%</sup></h3>
        <p>CPU Usage</p>
      </div>
      <div class="icon">
        <i class="fas fa-microchip"></i>
      </div>
      <a href="#" class="small-box-footer">Real-time <i class="fas fa-sync"></i></a>
    </div>
  </div>
  <!-- ./col -->
  <div class="col-lg-3 col-6">
    <!-- small box -->
    <div class="small-box bg-warning">
      <div class="inner">
        <h3 id="ramUsage">{{ ram[0]|number_format(1) }}</h3>
        <p>RAM Used ({{ ram[3] }})</p>
      </div>
      <div class="icon">
        <i class="fas fa-memory"></i>
      </div>
      <a href="#" class="small-box-footer">{{ ram[0]|number_format(1) }}/{{ ram[1]|number_format(1) }} {{ ram[3] }}</a>
    </div>
  </div>
  <!-- ./col -->
  <div class="col-lg-3 col-6">
    <!-- small box -->
    <div class="small-box bg-danger">
      <div class="inner">
        <h3 id="diskUsage">{{ memory[0] }}</h3>
        <p>Disk Usage</p>
      </div>
      <div class="icon">
        <i class="fas fa-hdd"></i>
      </div>
      <a href="#" class="small-box-footer">{{ memory[0] }}/{{ memory[1] }}</a>
    </div>
  </div>
  <!-- ./col -->
</div>
<!-- /.row -->

<!-- Main row -->
<div class="row">
  <!-- Left col -->
  <section class="col-lg-6 connectedSortable">
    <!-- Custom tabs (Charts with tabs)-->
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">
          <i class="fas fa-chart-pie mr-1"></i>
          {{ lang._('dashboard_register') }}
        </h3>
        <div class="card-tools">
          <button type="button" class="btn btn-tool" data-card-widget="collapse">
            <i class="fas fa-minus"></i>
          </button>
        </div>
      </div><!-- /.card-header -->
      <div class="card-body">
        <div class="row mb-3">
          <div class="col-md-4">
            <label>{{ lang._('dashboard_sort') }}</label>
            <select id="typeSelect1" class="form-control form-control-sm" onchange="onSelType1()">
            <?php
                $i = 0;
                for($i = 0;$i < 4;$i ++){
                    if($regUnit == $typeSelect[$i])
                        echo "<option value = '".$typeSelect[$i]."' selected>".$typeName[$i]."</option>";
                    else
                        echo "<option value = '".$typeSelect[$i]."'>".$typeName[$i]."</option>";
                }
            ?>
            </select>
          </div>
          
          <div class="col-md-3" id="regYear">
            <label>{{ lang._('dashboard_year') }}</label>
            <select id="yearSelect1" class="form-control form-control-sm" onchange="onSelType1()">
            <?php
                foreach($years as $year){
                    if($selRegYear == $year)
                        echo "<option value = '".$year."' selected>".$year."</option>";
                    else
                        echo "<option value = '".$year."'>".$year."</option>";
                }
            ?>
            </select>
          </div>
          
          <div class="col-md-3" id="regMonth">
            <label>{{ lang._('dashboard_month') }}</label>
            <select id="monthSelect1" class="form-control form-control-sm" onchange="onSelType1()">
            <?php
                foreach($months as $month){
                    if($selRegMonth == $month)
                        echo "<option value = '".$month."' selected>".$month."</option>";
                    else
                        echo "<option value = '".$month."'>".$month."</option>";
                }
            ?>
            </select>
          </div>
          
          <div class="col-md-3" id="regYearTo" style="display:none;">
            <label>{{ lang._('dashboard_year_to') }}</label>
            <select id="yearSelect1To" class="form-control form-control-sm" onchange="onSelType1()">
            <?php
                foreach($years as $year){
                    if($selRegYearTo == $year)
                        echo "<option value = '".$year."' selected>".$year."</option>";
                    else
                        echo "<option value = '".$year."'>".$year."</option>";
                }
            ?>
            </select>
          </div>
        </div>
        
        <div class="chart">
          <div id="registrationChart" style="min-height: 300px; height: 300px; max-height: 300px; max-width: 100%;"></div>
        </div>
      </div><!-- /.card-body -->
    </div>
    <!-- /.card -->
  </section>
  <!-- /.Left col -->
  
  <!-- right col (We are only adding the ID to make the widgets sortable)-->
  <section class="col-lg-6 connectedSortable">
    <!-- Custom tabs (Charts with tabs)-->
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">
          <i class="fas fa-chart-line mr-1"></i>
          {{ lang._('dashboard_login') }}
        </h3>
        <div class="card-tools">
          <button type="button" class="btn btn-tool" data-card-widget="collapse">
            <i class="fas fa-minus"></i>
          </button>
        </div>
      </div><!-- /.card-header -->
      <div class="card-body">
        <div class="row mb-3">
          <div class="col-md-4">
            <label>{{ lang._('dashboard_sort') }}</label>
            <select id="typeSelect2" class="form-control form-control-sm" onchange="onSelType2()">
            <?php
                $i = 0;
                for($i = 0;$i < 4;$i ++){
                    if($logUnit == $typeSelect[$i])
                        echo "<option value = '".$typeSelect[$i]."' selected>".$typeName[$i]."</option>";
                    else
                        echo "<option value = '".$typeSelect[$i]."'>".$typeName[$i]."</option>";
                }
            ?>
            </select>
          </div>
          
          <div class="col-md-3" id="logYear">
            <label>{{ lang._('dashboard_year') }}</label>
            <select id="yearSelect2" class="form-control form-control-sm" onchange="onSelType2()">
            <?php
                foreach($years as $year){
                    if($selLogYear == $year)
                        echo "<option value = '".$year."' selected>".$year."</option>";
                    else
                        echo "<option value = '".$year."'>".$year."</option>";
                }
            ?>
            </select>
          </div>
          
          <div class="col-md-3" id="logMonth">
            <label>{{ lang._('dashboard_month') }}</label>
            <select id="monthSelect2" class="form-control form-control-sm" onchange="onSelType2()">
            <?php
                foreach($months as $month){
                    if($selLogMonth == $month)
                        echo "<option value = '".$month."' selected>".$month."</option>";
                    else
                        echo "<option value = '".$month."'>".$month."</option>";
                }
            ?>
            </select>
          </div>
          
          <div class="col-md-3" id="logYearTo" style="display:none;">
            <label>{{ lang._('dashboard_year_to') }}</label>
            <select id="yearSelect2To" class="form-control form-control-sm" onchange="onSelType2()">
            <?php
                foreach($years as $year){
                    if($selLogYearTo == $year)
                        echo "<option value = '".$year."' selected>".$year."</option>";
                    else
                        echo "<option value = '".$year."'>".$year."</option>";
                }
            ?>
            </select>
          </div>
        </div>
        
        <div class="chart">
          <div id="loginChart" style="min-height: 300px; height: 300px; max-height: 300px; max-width: 100%;"></div>
        </div>
      </div><!-- /.card-body -->
    </div>
    <!-- /.card -->
  </section>
  <!-- right col -->
</div>
<!-- /.row (main row) -->

