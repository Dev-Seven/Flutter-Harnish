<?php

namespace App\Http\Controllers\Api\Stylist;

use Tymon\JWTAuth\Exceptions\JWTException;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Models\User;
use App\Models\Appointment;
use App\Models\Salon;
use App\Models\AppointmentAcceptance;
use App\Models\UserDeviceToken;
use Validator;
use JWTAuth;
use Response;
use JWTFactory;

class AppointmentController extends Controller
{
    public function __construct()
    {
        $this->middleware('jwt.auth');
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

        $appointmentList = Appointment::with(['salon','stylist','appointmentServices','customer']);

        if($jwt_user->role == SALON_ROLE)
        {
            $salonDetail = Salon::where('user_id',$user_id)->first();
            if(!empty($salonDetail))
            {
                $salon_id = $salonDetail->_id;
                $appointmentList = $appointmentList->where('salon_id',$salon_id);
            }
        } 
        else 
        {
            $appointmentList = $appointmentList->where('employee_id',$user_id);
        }

        $status_ = (int) $request->status;
        if ($status_ == 1) 
        {
            $status = APPOINTMENT_CREATE;
            $appointmentList = $appointmentList->where('status',$status);
        } 
        elseif ($status_ == 2) 
        {
            $status = APPOINTMENT_ACCEPT;
            $appointmentList = $appointmentList->where('status',$status);
        } 
        elseif ($status_ == 3) 
        {
            $status = APPOINTMENT_INPROGRESS;
            $appointmentList = $appointmentList->where('status',$status);
        } 
        elseif ($status_ == 4) 
        {
            $status = APPOINTMENT_COMPLETE;
            $appointmentList = $appointmentList->where('status',$status);
        } 
        elseif ($status_ == 5) 
        {
            $status = APPOINTMENT_CANCEL;
            $appointmentList = $appointmentList->where('status',$status);
        }

        $appointmentList = $appointmentList->orderBy('id','DESC')->get();
        if(count($appointmentList) == 0)
        {
            $message = 'No Appointment Found.';
            return SuccessResponse($message,200,[]);
        }
        $message = 'Appointment Listing.';
        return SuccessResponse($message,200,$appointmentList);
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
        
        if (!$success) 
        {
            return $response;
        }

        $validator = Validator::make($request->all(), [
            'appointment_id' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);

        $appointment_id = $request->appointment_id;
        $user_id = $jwt_user->_id;

        $appointmentDetail = Appointment::with(['appointmentServices','customer']);
        $appointmentDetail = $appointmentDetail->where('_id',$appointment_id)->first();

        if(empty($appointmentDetail))
        {
            $message = 'No Appointment Found.';
            return SuccessResponse($message,200,[]);
        }
        $message = 'Appointment Detail.';
        return SuccessResponse($message,200,$appointmentDetail);
    }

    public function appointmentStatusChange(Request $request)
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
            'salon_id' => 'required',
            'appointment_id' => 'required',
            'status' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);

        $salon_id = $request->salon_id;
        $user_id = $jwt_user->_id;
        $appointment_id = $request->appointment_id;

        $status = APPOINTMENT_ACCEPT;
        if ($request->status == 2) 
        {
            $status = APPOINTMENT_INPROGRESS;
        } 
        elseif ($request->status == 3) 
        {
            $status = APPOINTMENT_COMPLETE;
        } 
        elseif ($request->status == 4) 
        {
            $status = APPOINTMENT_CANCEL;
        }

        $Appointment = new AppointmentAcceptance;
        $Appointment->appointment_id = $appointment_id;
        $Appointment->salon_id = $salon_id;
        $Appointment->user_id = $user_id;
        $Appointment->status = $status;
        $Appointment->save();

        $updateAppointmentStatus = Appointment::where('_id',$appointment_id)->first();
        $updateAppointmentStatus->status = $status;
        $updateAppointmentStatus->save();

