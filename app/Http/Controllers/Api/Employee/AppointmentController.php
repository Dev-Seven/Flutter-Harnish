<?php

namespace App\Http\Controllers\Api\Employee;

use Tymon\JWTAuth\Exceptions\JWTException;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Models\User;
use App\Models\Appointment;
use App\Models\AppointmentAcceptance;
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
        
        if (!$success) {
            return $response;
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $user_id = $jwt_user->_id;

        $appointmentList = Appointment::with(['appointmentServices','customer'])->where('employee_id',$user_id)->orderBy('id','DESC')->get();

        if(count($appointmentList) == 0)
        {
            $message = 'No Appointment Found.';
            return SuccessResponse($message,200,[]);
        }

        $message = 'Appointment Listing.';
        return SuccessResponse($message,200,$appointmentList);
    }
}
