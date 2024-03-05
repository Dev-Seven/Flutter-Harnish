<?php

namespace App\Http\Controllers\Api\Stylist;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\ShalonImage;
use App\Models\SalonVisited;
use App\Models\SalonRating;
use Validator;
use JWTAuth;
use Response;
use JWTFactory;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Exceptions\JWTException;
use Mail;

class RatingController extends Controller
{
    public function __construct()
    {
        $this->middleware('jwt.auth');
    }
    public function addRatings(Request $request)
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
            'salon_id' => 'required',
            'customer_id' => 'required',
            'rating' => 'required',
            'message' => 'required',
        ]);

        if ($validator->fails()) {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }
        
        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);

        $user_id = $jwt_user->_id;
        $customer_id = $request->customer_id;
        $salon_id = $request->salon_id;

        $ratingDataCheck = SalonRating::where('sender_id',$user_id);
        $ratingDataCheck = $ratingDataCheck->where('receiver_id',$customer_id);
        $ratingDataCheck = $ratingDataCheck->count();
        if($ratingDataCheck > 0)
        {
            $message = 'Rating already given on this Customer';
            return InvalidResponse($message,101);   
        }

        $storeRating = new SalonRating;
        $storeRating->sender_id = $user_id;
        $storeRating->receiver_id = $customer_id;
        $storeRating->salon_id = $salon_id;
        $storeRating->rating = round($request->rating,2);
        $storeRating->message = $request->message;
        $storeRating->sender = 'stylist';

        if ($request->hasFile('image')) 
        {
            $image = $request->file('image');
            $name = 'rating_'.rand(0,999999).'_'.time().'.'.$image->getClientOriginalExtension();
            $destinationPath = public_path('/rating');
            $image->move($destinationPath, $name);
            $storeRating->image = $name;
        }
        $storeRating->save();

        $message = 'Customer Rating added successfully.';
        return SuccessResponse($message,200,[]);
    }
}
