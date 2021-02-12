{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

    <style type="text/css">

        span.w-100 {
            /* width: 140px;*/
            float: left;
            height: 48px;
        }

        .pro_image {
            border-radius: 3px;
            background-color: #FFF;
            box-shadow: 0px 0px 2px #ccc;
            text-align: center;
            line-height: 0;
            margin: 0px auto 0px;
            background-position: center center;
            background-size: cover;
            display: inline-block;
            width: auto;
            padding: 10px;
            height: auto;
        }

        .addresscity {
            color: #F00;
        }

    </style>
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li class="active"> Users <i class="fa fa-angle-double-right"></i> {if $users.id == 0 or $users.id == ''} Add {else} Edit {/if} Users <i class="fa fa-angle-double-right"></i> {$users.username} </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-8">
            {if $error !=''}
            <div class="alert alert-danger " role="alert">
                <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                <span class="sr-only">Error:</span><span class="">{$error}</span>
            </div>
            {/if}
            {if $error == 'saved'}
            <div class="alert alert-success"><strong>Saved!</strong>
                {if $stat_msg !=''}
                {$stat_msg}
                {else}
                {$users.first_name} profile was successfully changed.
                {/if}
            </div>
            {elseif $error != ''}
            <div class="alert alert-danger"><strong>{$error}</strong></div>
            {/if}
            <form enctype="multipart/form-data" class="admin_form registration-form" data-parsley-validate id="subadminform" method="post" enctype="multipart/form-data" action="javascript:void(0)">

                <input type="hidden" value="{$users.id}" name="id"/>

                <div class="row">
                    <div class="col-md-12 col-sm-6">
                        <div class="form-group cus-radio">
                            <div class="radio radio-inline radio-primary ">
                                <!-- <input type="radio" name="role" id="role1" value="2" {if $users.role == '' || $users.role == '2'} checked="true" {/if}>
                                <label for="role1">&nbsp;&nbsp;&nbsp; Sub Admin </label>
                                <input type="radio" name="role" id="role2" value="3" {if $users.role == '3'} checked="true" {/if}>
                                <label for="role2">&nbsp;&nbsp;&nbsp; Sales Admin </label>
                                <input type="radio" name="role" id="role3" value="4" {if $users.role == '4'} checked="true" {/if}>
                                <label for="role3">&nbsp;&nbsp;&nbsp; Distributor </label> -->
                                <input type="radio" name="role" id="role1" value="4" {if $users.role == '4' || $users.role == ''} checked="true" {/if}>
                                <label for="role1">&nbsp;&nbsp;&nbsp; Sub Admin </label>
                                <input type="radio" name="role" id="role2" value="5" {if $users.role == '5'} checked="true" {/if}>
                                <label for="role2">&nbsp;&nbsp;&nbsp; Sales Admin </label>
                                <input type="radio" name="role" id="role3" value="6" {if $users.role == '6'} checked="true" {/if}>
                                <label for="role3">&nbsp;&nbsp;&nbsp; Distributor </label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label>First Name :</label>
                            <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter First Name"
                                   value="{$users.first_name}"
                                   name="first_name" data-parsley-group="block1" data-parsley-pattern="^[A-Za-z]*$" pattern="^[A-Za-z]*$" data-parsley-pattern-message="Invalid username" data-parsley-required required>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label>Last Name :</label>
                            <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Last Name"
                                   value="{$users.last_name}"
                                   name="last_name" data-parsley-group="block1" data-parsley-pattern="^[A-Za-z]*$" pattern="^[A-Za-z]*$" data-parsley-pattern-message="Invalid username" data-parsley-required required data-parsley-trigger="blur">
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="inputEmail">Phone Number :</label>
                            <div>
                                <input data-parsley-errors-container="#phone_err" data-parsley-trigger="change focusout" class="form-control" placeholder="Enter Phone Number" value="{$users.phone}" name="phone" maxlength="18" data-parsley-required required data-parsley-trigger="blur" data-mask="000-000-0000" data-parsley-minlength="12" data-parsley-minlength-message="Enter the 10 digit phone number">

                                <span id="valid-msg" style="color:#075A0B;" class="hide phone_valid"> Valid</span>
                                <span id="error-msg" style="color:#F00;" class="hide phone_valid">Invalid number</span>
                            </div>
                            <span id="phone_err"></span>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label>Email :</label>
                                <input data-parsley-trigger="change focusout" class="form-control" type="email" id="email" name="email" value="{$users.email}" data-parsley-required-message="Please enter Email ID" placeholder="Business Email"
                                  class="form-control" data-required="true" data-parsley-required data-parsley-group="block1"
                                  data-parsley-errors-container="#email-register-err" data-parsley-group="block1" {if users.id}disabled{/if} />

                                    <span id="email-register-err" class="err-message"></span>
                                    <span id="email-check-err" class="err-message customErrors"></span>
                              </div>

                            <!-- <input class="form-control" data-parsley-trigger="change focusout" data-parsley-type="email" name="email" type="email" value="{$users.email}" id="email" data-parsley-group="block1" data-parsley-required required>
                            <span id="email-check-err" class="err-message"></span> -->
                        </div>
                    </div>

                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label>Password :
                                {if $users.id}<small>(leave empty to keep same)</small>{/if}
                            </label>
                            <input type="password" data-parsley-trigger="change focusout" class="form-control" {if $users.id} disabled {/if} name="password" id="password"
                                   data-parsley-group="block1" id="password" name="password" data-parsley-minlength="6"
                                   data-parsley-minlength-message="Please enter a minimum of 6 characters"
                                   data-parsley-length-message="Please enter a minimum of 6 characters"
                                   data-parsley-type-message="Password should be alphanumeric" {if !$users.id} data-parsley-required required {/if} data-parsley-trigger="blur">
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label>Confirm Password :</label>
                            <input type="password" data-parsley-trigger="change focusout" class="form-control" {if $users.id} disabled {/if} name="cpassword" data-parsley-group="block1" data-parsley-equalto="#password" data-parsley-minlength="6"
                                   data-parsley-minlength-message="Please enter a minimum of 6 characters"
                                   data-parsley-length-message="Please enter a minimum of 6 characters"
                                   data-parsley-type-message="Password should be alphanumeric" {if !$users.id} data-parsley-required required {/if} data-parsley-trigger="blur">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label>Country :</label>
                            <select data-parsley-trigger="change focusout" class="form-control" name="country" id="country"
                                    data-parsley-required-message="Please select country"
                                    data-parsley-message="Please select country" data-parsley-required required data-parsley-trigger="blur">
                                {if $users.country != ''}
                                <option value="{$users.country}" selected>{$users.country}</option>
                                {/if}
                                {if $users.country != ''}
                                <option value="{$users.country}" selected>{$users.country}</option>
                                {/if}
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label>State :</label>
                            <select id="state" data-parsley-trigger="change focusout"  name="state" class="form-control"
                                    data-parsley-required-message="Please select state" data-parsley-required  required data-parsley-trigger="blur" >
                                <option val="">Select State</option>
                                {if $users.state != ''}
                                <option value="{$users.state}" selected>{$users.state}</option>
                                {/if}
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label>City :</label>
                            <input type="text" data-parsley-trigger="change focusout" id="city" name="city" placeholder="Enter your city" required class="form-control"
                                   value="{$users.city}" title="City" maxlength="50"
                                   data-parsley-required-message="Please enter city" data-parsley-trigger="blur">
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label>Region :</label>
                            <select class="form-control" name="region" id="region"  data-parsley-required data-parsley-required-message="Please select region" place-holder="Select Region"  data-parsley-required>
                                <option value="">Select Region</option>
                                <option {if $users.region=='north west'} selected {/if} value="north west">North West</option>
                                <option {if $users.region=='south west'} selected {/if} value="south west">South West</option>
                                <option {if $users.region=='north east'} selected {/if} value="north east">North East</option>
                                <option {if $users.region=='south east'} selected {/if} value="south east">South East</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="inputEmail">Address :</label>
                            <input data-parsley-trigger="change focusout" type="text" id="address_line1" name="address1" required placeholder="Enter your address"
                                   class="form-control" value="{$users.address1}"
                                   title="Address Line 1" maxlength="50" data-parsley-trigger="blur">
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="inputEmail">Zipcode :</label>
                            <input data-parsley-trigger="change focusout" type="text" id="zipcode" name="zipcode" placeholder="Enter zipcode" class="form-control" value="{$users.zip}" title="Zipcode" maxlength="10" required data-parsley-trigger="blur">
                        </div>
                    </div>
                </div>
                <div class="row ">
                    <div class="col-sm-12 text-center ">
                        <input id="adminsub_button_hd" type="submit" class="btn btn-success submit_form " value="{if $users.id>0}Update{else}Submit{/if}">
                        <input id="adminsub_button" type="button" class="btn btn-success submit_form hide" value="submit">
                    </div>
                </div>

            </form>
        </div>
    </div>

    <!-- /.row -->
</div>
{include file="/admincp/footer.tpl" nocache}
<script src="{$config['externaljs']}scripts.js"></script>
<script>

    $('input[type=radio][name=stax]').change(function() {
        ////console.log('running');
        if (this.value == 'y') {
            $('input[type=text][name=stax_per]').prop('disabled', false);
            $('input[type=text][name=stax_per]').prop('data-toggle','tooltip');
            $('input[type=text][name=stax_per]').attr({ "data-parsley-required-message" : "Please enter sales tax" , "data-parsley-required":true });
            $('input[type=text][name=stax_per]').prop('title','Enter the sales tax(%)...!');
            $('#stax_per-err').show();
            $('#staxSetting').show();
        }
        if (this.value == 'n') {
            $('input[type=text][name=stax_per]').val(0);
            $('input[type=text][name=stax_per]').prop('disabled', true);
            $('input[type=text][name=stax_per]').prop('data-toggle','tooltip');
            $('input[type=text][name=stax_per]').removeAttr("data-parsley-required data-parsley-min data-required");
            $('input[type=text][name=stax_per]').prop('title','Select yes to enable...!');
            $('#stax_per-err').hide();
            $('#staxSetting').hide();
        }
    });



    function chooseCert() {
        $("#certificates").click();
    }
    function chooseLic() {
        $("#licenses").click();
    }


    $('.admin_form').on('submit',function(){
        if(true === $('#subadminform').parsley().isValid()){
            $('#adminsub_button').trigger('click');
        }
    });
    $('#adminsub_button').on('click',function(){
         if(true === $('#subadminform').parsley().isValid()){
             var param = $('#subadminform').serialize();
             subAdminDetails(param);
        }

    });
    function subAdminDetails(datas){
        var url = $('#auctiontype').val() !='' && typeof ($('#auctiontype').val() !='undefined') ? $('#auctiontype').val() :'';
        $.ajax({
            type: "GET",
            url: "/admincp/subadmin/add",
            data: datas,
            success: function (data) {
                if(data.status =='success' && data.status !='' && typeof(data.status) !='undefined'){
                    if(confirm("Sub Admin Details "+data.succesmsg+" Successfully") ==true ){
                        $('#id').val(data.userId);
                       // location.href='{$config.url}/admincp/subadmin/edit?id='+data.userId;
                        location.href='{$config.url}/admincp/subadmin/all';
                    }else{
                        location.href='{$config.url}/admincp/subadmin/add';
                    }
                }
            },
            error:function(){
            alert("something went to be wrong")
            }
        })

    }
</script>

<script language="javascript" type="text/javascript">


    function checkStateCity(form, id) {
       //console.log(id);
       //console.log("http://maps.googleapis.com/maps/api/geocode/json?address=" + $('#' + form + ' #zipcode').val());
        var params = {};
        if (window.XDomainRequest) {
            if (window.XDomainRequest) {
                var xdr = new XDomainRequest();
                var query = "http://maps.googleapis.com/maps/api/geocode/json?address=" + $('#' + form + ' #zipcode').val();
                if (xdr) {
                    xdr.onload = function () {
                       //console.log(JSON.parse(xdr.responseText));
                        sZipcode(JSON.parse(xdr.responseText), form, id);
                    }
                    xdr.onerror = function () { /* error handling here */
                    }
                    xdr.open('GET', query);
                    xdr.send();
                }
            }
        }
        else {
            $.ajax({
                type: "GET",
                url: "http://maps.googleapis.com/maps/api/geocode/json?address=" + $('#' + form + ' #zipcode').val(),
                data: params,
                success: function (data) {
                    sZipcode(data, form, id);
                }
            });
        }
    }

    function sZipcode(data, form, id) {
       //console.log(data);
        if (data['results'].length > 0) {
            var m = data['results'][0]['address_components'].length;

            $('#' + form + ' #city').val(data['results'][0]['address_components'][m - 3]['long_name']);
            $('#' + form + ' #state').val(data['results'][0]['address_components'][m - 2]['long_name']);
            $('#' + form + ' #country').val(data['results'][0]['address_components'][m - 1]['long_name']);
            $('#' + form + ' .addresscity').html($('#city').val() + ',' + $('#state').val() + ',' + $('#country').val());
            if (id > 0) {
                $('#' + form).submit();
            }
        }
        else {
            alert('Invalid Zipcode');
            //$('#'+form+' #zipcode').focus();
            $('#' + form + ' .addresscity').html('Invalid Zipcode');
            return false;
        }
    }

    var initValues = {};

    {if {$mcats} != ''}
    var initValues = '{$mcats}'.split(',');
    {/if}

    //alert(initValues);
    $(':checkbox[name^="categories"]').each(function () {
        $(this).prop("checked", ($.inArray($(this).val(), initValues) != -1));
    });

    $(function () {
        $('input[name="categories[]"]').each(function () {
            $(this).on('click', function () {
                var pid = $(this).attr('pid');
                var vid = $(this).attr('value');
                if (pid > 0) {
                    if (!$(this).is(':checked')) {
                        $('input[name="categories[]"][value="' + pid + '"]').attr('checked', false);
                    }
                }
                else {
                    if ($(this).is(':checked')) {
                        $('input[name="categories[]"][pid="' + vid + '"]').each(function () {
                            $(this).attr('checked', false);
                            $(this).click();
                        });
                    }
                    else {
                        $('input[name="categories[]"][pid="' + vid + '"]').each(function () {
                            $(this).attr('checked', false);
                        });
                    }
                }
            });
        });
        var ctry = '{$users.country}';
       //console.log(ctry);
        if (ctry != '') {

            $('#country').val(ctry);
            if ($('#country option[value="{$users.country}"]').length > 0) {
                loadLocation('country', $('#country option[value="{$users.country}"]').attr('attr'), '{$users.state}', '{$users.city}');
            }
        }
        var country = '{$users.country}';
        if (country != '') {
            $('#country').val(country);
            loadState();
        }

    });


    function checkEmailExist(email) {
       //console.log(email);
        if(email != '{$users.email}') {
            data = {
                email: email
            };
            $.ajax({
                datatype: 'json',
                type: "POST",
                url: "/register/check_email_exist",
                data: data,
                success: function (html) {
                   //console.log(html);
                    if (html.status) {
                        $('#divExisteEailReg').css('display', 'none');
                    } else {
                        $('#email').val('');
                        $('#divExisteEailReg').css('display', 'block');
                    }
                }
            });
        }else{
            return true;
        }
    }

    //Image uploading
    document.getElementById("uploadBtn").onchange = function () {
        var reader = new FileReader();
        reader.onload = function (e) {
            // get loaded data and render thumbnail.
            document.getElementById("pro_image").src = e.target.result;
           //console.log(JSON.stringify(e));
        };
        // read the image file as a data URL.
        reader.readAsDataURL(this.files[0]);
    };


</script>
