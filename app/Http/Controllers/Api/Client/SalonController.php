<?php

namespace App\Http\Controllers\Api\Client;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\ShalonImage;
use App\Models\SalonVisited;
use App\Models\Salon;
use App\Models\Appointment;
use App\Models\SalonPackage;
use Validator;
use JWTAuth;
use Response;
use JWTFactory;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Exceptions\JWTException;
use Mail;

class SalonController extends Controller
{
    public function __construct()
    {
        $this->middleware('jwt.auth');
    }

    public function list(Request $request)
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

        $SalonList = Salon::with(['salon_images','services','employee' => function($data){ $data->where('parent_id','<>',0)->where('status',1); }]);
        $SalonList = $SalonList->where('status',1);
        $SalonList = $SalonList->orderBy('rating','DESC');
        $SalonList = $SalonList->orderBy('salon_name','ASC');
        $SalonList = $SalonList->get();

        if(!empty($SalonList) && count($SalonList) > 0)
        { 
            $message = 'Salon Shop Listing.';
            return SuccessResponse($message,200,$SalonList);
        } 
        else 
        {
            $message = 'No Salon Shop Found' ;
            return InvalidResponse($message,101);   
        }
    }

    public function shopDetail(Request $request)
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

        $validator = Validator::make($request->all(), [
            'salon_id' => 'required',
        ]);

        if ($validator->fails()) {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);

        $salon_id = $request->salon_id;
        $user_id = $jwt_user->_id;

        // add last visited salon for perticular users
        $checkSalon = SalonVisited::where('user_id',$user_id)->where('salon_id',$salon_id)->count();
        if($checkSalon == 0){
            $add_visitor = new SalonVisited;
            $add_visitor->salon_id = $salon_id;
            $add_visitor->user_id = $user_id;
            $add_visitor->save();
        }

        $Salon = Salon::with(['salon_images','salon_timing','services','employee'=> function($data){ $data->where('parent_id','<>',0)->where('status',1); }, 'packages' => function($pack){ $pack->with('services'); }])->where('_id',$salon_id)->first();
        if(empty($Salon))
        {
            $message = 'Salon Not Found';
            return InvalidResponse($message,101);
        }
        $message = 'Salon Detail.';
        return SuccessResponse($message,200,$Salon);
    }

    public function lastVisitedSalon(Request $request)
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

        $appointments = Appointment::where('user_id',$user_id);
        $appointments = $appointments->where('status',APPOINTMENT_COMPLETE);
        $appointments = $appointments->get();

        if(!empty($appointments) && count($appointments) > 0)
        {
            $salonArr = [];
            foreach($appointments as $key => $value)
            {
                $salonArr[$key] = $value->salon_id;
            }

            if(!empty($salonArr) && count($salonArr) > 0)
            {
                $salonList = Salon::with(['salon_images','services','employee'=> function($data){ $data->where('parent_id','<>',0)->where('status',1); }])->whereIn('id',$salonArr)->get();
                
                $message = 'Last Visited List.';
                return SuccessResponse($message,200,$salonList);
            } 
            else 
            {
                $message = 'No Salon found';
                return InvalidResponse($message,101);
            }
        } 
        else 
        {
            $message = 'No Salon found';
            return InvalidResponse($message,101);
        }
    }

    public function recommendedStylist(Request $request)
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
        
        if (!$success) 
        {
            return $response;
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $user_id = $jwt_user->_id;

        $recommendedStylist = User::with('salon_detail')->where('role',STYLIST_ROLE);
        $recommendedStylist = $recommendedStylist->orderBy('rating','DESC');
        $recommendedStylist = $recommendedStylist->get();

        $message = 'Recommended Stylist List.';
        return SuccessResponse($message,200,$recommendedStylist);
    }

    public function topRatedSalon(Request $request)
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

        $topRatedSalonList = Salon::with(['services']);
        $topRatedSalonList = $topRatedSalonList->orderBy('rating','DESC');
        $topRatedSalonList = $topRatedSalonList->get();

        $message = 'Top Rated Salon List.';
        return SuccessResponse($message,200,$topRatedSalonList);
    }

    public function packages(Request $request)
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
        
        if (!$success) 
        {
            return $response;
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $user_id = $jwt_user->_id;

        $packageList = SalonPackage::with(['salon_detail','services']);
        $packageList = $packageList->orderBy('discount','DESC');
        $packageList = $packageList->orderBy('service_count','DESC');
        $packageList = $packageList->get();

        $message = 'Package Listing.';
        return SuccessResponse($message,200,$packageList);
    }
}
