<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Appointment;
use Auth;

class AppointmentController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index()
    {
        $appointmentsData = Appointment::with(['customer','salon','appointmentServices']);
        $appointmentsData = $appointmentsData->orderBy('_id','DESC');
        $appointmentsData = $appointmentsData->get()->toArray();

        $appointments = [];
        if(!empty($appointmentsData) && count($appointmentsData))
        {
            foreach($appointmentsData as $key => $data)
            {
                $appointments[$key] = $data;
                $appointments[$key]['total_revenue_price'] = 0;

                if(!empty($data['appointment_services']) && count($data['appointment_services']) > 0)
                {
                    foreach($data['appointment_services'] as $service)
                    {
                        $appointments[$key]['total_revenue_price'] += $service['price'];
                    }
                }
            }
        }
        return view('admin.appointment.index',compact('appointments'));
    }

    public function view($id)
    {
        $appointments = Appointment::with(['customer','salon' => function($data){ 
                            $data->with('city_detail'); 
                        },'appointmentServices'])->where('_id',$id)->first()->toArray();

        $appointment = $appointments;
        $appointment['total_revenue_price'] = 0;

        if(!empty($appointments['appointment_services']) && count($appointments['appointment_services']) > 0)
        {
            foreach($appointments['appointment_services'] as $service)
            {
                $appointment['total_revenue_price'] += $service['price'];
            }
        }
        return view('admin.appointment.view',compact('appointment'));   
    }
}