        $message = 'Appointment status Updated Sucessfully.';
        return SuccessResponse($message,200,[]);
    }

    public function appointmentAccept(Request $request)
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
            'salon_id' => 'required',
            'appointment_id' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);

        $salon_id = $request->salon_id;
        $user_id = $jwt_user->_id;
        $appointment_id = $request->appointment_id;

        $acceptAppointment = new AppointmentAcceptance;
        $acceptAppointment->appointment_id = $appointment_id;
        $acceptAppointment->salon_id = $salon_id;
        $acceptAppointment->user_id = $user_id;
        $acceptAppointment->status = APPOINTMENT_ACCEPT;
        $acceptAppointment->save();

        $updateAppointmentStatus = Appointment::where('_id',$appointment_id)->first();
        $updateAppointmentStatus->status = APPOINTMENT_ACCEPT;
        $updateAppointmentStatus->save();

        // send push notification code start
        $push_title = 'Appointment Accepted';
        $push_message = 'your Appointment accepted by '.ucfirst($jwt_user->name);
        $push_data = ['appointment_id' => $appointment_id];

        $tokenData = UserDeviceToken::where('user_id',$updateAppointmentStatus->user_id)->first();
        if(!empty($tokenData))
        {
            $push_token = $tokenData->token;
            sendPushNotification($push_title,$push_message,$push_token,$push_data);
        }
        // send push notification code end

        $message = 'Appointment status Updated Sucessfully.';
        return SuccessResponse($message,200,[]);
    }

    public function cancelAppointment(Request $request)
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
            'salon_id' => 'required',
            'appointment_id' => 'required',
            'reason' => 'required'
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);

        $salon_id = $request->salon_id;
        $appointment_id = $request->appointment_id;
        $reason = $request->reason;
        $user_id = $jwt_user->_id;

        $cancelAppointment = new AppointmentAcceptance;
        $cancelAppointment->appointment_id = $appointment_id;
        $cancelAppointment->salon_id = $salon_id;
        $cancelAppointment->user_id = $user_id;
        $cancelAppointment->reason = $reason;
        $cancelAppointment->status = APPOINTMENT_CANCEL;
        $cancelAppointment->save();

        $updateAppointmentStatus = Appointment::where('_id',$appointment_id)->first();
        $updateAppointmentStatus->status = APPOINTMENT_CANCEL;
        $updateAppointmentStatus->save();

        $message = 'Appointment Canceled Successfully.';
        return SuccessResponse($message,200,[]);
    }

    public function startAppointment(Request $request)
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
            'salon_id' => 'required',
            'appointment_id' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);

        $salon_id = $request->salon_id;
        $appointment_id = $request->appointment_id;
        $user_id = $jwt_user->_id;

        $startAppointment = new AppointmentAcceptance;
        $startAppointment->appointment_id = $appointment_id;
        $startAppointment->salon_id = $salon_id;
        $startAppointment->user_id = $user_id;
        $startAppointment->reason = null;
        $startAppointment->status = APPOINTMENT_INPROGRESS;
        $startAppointment->save();

        $updateAppointmentStatus = Appointment::where('_id',$appointment_id)->first();
        $updateAppointmentStatus->status = APPOINTMENT_INPROGRESS;
        $updateAppointmentStatus->save();

        $message = 'Appointment started Successfully.';
        return SuccessResponse($message,200,[]);
    }

    public function completeAppointment(Request $request)
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
            'salon_id' => 'required',
            'appointment_id' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);

        $salon_id = $request->salon_id;
        $appointment_id = $request->appointment_id;
        $user_id = $jwt_user->_id;

        $salon = Salon::where('_id',$salon_id)->first();
        $admin_commission_price = 0;

        $data = Appointment::with(['appointmentServices','customer']);
        $data = $data->where('_id',$appointment_id)->first();
        if(!empty($data['appointmentServices']))
        {
            foreach($data['appointmentServices'] as $service)
            {
                $admin_commission_price += $service['price'];
            }
        }
        $commission_price = ($admin_commission_price * (float)$salon->commission) / 100 ;

        $completeAppointment = Appointment::where('_id',$appointment_id)->first();
        $completeAppointment->status = APPOINTMENT_COMPLETE;
        $completeAppointment->completed_by = $user_id;
        $completeAppointment->admin_commission = numberFormat($commission_price);
        $completeAppointment->save();

        $message = 'Appointment Completed Successfully.';
        return SuccessResponse($message,200,[]);
    }

    public function onGoingAppointment(Request $request)
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
            'salon_id' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);

        $salon_id = $request->salon_id;
        $user_id = $jwt_user->_id;

        $data = Appointment::with(['appointmentServices','customer']);
        $data = $data->where('salon_id',$salon_id);
        if($jwt_user->role == STYLIST_ROLE)
        {
            $data = $data->where('employee_id',$user_id);
        }
        $data = $data->where('status',APPOINTMENT_INPROGRESS);
        $data = $data->get();

        $message = 'On Going Appointment List';
        return SuccessResponse($message,200,$data);
    }
}
