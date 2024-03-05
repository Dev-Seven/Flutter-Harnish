<?php

namespace App\Models;

//use Jenssegers\Mongodb\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Jenssegers\Mongodb\Eloquent\Model as Eloquent;

class SalonRating extends Eloquent
{
	protected $connection = 'mongodb';
    protected $table = 'shalon_ratings';

    public function sender()
    {
    	return $this->hasOne('App\Models\User','_id','sender_id');
    }

    public function receiver()
    {
    	return $this->hasOne('App\Models\User','_id','receiver_id');
    }

    public function salon()
    {
        return $this->hasOne('App\Models\Salon','_id','salon_id');
    }
}
