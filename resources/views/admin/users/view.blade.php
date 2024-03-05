@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>User Details</h1>
                </div>
                <div class="col-sm-6 text-right">
                    <a href="{{route('admin.users.index')}}" class="btn btn-danger btn_loader"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back</a>
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
                            <h3 class="card-title">User Details</h3>
                        </div>
                        <div class="card-body">
                            <table class="table table-bordered table-striped">
                                <tbody>
                                    <tr>
                                        <th>User Name</th>
                                        <td>{{ucfirst($user->name)}}</td>
                                    </tr>
                                    <tr>
                                        <th>Gender</th>
                                        <td>
                                            @if($user->gender == 'm')
                                            Male
                                            @elseif($user->gender == 'f')
                                            Female
                                            @else
                                            Other
                                            @endif
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Mobile Number</th>
                                        <td>{{$user->phone_number}}</td>
                                    </tr>
                                    <tr>
                                        <th>E-Mail Address</th>
                                        <td>{{$user->email}}</td>
                                    </tr>
                                    <tr>
                                        <th>Address</th>
                                        <td>{{$user->location}}</td>
                                    </tr>
                                    <tr>
                                        <th>Status</th>
                                        <td>
                                            @if(count($user->user_appointment) > 1)
                                            <span>Old</span>
                                            @else
                                            <span>New</span>
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
    @if(!empty($user->user_appointment) && count($user->user_appointment) > 0)
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Appointments ({{count($user->user_appointment)}})</h1>
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
                                        <th>Salon Name</th>
                                        <th>Date/Time</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($user->user_appointment as $key => $appointment)
                                    <tr>
                                        <td>{{$key+1}}</td>
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