<?php

namespace App\Http\Controllers\Api\Stylist;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\ShalonImage;
use App\Models\SalonTiming;
use App\Models\Salon;
use Validator;
use JWTAuth;
use Response;
use JWTFactory;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Exceptions\JWTException;

class ShopController extends Controller
{
    public function __construct()
    {
        $this->middleware('jwt.auth');
    }

    public function shop_detail(Request $request)
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

        $salon_shop = Salon::with(['salon_images','salon_timing']);
        $salon_shop = $salon_shop->where('user_id',$jwt_user->_id);
        $salon_shop = $salon_shop->first();
        if(!empty($salon_shop))
        {
            $message = 'Shop Detail Found.';
            return SuccessResponse($message,200,$salon_shop);
        } 
        else 
        {
            $message = 'Shop Not Found.';
            return InvalidResponse($message,101);
        }
    }

    public function update_shop(Request $request)
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
        $salon_shop = Salon::where('user_id',$jwt_user->_id)->first();

        $message = 'Shop updated Successfully.';
        if(empty($salon_shop)) 
        {
            $message = 'Shop Created Successfully.';
            $salon_shop = new Salon;
        }

        $salon_shop->user_id = $jwt_user->_id;

        if(isset($request->address) && $request->address != '')
        {
            $salon_shop->address = $request->address;
        }
        if(isset($request->salon_name) && $request->salon_name != '')
        {
            $salon_shop->salon_name  = $request->salon_name;
        }
        if(isset($request->salon_type) && $request->salon_type != '')
        {
            $salon_shop->type  = $request->salon_type;
        }
        if(isset($request->latitude) && $request->latitude != '')
        {
            $salon_shop->latitude = $request->latitude;
        }
        if(isset($request->longitude) && $request->longitude != '')
        {
            $salon_shop->longitude = $request->longitude;
        }
        if(isset($request->tower_name) && $request->tower_name != '')
        {
            $salon_shop->tower_name = $request->tower_name;
        }
        if(isset($request->near_by) && $request->near_by != '')
        {
            $salon_shop->near_by = $request->near_by;
        }
        if(isset($request->area) && $request->area != '')
        {
            $salon_shop->area = $request->area;
        }
        if(isset($request->city) && $request->city != '')
        {
            $salon_shop->city = $request->city;
        }
        if(isset($request->state) && $request->state != '')
        {
            $salon_shop->state = $request->state;
        }
        $salon_shop->save();


        if(isset($request->open_close_data) && $request->open_close_data != '')
        {
            $weekdays = ['monday','tuesday','wednesday','thursday','friday','saturday','sunday'];
            SalonTiming::where('salon_id',$salon_shop->_id)->where('user_id',$jwt_user->_id)->delete();
                
            //Monday data
            $monday = new SalonTiming;
            $monday->salon_id = $salon_shop->_id;
            $monday->user_id  = $jwt_user->_id;
            $monday->week_day = strtolower($request->monday);
            $monday->status = $request->monday_status;
            if(isset($request->monday_from) && $request->monday_from != ''){
                $monday->opening_time = $request->monday_from;
            }
            if(isset($request->monday_to) && $request->monday_to != ''){
                $monday->closing_time = $request->monday_to;
            }
            $monday->save();

            // Tuesday
            $tuesday = new SalonTiming;
            $tuesday->salon_id = $salon_shop->_id;
            $tuesday->user_id  = $jwt_user->_id;
            $tuesday->week_day = strtolower($request->tuesday);
            $tuesday->status = $request->tuesday_status;
            if(isset($request->tuesday_from) && $request->tuesday_from != ''){
                $tuesday->opening_time = $request->tuesday_from;
            }
            if(isset($request->tuesday_to) && $request->tuesday_to != ''){
                $tuesday->closing_time = $request->tuesday_to;
            }
            $tuesday->save();

            // Wednesday
            $wednesday = new SalonTiming;
            $wednesday->salon_id = $salon_shop->_id;
            $wednesday->user_id  = $jwt_user->_id;
            $wednesday->week_day = strtolower($request->wednesday);
            $wednesday->status = $request->wednesday_status;
            if(isset($request->wednesday_from) && $request->wednesday_from != ''){
                $wednesday->opening_time = $request->wednesday_from;
            }
            if(isset($request->wednesday_to) && $request->wednesday_to != ''){
                $wednesday->closing_time = $request->wednesday_to;
            }
            $wednesday->save();

            // Thurdayday
            $thursday = new SalonTiming;
            $thursday->salon_id = $salon_shop->_id;
            $thursday->user_id  = $jwt_user->_id;
            $thursday->week_day = strtolower($request->thursday);
            $thursday->status = $request->thursday_status;
            if(isset($request->thursday_from) && $request->thursday_from != ''){
                $thursday->opening_time = $request->thursday_from;
            }
            if(isset($request->thursday_to) && $request->thursday_to != ''){
                $thursday->closing_time = $request->thursday_to;
            }
            $thursday->save();

            // Friday Data
            $friday = new SalonTiming;
            $friday->salon_id = $salon_shop->_id;
            $friday->user_id  = $jwt_user->_id;
            $friday->week_day = strtolower($request->friday);
            $friday->status = $request->friday_status;
            if(isset($request->friday_from) && $request->friday_from != ''){
                $friday->opening_time = $request->friday_from;
            }
            if(isset($request->friday_to) && $request->friday_to != ''){
                $friday->closing_time = $request->friday_to;
            }
            $friday->save();

            // Saturday
            $saturday = new SalonTiming;
            $saturday->salon_id = $salon_shop->_id;
            $saturday->user_id  = $jwt_user->_id;
            $saturday->week_day = strtolower($request->saturday);
            $saturday->status = $request->saturday_status;
            if(isset($request->saturday_from) && $request->saturday_from != ''){
                $saturday->opening_time = $request->saturday_from;
            }
            if(isset($request->saturday_to) && $request->saturday_to != ''){
                $saturday->closing_time = $request->saturday_to;
            }
            $saturday->save();

            // Sunday
            $sunday = new SalonTiming;
            $sunday->salon_id = $salon_shop->_id;
            $sunday->user_id  = $jwt_user->_id;
            $sunday->week_day = strtolower($request->sunday);
            $sunday->status = $request->sunday_status;
            if(isset($request->sunday_from) && $request->sunday_from != ''){
                $sunday->opening_time = $request->sunday_from;
            }
            if(isset($request->sunday_to) && $request->sunday_to != ''){
                $sunday->closing_time = $request->sunday_to;
            }
            $sunday->save();

            // $timing = json_decode($request->open_close_data);
            // if(!empty($timing) && count($timing) > 0)
            // {
            //     SalonTiming::where('salon_id',$salon_shop->_id)->where('user_id',$jwt_user->_id)->delete();
            //     foreach($timing as $key => $value)
            //     {
            //         $time = new SalonTiming;
            //         $time->salon_id = $salon_shop->_id;
            //         $time->user_id  = $jwt_user->_id;
            //         $time->week_day = $value->weekends;
            //         $time->status = $value->status;
            //         if(isset($value->opening_time) && $value->opening_time != '')
            //         {
            //             $time->opening_time = $value->opening_time;
            //         }
            //         if(isset($value->closing_time) && $value->closing_time != '')
            //         {
            //             $time->closing_time = $value->closing_time;
            //         }
            //         $time->save();
            //     }
            // }
        }
        return SuccessResponse($message,200,[]);
    }
}
