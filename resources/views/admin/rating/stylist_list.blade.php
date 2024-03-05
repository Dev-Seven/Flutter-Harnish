@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Stylist Ratings</h1>
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
                            <h3 class="card-title">Stylist Ratings</h3>
                        </div>
                        <div class="card-body">
                            <table id="rate_list_table" style="width: 100%;" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>Sr. No.</th>
                                        <th>Salon Name</th>
                                        <th>Stylist Name</th>
                                        <th>Customer Phone</th>
                                        <th>Message</th>
                                        <th>Rate</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @if(!empty($ratings) && count($ratings) > 0)
                                        @foreach($ratings as $key => $rate)
                                        <tr>
                                            <td>{{$key+1}}</td>
                                            @if(!empty($rate->salon))
                                            <td>{{ucfirst($rate->salon->salon_name)}}</td>
                                            @else
                                            <td>-</td>
                                            @endif
                                            @if(!empty($rate->sender))
                                            <td>{{ucfirst($rate->sender->name)}}</td>
                                            @else
                                            <td>-</td>
                                            @endif
                                            @if(!empty($rate->receiver))
                                            <td>{{$rate->receiver->phone_number}}</td>
                                            @else
                                            <td>-</td>
                                            @endif
                                            <td>{{ucfirst($rate->message)}}</td>
                                            <td>
                                                @for($i=0;$i<$rate->rating;$i++)
                                                <i class="nav-icon fa fa-star"></i>
                                                @endfor
                                            </td>
                                        </tr>
                                        @endforeach
                                    @else
                                    <tr>
                                        <td colspan="10">No Rating Found.</td>
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