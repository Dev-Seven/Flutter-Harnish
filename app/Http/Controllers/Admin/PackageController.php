<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\SalonService;
use App\Models\Salon;
use App\Models\SalonPackage;
use App\Models\StylistPackageServices;
use App\Models\Service;
use Illuminate\Support\Str;
use Auth;

class PackageController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index()
    {
        $packages = SalonPackage::with(['salon_detail','services'])->get();

        return view('admin.package.index',compact('packages'));
    }

    public function create()
    {
        $services = Service::get();
        $salons = Salon::get();
        return view('admin.package.create',compact('services','salons'));
    }

    public function view($id)
    {
        $package = SalonPackage::with(['salon_detail','services'])->where('_id',$id)->first();
        return view('admin.package.view',compact('package'));
    }

    public function store(Request $request)
    {
        $user = \Auth::User();

        $new_package = new SalonPackage;
        $new_package->name = $request->package_name;
        $new_package->price = $request->price;
        $new_package->discount = $request->discount;
        $new_package->user_id = $user->_id;
        $new_package->salon_id = $request->salon;
        $new_package->service_count = count($request->services);
        $new_package->save();

        if(!empty($request->services) && count($request->services) > 0)
        {
            foreach($request->services as $key => $value)
            {
                $value = trim($value);
                $service_data = Service::where('_id',$value)->first();
                $p_service = new StylistPackageServices;
                $p_service->package_id = $new_package->_id;
                $p_service->service_id = $value;
                $p_service->service_name = $service_data->name;
                $p_service->service_price = null;
                $p_service->user_id = $user->_id;
                $p_service->save();
            }
        }
        return redirect()->route('admin.package.index')->with('success','Package added successfully');
    }

    public function delete(Request $request)
    {
        $id = $request->id;

        SalonPackage::where('_id',$id)->delete();
        StylistPackageServices::where('package_id',$id)->delete();

        return redirect()->back()->with('success','Package deleted successfully');
    }
}
