<?php

namespace App\Models;

use Illuminate\Notifications\Notifiable;
use Jenssegers\Mongodb\Eloquent\Model;

class Appointment extends Model
{
	protected $connection = 'mongodb';
    protected $table = 'appointments';

    protected $dates = array('created_at');

    public function packages()
    {
    	return $this->hasOne('App\Models\AppointmentService','appointment_id','_id');
    }

    public function appointmentServices()
    {
    	return $this->hasMany('App\Models\AppointmentService','appointment_id','_id');
    }

    public function salon()
    {
        return $this->hasOne('App\Models\Salon','_id','salon_id');
    }

    public function stylist()
    {
        return $this->hasOne('App\Models\User','_id','employee_id');
    }

    public function customer()
    {
        return $this->hasOne('App\Models\User','_id','user_id');
    }
}
