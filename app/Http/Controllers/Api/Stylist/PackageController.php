<?php

namespace App\Http\Controllers\Api\Stylist;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\ShalonImage;
use App\Models\SalonService;
use App\Models\SalonPackage;
use App\Models\Salon;
use App\Models\StylistPackageServices;
use Validator;
use JWTAuth;
use Response;
use JWTFactory;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Exceptions\JWTException;

class PackageController extends Controller
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
        $service_list = SalonPackage::with(['salon_detail','services'])->where('salon_id',$jwt_user->salon_id)->orderBy('created_at','DESC')->get();
        if(!empty($service_list))
        {    
            $message = 'Package list.';
            return SuccessResponse($message,200,$service_list);    
        } 
        else 
        {
            $message = 'Package not found';
            return InvalidResponse($message,101);
        }
    }

    public function create(Request $request)
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
            'name' => 'required',
            'services' => 'required',
            'price' => 'required',
            'discount' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $servicesList = json_decode($request->services);

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $serviceCount = 0;
        $salonDetail = Salon::where('user_id',$jwt_user->_id)->first();

        $new_package = new SalonPackage;
        $new_package->name = $request->name;
        $new_package->price = $request->price;
        $new_package->discount = $request->discount;
        $new_package->user_id = $jwt_user->_id;
        if(!empty($servicesList) && count($servicesList) > 0)
        {
            $serviceCount = count($servicesList);
        }
        $new_package->service_count = $serviceCount;
        $new_package->salon_id = $salonDetail->_id;
        $new_package->save();

        if(!empty($servicesList) && count($servicesList) > 0)
        {
            foreach($servicesList as $key => $value)
            {
                $value = trim($value);
                $service_data = SalonService::where('_id',$value)->first();
                $p_service = new StylistPackageServices;
                $p_service->package_id = $new_package->_id;
                $p_service->service_id = $value;
                $p_service->service_price = $service_data->service_price;
                $p_service->service_name = $service_data->service_name;
                $p_service->user_id = $jwt_user->_id;
                $p_service->save();
            }
        }

        $message = 'Package added successfully.';
        return SuccessResponse($message,200,[]);
    }

    public function delete(Request $request)
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
            'package_id' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $service = SalonPackage::where('_id',$request->package_id)->first();
        if(!empty($service))
        {
            StylistPackageServices::where('package_id',$request->package_id)->delete();
            $service->delete();
            $message = 'Package deleted successfully.';
            return SuccessResponse($message,200,[]);
        }
    }
}
