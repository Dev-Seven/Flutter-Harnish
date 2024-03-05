@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Edit CMS Page</h1>
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
                            <h3 class="card-title">Edit CMS Page</h3>
                        </div>
                        <form action="{{route('admin.cms.update')}}" method="post" id="cms_page_create">
                            @csrf
                            <input type="hidden" name="id" value="{{$page->_id}}">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Page Title</label>
                                            <input type="text" class="form-control" name="title" value="{{$page->title}}" placeholder="Enter Title">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Short Description</label>
                                            <input type="text" value="{{$page->short_description}}" class="form-control" name="short_description" placeholder="Short Description">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Description</label>
                                            <textarea name="description" class="form-control" rows="5" placeholder="Description">{{$page->description}}</textarea>
                                        </div>
                                </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Status</label>
                                            <select class="form-control custom-select" name="status">
                                                <option value="">Select Status</option>
                                                <option @if($page->status == 1) selected="selected" @endif value="1">Active</option>
                                                <option @if($page->status == 0) selected="selected" @endif value="0">InActive</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="card-footer">
                                        <a href="{{route('admin.cms.index')}}" class="btn btn-danger btn_loader">Cancel</a>
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
@endsection