<?php

namespace App\Models;

use Jenssegers\Mongodb\Eloquent\Model as Eloquent;

class Salon extends Eloquent
{
	protected $connection = 'mongodb';
    protected $table = 'salons';
    protected $dates = array('created_at');

    public function services()
    {
        return $this->hasMany('App\Models\SalonService','salon_id','_id');
    }

    public function packages()
    {
        return $this->hasMany('App\Models\SalonPackage','salon_id','_id');
    }

    public function employee()
    {
        return $this->hasMany('App\Models\User','salon_id','_id');
    }

    public function city_Detail()
    {
        return $this->hasOne('App\Models\City','_id','city');
    }

    public function salon_images()
    {
        return $this->hasMany('App\Models\ShalonImage','user_id','user_id');
    }

    public function salon_timing()
    {
        return $this->hasMany('App\Models\SalonTiming','salon_id','_id');
    }
}
