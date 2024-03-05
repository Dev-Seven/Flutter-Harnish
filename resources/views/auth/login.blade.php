@extends('layouts.app_login')

@section('content')
<div class="login-box">
    @include('layouts.toastr')
    <div class="card">
        <div class="title m-b-md text-center ">
            <img src="{{asset('img/logo.png')}}" class="brand-image img-circle" style="width: 25%; height: auto; margin-top: 15px;">
        </div>
        <div class="card-body login-card-body">
            <p class="login-box-msg">Sign in to start your session</p>
            <form action="{{route('login.submit')}}" id="login_form" method="post">
                @csrf
                <div class="input-group">
                    <input type="email" name="email" class="form-control" placeholder="Email">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-envelope"></span>
                        </div>
                    </div>
                </div>
                <label id="email-error" class="error" for="email"></label>
                <div class="input-group mt-3">
                    <input type="password" class="form-control" name="password" placeholder="Password">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-lock"></span>
                        </div>
                    </div>
                </div>
                <label id="password-error" class="error" for="password"></label>
                <div class="row mt-2">
                    <div class="col-12">
                        <button type="submit" class="btn loader_class btn-primary btn-block">Sign In</button>
                    </div>
                </div>
            </form>
            <p class="mb-1 text-center">
                <a href="{{route('forgot_password')}}">Forgot Password?</a>
            </p>
        </div>
    </div>
</div>
@endsection
