@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Package Details</h1>
                </div>
                <div class="col-sm-6 text-right">
                    <a href="{{route('admin.package.index')}}" class="btn btn-danger btn_loader"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back</a>
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
                            <h3 class="card-title">Package Details</h3>
                        </div>
                        <div class="card-body">
                            <table class="table table-bordered table-striped">
                                <tbody>
                                    <tr>
                                        <th>Salon Name</th>
                                        @if(!empty($package->salon_detail))
                                        <td>{{ucfirst($package->salon_detail->salon_name)}}</td>
                                        @else
                                        <td>-</td>
                                        @endif
                                    </tr>
                                    <tr>
                                        <th>Package Name</th>
                                        <td>{{ucfirst($package->name)}}</td>
                                    </tr>
                                    <tr>
                                        <th>Price (₹)</th>
                                        <td>{{$package->price}}</td>
                                    </tr>
                                    <tr>
                                        <th>Discount (%)</th>
                                        <td>{{$package->discount}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    @if(isset($package->services) && !empty($package->services) && count($package->services) > 0)
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Services</h1>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                @foreach($package->services as $service)
                <div class="col-3">
                    <div class="card">
                        <div class="card-body">
                            <table class="table table-bordered table-striped">
                                <tbody>
                                    <tr>
                                        <td>{{ucfirst($service->service_name)}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                @endforeach
            </div>
        </div>
    </section>
    @endif
</div>
@endsection