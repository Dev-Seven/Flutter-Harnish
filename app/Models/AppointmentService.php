<?php

namespace App\Models;

use Illuminate\Notifications\Notifiable;
use Jenssegers\Mongodb\Eloquent\Model;

class AppointmentService extends Model
{
	protected $connection = 'mongodb';
    protected $table = 'appointment_services';
}
