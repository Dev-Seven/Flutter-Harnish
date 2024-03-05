<?php

namespace App\Http\Controllers\Api\Client;

use Tymon\JWTAuth\Exceptions\JWTException;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Models\User;
use App\Models\Appointment;
use App\Models\AppointmentService;
use App\Models\SalonService;
use App\Models\SalonPackage;
use App\Models\SalonTiming;
use App\Models\Salon;
use Validator;
use JWTAuth;
use Response;
use JWTFactory;
use App\Models\UserDeviceToken;

class AppointmentController extends Controller
{
    public function __construct()
    {
        $this->middleware('jwt.auth');
    }

    public function bookAppointment(Request $request)
    {
        $inputData = $request->all();

        $header = $request->header('AuthorizationUser');
        $user_token = $request->header('authorization');

        if(empty($header))
        {
            $message = 'Authorisation required';
            return InvalidResponse($message,101);
        }

        $response = veriftyAPITokenData($header);
        $success = $response->original['success'];
        
        if (!$success) 
        {
            return $response;
        }

        $validator = Validator::make($request->all(), [
            'salon_id' => 'required',
            'time' => 'required',
            'date' => 'required',
            'employee_id' => 'required',
            'payment_id' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $salon_id = $request->salon_id;
        $user_id = $jwt_user->_id;

        $requested_date = date('Y-m-d',strtotime($request->date));

        $dayName = date('l',strtotime($request->date));
        $dayName = strtolower($dayName);

        $checkTime = SalonTiming::where('week_day',$dayName);
        $checkTime = $checkTime->where('status','open');
        $checkTime = $checkTime->where('salon_id',$salon_id);
        $checkTime = $checkTime->first();

        if(!empty($checkTime))
        {
            $exp_start_time = explode(":",$checkTime->opening_time);
            $exp_end_time = explode(":",$checkTime->closing_time);

            $startTime = $exp_start_time[0];
            $endTime = $exp_end_time[0];

            $timeArr = [];
            foreach (range($startTime, $endTime) as $i => $number) 
            {
                $timeArr[$i] = $number.":00";
            }

            if(!in_array($request->time, $timeArr))
            {
                $message = 'Salon has been closed on selected date and time';
                return InvalidResponse($message,101);
            }

            $date_time = date('Y-m-d',strtotime($request->date))." ".date('H:i:s',strtotime($request->time));
            $date_time = date('Y-m-d H:i:s',strtotime($date_time));

            $checkStylistAvailability = Appointment::where('employee_id',$request->employee_id)->where('date_time',$date_time)->count();

            if($checkStylistAvailability > 0)
            {
                $message = 'Stylist already appointed for selected date and time';
                return InvalidResponse($message,101);
            }

            $createAppointment = new Appointment;
            $createAppointment->salon_id = $salon_id;
            $createAppointment->employee_id = $request->employee_id;
            $createAppointment->user_id = $user_id;
            $createAppointment->time = date('H:i:s',strtotime($request->time));
            $createAppointment->date = $requested_date;
            $createAppointment->date_time = $date_time;
            $createAppointment->notification_ten_minutes = 0;
            $createAppointment->notification_an_hour = 0;
            $createAppointment->date_time = $date_time;
            $createAppointment->status = APPOINTMENT_CREATE;
            $createAppointment->payment_id = $request->payment_id;
            $createAppointment->save();

            // add services in appointment detail services tables
            if(isset($request->services) && count($request->services) > 0)
            {
                // $services = explode(',', $request->services);
                // if(!empty($services) && count($services) > 0)
                // {
                foreach($request->services as $key => $service)
                {
                    $service_detail = SalonService::where('_id',$service)->first();

                    $addService = new AppointmentService;
                    $addService->appointment_id = $createAppointment->_id;
                    $addService->data_id = $service;
                    $addService->price = $service_detail->service_price;
                    $addService->name = $service_detail->service_name;
                    $addService->salon_id = $salon_id;
                    $addService->user_id = $user_id;
                    $addService->employee_id = $request->employee_id;
                    $addService->type = 'service';
                    $addService->save();
                }
                // }
            }

            // add package detail in appointment details 
            if(isset($request->package) && $request->package != '')
            {    
                $package_detail = SalonPackage::where('_id',$request->package)->first();

                $addPackage = new AppointmentService;
                $addPackage->appointment_id = $createAppointment->_id;
                $addPackage->data_id = $request->package;
                $addPackage->price = $package_detail->price;
                $addPackage->name = $package_detail->name;
                $addPackage->salon_id = $salon_id;
                $addPackage->user_id = $user_id;
                $addPackage->employee_id = $request->employee_id;
                $addPackage->type = 'package';
                $addPackage->save();
            }

            $appointment_id = $createAppointment->_id;
            // add revenue to salon and stylist data
            $data = Appointment::with(['appointmentServices'])->where('_id',$appointment_id)->first();

            $salon = Salon::where('_id',$salon_id)->first();

            $admin_commission_price = 0;
            if(!empty($data['appointmentServices']))
            {
                foreach($data['appointmentServices'] as $service)
                {
                    $admin_commission_price += $service['price'];
                }
            }

            // admin commission added in appointment table
            $acp = ((float) $admin_commission_price * (float)$salon->commission) / 100;

            $data->admin_commission = $acp;
            $data->save();

            // salon revenue added 
            $new_revenue = $salon->total_revenue + $admin_commission_price;
            $salon->total_revenue = numberFormat($new_revenue);
            $salon->save();

            // stylist revenue added 
            $stylistRevenue = User::where('_id',$request->employee_id)->first();
            $new_revenue_stylist = $stylistRevenue->total_revenue + $admin_commission_price;
            $stylistRevenue->total_revenue = numberFormat($new_revenue_stylist);
            $stylistRevenue->save(); 

            // send push notification code start
            $push_title = 'New Appointment Booked';
            $push_message = ucfirst($jwt_user->name).' is booked new Appointment for '.ucfirst($stylistRevenue->name);
            $push_data = ['appointment_id' => $createAppointment->_id];

            $salonOwnerId = $salon->user_id;
            $employee_id = $stylistRevenue->_id;

            $userArr = [$salonOwnerId, $employee_id];
            foreach($userArr as $k => $v)
            {
                $tokenData = UserDeviceToken::where('user_id',$v)->first();
                if(!empty($tokenData))
                {
                    $push_token = $tokenData->token;
                    sendPushNotification($push_title,$push_message,$push_token,$push_data);
                }
            }
            // send push notification code end
            $message = 'Appointment Added Successfully.';
            return SuccessResponse($message,200,[]);
        } 
        else 
        {
            $message = 'Salon has been closed on selected date and time';
            return InvalidResponse($message,101);
        }
    }

    public function appointmentList(Request $request)
    {
        $inputData = $request->all();

        $header = $request->header('AuthorizationUser');
        $user_token = $request->header('authorization');

        if(empty($header))
        {
            $message = 'Authorisation required';
            return InvalidResponse($message,101);
        }

        $response = veriftyAPITokenData($header);
        $success = $response->original['success'];
        
        if (!$success) 
        {
            return $response;
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $user_id = $jwt_user->_id;

        $appointments = Appointment::with(['salon','appointmentServices']);
        $appointments = $appointments->where('user_id',$user_id)->get();

        $message = 'Appointment Listing.';
        return SuccessResponse($message,200,$appointments);
    }

    public function appointmentDetail(Request $request)
    {
        $inputData = $request->all();

        $header = $request->header('AuthorizationUser');
        $user_token = $request->header('authorization');

        if(empty($header))
        {
            $message = 'Authorisation required';
            return InvalidResponse($message,101);
        }

        $response = veriftyAPITokenData($header);
        $success = $response->original['success'];
        
        if (!$success) {
            return $response;
        }

        $validator = Validator::make($request->all(), [
            'appointment_id' => 'required'
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $appointment_id = $request->appointment_id;
        $appointments = Appointment::with(['appointmentServices','salon']);
        $appointments = $appointments->where('_id',$appointment_id)->first();

        if(empty($appointments))
        {
            $message = 'Appointment not found.';
            return InvalidResponse($message,101);
        }

        $message = 'Appointment Detail.';
        return SuccessResponse($message,200,$appointments);
    }
}
