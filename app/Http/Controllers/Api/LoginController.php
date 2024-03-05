<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\UserDeviceToken;
use Validator;
use JWTAuth;
use Response;
use JWTFactory;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Exceptions\JWTException;

class LoginController extends Controller
{
    public function postRefreshToken(Request $request)
    {
        /*$enc = Crypt::e ncrypt('apiuser@harnish.com|123456789');*/
        $inputData = $request->all();

        $header = $request->header('AuthorizationUser');
        if(empty($header))
        {
            $message = 'Authorisation required' ;
            return InvalidResponse($message,101);
        }

        $response = veriftyAPITokenData($header);
        $success = $response->original['success'];

        if (!$success)
        {
            return $response;
        }
    }

    public function login(Request $request)
    {
        $inputData = $request->all();

        $header = $request->header('AuthorizationUser');
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
            'phone_number' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $phone_number = $request->phone_number;
        $otp = generateRandomString(4);
        $user = User::where('phone_number',$phone_number)->first();
        if(empty($user)) 
        {
            $message = "User not found";
            return InvalidResponse($message,101);   
        }

        $user->otp = $otp;
        $user->save();

        $user_detail = User::where('phone_number',$phone_number)->first();
        sendOtp($phone_number,$otp);
        $token = JWTAuth::fromUser($user_detail);
        $user_detail['token'] = $token;

        if(isset($request->device_token) && $request->device_token != '')
        {
            $checkToken = UserDeviceToken::where('token',$request->token);
            $checkToken = $checkToken->where('user_id',$user_detail->id);
            $checkToken = $checkToken->count();

            if($checkToken == 0)
            {
                $deviceToken = new UserDeviceToken;
                $deviceToken->user_id = $user_detail->id;
                $deviceToken->token = $request->device_token;
                if(isset($request->device_type) && $request->device_type != '')
                {
                    $deviceToken->device_type = $request->device_type;
                }
                $deviceToken->save();
            }
        }
        $message = 'Login successfully';
        return SuccessResponse($message,200,$user_detail);
    }
}
