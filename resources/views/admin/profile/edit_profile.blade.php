@extends('layouts.app_admin')
@section('content')
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Edit Profile</h1>
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
                            <h3 class="card-title">Edit Profile</h3>
                        </div>
                        <form action="{{route('admin.profile.update')}}" method="post" id="edit_profile" enctype="multipart/form-data">
                            @csrf
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>First Name</label>
                                            <input type="text" class="form-control" name="first_name" value="{{$user_detail->first_name}}" placeholder="First Name">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Last Name</label>
                                            <input type="text" value="{{$user_detail->last_name}}" class="form-control" name="last_name" placeholder="Last Name">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>E-mail</label>
                                            <input type="text" value="{{$user_detail->email}}" class="form-control" placeholder="E-Mail" readonly="readonly">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Phone Number</label>
                                            <input type="text" value="{{$user_detail->phone_number}}" class="form-control" name="phone_number" placeholder="Phone Number">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Profile Picture</label>
                                            <br>
                                            <input type="file" name="image" class="image" accept="image/*">
                                        </div>
                                        @if($user_detail->image != '' && file_exists(public_path('users/'.$user_detail->image)))
                                        <img id="image_preview" src="{{asset('users/'.$user_detail->image)}}" alt="Profile Picture" height="100" width="100" />
                                        @else
                                        <img id="image_preview" style="display: none;" src="#" alt="Profile Picture" height="100" width="100" />
                                        @endif
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="card-footer">
                                        <a href="{{route('admin.dashboard')}}" class="btn btn-danger btn_loader">Cancel</a>
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
<script src="{{asset('js/jquery.min.js')}}"></script>
<script type="text/javascript">
$(document).on('change','.image',function(){
    readURL(this);
});
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#image_preview').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}
</script>
@endsection