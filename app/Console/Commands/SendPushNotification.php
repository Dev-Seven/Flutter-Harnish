<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class SendPushNotification extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'reminder:appointment';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Appointment reminder code every minutes';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $date = date('Y-m-d h:i:s',strtotime('now'));
        $current_date_time_before_ten_minutes = date('Y-m-d h:i:s',strtotime('-10 minutes'));

        $current_time = utcToLocal($date);
        $before_ten =  utcToLocal($current_date_time_before_ten_minutes);

        $between_arr = [$before_ten,$current_time];

        $appointments = new \App\Models\Appointment;
        $appointments = $appointments->where('status',APPOINTMENT_ACCEPT);
        $appointments = $appointments->where('notification_ten_minutes',0);
        $appointments = $appointments->whereBetween('date_time',$between_arr);
        $appointments = $appointments->get();

        if(!empty($appointments) && count($appointments) > 0)
        {
            foreach($appointments as $key => $value)
            {
                $clientId = $value->user_id;
                $stylistId = $value->employee_id;
                $appointment_id = $value->_id;

                $clientDetail = \App\Models\User::where('_id',$clientId)->first();
                $stylistDetail = \App\Models\User::where('_id',$stylistId)->first();

                if(!empty($clientDetail)){
                    // client push send
                    $push_title = 'Appointment scheduled';
                    $push_message = 'Your appointment has been scheduled after 10 minutes with '.ucfirst($stylistDetail->name);
                    $push_data = ['appointment_id' => $appointment_id];

                    $tokenData = \App\Models\UserDeviceToken::where('user_id',$clientId)->first();
                    if(!empty($tokenData)){
                        $push_token = $tokenData->token;
                        sendPushNotification($push_title,$push_message,$push_token,$push_data);
                    }
                }

                if(!empty($stylistDetail)){
                    //stylist push send
                    $push_title = 'Appointment scheduled';
                    $push_message = 'Your appointment has been scheduled after 10 minutes with'.ucfirst($clientDetail->name);
                    $push_data = ['appointment_id' => $appointment_id];

                    $tokenData = \App\Models\UserDeviceToken::where('user_id',$clientId)->first();
                    if(!empty($tokenData)){
                        $push_token = $tokenData->token;
                        sendPushNotification($push_title,$push_message,$push_token,$push_data);
                    }
                }

                $appDetail = \App\Models\Appointment::where('_id',$appointment_id)->first();
                if(!empty($appDetail)){
                    $appDetail->notification_ten_minutes = 1;
                    $appDetail->save();
                }
            }
        }

        $date = date('Y-m-d h:i:s',strtotime('now'));
        $before_an_hour = date('Y-m-d h:i',strtotime('-1 hour'));

        $now_date_ = utcToLocal($date);
        $before_one_hour =  utcToLocal($before_an_hour);

        $between_arr_hour = [$before_one_hour,$now_date_];

        $appointmentHours = new \App\Models\Appointment;
        $appointmentHours = $appointmentHours->where('status',APPOINTMENT_ACCEPT);
        $appointmentHours = $appointmentHours->where('notification_an_hour',0);
        $appointmentHours = $appointmentHours->whereBetween('date_time',$between_arr_hour);
        $appointmentHours = $appointmentHours->get();

        if(!empty($appointmentHours) && count($appointmentHours) > 0)
        {
            foreach($appointmentHours as $key => $value)
            {
                $clientId = $value->user_id;
                $stylistId = $value->employee_id;
                $appointment_id = $value->_id;

                $clientDetail = \App\Models\User::where('_id',$clientId)->first();
                $stylistDetail = \App\Models\User::where('_id',$stylistId)->first();

                if(!empty($clientDetail)){
                    // client push send
                    $push_title = 'Appointment scheduled';
                    $push_message = 'Your appointment has been scheduled after 1 hour with '.ucfirst($stylistDetail->name);
                    $push_data = ['appointment_id' => $appointment_id];

                    $tokenData = \App\Models\UserDeviceToken::where('user_id',$clientId)->first();
                    if(!empty($tokenData)){
                        $push_token = $tokenData->token;
                        sendPushNotification($push_title,$push_message,$push_token,$push_data);
                    }
                }

                if(!empty($stylistDetail)){
                    //stylist push send
                    $push_title = 'Appointment scheduled';
                    $push_message = 'Your appointment has been scheduled after 1 hour with'.ucfirst($clientDetail->name);
                    $push_data = ['appointment_id' => $appointment_id];

                    $tokenData = \App\Models\UserDeviceToken::where('user_id',$clientId)->first();
                    if(!empty($tokenData)){
                        $push_token = $tokenData->token;
                        sendPushNotification($push_title,$push_message,$push_token,$push_data);
                    }
                }

                $appDetail = \App\Models\Appointment::where('_id',$appointment_id)->first();
                if(!empty($appDetail)){
                    $appDetail->notification_an_hour = 1;
                    $appDetail->save();
                }
            }
        }
    }
}
