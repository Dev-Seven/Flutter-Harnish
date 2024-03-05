<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use App\Models\Service;

class ServiceController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index()
    {
        $services = Service::get();
        return view('admin.service.index',compact('services'));
    }

    public function create()
    {
        return view('admin.service.create');
    }

    public function store(Request $request)
    {
        $service_create = new Service;
        $service_create->name = strtolower($request->name);
        $service_create->status = (int) $request->status;
        $service_create->save();

        return redirect()->route('admin.service.index')->with('success','Service added successfully');
    }

    public function view($id)
    {
        $service = Service::where('_id',$id)->first();
        return view('admin.service.view',compact('service'));
    }

    public function edit($id)
    {
        $service = Service::where('_id',$id)->first();
        return view('admin.service.edit',compact('service'));
    }

    public function update(Request $request)
    {
        $service_update = Service::where('_id',$request->id)->first();
        $service_update->name = strtolower($request->name);
        $service_update->status = (int) $request->status;
        $service_update->save();

        return redirect()->route('admin.service.index')->with('success','Service updated successfully');
    }

    public function delete(Request $request)
    {
        $id = $request->id;
        Service::where('_id',$id)->delete();

        return redirect()->route('admin.service.index')->with('success','Service deleted successfully');
    }
}
