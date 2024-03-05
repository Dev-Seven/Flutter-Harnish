<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Models\SalonTiming;
use App\Models\Appointment;
use App\Models\Salon;
use App\Models\User;
use Carbon\Carbon;
use Validator;
use JWTAuth;
use Response;

class GraphController extends Controller
{
	public function __construct()
	{
		$this->middleware('jwt.auth');
	}

	public function index(Request $request){

		$inputData = $request->all();

		$header = $request->header('AuthorizationUser');
		$user_token = $request->header('authorization');

		if(empty($header))
		{
			$message = 'Authorisation required' ;
			return InvalidResponse($message,101);
		}

		$response = veriftyAPITokenData($header);
		$success = $response->original['success'];

		if (!$success) {
			return $response;
		}

		$validator = Validator::make($request->all(), [
			'type' => 'required',
		]);

		if ($validator->fails()) 
		{
			$message = $validator->messages()->first();
			return InvalidResponse($message,101);
		}

		$type = $request->type;
		// 3 types of graph will display for daily, weekly and 6 monthly graph

		$jwt_user = JWTAuth::parseToken()->authenticate($user_token);
		$user_id = $jwt_user->_id;
		$user = User::where('_id',$user_id)->first();

		$salonDetail = Salon::where('user_id',$user_id)->first();
		if(!empty($salonDetail))
		{
			$todayDate = date('Y-m-d',strtotime('now'));
			$todayDateTime = date('Y-m-d h:i:s',strtotime('now'));

			$responseArr = [];
			if($type == 'daily')
			{
				$fullDayName = date('l');
				$fullDayName = strtolower($fullDayName);

				$SalonTiming = SalonTiming::where('salon_id',$salonDetail->_id);
				$SalonTiming = $SalonTiming->where('week_day',$fullDayName);
				$SalonTiming = $SalonTiming->first();

				if($SalonTiming->status == "open")
				{
					$exp_start_time = explode(":",$SalonTiming->opening_time);
		            $exp_end_time = explode(":",$SalonTiming->closing_time);

		            $startTime = $exp_start_time[0];
		            $endTime = $exp_end_time[0];

		            $timeArr = [];
		            $timeDataArr = [];
		            foreach (range($startTime, $endTime) as $i => $number) 
		            {
		                $timeArr[$i] = $number.":00:00";
		                $timeDataArr[$i] = $number.":00";
		            }

		            foreach($timeArr as $key => $value)
		            {
		            	$appointments = Appointment::where('salon_id',$salonDetail->_id);
		            	$appointments = $appointments->where('time',$value);
		            	$appointments = $appointments->where('status',APPOINTMENT_COMPLETE);
		            	$appointments = $appointments->count();

						$responseArr[$key]['value'] = $timeDataArr[$key];
						$responseArr[$key]['key'] = $appointments;
		            }
				} 
				else 
				{
					$responseArr = [];
				}
			}

			if($type == 'weekly')
			{
				$beforeSevenDays = date('Y-m-d h:i:s',strtotime('-7 days'));
				$dates = $this->date_range($beforeSevenDays,$todayDate, "+1 day", "Y-m-d");
				if(!empty($dates) && count($dates) > 0)
				{
					foreach($dates as $key => $date)
					{
						$from_date = $this->getDBTime($date." 00:00:00");
		            	$to_date = $this->getDBTime($date." 23:59:59");

						$appointments = Appointment::where('salon_id',$salonDetail->_id);
						$appointments = $appointments->whereBetween('created_at',[$from_date,$to_date]);
						$appointments = $appointments->where('status',APPOINTMENT_COMPLETE);
						$appointments = $appointments->count();

						$responseArr[$key]['value'] = $date;
						$responseArr[$key]['key'] = $appointments;
					}
				}
			}

			if($type == 'monthly')
			{
				for ($i = 0; $i <= 6; $i++) 
				{
					$monthValue = date('d-m-Y', strtotime("-$i month"));
					$firstDate = date('Y-m-01', strtotime($monthValue));
					$lastDate = date('Y-m-t', strtotime($monthValue));

					$from_date = $this->getDBTime($firstDate." 00:00:00");
		            $to_date = $this->getDBTime($lastDate." 23:59:59");

		            $appointments = Appointment::where('salon_id',$salonDetail->_id);
		            $appointments = $appointments->whereBetween('created_at',[$from_date,$to_date]);
		            $appointments = $appointments->where('status',APPOINTMENT_COMPLETE);
		            $appointments = $appointments->count();

					$monthName = date('F-Y', strtotime("-$i month"));
					$responseArr[$i]['value'] = $monthName;
					$responseArr[$i]['key'] = $appointments;
				}
			}

			$message = 'Salon graph details';
        	return SuccessResponse($message,200,$responseArr);
		} 
		else 
		{
			$message = "Salon Detail not found";
			return InvalidResponse($message,101);
		}
	}

	public function date_range($first, $last, $step = '+1 day', $output_format = 'd/m/Y' ) 
	{
        $dates = array();
        $current = strtotime($first);
        $last = strtotime($last);

        while( $current <= $last ) 
        {
            $dates[] = date($output_format, $current);
            $current = strtotime($step, $current);
        }
        return $dates;
    }

    public function getDBTime($value)
    {
        $value1 = date('Y-m-d H:i:s',strtotime($value));
        $date1 = localToUtc($value1);
        $date2 = Carbon::createFromFormat('Y-m-d H:i:s', $date1);
        return $date2;
    }
}
