<?php

namespace App\Models;

use Jenssegers\Mongodb\Eloquent\Model as Eloquent;

class SalonService extends Eloquent
{
	protected $connection = 'mongodb';
    protected $table = 'salon_services';

    public function service_detail()
    {
    	return $this->hasOne('App\Models\Service','_id','service_id');
    }
}
