@extends('layouts.app_login')

@section('content')
<div class="login-box">
    @include('layouts.toastr')
    <div class="card">
        <div class="title m-b-md text-center ">
            <img src="{{asset('img/logo.png')}}" class="brand-image img-circle" style="width: 25%; height: auto; margin-top: 15px;">
        </div>
        <div class="card-body login-card-body">
            <p class="login-box-msg">You forgot your password? Here you can easily retrieve a new password.</p>
            <form action="{{route('forgot_password.submit')}}" method="post" id="forgot_password_form">
                @csrf
                <div class="input-group mb-2">
                    <input type="email" name="email" value="{{old('email')}}" class="form-control" placeholder="Email">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-envelope"></span>
                        </div>
                    </div>
                </div>
                <label id="email-error" class="error" for="email"></label>
                <div class="row">
                    <div class="col-12">
                        <button type="submit" class="btn loader_class btn-primary btn-block">Request new password</button>
                    </div>
                </div>
            </form>
            <p class="mt-3 mb-1 text-center">
            <a href="{{route('login')}}">Sign In</a>
            </p>
        </div>
    </div>
</div>
@endsection
