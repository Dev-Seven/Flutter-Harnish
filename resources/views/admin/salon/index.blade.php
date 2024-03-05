@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-12 col-md-4">
                    <h1>Salon List</h1>
                </div>
                <div class="col-sm-12 col-md-8">
                    <div class="row">
                        <div class="col-md-3">
                            <form id="form_location_dropdown">
                            @csrf
                            <select name="city" id="single" class="form-control custom-select">
                                <option value="">Select Location</option>
                                @if(!empty($cities) && count($cities) > 0)
                                @foreach($cities as $city)
                                <option @if(isset($_REQUEST['city']) && $_REQUEST['city'] == $city->_id) selected="selected" @endif value="{{$city->_id}}">{{ucfirst($city->name)}}</option>
                                @endforeach
                                @endif
                            </select>
                            </form>
                        </div>
                        <div class="col-md-3">
                            <form id="form_type_dropdown"> @csrf
                            <select class="form-control custom-select type_dropdown" name="type">
                                <option value="">Select Type</option>
                                <option @if(isset($_REQUEST['type']) && $_REQUEST['type'] == 'male') selected="selected" @endif value="male">Male</option>
                                <option @if(isset($_REQUEST['type']) && $_REQUEST['type'] == 'female') selected="selected" @endif value="female">Female</option>
                                <option @if(isset($_REQUEST['type']) && $_REQUEST['type'] == 'unisex') selected="selected" @endif value="unisex">Unisex</option>
                            </select>
                            </form>
                        </div>
                        <div class="col-md-3">
                            <form id="form_rate_dropdown">
                            @csrf
                            <select class="form-control custom-select" name="rate" id="rate">
                                <option value="">Select Rating</option>
                                <option @if(isset($_REQUEST['rate']) && $_REQUEST['rate'] == '0') selected="selected" @endif value="0" value="">No Ratings</option>
                                <option @if(isset($_REQUEST['rate']) && $_REQUEST['rate'] == '1') selected="selected" @endif value="1">Very Poor</option>
                                <option @if(isset($_REQUEST['rate']) && $_REQUEST['rate'] == '2') selected="selected" @endif value="2">Poor</option>
                                <option @if(isset($_REQUEST['rate']) && $_REQUEST['rate'] == '3') selected="selected" @endif value="3">Good</option>
                                <option @if(isset($_REQUEST['rate']) && $_REQUEST['rate'] == '4') selected="selected" @endif value="4">Very Good</option>
                                <option @if(isset($_REQUEST['rate']) && $_REQUEST['rate'] == '5') selected="selected" @endif value="5">Excellent</option>
                            </select>
                            </form>
                        </div>
                        <div class="col-md-3 text-right">
                            <a href="{{route('admin.salon.create')}}" class="btn btn-success btn_loader btn-new"><Strong><i class="fa fa-plus"></i> New</strong></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            @include('layouts.toastr')
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Salon List</h3>
                        </div>
                        <div class="card-body">
                            <div class="table-scroll">
                                <table id="salon_table" style="width: 100%;" class="table table-bordered table-striped">
                                  <thead>
                                        <tr>
                                            <th>Salon Name</th>
                                            <th>Owner Name</th>
                                            <th>Mobile Number</th>
                                            <th>City</th>
                                            <th>Salon Type</th>
                                            <th>Total Services</th>
                                            <th>Total Revenue</th>
                                            <th>Ratings</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @if(!empty($salons) && count($salons) > 0)
                                            @foreach($salons as $key => $salon)
                                            <tr>
                                                <td>{{ucfirst($salon->salon_name)}}</td>
                                                <td>{{ucfirst($salon->owner_name)}}</td>
                                                <td>{{$salon->phone_number}}</td>
                                                @if(isset($salon->city_detail) && !empty($salon->city_detail))
                                                <td>{{ucfirst($salon->city_detail->name)}}</td>
                                                @else
                                                <td>-</td>
                                                @endif
                                                <td>{{ucfirst($salon->type)}}</td>
                                                <td>{{count($salon->services)}}</td>
                                                <td>₹ {{$salon->total_revenue}}</td>
                                                <td>{{$salon->ratings}}</td>
                                                <td>
                                                    @if($salon->status == 1)
                                                    <span style="color: green;">Active</span>
                                                    @else
                                                    <span style="color: red;">Block</span>
                                                    @endif
                                                </td>
                                                <td class="text-center">
                                                    <a href="{{route('admin.salon.view',$salon->_id)}}" class="btn icon_loader btn-sm btn-info"><i class="fa fa-eye"></i>
                                                    </a>
                                                    <a href="{{route('admin.salon.edit',$salon->_id)}}" class="btn icon_loader btn-sm btn-primary"><i class="fa fa-pen"></i>
                                                    </a>
                                                    @if($salon->status == "1")
                                                        <a href="javascript:void(0)" data-text="Are you sure to Block Salon?" data-url="{{route('admin.salon.block')}}" class="btn btn-sm btn-danger delete_button" data-id="{{$salon->_id}}"><i class="fa fa-ban"></i></a>
                                                    @else
                                                        <a href="javascript:void(0)" data-text="Are you sure to Unblock Salon?" data-url="{{route('admin.salon.unblock')}}" class="btn btn-sm btn-success delete_button" data-id="{{$salon->_id}}"><i class="fa fa-unlock-alt"></i></a>
                                                    @endif
                                                </td>
                                            </tr>
                                            @endforeach
                                        @else
                                        <tr>
                                            <td colspan="10">No Salon Found.</td>
                                        </tr>
                                        @endif
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<script src="{{asset('plugins/jquery/jquery.min.js')}}"></script>
<!-- Popup modal for logout start -->
<div class="modal fade" id="deleteModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Are You sure?</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body title_modal"></div>
            <form method="post" action="" id="form_delete">
                @csrf
                <input type="hidden" name="id" class="page_id">
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                    <button type="submit" class="btn btn-danger form_submit btn_loader">Yes</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Popup modal for logout end -->
<script type="text/javascript">
    $(document).on('click','.delete_button',function(){
        $('#deleteModel').modal('show');
        $('.page_id').val($(this).attr('data-id'));
        $('#form_delete').attr('action',$(this).attr('data-url'));
        $('.title_modal').html($(this).attr('data-text'));
    })
    $(document).on('click','.form_submit',function(){
        $('#form_delete').submit();
    })
    $(document).on('change','.type_dropdown',function(){
        $('#form_type_dropdown').submit();
    });
    $(document).on('change','#single',function(){
        $('#form_location_dropdown').submit();
    });
    $(document).on('change','#rate',function(){
        $('#form_rate_dropdown').submit();
    });
</script>
<link href="{{asset('plugins/select2/css/select2.min.css')}}" rel="stylesheet" />
<script src="{{asset('plugins/select2/js/select2.min.js')}}"></script>
<script>
    var $j = jQuery.noConflict();
      $j("#single").select2({
          placeholder: "Select Location",
          allowClear: true
      });
      $j(document).on('change','.salon_drop',function(){
        $('.salon_form').submit();
      });
    </script>
<style type="text/css">
    .select2-container--default .select2-selection--single{
        padding-bottom: 28px !important;
		
    }
	
   .select2.select2-container.select2-container--default{
	width: 100%!important;
	}
    .select2-container--default .select2-selection--single .select2-selection__arrow b{
        margin-top: 3px !important;
    }
</style>
@endsection