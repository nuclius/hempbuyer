{include file="common/header-1.tpl" nocache}
<!-- Page content -->
{include file="common/dashboard-navigation.tpl" nocache}
<div class="container-fluid grey-bg xs-pdlr">

  <div class="container dashboard-settings-con m50">

    <div class="row">
      <!-- common sidebar here -->
      <div class="col-md-3 sidebar  mb-25  mb-25"> 
        <div class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown">Profile <i class="fa fa-angle-down"></i></a>
          {include file="common/dashboard_settings_menu.tpl" nocache}
        </div>
      </div> 
      <!-- / Sidebar -->

      <div class="col-md-9 content-area">

        <div class="row">
          <div class="panel panel-success m5 m-t-0">

              <div class="panel-heading green-bg">
                  <h3>Profile</h3>
              </div>

          </div>
          <div class="col-md-12 white-bg-2 p35 shadow">

            <!-- <form class="form-horizontal" action=""> -->
            <form action="/profile_settings/update" method="POST" class="form-horizontal registration-form" id="user_profile" enctype="multipart/form-data" data-parsley-validate>

                <input type="hidden" name="country" value="{$users.country}">
                <input type="hidden" name="address" value="{$users.address}">
                <input type="hidden" name="state" value="{$users.state}">
                <input type="hidden" name="city" value="{$users.city}">
                <input type="hidden" name="region" value="{$users.region}">
                <input type="hidden" name="zip" value="{$users.zip}">

              <div class="row">
               <!--  <div class="col-md-12">
                    Note : Default address can not be change. Please contact the customer support for reference.<br>
                </div> -->
              </div>
                <div class="row m-20">
                    <div class="col-md-12">

                        <div class="form-group">
                          <div class="col-lg-2 col-md-3 col-sm-3">
                              <div class="pro-thumb hide-badge">
                                    <!-- <input type="file" id="filecount" multiple="multiple"> -->
                                    {if $users.avatar != ''}
                                    <img id="profile_img" src="{$config.imgpath}profile/{$users.avatar}" class="img-responsive display-block margin-auto mb-10" alt="">
                                    {/if}
                                    {if $users.avatar == ''}
                                    <img id="profile_img" src="{$config.url}/images/no_img.png" class="img-responsive display-block margin-auto mb-10" alt="">
                                    {/if}
                                    <div class="text-center">
                                      <span class="f12 m5" ><i>Select Profile Image (*.jpeg, *.jpg, *.png etc.)</i></span>
                                      <input name="profile_image" type="file" id="profile_image" value="test" accept="image/*">
                                    </div>
                              </div>
                          </div>
                          <div class="col-lg-10 col-md-9 col-sm-9 col-lg-offset-0">
                            <label>About Me</label>
                            <textarea class="grey-bg w100 border-0 p15 pb15" placeholder="About Me" name="aboutme" rows="6" cols="80">{$users.aboutme}</textarea>

                            {if $loged.business_type == 'grower' || $loged.business_type == 'producer'}
                            <div class="rating green-text">
                                <b>Seller Rating:</b> <span class="stars" align="left">{$seller_rating}</span>
                            </div>
                            {/if}
                            {if $loged.business_type == 'dispensary'}
                            <div class="rating green-text">
                                <b>Buyer Rating:</b> <span class="stars" align="left">{$buyer_rating}</span>
                            </div>
                            {/if}
                          </div>
                        </div>
                        <!-- for business type and name -->
                        <div class="form-group">
                          <div class="col-sm-6">
                          <label>Business Name </label>
                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="business_name" placeholder="NA" name="business_name" value="{$users.business_name}" >
                          </div>
                          <div class="col-sm-6">
                          <label>Business Type </label>
                            <input class="w100 p15 pb15 grey-bg border-0" type="text"  class="form-control" id="business_name" placeholder="NA" name="business_name" value="{$users.business_type}" disabled style="text-transform: capitalize; color : gray">
                          </div>
                        </div>
                        <div class="form-group">
                          <div class="col-sm-6">
                            <label>User Name</label>
                            <input class="w100 p15 pb15 grey-bg border-0" type="text"  data-parsley-trigger="change" data-parsley-required class="form-control" id="username" placeholder="Username" data-parsley-pattern="^[A-Za-z0-9]*$" data-parsley-pattern-message="Invalid Username." name="username" value="{$users.username}">
                            <span id="username-check-err" class="err-message"></span>
                          </div>
                          <div class="col-sm-6">
                           <label>Email-ID</label>
                            <input class="w100 p15 pb15 grey-bg border-0" data-parsley-trigger="change focusout"  data-parsley-type="email" data-parsley-required type="email" class="form-control" id="email" placeholder="Email" name="email" value="{$users.email}">
                            <span id="email-check-err"  class="err-message"></span>
                          </div>
                        </div>

                        <div class="form-group">
                          <div class="col-sm-6">
                            <label>First Name </label>
                            <input class="w100 p15 pb15 grey-bg border-0" data-parsley-trigger="change focusout" type="text"  data-parsley-required class="form-control" id="first_name" placeholder="First Name"  data-parsley-pattern="^[A-Za-z0-9]*$" data-parsley-pattern-message="Invalid first name." name="first_name" value="{$users.first_name}">
                          </div>
                          <div class="col-sm-6">
                            <label>Last Name </label>
                            <input class="w100 p15 pb15 grey-bg border-0" data-parsley-trigger="change focusout"  data-parsley-required type="text" data-parsley-pattern="^[A-Za-z0-9]*$"  data-parsley-pattern-message="Invalid last name." class="form-control" id="last_name" placeholder="Last Name" name="last_name" value="{$users.last_name}">
                          </div>
                        </div>



