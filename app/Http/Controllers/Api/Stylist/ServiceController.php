<?php

namespace App\Http\Controllers\Api\Stylist;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\ShalonImage;
use App\Models\SalonService;
use App\Models\ServiceRequest;
use App\Models\Service;
use App\Models\Salon;
use Validator;
use JWTAuth;
use Response;
use JWTFactory;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Exceptions\JWTException;

class ServiceController extends Controller
{
    public function __construct()
    {
        $this->middleware('jwt.auth');
    }

    public function service_list(Request $request)
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

        $service_list = SalonService::where('user_id',$jwt_user->_id);
        $service_list = $service_list->orderBy('created_at','DESC');
        $service_list = $service_list->get()->toArray();
        if(!empty($service_list))
        {    
            $message = 'Service list.';
            return SuccessResponse($message,200,$service_list);   
        } 
        else 
        {
            $message = 'Service not found';
            return InvalidResponse($message,101);
        }
    }

    public function create_service(Request $request)
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
            'service_id' => 'required',
            'service_price' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $serviceDetail = Service::where('_id',$request->service_id)->first();
        $salonDetail = Salon::where('user_id',$jwt_user->_id)->first();

        $new_service = new SalonService;
        $new_service->user_id = $jwt_user->_id;
        $new_service->salon_id = $salonDetail->_id;
        $new_service->service_id = $request->service_id;
        $new_service->service_name = $serviceDetail->name;
        $new_service->service_price = $request->service_price;
        $new_service->save();

        $message = 'Service added successfully.';
        return SuccessResponse($message,200,[]);
    }

    public function edit_service(Request $request)
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
            'service_id' => 'required',
            'service_price' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $service = SalonService::where('_id',$request->service_id)->first();
        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        
        $serviceDetail = Service::where('_id',$service->service_id)->first();
        if(!empty($service))
        {    
            $service->user_id = $jwt_user->_id;
            $service->service_id = $request->service_id;
            $service->service_name = $serviceDetail->name;
            $service->service_price = $request->service_price;
            $service->save();

            $message = 'Service updated successfully.';
            return SuccessResponse($message,200,[]);
        }
    }

    public function delete_service(Request $request)
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
            'service_id' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $service = SalonService::where('_id',$request->service_id)->first();
        if(!empty($service))
        {    
            $service->delete();
            $message = 'Service deleted successfully.';
            return SuccessResponse($message,200,[]);
        }
    }

    public function service_request(Request $request)
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
            'service_name' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }

        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);
        $user_id = $jwt_user->_id;
        $service_name = strtolower($request->service_name);

        $serviceExists = Service::where('service_name',$service_name)->count();
        if($serviceExists > 0)
        {
            $message = 'Service already existed in list.';
            return InvalidResponse($message,101);
        }

        $serviceCount = ServiceRequest::where('stylist_id',$user_id);
        $serviceCount = $serviceCount->where('service_name',$service_name);
        $serviceCount = $serviceCount->count();
        if($serviceCount > 0)
        {
            $message = 'Service Request already added';
            return InvalidResponse($message,101);
        } 
        else 
        {
            $addServiceRequest = new ServiceRequest;
            $addServiceRequest->service_name = $service_name;
            $addServiceRequest->stylist_id = $user_id;
            $addServiceRequest->status = 1;
            $addServiceRequest->reason = null;
            $addServiceRequest->save();

            $message = 'Service Request added successfully.';
            return SuccessResponse($message,200,[]);
        }
    }

    public function getRequestedServices(Request $request)
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

        $serviceList = ServiceRequest::where('stylist_id',$user_id)->get();
        if(empty($serviceList) && count($serviceList) > 0)
        {
            $message = 'No Service Request sended';
            return InvalidResponse($message,101);
        } 
        else 
        {
            $message = 'Service Request List.';
            return SuccessResponse($message,200,$serviceList);
        }
    }
}
