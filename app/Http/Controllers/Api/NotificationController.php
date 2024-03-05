<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\ShalonImage;
use App\Models\UserDeviceToken;
use Validator;
use JWTAuth;
use Response;
use JWTFactory;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Exceptions\JWTException;
use Mail;

class NotificationController extends Controller
{
    public function __construct()
    {
        $this->middleware('jwt.auth');
    }
    public function onOffSwitch(Request $request)
    {
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
            'status' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $user_id = $jwt_user->_id;

        $user = User::where('_id',$user_id)->first();
        if(empty($user))
        {
        	$message = 'User Detail Not Found' ;
            return InvalidResponse($message,101);
        }

        $user->notification_status = $request->status;
        $user->save();

        $message = 'User Notification status updated successfully';
        return SuccessResponse($message,200,[]);
    }

}
