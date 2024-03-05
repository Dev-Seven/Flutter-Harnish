<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\UserDeviceToken;
use App\Models\Service;
use App\Models\City;
use Validator;
use JWTAuth;
use Response;
use JWTFactory;

class CommonController extends Controller
{
    public function __construct()
    {
        $this->middleware('jwt.auth');
    }
    public function logout(Request $request)
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
        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $user_id = $jwt_user->_id;
        UserDeviceToken::where('user_id',$user_id)->delete();

        $message = 'User logout successfully';
        return SuccessResponse($message,200,[]);
    }

    public function activate_status(Request $request)
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
            'activation_status' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $user_id = $jwt_user->_id;

        $user = User::where('_id',$user_id)->first();
        if(!empty($user)) 
        {
            $message = '';
            if($request->activation_status == 0)
            {
                $user->activation_status = 0;
                $message = 'Stylist has been completed appointment';
            } 
            else 
            {
                $user->activation_status = 1;
                $message = 'Stylist has been started new appointment';
            }
            $user->save();
            return SuccessResponse($message,200,[]);
        } 
        else 
        {
            $message = 'Stylist detail not found';
            return InvalidResponse($message,101);
        }
    }

    public function servicesList(Request $request)
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

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $user_id = $jwt_user->_id;

        $servicesList = Service::where('status',1)->get();

        if(!empty($servicesList) && count($servicesList) > 0) 
        {
            $message = 'Service List';
            return SuccessResponse($message,200,$servicesList);
        } 
        else 
        {
            $message = 'Service Not Found!';
            return InvalidResponse($message,101);
        }
    }

    public function cityList(Request $request)
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

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $user_id = $jwt_user->_id;

        $cityList = City::where('status',1)->get();
        if(!empty($cityList) && count($cityList) > 0) 
        {
            $message = 'City List';
            return SuccessResponse($message,200,$cityList);
        } 
        else 
        {
            $message = 'City Not Found!';
            return InvalidResponse($message,101);
        }
    }
}
