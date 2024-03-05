@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-12 col-md-8">
                    <h1>Package List</h1>
                </div>
                <div class="col-sm-12 col-md-4">
                    <div class="row">
                        <div class="col-md-6"></div>
                        <div class="col-md-6 text-right">
                            <a href="{{route('admin.package.create')}}" class="btn btn-success btn_loader btn-new"><Strong><i class="fa fa-plus"></i> New</strong></a>
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
                            <h3 class="card-title">Package List</h3>
                        </div>
                        <div class="card-body">
                            <table id="package_table" style="width: 100%;" class="table table-bordered table-striped">
                              <thead>
                                    <tr>
                                        <th>Sr. No.</th>
                                        <th>Salon Name</th>
                                        <th>Package Name</th>
                                        <th>Price (₹)</th>
                                        <th>Discount (%)</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @if(!empty($packages) && count($packages) > 0)
                                        @foreach($packages as $key => $package)
                                        <tr>
                                            <td>#{{$key+1}}</td>
                                            @if(!empty($package->salon_detail))
                                            <td>{{ucfirst($package->salon_detail->salon_name)}}</td>
                                            @else
                                            <td>-</td>
                                            @endif
                                            <td>{{ucfirst($package->name)}}</td>
                                            <td>{{$package->price}}</td>
                                            <td>{{$package->discount}}</td>
                                            <td class="text-center">
                                                <a href="{{route('admin.package.view',$package->_id)}}" class="btn icon_loader btn-sm btn-info"><i class="fa fa-eye"></i>
                                                </a>
                                                <a href="javascript:void(0)" data-id="{{$package->_id}}" class="btn delete_button  btn-sm btn-danger"><i class="fa fa-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                        @endforeach
                                    @else
                                    <tr>
                                        <td colspan="15">No Package Found.</td>
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
            <div class="modal-body"> Are you sure to delete Package?</div>
            <form method="post" action="{{route('admin.package.delete')}}" id="form_delete">
                @csrf
                <input type="hidden" name="id" class="page_id">
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-danger form_submit btn_loader">Delete</button>
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
    
</script>
@endsection