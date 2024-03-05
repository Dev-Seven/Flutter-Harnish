@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Stylist Edit</h1>
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
                            <h3 class="card-title">Stylist Edit</h3>
                        </div>
                        <form action="{{route('admin.stylist.update')}}" method="post" id="stylist_create">
                            @csrf
                            <div class="card-body">
                                <div class="row">
                                    <input type="hidden" name="id" value="{{$stylist->_id}}">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>First Name</label>
                                            <input type="text" class="form-control" value="{{$stylist->first_name}}" name="first_name" placeholder="First Name">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Last Name</label>
                                            <input type="text" class="form-control" value="{{$stylist->last_name}}" name="last_name" placeholder="Last Name">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>E-Mail Address</label>
                                            <input type="text" class="form-control" value="{{$stylist->email}}" placeholder="E-Mail Address" readonly="readonly">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Mobile Number</label>
                                            <input type="text" class="form-control" value="{{$stylist->phone_number}}" name="phone_number" placeholder="Mobile Number">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Select Salon</label>
                                            <select class="form-control custom-select" name="salon_id">
                                                    <option value="">Select Salon...</option>
                                                @if(!empty($salonList) && count($salonList) > 0)
                                                    @foreach($salonList as $salon)
                                                        <option @if($salon->_id == $stylist->salon_id) selected="selected" @endif value="{{$salon->_id}}">{{ucfirst($salon->salon_name)}}</option>
                                                    @endforeach
                                                @endif
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Services</label>
                                            <select class="form-control multiple_dropdown custom-select" placeholder="Select Services" name="services[]" multiple="multiple">
                                                @if(!empty($services) && count($services) > 0)
                                                    @foreach($services as $service)
                                                        <option @if(in_array($service->_id,$serviceListArr)) selected="selected" @endif value="{{$service->_id}}">{{ucfirst($service->name)}}</option>
                                                    @endforeach
                                                @endif
                                            </select>
                                        <label id="services[]-error" class="error" for="services[]"></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <label>Location</label>
                                            <input type="text" class="form-control" value="{{$stylist->location}}" name="address" placeholder="Location">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>City</label>
                                            <select id="single" name="city" class="form-control custom-select">
                                                <option value="">Select City</option>
                                                <option @if($stylist->city == "Ahmadabad") selected="selected" @endif value="Ahmadabad">Ahmadabad</option>
                                                <option @if($stylist->city == "Surat") selected="selected" @endif value="Surat">Surat</option>
                                                <option @if($stylist->city == "Baroda") selected="selected" @endif value="Baroda">Baroda</option>
                                                <option @if($stylist->city == "Rajkot") selected="selected" @endif value="Rajkot">Rajkot</option>
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
                                                <option @if($stylist->status == 1) selected="selected" @endif value="1">Active</option>
                                                <option @if($stylist->status == 0) selected="selected" @endif value="0">Block</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="card-footer">
                                        <a href="{{route('admin.stylist.index')}}" class="btn btn-danger btn_loader">Cancel</a>
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
@endsection