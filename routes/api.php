<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

//Common urls and routes for both users (Clients and Salons)
Route::post('register', 'Api\RegisterController@register');
Route::post('client-register', 'Api\RegisterController@customerRegistration');
Route::post('login', 'Api\LoginController@login');
Route::post('verify_otp', 'Api\RegisterController@verify_otp');

Route::post('forgot_password', 'Api\ForgotpasswordController@forgot_password');
Route::post('check_otp', 'Api\ForgotpasswordController@check_otp');
Route::post('submit_reset_password', 'Api\ForgotpasswordController@password_submit');
Route::post('resend_otp', 'Api\RegisterController@resend_otp');

//Support data structure for support mail and contact details
Route::post('support_data', 'Api\SupportController@index');
Route::post('logout', 'Api\CommonController@logout');
Route::post('cms_page', 'Api\CmsController@cms_page');
Route::post('city', 'Api\CommonController@cityList');
Route::post('activate_status', 'Api\CommonController@activate_status');


Route::post('services', 'Api\CommonController@servicesList');
Route::post('graph', 'Api\GraphController@index');

Route::group(['namespace' => 'Api', 'prefix' => 'notification'], function ($router) {
    Route::post('status', 'NotificationController@onOffSwitch');
});

// client routes started
Route::group(['namespace' => 'Api\Client', 'prefix' => 'client'], function ($router) {

    Route::post('get_profile', 'ProfileController@getProfile');
    Route::post('edit_profile', 'ProfileController@update_profile');
    Route::post('upload_images', 'ProfileController@uploadImages');
    Route::post('add-rating', 'RatingController@addRatings');
    
    Route::post('recommended-stylist', 'SalonController@recommendedStylist');
    
    Route::post('package', 'SalonController@packages');

    Route::group(['prefix' => 'salon'], function ($router) {
        Route::post('list', 'SalonController@list');
        Route::post('detail', 'SalonController@shopDetail');
        Route::post('last-visited', 'SalonController@lastVisitedSalon');
        Route::post('top-rated', 'SalonController@topRatedSalon');
    });

    Route::group(['prefix' => 'appointment'], function ($router) {
        Route::post('booked', 'AppointmentController@bookAppointment');
        Route::post('list', 'AppointmentController@appointmentList');
        Route::post('detail', 'AppointmentController@appointmentDetail');
    });
});
// client routes ended

// Stylist routes started
Route::group(['namespace' => 'Api\Stylist', 'prefix' => 'stylist'], function ($router) {

    Route::post('get_profile', 'ProfileController@getProfile');
    Route::post('edit_profile', 'ProfileController@update_profile');
    Route::post('update_profile', 'ProfileController@update_profile');
    Route::post('upload_images', 'ProfileController@uploadImages');
    Route::post('upload_logo', 'ProfileController@uploadLogo');

    // Customer rating add
    Route::post('add-rating', 'RatingController@addRatings');

    Route::group(['prefix' => 'service'], function ($router) {

    	Route::post('list', 'ServiceController@service_list');
    	Route::post('create', 'ServiceController@create_service');
    	Route::post('edit', 'ServiceController@edit_service');
    	Route::post('delete', 'ServiceController@delete_service');
    	Route::post('service-request', 'ServiceController@service_request');
    	Route::post('get-requested-services', 'ServiceController@getRequestedServices');
    });

    Route::group(['prefix' => 'package'], function ($router) {

        Route::post('list', 'PackageController@list');
        Route::post('create', 'PackageController@create');
        // Route::post('edit', 'PackageController@edit');
        Route::post('delete', 'PackageController@delete');
    });

    Route::group(['prefix' => 'employee'], function ($router) {

        Route::post('list', 'EmployeeController@employee_list');
        Route::post('create', 'EmployeeController@create_employee');
        Route::post('detail', 'EmployeeController@detail_employee');
        Route::post('edit', 'EmployeeController@edit_employee');
        Route::post('delete', 'EmployeeController@delete_employee');
        Route::post('varification', 'EmployeeController@employeeVarification');
    });

    Route::group(['prefix' => 'address'], function ($router) {

        Route::post('detail', 'ShopController@shop_detail');
        Route::post('update', 'ShopController@update_shop');
    });

    Route::group(['prefix' => 'appointment'], function ($router) {

        Route::post('list', 'AppointmentController@appointmentList');
        Route::post('detail', 'AppointmentController@appointmentDetail');
        Route::post('accept', 'AppointmentController@appointmentAccept');
        Route::post('cancel', 'AppointmentController@cancelAppointment');
        Route::post('on-going', 'AppointmentController@onGoingAppointment');
        Route::post('start', 'AppointmentController@startAppointment');
        Route::post('complete', 'AppointmentController@completeAppointment');

        Route::post('change-status', 'AppointmentController@appointmentStatusChange');
        
    });
});
// Stylist routes ended