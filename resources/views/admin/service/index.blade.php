@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-10">
                    <h1>Service Master</h1>
                </div>
                <div class="col-sm-2 text-right">
                    <a href="{{route('admin.service.create')}}" class="btn btn-new btn-success btn_loader"><Strong><i class="fa fa-plus"></i> New</strong></a>
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
                            <h3 class="card-title">Services</h3>
                        </div>
                        <div class="card-body">
                            <table id="service_table" style="width: 100%;" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>Sr.No.</th>
                                        <th>Service Name</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @if(!empty($services) && count($services) > 0)
                                        @foreach($services as $key => $service)
                                        <tr>
                                            <td>#{{$key+1}}</td>
                                            <td>{{ucfirst($service->name)}}</td>
                                            <td>
                                                @if($service->status == 1)
                                                <span style="color:green;">Active</span>
                                                @else
                                                <span style="color:red;">InActive</span>
                                                @endif
                                            </td>
                                            <td class="text-center">
                                                <a href="{{route('admin.service.edit',$service->_id)}}" class="btn icon_loader btn-sm btn-primary"><i class="fa fa-pen"></i>
                                                </a>
                                                <a href="javascript:void(0)" class="btn btn-sm btn-danger delete_button" data-id="{{$service->_id}}"><i class="fa fa-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                        @endforeach
                                    @else
                                    <tr>
                                        <td colspan="10">No Service Found.</td>
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
            <div class="modal-body">
                Are you sure to Delete Service?
            </div>
            <form method="post" action="{{route('admin.service.delete')}}" id="form_delete">
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
    })
    $(document).on('click','.form_submit',function(){
        $('#form_delete').submit();
    })
</script>
@endsection