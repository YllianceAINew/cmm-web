{{ content() }}

<!-- User Management Metrics (Small Boxes) -->
<div class="row">
  <div class="col-lg-3 col-6">
    <!-- small box -->
    <div class="small-box bg-info">
      <div class="inner">
        <h3>{{ userMetrics['total_users'] | number_format }}</h3>
        <p>Total Users</p>
      </div>
      <div class="icon">
        <i class="fas fa-users"></i>
      </div>
      <a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
    </div>
  </div>
  <!-- ./col -->
  <div class="col-lg-3 col-6">
    <!-- small box -->
    <div class="small-box bg-success">
      <div class="inner">
        <h3>{{ userMetrics['active_today'] | number_format }}</h3>
        <p>Active Users Today</p>
      </div>
      <div class="icon">
        <i class="fas fa-user-check"></i>
      </div>
      <a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
    </div>
  </div>
  <!-- ./col -->
  <div class="col-lg-3 col-6">
    <!-- small box -->
    <div class="small-box bg-warning">
      <div class="inner">
        <h3>{{ userMetrics['new_signups_week'] | number_format }}</h3>
        <p>New Signups This Week</p>
      </div>
      <div class="icon">
        <i class="fas fa-user-plus"></i>
      </div>
      <a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
    </div>
  </div>
  <!-- ./col -->
  <div class="col-lg-3 col-6">
    <!-- small box -->
    <div class="small-box bg-danger">
      <div class="inner">
        <h3>{{ userMetrics['users_online'] | number_format }}</h3>
        <p>Users Currently Online</p>
      </div>
      <div class="icon">
        <i class="fas fa-circle"></i>
      </div>
      <a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
    </div>
  </div>
  <!-- ./col -->
</div>
<!-- /.row -->

<!-- Server / System Indicators Table -->
<div class="row">
  <div class="col-12">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">
          <i class="fas fa-server mr-1"></i>
          Server / System Indicators
        </h3>
      </div>
      <!-- /.card-header -->
      <div class="card-body">
        <table class="table table-bordered table-striped table-hover">
          <thead>
            <tr>
              <th>Server Name</th>
              <th>Status</th>
              <th>CPU Usage (%)</th>
              <th>RAM Usage (%)</th>
              <th>Disk Usage (%)</th>
              <th>Network In</th>
              <th>Network Out</th>
              <th>Uptime</th>
              <th>Last Check Time</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {% for server in servers %}
            <tr>
              <td><strong>{{ server['name'] }}</strong></td>
              <td>
                {% if server['status'] == 'online' %}
                  <span class="badge badge-success">Online</span>
                {% else %}
                  <span class="badge badge-danger">Offline</span>
                {% endif %}
              </td>
              <td>
                <div class="progress progress-xs">
                  <div class="progress-bar {% if server['cpu'] > 80 %}bg-danger{% elseif server['cpu'] > 60 %}bg-warning{% else %}bg-success{% endif %}" 
                       style="width: {{ server['cpu'] }}%"></div>
                </div>
                <small class="text-muted">{{ server['cpu'] }}%</small>
              </td>
              <td>
                <div class="progress progress-xs">
                  <div class="progress-bar {% if server['ram'] > 80 %}bg-danger{% elseif server['ram'] > 60 %}bg-warning{% else %}bg-info{% endif %}" 
                       style="width: {{ server['ram'] }}%"></div>
                </div>
                <small class="text-muted">{{ server['ram'] }}%</small>
              </td>
              <td>
                <div class="progress progress-xs">
                  <div class="progress-bar {% if server['disk'] > 80 %}bg-danger{% elseif server['disk'] > 60 %}bg-warning{% else %}bg-primary{% endif %}" 
                       style="width: {{ server['disk'] }}%"></div>
                </div>
                <small class="text-muted">{{ server['disk'] }}%</small>
              </td>
              <td><span class="text-info"><i class="fas fa-arrow-down"></i> {{ server['network_in'] }}</span></td>
              <td><span class="text-success"><i class="fas fa-arrow-up"></i> {{ server['network_out'] }}</span></td>
              <td><small>{{ server['uptime'] }}</small></td>
              <td><small class="text-muted">{{ server['last_check'] }}</small></td>
              <td>
                <a href="#" class="btn btn-sm btn-primary" title="View Details">
                  <i class="fas fa-eye"></i> View Details
                </a>
              </td>
            </tr>
            {% endfor %}
          </tbody>
        </table>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
  </div>
  <!-- /.col -->
</div>
<!-- /.row -->

<!-- User Growth Chart -->
<div class="row">
  <div class="col-12">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">
          <i class="fas fa-chart-line mr-1"></i>
          User Growth Chart
        </h3>
        <div class="card-tools">
          <button type="button" class="btn btn-tool" data-card-widget="collapse">
            <i class="fas fa-minus"></i>
          </button>
        </div>
      </div>
      <!-- /.card-header -->
      <div class="card-body">
        <div class="chart">
          <canvas id="userGrowthChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
        </div>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
  </div>
  <!-- /.col -->
</div>
<!-- /.row -->

<script>
// User Growth Chart using Chart.js
var userGrowthData = {{ userGrowthData | json_encode }};

// Initialize chart after all resources (including Chart.js) are loaded
window.addEventListener('load', function() {
  // Double-check Chart.js is available
  if (typeof Chart === 'undefined') {
    console.error('Chart.js is not loaded');
    return;
  }
  
  var canvas = document.getElementById('userGrowthChart');
  if (!canvas) {
    console.error('Canvas element not found');
    return;
  }
  
  var ctx = canvas.getContext('2d');
  var userGrowthChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: userGrowthData.labels,
      datasets: [{
        label: 'Total Users',
        data: userGrowthData.data,
        borderColor: 'rgb(75, 192, 192)',
        backgroundColor: 'rgba(75, 192, 192, 0.2)',
        borderWidth: 2,
        fill: true,
        tension: 0.4,
        pointRadius: 4,
        pointHoverRadius: 6,
        pointBackgroundColor: 'rgb(75, 192, 192)',
        pointBorderColor: '#fff',
        pointBorderWidth: 2
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: true,
          position: 'top',
        },
        tooltip: {
          mode: 'index',
          intersect: false,
        }
      },
      scales: {
        y: {
          beginAtZero: false,
          ticks: {
            callback: function(value) {
              return value.toLocaleString();
            }
          }
        }
      },
      interaction: {
        mode: 'nearest',
        axis: 'x',
        intersect: false
      }
    }
  });
});
</script>

<style>
/* Hover effect for table rows */
.table-hover tbody tr:hover {
  background-color: rgba(0, 0, 0, 0.05);
  transition: background-color 0.15s ease-in-out;
}

/* Progress bar styling */
.progress-xs {
  height: 8px;
  margin-bottom: 2px;
}

/* Card hover effect */
.card {
  transition: box-shadow 0.15s ease-in-out;
}

.card:hover {
  box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
}
</style>