<!--                         <div class="form-group">

                          <div class="col-sm-6">
                            <input class="w100 p15 pb15 grey-bg border-0"  data-parsley-required type="text" class="form-control" id="profile_url" placeholder="Enter URL" name="profile_url" value="{$users.profile_url}">
                          </div>
                        </div> -->
                        <div class="form-group">
                            <div class="col-md-6">
                                <label>Country</label>
                                <select class="w100 p15 pb15 grey-bg border-0"
                                {if $user.country == ''} data-parsley-required name="country" id="country" data-parsley-required-message="Please select country" data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#country-err"
                                {/if} disabled="true" style="color : gray">
                                    {if $users.country != ''}
                                    <option value="{$users.country}" selected>{$users.country}</option>
                                    {/if}
                                    {if $users.country == ''}
                                    <option value="" selected>Select Country</option>
                                    {/if}
                                </select>
                                <span id="country-err" class="err-message"></span>
                            </div>
                            <div class="col-md-6">
                            <label>State</label>
                              <select class="w100 p15 pb15 grey-bg border-0"
                              {if $user.state == ''} data-parsley-required name="state" id="state" data-parsley-required-message="Please select state"
                              data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#state-err"
                              {/if} disabled="true" style="color : gray"/>
                                    {if $users.state != ''}
                                    <option value="{$users.state}" selected>{$users.state}</option>
                                    {/if}
                                    {if $users.state == ''}
                                    <option value="" selected>Select state</option>
                                    {/if}
                              </select>
                              <span id="state-err" class="err-message"></span>
                            </div>
                        </div>

                        <div class="form-group">
                          <div class="col-sm-6">
                          <label>City</label>
                            <input class="w100 p15 pb15 grey-bg border-0"  data-parsley-required type="text" class="form-control" data-parsley-pattern="^[A-Za-z]*$" pattern="^[A-Za-z]*$" data-parsley-pattern-message="Invalid city" id="city" placeholder="City" name="city" value="{$users.city}" disabled="true" style="color : gray">
                          </div>
                          <div class="col-sm-6">
                          <label>Region</label>
                          <select class="w100 p15 pb15 grey-bg border-0" name="region" id="region"  data-parsley-required data-parsley-required-message="Please select region" place-holder="Select Region"  data-parsley-required disabled="true">
                                  <option value="">Select Region</option>
                                  <option {if $users.region=='north west'} selected {/if} value="north west">North West</option>
                                  <option {if $users.region=='south west'} selected {/if} value="south west">South West</option>
                                  <option {if $users.region=='north east'} selected {/if} value="north east">North East</option>
                                  <option {if $users.region=='north east'} selected {/if} value="south east">South East</option>
                              </select>
                          </div>
                        </div>
                        <div class="form-group">
                          <div class="col-sm-6">  
                                <label>Phone Number</label>
                                <input  class="w100 p15 pb15 grey-bg border-0"   data-parsley-trigger="change focusout"  type="text" id="phone" data-mask="000-000-0000" name="phone" placeholder="Phone" data-parsley-minlength="12" data-parsley-minlength-message="Enter the 10 digit phone number"
                                data-parsley-required-message="Please enter Phone Number" class="form-control"
                                data-required="true" data-parsley-required
                                data-parsley-errors-container="#phone-err" data-parsley-group="block1" value="{$users.phone}"/>
                               
                              <span id="valid-msg" style="color:#075A0B;" class="hide"> {$phrase.valid}</span>
                              <span id="error-msg" style="color:#F00;" class="hide">{$phrase.invalid_number}</span>
                            
                          </div>
                          <div class="col-sm-6">
                            <label>Zip Code</label>
                              <!-- <input class="w100 p15 pb15 grey-bg border-0"  data-parsley-required type="text" class="form-control" id="zip" placeholder="Zip Code" name="zip" value="{$users.zip}"> -->
                              <input data-parsley-trigger="change focusout" class="w100 p15 pb15 grey-bg border-0" id="zip" type="text" name="zip" maxlength="6"
                            data-parsley-maxlength="6" data-parsley-maxlength-message="Enter the 5-6 character zip code"
                            data-parsley-minlength="5" data-parsley-minlength-message="Enter the 5-6 character zip code"
                            data-parsley-required-message="Please enter zip code" placeholder="Zip Code" class="form-control" data-required="true" data-parsley-required value="{$users.zip}" disabled="true" style="color : gray"/>
                          </div>
                        </div>
                        <div class="form-group">
                          <div class="col-sm-12">
                            <label>Address</label>
                            <textarea class="grey-bg w100 border-0 p15 pb15" data-parsley-pattern="^[a-zA-Z0-9,\n ]*$" pattern="^[a-zA-Z0-9,\n ]*$" data-parsley-pattern-message="Invalid Address" data-parsley-required placeholder="Address" name="address" rows="6" cols="80" style="color : gray">{$users.address1}</textarea>
                          </div>
                        </div>

