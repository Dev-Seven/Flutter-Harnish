var customurl = SITE_URL;
$(document).ready(function(){
    
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    $("#login_form").validate({
        ignore: "not:hidden",
        onfocusout: function(element) {
            this.element(element);  
        },
        rules: {
            "email":{
                required:true,
                email:true,
                emailCheck:true,
            },
            "password":{
                required:true,
                minlength:6,
            },
        },
        messages: {
            "email":{
                required:'Please enter Email address',
                email:'Please enter valid Email address',
                emailCheck:'Please enter valid Email address',
            },
            "password":{
                required:'Please enter password',
                minlength:'Password must be more then 6 characters',
            },
        },
        submitHandler: function(form) {
            var $this = $('.loader_class');
            var loadingText = '<i class="fa fa-spinner fa-spin" role="status" aria-hidden="true"></i> Loading...';
            $('.loader_class').prop("disabled", true);
            $this.html(loadingText);
            form.submit();
        }
    });

    $("#forgot_password_form").validate({
        ignore: "not:hidden",
        onfocusout: function(element) {
            this.element(element);  
        },
        rules: {
            "email":{
                required:true,
                email:true,
                emailCheck:true,
            },
        },
        messages: {
            "email":{
                required:'Please enter Email address',
                email:'Please enter valid Email address',
                emailCheck:'Please enter valid Email address',
            },
        },
        submitHandler: function(form) {
            var $this = $('.loader_class');
            var loadingText = '<i class="fa fa-spinner fa-spin" role="status" aria-hidden="true"></i> Loading...';
            $('.loader_class').prop("disabled", true);
            $this.html(loadingText);
            form.submit();
        }
    });

    $("#reset_password_form").validate({
        ignore: "not:hidden",
        onfocusout: function(element) {
            this.element(element);  
        },
        rules: {
            "password":{
                required:true,
                minlength:6,
            },
            "confirm_password":{
                equalTo:'#password',
            },
        },
        messages:{
            "password":{
                required:'Please Enter Password',
                minlength:'Please Password must be 6 character',
            },
            "confirm_password":'Password and Re-type Password must match',
        },
        submitHandler: function(form) {
            var $this = $('.loader_class');
            var loadingText = '<i class="fa fa-spinner fa-spin" role="status" aria-hidden="true"></i> Loading...';
            $('.loader_class').prop("disabled", true);
            $this.html(loadingText);
            form.submit();
        },
    });

    $("#setting_page").validate({
        ignore: "not:hidden",
        onfocusout: function(element) {
            this.element(element);  
        },
        rules: {
            "facebook_link":{
                required:true,
                url: true
            },
            "instagram_link":{
                required:true,
                url: true
            },
            "support_mail":{
                required:true,
                email:true,
                emailCheck:true,
            },
            "support_contact":{
                required:true,
                maxlength:10,
                minlength:10,
                number: true,
            },
            "support_radius":{
                required:true,
                number: true,
            }
        },
        messages:{
            "facebook_link":{
                required:'Please enter Facebook shared link',
                url:'Please enter valid link',
            },
            "instagram_link":{
                required:'Please enter Instagram shared link',
                url:'Please enter valid link',
            },
            "support_mail":{
                required:'Please enter support Email address',
                email:'Please enter valid Email address',
                emailCheck:'Please enter valid Email address',
            },
            "support_contact":{
                required:'Please enter Support contact number',
                maxlength:"Contact number must be 10 digits",
                minlength:"Contact number must be 10 digits",
                number: "Please enter valid Contact number",
            },
            "support_radius":{
                required:'Please enter Radius distance',
                number: "Please enter valid Distance",
            },
        },
        submitHandler: function(form) {
            var $this = $('.loader_class');
            var loadingText = '<i class="fa fa-spinner fa-spin" role="status" aria-hidden="true"></i> Loading...';
            $('.loader_class').prop("disabled", true);
            $this.html(loadingText);
            form.submit();
        },
    });

    $("#city_create").validate({
        ignore: "not:hidden",
        onfocusout: function(element) {
            this.element(element);  
        },
        rules: {
            "name":{
                required:true,
            },
            "status":{
                required:true,
            }
        },
        messages: {
            "name":{
                required:'Please enter City Name',
            },
            "status":{
                required:'Please select Status',
            }
        },
        submitHandler: function(form) {
            var $this = $('.loader_class');
            var loadingText = '<i class="fa fa-spinner fa-spin" role="status" aria-hidden="true"></i> Loading...';
            $('.loader_class').prop("disabled", true);
            $this.html(loadingText);
            form.submit();
        }
    });

    $("#support_data_form").validate({
        ignore: "not:hidden",
        onfocusout: function(element) {
            this.element(element);  
        },
        rules: {
            "support_mail":{
                required:true,
                email:true,
                emailCheck:true,
            },
            "support_contact":{
                required:true,
                number: true,
            },
            "support_radius":{
                required:true,
                number: true,
            }
        },
        messages:{
            "support_mail":{
                required:'Please enter support Email address',
                email:'Please enter valid Email address',
                emailCheck:'Please enter valid Email address',
            },
            "support_contact":{
                required:'Please enter Support contact number',
                number: "Please enter valid Contact number",
            },
            "support_radius":{
                required:'Please enter Radius distance',
                number: "Please enter valid Distance",
            },
        },
        submitHandler: function(form) {
            var $this = $('.loader_class');
            var loadingText = '<i class="fa fa-spinner fa-spin" role="status" aria-hidden="true"></i> Loading...';
            $('.loader_class').prop("disabled", true);
            $this.html(loadingText);
            form.submit();
        },
    });

    $("#change_password_form").validate({
        ignore: "not:hidden",
        onfocusout: function(element) {
            this.element(element);  
        },
        rules: {
            "current_password":{
                required:true,
                minlength:6,
            },
            "new_password":{
                required:true,
                minlength:6,
            },
            "confirm_password":{
                required:true,
                minlength:6,
                equalTo:'#new_password'
            },
        },
        messages:{
            "current_password":{
                required:'Please enter Current password',
            },
            "new_password":{
                required:'Please enter New password',
                minlength:'Please Password must be 6 character',
            },
            "confirm_password":{
                required:'Please enter Confirm new password',
                equalTo:'New password and Confirm new password are not match',
                minlength:'Please Password must be 6 character',
            },
        },
        submitHandler: function(form) {
            var $this = $('.loader_class');
            var loadingText = '<i class="fa fa-spinner fa-spin" role="status" aria-hidden="true"></i>Loading...';
            $('.loader_class').prop("disabled", true);
            $this.html(loadingText);
            form.submit();
        },
    });

    $("#edit_profile").validate({
        ignore: "not:hidden",
        onfocusout: function(element) {
            this.element(element);  
        },
        rules: {
            "first_name":{
                required:true,
            },
            "last_name":{
                required:true,
            },
            "phone_number":{
                required:true,
                number: true,
            },
            "image":{
                extension:true
            },
        },
        messages: {
            "first_name":{
                required:'Please enter First Name',
            },
            "last_name":{
                required:'Please enter Last Name',
            },
            "phone_number":{
                required:'Please enter Phone number',
                number: "Please enter valid Phone Number",
            },
        },
        submitHandler: function(form) {
            var $this = $('.loader_class');
            var loadingText = '<i class="fa fa-spinner fa-spin" role="status" aria-hidden="true"></i> Loading...';
            $('.loader_class').prop("disabled", true);
            $this.html(loadingText);
            form.submit();
        }
    });

    $("#stylist_create").validate({
        ignore: "not:hidden",
        onfocusout: function(element) {
            this.element(element);  
        },
        rules: {
            "first_name":{
                required:true,
            },
            "last_name":{
                required:true,
            },
            "email":{
                required:true,
                email:true,
                emailCheck:true,
                remote: {
                    url : customurl+"/admin/check/email",
                    type: "get",
                    data: {
                        email: function() {
                          return $("#email").val();
                        },
                    },
                },
            },
            "phone_number":{
                required:true,
                number: true,
            },
            "salon_id":{
                required:true,
            },
            "services[]":{
                required:true,
            },
            "address":{
                required:true,
            },
            "status":{
                required:true,
            },
        },
        messages: {
            "first_name":{
                required:'Please enter First Name',
            },
            "last_name":{
                required:'Please enter Last Name',
            },
            "address":{
                required:'Please enter Location',
            },
            "status":{
                required:'Please select Status',
            },
            "salon_id":{
                required:'Please select Salon',
            },
            "services[]":{
                required:'Please select atleast one Service',
            },
            "phone_number":{
                required:'Please enter Phone number',
                number: "Please enter valid Phone Number",
            },
            "email":{
                required:'Please enter Email address',
                email: "Please enter valid Email address",
                emailCheck: "Please enter valid Email address",
                remote:"Entered email is already exists in our record.",
            },
        },
        submitHandler: function(form) {
            var $this = $('.loader_class');
            var loadingText = '<i class="fa fa-spinner fa-spin" role="status" aria-hidden="true"></i> Loading...';
            $('.loader_class').prop("disabled", true);
            $this.html(loadingText);
            form.submit();
        }
    });

    $("#cms_page_create").validate({
        ignore: "not:hidden",
        onfocusout: function(element) {
            this.element(element);  
        },
        rules: {
            "title":{
                required:true,
            },
            "short_description":{
                required:true,
            },
            "description":{
                required:true,
            },
            "status":{
                required:true,
            },
        },
        messages: {
            "title":{
                required:'Please enter Page Title',
            },
            "description":{
                required:'Please enter Description',
            },
            "short_description":{
                required:'Please enter Short Description',
            },
            "status":{
                required:'Please select Status',
            },
        },
        submitHandler: function(form) {
            var $this = $('.loader_class');
            var loadingText = '<i class="fa fa-spinner fa-spin" role="status" aria-hidden="true"></i> Loading...';
            $('.loader_class').prop("disabled", true);
            $this.html(loadingText);
            form.submit();
        }
    });

    $("#service_create").validate({
        ignore: "not:hidden",
        onfocusout: function(element) {
            this.element(element);  
        },
        rules: {
            "name":{
                required:true,
            },
            "status":{
                required:true,
            }
        },
        messages: {
            "name":{
                required:'Please enter Service Name',
            },
            "status":{
                required:'Please select Status',
            }
        },
        submitHandler: function(form) {
            var $this = $('.loader_class');
            var loadingText = '<i class="fa fa-spinner fa-spin" role="status" aria-hidden="true"></i> Loading...';
            $('.loader_class').prop("disabled", true);
            $this.html(loadingText);
            form.submit();
        }
    });

    $("#salon_create").validate({
        ignore: "not:hidden",
        onfocusout: function(element) {
            this.element(element);  
        },
        rules: {
            "salon_name":{
                required:true,
            },
            "owner_name":{
                required:true,
            },
            "city":{
                required:true,
            },
            "type":{
                required:true,
            },
            "phone_number":{
                required:true,
            },
            "commission":{
                required:true,
                min: 0,
                max: 100,
            },
            "email":{
                required:true,
                email:true,
                emailCheck:true,
                remote: {
                    url : customurl+"/admin/check/email",
                    type: "get",
                    data: {
                        email: function() {
                          return $("#email").val();
                        },
                    },
                },
            },
            "services[]":{
                required:true,
            },
            "address":{
                required:true,
            },
            "status":{
                required:true,
            }
        },
        messages: {
            "salon_name":{
                required:'Please enter Salon Name',
            },
            "owner_name":{
                required:'Please enter Owner Name',
            },
            "phone_number":{
                required:'Please enter Mobile Number',
            },
            "services[]":{
                required:'Please select atleast one Service',
            },
            "commission" : {
                required:'Please enter Commission',
            },
            "email":{
                required:'Please enter Owner Email',
                email: "Please enter valid Email",
                emailCheck: "Please enter valid Email",
                remote:"Entered email is already exists in our record.",
            },
            "address":{
                required:'Please enter Address',
            },
            "status":{
                required:'Please select Status',
            },
            "type":{
                required:'Please select Salon type',
            },
            "city":{
                required:'Please select City',
            }
        },
        submitHandler: function(form) {
            var $this = $('.loader_class');
            var loadingText = '<i class="fa fa-spinner fa-spin" role="status" aria-hidden="true"></i> Loading...';
            $('.loader_class').prop("disabled", true);
            $this.html(loadingText);
            form.submit();
        }
    });


    $("#package_create").validate({
        ignore: "not:hidden",
        onfocusout: function(element) {
            this.element(element);  
        },
        rules: {
            "package_name":{
                required:true,
            },
            "salon":{
                required:true,
            },
            "price":{
                required:true,
                number:true,
            },
            "services[]":{
                required:true,
            },
            "discount":{
                required:true,
                min: 0,
                max: 100,
            },
        },
        messages: {
            "package_name":{
                required:'Please enter Package Name',
            },
            "salon":{
                required:'Please select Salon Name',
            },
            "price":{
                required:'Please enter Price',
            },
            "services[]":{
                required:'Please select atleast one Service',
            },
            "discount" : {
                required:'Please enter Commission',
            },
        },
        submitHandler: function(form) {
            var $this = $('.loader_class');
            var loadingText = '<i class="fa fa-spinner fa-spin" role="status" aria-hidden="true"></i> Loading...';
            $('.loader_class').prop("disabled", true);
            $this.html(loadingText);
            form.submit();
        }
    });

    $("#user_create").validate({
        ignore: "not:hidden",
        onfocusout: function(element) {
            this.element(element);  
        },
        rules: {
            "first_name":{
                required:true,
            },
            "last_name":{
                required:true,
            },
            "email":{
                required:true,
                email:true,
                emailCheck:true,
                remote: {
                    url : customurl+"/admin/check/email",
                    type: "get",
                    data: {
                        email: function() {
                          return $("#email").val();
                        },
                    },
                },
            },
            "phone_number":{
                required:true,
                number: true,
            },
            "services[]":{
                required:true,
            },
            "address":{
                required:true,
            },
            "gender":{
                required:true,
            },
            "status":{
                required:true,
            },
            "city":{
                required:true,
            },
        },
        messages: {
            "first_name":{
                required:'Please enter First Name',
            },
            "last_name":{
                required:'Please enter Last Name',
            },
            "address":{
                required:'Please enter Location',
            },
            "status":{
                required:'Please select User Type',
            },
            "gender":{
                required:'Please select Gender',
            },
            "city":{
                required:'Please select City',
            },
            "services[]":{
                required:'Please select atleast one Service',
            },
            "phone_number":{
                required:'Please enter Phone number',
                number: "Please enter valid Phone Number",
            },
            "email":{
                required:'Please enter Email address',
                email: "Please enter valid Email address",
                emailCheck: "Please enter valid Email address",
                remote:"Entered Email is already exists in our record.",
            },
        },
        submitHandler: function(form) {
            var $this = $('.loader_class');
            var loadingText = '<i class="fa fa-spinner fa-spin" role="status" aria-hidden="true"></i> Loading...';
            $('.loader_class').prop("disabled", true);
            $this.html(loadingText);
            form.submit();
        }
    });

    $.validator.addMethod("emailCheck", function (value, element, param) {
        var check_result = false;
        result = this.optional( element ) || /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}/.test( value );
        return result;
    });

    $.validator.addMethod('filesize', function (value, element, param) {
        return this.optional(element) || (element.files[0].size <= param)
    }, 'File size must be less than 40MB');

    $.validator.addMethod("extension", function (value, element, param) {
        param = typeof param === "string" ? param.replace(/,/g, '|') : "png|jpe?g|gif";
        return this.optional(element) || value.match(new RegExp(".(" + param + ")$", "i"));
    }, "Please enter a value with a valid extension.");

});