<?php

namespace App\Http\Controllers\Api\Stylist;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\ShalonImage;
use App\Models\Salon;
use App\Models\StylistEmployee;
use Validator;
use JWTAuth;
use Response;
use JWTFactory;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Exceptions\JWTException;

class EmployeeController extends Controller
{
    public function __construct()
    {
        $this->middleware('jwt.auth');
    }

    public function create_employee(Request $request)
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
            'mobile_no' => 'required',
            'dob' => 'required',
            'gender' => 'required',
            'location' => 'required',
            'latitude' => 'required',
            'longitude' => 'required',
            'designation' => 'required',
            'time_schedule' => 'required',
            'city' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $salon_detail = Salon::where('user_id',$jwt_user->_id)->first();

        $check_employee = User::where('phone_number',$request->mobile_no)->count();
        if($check_employee > 0)
        {
            $message = 'This Phone number already exists in our record';
            return InvalidResponse($message,101);
        }

        $check_email = User::where('email',$request->email)->count();
        if($check_email > 0)
        {
            $message = 'This Email already used by another user';
            return InvalidResponse($message,101);
        }

        $otp = generateRandomString(4);

        $create_employee = new User;
        $create_employee->first_name = $request->first_name;
        $create_employee->last_name = $request->last_name;
        $create_employee->name = $request->first_name." ".$request->last_name;
        $create_employee->email = $request->email;
        $create_employee->phone_number = $request->mobile_no;
        $create_employee->dob = $request->dob;
        $create_employee->gender = $request->gender;
        $create_employee->location = $request->location;
        $create_employee->latitude = $request->latitude;
        $create_employee->longitude = $request->longitude;
        $create_employee->designation = $request->designation;
        $create_employee->time_schedule = $request->time_schedule;
        $create_employee->city = $request->city;
        $create_employee->otp = $otp;
        $create_employee->status = 0;
        $create_employee->parent_id = $jwt_user->_id;
        $create_employee->salon_id = $salon_detail->_id;
        $create_employee->ratings = 0;
        $create_employee->total_revenue = numberFormat("0");
        $create_employee->role = STYLIST_ROLE;
        if ($request->hasFile('image'))
        {
            $image = $request->file('image');
            $name = 'profile_'.rand(0,999999).'_'.time().'.'.$image->getClientOriginalExtension();
            $destinationPath = public_path('/users');
            $image->move($destinationPath, $name);
            $create_employee->image = $name;
        }
        $create_employee->save();

        $phone_number = $create_employee->phone_number;
        sendOtp($phone_number,$otp);

        $message = 'Employee Added successfully.';
        return SuccessResponse($message,200,$create_employee);
    }

    public function edit_employee(Request $request)
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
            'mobile_no' => 'required',
            'dob' => 'required',
            'gender' => 'required',
            'location' => 'required',
            'latitude' => 'required',
            'longitude' => 'required',
            'designation' => 'required',
            'time_schedule' => 'required',
            'employee_id' => 'required',
            'city' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $employee = User::where('_id',$request->employee_id)->first();

        $check_email = User::where('email',$request->email);
        $check_email = $check_email->where('_id','!=',$request->employee_id);
        $check_email = $check_email->count();

        if($check_email > 0)
        {
            $message = 'This Email already used by another user';
            return InvalidResponse($message,101);
        }

        if(empty($employee))
        {
            $message = 'No Employee found';
            return InvalidResponse($message,101);
        } 
        else 
        {
            $employee->first_name = $request->first_name;
            $employee->last_name = $request->last_name;
            $employee->name = $request->first_name." ".$request->last_name;
            $employee->email = $request->email;
            $employee->phone_number = $request->mobile_no;
            $employee->dob = $request->dob;
            $employee->gender = $request->gender;
            $employee->location = $request->location;
            $employee->latitude = $request->latitude;
            $employee->longitude = $request->longitude;
            $employee->designation = $request->designation;
            $employee->time_schedule = $request->time_schedule;
            $employee->city = $request->city;

            if ($request->hasFile('image'))
            {
                $image = $request->file('image');
                $name = 'profile_'.rand(0,999999).'_'.time().'.'.$image->getClientOriginalExtension();
                $destinationPath = public_path('/users');
                $image->move($destinationPath, $name);
                $employee->image = $name;
            }
            $employee->save();

            $message = 'Employee Updated successfully.';
            return SuccessResponse($message,200,[]);
        }
    }

    public function detail_employee(Request $request)
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
            'employee_id' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $employee = User::where('_id',$request->employee_id)->first();
        if(empty($employee))
        {
            $message = 'No Employee found';
            return InvalidResponse($message,101);
        } 
        else 
        {
            $message = 'Employee Detail.';
            return SuccessResponse($message,200,$employee);
        }
    }

    public function employee_list(Request $request)
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

        $employee = User::with(['rating_review' => function($data){ $data->orderBy('created_at','DESC')->limit(2); }])->where('parent_id',$jwt_user->_id)->where('role',STYLIST_ROLE)->get();
        if(empty($employee))
        {
            $message = 'No Employee found';
            return InvalidResponse($message,101);
        } 
        else 
        {
            $message = 'Employee List.';
            return SuccessResponse($message,200,$employee);
        }
    }

    public function delete_employee(Request $request)
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
            'employee_id' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);

        $employee = User::where('_id',$request->employee_id)->first();
        if(empty($employee))
        {
            $message = 'No Employee found';
            return InvalidResponse($message,101);
        } 
        else 
        {
            $employee->delete();
            $message = 'Employee Deleted successfully.';
            return SuccessResponse($message,200,[]);
        }
    }

    public function employeeVarification(Request $request)
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
            'employee_id' => 'required',
            'otp' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $user = User::where('_id',$request->employee_id)->first();
        if(!empty($user))
        {
            if($user->otp == $request->otp)
            {
                $user->otp = null;
                $user->activation_status = 1;
                $user->status = 1;
                $user->save();

                $message = 'Employee verified Successfully.';
                return SuccessResponse($message,200,[]);
            } 
            else 
            {
                $message = 'Please enter valid OTP';
                return InvalidResponse($message,101);
            }
        } 
        else 
        {
            $message = 'This Employee not exists in our record';
            return InvalidResponse($message,101);
        }
    }
}
