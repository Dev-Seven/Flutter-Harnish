<?php 

$route_name = \Request::route()->getName(); 
$logged_user = \Auth::User();
?>
<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <a href="{{route('admin.dashboard')}}" class="brand-link">
        <img src="{{asset('dist/img/AdminLTELogo.png')}}" alt="{{env('APP_NAME')}}" class="brand-image img-circle elevation-3"
        style="opacity: .8">
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
                <a href="#" class="d-block">{{ucfirst(\Auth::User()->name)}}</a>
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
                        <i class="nav-icon fas fa-tachometer-alt"></i>
                        <p>Dashboard</p>
                    </a>
                </li>
                <li class="nav-item">
                    <?php 
                    $user_active = '';
                    if(in_array($route_name, ['admin.user.index','admin.user.view'])){
                        $user_active = 'active';
                    }
                    ?>

                    <a href="{{route('admin.user.index')}}" class="nav-link {{$user_active}}">
                        <i class="nav-icon fa fa-users"></i>
                        <p>Client List</p>
                    </a>
                </li>
                <li class="nav-item">
                    <?php 
                    $merchant_active = '';
                    if(in_array($route_name, ['admin.merchant.index','admin.merchant.view'])){
                        $merchant_active = 'active';
                    }
                    ?>

                    <a href="{{route('admin.merchant.index')}}" class="nav-link {{$merchant_active}}">
                        <i class="nav-icon fa fa-industry"></i>
                        <p>Stylist List</p>
                    </a>
                </li>

                <li class="nav-item">
                    <?php 
                    $service_active = '';
                    if(in_array($route_name, ['admin.service.index','admin.service.view'])){
                        $service_active = 'active';
                    }
                    ?>

                    <a href="{{route('admin.service.index')}}" class="nav-link {{$service_active}}">
                        <i class="nav-icon fa fa-industry"></i>
                        <p>Stylist Service/Package</p>
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
                <li class="nav-item">
                    <?php 
                    $employee_active = '';
                    if(in_array($route_name, ['admin.employee.index','admin.employee.view'])){
                        $employee_active = 'active';
                    }
                    ?>

                    <a href="{{route('admin.employee.index')}}" class="nav-link {{$employee_active}}">
                        <i class="nav-icon fa fa-users"></i>
                        <p>Stylist Employee</p>
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
                        <p>Cms Pages</p>
                    </a>
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