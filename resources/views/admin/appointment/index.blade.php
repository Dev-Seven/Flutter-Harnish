@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Appointment List</h1>
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
                            <h3 class="card-title">Appointment List</h3>
                        </div>
                        <div class="card-body">
                            <table id="appointment_list_table" style="width: 100%;" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>Sr. No.</th>
                                        <th>Customer Name/Mobile Number</th>
                                        <th>Salon Name</th>
                                        <th>Date/Time</th>
                                        <th>Price (₹)</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @if(!empty($appointments) && count($appointments) > 0)
                                        @foreach($appointments as $key => $appointment)
                                        <tr>
                                            <td>{{$key+1}}</td>
                                            @if(isset($appointment['customer']['name']) && $appointment['customer']['name'] != '')
                                            <td>{{ucfirst($appointment['customer']['name'])}}</td>
                                            @else
                                            <td>{{$appointment['customer']['phone_number']}}</td>
                                            @endif
                                            <td>{{ucfirst($appointment['salon']['salon_name'])}}</td>
                                            <td>{{date('m/d/Y',strtotime($appointment['date']))}} {{date('h:i A',strtotime($appointment['time']))}}</td>
                                            <td>{{numberFormat($appointment['total_revenue_price'])}}</td>
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
                                            <td class="text-center">
                                                <a href="{{route('admin.appointment.view',$appointment['_id'])}}" class="btn icon_loader btn-sm btn-info"><i class="fa fa-eye"></i>
                                                </a>
                                            </td>
                                        </tr>
                                        @endforeach
                                    @else
                                    <tr>
                                        <td colspan="10">No Appointment Found.</td>
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
</div>
@endsection