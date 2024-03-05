<?php

namespace App\Models;

use Jenssegers\Mongodb\Eloquent\Model as Eloquent;

class SalonTiming extends Eloquent
{
	protected $connection = 'mongodb';
    protected $table = 'shalon_times';
}
