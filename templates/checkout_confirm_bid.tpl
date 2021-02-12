<!--============================================================================*\
|| ########################################################################## ||
|| # Auction Software Marketplace[*]version[*] Build [*]build[*]
|| # ---------------------------------------------------------------------- # ||
|| # Customer License # [*]license[*]
|| # ---------------------------------------------------------------------- # ||
|| # Copyright ©2014–[*]year[*] Develop Scripts LLC. All Rights Reserved    # ||
|| # This file may not be redistributed in whole or significant part.       # ||
|| # ------------- AUCTION SOFTWARE IS NOT FREE SOFTWARE ------------------ # ||
|| # http://www.auctionsoftwaremarketplace.com|support@auctionsoftware.com  # ||
|| # ---------------------------------------------------------------------- # ||
|| ########################################################################## ||
\*============================================================================ -->
{include file="common/header-1.tpl" nocache}
<!-- Page content -->
{include file="common/dashboard-navigation.tpl" nocache}
<div class="container-fluid p0">
    <div class="container m50">
      <div class="row flex">
        <div class="col-sm-10 margin-auto">
          <div class="row">
                <div class="col-sm-5 margin-auto">
                    <ul class="lh-22 p0">
                        <li class="p5"><b class="f16">{$shipping.first_name} {$shipping.last_name}</b></li>
                        <li class="p5">{$shipping.address},{$shipping.city}</li>
                        <li class="p5">{$shipping.state}, {$shipping.country}, {$shipping.zipcode}</li>
                        <li class="p5">Email : {$shipping.email}</li>
                        <li class="p5">Phone : {$shipping.phone}</li>
                    </ul>
                    <br>
                    <h4 class="green-text"><b>Total Amount to Be Paid</b></h4>
                    <ul class="lh-22 p0">
                        <li class="p5"><b class="f16"></b></li>
                        <li class="p5">Product price : $ {$buynow.amount} / {$product.short_unit}</li>
                        <li class="p5">Ordered Quantity : {$buynow.qty} {$product.units}</li>
                        <li class="p5">Herbee Commission Amount ({$buynow.commission_per}%) : $ {$buynow.commission}</li>
                        <li class="p5">Sales tax ({$buynow.stax_per}%) : $ {$buynow.stax_amt}</li>
                        <li class="p5">Total amount : $ {$buynow_total_amount}</li>
                        <!-- <li class="p5">Total amount : $ {$buynow.total_amount}</li> -->
                        <!-- <li class="p5">Total amount : $ {$buynow.total_amount}</li> -->
                    </ul>
                    <!-- <h4 class="green-text"><b>Total Amount to Be Paid - US $ 400 (Including Shipping)</b></h4> -->
                    <br>
                    <button class="btn btn-default btn-d-b green-b m0" type="button" onclick="payToHarbee({$buynow.id})">PAY</button>
                </div>
                <div class="col-sm-2 margin-auto padboth">
                    <div class="or-circle margin-auto block">
                        OR
                    </div><div class="clearfix"></div>
                </div>
                <div class="col-sm-5">
                        <div class="hide">
                          <form action="{$config.url}/product/payment/pay/{$buynow.id}" method="POST" id="shipping_form_hd" class="row">
                              <input type="text" class="w100 p15 pb15 grey-bg border-0" name="f_name" value="{$shipping.first_name}" placeholder="First Name*"/>
                              <input type="text" class="w100 p15 pb15 grey-bg border-0" name="l_name" value="{$shipping.last_name}" placeholder="Last Name*">
                              <input type="text" class="w100 p15 pb15 grey-bg border-0" name="address" value="{$shipping.address}" placeholder="Address*">
                              <input data-parsley-trigger="change focusout" class="w100 p15 pb15 grey-bg border-0" type="email" id="email" name="email" value="{$shipping.email}"/>
                              <input type="text" class="w100 p15 pb15 grey-bg border-0" name="phone" value="{$shipping.phone}">
                              <input type="text" class="w100 p15 pb15 grey-bg border-0" name="country" value="{$shipping.country}">
                              <input type="text" class="w100 p15 pb15 grey-bg border-0" name="state" value="{$shipping.state}">
                              <input type="text" class="w100 p15 pb15 grey-bg border-0" name="city" value="{$shipping.city}">
                              <input type="text" class="w100 p15 pb15 grey-bg border-0" name="zipcode" value="{$shipping.zipcode}">
                          </form>
                        </div>
                          <form action="{$config.url}/product/payment/pay/{$buynow.id}" method="POST" id="shipping_form" class="row nd-mg">

                              <div class="row">
                                  <div class="checkbox">
                                      <label>
                                          <input type="checkbox" class="shipping_checkbox" name="change_shipping" value="y">
                                          <span class="cr"><i class="cr-icon fa fa-check"></i></span> New shipping address
                                      </label>
                                  </div>
                                   <div id="shipping_address">
                                  <div class="row">
                                      <div class="col-md-6 form-group">
                                          <div class="input-group w100">
                                              <input type="text" class="w100 p15 pb15 grey-bg border-0" name="f_name" value="" placeholder="First Name*" data-parsley-pattern="^[A-Za-z]*$" pattern="^[A-Za-z]*$" data-parsley-pattern-message="Invalid first name."  data-parsley-required/>
                                          </div>
                                      </div>
                                      <div class="col-md-6 form-group">
                                          <div class="input-group w100">
                                               <input type="text" class="w100 p15 pb15 grey-bg border-0" name="l_name" value="" placeholder="Last Name*" data-parsley-pattern="^[A-Za-z]*$" pattern="^[A-Za-z]*$" data-parsley-pattern-message="Invalid last name." data-parsley-required>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="row">
                                      <div class="col-md-12 form-group">
                                          <textarea class="grey-bg w100 border-0 p15 pb15"  data-parsley-pattern="^[a-zA-Z ]*$" pattern="^[a-zA-Z ]*$" data-parsley-pattern-message="Invalid Address"  placeholder="Address" name="address" value="" rows="6" cols="80" data-parsley-required></textarea>
                                      </div>
                                  </div>
                                  <div class="row">
                                      <div class="col-md-6 form-group">
                                          <div class="input-group w100">
                                              <input data-parsley-trigger="change focusout" class="w100 p15 pb15 grey-bg border-0" type="email" id="email" name="email" value="" data-parsley-required-message="Please enter Email ID" placeholder="Business Email" class="form-control" data-required="true" data-parsley-required />
                                          </div>
                                      </div>
                                      <div class="col-md-6 form-group">
                                          <div class="input-group w100">
                                               <input type="text" class="w100 p15 pb15 grey-bg border-0" name="phone" value="" placeholder="Cell Phone*" data-mask="000-000-0000" data-parsley-required data-parsley-minlength="12" data-parsley-error-message="please enter valid phone number"  maxlength="12" >
                                          </div>
                                      </div>
          <!--                             <div class="col-md-6 form-group">
                                          <select class="w100 p15 pb15 grey-bg border-0" name="region" id="region" data-parsley-required data-parsley-required-message="Please select region" place-holder="Select Region" data-parsley-required>
                                              <option value="">Region</option>
                                              <option value="northwest" {if $shipping.region == 'northwest'} selected {/if}>North West</option>
                                              <option value="southwest" {if $shipping.region == 'southwest'} selected {/if}>South West</option>
                                              <option value="northeast" {if $shipping.region == 'northeast'} selected {/if}>North East</option>
                                              <option value="southeast" {if $shipping.region == 'southeast'} selected {/if}>South East</option>
                                          </select>
                                      </div> -->
                    </div>
                                  <div class="row">
                                      <div class="col-md-6 form-group">
                                          <select class="w100 p15 pb15 grey-bg border-0"
                                          data-parsley-required name="country" id="country" data-parsley-required-message="Please select country" data-parsley-required data-parsley-errors-container="#country-err">
                                              <option value="" selected>Select Country</option>
                                              <!--{if $shipping.country != ''}
                                              <option value="{$shipping.country}" selected>{$shipping.country}</option>
                                              {/if}-->
                                             <!-- {if $shipping.country == ''}
                                              <option value="" selected>Select Country</option>
                                              {/if}-->
                                          </select>
                                          <span id="country-err" class="err-message"></span>
                                      </div>
                                      <div class="col-md-6 form-group">
                                          <select class="w100 p15 pb15 grey-bg border-0"
                                        data-parsley-required name="state" id="state" data-parsley-errors-container="#state-err">
                                              <option value="" selected>Select state</option>
                                              <!--{if $shipping.state != ''}
                                              <option value="{$shipping.state}" selected>{$shipping.state}</option>
                                              {/if}
                                              {if $shipping.state == ''}
                                              <option value="" selected>Select state</option>
                                              {/if}-->
                                        </select>
                                        <span id="state-err" class="err-message"></span>
                                      </div>
                                  </div>
                                  <div class="row">
                                      <div class="col-md-6 form-group">
                                          <input class="w100 p15 pb15 grey-bg border-0"  data-parsley-required type="text" class="form-control" data-parsley-pattern="^[A-Za-z]*$" pattern="^[A-Za-z]*$" data-parsley-pattern-message="Invalid city" id="city" placeholder="City" name="city" value="">
                                      </div>
                                      <div class="col-md-6">
                                          <div class="input-group w100">
                                               <input data-parsley-trigger="change focusout" class="w100 p15 pb15 grey-bg border-0" id="zip" type="text" name="zipcode" value="" maxlength="6"
                                    data-parsley-maxlength="6" data-parsley-maxlength-message="Enter the 5-6 character zip code"
                                    data-parsley-minlength="5" data-parsley-minlength-message="Enter the 5-6 character zip code"
                                    data-parsley-required-message="Please enter zip code" placeholder="Zip Code" class="form-control" data-required="true" data-parsley-required/>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                              </div>
                          </form>
                </div>
            </div>
        </div>
      </div>
    </div>
</div>
</div>
</div>
<!--/ Page content -->
{include file="common/footer-1.tpl" nocache}
<script type="text/javascript">
document.getElementById('shipping_address').style.display = 'none';
  $('.shipping_checkbox').change(function () {
     if ($('input[type=checkbox][name=change_shipping]').prop('checked') == true) {
        document.getElementById('shipping_address').style.display = 'inline';
    }else{
        document.getElementById('shipping_address').style.display = 'none';
    }
 });
/*
function payToHarbee(id) {
    if ($('input[type=checkbox][name=change_shipping]').prop('checked') == true) {
        $('#shipping_form').attr("data-parsley-validate", "true");
        if ($('#shipping_form').parsley().validate()) {
            // alert("validated");
            $('#shipping_form').submit();
        }

    } else {
        $('#shipping_form').submit();
    }


}
*/
function payToHarbee(id) {

            if ($('input[type=checkbox][name=change_shipping]').prop('checked') == true) {
                $('#shipping_form').attr("data-parsley-validate", "true");
                if ($('#shipping_form').parsley().validate()) {
                    $('#shipping_form').submit();
                }
            } else {
                $('#shipping_form_hd').submit();
            }

}

$(function() {
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
