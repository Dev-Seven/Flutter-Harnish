        <aside class="control-sidebar control-sidebar-dark">
        </aside>
        <footer class="main-footer">
            <strong>Copyright &copy; {{date('Y')}} <a href="javascript::void(0)">{{env('APP_NAME')}}</a>.</strong>
            All rights reserved.
        </footer>
        </div>

        <!-- Popup modal for logout start -->
        <div class="modal fade" id="logoutModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
            aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Are You sure?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Are you sure to logout?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <a href="{{route('admin.logout')}}" class="btn btn-danger btn_loader">Logout</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Popup modal for logout end -->

        <script src="{{asset('plugins/jquery/jquery.min.js')}}"></script>
        <script src="{{asset('plugins/bootstrap/js/bootstrap.bundle.min.js')}}"></script>
        <script src="{{asset('plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js')}}"></script>
        <script src="{{asset('dist/js/adminlte.js')}}"></script>
        <script src="{{asset('dist/js/demo.js')}}"></script>
        <script src="{{asset('plugins/jquery-mousewheel/jquery.mousewheel.js')}}"></script>
        <script src="{{asset('plugins/raphael/raphael.min.js')}}"></script>
        <script src="{{asset('plugins/jquery-mapael/jquery.mapael.min.js')}}"></script>
        <script src="{{asset('plugins/jquery-mapael/maps/usa_states.min.js')}}"></script>
        <script src="{{asset('plugins/chart.js/Chart.min.js')}}"></script>
        <script src="{{asset('dist/js/pages/dashboard2.js')}}"></script>
        <script src="{{asset('plugins/ion-rangeslider/js/ion.rangeSlider.min.js')}}"></script>
        <script src="{{asset('plugins/bootstrap-slider/bootstrap-slider.min.js')}}"></script>


        <script src="{{asset('plugins/datatables/jquery.dataTables.min.js')}}"></script>
        <script src="{{asset('plugins/datatables-bs4/js/dataTables.bootstrap4.min.js')}}"></script>
        <script src="{{asset('plugins/datatables-responsive/js/dataTables.responsive.min.js')}}"></script>
        <script src="{{asset('plugins/datatables-responsive/js/responsive.bootstrap4.min.js')}}"></script>

        <script src="{{asset('js/jquery.validate.min.js')}}"></script>
        <script src="{{asset('js/additional-methods.min.js')}}"></script>
        <script src="{{asset('js/jquery_validation.js')}}"></script>
        <script src="{{asset('js/custom.js')}}"></script>
        </body>

        </html>