<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use App\Models\Service;
use App\Models\Salon;
use App\Models\SalonService;

class SalonServicesController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index(Request $request)
    {
        $arr = [];
        $salons = Salon::orderBy('_id','DESC');
        if(isset($request->salon_id) && $request->salon_id != '')
        {
            $salons = $salons->where('_id',$request->salon_id);
        }
        $salons = $salons->orderBy('salon_name','ASC');
        $salons = $salons->get()->toArray();
        if(!empty($salons) && count($salons) > 0)
        {
            foreach($salons as $key => $value)
            {
                $services = SalonService::with('service_detail');
                $services = $services->where('salon_id',$value['_id']);
                $services = $services->get()->toArray();

                $arr[$key]['salon'] = $value;
                $arr[$key]['services'] = $services;
            }
        }
        $salonArray = Salon::orderBy('_id','DESC')->orderBy('salon_name','ASC')->get()->toArray();

        return view('admin.salon_services.index',compact('arr','salonArray'));
    }
}
