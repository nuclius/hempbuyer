<style>
  #slider-range{width:400px;}
  #slider-range,#time{margin:10px;display:block;}
</style>
{include file="common/header-1.tpl" nocache}

<!-- Page content -->

{include file="common/dashboard-navigation.tpl" nocache}

<div class="container-fluid grey-bg xs-pdlr">

  <div class="container dashboard-settings-con m50">

    <div class="row">

      <!-- common sidebar here -->
      <div class="col-md-3 sidebar  mb-25  mb-25">
        <div class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown">Shipping Info <i class="fa fa-angle-down"></i></a>
          {include file="common/dashboard_settings_menu.tpl" nocache}
        </div>
      </div>
      <!-- / Sidebar -->

      <div class="col-md-9 content-area">

        <div class="row">
          <div class="panel panel-success m5 m-t-0">

              <div class="panel-heading green-bg">
                  <h3>Shipping Info</h3>
              </div>

          </div>
          <div class="col-md-12 white-bg-2 p35 shadow">
          {if $updation_status}
            <div class="alert alert-success">
                <strong>Success!</strong> &nbsp;&nbsp;" Shipping details updated successfully!"
            </div>
            {/if}

            <!-- <form class="form-horizontal" action="/action_page.php"> -->
            <form name="" action="{$config.url}/profile_settings/shipping" data-parsley-validate method="post" id="paypal-form" class="form-horizontal">
                <div class="row">
                    <div class="col-md-12">

                     
                        {if !$shipping.email && !$shipping.first_name && !$shipping.last_name && !$shipping.address && !$shipping.city && !$shipping.state && !$shipping.zipcode && !$shipping.phone}
                            <p class="description text-center green-text m20">No Current Shipping Address Found</p>
                        {else\} 
                            <p class="description text-center green-text m20">Current Shipping addresses</p>
                        {/if}
                        <div class="row form-group">

                          <div class="col-md-12">
                          
                            <h5 class="f700">{$shipping.first_name} {if $shipping.last_name}{$shipping.last_name}{/if}</h5>
                            <ul class="p0">
                              <li>{$shipping.address}</li>
                              <li>{if $shipping.city}{$shipping.city}, {/if}{if $shipping.state}{$shipping.state}, {/if}{$shipping.zipcode}</li>
                              <li>{$shipping.country}</li>
                              <li>&nbsp;</li>
                              <li>{$shipping.email}</li>
                              <li>{$shipping.phone}</li>

                            </ul>

                            <hr>

                          </div>

                        </div>

                        <div class="row form-group">
                        <div class="col-md-12">
                          <p class="description text-center green-text m20">Change Shipping addresses</p>
                        </div>
                          <div class="col-sm-6">
                            <input type="text" class="w100 p15 pb15 grey-bg border-0" name="f_name" placeholder="First Name*" data-parsley-pattern="^[A-Za-z]*$" pattern="^[A-Za-z]*$" data-parsley-pattern-message="Invalid first name." value="{$shipping.first_name}" data-parsley-required/>
                          </div>
                          <div class="col-sm-6">
                            <input type="text" class="w100 p15 pb15 grey-bg border-0" name="l_name" placeholder="Last Name*" value="{if $shipping.last_name}{$shipping.last_name}{/if}" data-parsley-pattern="^[A-Za-z]*$" pattern="^[A-Za-z]*$" data-parsley-pattern-message="Invalid last name." data-parsley-required>
                          </div>
                        </div>
                        <div class="row form-group">
                          <div class="col-sm-12">
                                <input data-parsley-trigger="change focusout" class="w100 p15 pb15 grey-bg border-0" type="email" id="email" name="email" data-parsley-required-message="Please enter Email ID" placeholder="Business Email" class="form-control" data-required="true" data-parsley-required value="{$shipping.email}"/>

                          </div>
                          </div>
                     
                        <div class="row form-group">
                          <div class="col-md-6">
                              <select {if $user.country != ''} disabled {/if} class="w100 p15 pb15 grey-bg border-0"
                              {if $user.country == ''} data-parsley-required name="country1" id="country" data-parsley-required-message="Please select country" data-parsley-required data-parsley-errors-container="#country-err"{/if}/>
                                  {if $shipping.country != ''}
                                  <option value="{$shipping.country}" selected>{$shipping.country}</option>
                                  {/if}
                                  {if $shipping.country == ''}
                                  <option value="" selected>Select Country</option>
                                  {/if}
                              </select>
                              {if $shipping.country!=''}
                                <input type="hidden" name="country" value="{$shipping.country}">
                              {/if}
                              <span id="country-err" class="err-message"></span>
                          </div>
                          <div class="col-md-6">
                              <select {if $user.state != ''} disabled {/if} class="w100 p15 pb15 grey-bg border-0"
                              {if $user.state == ''} data-parsley-required name="state1" id="state" data-parsley-errors-container="#state-err" {/if}
                              >
                                    {if $shipping.state != ''}
                                    <option value="{$shipping.state}" selected>{$shipping.state}</option>
                                    {/if}
                                    {if $shipping.state == ''}
                                    <option value="" selected>Select state</option>
                                    {/if}
                              </select>
                              {if $shipping.state!=''}
                                <input type="hidden" name="state" value="{$shipping.state}">
                              {/if}
                              <span id="state-err" class="err-message"></span>
                            </div>
                        </div>
              
                      
                        
                        <div class="row form-group">
                          <div class="col-sm-6">
                                <input type="text" class="w100 p15 pb15 grey-bg border-0" name="phone" placeholder="Cell Phone*" value="{$shipping.phone}" data-mask="000-000-0000" data-parsley-required data-parsley-minlength="12" data-parsley-error-message="please enter valid phone number"  maxlength="12" >
                          </div>
                            <div class="col-sm-6">
                                    <select class="w100 p15 pb15 grey-bg border-0" name="region" data-parsley-required
                                    data-parsley-required-message="Please select Region" place-holder="Select Region"
                                    data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#shipping_region-err"
                                    tabindex="5">
                                    <option value="">Region</option>
                                    <option value="north west" {if $shipping.region == "north west"}selected{/if}>North West</option>
                                    <option value="south west" {if $shipping.region == "south west"}selected{/if}>South West</option>
                                    <option value="north east" {if $shipping.region == "north east"}selected{/if}>North East</option>
                                    <option value="south east" {if $shipping.region == "south east"}selected{/if}>South East</option>
                                  </select>
                                  <span id="shipping_region-err" class="err-message"></span>
                          </div>
                        </div>


                        <div class="row form-group">
                          <div class="col-sm-6">
                           <input class="w100 p15 pb15 grey-bg border-0"  data-parsley-required type="text" class="form-control" data-parsley-pattern="^[A-Za-z]*$" pattern="^[A-Za-z]*$" data-parsley-pattern-message="Invalid city" id="city" placeholder="City" name="city" value="{$shipping.city}">

                          </div>
                          <div class="col-sm-6">
                             <input data-parsley-trigger="change focusout" class="w100 p15 pb15 grey-bg border-0" id="zip" type="text" name="zipcode" maxlength="6"
                             data-parsley-maxlength="6" data-parsley-maxlength-message="Enter the 5-6 character zip code"
                             data-parsley-minlength="5" data-parsley-minlength-message="Enter the 5-6 character zip code"
                             data-parsley-required-message="Please enter zip code" placeholder="Zip Code" class="form-control" data-required="true" data-parsley-required value="{$shipping.zipcode}"/>
                           </div>
                        </div>
                        <div class="row form-group">
                          <div class="col-sm-6">
                            <textarea class="grey-bg w100 border-0 p15 pb15"  data-parsley-pattern="^[a-zA-Z ]*$" pattern="^[a-zA-Z ]*$" data-parsley-pattern-message="Invalid Address"  placeholder="Address" name="address" rows="6" cols="80">{$shipping.address}</textarea>
                          </div>
                          <div class="col-sm-6">
                            <textarea class="grey-bg w100 border-0 p15 pb15"  data-parsley-pattern="^[a-zA-Z ]*$" pattern="^[a-zA-Z ]*$" data-parsley-pattern-message="Invalid Instruction"  placeholder="Standard Delivery Instruction" name="delivery_instruction" rows="6" cols="80">{$shipping.delivery_instruction}</textarea>
                          </div>
                        </div>

                        <div class="row form-group">
                          <div class="col-md-12" style="text-align:center;">
                            <div id="slider-range"></div>
		                        <span>Available Time : </span><span id="time"></span>
                            <br>
                            <span id="hour-err" class="err-message"></span>
                          </div>
                        </div>
                        <input class="hidden" type="text"  id="from_hour" name="from_hour">
                        <input class="hidden" type="text" id="to_hour" name="to_hour">
                         <div class="row flex form-group">
                            <div class="col-sm-2 margin-auto mt-15">
                              <button id="form-submit-btn" class="btn btn-default btn-d-b green-b m0" type="submit" class="btn btn-default">SAVE</button>
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

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script> 
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
<script type="text/javascript">
  $("#slider-range").slider({
    range: true,
    min: 0,
    max: 1439,
    values: [0, 1439],
    slide: slideTime,
    change: checkMax
  });

  function checkMax() {
		var size = $("#slider-range").slider("values", 1) - $("#slider-range").slider("values", 0);
    
		if( size <= 119) {
			$("#form-submit-btn")
				.attr("disabled","disabled");
			$("#hour-err").text("Cannot be less than 2 hours");
		}
		else {	
			$("#form-submit-btn")
				.removeAttr("disabled")
			$("#hour-err").text("");
		}
	}



  function slideTime(event, ui){
    var val0 = $("#slider-range").slider("values", 0),
      val1 = $("#slider-range").slider("values", 1),
      minutes0 = parseInt(val0 % 60, 10),
      hours0 = parseInt(val0 / 60 % 24, 10),
      minutes1 = parseInt(val1 % 60, 10),
      hours1 = parseInt(val1 / 60 % 24, 10);
    $("#from_hour").val(val0);
    $("#to_hour").val(val1);
    startTime = getTime(hours0, minutes0);
    endTime = getTime(hours1, minutes1);
    $("#time").text(startTime + ' - ' + endTime);
  
  }
  function getTime(hours, minutes) {
    var time = null;
    minutes = minutes + "";
    if (hours < 12) {
      time = "AM";
    }
    else {
      time = "PM";
    }
    if (hours == 0) {
      hours = 12;
    }
    if (hours > 12) {
      hours = hours - 12;
    }
    if (minutes.length == 1) {
      minutes = "0" + minutes;
    }
    return hours + ":" + minutes + " " + time;
  }
  
var from = "{$shipping.from_hour}"
var to = "{$shipping.to_hour}"
$("#slider-range").slider("values", 0, from)
$("#slider-range").slider("values", 1, to)
  slideTime();
</script>


<script type="text/javascript">


 $(function () {
        ////console.log("{$shipping}");
        populateCountries("country", "state");
        var ctry = '{$shipping.country}';
        if (ctry != '')
            $('#country').val(ctry);
        loadState();

    });

</script>
</body>
</html>

