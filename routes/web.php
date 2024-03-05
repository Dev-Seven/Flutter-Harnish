<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function(){
	return view('welcome');
});

Route::group(['middleware' => 'guest'], function ($router) {

	Route::get('/login', 'LoginController@index')->name('login');
	Route::post('/login/submit', 'LoginController@submit')->name('login.submit');
	Route::get('/forgot-password', 'ForgotpasswordController@index')->name('forgot_password');
	Route::post('/forgot-password/submit', 'ForgotpasswordController@submit')->name('forgot_password.submit');
	
	Route::get('/reset-password/{token}', 'ForgotpasswordController@reset_password')->name('auth.reset_password');
	Route::post('/password/submit', 'ForgotpasswordController@password_submit')->name('password.submit');
});

Route::group(['middleware' => 'auth', 'namespace' => 'Admin' , 'prefix' => 'admin'], function ($router) {

	Route::get('/home', 'DashboardController@index')->name('admin.dashboard');
	Route::post('/append', 'DashboardController@dashboard_append')->name('admin.dashboard.append');
	Route::get('/logout', 'DashboardController@logout')->name('admin.logout');
	Route::post('/filter', 'DashboardController@filter_dashboard')->name('admin.dashboard.filter_dashboard');
	Route::post('/dropdown/location', 'DashboardController@filter_location_dropdown')->name('admin.dashboard.filter_location_dropdown');
	Route::post('/dropdown/type', 'DashboardController@filter_type_dropdown')->name('admin.dashboard.filter_type_dropdown');
	Route::post('/dropdown/salon', 'DashboardController@filter_salon_dropdown')->name('admin.dashboard.filter_salon_dropdown');
	
	Route::get('/check/email', 'DashboardController@check_email');
	Route::get('/flush/data', 'FlushController@flush_data');
	
	Route::group(['prefix' => 'cms'], function ($router) {
		Route::get('/', 'CmsController@index')->name('admin.cms.index');
		Route::get('/create', 'CmsController@create')->name('admin.cms.create');
		Route::post('/store', 'CmsController@store')->name('admin.cms.store');
		Route::post('/delete', 'CmsController@delete')->name('admin.cms.delete');
		Route::get('/view/{id}', 'CmsController@view')->name('admin.cms.view');
		Route::get('/edit/{id}', 'CmsController@edit')->name('admin.cms.edit');
		Route::post('/update', 'CmsController@update')->name('admin.cms.update');
	});

	Route::group(['prefix' => 'city'], function ($router) {
		Route::get('/', 'CityController@index')->name('admin.city.index');
		Route::get('/create', 'CityController@create')->name('admin.city.create');
		Route::post('/store', 'CityController@store')->name('admin.city.store');
		Route::post('/delete', 'CityController@delete')->name('admin.city.delete');
		Route::get('/edit/{id}', 'CityController@edit')->name('admin.city.edit');
		Route::post('/update', 'CityController@update')->name('admin.city.update');
	});

	Route::group(['prefix' => 'profile'], function ($router) {
		Route::get('/', 'ProfileController@profile')->name('admin.profile.index');
		Route::post('/update', 'ProfileController@profile_update')->name('admin.profile.update');
	});

	Route::group(['prefix' => 'change-password'], function ($router) {
		Route::get('/','ProfileController@change_password')->name('admin.change_password');
		Route::post('/update', 'ProfileController@change_password_submit')->name('admin.change_password.update');
	});

	Route::group(['prefix' => 'support'], function ($router) {
		Route::get('/', 'SupportController@index')->name('admin.support.index');
		Route::post('/submit', 'SupportController@support_update')->name('admin.support.support_update');
	});

	Route::group(['prefix' => 'rating/stylist'], function ($router) {
		Route::get('/', 'RatingController@StylistRatingList')->name('admin.rating.stylist');
	});

	Route::group(['prefix' => 'rating/client'], function ($router) {
		Route::get('/', 'RatingController@ClientRatingList')->name('admin.rating.client');
	});

	Route::group(['prefix' => 'service'], function ($router) {
		Route::get('/', 'ServiceController@index')->name('admin.service.index');
		Route::get('/create', 'ServiceController@create')->name('admin.service.create');
		Route::post('/store', 'ServiceController@store')->name('admin.service.store');
		Route::post('/delete', 'ServiceController@delete')->name('admin.service.delete');
		Route::get('/edit/{id}', 'ServiceController@edit')->name('admin.service.edit');
		Route::post('/update', 'ServiceController@update')->name('admin.service.update');
	});

	Route::group(['prefix' => 'service-request'], function ($router) {
		Route::get('/', 'ServiceRequestController@index')->name('admin.service_request.index');
		Route::get('/{id}/accept', 'ServiceRequestController@accept')->name('admin.service_request.accept');
		Route::get('/{id}/reject', 'ServiceRequestController@rejected')->name('admin.service_request.rejected');
	});

	Route::group(['prefix' => 'salon'], function ($router) {
		Route::get('/', 'SalonController@index')->name('admin.salon.index');
		Route::get('/view/{id}', 'SalonController@view')->name('admin.salon.view');
		Route::get('/create', 'SalonController@create')->name('admin.salon.create');
		Route::post('/store', 'SalonController@store')->name('admin.salon.store');
		Route::post('/block', 'SalonController@block')->name('admin.salon.block');
		Route::post('/unblock', 'SalonController@unblock')->name('admin.salon.unblock');
		Route::get('/edit/{id}', 'SalonController@edit')->name('admin.salon.edit');
		Route::post('/update', 'SalonController@update')->name('admin.salon.update');
	});

	Route::group(['prefix' => 'appointment'], function ($router) {
		Route::get('/', 'AppointmentController@index')->name('admin.appointment.index');
		Route::get('/view/{id}', 'AppointmentController@view')->name('admin.appointment.view');
	});

	Route::group(['prefix' => 'stylist'], function ($router) {
		Route::get('/', 'StylistController@index')->name('admin.stylist.index');
		Route::get('/view/{id}', 'StylistController@view')->name('admin.stylist.view');
		Route::get('/create', 'StylistController@create')->name('admin.stylist.create');
		Route::post('/store', 'StylistController@store')->name('admin.stylist.store');
		Route::post('/block', 'StylistController@block')->name('admin.stylist.block');
		Route::post('/unblock', 'StylistController@unblock')->name('admin.stylist.unblock');
		Route::get('/edit/{id}', 'StylistController@edit')->name('admin.stylist.edit');
		Route::post('/update', 'StylistController@update')->name('admin.stylist.update');
	});

	Route::group(['prefix' => 'package'], function ($router) {
		Route::get('/', 'PackageController@index')->name('admin.package.index');
		Route::get('/create', 'PackageController@create')->name('admin.package.create');
		Route::post('/store', 'PackageController@store')->name('admin.package.store');
		Route::get('/view/{id}', 'PackageController@view')->name('admin.package.view');
		Route::post('/delete', 'PackageController@delete')->name('admin.package.delete');
	});

	Route::group(['prefix' => 'users'], function ($router) {
		Route::get('/', 'UserController@index')->name('admin.users.index');
		Route::get('/view/{id}', 'UserController@view')->name('admin.users.view');
		Route::get('/create', 'UserController@create')->name('admin.users.create');
		Route::post('/store', 'UserController@store')->name('admin.users.store');
	});

	Route::group(['prefix' => 'salon-services'], function ($router) {
		Route::get('/', 'SalonServicesController@index')->name('admin.salon_services.index');
	});
});
