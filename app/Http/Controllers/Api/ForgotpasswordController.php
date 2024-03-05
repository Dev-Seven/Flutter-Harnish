<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\PasswordReset;
use Auth;
use Mail;
use Validator;
use Log;
use Exception;

class ForgotpasswordController extends Controller
{
    public function postRefreshToken(Request $request) 
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
    }

    public function forgot_password(Request $request)
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
            'email' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $email = $request->email;
        $user = User::where('email',$email)->first();

        if(!empty($user))
        {
            PasswordReset::where('email',$email)->delete();
            $token = generateRandomString(4);
            $reset = new PasswordReset;
            $reset->email = $email;
            $reset->token = $token;
            $reset->save();

            $from_address = env('MAIL_FROM_ADDRESS');
            $from_name = env('MAIL_FROM_NAME');

            $data = array('name'=> $user->name, 'token' => $token);

            try {
                Mail::send('mails.reset_link_otp', $data, function($message) use($user,$from_address,$from_name) {
                    $message->to($user->email, $user->name);
                    $message->subject('Password reset request');
                    $message->from($from_address,$from_name);
                });
            } catch (Exception $e) {
                Log::Info('mail_failed_reset_link_app',['error' => $e]);
            }
            
            $message = 'Check your mailbox for reset password link';
            return SuccessResponse($message,200,[]); 
        } 
        else 
        {
            $message = 'Entered details not found';
            return InvalidResponse($message,200);
        }
    }

    public function check_otp(Request $request)
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
            'email' => 'required',
            'otp' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $token = $request->otp;
        $email = $request->email;

        $check_token = PasswordReset::where('token',$token)->where('email',$email)->first();
        if(!empty($check_token))
        {
            $message = 'OTP is valid';
            return SuccessResponse($message,200,[]);
        } 
        else 
        {
            $message = 'Entered OTP is invalid';
            return InvalidResponse($message,200);
        }
    }

    public function password_submit(Request $request)
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
            'email' => 'required',
            'password' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $email = $request->email;
        $user = User::where('email',$email)->first();
        if(!empty($user))
        {
            $user->password = Hash::make($request->password);
            $user->save();

            PasswordReset::where('email',$email)->delete();

            $message = 'Password updated successfully!';
            return SuccessResponse($message,200,[]);
        } 
        else 
        {
            $message = 'Entered details not found';
            return InvalidResponse($message,200);
        }
    }
}
