<?php

namespace App\Http\Controllers\Api\Client;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Salon;
use App\Models\SalonRating;
use Validator;
use JWTAuth;

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
            'stylist_id' => 'required',
            'rating' => 'required',
            'message' => 'required',
        ]);

        if ($validator->fails()) 
        {
            $message = $validator->messages()->first();
            return InvalidResponse($message,101);
        }
        
        $jwt_user = JWTAuth::parseToken()->authenticate($user_token);

        $user_id = $jwt_user->_id;
        $stylist_id = $request->stylist_id;
        $salon_id = $request->salon_id;

        $Salon = Salon::where('_id',$salon_id)->first();
        if(empty($Salon))
        {
            $message = 'Salon Not Found';
            return InvalidResponse($message,101);
        }

        // $ratingDataCheck = SalonRating::where('sender_id',$user_id)->where('receiver_id',$stylist_id)->count();

        // if($ratingDataCheck > 0){
        //     $message = 'Rating already given on this Salon';
        //     return InvalidResponse($message,101);   
        // }

        $storeRating = new SalonRating;
        $storeRating->sender_id = $user_id;
        $storeRating->receiver_id = $stylist_id;
        $storeRating->salon_id = $salon_id;
        $storeRating->rating = round($request->rating,2);
        $storeRating->message = $request->message;
        $storeRating->sender = 'client';

        if ($request->hasFile('image')) 
        {
            $image = $request->file('image');
            $name = 'rating_'.rand(0,999999).'_'.time().'.'.$image->getClientOriginalExtension();
            $destinationPath = public_path('/rating');
            $image->move($destinationPath, $name);
            $storeRating->image = $name;
        }
        $storeRating->save();

        $getAvgRating = SalonRating::where('salon_id',$salon_id)->avg('rating');
        // save AVG rating on salon main table
        $SalonRate = Salon::where('_id',$salon_id)->first();
        $SalonRate->ratings = $getAvgRating;
        $SalonRate->save();

        $getStylistAvgRating = SalonRating::where('receiver_id',$stylist_id)->avg('rating');
        $StylistRate = User::where('_id',$stylist_id)->first();
        $StylistRate->rating = $getStylistAvgRating;
        $StylistRate->save();

        $message = 'Salon Rating added successfully.';
        return SuccessResponse($message,200,[]);
    }
}
