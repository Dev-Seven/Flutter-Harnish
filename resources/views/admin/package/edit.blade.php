@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Salon Edit</h1>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="card card-default">
                        <div class="card-header">
                            <h3 class="card-title">Salon Edit</h3>
                        </div>
                        <form action="{{route('admin.salon.update')}}" method="post" id="salon_create">
                            @csrf
                            <input type="hidden" name="id" value="{{$salon->_id}}">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Name</label>
                                            <input type="text" class="form-control" name="salon_name" value="{{$salon->salon_name}}" placeholder="Name">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Owner Name</label>
                                            <input type="text" value="{{$salon->owner_name}}" class="form-control" name="owner_name" placeholder="Owner Name">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>E-Mail Address</label>
                                            <input type="text" class="form-control" value="{{$salon->email}}" placeholder="E-Mail Address" readonly="readonly">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label>Mobile Number</label>
                                            <input type="text" value="{{$salon->phone_number}}" class="form-control" name="phone_number" placeholder="Mobile Number">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label>Commission(%)</label>
                                            <input type="text" value="{{$salon->commission}}" class="form-control" name="commission" placeholder="Commission(%)">
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-group">
                                            <label>Type</label>
                                            <select class="form-control custom-select" name="type">
                                                <option value="">Select Type</option>
                                                <option @if($salon->type == "male") selected="selected" @endif value="male">Male</option>
                                                <option @if($salon->type == "female") selected="selected" @endif value="female">Female</option>
                                                <option @if($salon->type == "unisex") selected="selected" @endif value="unisex">Unisex</option>
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <!-- <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Total Revenue</label>
                                            <input type="text" value="{{$salon->total_revenue}}" class="form-control" name="total_revenue" placeholder="Total Revenue">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Ratings</label>
                                            <select class="form-control custom-select" name="ratings">
                                                <option value="">Select Ratings</option>
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                            </select>
                                        </div>
                                    </div> -->
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Services</label>
                                            <select class="form-control multiple_dropdown custom-select" multiple="multiple" disabled="disabled">
                                                @if(!empty($services) && count($services) > 0)
                                                    @foreach($services as $service)
                                                        <option @if(in_array($service->_id,$service_ids)) selected="selected" @endif value="{{$service->_id}}">{{ucfirst($service->name)}}</option>
                                                    @endforeach
                                                @endif
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <label>Address</label>
                                            <input type="text" class="form-control" value="{{$salon->address}}" name="address" placeholder="Address">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>City</label>
                                            <select id="single" name="city" class="form-control custom-select">
                                                <option value="">Select City</option>
                                                @if(!empty($cities) && count($cities) > 0)
                                                    @foreach($cities as $city)
                                                    <option @if($salon->city == $city->_id) selected="selected" @endif value="{{$city->_id}}">{{ucfirst($city->name)}}</option>
                                                    @endforeach
                                                @endif
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Status</label>
                                            <select class="form-control custom-select" name="status">
                                                <option value="">Select Status</option>
                                                <option @if($salon->status == 1) selected="selected" @endif value="1">Active</option>
                                                <option @if($salon->status == 0) selected="selected" @endif value="0">Block</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="card-footer">
                                        <a href="{{route('admin.salon.index')}}" class="btn btn-danger btn_loader">Cancel</a>
                                        <button type="submit" class="btn btn-primary loader_class">Submit</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<link rel="stylesheet" href="{{asset('js/choices.min.css')}}">
<style type="text/css">
    .choices{
        margin-bottom: 0px !important;
    }
</style>
<script src="{{asset('js/choices.min.js')}}"></script>
<script type="text/javascript" src="{{asset('js/jquery.min.js')}}"></script>
<script type="text/javascript">
$(document).ready(function(){
    var multipleCancelButton = new Choices('.multiple_dropdown', {
        removeItemButton: true,
        maxItemCount:10,
        searchResultLimit:10,
        renderChoiceLimit:10,
        placeholder: true,
        placeholderValue: '',
        searchPlaceholderValue: null,
        prependValue: false,
        appendValue: false,
        selectAll: true,
    });
 });
</script>
<!-- <style type="text/css">
    .choices{
        margin-bottom: 0px !important;
    }
</style> -->
@endsection