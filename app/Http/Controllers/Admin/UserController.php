<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use App\Models\User;
use App\Models\Service;
use App\Models\UserService;

class UserController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index(Request $request)
    {
        $users = User::with(['user_appointment','city_detail']);
        $users = $users->where('role',USER_ROLE);
        $users = $users->orderBy('_id','DESC')->get();
        
        return view('admin.users.index',compact('users'));
    }

    public function view($id)
    {
        $user = User::with(['user_appointment' => function($data){ 
                $data->orderBy('created_at','DESC'); 
            }])->where('_id',$id)->first();

        return view('admin.users.view',compact('user'));
    }
}
