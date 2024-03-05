<?php

namespace App\Models;

use Jenssegers\Mongodb\Eloquent\Model as Eloquent;

class UserService extends Eloquent
{
	protected $connection = 'mongodb';
    protected $table = 'user_services';

    public function service_detail()
    {
    	return $this->hasOne('App\Models\Service','_id','service_id');
    }
}
