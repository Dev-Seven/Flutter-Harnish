@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Stylist Details</h1>
                </div>
                <div class="col-sm-6 text-right">
                    <a href="{{route('admin.stylist.index')}}" class="btn btn-danger btn_loader"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back</a>
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
                            <h3 class="card-title">Stylist Details</h3>
                        </div>
                        <div class="card-body">
                            <table class="table table-bordered table-striped">
                                <tbody>
                                    <tr>
                                        <th>Stylist Name</th>
                                        <td>{{ucfirst($stylist->name)}}</td>
                                    </tr>
                                    <tr>
                                        <th>Salon Name</th>
                                        @if(!empty($stylist->salon_detail))
                                        <td>{{ucfirst($stylist->salon_detail->salon_name)}}</td>
                                        @else
                                        <td>-</td>
                                        @endif
                                    </tr>
                                    <tr>
                                        <th>Mobile Number</th>
                                        <td>{{$stylist->phone_number}}</td>
                                    </tr>
                                    <tr>
                                        <th>E-Mail Address</th>
                                        <td>{{$stylist->email}}</td>
                                    </tr>
                                    <tr>
                                        <th>Address</th>
                                        @if(!empty($stylist->city_detail))
                                        <td>{{ucfirst($stylist->city_detail->name)}}</td>
                                        @else
                                        <td>-</td>
                                        @endif
                                    </tr>
                                    <tr>
                                        <th>Total Revenue (₹)</th>
                                        <td>{{$stylist->total_revenue}}</td>
                                    </tr>
                                    <tr>
                                        <th>Ratings (Average)</th>
                                        <td>{{$stylist->rating}}</td>
                                    </tr>
                                    <tr>
                                        <th>Status</th>
                                        <td>
                                            @if($stylist->status == 1)
                                            <span style="color: green;">Active</span>
                                            @else
                                            <span style="color: red;">Block</span>
                                            @endif
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
@if(isset($stylist->stylistAppointment) && !empty($stylist->stylistAppointment) && count($stylist->stylistAppointment) > 0)
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Appointments</h1>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <table id="appointment_list_table" style="width: 100%;" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Customer Name</th>
                                        <th>Salon Name</th>
                                        <th>Date/Time</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($stylist->stylistAppointment as $key => $appointment)
                                    <tr>
                                        <td>{{$key+1}}</td>
                                        <td>{{ucfirst($appointment->customer->name)}}</td>
                                        <td>{{ucfirst($appointment->salon->salon_name)}}</td>
                                        <td>{{date('m/d/Y',strtotime($appointment->date))}} {{date('h:i A',strtotime($appointment->time))}}</td>
                                        <td>
                                            @if($appointment->status == APPOINTMENT_ACCEPT)
                                            <span style="color:green;">Accepted</span>
                                            @elseif($appointment->status == APPOINTMENT_INPROGRESS)
                                            <span style="color:orange;">In Progress</span>
                                            @elseif($appointment->status == APPOINTMENT_COMPLETE)
                                            <span style="color:green;">Completed</span>
                                            @elseif($appointment->status == APPOINTMENT_CANCEL)
                                            <span style="color:red;">Canceled</span>
                                            @elseif($appointment->status == APPOINTMENT_REJECT)
                                            <span style="color:red;">Rejected</span>
                                            @else
                                            <span style="color:grey;">Pending</span>
                                            @endif
                                        </td>
                                        <td class="text-center">
                                            <a href="{{route('admin.appointment.view',$appointment->_id)}}" class="btn icon_loader btn-sm btn-info"><i class="fa fa-eye"></i>
                                            </a>
                                        </td>
                                    </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    @endif
</div>
@endsection