@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-10">
                    <h1>Salon Service List</h1>
                </div>
                
                <div class="col-sm-2">
                    <form class="salon_form">
                    @csrf
                    <select id="single" name="salon_id" style="width: 100%;" class="form-control salon_drop custom-select">
                        <option value="">Select Salon</option>
                        @foreach($salonArray as $salon_name)
                        <?php 
                        $selected = '';
                        if(isset($_REQUEST['salon_id']) && $_REQUEST['salon_id'] == $salon_name['_id']){
                            $selected = 'selected == "selected"';
                        }
                        ?>
                        <option {{$selected}} value="{{$salon_name['_id']}}">{{ucfirst($salon_name['salon_name'])}}</option>
                        @endforeach
                      </select>
                    </form>
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
                            <h3 class="card-title">Salon Services</h3>
                        </div>
                        <div class="card-body">
                            
                            <div class="accordion" id="accordionExample">
                                <div class="card">
                                    @if(!empty($arr) && count($arr) > 0)
                                        @foreach($arr as $key => $value)
                                        <div class="card-header" id="headingOne">
                                            <h2 class="mb-0">
                                                <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapse{{$key}}" aria-expanded="false" aria-controls="collapse{{$key}}">{{ucfirst($value['salon']['salon_name'])}} ({{count($value['services'])}})</button>
                                            </h2>
                                        </div>

                                        <div id="collapse{{$key}}" class="collapse @if($key == 0) show @endif" aria-labelledby="headingOne" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <div class="row">
                                                    @if(!empty($value['services']) && count($value['services']) > 0)
                                                    @foreach($value['services'] as $k => $v)
                                                    <div class="col-md-4">
                                                        <div class="card">
                                                            <div class="card-header">
                                                                {{ucfirst($v['service_detail']['name'])}}
                                                            </div>
                                                        </div>
                                                    </div>
                                                    @endforeach
                                                    @else
                                                    <div class="col-md-12">
                                                        <div class="card">
                                                            <div class="card-header">
                                                                No Service Found.
                                                            </div>
                                                        </div>
                                                    </div>
                                                    @endif
                                                </div>
                                            </div>
                                        </div>
                                        @endforeach
                                    @endif
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<link href="{{asset('plugins/select2/css/select2.min.css')}}" rel="stylesheet" />
<script src="{{asset('plugins/jquery/jquery.min.js')}}"></script>
<script src="{{asset('plugins/select2/js/select2.min.js')}}"></script>
<script>
    var $j = jQuery.noConflict();
      $j("#single").select2({
          placeholder: "Select a Salon name",
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
</style>
@endsection
