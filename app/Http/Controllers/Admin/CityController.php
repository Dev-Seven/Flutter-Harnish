<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use App\Models\City;

class CityController extends Controller
{
    public function __construct()
    {
        $this->middleware(['auth']);
    }

    public function index()
    {
        $cities = City::get();
        return view('admin.city.index',compact('cities'));
    }

    public function create()
    {
        return view('admin.city.create');
    }

    public function store(Request $request)
    {
        $city_create = new City;
        $city_create->name = strtolower($request->name);
        $city_create->status = (int) $request->status;
        $city_create->save();

        return redirect()->route('admin.city.index')->with('success','City added successfully');
    }

    public function view($id)
    {
        $city = City::where('_id',$id)->first();
        return view('admin.city.view',compact('city'));
    }

    public function edit($id)
    {
        $city = City::where('_id',$id)->first();
        return view('admin.city.edit',compact('city'));
    }

    public function update(Request $request)
    {
        $city_create = City::where('_id',$request->id)->first();
        $city_create->name = strtolower($request->name);
        $city_create->status = (int) $request->status;
        $city_create->save();

        return redirect()->route('admin.city.index')->with('success','City updated successfully');
    }

    public function delete(Request $request)
    {
        $id = $request->id;
        City::where('_id',$id)->delete();

        return redirect()->route('admin.city.index')->with('success','City deleted successfully');
    }
}
