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
                <li class="active"><i class="fa fa-user"></i> <i class="fa fa-angle-double-right"></i> <i
                        class="fa fa-edit"></i> {if $users.id == 0 or $users.id == ''} Add {else} View/Edit {/if} Users <i
                        class="fa fa-angle-double-right"></i> {$users.first_name} {$users.last_name}
                </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-8">
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
            <form enctype="multipart/form-data" class="admin_form" data-parsley-validate id="registration-form" method="post" enctype="multipart/form-data" action="{$config.url}/admincp/users/save">
            <!-- <form enctype="multipart/form-data" class="admin_form" data-parsley-validate id="admin_form" method="post" enctype="multipart/form-data" action="{$config.url}/admincp/users/save"> -->
                <input type="hidden" value="{$users.id}" name="id"/>

                <div class="form-group">
                    <label>Profile Pic</label><br/>

                    <div class="pro_image">
                    <img id="pro_image" src="{if $users.avatar == ''} {$config.url}/images/no_img.png {else if $users.avatar != ''}{$config['imgpath']}profile/{$users.avatar}{/if}"
                            width="82" title="{$users.first_name}" height="83" alt="{$val.title}"></a> </div>
                    <div class="fileUpload btn btn-primary redbg5"><span>Browse</span>
                        <input id="uploadBtn" type="file" class="upload" name="profile_image" {if(!($users.avatar))} {/if}>
                    </div>

                    <!--input type="file" name="profile_image"-->
                </div>
                <div class="form-group">
                    <label>Username</label>
                    <input class="form-control" placeholder="Enter First Name" value="{$users.username}"
                           id="username" name="username" data-parsley-group="block1"  data-parsley-pattern="^[A-Za-z]*$" pattern="^[A-Za-z]*$" data-parsley-pattern-message="Invalid username" data-parsley-required required>
                           <span id="username-check-err" class="err-message"></span>
                </div>
                <div class="form-group">
                    <label>First Name</label>
                    <input class="form-control" data-parsley-trigger="blur" placeholder="Enter First Name" value="{$users.first_name}"
                           name="first_name" data-parsley-group="block1" data-parsley-pattern="^[A-Za-z]*$" pattern="^[A-Za-z]*$" data-parsley-pattern-message="Invalid username" data-parsley-required required>
                </div>
                <div class="form-group">
                    <label>Last Name</label>
                    <input class="form-control" placeholder="Enter Last Name" value="{$users.last_name}"
                           name="last_name" data-parsley-group="block1" data-parsley-pattern="^[A-Za-z]*$" pattern="^[A-Za-z]*$" data-parsley-pattern-message="Invalid username" data-parsley-required required data-parsley-trigger="blur">
                </div>
                <div class="form-group">
                    <label for="inputEmail">Phone Number:</label>
                    <div>
                        <input data-parsley-errors-container="#phone_err"  class="form-control" placeholder="Cellphone Number" value="{$users.phone}" name="phone" maxlength="18" data-parsley-required required data-parsley-trigger="blur" data-mask="000-000-0000" data-parsley-minlength="12" data-parsley-minlength-message="Enter the 10 digit phone number">

<!--                         <input  class="w100 p15 pb15 grey-bg border-0"  data-parsley-trigger="change focusout"  type="text" id="phone" data-mask="000-000-0000" name="phone" placeholder="Phone" data-parsley-minlength="12" data-parsley-minlength-message="Enter the 10 digit phone number"
                                data-parsley-required-message="Please enter Phone Number" class="form-control"
                                data-required="true" data-parsley-required
                                data-parsley-errors-container="#phone-err" data-parsley-group="block1" value="{$users.phone}"/> -->

                        <span id="valid-msg" style="color:#075A0B;" class="hide phone_valid"> Valid</span>
                        <span id="error-msg" style="color:#F00;" class="hide phone_valid">Invalid number</span>
                    </div>
                    <span id="phone_err"></span>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input class="form-control" data-parsley-type="email" name="email" type="email" value="{$users.email}" id="email" data-parsley-group="block1" data-parsley-required required>
                    <span id="email-check-err" class="err-message"></span>
                </div>
                <div class="form-group">
                    <label>Password
                        <small>(leave empty to keep same)</small>
                    </label>
                    <input type="password" class="form-control" name="password" id="password"
                           data-parsley-group="block1" id="password" name="password" data-parsley-minlength="6"
                           data-parsley-minlength-message="Please enter a minimum of 6 characters"
                           data-parsley-length-message="Please enter a minimum of 6 characters"
                           data-parsley-type-message="Password should be alphanumeric" {if !$users.id} data-parsley-required required {/if} data-parsley-trigger="blur">
                </div>
                <div class="form-group">
                    <label>Confirm Password</label>
                    <input type="password" class="form-control" name="cpassword" data-parsley-group="block1" data-parsley-equalto="#password" data-parsley-minlength="6"
                           data-parsley-minlength-message="Please enter a minimum of 6 characters"
                           data-parsley-length-message="Please enter a minimum of 6 characters"
                           data-parsley-type-message="Password should be alphanumeric" {if !$users.id} data-parsley-required required {/if} data-parsley-trigger="blur">
                </div>

                <div class="form-group">
                    <label>Country:</label>
                    <select class="form-control" name="country" id="country"
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

                <div class="form-group">
                    <label>State:</label>
                    <select id="state" name="state" class="form-control"
                            data-parsley-required-message="Please select state" data-parsley-required required data-parsley-trigger="blur">
                        <option val="">Select State</option>
                        {if $users.state != ''}
                            <option value="{$users.state}" selected>{$users.state}</option>
                            {/if}
                        {if $users.state != ''}
                        <option value="{$users.state}" selected>{$users.state}</option>
                        {/if}
                    </select>
                </div>

                <div class="form-group">
                    <label>City:</label>
                    <input type="text" id="city" name="city" placeholder="Enter your city" class="form-control"
                           value="{$users.city}" title="City" maxlength="50"
                           data-parsley-required-message="Please enter city" data-parsley-trigger="blur">
                </div>

