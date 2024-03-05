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

class SalonPackage extends Eloquent
{
	protected $connection = 'mongodb';
    protected $table = 'salon_packages';

    public function services()
    {
    	return $this->hasMany('App\Models\StylistPackageServices','package_id','_id');
    }

    public function salon_detail()
    {
    	return $this->hasOne('App\Models\Salon','_id','salon_id');
    }
}
