@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Appointment Details</h1>
                </div>
                <div class="col-sm-6 text-right">
                    <a href="{{route('admin.appointment.index')}}" class="btn btn-danger btn_loader"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back</a>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Appointment Details</h3>
                        </div>
                        <div class="card-body">
                            <table class="table table-bordered table-striped">
                                <thead>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>Date Time</th>
                                        <td>{{date('m/d/Y',strtotime($appointment['date']))}} {{date('h:i A',strtotime($appointment['time']))}}</td>
                                    </tr>
                                    <tr>
                                        <th>Status</th>
                                        <td>
                                            @if($appointment['status'] == APPOINTMENT_ACCEPT)
                                            <span style="color:green;">Accepted</span>
                                            @elseif($appointment['status'] == APPOINTMENT_INPROGRESS)
                                            <span style="color:orange;">In Progress</span>
                                            @elseif($appointment['status'] == APPOINTMENT_COMPLETE)
                                            <span style="color:green;">Completed</span>
                                            @elseif($appointment['status'] == APPOINTMENT_CANCEL)
                                            <span style="color:red;">Canceled</span>
                                            @elseif($appointment['status'] == APPOINTMENT_REJECT)
                                            <span style="color:red;">Rejected</span>
                                            @else
                                            <span style="color:grey;">Pending</span>
                                            @endif
                                        </td>
                                    </tr>
                                    @if(isset($appointment['payment_id']) && $appointment['payment_id'] != "")
                                    <tr>
                                        <td>Payment Id</td>
                                        <td>{{$appointment['payment_id']}}</td>
                                    </tr>
                                    @endif
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Appointment Services/Package</h3>
                        </div>
                        <div class="card-body">
                            <table class="table table-bordered table-striped">
                                <tbody>
                                    <tr>
                                        <th>Type</th>
                                        <th>Name</th>
                                        <th>Price</th>
                                    </tr>
                                    <?php $total_price = 0; ?>
                                    @if(!empty($appointment['appointment_services']) && count($appointment['appointment_services']) > 0)
                                        @foreach($appointment['appointment_services'] as $pack)
                                        <tr>
                                            <td>{{ucfirst($pack['type'])}}</td>
                                            <td>{{ucfirst($pack['name'])}}</td>
                                            <td>₹ {{numberFormat($pack['price'])}}</td>
                                        </tr>
                                        <?php $total_price = $total_price + $pack['price']; ?>
                                        @endforeach
                                    @else
                                    <tr>
                                        <td colspan="3">No Service/Package Found</td>
                                    </tr>
                                    @endif
                                </tbody>
                            </table>
                            <span style="float: right;"><strong>Total Price</strong> : ₹ {{numberFormat($total_price)}}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Customer Details</h3>
                        </div>
                        <div class="card-body">
                            <div class="row"> 
                                <div class="col-md-12">
                                    <table id="employee_sub_table" class="table table-bordered table-striped mb-3" style="width: 100%;">
                                        <thead>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th>Name</th>
                                                <td>
                                                    @if($appointment['customer']['name'] != '')
                                                    {{ucfirst($appointment['customer']['name'])}}
                                                    @else
                                                    -
                                                    @endif
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Contact No.</th>
                                                <td>{{$appointment['customer']['phone_number']}}</td>
                                            </tr>  
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Salon Details</h3>
                        </div>
                        <div class="card-body">
                            <div class="row"> 
                                <div class="col-md-12">
                                    <table id="employee_sub_table" class="table table-bordered table-striped mb-3" style="width: 100%;">
                                        <tbody>
                                            <tr>
                                                <th>Name</th>
                                                <td>{{ucfirst($appointment['salon']['salon_name'])}}</td>
                                            </tr>
                                            <tr>
                                                <th>Address</th>
                                                <td>{{ucfirst($appointment['salon']['address'])}}</td>
                                            </tr>
                                            <tr>
                                                <th>Tower</th>
                                                <td>{{ucfirst($appointment['salon']['tower_name'])}}</td>
                                            </tr>
                                            <tr>
                                                <th>Near By</th>
                                                <td>{{ucfirst($appointment['salon']['near_by'])}}</td>
                                            </tr>
                                            
                                            <tr>
                                                <th>Area</th>
                                                <td>{{ucfirst($appointment['salon']['area'])}}
                                                @if(!empty($appointment['salon']['city_detail']))
                                                , {{ucfirst($appointment['salon']['city_detail']['name'])}}
                                                @endif
                                                , {{ucfirst($appointment['salon']['state'])}}</td>
                                            </tr>
                                            @endif
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
@endsection