<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use App\Models\ServiceRequest;
use App\Models\Service;
use App\Models\StylistService;

class ServiceRequestController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index()
    {
        $requests = ServiceRequest::with(['stylist'])->orderBy('_id','DESC')->get();
        return view('admin.service_request.index',compact('requests'));
    }
    public function accept($id)
    {
        $requestData = ServiceRequest::where('_id',$id)->first();
        if(!empty($requestData))
        {
            $requestData->status = 2;
            $requestData->save();

            $checkService = Service::where('name',$requestData->service_name)->count();
            if($checkService > 0) 
            {
                return redirect()->back()->with('danger','Service already added in list');
            } 
            else 
            {
                $ServiceAdd = new Service;
                $ServiceAdd->name = $requestData->service_name;
                $ServiceAdd->status = 1;
                $ServiceAdd->save();

                // Service added in stylist list with 0 price
                $new_service_for_stylist = new StylistService;
                $new_service_for_stylist->user_id = $requestData->stylist_id;
                $new_service_for_stylist->service_id = $ServiceAdd->_id;
                $new_service_for_stylist->service_name = $ServiceAdd->service_name;
                $new_service_for_stylist->service_price = 0;
                $new_service_for_stylist->save();

                return redirect()->back()->with('success','Request approved Successfully');
            }
        } 
        else 
        {
            return redirect()->back()->with('danger','Request not found');
        }
    }

    public function rejected($id)
    {
        $requestData = ServiceRequest::where('_id',$id)->first();
        if(!empty($requestData))
        {
            $requestData->status = 3;
            $requestData->save();

            return redirect()->back()->with('danger','Request has been rejected');
        } else {
            return redirect()->back()->with('danger','Request not found');
        }
    }
}
