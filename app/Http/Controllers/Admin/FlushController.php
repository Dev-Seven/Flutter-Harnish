<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use App\Models\User;

class FlushController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function flush_data()
    {
        \App\Models\Appointment::truncate();
        \App\Models\AppointmentAcceptance::truncate();
        \App\Models\AppointmentService::truncate();
        \App\Models\CmsPage::truncate();
        \App\Models\PasswordReset::truncate();
        \App\Models\Salon::truncate();
        \App\Models\SalonPackage::truncate();
        \App\Models\SalonRating::truncate();
        \App\Models\SalonService::truncate();
        \App\Models\SalonShop::truncate();
        \App\Models\SalonTiming::truncate();
        \App\Models\SalonVisited::truncate();
        \App\Models\ServiceRequest::truncate();
        \App\Models\ShalonImage::truncate();
        \App\Models\StylistEmployee::truncate();
        \App\Models\StylistPackageServices::truncate();
        \App\Models\StylistService::truncate();
        \App\Models\SupportDetail::truncate();
        \App\Models\UserDeviceToken::truncate();
        \App\Models\UserService::truncate();
        User::whereNotIn('role',[1,2])->delete();
        

        //\App\Models\Service::truncate();
        //\App\Models\City::truncate();
        // \App\Models\Service::truncate();

        return redirect()->route('admin.dashboard')->with('success','Data deleted successfully');
    }
}

