<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use App\Models\Service;
use App\Models\Salon;
use App\Models\User;
use App\Models\City;
use App\Models\SalonService;
use App\Models\StylistService;

class StylistController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index(Request $request)
    {
        $salonList = Salon::where('status',1)->get();

        $stylists = User::with('stylistAppointment','salon_detail','city_detail')->where('role',STYLIST_ROLE);
        if(isset($request->city) && $request->city != '')
        {
            $stylists = $stylists->where('city',$request->city);
        }
        if(isset($request->salon) && $request->salon != '')
        {
            $stylists = $stylists->where('salon_id',$request->salon);
        }
        if(isset($request->rate) && $request->rate != '')
        {
            if($request->rate != "0")
            {
                $stylists = $stylists->where('ratings',(int)$request->rate);
            } 
            else 
            {
                $stylists = $stylists->where('ratings',0);
            }
        }
        $stylists = $stylists->orderBy('_id','DESC')->get();
        $cities = City::where('status',1)->get();

        return view('admin.stylist.index',compact('stylists','salonList','cities'));
    }

    public function view($id)
    {
        $stylist = User::with(['city_detail','stylistAppointment' => function($customer){ $customer->with('customer'); },'salon_detail'])->where('_id',$id)->first();

        return view('admin.stylist.view',compact('stylist'));
    }

    public function create(Request $request)
    {
        $salonList = Salon::where('status',1)->get();
        $services = Service::where('status',1)->get();
        return view('admin.stylist.create',compact('salonList','services'));
    }

    public function store(Request $request)
    {
        $create_stylist = new User;
        $create_stylist->first_name = $request->first_name;
        $create_stylist->last_name = $request->last_name;
        $create_stylist->name = $request->first_name." ".$request->last_name;
        $create_stylist->email = $request->email;
        $create_stylist->phone_number = $request->phone_number;
        $create_stylist->salon_id = $request->salon_id;
        $create_stylist->location = $request->address;
        $create_stylist->city = $request->city;
        $create_stylist->latitude = 0;
        $create_stylist->longitude = 0;
        $create_stylist->ratings = $request->ratings;
        $create_stylist->total_revenue = numberFormat($request->total_revenue);
        $create_stylist->status = (int) $request->status;
        $create_stylist->image = null;
        $create_stylist->role = STYLIST_ROLE;
        $create_stylist->save();

        if(isset($request->services) && count($request->services) > 0)
        {
            foreach($request->services as $service)
            {
                $service_create = new StylistService;
                $service_create->stylist_id = $create_stylist->_id;
                $service_create->service_id = $service;
                $service_create->save();
            }
        }

        return redirect()->route('admin.stylist.index')->with('success','Stylist created successfully');
    }

    public function edit($id)
    {
        $salonList = Salon::where('status',1)->get();
        $stylist = User::where('_id',$id)->first();
        $serviceListArr = StylistService::where('stylist_id',$id)->pluck('service_id')->toArray();
        $services = Service::where('status',1)->get();

        return view('admin.stylist.edit',compact('salonList','stylist','serviceListArr','services'));
    }

    public function update(Request $request)
    {
        $update_stylist = User::where('_id',$request->id)->first();
        $update_stylist->first_name = $request->first_name;
        $update_stylist->last_name = $request->last_name;
        $update_stylist->name = $request->first_name." ".$request->last_name;
        $update_stylist->phone_number = $request->phone_number;
        $update_stylist->salon_id = $request->salon_id;
        $update_stylist->location = $request->address;
        $update_stylist->city = $request->city;
        $update_stylist->role = STYLIST_ROLE;
        $update_stylist->save();

        if(isset($request->services) && count($request->services) > 0)
        {
            StylistService::where('stylist_id',$request->id)->delete();
            foreach($request->services as $service)
            {
                $service_update = new StylistService;
                $service_update->stylist_id = $request->id;
                $service_update->service_id = $service;
                $service_update->save();
            }
        }

        return redirect()->route('admin.stylist.index')->with('success','Stylist updated successfully');
    }

    public function block(Request $request)
    {
        $id = $request->id;
        $stylist_update = User::where('_id',$request->id)->first();
        $stylist_update->status = 0;
        $stylist_update->save();
        return redirect()->back()->with('success','Stylist blocked successfully');
    }

    public function unblock(Request $request)
    {
        $id = $request->id;
        $stylist_update = User::where('_id',$request->id)->first();
        $stylist_update->status = 1;
        $stylist_update->save();
        return redirect()->back()->with('success','Stylist unblocked successfully');
    } 
}
