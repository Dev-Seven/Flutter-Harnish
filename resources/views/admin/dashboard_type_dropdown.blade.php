
<select id="type1" class="form-control type_dropdown">
    <option value="">Please select...</option>
    @if(!empty($data) && count($data) > 0)
        @foreach($data as $value)
            <option value="{{$value['key']}}">{{$value['value']}}</option>
        @endforeach
    @endif
</select>
                        
<script src="{{asset('plugins/jquery/jquery.min.js')}}"></script>
<link href="{{asset('plugins/select2/css/select2.min.css')}}" rel="stylesheet" />
<script src="{{asset('plugins/select2/js/select2.min.js')}}"></script>
<script>
var $j = jQuery.noConflict();
$j("#type1").select2({
    placeholder: "Select a Salon Type",
    allowClear: true,
    "language": {
        "noResults": function(){
            return "First Select Location"
        }
    },
});
$j(document).on('change','.type_dropdown',function(){
    var token = '{{csrf_token()}}'
    var type_value = $(this).val();
    var location_value = $('.location_dropdown').val();
    var salon_value = $('.salon_dropdown').val();
    var stylist_value = $('.stylist_dropdown').val();
    change_type_dropdown(token,type_value,location_value);
    filter_dashboard(token,location_value,type_value,salon_value,stylist_value)
});
</script>