<?php

$route_name = \Request::route()->getName();
$logged_user = \Auth::User();
?>
<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <a href="{{route('admin.dashboard')}}" class="brand-link">
        <img src="{{asset('img/logo.png')}}" alt="{{env('APP_NAME')}}" class="brand-image img-circle elevation-3">
        <span class="brand-text font-weight-light">{{env('APP_NAME')}}</span>
    </a>
    <div class="sidebar">
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <div class="image">

                @if($logged_user->image != '' && file_exists(public_path('users/'.$logged_user->image)))
                <img src="{{asset('users/'.$logged_user->image)}}" style="height: 40px; width: 40px;" alt="Profile Picture" class="img-circle elevation-2" />
                @else
                <img src="{{asset('users/avatar.jpg')}}" alt="Profile Picture" class="img-circle elevation-2" />
                @endif
            </div>
            <div class="info">
                <span class="d-block" style="color: #fff;">{{ucfirst(\Auth::User()->name)}}</span>
            </div>
        </div>
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                <li class="nav-item">
                    <?php
                    $dashboard_active = '';
                    if(in_array($route_name, ['admin.dashboard'])){
                        $dashboard_active = 'active';
                    }
                    ?>
                    <a href="{{route('admin.dashboard')}}" class="nav-link {{$dashboard_active}}">
                        <i class="nav-icon fas fa-home"></i>
                        <p>Home</p>
                    </a>
                </li>
                <li class="nav-item">
                    <?php
                    $salon_active = '';
                    if(in_array($route_name, ['admin.salon.index','admin.salon.create','admin.salon.edit','admin.salon.view'])){ $salon_active = 'active'; }
                    ?>

                    <a href="{{route('admin.salon.index')}}" class="nav-link {{$salon_active}}">
                        <i class="nav-icon fa fa-industry"></i>
                        <p>Salon List</p>
                    </a>
                </li>
                <li class="nav-item">
                    <?php
                    $stylist_active = '';
                    if(in_array($route_name, ['admin.stylist.index','admin.stylist.create','admin.stylist.edit','admin.stylist.view'])){ $stylist_active = 'active'; }
                    ?>

                    <a href="{{route('admin.stylist.index')}}" class="nav-link {{$stylist_active}}">
                        <i class="nav-icon fa fa-users"></i>
                        <p>Salon Stylists List</p>
                    </a>
                </li>
                <li class="nav-item">
                    <?php
                    $user_active = '';
                    if(in_array($route_name, ['admin.users.index','admin.users.create','admin.users.view'])){ $user_active = 'active'; }
                    ?>

                    <a href="{{route('admin.users.index')}}" class="nav-link {{$user_active}}">
                        <i class="nav-icon fa fa-users"></i>
                        <p>Users List</p>
                    </a>
                </li>
                <li class="nav-item">
                    <?php 
                    $appointment_active = '';
                    if(in_array($route_name, ['admin.appointment.index','admin.appointment.view'])){
                        $appointment_active = 'active';
                    }
                    ?>

                    <a href="{{route('admin.appointment.index')}}" class="nav-link {{$appointment_active}}">
                        <i class="nav-icon far fa-calendar-check"></i>
                        <p>Appointment List</p>
                    </a>
                </li>
                <!-- <li class="nav-item"> -->
                    <?php
                    $salon_services_active = '';
                    // if(in_array($route_name, ['admin.salon_services.index'])){
                    //     $salon_services_active = 'active';
                    // }
                    ?>

                    <!-- <a href="{{route('admin.salon_services.index')}}" class="nav-link {{$salon_services_active}}">
                        <i class="nav-icon fa fa-list-alt"></i>
                        <p>Salon Services List</p>
                    </a>
                </li> -->

                <li class="nav-item">
                    <?php
                    $service__request_active = '';
                    if(in_array($route_name, ['admin.service_request.index'])){
                        $service__request_active = 'active';
                    }
                    ?>

                    <a href="{{route('admin.service_request.index')}}" class="nav-link {{$service__request_active}}">
                        <i class="nav-icon fa fa-paper-plane"></i>
                        <p>Service Requests</p>
                    </a>
                </li>
                <li class="nav-item">
                    <?php
                    $service_active = '';
                    if(in_array($route_name, ['admin.service.index','admin.service.create','admin.service.edit'])){
                        $service_active = 'active';
                    }
                    ?>

                    <a href="{{route('admin.service.index')}}" class="nav-link {{$service_active}}">
                        <i class="nav-icon fa fa-list-alt"></i>
                        <p>Service Master</p>
                    </a>
                </li>
                <li class="nav-item">
                    <?php
                    $package_active = '';
                    if(in_array($route_name, ['admin.package.index','admin.package.create'])){
                        $package_active = 'active';
                    }
                    ?>
                    <a href="{{route('admin.package.index')}}" class="nav-link {{$package_active}}">
                        <i class="nav-icon fa fa-list-alt"></i>
                        <p>Package Master</p>
                    </a>
                </li>
                <li class="nav-item">
                    <?php 
                    $city_active = '';
                    if(in_array($route_name, ['admin.city.index','admin.city.create','admin.city.edit'])){
                        $city_active = 'active';
                    }
                    ?>

                    <a href="{{route('admin.city.index')}}" class="nav-link {{$city_active}}">
                        <i class="nav-icon fas fa-city"></i>
                        <p>City Master</p>
                    </a>
                </li>
                <li class="nav-item">
                    <?php
                    $cms_active = '';
                    if(in_array($route_name, ['admin.cms.index','admin.cms.create','admin.cms.edit','admin.cms.view'])){
                        $cms_active = 'active';
                    }
                    ?>

                    <a href="{{route('admin.cms.index')}}" class="nav-link {{$cms_active}}">
                        <i class="nav-icon fa fa-file"></i>
                        <p>CMS Pages</p>
                    </a>
                </li>
                <?php 
                    $treeview_open_rate = '';
                    if(in_array($route_name, ['admin.rating.client','admin.rating.stylist'])){
                        $treeview_open_rate = 'menu-open';
                    }
                ?>
                <li class="nav-item has-treeview {{$treeview_open_rate}}">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fa fa-star"></i>
                        <p>Ratings<i class="fas fa-angle-left right"></i></p>
                    </a>
                    
                    <ul class="nav nav-treeview {{$treeview_open_rate}}">
                        <li class="nav-item">
                            <a href="{{route('admin.rating.client')}}" class="nav-link @if($route_name == 'admin.rating.client') active @endif">
                                <i class="far fa-circle nav-icon"></i><p>Client Ratings</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="{{route('admin.rating.stylist')}}" class="nav-link @if($route_name == 'admin.rating.stylist') active @endif">
                                <i class="far fa-circle nav-icon"></i><p>Stylist Ratings</p>
                            </a>
                        </li>
                    </ul>
                </li>
                <?php
                    $treeview_open = '';
                    if(in_array($route_name, ['admin.profile.index','admin.change_password','admin.support.index'])){
                        $treeview_open = 'menu-open';
                    }
                    ?>
                <li class="nav-item has-treeview {{$treeview_open}}">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-cog"></i>
                        <p>Settings<i class="fas fa-angle-left right"></i></p>
                    </a>
                    <ul class="nav nav-treeview {{$treeview_open}}">
                        <li class="nav-item">
                            <a href="{{route('admin.profile.index')}}" class="nav-link @if($route_name == 'admin.profile.index') active @endif">
                                <i class="far fa-circle nav-icon"></i><p>Edit Profile</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="{{route('admin.change_password')}}" class="nav-link @if($route_name == 'admin.change_password') active @endif">
                                <i class="far fa-circle nav-icon"></i><p>Change Password</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="{{route('admin.support.index')}}" class="nav-link @if($route_name == 'admin.support.index') active @endif">
                                <i class="far fa-circle nav-icon"></i><p>Support Details</p>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </nav>
    </div>
</aside>
