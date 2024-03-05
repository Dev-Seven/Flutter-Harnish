<?php

namespace App\Models;

use Illuminate\Notifications\Notifiable;
use Jenssegers\Mongodb\Eloquent\Model;

class SalonVisited extends Model
{
	protected $connection = 'mongodb';
    protected $table = 'shalon_visits';

    public function stylist()
    {
    	return $this->hasOne('App\Models\User','_id','user_id');
    }

    public function salon()
    {
    	return $this->hasOne('App\Models\Salon','_id','salon_id');
    }
}
