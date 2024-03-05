@extends('layouts.app_login')

@section('content')
<div class="login-box">
    <div class="card">
        <div class="title m-b-md text-center ">
            <img src="{{asset('img/logo.png')}}" class="brand-image img-circle" style="width: 25%; height: auto; margin-top: 15px;">
        </div>
        <div class="card-body login-card-body">
            <p class="login-box-msg">You are only one step a way from your new password, recover your password now.</p>
            <form action="{{route('password.submit')}}" method="post" id="reset_password_form">
                @csrf
                <div class="input-group mb-3">
                    <input type="text" class="form-control" value="{{$user->email}}" placeholder="E-mail" readonly="readonly">
                    <input type="hidden" name="user_id" value="{{$user->_id}}">
                    <input type="hidden" name="email" value="{{$user->email}}">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-envelope"></span>
                        </div>
                    </div>
                </div>
                <div class="input-group mb-2">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-lock"></span>
                        </div>
                    </div>
                </div>
                <label id="password-error" class="error" for="password"></label>
                <div class="input-group mb-2">
                    <input type="password" class="form-control" name="confirm_password" placeholder="Confirm Password">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-lock"></span>
                        </div>
                    </div>
                </div>
                <label id="confirm_password-error" class="error" for="confirm_password"></label>
                <div class="row">
                    <div class="col-12">
                        <button type="submit" class="btn btn-primary btn-block">Change password</button>
                    </div>
                </div>
            </form>
            <p class="mt-3 mb-1 text-center">
                <a href="{{route('login')}}">Login</a>
            </p>
        </div>
    </div>
</div>
@endsection
