
<select name="stylist" id="stylist" class="form-control stylist_dropdown">
    <option value="">First Select Salon</option>
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
$j("#stylist").select2({
    placeholder: "Select a Stylist",
    allowClear: true,
    "language": {
        "noResults": function(){
            return "First Select Salon"
        }
    },
});

$j(document).on('change','.stylist_dropdown',function(){
    var token = '{{csrf_token()}}'
    var salon_value = $('.salon_dropdown').val();
    var type_value = $('.type_dropdown').val();
    var location_value = $('.location_dropdown').val();
    var stylist_value = $(this).val();
    filter_dashboard(token,location_value,type_value,salon_value,stylist_value)
});

</script>