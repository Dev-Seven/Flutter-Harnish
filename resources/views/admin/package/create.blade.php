@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Create Package</h1>
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
                            <h3 class="card-title">Create Package</h3>
                        </div>
                        <form action="{{route('admin.package.store')}}" method="post" id="package_create">
                            @csrf
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Package Name</label>
                                            <input type="text" class="form-control" name="package_name" placeholder="Package Name">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Salon Name</label>
                                            <select class="form-control custom-select" name="salon">
                                                <option value="">Select Salon</option>
                                                @if(!empty($salons) && count($salons) > 0)
                                                @foreach($salons as $salon)
                                                <option value="{{$salon->_id}}">{{ucfirst($salon->salon_name)}}</option>
                                                @endforeach
                                                @endif
                                            </select>
                                            <label id="salon-error" class="error" for="salon"></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Price (₹)</label>
                                            <input type="text" class="form-control" name="price" placeholder="Price">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Discount (%)</label>
                                            <input type="text" class="form-control" name="discount" placeholder="Discount">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Services</label>
                                            <select class="form-control custom-select" id="services" multiple="multiple" name="services[]">
                                                <option value="">Select Services</option>
                                                @if(!empty($services) && count($services) > 0)
                                                @foreach($services as $service)
                                                <option value="{{$service->_id}}">{{ucfirst($service->name)}}</option>
                                                @endforeach
                                                @endif
                                            </select>
                                            <label id="services-error" class="error" for="services"></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="card-footer">
                                        <a href="{{route('admin.package.index')}}" class="btn btn-danger btn_loader">Cancel</a>
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
<script src="{{asset('plugins/jquery/jquery.min.js')}}"></script>
<link href="{{asset('plugins/select2/css/select2.min.css')}}" rel="stylesheet" />
<script src="{{asset('plugins/select2/js/select2.min.js')}}"></script>
<script>
    var $j = jQuery.noConflict();
    $j("#services").select2({
        placeholder: "Select Services",
        allowClear: true
    });
</script>
<style type="text/css">
.select2-container--default .select2-selection--single{ padding-bottom: 28px !important; }.select2-container--default .select2-selection--single .select2-selection__arrow b{ margin-top: 3px !important;}.select2.select2-container.select2-container--default{ width: 100%!important;}.select2-container--default .select2-selection--multiple .select2-selection__choice{
        background-color: #007bff; border: 1px solid #007bff; }.select2-container--default .select2-selection--multiple .select2-selection__choice__remove{
        color: #fff;}.select2-container--default .select2-selection--multiple:before {content: ' '; display: block; position: absolute; border-color: #888 transparent transparent transparent; border-style: solid; border-width: 5px 4px 0 4px; height: 0; right: 6px;margin-left: -4px; margin-top: -2px;top: 50%; width: 0;cursor: pointer }.select2-container--open .select2-selection--multiple:before {content: ' ';display: block;position: absolute;border-color: transparent transparent #888 transparent;border-width: 0 4px 5px 4px;height: 0;right: 6px;margin-left: -4px;margin-top: -2px;top: 50%;width: 0;cursor: pointer}
</style>
@endsection