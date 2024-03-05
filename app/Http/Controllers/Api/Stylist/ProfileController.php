<?php

namespace App\Http\Controllers\Api\Stylist;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\ShalonImage;
use Validator;
use JWTAuth;
use Response;
use JWTFactory;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Exceptions\JWTException;
use Mail;

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

        $message = 'Get Stylist Detail.';
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
            'email' => 'required',
        ]);

        if ($validator->fails()) {
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

    public function uploadImages(Request $request)
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

        if (!$success) 
        {
            return $response;
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $user = User::where('_id',$jwt_user->_id)->first();
        if($request->hasFile('images'))
        {
            foreach($request->images as $key => $img)
            {
                $new_image = new ShalonImage;
                $name = rand(0,99999).'_'.time().'.'.$img->getClientOriginalExtension();
                $destinationPath = public_path('/salon_image');
                $img->move($destinationPath, $name);
                $new_image->name = $name;
                $new_image->user_id = $user->_id;
                $new_image->type = "image";
                $new_image->save();
            }
        }

        if ($request->hasFile('logo'))
        {
            $image = $request->file('logo');
            $name = 'logo_'.rand(0,999999).'_'.time().'.'.$image->getClientOriginalExtension();
            $destinationPath = public_path('/salon_image');
            $image->move($destinationPath, $name);

            $new_image = new ShalonImage;
            $new_image->name = $name;
            $new_image->user_id = $user->_id;
            $new_image->type = "logo";
            $new_image->save();
        }

        $message = 'Image upload Successfully.';
        return SuccessResponse($message,200,[]);
    }

    public function uploadLogo(Request $request)
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
        $user = User::where('_id',$jwt_user->_id)->first();
        if ($request->hasFile('logo'))
        {
            $image = $request->file('logo');
            $name = 'logo_'.rand(0,999999).'_'.time().'.'.$image->getClientOriginalExtension();
            $destinationPath = public_path('/salon_image');
            $image->move($destinationPath, $name);

            $new_image = new ShalonImage;
            $new_image->name = $name;
            $new_image->user_id = $user->_id;
            $new_image->type = "logo";
            $new_image->save();
        }

        $message = 'Logo Updated Successfully.';
        return SuccessResponse($message,200,[]);
    }
}
