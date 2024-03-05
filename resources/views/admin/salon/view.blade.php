@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Salon Details</h1>
                </div>
                <div class="col-sm-6 text-right">
                    <a href="{{route('admin.salon.index')}}" class="btn btn-danger btn_loader"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back</a>
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
                            <table class="table table-bordered table-striped">
                                <tbody>
                                    <tr>
                                        <th>Salon Name</th>
                                        <td>{{ucfirst($salon->salon_name)}}</td>
                                    </tr>
                                    <tr>
                                        <th>Owner Name</th>
                                        <td>{{ucfirst($salon->owner_name)}}</td>
                                    </tr>
                                    <tr>
                                        <th>Salon Type</th>
                                        <td>{{ucfirst($salon->type)}}</td>
                                    </tr>
                                    @if($salon->commission != "")
                                    <tr>
                                        <th>Commission</th>
                                        <td>{{$salon->commission}}% </td>
                                    </tr>
                                    @endif
                                    <tr>
                                        <th>Mobile Number</th>
                                        <td>{{$salon->phone_number}}</td>
                                    </tr>
                                    <tr>
                                        <th>E-Mail</th>
                                        <td>{{$salon->email}}</td>
                                    </tr>
                                    <tr>
                                        <th>Address</th>
                                        <td>{{$salon->address}}</td>
                                    </tr>
                                    <tr>
                                        <th>City</th>
                                        @if(isset($salon->city_detail) && !empty($salon->city_detail))
                                        <td>{{ucfirst($salon->city_detail->name)}}</td>
                                        @else
                                        <td>-</td>
                                        @endif
                                    </tr>
                                    <tr>
                                        <th>Total Revenue (₹)</th>
                                        <td>{{$salon->total_revenue}}</td>
                                    </tr>
                                    <tr>
                                        <th>Ratings (Average)</th>
                                        <td>{{$salon->ratings}}</td>
                                    </tr>
                                    <tr>
                                        <th>Status</th>
                                        <td>
                                            @if($salon->status == 1)
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
    @if(isset($salon->services) && !empty($salon->services) && count($salon->services) > 0)
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Services</h1>
                </div>
            </div>
        </div>
    </section>
    @endif
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                @if(isset($salon->services) && !empty($salon->services) && count($salon->services) > 0)
                    @foreach($salon->services as $service)
                    <div class="col-3">
                        <div class="card">
                            <div class="card-body">
                                <table class="table table-bordered table-striped">
                                    <tbody>
                                        <tr>
                                            <td>{{ucfirst($service->service_detail->name)}}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    @endforeach
                @endif
            </div>
        </div>
    </section>

    @if(isset($salon->salon_images) && !empty($salon->salon_images) && count($salon->salon_images) > 0)
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Salon Images</h1>
                </div>
            </div>
        </div>
    </section>
    @endif
    <section class="content mb-5">
        <div class="container-fluid">
            <div class="row">
                @if(isset($salon->salon_images) && !empty($salon->salon_images) && count($salon->salon_images) > 0)
                    @foreach($salon->salon_images as $image)
                    <div class="col-2">
                        @if($image->name != '' && file_exists(public_path('salon_image/'.$image->name)))
                        <img src="{{asset('salon_image/'.$image->name)}}" title="{{$image->name}}" style="width: 100%; height: 250px;">
                        @endif
                    </div>
                    @endforeach
                @endif
            </div>
        </div>
    </section>
</div>
@endsection