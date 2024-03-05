<?php

namespace App\Models;

//use Jenssegers\Mongodb\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Illuminate\Auth\Authenticatable;
use Illuminate\Auth\Passwords\CanResetPassword;
use Illuminate\Foundation\Auth\Access\Authorizable;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;
use Illuminate\Contracts\Auth\CanResetPassword as CanResetPasswordContract;
use Jenssegers\Mongodb\Eloquent\Model as Eloquent;
use Tymon\JWTAuth\Contracts\JWTSubject;

class SalonShop extends Eloquent
{
	protected $connection = 'mongodb';
    protected $table = 'shalon_shops';

    public function stylist()
    {
    	return $this->hasOne('App\Models\User','_id','user_id');
    }

    public function packages()
    {
    	return $this->hasMany('App\Models\StylistPackage','user_id','user_id');
    }

    public function services()
    {
    	return $this->hasMany('App\Models\StylistService','user_id','user_id');
    }
}
