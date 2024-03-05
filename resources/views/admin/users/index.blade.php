@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-7">
                    <h1>Users List</h1>
                </div>
                <div class="col-sm-5">
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
                            <h3 class="card-title">Users List</h3>
                        </div>
                        <div class="card-body">
                            <table id="user_table" style="width: 100%;" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>User Name</th>
                                        <th>Mobile Number</th>
                                        <th>Location</th>
                                        <th>City</th>
                                        <th>Email</th>
                                        <th>Gender</th>
                                        <th>Total Appointments</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @if(!empty($users) && count($users) > 0)
                                        @foreach($users as $key => $user)
                                        <tr>
                                            <td>{{ucfirst($user->name)}}</td>
                                            <td>{{$user->phone_number}}</td>
                                            <td>{{$user->location}}</td>
                                            @if(!empty($user->city_detail))
                                            <td>{{ucfirst($user->city_detail->name)}}</td>
                                            @else
                                            <td>-</td>
                                            @endif
                                            <td>{{$user->email}}</td>
                                            <td>
                                                @if($user->gender == 'm')
                                                Male
                                                @elseif($user->gender == 'f')
                                                Female
                                                @else
                                                Other
                                                @endif
                                            </td>
                                            <td>{{count($user->user_appointment)}}</td>
                                            <td>
                                                @if(count($user->user_appointment) > 1)
                                                <span>Old</span>
                                                @else
                                                <span>New</span>
                                                @endif
                                            </td>
                                            <td class="text-center">
                                                <a href="{{route('admin.users.view',$user->_id)}}" class="btn icon_loader btn-sm btn-info"><i class="fa fa-eye"></i>
                                                </a>
                                            </td>
                                        </tr>
                                        @endforeach
                                    @else
                                    <tr>
                                        <td colspan="15">No User Found.</td>
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