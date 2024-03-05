<div class="container-fluid">
    <div class="row dasboard-box">
        <div class="col-md-2-5">
            <div class="info-box">
               
                <div class="info-box-content">
                    <span class="info-box-text">Total Revenue</span>
                    <span class="info-box-number">₹ {{$total_revenue}} </span>
                </div>
            </div>
        </div>
        <div class="col-md-2-5">
            <div class="info-box mb-3">
               
                <div class="info-box-content">
                    <span class="info-box-text">Completed Appointment</span>
                    <span class="info-box-number">{{$completed_services}}</span>
                </div>
            </div>
        </div>
        <div class="col-md-2-5">
            <div class="info-box mb-3">
               
                <div class="info-box-content">
                    <span class="info-box-text">Upcoming Appointment</span>
                    <span class="info-box-number">{{$upcoming_services}}</span>
                </div>
            </div>
        </div>
        <div class="col-md-2-5">
            <div class="info-box mb-3">
               
                <div class="info-box-content">
                    <span class="info-box-text">Cancelled Appointment</span>
                    <span class="info-box-number">{{$canceled_appointment}}</span>
                </div>
            </div>
        </div> 
        <div class="col-md-2-5">
            <div class="info-box mb-3">
            
                <div class="info-box-content">
                    <span class="info-box-text">New User</span>
                    <span class="info-box-number">{{$new_clients}}</span>
                </div>
            </div>
        </div>
        <div class="col-md-2-5">
            <div class="info-box mb-3">
              
                <div class="info-box-content">
                    <span class="info-box-text">Repeated User</span>
                    <span class="info-box-number">{{$repeated_clients}}</span>
                </div>
            </div>
        </div>
        <div class="col-md-2-5">
            <div class="info-box mb-3">
             
                <div class="info-box-content">
                    <span class="info-box-text">Total User</span>
                    <span class="info-box-number">{{$total_clients}}</span>
                </div>
            </div>
        </div>
        <div class="col-md-2-5">
            <div class="info-box mb-3">
             
                <div class="info-box-content">
                    <span class="info-box-text">Commission</span>
                    <span class="info-box-number">₹ {{$commision}}</span>
                </div>
            </div>
        </div>
        <div class="col-md-2-5">
            <div class="info-box mb-3">
              
                <div class="info-box-content">
                    <span class="info-box-text">Registered Salon</span>
                    <span class="info-box-number">{{$registered_salon}}</span> 
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card card-success">
                <div class="card-header">
                    <h3 class="card-title">Total Revenue</h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
                        <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i></button>
                    </div>
                </div>
                <div class="card-body">
                    <div class="chart">
                      <canvas id="barChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card card-info">
                <div class="card-header">
                    <h3 class="card-title">New/Repeated/Total Users</h3>

                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
                        <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i></button>
                    </div>
                </div>
                <div class="card-body">
                    <div class="chart">
                        <canvas id="lineChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card card-danger">
                <div class="card-header">
                    <h3 class="card-title">New/Active Salon</h3>

                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
                        <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i></button>
                    </div>
                </div>
                <div class="card-body">
                    <canvas id="pieChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="{{asset('plugins/jquery/jquery.min.js')}}"></script>
<script src="{{asset('plugins/chart.js/Chart.min.js')}}"></script>
<script>
  $(function () {

    var barChart = document.getElementById("barChart").getContext('2d');
    var lineChart = document.getElementById("lineChart").getContext('2d');
    var pieChart = document.getElementById("pieChart").getContext('2d');

    var myChart = new Chart(barChart, {
        type: 'line',
        data: <?php echo $total_revenue_graph; ?>,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true,
                        userCallback: function(label, index, labels) {
                            if (Math.floor(label) === label) {
                                return label;
                            }
                        },
                    }
                }]
            },
        indexAxis: 'y',
        }
    });
    var lineChart = new Chart(lineChart, {
        type: 'line',
        data: {
            labels: [<?php echo $datesArr1; ?>],
            datasets: <?php echo $userGraph; ?>},
        options: {
          responsive: true,
          maintainAspectRatio: true,
          indexAxis: 'y',
          scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true,
                        userCallback: function(label, index, labels) {
                            if (Math.floor(label) === label) {
                                return label;
                            }
                        },
                    }
                }]
            }
        }
    });
    var pieChart = new Chart(pieChart, {
        type: 'line',
        data: {
            labels: [<?php echo $datesArr1; ?>],
            datasets: <?php echo $newArray1; ?>},
        options: {
            responsive: true,
            maintainAspectRatio: true,
            indexAxis: 'Y',
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true,
                        userCallback: function(label, index, labels) {
                            if (Math.floor(label) === label) {
                                return label;
                            }
                        },
                    }
                }]
            }
        }
    });
  })
</script>