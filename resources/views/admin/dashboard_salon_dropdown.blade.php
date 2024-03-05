
@csrf
<select name="salon" id="salon" class="form-control salon_dropdown">
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
$j("#salon").select2({
      placeholder: "Select a Salon",
      allowClear: true,
      "language": {
        "noResults": function(){
            return "First Select Type"
        }
      },
    });


$j(document).on('change','.salon_dropdown',function(){
    var token = '{{csrf_token()}}'
    var salon_value = $(this).val();
    var type_value = $('.type_dropdown').val();
    var location_value = $('.location_dropdown').val();
    var stylist_value = $('.stylist_dropdown').val();
    change_salon_dropdown(token,type_value,location_value,salon_value);
    filter_dashboard(token,location_value,type_value,salon_value,stylist_value)
});
</script>