@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-12 col-md-4">
                    <h1>Stylist List</h1>
                </div>
                <div class="col-sm-12 col-md-8">
                    <div class="row">
                        <div class="col-md-4">
                            <form id="form_salon_dropdown">
                            @csrf
                            <select id="salon" name="salon" class="form-control custom-select">
                                <option value="">Select Salon</option>
                                @if(!empty($salonList) && count($salonList) > 0)
                                    @foreach($salonList as $salon)
                                        <option @if(isset($_REQUEST['salon']) && $_REQUEST['salon'] == $salon->_id) selected="selected" @endif value="{{$salon->_id}}">{{ucfirst($salon->salon_name)}}</option>
                                    @endforeach
                                @endif
                            </select>
                            </form>
                        </div>
                        <div class="col-md-4">
                            <form id="form_location_dropdown">
                            @csrf
                            <select name="city" id="location" class="form-control custom-select">
                                <option value="">Select Location</option>
                                @if(!empty($cities) && count($cities) > 0)
                                @foreach($cities as $city)
                                <option @if(isset($_REQUEST['city']) && $_REQUEST['city'] == $city->_id) selected="selected" @endif value="{{$city->_id}}">{{ucfirst($city->name)}}</option>
                                @endforeach
                                @endif
                            </select>
                            </form>
                        </div>
                        <div class="col-md-4">
                            <form id="form_rate_dropdown">
                            @csrf
                            <select class="form-control custom-select" name="rate" id="rate">
                                <option value="">Select Rating</option>
                                <option @if(isset($_REQUEST['rate']) && $_REQUEST['rate'] == '0') selected="selected" @endif value="0">No Ratings</option>
                                <option @if(isset($_REQUEST['rate']) && $_REQUEST['rate'] == '1') selected="selected" @endif value="1">Very Poor</option>
                                <option @if(isset($_REQUEST['rate']) && $_REQUEST['rate'] == '2') selected="selected" @endif value="2">Poor</option>
                                <option @if(isset($_REQUEST['rate']) && $_REQUEST['rate'] == '3') selected="selected" @endif value="3">Good</option>
                                <option @if(isset($_REQUEST['rate']) && $_REQUEST['rate'] == '4') selected="selected" @endif value="4">Very Good</option>
                                <option @if(isset($_REQUEST['rate']) && $_REQUEST['rate'] == '5') selected="selected" @endif value="5">Excellent</option>
                            </select>
                            </form>
                        </div>
                        <!-- <div class="col-md-3 text-right">
                            <a href="{{route('admin.stylist.create')}}" class="btn btn-success btn_loader"><Strong><i class="fa fa-plus"></i> New</strong></a>
                        </div> -->
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
                            <h3 class="card-title">Stylist List</h3>
                        </div>
                        <div class="card-body">
                            <table id="stylist_table" style="width: 100%;" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>Stylist Name</th>
                                        <th>Salon Name</th>
                                        <th>Mobile Number</th>
                                        <th>Location</th>
                                        <th>Total Appointment</th>
                                        <th>Total Revenue</th>
                                        <th>Ratings</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @if(!empty($stylists) && count($stylists) > 0)
                                        @foreach($stylists as $key => $stylist)
                                        <tr>
                                            <td>{{ucfirst($stylist->name)}}</td>
                                            @if(!empty($stylist->salon_detail))
                                            <td>{{ucfirst($stylist->salon_detail->salon_name)}}</td>
                                            @else
                                            <td>-</td>
                                            @endif
                                            <td>{{$stylist->phone_number}}</td>
                                            @if(!empty($stylist->city_detail))
                                            <td>{{ucfirst($stylist->city_detail->name)}}</td>
                                            @else
                                            <td>-</td>
                                            @endif
                                            <td>{{count($stylist->stylistAppointment)}}</td>
                                            <td>₹ {{$stylist->total_revenue}}</td>
                                            <td>{{$stylist->rating}}</td>
                                            <td>
                                                @if($stylist->status == 1)
                                                <span style="color: green;">Active</span>
                                                @else
                                                <span style="color: red;">Block</span>
                                                @endif
                                            </td>
                                            <td class="text-center">
                                                <a href="{{route('admin.stylist.view',$stylist->_id)}}" class="btn icon_loader btn-sm btn-info"><i class="fa fa-eye"></i>
                                                </a>
                                                <a href="{{route('admin.stylist.edit',$stylist->_id)}}" class="btn icon_loader btn-sm btn-primary"><i class="fa fa-pen"></i>
                                                </a>
                                                @if($stylist->status == 1)
                                                    <a href="javascript:void(0)" data-text="Are you sure to Block stylist ?" data-url="{{route('admin.stylist.block')}}" class="btn btn-sm btn-danger delete_button" data-id="{{$stylist->_id}}"><i class="fa fa-ban"></i>
                                                @else
                                                    <a href="javascript:void(0)" data-text="Are you sure to Unblock stylist ?" data-url="{{route('admin.stylist.unblock')}}" class="btn btn-sm btn-success delete_button" data-id="{{$stylist->_id}}"><i class="fa fa-unlock-alt"></i>
                                                @endif
                                                </a>
                                            </td>
                                        </tr>
                                        @endforeach
                                    @else
                                    <tr>
                                        <td colspan="15">No Stylist Found.</td>
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
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-danger form_submit btn_loader">Submit</button>
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
    $(document).on('change','#location',function(){
        $('#form_location_dropdown').submit();
    });
    $(document).on('change','#salon',function(){
        $('#form_salon_dropdown').submit();
    });
    $(document).on('change','#rate',function(){
        $('#form_rate_dropdown').submit();
    });
</script>
<link href="{{asset('plugins/select2/css/select2.min.css')}}" rel="stylesheet" />
<script src="{{asset('plugins/select2/js/select2.min.js')}}"></script>
<script>
    var $j = jQuery.noConflict();
      $j("#location").select2({
          placeholder: "Select Location",
          allowClear: true
      });
      $j("#salon").select2({
          placeholder: "Select Salon",
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
    .select2-container--default .select2-selection--single .select2-selection__arrow b{
        margin-top: 3px !important;
    }
    .select2.select2-container.select2-container--default{
    width: 100%!important;
    }
</style>
@endsection