<!--
    <input type="hidden" name="hidden_country" id="hidden_country" value="{$users.country}">
    <input type="hidden" name="hidden_state" id="hidden_state" value="{$users.state}">
                -->


                <div class="form-group">
                    <label for="inputEmail">Address Line 1:</label>
                    <input type="text" id="address_line1" name="address1" placeholder="Enter your address line1"
                           class="form-control" value="{$users.address1}"
                           title="Address Line 1" maxlength="50" data-parsley-trigger="blur">
                </div>
                <div class="form-group">
                    <label for="inputEmail">Address Line 2:</label>
                    <input type="text" id="address_line2" name="address2" placeholder="Enter your address line2"
                           class="form-control" value="{$users.address2}"
                           title="Address Line 2" maxlength="50" data-parsley-trigger="blur">
                </div>


                <div class="form-group">
                    <label for="inputEmail">Zipcode:</label>
                    <input type="text" id="zipcode" name="zip" placeholder="Enter zipcode" class="form-control"
                           value="{$users.zip}" title="Zipcode" maxlength="10" data-parsley-trigger="blur">
                </div>

                <!--<div class="form-group addresscity">{if ($users.city)} {$users.city}{$users.state} {$users.country} {/if}</div>
                <input type="hidden" name="state" id="state" value="{$users.state}" />
                <input type="hidden" name="country" id="country" value="{$users.country}" />
                <input type="hidden" name="city" id="city" value="{$users.city}" />-->
<!--                 <div class="form-group">
                    <label for="inputEmail">Profile Url:</label>
                    <input class="form-control" placeholder="Enter Url" name="profile_url" value="{$users.profile_url}">
                </div>
                <div class="form-group">
                    <label for="inputEmail">Paypal Address:</label>
                    <input class="form-control" placeholder="Paypal E-mail" name="paypal_address"
                           value="{$users.paypal_address}">
                </div> -->
                <div class="form-group">
                    <label>Status</label>
                    <select class="form-control" name="status" data-parsley-group="block1" data-parsley-required required data-parsley-trigger="blur">
                        <option value="active" {if $users.status==
                        'active'} selected {/if}>Active</option>
                        <option value="moderate" {if $users.status==
                        'moderate'} selected {/if}>Moderate</option>
                        <option value="deactivate" {if $users.status==
                        'deactivate'} selected {/if}>Deactivate</option>
                        <option value="unsubscribe" {if $users.status==
                        'unsubscribe'} selected {/if}>Unsubscribe</option>
                        <option value="unverified" {if $users.status==
                        'unverified'} selected {/if}>Unverified</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>About me</label>
                    <textarea class="form-control" rows="3" name="aboutme"
                              data-parsley-group="block1" data-parsley-trigger="blur" data-parsley-pattern="^[A-Za-z ]*$" pattern="^[A-Za-z ]*$" >{$users.aboutme}</textarea>
                </div>
<!--                 <div class="form-group">
                    <label for="inputEmail">Select Categories you are interested:</label>
                </div>
                <div class="form-group">

                    {foreach $category as $key => $val} <span class="col-sm-3 w-100">
      <input type="checkbox" name="categories[]" value="{$val.id}" pid="{$val.parent_id}" class="m-left-6"/>
      <span class="p-left-5">{$val.name} </span> </span> {/foreach}

                    <div class="clear"></div>
                </div> -->

                <input id="adminsub_button" type="submit" class="btn btn-success submit_form" value="submit">

        </form>
        </div>
    </div>

    <!-- /.row -->
</div>
{include file="/admincp/footer.tpl" nocache}
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

        //alert($.inArray($(this).val(), initValues));
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
            //loadLocation('state',$('#states option[value="{$users.state}"]').val(),'{$users.city}');
        }
//loadProfilePage();
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
