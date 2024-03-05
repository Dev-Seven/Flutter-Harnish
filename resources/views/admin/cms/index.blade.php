@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-10">
                    <h1>CMS Pages</h1>
                </div>
                <div class="col-sm-2 text-right">
                    <a href="{{route('admin.cms.create')}}" class="btn btn-new btn-success btn_loader"><Strong><i class="fa fa-plus"></i> New</strong></a>
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
                            <h3 class="card-title">CMS Pages</h3>
                        </div>
                        <div class="card-body">
                            <table id="cms_page_table" style="width: 100%;" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>Title</th>
                                        <th>Short Description</th>
                                        <th>Description</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @if(!empty($cms_pages) && count($cms_pages) > 0)
                                        @foreach($cms_pages as $key => $page)
                                        <tr>
                                            <td>{{ucfirst($page->title)}}</td>
                                            <td>{{$page->short_description}}</td>
                                            <td>{{substr($page->description,0,100)}}...</td>
                                            <td>
                                                @if($page->status == 1)
                                                <span style="color:green;">Active</span>
                                                @else
                                                <span style="color:red;">InActive</span>
                                                @endif
                                            </td>
                                            <td class="text-center">
                                                <a href="{{route('admin.cms.view',$page->_id)}}" class="btn icon_loader btn-sm btn-info"><i class="fa fa-eye"></i>
                                                </a>
                                                <a href="{{route('admin.cms.edit',$page->_id)}}" class="btn icon_loader btn-sm btn-primary"><i class="fa fa-pen"></i>
                                                </a>
                                                <a href="javascript:void(0)" class="btn btn-sm btn-danger delete_button" data-id="{{$page->_id}}"><i class="fa fa-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                        @endforeach
                                    @else
                                    <tr>
                                        <td colspan="10">No Page Found.</td>
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
                Are you sure to Delete CMS Page?
            </div>
            <form method="post" action="{{route('admin.cms.delete')}}">
                @csrf
                <input type="hidden" name="id" class="page_id">
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-danger btn_loader">Delete</button>
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
</script>
@endsection