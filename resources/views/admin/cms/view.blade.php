@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>CMS Page Details</h1>
                </div>
                <div class="col-sm-6 text-right">
                    <a href="{{route('admin.cms.index')}}" class="btn btn-danger btn_loader"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back</a>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">CMS Page Details</h3>
                        </div>
                        <div class="card-body">
                            <table class="table table-bordered table-striped">
                                <tbody>
                                    <tr>
                                        <th>Title</th>
                                        <td>{{ucfirst($page->title)}}</td>
                                    </tr>
                                    <tr>
                                        <th>Slug</th>
                                        <td>{{$page->slug}}</td>
                                    </tr>
                                    <tr>
                                        <th>Short Description</th>
                                        <td>{{$page->short_description}}</td>
                                    </tr>
                                        <th>Description</th>
                                        <td>{{$page->description}}</td>
                                    <tr>
                                        <th>Status</th>
                                        <td>
                                            @if($page->status == 1)
                                            Active
                                            @else
                                            InActive
                                            @endif
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
@endsection