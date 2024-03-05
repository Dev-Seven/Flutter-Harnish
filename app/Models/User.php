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

class User extends Eloquent implements AuthenticatableContract, AuthorizableContract, CanResetPasswordContract, JWTSubject
{
	use Authenticatable, Authorizable, CanResetPassword, Notifiable;

	public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return [];
    }

	protected $connection = 'mongodb';

    protected $table = 'users';
    // protected $collection = 'users';

    protected $dates = array('created_at');

    public function stylistservices()
    {
        return $this->hasMany('App\Models\StylistService','stylist_id','_id');
    }

    public function user_service()
    {
        return $this->hasMany('App\Models\UserService','user_id','_id');
    }

    public function salon_detail()
    {
        return $this->hasOne('App\Models\Salon','_id','salon_id');
    }

    public function user_appointment()
    {
        return $this->hasMany('App\Models\Appointment','user_id','_id');
    }

    public function stylistAppointment()
    {
        return $this->hasMany('App\Models\Appointment','employee_id','_id');   
    }

    public function rating_review()
    {
        return $this->hasMany('App\Models\SalonRating','stylist_id','_id');   
    }

    public function city_detail()
    {
        return $this->hasOne('App\Models\City','_id','city');
    }
}
