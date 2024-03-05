@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <div class="container-fluid overlay-add">
        <div class="load-first">
        </div>
        <div class="row">
            <div class="col-xl-2 filter-sec">
                <div class="padd-20">
                    <div class="cd-filter-block">
                        <div class="service-dropdown">
                            <input type="hidden" class="form-control daterangepicker_value" name="daterange"/>
                            <div id="id_daterangepicker" class="filter_drop_time" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 100%">
                                <i class="fa fa-calendar"></i>&nbsp;
                                <span></span> <i class="fa fa-caret-down"></i>
                            </div>
                        </div> 
                        <input type="hidden" class="start_date">
                        <input type="hidden" class="end_date">
                    </div>
                    <div class="cd-filter-block">
                        <h4>Location</h4>
                        <div class="service-dropdown">
                            <form id="form_location_dropdown">
                            @csrf
                            <select id="location" class="form-control location_dropdown">
                                <option value="">Select Location</option>
                                @if(!empty($cities) && count($cities) > 0)
                                    @foreach($cities as $city)
                                    <option value="{{$city->_id}}">{{ucfirst($city->name)}}</option>
                                    @endforeach
                                @endif
                            </select>
                            </form>
                        </div>
                    </div>
                    <div class="cd-filter-block">
                        <h4>Type</h4>
                        <div class="service-dropdown">
                            <form id="form_location_dropdown">
                                @csrf
                                <div class="">
                                    <select name="type" id="type" class="form-control type_dropdown">
                                        <option value="">Select Type...</option>
                                        <option value="male">Male</option>
                                        <option value="female">Female</option>
                                        <option value="unisex">Unisex</option>
                                    </select>
                                </div>
                            </form>
                        </div> 
                    </div>
                    <div class="cd-filter-block">
                        <h4>Salon</h4>
                        <div class="service-dropdown">
                            <form id="form_location_dropdown">
                                @csrf
                                <div class="">
                                    <select name="salon" id="salon" class="form-control salon_dropdown">
                                        <option value="">Select Salon...</option>
                                        @if(!empty($salonList) && count($salonList) > 0)
                                            @foreach($salonList as $salon)
                                            <option value="{{$salon->_id}}">{{ucfirst($salon->salon_name)}}</option>
                                            @endforeach
                                        @endif
                                    </select>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="cd-filter-block">
                        <h4>Stylist</h4>
                        <div class="service-dropdown">
                            <form id="form_location_dropdown">
                                @csrf
                                <div class="stylist_class">
                                    <select name="stylist" id="stylist" class="form-control stylist_dropdown">
                                        <option value="">First Select Salon</option>
                                    </select>
                                </div>
                            </form>
                        </div>
                    </div>
                </div> 
            </div>

            <div class="col-xl-10 dashboard-right" style="background:#eaedf0;">
                @include('layouts.toastr')
                <section class="content mt-5 append_data">
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
                </section>
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
        data: {
            labels: ["Ahmadabad",   "Surat",   "Rajkot",  "Vadodara"],
            datasets: [{
                label: 'Total Revenue',
                data: [1500, 3800, 4600, 2000],
                fill: false,
                borderColor: '#2196f3',
                backgroundColor: '#2196f3',
                borderWidth: 1
            }]},
        options: {
          responsive: true,
          maintainAspectRatio: false,
          indexAxis: 'y',
        }
    });
    var lineChart = new Chart(lineChart, {
        type: 'line',
        data: {
            labels: [<?php echo $datesArr1; ?>],
            datasets: <?php echo $newArray1; ?>},
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
<script type="text/javascript" src="{{asset('js/moment.min.js')}}"></script>
<script type="text/javascript" src="{{asset('js/daterangepicker.js')}}"></script>
<link rel="stylesheet" type="text/css" href="{{asset('css/daterangepicker.css')}}" />
<script type="text/javascript">

    $(document).ready(function(e){
        var token = '{{csrf_token()}}'
        var location_value = $('.location_dropdown').val();
        var type_value = $('.type_dropdown').val();
        var salon_value = $('.salon_dropdown').val();
        var stylist_value = $('.stylist_dropdown').val();

        filter_dashboard(token,location_value,type_value,salon_value,stylist_value);
    });

    var start = moment().subtract(29, 'days');
    var end = moment();

    function cb(start, end) {
        $('#id_daterangepicker span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
        var start_date = start.format('MMMM D, YYYY H:m:s');
        var end_date = end.format('MMMM D, YYYY H:m:s');
        $('.start_date').val(start_date);
        $('.end_date').val(end_date);

        var token = '{{csrf_token()}}'
        var location_value = $('.location_dropdown').val();
        var type_value = $('.type_dropdown').val();
        var salon_value = $('.salon_dropdown').val();
        var stylist_value = $('.stylist_dropdown').val();

        filter_dashboard(token,location_value,type_value,salon_value,stylist_value);
    }

    $('#id_daterangepicker').daterangepicker({
        startDate: start,
        endDate: end,
        locale: {
            format: 'DD/MM/YYYY',
        },
        ranges: {
            'Today': [moment(), moment()],
            'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            'Last 7 Days': [moment().subtract(6, 'days'), moment()],
            'Last 30 Days': [moment().subtract(29, 'days'), moment()],
            'This Month': [moment().startOf('month'), moment().endOf('month')],
            'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        }
    }, cb);
    cb(start, end);
</script>
<link href="{{asset('plugins/select2/css/select2.min.css')}}" rel="stylesheet" />
<script src="{{asset('plugins/select2/js/select2.min.js')}}"></script>
<script>
    var $j = jQuery.noConflict();
      
    $j("#location").select2({
      placeholder: "Select a Location",
      allowClear: true
    });
    $j("#type").select2({
      placeholder: "Select a Salon Type",
      allowClear: true,
      "language": {
        "noResults": function(){
            return "First Select Location"
        }
      },
    });
    $j("#salon").select2({
      placeholder: "Select a Salon",
      allowClear: true,
      "language": {
        "noResults": function(){
            return "No Salon Found"
        }
      },
    });
    $j("#stylist").select2({
      placeholder: "Select a Stylist",
      allowClear: true,
      "language": {
        "noResults": function(){
            return "First Select Salon"
        }
      },
    });
    
    $j(document).ready(function(){
        $('#stylist').attr('disabled',true);

        $j(document).on('change','.location_dropdown',function(){
            var token = '{{csrf_token()}}'
            var location_value = $(this).val();
            var type_value = $('.type_dropdown').val();
            var salon_value = $('.salon_dropdown').val();
            var stylist_value = $('.stylist_dropdown').val();
            filter_dashboard(token,location_value,type_value,salon_value,stylist_value)
        });

        $j(document).on('change','.type_dropdown',function(){
            var token = '{{csrf_token()}}'
            var type_value = $(this).val();
            var location_value = $('.location_dropdown').val();
            var salon_value = $('.salon_dropdown').val();
            var stylist_value = $('.stylist_dropdown').val();
            filter_dashboard(token,location_value,type_value,salon_value,stylist_value)
        });

        $j(document).on('change','.salon_dropdown',function(){
            var token = '{{csrf_token()}}'
            var salon_value = $(this).val();
            var type_value = $('.type_dropdown').val();
            var location_value = $('.location_dropdown').val();
            var stylist_value = $('.stylist_dropdown').val();
            change_salon_dropdown(token,type_value,location_value,salon_value);
            filter_dashboard(token,location_value,type_value,salon_value,stylist_value);
        });

        $j(document).on('change','.stylist_dropdown',function(){
            var token = '{{csrf_token()}}'
            var stylist_value = $(this).val();
            var salon_value = $('salon_dropdown').val();
            var type_value = $('.type_dropdown').val();
            var location_value = $('.location_dropdown').val();
            filter_dashboard(token,location_value,type_value,salon_value,stylist_value)
        });
    });

    function change_salon_dropdown(token,type,location,salon)
    {
        $.ajax({
            url: "{{route('admin.dashboard.filter_salon_dropdown')}}",
            method:"post",
            data:{_token:token,type:type,location:location,salon:salon},
            success : function(result){
                $('.stylist_class').html(result);
                $('#salon').attr('disabled',false);
                if(salon != ""){
                    $('#stylist').attr('disabled',false);
                } else {
                    $('#stylist').attr('disabled',true);
                }
            }
        });
    }

    function filter_dashboard(token,location,type,salon,stylist)
    {
        var start_date = $('.start_date').val();
        var end_date = $('.end_date').val();

        $('.load-first').html('<div id="loading"><img src="{{asset("img/tenor.gif")}}"></div>');
        $('.overlay-add').addClass('overlay');
        $.ajax({
            url: "{{route('admin.dashboard.filter_dashboard')}}",
            method:"post",
            data:{location:location,_token:token,type:type,salon:salon,stylist:stylist,start_date:start_date,end_date:end_date},
            success : function(data){
                $('.append_data').html(data);
                $('.load-first').html('');
                $('.overlay-add').removeClass('overlay');
            },
        });
    }
</script>
<link rel="stylesheet" type="text/css" href="{{asset('css/dashboard.css')}}">
@endsection