<div class="form-group">
                          <div class="col-sm-12">  
                        <div id="default_provider_q" class="form-group form-inline text-left">
                            <label class="lab-clr">Do you want to use Herbee as the default provider for your distribution needs?</label>
                              <div class="radio radio-inline radio-primary ">
                                <input data-parsley-trigger="change focusout" type="radio" name="default_provider" id="default_provider1" {if $users.default_provider == 'y'} checked {/if} value="y" tabindex="6">
                                <label for="default_provider1"> Yes </label>
                                <input data-parsley-trigger="change focusout" type="radio" name="default_provider" id="default_provider2" value="n" tabindex="7" {if $users.default_provider == 'n'} checked {/if}>
                                <label for="default_provider2"> No </label>
                              </div>
                        </div>
                        </div>
                        </div>
                        <div class="form-group">
                          <div class="col-sm-12"> 
                        <div id="default_transport_q" class="form-group form-inline text-left">
                            <label class="lab-clr">Would you like to select Herbee as your default transport service provider?</label>
                              <div class="radio radio-inline radio-primary ">
                                <input data-parsley-trigger="change focusout" type="radio" name="default_transport" id="default_transport1" value="y" tabindex="6" {if $users.default_transport == 'y'} checked {/if}>
                                <label for="default_transport1"> Yes </label>
                                <input data-parsley-trigger="change focusout" type="radio" name="default_transport" id="default_transport2" value="n" tabindex="7" {if $users.default_transport == 'n'} checked {/if}>
                                <label for="default_transport2"> No </label>
                              </div>
                        </div>
                        </div>
                        </div>

                        <div class="row flex">
                            <div class="col-sm-2 margin-auto">
                              <button class="btn btn-default btn-d-b green-b m0 btn-next" type="submit">SAVE</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

          </div>

        </div>

      </div>
      <!-- / Content Area -->


    </div>
    <!-- Parent Row -->

  </div>
  <!-- dashboard-settings-con -->

</div>



<!--/ Page content -->




{include file="common/footer-1.tpl" nocache}


<!-- <script src="js/custom.js"></script>
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/aos.js"></script>
<script src="js/owl.carousel.min.js"></script> -->
<!-- <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/owl.carousel.min.js"> -->

<!-- </script> -->
<!-- <script src="js/bootstrap-filestyle.min.js"></script> -->


<script>
    // $(function () {
    //     var ctry = '{$shipping.country}';
    //     if (ctry != '')
    //         $('#country').val(ctry);
    // });

 $(function () {
        ////console.log("{$users}");
        populateCountries("country", "state");
        var ctry = '{$users.country}';
        if (ctry != '')
            $('#country').val(ctry);
        loadState();
    });


$('#filecount').filestyle({
     input : true,
     buttonName : '',
     iconName : 'fa fa-pencil',
     buttonText: ''
    });

    $('#profile_image').filestyle({
     input : false,
     buttonName : 'btn btn-default btn-d-b btn-d-g m5',
     iconName : '',
     buttonText: 'UPLOAD'
    });

document.getElementById("profile_image").onchange = function () {

if(projectLoad1(this)){
     var reader = new FileReader();

    reader.onload = function (e) {
        // get loaded data and render thumbnail.
        document.getElementById("profile_img").src = e.target.result;
    };

    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
} else {
    $(this).val('');
    $(this).parents().find(".badge").remove();
    document.getElementById("profile_img").src = "{$config.url}/images/upload-img.png"
    // error message here
    // alert("not an image");
}
     
   
};

          // $('#business_type').val('{$user.business_type}').change();


</script>

</body>
</html>
