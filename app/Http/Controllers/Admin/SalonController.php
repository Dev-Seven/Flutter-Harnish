<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use App\Models\Service;
use App\Models\Salon;
use App\Models\City;
use App\Models\SalonService;
use App\Models\User;

class SalonController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index(Request $request)
    {
        $salons = Salon::with(['services','city_detail']);
        if(isset($request->type) && $request->type != '') 
        {
            $salons = $salons->where('type',$request->type);
        }
        if(isset($request->city) && $request->city != '') 
        {
            $salons = $salons->where('city',$request->city);
        }
        if(isset($request->rate) && $request->rate != '') 
        {
            if($request->rate != '0')
            {
                $salons = $salons->where('ratings',(int)$request->rate);
            } 
            else 
            {
                $salons = $salons->where('ratings',0);
            }
        }
        $salons = $salons->orderBy('_id','DESC')->get();
        $cities = City::where('status',1)->get();

        return view('admin.salon.index',compact('salons','cities'));
    }

    public function create()
    {
        $services = Service::where('status','1')->get();
        $cities = City::where('status','1')->get();
        return view('admin.salon.create',compact('services','cities'));
    }

    public function store(Request $request)
    {
        // create new user
        $StylistCreate = new User;
        $StylistCreate->first_name = $request->owner_name;
        $StylistCreate->last_name = null;
        $StylistCreate->name = $request->owner_name;
        $StylistCreate->email = $request->email;
        $StylistCreate->phone_number = $request->phone_number;
        $StylistCreate->status = (int) $request->status;
        $StylistCreate->role = SALON_ROLE;
        $StylistCreate->is_confirm = 0;
        $StylistCreate->ratings = 0;
        $StylistCreate->total_revenue = numberFormat("0");
        $StylistCreate->save();

        // salon create
        $create_salon = new Salon;
        $create_salon->salon_name = $request->salon_name;
        $create_salon->owner_name = $request->owner_name;
        $create_salon->user_id = $StylistCreate->_id;
        $create_salon->email = $request->email;
        $create_salon->phone_number = $request->phone_number;
        $create_salon->address = $request->address;
        $create_salon->city = $request->city;
        $create_salon->type = $request->type;
        $create_salon->status = (int) $request->status;
        $create_salon->commission = $request->commission;
        $create_salon->ratings = 0;
        $create_salon->total_revenue = numberFormat("0");
        $create_salon->save();

        $findStylist = User::where('_id',$StylistCreate->_id)->first();
        $findStylist->parent_id = 0;
        $findStylist->salon_id = $create_salon->_id;
        $findStylist->save();

        return redirect()->route('admin.salon.index')->with('success','Salon added successfully');
    }

    public function view($id)
    {
        $salon = Salon::with(['city_detail','salon_images','services' => function($data){ 
            $data->with('service_detail'); 
        }])->where('_id',$id)->first();
        
        return view('admin.salon.view',compact('salon'));
    }

    public function edit($id)
    {
        $salon = Salon::with('services','city_detail')->where('_id',$id)->first();
        $services = Service::where('status',1)->get();
        $cities = City::where('status',1)->get();
        $service_ids = SalonService::where('salon_id',$id)->pluck('service_id')->toArray();

        return view('admin.salon.edit',compact('salon','services','service_ids','cities'));
    }

    public function update(Request $request)
    {
        $salon_update = Salon::where('_id',$request->id)->first();
        $salon_update->salon_name = $request->salon_name;
        $salon_update->owner_name = $request->owner_name;
        $salon_update->phone_number = $request->phone_number;
        $salon_update->address = $request->address;
        $salon_update->city = $request->city;
        $salon_update->status = (int) $request->status;
        $salon_update->type = $request->type;
        $salon_update->commission = $request->commission;
        $salon_update->save();

        // if(isset($request->services) && count($request->services) > 0)
        // {
        //     SalonService::where('salon_id',$request->id)->delete();
        //     foreach($request->services as $service)
        //     {
        //         $serviceDetail = Service::where('_id',$service)->first();
        //         $salon_service_create = new SalonService;
        //         $salon_service_create->salon_id = $request->id;
        //         $salon_service_create->service_id = $service;
        //         $salon_service_create->service_name = $serviceDetail->name;
        //         $salon_service_create->save();
        //     }
        // }

        return redirect()->route('admin.salon.index')->with('success','Salon updated successfully');
    }

    public function block(Request $request)
    {
        $id = $request->id;
        $salon_update = Salon::where('_id',$request->id)->first();
        $salon_update->status = 0;
        $salon_update->save();
        return redirect()->back()->with('success','Salon blocked successfully');
    }

    public function unblock(Request $request)
    {
        $id = $request->id;
        $salon_update = Salon::where('_id',$request->id)->first();
        $salon_update->status = 1;
        $salon_update->save();
        return redirect()->back()->with('success','Salon unblocked successfully');
    }

    public function delete(Request $request)
    {
        $id = $request->id;
        Salon::where('_id',$id)->delete();

        return redirect()->route('admin.salon.index')->with('success','Salon deleted successfully');
    }
}
