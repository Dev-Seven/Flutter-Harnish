<?php

namespace App\Models;

use Jenssegers\Mongodb\Eloquent\Model as Eloquent;

class ServiceRequest extends Eloquent
{
	protected $connection = 'mongodb';
    protected $table = 'service_requests';

    public function stylist()
    {
    	return $this->hasOne('App\Models\User','_id','stylist_id');
    }
}
