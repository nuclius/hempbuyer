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
        .auctiondisable{
            pointer-events:none
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
            <form enctype="multipart/form-data" class="admin_form" data-parsley-validate id="registration-form" method="post" enctype="multipart/form-data" onsubmit="return salestaxcheck()" action="{$config.url}/{$loged.adminUrl}/users/save">

                <input type="hidden" value="{$users.id}" name="id"/>

                <div class="row">
                  <div class="col-sm-4">
                    <div class="form-group">
                        <label>Profile Pic :</label><br/>

                        <div class="pro_image img-wrapper">
                        <img id="pro_image" src="{if $users.avatar == ''} {$config.url}/images/no_img.png {else if $users.avatar != ''}{$config['imgpath']}profile/{$users.avatar}{/if}"
                                width="82" title="{$users.first_name}" height="83" alt="{$val.title}"></a> </div> <br>
                        <div class="fileUpload btn btn-primary redbg5 w100"><span>Browse</span>
                            <input id="uploadBtn" type="file" class="upload" name="profile_image">
                            <!-- <input id="uploadBtn" type="file" class="upload" name="profile_image" data-parsley-trigger="change focusout" data-parsley-errors-container="#pro_img-err" {if(!($users.avatar))}  data-parsley-required-message="Please upload profile image" required {/if} > -->
                        </div>
                        <span id="pro_img-err" class="err-message"></span>
                        <!--input type="file" name="profile_image"-->
                    </div>
                  </div>
                  <div class="col-sm-8">

                    <div class="row">
                      <div class="col-sm-6">
                        <div class="form-group">
                            <label>Username :</label>
                            <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Username" value="{$users.username}"
                                   id="username" name="username" data-parsley-group="block1"  data-parsley-pattern-message="Invalid username" data-parsley-required required  tabindex="1">
                                   <span id="username-check-err" class="err-message"></span>
                        </div>
                      </div>
                      <div class="col-sm-6">
                        <div class="form-group">
                            <label>Business Name :</label>
                            <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Business Name" value="{$users.business_name}"
                                   id="business_name" name="business_name" data-parsley-group="block1"  data-parsley-pattern-message="Invalid business type" data-parsley-required required>
                        </div>
                      </div>
                    </div>

                    <div class="row">
                      <div class="col-sm-6">
                        <div class="form-group">
                              <label>Business Type :</label>
                          <select class="form-control {if $users.id>0}auctiondisable{/if}" data-parsley-trigger="change focusout" name="business_type" id="business_type" data-parsley-required-message="Please select Business type" place-holder="Business Type" data-parsley-required data-parsley-group="block3">
                            <option value="">Business Type</option>
                            <option value="grower" {if $users.business_type == 'grower'} selected {/if} >Grower</option>
                            <option value="producer" {if $users.business_type == 'producer'} selected {/if}>Producer</option>
                            <option value="dispensary" {if $users.business_type == 'dispensary'} selected {/if}>Dispensary</option>
                            <option value="supplier" {if $users.business_type == 'supplier'} selected {/if}>Supplier</option>
                          </select>

                        </div>
                      </div>
                      <div class="col-sm-6">
                        <div class="form-group">
                        <label>EIN No. :</label>
                          <input class="form-control" name="ein_number" data-parsley-trigger="change focusout" data-parsley-required class="form-control" type="text" data-parsley-type="number" data-parsley-minlength="9" data-parsley-maxlength="9" data-parsley-required-message="Please enter EIN number" placeholder="EIN N0." value="{$users.ein_number}"/>
                        </div>
                      </div>
                    </div>

                  </div>
                </div>

                <div class="row">
                  <div class="col-sm-6">
                    <div class="form-group">
                       <input type="hidden" name="license_image" value="{$users.license_img}">
                      <label class="lab-clr"> Upload Licence Here (*.jpeg, *.jpg, *.png etc.)</label>
                        <div style="overflow: hidden;" class="mt-15 img-wrapper">
                        <img id="license" src="{if $users.license_img == ''}{$config.url}/images/no_img.png{else if $users.license_img != ''}{$config['imgpath']}licenses/{$users.license_img}{/if}" height="100px" style="margin: auto; display: block;" />
                        </div>
                        <div class="reg_file_upload">
                          <input data-parsley-trigger="change focusout" type="file" id="licenses" name="licenses"  data-parsley-errors-container="#lic_img-err" {if(!($users.license_img))} data-parsley-required-message="Please Upload Licenses" required {/if} accept="image/*" data-parsley-fileextension='jpg jpeg gif png'/>
                        </div>

                        <span id="lic_img-err" class="err-message"></span>
                    </div>
                  </div>
                  <div class="col-sm-6">
                    <div class="form-group">
                      <input type="hidden" name="business_certificate" value="{$users.business_cert}">
                      <label class="lab-clr"> Upload Business Certificate Here (*.jpeg, *.jpg, *.png etc.)</label>
                        <div style="overflow: hidden;" class="mt-15 img-wrapper">

                          <img id="certificate" src="{if $users.business_cert == ''} {$config.url}/images/no_img.png {else if $users.business_cert != ''}{$config['imgpath']}certificates/{$users.business_cert}{/if}"
                          src="{$config.url}/images/no_img.png" height="100px" style="margin: auto; display: block;" />

                        </div>
                        <div class="reg_file_upload">
                          <input data-parsley-trigger="change focusout" type="file" id="certificates" name="certificates" {if(!($users.business_cert))} data-parsley-required-message="Please Upload Certificate" required {/if} data-parsley-trigger="change focusout" data-parsley-errors-container="#cert_img-err" accept="image/*" data-parsley-fileextension='jpg jpeg gif png'/>
                        </div>
                        <span id="cert_img-err" class="err-message"></span>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col-sm-6">
                    <div class="form-group">
                        <label>First Name :</label>
                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter First Name"
                        value="{$users.first_name}"
                               name="first_name" data-parsley-group="block1" data-parsley-pattern-message="Invalid username" data-parsley-required required>
                    </div>
                  </div>
                  <div class="col-sm-6">
                    <div class="form-group">
                        <label>Last Name :</label>
                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Last Name"
                        value="{$users.last_name}"
                               name="last_name" data-parsley-group="block1" data-parsley-pattern-message="Invalid username" data-parsley-required required data-parsley-trigger="blur">
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
                        <input class="form-control {if $users.id>0}auctiondisable{/if}" data-parsley-trigger="change focusout" data-parsley-type="email" name="email" type="email" value="{$users.email}" id="email" placeholder="Enter Email-ID" data-parsley-group="block1" data-parsley-required required>
                        <span id="email-check-err" class="err-message"></span>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col-sm-6">
                    <div class="form-group">
                        <label>Password :
                            <small>(leave empty to keep same)</small>
                        </label>
                        <input type="password" data-parsley-trigger="change focusout" class="form-control" name="password" id="password"
                               data-parsley-group="block1" id="password" name="password" data-parsley-minlength="6"
                               data-parsley-minlength-message="Please enter a minimum of 6 characters"
                               data-parsley-length-message="Please enter a minimum of 6 characters"
                               data-parsley-type-message="Password should be alphanumeric" {if !$users.id} data-parsley-required required {/if} data-parsley-trigger="blur">
                    </div>
                  </div>
                  <div class="col-sm-6">
                    <div class="form-group">
                        <label>Confirm Password :</label>
                        <input type="password" data-parsley-trigger="change focusout" class="form-control" name="cpassword" data-parsley-group="block1" data-parsley-equalto="#password" data-parsley-minlength="6"
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
                        <select data-parsley-trigger="change focusout" class="form-control {if $users.id>0}auctiondisable{/if}" name="country" id="country"
                            data-parsley-required-message="Please select country"
                            data-parsley-message="Please select country" required data-parsley-trigger="blur">
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
                        <select id="state" data-parsley-trigger="change focusout"  name="state" class="form-control {if $users.id>0}auctiondisable{/if}"
                                data-parsley-required-message="Please select state" data-parsley-trigger="blur" required>
                            <option val="">Select State</option>
                            {if $users.state != ''}
                                <option value="{$users.state}" selected>{$users.state}</option>
                                {/if}
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
                        <input type="text" data-parsley-trigger="change focusout" id="city" name="city" placeholder="Enter your city" class="form-control {if $users.id>0}auctiondisable{/if}"
                               value="{$users.city}" title="City" maxlength="50"
                               data-parsley-required-message="Please enter city" data-parsley-trigger="blur" required>
                    </div>
                  </div>
                  <div class="col-sm-6">
                    <div class="form-group">
                              <label>Region :</label>
                              <select class="form-control {if $users.id>0}auctiondisable{/if}" name="region" id="region"  data-parsley-required data-parsley-required-message="Please select region" place-holder="Select Region"  data-parsley-required>
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
                        <input data-parsley-trigger="change focusout" type="text" id="address_line1" name="address1" placeholder="Enter your address"
                               class="form-control" value="{$users.address1}"
                               title="Address Line 1" maxlength="50" data-parsley-trigger="blur" data-parsley-required data-parsley-required-message="Please enter address" >
                    </div>
                  </div>
                  <div class="col-sm-6">
                    <div class="form-group">
                        <label for="inputEmail">Zipcode :</label>
                        <input data-parsley-trigger="change focusout" type="text" id="zipcode" name="zip" placeholder="Enter zipcode" min="5" class="form-control" value="{$users.zip}" title="Zipcode" maxlength="10" data-parsley-trigger="blur" data-parsley-required-message="Please enter zipcode" {if !$users.zip} required{else} disabled {/if}>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col-sm-6">
                    <div class="form-group">
                        <label>About me :</label>
                        <textarea data-parsley-trigger="change focusout" class="form-control" rows="3" name="aboutme"
                                  data-parsley-group="block1">{$users.aboutme}</textarea>
                    </div>
                  </div>
                  <div class="col-sm-6">
                    <div  class="form-group cus-radio">
                        <label>Sales tax :</label>
                            <div class="radio radio-inline radio-primary ">
                                <input data-parsley-trigger="change focudsout" type="radio" name="stax" id="stax1" value="y" {if $users.stax == 'y'} checked="true" {/if} data-parsley-required-message="Please select one option" required>
                                <label for="stax1"> Yes </label>
                                <input data-parsley-trigger="change focusout" type="radio" name="stax" id="stax2" value="n" {if $users.stax == 'n'} checked="true" {/if} data-parsley-required-message="Please select one option" required>
                                <label for="stax2"> No </label>
                            </div>
                    </div>
                    <div class="form-group">
                      <div id="staxSetting" class="form-group">
                            <label for="inputEmail">Enter the sales tax percentage : </label>
                              <input data-parsley-trigger="change focusout" class="form-control"
                              name="stax_per"
                              id="stax_per"  
                              class="form-control"
                              type="text"
                              data-parsley-type="number"
                              data-parsley-min="1"
                              data-parsley-min-message="Please enter value more than or equal to 1"
                              placeholder="Sales tax (%)"
                              {if $users.stax == 'y'} value="{$users.stax_per}" {/if}/>
                        </div>
                    </div>


                    <div class="form-group">
                      <div id="default_provider_q" class="form-group form-inline text-left">
                          <label class="lab-clr">Do you want to use Herbee as the default provider for your distribution needs?</label>
                            <div class="radio radio-inline radio-primary ">
                              <input data-parsley-trigger="change focusout" type="radio" name="default_provider" id="default_provider1" {if $users.default_provider == 'y'} checked {/if} value="y">
                              <label for="default_provider1"> Yes </label>
                              <input data-parsley-trigger="change focusout" type="radio" name="default_provider" id="default_provider2" value="n" {if $users.default_provider == 'n'} checked {/if}>
                              <label for="default_provider2"> No </label>
                            </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <div id="default_transport_q" class="form-group form-inline text-left">
                          <label class="lab-clr">Would you like to select Herbee as your default transport service provider?</label>
                            <div class="radio 
                            radio-inline radio-primary ">
                              <input data-parsley-trigger="change focusout" type="radio" name="default_transport" id="default_transport1" value="y" {if $users.default_transport == 'y'} checked {/if}>
                              <label for="default_transport1"> Yes </label>
                              <input data-parsley-trigger="change focusout" type="radio" name="default_transport" id="default_transport2" value="n" {if $users.default_transport == 'n'} checked {/if}>
                              <label for="default_transport2"> No </label>
                            </div>
                      </div>
                    </div>


                  </div>
                </div>
                <div class="row">
                  <div class="col-sm-12">
                    <input id="adminsub_button" type="submit" class="btn btn-success submit_form pull-right" value="submit">
                  </div>
                </div>

        </form>
        </div>
    </div>

    <!-- /.row -->
</div>
{include file="/admincp/footer.tpl" nocache}
<script src="{$config['externaljs']}scripts.js" type="text/javascript"></script>
<script>

$('input[type=radio][name=stax]').change(function() {
    // //console.log('running');
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

$('#certificates').filestyle({
    input: false,
    buttonName: 'btn btn-default btn-d-b btn-d-g m5',
    iconName: '',
    buttonText: 'UPLOAD'
});

$('#licenses').filestyle({
    input: false,
    buttonName: 'btn btn-default btn-d-b btn-d-g m5',
    iconName: '',
    buttonText: 'UPLOAD'
});

   function chooseCert() {
      $("#certificates").click();
   }
   function chooseLic() {
      $("#licenses").click();
   }
</script>

<script language="javascript" type="text/javascript">
document.getElementById("licenses").onchange = function () {

  if(projectLoad1(this)){
    var reader = new FileReader();

    reader.onload = function (e) {
        ////console.log(e);
        // get loaded data and render thumbnail.
        document.getElementById("license").src = e.target.result;
    };

    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
} else {
    $(this).val('');
    $(this).parents().find(".badge").remove();
    document.getElementById("license").src = "{$config.url}/images/no_img.png"
    // error message here
    // alert("not an image");
}


};

document.getElementById("certificates").onchange = function () {
  if(projectLoad1(this)){

      var reader = new FileReader();

      reader.onload = function (e) {
        ////console.log(e);
          // get loaded data and render thumbnail.
          document.getElementById("certificate").src = e.target.result;
      };

      // read the image file as a data URL.
      reader.readAsDataURL(this.files[0]);
  } else {
      $(this).val('');
      $(this).parents().find(".badge").remove();
      document.getElementById("certificates").src = "{$config.url}/images/no_img.png"
      // error message here
      // alert("not an image");
  }

};

    function checkStateCity(form, id) {
        ////console.log(id);
        ////console.log("http://maps.googleapis.com/maps/api/geocode/json?address=" + $('#' + form + ' #zipcode').val());
        var params = {};
        if (window.XDomainRequest) {
            if (window.XDomainRequest) {
                var xdr = new XDomainRequest();
                var query = "http://maps.googleapis.com/maps/api/geocode/json?address=" + $('#' + form + ' #zipcode').val();
                if (xdr) {
                    xdr.onload = function () {
                        ////console.log(JSON.parse(xdr.responseText));
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
        if(projectLoad1(this)){
            
            var reader = new FileReader();
            reader.onload = function (e) {
                // get loaded data and render thumbnail.
                document.getElementById("pro_image").src = e.target.result;
                //console.log(JSON.stringify(e));
            };
            // read the image file as a data URL.
            reader.readAsDataURL(this.files[0]);
        } else {
            $(this).val('');
            $(this).parents().find(".badge").remove();
            document.getElementById("pro_image").src = "{$config.url}/images/no_img.png"
            // error message here
            // alert("not an image");
        }

    };

    function salestaxcheck(){
     if($('#stax1').is(':checked') && $('#stax_per').val() <= 0) {
      swal('Invalid Sales Tax Value');
      return false;
     }else{
      return true;
     }
    }

</script>
