<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use App\Models\User;
use App\Models\Salon;
use App\Models\City;
use App\Models\Appointment;
use App\Models\AppointmentService;
use DB;
use Carbon\Carbon;
use MongoDB\BSON\UTCDateTime;

class DashboardController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index(Request $request)
    {
        $total_revenue        = '0';  $completed_services = '0';  $upcoming_services = '0';
        $canceled_appointment = '0';  $new_clients        = '0';  $repeated_clients  = '0';
        $total_clients        = '0';  $commision          = '0';  $registered_salon  = '0';
        $newArray1            = '';   $datesArr1          = '';   $userGraph         = '';

        $salonList = Salon::get();
        $stylistList = User::where('role',STYLIST_ROLE)->get();
        $locationList = Salon::get();
        $cities = City::get();

        return view('admin.dashboard',compact('salonList','stylistList','locationList','total_revenue','completed_services','upcoming_services','canceled_appointment','new_clients','repeated_clients','total_clients','commision','registered_salon','cities','newArray1','datesArr1','userGraph'));
    }

    public function getDBTime($value)
    {
        $value1 = date('Y-m-d H:i:s',strtotime($value));
        $date1 = localToUtc($value1);
        $date2 = Carbon::createFromFormat('Y-m-d H:i:s', $date1);
        return $date2;
    }

    public function logout()
    {
        Auth::logout();
        return redirect()->route('login')->with('success','You are logged out successfully');
    }

    public function check_email(Request $request)
    {
        $userCount = User::where('email',$request->email);
        $userCount = $userCount->count();

        if($userCount > 0)
        {
            return "false";
        } 
        else 
        {
            return "true";
        }
    }

    public function filter_location_dropdown(Request $request)
    {
        $data = [];
        $value = $request->value;

        $salon_data = Salon::select('type')->where('city',$value);
        $salon_data = $salon_data->groupBy('type')->get();
        if(!empty($salon_data) && count($salon_data))
        {
            foreach($salon_data as $key => $value)
            {
                $data[$key]['key'] = $value->type;
                $data[$key]['value'] = ucfirst($value->type);
            }
        }
        return view('admin.dashboard_type_dropdown',compact('data'));
    }

    public function filter_type_dropdown(Request $request)
    {
        $data = [];
        $type = $request->value;
        $location = $request->location;

        $salon_data = Salon::where('city',$location)->where('type',$type)->get();
        if(!empty($salon_data) && count($salon_data))
        {
            foreach($salon_data as $key => $value)
            {
                $data[$key]['key'] = $value->_id;
                $data[$key]['value'] = ucfirst($value->salon_name);
            }
        }
        return view('admin.dashboard_salon_dropdown',compact('data'));
    }

    public function filter_salon_dropdown(Request $request)
    {
        $data = [];
        $type = $request->value;
        $location = $request->location;
        $salon = $request->salon;

        $users = User::where('salon_id',$salon)->where('role',STYLIST_ROLE)->get();
        if(!empty($users) && count($users))
        {
            foreach($users as $key => $value)
            {
                $data[$key]['key'] = $value->_id;
                $data[$key]['value'] = ucfirst($value->name);
            }
        }
        return view('admin.dashboard_stylist_dropdown',compact('data'));
    }

    public function filter_dashboard(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;

        $start_date1 = date('Y-m-d H:i:s',strtotime($start_date));
        $end_date1 = date('Y-m-d H:i:s',strtotime($end_date));

        $from_date = localToUtc($start_date1);
        $to_date = localToUtc($end_date1);

        $from_date = Carbon::createFromFormat('Y-m-d H:i:s', $from_date);
        $to_date = Carbon::createFromFormat('Y-m-d H:i:s', $to_date);

        // Default value set
        $total_revenue        = '0';  $completed_services = '0';  $upcoming_services = '0';
        $canceled_appointment = '0';  $new_clients        = '0';  $repeated_clients  = '0';
        $total_clients        = '0';  $commision          = '0';

        // salon common model with date filter
        $salonModel = new Salon;
        $salonModel = $salonModel->whereBetween('created_at',[$from_date,$to_date]);
        if(isset($request->location) && $request->location != '')
        {
            $salonModel = $salonModel->where('city', $request->location);
        }
        if(isset($request->type) && $request->type != '')
        {
            $salonModel = $salonModel->where('type', $request->type);
        }
        if(isset($request->salon) && $request->salon != '')
        {
            $salonModel = $salonModel->where('_id', $request->salon);
        }
        $registered_salon = $salonModel->count();
        // registered Salon count with date filters

        // total revenue
        //$revenue_query = Salon::whereBetween('created_at',[$from_date,$to_date]);
        // $revenue_query = $revenue_query->where('created_at', '<=', $to_date);
        // if(isset($request->location) && $request->location != '')
        // {
        //     $revenue_query = $revenue_query->where('city', $request->location);
        // }
        // if(isset($request->type) && $request->type != '')
        // {
        //     $revenue_query = $revenue_query->where('type', $request->type);
        // }

        // $revenue_query = $revenue_query->get();

        // $salon_arr = [];
        // if(!empty($revenue_query) && count($revenue_query) > 0)
        // {
        //     foreach($revenue_query as $key => $value)
        //     {
        //         $salon_arr[$key] = $value->_id;
        //     }
        // }

        // $rqap = Appointment::with('appointmentServices');
        // if(isset($request->salon) && $request->salon != '')
        // {
        //     $rqap = $rqap->where('salon_id', $request->salon);
        // }
        // if(isset($request->location) && $request->location != '')
        // {
        //     $rqap = $rqap->whereIn('salon_id', $salon_arr);
        // }
        // if(isset($request->type) && $request->type != '')
        // {
        //     $rqap = $rqap->whereIn('salon_id', $salon_arr);
        // }
        // if(isset($request->stylist) && $request->stylist != '')
        // {
        //     $rqap = $rqap->where('employee_id', $request->stylist);
        // }
        // $rqap = $rqap->whereBetween('created_at',[$from_date,$to_date]);
        // $rqap = $rqap->get()->toArray();

        // if(!empty($rqap) && count($rqap) > 0)
        // {
        //     foreach($rqap as $k => $v)
        //     {
        //         $price = 0;
        //         if(!empty($v['appointment_services']) && count($v['appointment_services']) > 0)
        //         {
        //             foreach($v['appointment_services'] as $kk => $service)
        //             {
        //                 $price += $service['price'];
        //             }
        //         }
        //         $price += $price;
        //     }
        //     $total_revenue += (float)$price;
        // }

        // total revenue start


        $cityArr = [];  $cityPriceArr = [];

        $cityList = new City;
        if(isset($request->location) && $request->location != '')
        {
            $cityList = $cityList->where('_id', $request->location);
        }
        $cityList = $cityList->get();

        if(!empty($cityList) && count($cityList) > 0)
        {
            foreach($cityList as $k => $v)
            {
                $price = 0;
                $cityArr[$k] = ucfirst($v->name);

                $salonList = Salon::where('city',$v->_id);
                if(isset($request->type) && $request->type != '')
                {
                    $salonList = $salonList->where('type', $request->type);
                }
                if(isset($request->salon) && $request->salon != '')
                {
                    $salonList = $salonList->where('_id', $request->salon);
                }
                $salonList = $salonList->get();

                if(!empty($salonList) && count($salonList) > 0)
                {
                    foreach($salonList as $kk => $vv)
                    {
                        $ttlAppointment = Appointment::where('salon_id',$vv->_id);
                        $ttlAppointment = $ttlAppointment->whereBetween('created_at',[$from_date,$to_date]);
                        $ttlAppointment = $ttlAppointment->get();

                        if(!empty($ttlAppointment) && count($ttlAppointment) > 0)
                        {
                            foreach($ttlAppointment as $key => $value)
                            {
                                $apServices = AppointmentService::where('appointment_id',$value->_id)->get();
                                if(!empty($apServices) && count($apServices) > 0)
                                {
                                    foreach($apServices as $ser_key => $ser_value)
                                    {
                                        $price += $ser_value['price'];
                                    }
                                }
                            }
                        }
                    }
                }
                $cityPriceArr[$k] = $price;
            }
        }

        $total_revenue = array_sum($cityPriceArr);
        // total revenue end

        $getSalonTypeData = new Salon;
        $getSalonTypeData = $getSalonTypeData->whereBetween('created_at',[$from_date,$to_date]);
        if(isset($request->type) && $request->type != '')
        {
            $getSalonTypeData = $getSalonTypeData->where('type', $request->type);
        }
        if(isset($request->location) && $request->location != '')
        {
            $getSalonTypeData = $getSalonTypeData->where('city', $request->location);
        }
        $getSalonTypeData = $getSalonTypeData->get();
        $salonIdsArr = [];

        if(!empty($getSalonTypeData) && count($getSalonTypeData) > 0)
        {
            $salonIds = [];
            foreach($getSalonTypeData as $kk => $vv)
            {
                $salonIds[$kk] = $vv->_id;
            }
            $salonIdsArr = array_unique($salonIds);
        }

        // Canceled Appointment
        $canceled_appointment = new Appointment;
        $canceled_appointment = $canceled_appointment->whereBetween('created_at',[$from_date,$to_date]);
        if(isset($request->salon) && $request->salon != '')
        {
            $canceled_appointment = $canceled_appointment->where('salon_id', $request->salon);
        }
        if(isset($request->location) && $request->location != '')
        {
            $canceled_appointment = $canceled_appointment->whereIn('salon_id', $salonIdsArr);
        }
        if(isset($request->stylist) && $request->stylist != '')
        {
            $canceled_appointment = $canceled_appointment->where('employee_id', $request->stylist);
        }
        $canceled_appointment = $canceled_appointment->where('status',APPOINTMENT_CANCEL)->count();
        // Appointment model with date filter

        // Completed Service count
        $completed_services = new Appointment;
        $completed_services = $completed_services->whereBetween('created_at',[$from_date,$to_date]);
        if(isset($request->salon) && $request->salon != '')
        {
            $completed_services = $completed_services->where('salon_id', $request->salon);
        }
        if(isset($request->location) && $request->location != '')
        {
            $completed_services = $completed_services->whereIn('salon_id', $salonIdsArr);
        }
        if(isset($request->stylist) && $request->stylist != '')
        {
            $completed_services = $completed_services->where('employee_id', $request->stylist);
        }
        $completed_services = $completed_services->where('status',APPOINTMENT_COMPLETE)->count();

        // Upcoming services count
        $upcoming_services = new Appointment;
        $upcoming_services = $upcoming_services->whereBetween('created_at',[$from_date,$to_date]);
        if(isset($request->salon) && $request->salon != '')
        {
            $upcoming_services = $upcoming_services->where('salon_id', $request->salon);
        }
        if(isset($request->location) && $request->location != '')
        {
            $upcoming_services = $upcoming_services->whereIn('salon_id', $salonIdsArr);
        }
        if(isset($request->stylist) && $request->stylist != '')
        {
            $upcoming_services = $upcoming_services->where('employee_id', $request->stylist);
        }
        $upcoming_services = $upcoming_services->where('status',APPOINTMENT_ACCEPT)->count();
        //Upcoming Appointment count

        // Customer/User/Client Models with filter
        $CustomerModel = new User;
        $CustomerModel = $CustomerModel->where('role',USER_ROLE);
        $CustomerModel = $CustomerModel->whereBetween('created_at',[$from_date,$to_date]);
        if(isset($request->location) && $request->location != '')
        {
            $CustomerModel = $CustomerModel->where('city', $request->location);
        }
        if(isset($request->salon) && $request->salon != '')
        {
            $customerArr = [];
            $salonCustomers = new Appointment;
            if(isset($request->salon) && $request->salon != '')
            {
                $salonCustomers = $salonCustomers->where('salon_id', $request->salon);
            }
            if(isset($request->stylist) && $request->stylist != '')
            {
                $salonCustomers = $salonCustomers->where('employee_id', $request->stylist);
            }
            if(isset($request->type) && $request->type != '')
            {
                $salonCustomers = $salonCustomers->whereIn('salon_id', $salonIdsArr);
            }
            $salonCustomers = $salonCustomers->get();
            if(!empty($salonCustomers) && count($salonCustomers) > 0)
            {
                foreach($salonCustomers as $k => $v)
                {
                    $customerArr[$k] = $v->user_id;
                }
            }
            $CustomerModel = $CustomerModel->whereIn('_id', $customerArr);
        }

        // appointment count with user_id array
        $arrAppointment = [];
        $appointmentDataModel = new Appointment;
        $appointmentDataModel = $appointmentDataModel->whereBetween('created_at',[$from_date,$to_date]);
        if(isset($request->salon) && $request->salon != '')
        {
            $appointmentDataModel = $appointmentDataModel->where('salon_id', $request->salon);
        }
        if(isset($request->stylist) && $request->stylist != '')
        {
            $appointmentDataModel = $appointmentDataModel->where('employee_id', $request->stylist);
        }
        if(isset($request->type) && $request->type != '')
        {
            $appointmentDataModel = $appointmentDataModel->whereIn('salon_id', $salonIdsArr);
        }
        $appointmentDataModel = $appointmentDataModel->get();
        if(!empty($appointmentDataModel) && count($appointmentDataModel) > 0)
        {
            $appointmentArray = [];
            foreach($appointmentDataModel as $key => $value)
            {
                $countAppointment = Appointment::where('user_id',$value->user_id);
                $countAppointment = $countAppointment->whereBetween('created_at',[$from_date,$to_date]);
                if(isset($request->salon) && $request->salon != '')
                {
                    $countAppointment = $countAppointment->where('salon_id', $request->salon);
                }
                if(isset($request->location) && $request->location != '')
                {
                    $countAppointment = $countAppointment->whereIn('salon_id', $salonIdsArr);
                }
                if(isset($request->stylist) && $request->stylist != '')
                {
                    $countAppointment = $countAppointment->where('employee_id', $request->stylist);
                }
                $countAppointment = $countAppointment->count();

                $appointmentArray[$key]['user_id'] = $value['user_id'];
                $appointmentArray[$key]['count'] = $countAppointment;
            }
            $arrAppointment = array_map("unserialize", array_unique(array_map("serialize", $appointmentArray)));
        }

        // no any appointment booked clients/user/customer
        $newClientData = $CustomerModel->get();
        if(!empty($newClientData) && count($newClientData) > 0)
        {
            foreach($newClientData as $k => $v)
            {
                $appointmentCount = Appointment::where('user_id',$v->_id);
                $appointmentCount = $appointmentCount->whereBetween('created_at',[$from_date,$to_date]);
                if(isset($request->salon) && $request->salon != '')
                {
                    $appointmentCount = $appointmentCount->where('salon_id', $request->salon);
                }
                if(isset($request->location) && $request->location != '')
                {
                    $appointmentCount = $appointmentCount->whereIn('salon_id', $salonIdsArr);
                }
                if(isset($request->stylist) && $request->stylist != '')
                {
                    $appointmentCount = $appointmentCount->where('employee_id', $request->stylist);
                }
                $appointmentCount = $appointmentCount->count();

                if($appointmentCount == 0)
                {
                    $new_clients++;
                }
            }
        }

        // only single appointment booked clients/user/customer
        if(!empty($arrAppointment) && count($arrAppointment) > 0)
        {
            foreach($arrAppointment as $key => $value)
            {
                if($value['count'] == 1)
                {
                    $new_clients++;
                }
            }
        }

        // Repeated Clients
        if(!empty($arrAppointment) && count($arrAppointment) > 0)
        {
            foreach($arrAppointment as $key => $value)
            {
                if($value['count'] > 1)
                {
                    $repeated_clients++;
                }
            }
        }

        // Commission filter
        $SalonTypeData = new Salon;
        $SalonTypeData = $SalonTypeData->whereBetween('created_at',[$from_date,$to_date]);
        if(isset($request->type) && $request->type != '')
        {
            $SalonTypeData = $SalonTypeData->where('type', $request->type);
        }
        if(isset($request->location) && $request->location != '')
        {
            $SalonTypeData = $SalonTypeData->where('city', $request->location);
        }
        $SalonTypeData = $SalonTypeData->get();

        $comSalonIdsArr = [];
        if(!empty($SalonTypeData) && count($SalonTypeData) > 0)
        {
            $csalonIds = [];
            foreach($SalonTypeData as $kk => $vv)
            {
                $csalonIds[$kk] = $vv->_id;
            }
            $comSalonIdsArr = array_unique($salonIds);
        }

        $CommissionModel = new Appointment;
        $CommissionModel = $CommissionModel->whereBetween('created_at',[$from_date,$to_date]);
        if(isset($request->type) && $request->type != '')
        {
            $CommissionModel = $CommissionModel->whereIn('salon_id', $comSalonIdsArr);
        }
        if(isset($request->location) && $request->location != '')
        {
            $CommissionModel = $CommissionModel->whereIn('salon_id', $comSalonIdsArr);
        }
        if(isset($request->salon) && $request->salon != '')
        {
            $CommissionModel = $CommissionModel->where('salon_id', $request->salon);
        }
        if(isset($request->stylist) && $request->stylist != '')
        {
            $CommissionModel = $CommissionModel->where('employee_id', $request->stylist);
        }
        $CommissionModel = $CommissionModel->get()->toArray();

        if(!empty($CommissionModel) && count($CommissionModel) > 0)
        {
            foreach($CommissionModel as $com => $commisiona)
            {
                if(isset($commisiona['admin_commission']) && $commisiona['admin_commission'] != '')
                {
                    $commision = $commision + (float) $commisiona['admin_commission'];
                }
                else
                {
                    $commision = $commision + 0;
                }
            }
        }

        // Total Clients
        $total_clients = $new_clients + $repeated_clients;
        // chart integration code Start
        $from_date = Carbon::createFromFormat('Y-m-d H:i:s', $from_date);
        $to_date = Carbon::createFromFormat('Y-m-d H:i:s', $to_date);

        $today = date('Y-m-d',strtotime($to_date));
        $lastthirty = date('Y-m-d',strtotime($from_date));
        $dates = $this->date_range($lastthirty,$today, "+1 day", "Y-m-d");

        $activeSalon = []; $newSalon = []; $totalSalon = [];
        $newUser = []; $repeatedUser = []; $totalUser = [];

        foreach($dates as $key => $date)
        {
            $from_date = $this->getDBTime($date." 00:00:00");
            $to_date = $this->getDBTime($date." 23:59:59");

            // Salon Graph data start
            $salons = Salon::whereBetween('created_at',[$from_date,$to_date]);
            if(isset($request->type) && $request->type != '')
            {
                $salons = $salons->where('type', $request->type);
            }
            if(isset($request->location) && $request->location != '')
            {
                $salons = $salons->where('city', $request->location);
            }
            if(isset($request->salon) && $request->salon != '')
            {
                $salons = $salons->where('_id', $request->salon);
            }
            $salons = $salons->get();

            $asCount = 0; $nsCount = 0; $totalCount = 0;
            $datesArr[$key] = date('d',strtotime($date));
            foreach($salons as $k => $v)
            {
                $apCount = Appointment::where('salon_id',$v->_id);
                if(isset($request->stylist) && $request->stylist != '')
                {
                    $apCount = $apCount->where('employee_id', $request->stylist);
                }
                $apCount = $apCount->count();
                if($apCount > 0)
                {
                    $asCount++;
                }
                else
                {
                    $nsCount++;
                }
            }
            $totalCount = $asCount + $nsCount;

            $activeSalon[$key] = $asCount;
            $newSalon[$key] = $nsCount;
            // Salon Graph data End

            // User Graph Data start

            // This array for type city filters $salonIdsArr
            $users = User::where('role',USER_ROLE);
            $users = $users->whereBetween('created_at',[$from_date,$to_date]);
            if(isset($request->location) && $request->location != '')
            {
                $users = $users->where('city', $request->location);
            }
            if((isset($request->salon) && $request->salon != '') || (isset($request->type) && $request->type != ''))
            {
                $customerArr = [];
                $appointments = new Appointment;
                if(isset($request->salon) && $request->salon != '')
                {
                    $appointments = $appointments->where('salon_id', $request->salon);
                }
                if(isset($request->stylist) && $request->stylist != '')
                {
                    $appointments = $appointments->where('employee_id', $request->stylist);
                }
                if(isset($request->type) && $request->type != '')
                {
                    $appointments = $appointments->whereIn('salon_id', $salonIdsArr);
                }
                $appointments = $appointments->get();
                if(!empty($appointments) && count($appointments) > 0)
                {
                    foreach($appointments as $k => $v)
                    {
                        $customerArr[$k] = $v->user_id;
                    }
                }
                $users = $users->whereIn('_id', $customerArr);
            }
            $users = $users->get();

            $newUserCount = 0; $oldUserCount = 0; $totalUserCount = 0;
            foreach($users as $kk => $vv)
            {
                $userAppCount = Appointment::where('user_id',$vv->_id)->count();
                if($userAppCount > 1)
                {
                    $oldUserCount++;
                }
                else
                {
                    $newUserCount++;
                }
            }
            $totalUserCount = $oldUserCount + $newUserCount;

            $repeatedUser[$key] = $oldUserCount;
            $newUser[$key] = $newUserCount;
            $totalUser[$key] = $totalUserCount;
        }
        // User Graph Data End

        // Salon Graph encode and implode
        $newarrImplode = implode(',', $newSalon);
        $activearrImplode = implode(',', $activeSalon);

        $salonArr[0]['label'] = 'New';
        $salonArr[0]['data'] = $newSalon;
        $salonArr[0]['fill'] = false;
        $salonArr[0]['borderColor'] = '#2196f3';
        $salonArr[0]['backgroundColor'] = '#2196f3';
        $salonArr[0]['borderWidth'] = true;

        $salonArr[1]['label'] = 'Active';
        $salonArr[1]['data'] = $activeSalon;
        $salonArr[1]['fill'] = false;
        $salonArr[1]['borderColor'] = 'red';
        $salonArr[1]['backgroundColor'] = 'red';
        $salonArr[1]['borderWidth'] = true;

        $newArray1 = json_encode($salonArr);
        $datesArr1 = implode(',', $datesArr);

        // user graph encode and implode graph
        $newUser1 = implode(',', $newUser);
        $repeatedUser1 = implode(',', $repeatedUser);
        $totalUser1 = implode(',', $totalUser);

        $userArrGraph[0]['label'] = 'New';
        $userArrGraph[0]['data'] = $newUser;
        $userArrGraph[0]['fill'] = false;
        $userArrGraph[0]['borderColor'] = '#2196f3';
        $userArrGraph[0]['backgroundColor'] = '#2196f3';
        $userArrGraph[0]['borderWidth'] = true;

        $userArrGraph[1]['label'] = 'Repeated';
        $userArrGraph[1]['data'] = $repeatedUser;
        $userArrGraph[1]['fill'] = false;
        $userArrGraph[1]['borderColor'] = 'red';
        $userArrGraph[1]['backgroundColor'] = 'red';
        $userArrGraph[1]['borderWidth'] = true;

        $userArrGraph[2]['label'] = 'Total';
        $userArrGraph[2]['data'] = $totalUser;
        $userArrGraph[2]['fill'] = false;
        $userArrGraph[2]['borderColor'] = 'green';
        $userArrGraph[2]['backgroundColor'] = 'green';
        $userArrGraph[2]['borderWidth'] = true;

        $userGraph = json_encode($userArrGraph);

        // Total Revenue data report Start
        $start_date = $request->start_date;
        $end_date = $request->end_date;

        $start_date1 = date('Y-m-d H:i:s',strtotime($start_date));
        $end_date1 = date('Y-m-d H:i:s',strtotime($end_date));

        $from_date = localToUtc($start_date1);
        $to_date = localToUtc($end_date1);

        $from_date = Carbon::createFromFormat('Y-m-d H:i:s', $from_date);
        $to_date = Carbon::createFromFormat('Y-m-d H:i:s', $to_date);

        $cityArr = [];  $cityPriceArr = [];

        $cityList = new City;
        if(isset($request->location) && $request->location != '')
        {
            $cityList = $cityList->where('_id', $request->location);
        }
        $cityList = $cityList->get();
        if(!empty($cityList) && count($cityList) > 0)
        {
            foreach($cityList as $k => $v)
            {
                $price = 0;
                $cityArr[$k] = ucfirst($v->name);

                $salonList = Salon::where('city',$v->_id);
                if(isset($request->type) && $request->type != '')
                {
                    $salonList = $salonList->where('type', $request->type);
                }
                if(isset($request->salon) && $request->salon != '')
                {
                    $salonList = $salonList->where('_id', $request->salon);
                }
                $salonList = $salonList->get();
                if(!empty($salonList) && count($salonList) > 0)
                {
                    foreach($salonList as $kk => $vv)
                    {
                        $ttlAppointment = Appointment::where('salon_id',$vv->_id);
                        $ttlAppointment = $ttlAppointment->whereBetween('created_at',[$from_date,$to_date]);
                        $ttlAppointment = $ttlAppointment->get();
                        if(!empty($ttlAppointment) && count($ttlAppointment) > 0)
                        {
                            foreach($ttlAppointment as $key => $value)
                            {
                                $apServices = AppointmentService::where('appointment_id',$value->_id);
                                $apServices = $apServices->get();
                                if(!empty($apServices) && count($apServices) > 0)
                                {
                                    foreach($apServices as $ser_key => $ser_value)
                                    {
                                        $price += $ser_value['price'];
                                    }
                                }
                            }
                        }
                    }
                }
                $cityPriceArr[$k] = $price;
            }
        }

        $totalRevenueGraph = [];
        if(!empty($cityArr) && count($cityArr))
        {
            $cityImplode = implode(', ',$cityArr);
            $amountImplode = implode(' ', $cityPriceArr);

            $totalRevenueGraph['labels'] = $cityArr;
            $totalRevenueGraph['datasets'][0]['label'] = 'Total Revenue';
            $totalRevenueGraph['datasets'][0]['data'] = $cityPriceArr;
            $totalRevenueGraph['datasets'][0]['fill'] = false;
            $totalRevenueGraph['datasets'][0]['borderColor'] = '#2196f3';
            $totalRevenueGraph['datasets'][0]['backgroundColor'] = '#2196f3';
            $totalRevenueGraph['datasets'][0]['borderWidth'] = 1;
        }
        $total_revenue_graph = json_encode($totalRevenueGraph);
        // Total Revenue data report End

        return view('admin.dashboard_append',compact('total_revenue','completed_services','upcoming_services','canceled_appointment','new_clients','repeated_clients','total_clients','commision','registered_salon','newArray1','datesArr1','userGraph','total_revenue_graph'));
    }

    public function date_range($first, $last, $step = '+1 day', $output_format = 'd/m/Y' )
    {
        $dates = array();
        $current = strtotime($first);
        $last = strtotime($last);

        while( $current <= $last )
        {
            $dates[] = date($output_format, $current);
            $current = strtotime($step, $current);
        }
        return $dates;
    }
}
