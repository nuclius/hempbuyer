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
        <div class="row  ">
                  {foreach $loged.products as $key => $val}
          {$total=sumFloat($total,$val.qty_add)*sumFloat($val.bprice,$val.shipping_price)}
           {/foreach}
            <div class="col-md-5 margin-auto">
                <ul class="lh-22 p0">
                    <li class="p5"><b class="f16">{$shipping.first_name} {$shipping.last_name}</b></li>
                    <li class="p5">{$shipping.address},{$shipping.city}</li>
                    <li class="p5">{$shipping.state}, {$shipping.country}, {$shipping.zipcode}</li>
                    <li class="p5">Email : {$shipping.email}</li>
                    <li class="p5">Phone : {$shipping.phone}</li>
                </ul>
                <br>
                <h4 class="green-text"><b>Total Amount to Be Paid - US $ {$hidamt}</b></h4>
<!--                 <ul class="lh-22 p0">
                    <li class="p5"><b class="f16"></b></li>
                    <li class="p5">Product price : $ {$buynow.amount} / {$product.short_unit}</li>
                    <li class="p5">Ordered Quantity : {$buynow.qty} {$product.units}</li>
                    <li class="p5">Commission Amount ({$buynow.commission}%) : $ {$buynow.commission_amt}</li>
                    <li class="p5">Sales tax ({$buynow.stax_per}%) : $ {$buynow.stax_amt}</li>
                    <li class="p5">Total amount : $ {$buynow.total_amount}</li>
                </ul> -->
                <!-- <h4 class="green-text"><b>Total Amount to Be Paid - US $ 400 (Including Shipping)</b></h4> -->
                <br>
                <button class="btn btn-default btn-d-b green-b m0" type="button" onclick="payToHarbee({$buynow.id})">PAY</button>
            </div>
            <div class="col-md-2 margin-auto padboth">
                <div class="or-circle margin-auto block">
                    OR
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="col-md-5">
                <div class="hide">
                    <form action="{$config.url}/product/checkout/payment" method="POST" id="shipping_form_hd">
                        <input type="text" name="f_name"  value="{$shipping.first_name}" >
                        <input type="text" name="l_name" value="{$shipping.last_name}" >
                        <input type="text" name="address" value="{$shipping.address}" >
                        <input type="text" name="delivery_instruction" value="{$shipping.delivery_instruction}" >
                        <input type="text" name="email" value="{$shipping.email}" >
                        <input type="text" name="phone" value="{$shipping.phone}" >
                        <input type="text" name="country" value="{$shipping.country}" >
                        <input type="text" name="city" value="{$shipping.city}" >
                        <input type="text" name="state" value="{$shipping.state}" >
                        <input type="text" name="zipcode" value="{$shipping.zipcode}" >
                        <input type="hidden" name="cod" value="{$cod}" >
                        </form>
                    </div>
                <form action="{$config.url}/product/checkout/payment" method="POST" id="shipping_form" class="row nd-mg">
                    <input type="hidden" name="cod" value="{$cod}" >
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
                                    <input type="text" class="w100 p15 pb15 grey-bg border-0" name="f_name" placeholder="First Name*" data-parsley-pattern="^[A-Za-z ]*$" pattern="^[A-Za-z ]*$" data-parsley-pattern-message="Invalid first name." value=""  data-parsley-required/>
                                </div>
                            </div>
                            <div class="col-md-6 form-group">
                                <div class="input-group w100">
                                     <input type="text" class="w100 p15 pb15 grey-bg border-0" name="l_name" placeholder="Last Name*" value="" data-parsley-pattern="^[A-Za-z ]*$" pattern="^[A-Za-z ]*$" data-parsley-pattern-message="Invalid last name." data-parsley-required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 form-group">
                                <textarea class="grey-bg w100 border-0 p15 pb15"  data-parsley-pattern="^[a-zA-Z0-9 ]*$" pattern="^[a-zA-Z0-9 ]*$" data-parsley-pattern-message="Invalid Address" value="" placeholder="Address" name="address" rows="6" cols="80" data-parsley-required></textarea>
                            </div>
                            <div class="col-md-6 form-group">
                                <textarea class="grey-bg w100 border-0 p15 pb15"  data-parsley-pattern="^[a-zA-Z0-9 ]*$" pattern="^[a-zA-Z0-9 ]*$" data-parsley-pattern-message="Invalid Standard Delivery Instruction" value="" placeholder="Standard Delivery Instruction" name="delivery_instruction" rows="6" cols="80" data-parsley-required></textarea>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 form-group">
                                <div class="input-group w100">
                                    <input data-parsley-trigger="change focusout" class="w100 p15 pb15 grey-bg border-0" type="email" id="email" name="email" data-parsley-required-message="Please enter Email ID" placeholder="Business Email" class="form-control" data-required="true" data-parsley-required value=""/>
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
                                    <!--  {if $shipping.country != ''}
                                    <option value="{$shipping.country}" selected>{$shipping.country}</option>
                                    {/if}
                                    {if $shipping.country == ''}
                                    <option value="" selected>Select Country</option>
                                   {/if}-->
                                </select>
                                <span id="country-err" class="err-message"></span>
                            </div>
                            <div class="col-md-6 form-group">
                                <select class="w100 p15 pb15 grey-bg border-0"  
                              data-parsley-required name="state" id="state" data-parsley-errors-container="#state-err">
                                    <option value="" selected>Select state</option>
                                  <!--  {if $shipping.state != ''}
                                    <option value="{$shipping.state}" selected>{$shipping.state}</option>
                                    {/if}
                                    {if $shipping.state == ''} 
                                    <option value="" selected>Select state</option>
                                     {/if} -->
                              </select>
                              <span id="state-err" class="err-message"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 form-group">
                                <input class="w100 p15 pb15 grey-bg border-0"  data-parsley-required type="text" class="form-control" value="" data-parsley-pattern="^[A-Za-z ]*$" pattern="^[A-Za-z ]*$" data-parsley-pattern-message="Invalid city" id="city" placeholder="City" name="city">
                            </div>
                            <div class="col-md-6">
                                <div class="input-group w100">
                                     <input data-parsley-trigger="change focusout" class="w100 p15 pb15 grey-bg border-0" id="zip" type="text" value="" name="zipcode" maxlength="6"
                          data-parsley-maxlength="6" data-parsley-maxlength-message="Enter the 5-6 character zip code"
                          data-parsley-minlength="5" data-parsley-minlength-message="Enter the 5-6 character zip code" 
                          data-parsley-required-message="Please enter zip code" placeholder="Zip Code" class="form-control" data-required="true" data-parsley-required />
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

    $("#country").trigger("change");
});
</script>
</body>

</html>