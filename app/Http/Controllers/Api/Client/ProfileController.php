<?php

namespace App\Http\Controllers\Api\Client;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use JWTAuth;
use Validator;

class ProfileController extends Controller
{
    public function __construct()
    {
        $this->middleware('jwt.auth');
    }
    public function getProfile(Request $request)
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

        $message = 'Get user Profile.';
        return SuccessResponse($message,200,$jwt_user);
    }

    public function update_profile(Request $request)
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
            'first_name' => 'required',
            'last_name' => 'required',
            'email' => 'required|email',
            'gender' => 'required',
            'location' => 'required',
            'latitude' => 'required',
            'longitude' => 'required',
            'city' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $user = User::where('_id',$jwt_user->_id)->first();
        
        $check_email = User::where('email',$request->email)->where('_id','!=',$jwt_user->_id)->count();
        if($check_email > 0)
        {
            $message = 'Entered email already used by another user';
            return InvalidResponse($message,101);
        }

        if(!empty($user))
        {    
            $user->first_name = $request->first_name;
            $user->last_name = $request->last_name;
            $user->name = $request->first_name.' '.$request->last_name;
            $user->email = $request->email;
            $user->gender = $request->gender;
            $user->location = $request->location;
            $user->city = $request->city;
            $user->latitude = $request->latitude;
            $user->longitude = $request->longitude;
            $user->save();

            $message = 'Profile updated Successfully.';
            return SuccessResponse($message,200,[]);
            
        } 
        else 
        {
            $message = 'User not found';
            return InvalidResponse($message,101);
        }
    }
}
