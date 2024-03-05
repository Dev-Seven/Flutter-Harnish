@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Service Requests</h1>
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
                            <h3 class="card-title">Service Requests</h3>
                        </div>
                        <div class="card-body">
                            <table id="service_request_table" style="width: 100%;" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>Sr.No.</th>
                                        <th>Service Name</th>
                                        <th>Requested Stylist</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @if(!empty($requests) && count($requests) > 0)
                                        @foreach($requests as $key => $service)
                                        <tr>
                                            <td>#{{$key+1}}</td>
                                            <td>{{ucfirst($service->service_name)}}</td>
                                            @if(!empty($service->stylist))
                                            <td>{{ucfirst($service->stylist->name)}}</td>
                                            @else
                                            <td>-</td>
                                            @endif
                                            <td>
                                                @if($service->status == 1)
                                                <span style="color: orange;">Pending</span>
                                                @elseif($service->status == 2)
                                                <span style="color: green">Approved</span>
                                                @else
                                                <span style="color: red;">Canceled</span>
                                                @endif
                                            </td>
                                            <td class="text-center">
                                                @if($service->status == 1)
                                                <a href="{{route('admin.service_request.accept',$service->_id)}}" title="Approve" class="btn btn-sm btn-success"><i class="fa fa-check"></i>
                                                </a>
                                                <a href="{{route('admin.service_request.rejected',$service->_id)}}" title="Reject" class="btn btn-sm btn-danger"><i class="fa fa-window-close"></i>
                                                </a>
                                                @else
                                                <a href="javascript:void(0)" style="pointer-events: none;" class="btn btn-sm btn-default"><i class="fa fa-check"></i>
                                                </a>
                                                <a href="javascript:void(0)" style="pointer-events: none;" class="btn btn-sm btn-default"><i class="fa fa-window-close"></i>
                                                </a>
                                                @endif
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
