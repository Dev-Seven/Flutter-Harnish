// var customurl = SITE_URL;
$(document).ready(function(){
    
    setTimeout(function(){ $('.alert').fadeOut(3000); }, 3000);
    
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    $(document).on('click','.btn_loader',function(){
        var $this = $(this);
        var html = $this.html();

        var loadingText = '<i class="fa fa-spinner fa-spin" role="status" aria-hidden="true"></i> Loading...';
        $(this).html(loadingText);
        $(this).prop("disabled", true);

        setTimeout(function(){ 
            $('.btn_loader').html(html);
            $('.btn_loader').prop("disabled", false);
        }, 5000);
    });

    $(document).on('click','.icon_loader',function(){
        var $this = $(this);
        var html = $this.html();

        var loadingText = '<i class="fa fa-spinner fa-spin" role="status" aria-hidden="true"></i>';
        $(this).html(loadingText);
        $(this).prop("disabled", true);

        setTimeout(function(){ 
            $('.icon_loader').html(html);
            $('.icon_loader').prop("disabled", false);
        }, 5000);
    });

    $('#cms_page_table').dataTable({
        "bDestroy": true, "lengthChange": true, "bFilter": true, "pageLength": 10,
        "bPaginate": true, "paging": true, "bInfo": true, "stateSave": true,
        "language": { searchPlaceholder: 'Search'},
        "order": [],
        "columnDefs": [ { "orderable": false, "targets": [4] },
            { "orderable": true, "targets": [0, 1, 2, 3] } ]
    });

    $('#user_list_table').dataTable({
        "bDestroy": true, "lengthChange": true, "bFilter": true, "pageLength": 10,
        "bPaginate": true, "paging": true, "bInfo": true, "stateSave": true,
        "language": { searchPlaceholder: 'Search' },
        "order": [],
        "columnDefs": [{ "orderable": false, "targets": [0, 5] },
            { "orderable": true, "targets": [1, 2, 3, 4] }
        ]
    });

    $('#service_list_table').dataTable({
        "bDestroy": true,  "lengthChange": true, "bFilter": true, "pageLength": 10,
        "bPaginate": true, "paging": true, "bInfo": true, "stateSave": true,
        "language": {  searchPlaceholder: 'Search' },
        "order": [],
        "columnDefs": [{ "orderable": false, "targets": [ 5] },
            { "orderable": true, "targets": [0, 1, 2, 3, 4] }
        ]
    });

    $('#employee_list_table').dataTable({
        "bDestroy": true, "lengthChange": true, "bFilter": true, "pageLength": 10, 
        "bPaginate": true,  "paging": true,  "bInfo": true, "stateSave": true,  
        "language": { searchPlaceholder: 'Search' },
        "order": [],
        "columnDefs": [ { "orderable": false, "targets": [0, 5] },
            { "orderable": true, "targets": [1, 2, 3, 4] }
        ]
    });
    $('#appointment_list_table').dataTable({
        "bDestroy": true, "lengthChange": true, "bFilter": true,"pageLength": 10,
        "bPaginate": true, "paging": true, "bInfo": true,"stateSave": true,
        "language": {  searchPlaceholder: 'Search'},
        "order": [],
        "columnDefs": [{ "orderable": false, "targets": [0, 6] },
            { "orderable": true, "targets": [1, 2, 3, 4, 5] }
        ]
    });

    $('#employee_sub_table').dataTable({
        "bDestroy": true, "lengthChange": true, "bFilter": true,"pageLength": 10,
        "bPaginate": true, "paging": true, "bInfo": true,"stateSave": true,
        "language": { searchPlaceholder: 'Search'},
        "order": [],
        "columnDefs": [ { "orderable": false, "targets": [0, 8] },
            { "orderable": true, "targets": [1, 2, 3, 4, 5, 6, 7] }
        ]
    });

    $('#rate_list_table').dataTable({
        "bDestroy": true, "lengthChange": true, "bFilter": true,"pageLength": 10,
        "bPaginate": true, "paging": true, "bInfo": true,"stateSave": true,
        "language": { searchPlaceholder: 'Search'},
        "order": [],
        "columnDefs": [ { "orderable": false, "targets": [0] },
            { "orderable": true, "targets": [1, 2, 3, 4, 5] }
        ]
    });

    $('#service_table').dataTable({
        "bDestroy": true, "lengthChange": true, "bFilter": true, "pageLength": 10,
        "bPaginate": true, "paging": true, "bInfo": true, "stateSave": true,
        "language": { searchPlaceholder: 'Search' },
        "order": [],
        "columnDefs": [{ "orderable": false, "targets": [3] },
            { "orderable": true, "targets": [0, 1, 2] }
        ]
    });

    $('#salon_table').dataTable({
        "bDestroy": true, "lengthChange": true, "bFilter": true, "pageLength": 10,
        "bPaginate": true, "paging": true, "bInfo": true, "stateSave": true,
        "language": { searchPlaceholder: 'Search' },
        "order": [],
        "columnDefs": [{ "orderable": false, "targets": [9] },
            { "orderable": true, "targets": [0, 1, 2, 3, 4, 5, 6, 7, 8] }
        ]
    });

    $('#stylist_table').dataTable({
        "bDestroy": true, "lengthChange": true, "bFilter": true, "pageLength": 10,
        "bPaginate": true, "paging": true, "bInfo": true, "stateSave": true,
        "language": { searchPlaceholder: 'Search' },
        "order": [],
        "columnDefs": [{ "orderable": false, "targets": [8] },
            { "orderable": true, "targets": [0, 1, 2, 3, 4, 5, 6, 7] }
        ]
    });

    $('#user_table').dataTable({
        "bDestroy": true, "lengthChange": true, "bFilter": true, "pageLength": 10,
        "bPaginate": true, "paging": true, "bInfo": true, "stateSave": true,
        "language": { searchPlaceholder: 'Search' },
        "order": [],
        "columnDefs": [{ "orderable": false, "targets": [8] },
            { "orderable": true, "targets": [0, 1, 2, 3, 4, 5, 6, 7] }
        ]
    });

    $('#service_request_table').dataTable({
        "bDestroy": true, "lengthChange": true, "bFilter": true, "pageLength": 10,
        "bPaginate": true, "paging": true, "bInfo": true, "stateSave": true,
        "language": { searchPlaceholder: 'Search' },
        "order": [],
        "columnDefs": [{ "orderable": false, "targets": [4] },
            { "orderable": true, "targets": [0, 1, 2, 3] }
        ]
    });

    $('#city_table').dataTable({
        "bDestroy": true, "lengthChange": true, "bFilter": true, "pageLength": 10,
        "bPaginate": true, "paging": true, "bInfo": true, "stateSave": true,
        "language": { searchPlaceholder: 'Search' },
        "order": [],
        "columnDefs": [{ "orderable": false, "targets": [0, 3] },
            { "orderable": true, "targets": [1, 2] }
        ]
    });

    $('#package_table').dataTable({
        "bDestroy": true, "lengthChange": true, "bFilter": true, "pageLength": 10,
        "bPaginate": true, "paging": true, "bInfo": true, "stateSave": true,
        "language": { searchPlaceholder: 'Search' },
        "order": [],
        "columnDefs": [{ "orderable": false, "targets": [4] },
            { "orderable": true, "targets": [0, 1, 2, 3] }
        ]
    });
});