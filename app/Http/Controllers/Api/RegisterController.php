<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\Salon;
use App\Models\UserDeviceToken;
use Validator;
use JWTAuth;
use Response;
use JWTFactory;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Exceptions\JWTException;
use Mail;

class RegisterController extends Controller
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

	public function register(Request $request)
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
			'salon_name' => 'required',
			'full_name' => 'required',
			'phone_number' => 'required',
		]);

		if ($validator->fails()) 
		{
			$message = $validator->messages()->first();
			return InvalidResponse($message,101);
		}

		$user = User::where('phone_number',$request->phone_number)->first();
		if(empty($user))
		{
			$otp = generateRandomString(4);

			$create_user = new User;
			$create_user->first_name = $request->full_name;
			$create_user->last_name = null;
			$create_user->name = $request->full_name;
			$create_user->phone_number = $request->phone_number;
			$create_user->password = null;
			$create_user->role = SALON_ROLE;
			$create_user->status = 0;
			$create_user->confirmed = 0;
			$create_user->image = null;
			$create_user->otp = $otp;
			$create_user->dob = null;
			$create_user->gender = null;
			$create_user->city = null;
			$create_user->rating = 0;
			$create_user->activation_status = 0;
			$create_user->save();

			// salon create
			$create_salon = new Salon;
			$create_salon->salon_name = $request->salon_name;
			$create_salon->owner_name = $request->full_name;
			$create_salon->user_id = $create_user->_id;
			$create_salon->email = null;
			$create_salon->phone_number = $request->phone_number;
			$create_salon->address = null;
			$create_salon->city = null;
			$create_salon->type = null;
			$create_salon->status = 1;
			$create_salon->ratings = 0;
			$create_salon->total_revenue = numberFormat("0");
			$create_salon->save();

			$findStylist = User::where('_id',$create_user->_id)->first();
			$findStylist->parent_id = 0;
			$findStylist->salon_id = $create_salon->_id;
			$findStylist->save();

			$phone_number = $create_user->phone_number;
			sendOtp($phone_number,$otp);

			$message = 'Registration Successfully.';
			return SuccessResponse($message,200,$create_user);
		} 
		else 
		{
			$message = 'This Phone number already exists in our record';
			return InvalidResponse($message,101);
		}
	}

	public function customerRegistration(Request $request)
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
		
		if (!$success) 
		{
			return $response;
		}

		$validator = Validator::make($request->all(), [
			'name' => 'required',
			'full_name' => 'required',
			'phone_number' => 'required',
		]);

		if ($validator->fails()) 
		{
			$message = $validator->messages()->first();
			return InvalidResponse($message,101);
		}

		$user = User::where('phone_number',$request->phone_number)->first();
		if(empty($user))
		{
			$otp = generateRandomString(4);

			$create_user = new User;
			$create_user->first_name = $request->name;
			$create_user->last_name = null;
			$create_user->name = $request->full_name;
			$create_user->phone_number = $request->phone_number;
			$create_user->password = null;
			$create_user->role = USER_ROLE;
			$create_user->status = 0;
			$create_user->confirmed = 0;
			$create_user->image = null;
			$create_user->otp = $otp;
			$create_user->dob = null;
			$create_user->gender = null;
			$create_user->city = null;
			$create_user->rating = 0;
			$create_user->activation_status = 0;
			$create_user->save();

			$phone_number = $create_user->phone_number;
			sendOtp($phone_number,$otp);

			$message = 'Registration Successfully.';
			return SuccessResponse($message,200,$create_user);
		} 
		else 
		{
			$message = 'This Phone number already exists in our record';
			return InvalidResponse($message,101);
		}
	}

	public function verify_otp(Request $request)
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
			'mobile_number' => 'required',
			'otp' => 'required',
		]);

		if ($validator->fails()) 
		{
			$message = $validator->messages()->first();
			return InvalidResponse($message,101);
		}

		$user = User::where('phone_number',$request->mobile_number)->first();
		if(!empty($user))
		{
			if($user->otp == $request->otp)
			{
				$user->otp = null;
				$user->activation_status = 1;
				$user->save();

				$user_detail = User::where('_id',$user->_id)->first();
				$token = JWTAuth::fromUser($user_detail);
				$user_detail['token'] = $token;

				if(isset($request->device_token) && $request->device_token != '')
				{
					$checkToken = UserDeviceToken::where('token',$request->device_token);
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
				$message = 'User verified Successfully.';
				return SuccessResponse($message,200,$user_detail);
			} 
			else 
			{
				$message = 'Please enter valid OTP';
				return InvalidResponse($message,101);
			}
		} 
		else
		{
			$message = 'This Phone number not exists in our record';
			return InvalidResponse($message,101);
		}
	}

	public function resend_otp(Request $request)
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
			'mobile_number' => 'required',
		]);

		if ($validator->fails()) 
		{
			$message = $validator->messages()->first();
			return InvalidResponse($message,101);
		}

		$user = User::where('phone_number',$request->mobile_number)->first();
		if(!empty($user))
		{
			$otp = generateRandomString(4);
			$user->otp = $otp;
			$user->save();

			sendOtp($user->phone_number,$otp);
			$message = 'OTP Send Successfully';
			return SuccessResponse($message,200,[]);
		} 
		else 
		{
			$message = 'This Phone number not exists in our record';
			return InvalidResponse($message,101);
		}
	}
}
