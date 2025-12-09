$(function () {
  'use strict'

  // Function to render registration chart
  function renderRegistrationChart() {
    if (typeof regProvider === 'undefined' || !regProvider.length) {
      return;
    }

    var tickSize = [1, "day"];
    var xaxis_label = "Date";
    
    var data = [];
    for (var i = 0; i < regProvider.length; i++) {
      data.push([i, regProvider[i][1]]);
    }

    var dataset = [
      {
        label: "Registration",
        data: data,
        color: "#007bff",
        lines: { show: true, fill: true, fillColor: { colors: [{ opacity: 0.1 }, { opacity: 0.3 }] } },
        points: { show: true, radius: 4 }
      }
    ];

    var options = {
      series: {
        lines: { show: true },
        points: { show: true }
      },
      grid: {
        borderWidth: 1,
        borderColor: '#f3f3f3',
        tickColor: '#f3f3f3',
        hoverable: true
      },
      xaxis: {
        ticks: regProvider.map(function(item, index) { return [index, item[0]]; }),
        tickLength: 0
      },
      yaxis: {
        min: 0,
        tickSize: 5
      }
    };

    if ($("#registrationChart").length) {
      $.plot("#registrationChart", dataset, options);
    }
  }

  // Function to render login chart
  function renderLoginChart() {
    if (typeof logProvider === 'undefined' || !logProvider.length) {
      return;
    }

    var data = [];
    for (var i = 0; i < logProvider.length; i++) {
      data.push([i, logProvider[i][1]]);
    }

    var dataset = [
      {
        label: "Login Count",
        data: data,
        color: "#28a745",
        lines: { show: true, fill: true, fillColor: { colors: [{ opacity: 0.1 }, { opacity: 0.3 }] } },
        points: { show: true, radius: 4 }
      }
    ];

    var options = {
      series: {
        lines: { show: true },
        points: { show: true }
      },
      grid: {
        borderWidth: 1,
        borderColor: '#f3f3f3',
        tickColor: '#f3f3f3',
        hoverable: true
      },
      xaxis: {
        ticks: logProvider.map(function(item, index) { return [index, item[0]]; }),
        tickLength: 0
      },
      yaxis: {
        min: 0,
        tickSize: 5
      }
    };

    if ($("#loginChart").length) {
      $.plot("#loginChart", dataset, options);
    }
  }

  // Initialize charts
  renderRegistrationChart();
  renderLoginChart();

  // Show/hide year/month selectors based on type
  function updateRegisterSelectors() {
    var type = $('#typeSelect1').val();
    if (type === '1 days' || type === '1 weeks') {
      $('#regYear').show();
      $('#regMonth').show();
      $('#regYearTo').hide();
    } else if (type === '1 months') {
      $('#regYear').show();
      $('#regMonth').hide();
      $('#regYearTo').hide();
    } else if (type === '1 years') {
      $('#regYear').show();
      $('#regMonth').hide();
      $('#regYearTo').show();
    }
  }

  function updateLoginSelectors() {
    var type = $('#typeSelect2').val();
    if (type === '1 days' || type === '1 weeks') {
      $('#logYear').show();
      $('#logMonth').show();
      $('#logYearTo').hide();
    } else if (type === '1 months') {
      $('#logYear').show();
      $('#logMonth').hide();
      $('#logYearTo').hide();
    } else if (type === '1 years') {
      $('#logYear').show();
      $('#logMonth').hide();
      $('#logYearTo').show();
    }
  }

  // Initialize selectors
  updateRegisterSelectors();
  updateLoginSelectors();

  // Update CPU in real-time (optional)
  function updateSystemStats() {
    // You can implement AJAX calls here to update stats in real-time
    // Example:
    // $.ajax({
    //   url: baseUrl + 'dashboard/getStats',
    //   success: function(data) {
    //     $('#cpu-value').text(data.cpu);
    //   }
    // });
  }

  // Optional: Update stats every 30 seconds
  // setInterval(updateSystemStats, 30000);
});

// Callback functions for select changes
function onSelType1() {
  var type = $('#typeSelect1').val();
  var year = $('#yearSelect1').val();
  var month = $('#monthSelect1').val();
  var yearTo = $('#yearSelect1To').val();
  
  var url = baseUrl + 'dashboard/index?RegType=' + type + '&selRegYear=' + year + '&selRegMonth=' + month + '&selRegYearTo=' + yearTo;
  window.location.href = url;
}

function onSelType2() {
  var type = $('#typeSelect2').val();
  var year = $('#yearSelect2').val();
  var month = $('#monthSelect2').val();
  var yearTo = $('#yearSelect2To').val();
  
  var url = baseUrl + 'dashboard/index?logType=' + type + '&selLogYear=' + year + '&selLogMonth=' + month + '&selLogYearTo=' + yearTo;
  window.location.href = url;
}

