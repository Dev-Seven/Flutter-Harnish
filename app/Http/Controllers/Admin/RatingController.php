<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\StylistEmployee;
use App\Models\SalonRating;
use App\Models\Appointment;
use App\Models\User;
use Auth;

class RatingController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function StylistRatingList()
    {
        $ratings = SalonRating::with(['sender','receiver','salon']);
        $ratings = $ratings->where('sender','stylist')->orderBy('created_at','DESC')->get();

        return view('admin.rating.stylist_list',compact('ratings'));
    }

    public function ClientRatingList()
    {
        $ratings = SalonRating::with(['sender','receiver','salon']);
        $ratings = $ratings->where('sender','client')->orderBy('created_at','DESC')->get();

        return view('admin.rating.client_list',compact('ratings'));
    }

    // public function view($id)
    // {
    //     $appointment = SalonRating::where('_id',$id)->first();
    //     return view('admin.appointment.view',compact('appointment'));   
    // }
}
