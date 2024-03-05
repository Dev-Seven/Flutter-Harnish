<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\PasswordReset;
use App\Models\SupportDetail;
use Auth;
use Mail;
use Validator;
use Log;
use Exception;

class SupportController extends Controller
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

    public function index(Request $request)
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

        $support_data = SupportDetail::get();
        if(!empty($support_data))
        {    
            $message = 'Support Data';
            return SuccessResponse($message,200,$support_data);   
        } 
        else 
        {
            $message = 'No Support data found';
            return InvalidResponse($message,200);
        }
    }
}
