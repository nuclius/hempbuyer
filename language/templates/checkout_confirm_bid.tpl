{include file="/common/header-1.tpl" nocache}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}ds-forms.css"/>
<style>
    .main_wrapper {
        margin: 20px auto 160px;
        min-height: 540px;
    }

    .ship_overlay1 {
        height: auto;
    }
</style>
<div class="row block1" style="  clear: both;  padding-bottom: 40px;">

    <!--<form id="localpick-form" method="post" action="{$config.url}/product/bidpaymentnoshiping/{$id}/" data-parsley-validate>
        <div class="col-md-12">
            <input type="hidden" name="total_amount" value='{$pro_price}' />

            <div id="noshipingsss" style="display:none;">
                <div class=" col-xs-12 col-sm-6 col-md-6">
                    <label class="option srch_olbl">

                        <span class="checkbox"></span> <span class="span_lbl">Please provide Buyer Details</span>
                    </label>
                    <div class="ship_overlay1">
                        <div class=" {if $shipping.first_name == ''} hide{/if}" style="background-color: transparent;"></div>
                        <div class="row">
                            <div class="col-md-6 mtop_20">
                                <div class="form-group">

                                    <input type="text" class="form-control" name="f_name" placeholder="First Name*" value="{$shipping.first_name}" def="{$shipping.first_name}" data-parsley-required tabindex="1" >
                                </div>
                            </div>
                            <div class="col-md-6 mtop_20">
                                <div class="form-group">
                                    <input type="text" class="form-control" name="l_name" placeholder="Last Name*" value="{$shipping.last_name}" def="{$shipping.last_name}" data-parsley-required tabindex="2">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mtop_20">
                                <div class="form-group">
                                    <input type="email" class="form-control" name="email" placeholder="E-Mail*" value="{$shipping.email}" data-parsley-required def="{$shipping.email}" tabindex="3">
                                </div>
                            </div>
                            <div class="col-md-6 mtop_20">
                                <div class="form-group">
                                    <input type="text" class="form-control numberonly" name="phone" placeholder="Cell Phone*" value="{$shipping.phone}" data-parsley-minlength="10" data-parsley-required data-parsley-error-message="please enter valid phone number"  maxlength="12" def="{$shipping.phone}" tabindex="4">
                                </div></div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mtop_20">
                                <div class="form-group">
                                    <select class="form-control" name="country" id="country1" data-parsley-required-message="Please select country"  >
                                        <option value="">Please select country</option>

                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6 mtop_20">
                                <div class="form-group">
                                    <div id="divstate1">
                                        <select class="form-control" name="state" id="state1" data-parsley-required-message="Please select state">
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <input type="hidden" name="hidden_country" id="hidden_country1" value="{$shipping_address.country}">
                        <input type="hidden" name="hidden_state" id="hidden_state1" value="{$shipping_address.state}">

                        <div class="row">

                            <div class="col-md-6 mtop_20">
                                <div class="form-group">
                                    <input class="form-control" placeholder="city" name="city" value="{$shipping.city}" def="{$shipping.city}"  data-parsley-required>
                                </div>
                            </div>

                            <div class="col-md-6 mtop_20">
                                <div class="form-group">
                                    <input type="text" class="form-control" name="address" placeholder="Address*" value="{$shipping.address}" data-parsley-required def="{$shipping.address}" tabindex="5">
                                </div>
                            </div>


                        </div>
                        <div class="row">
                            <div class="col-md-6 mtop_20">
                                <div class="form-group">
                                    <input type="text" class="form-control" name="zipcode" id="zipcode" placeholder="Zip Code*" value="{$shipping.zipcode}" data-parsley-required  data-parsley-error-message="please enter valid zipcode" onblur="checkStateCity('localpick-form',0)"  maxlength="8" def="{$shipping.zipcode}" tabindex="6">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-7 mtop_20">
                                &lt;!&ndash;<div>
                                    <input type="hidden" name="state" id="state" value="{$shipping.state}" />
                                    <input type="hidden" name="country" id="country" value="{$shipping.country}" />
                                    <input type="hidden" name="city" id="city" value="{$shipping.city}" />
                                </div>&ndash;&gt;

                                <div class="form-group addresscity">

                                </div>
                                &lt;!&ndash;<div class="project_title tmtpd" id="withoutshiping" style="display:block;">Total Amount to Be Paid -<span>US $ {$price}</span><span></span><span class="rtri"></span></div>&ndash;&gt;

                                <input type="hidden" name="price"  value='{$pro_detail.amount}' />

                            </div><div class="col-md-5 mtop_20">
                            <input type="submit" value="Update Information" class="btn btn-success form-control" style="margin-top: 17px;">
                        </div></div>
                    </div>
                </div>
            </div>
        </div>
    </form>-->

    <form name="" action="{$config.url}/product/bidpayment/{$id}/" method="post" id="paypal-form" data-parsley-validate>
        <input type="hidden" name="buynowid" value="{$buynowid}" />
        <div class="ds col-md-12">
            <div class="dash_brd" style="padding-left: 0;"><a href="/dashboard/mybids" style="color:#000">Dashboard</a> &gt;&gt; Buynow</div>

            <div class="checkt_wrapper">
                <div class="nship_chead1 delvt">Delivery Address</div>
                <!--<div class="text-danger">{$error}</div>-->
                <!--div class="featured_list">Total Amount to Be Paid - <span>US ${$price}</span></div-->
                <div></div>
                <div class="row chbor">
                    <div class="col-sm-4 ds">
                        {if $shipping.first_name != ''}
                        <label class="option srch_olbl">
                            <input type="checkbox"  name="delivery_address_shipping" checked onclick="shipping_add(1)" />
                            <span class="checkbox"></span> <span class="span_lbl">Saved Shipping Address  </span>
                        </label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="col-md-12 delivery_add">
                                        <div class="buyer_name bynn">{$shipping.first_name} {$shipping.last_name}</div>
                                        <div>{$shipping.phone}</div>
                                        <address>
                                            {$shipping.address},{$shipping.city}<br>
                                            {$shipping.state}, {$shipping.country}, {$shipping.zipcode} <br/>
                                            <div><strong>Email :</strong> {$shipping.email}</div>
                                        </address>

                                    </div>

                                </div>
                            </div>

                        </div>
                        {else}
                        <div class="text-center" style="margin-top: 13px;"> No shipping address added </div>
                        {/if}
                        
                    </div>
                    <div class="col-sm-2  or_line">
                        <div class="orad">OR</div>
                    </div>
                    <div class="ds col-sm-6">
                        <label class="option srch_olbl">
                            <input type="checkbox"  name="delivery_address" onclick="shipping_add(0);" {if $shipping.first_name == ''} checked {/if}  />
                            <span class="checkbox"></span> <span class="span_lbl">Add New Shipping Address</span>
                        </label>
                        <div class="ship_overlay1">
                            <div class="ship_overlay {if $shipping.first_name == ''} hide{/if}" style="background-color: transparent;"></div>
                            <div class="row">
                                <div class="col-md-6 mtop_20">
                                    <div class="form-group">
                                        <input type="hidden" name="paymentMethodNonceInputField" id='paymentMethodNonceInputField' />
                                        <input type="text" class="form-control" name="f_name" placeholder="First Name*" value="{$shipping.first_name}" def="{$shipping.first_name}" data-parsley-required tabindex="1" >
                                    </div>
                                </div>
                                <div class="col-md-6 mtop_20">
                                    <div class="form-group">
                                        <input type="text" class="form-control" name="l_name" placeholder="Last Name*" value="{$shipping.last_name}" def="{$shipping.last_name}" data-parsley-required tabindex="2">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mtop_20">
                                    <div class="form-group">
                                        <input type="email" class="form-control" name="email" placeholder="E-Mail*" value="{$shipping.email}" data-parsley-required def="{$shipping.email}" tabindex="3">
                                    </div>
                                </div>
                                <div class="col-md-6 mtop_20">
                                    <div class="form-group">
                                        <input type="text" class="form-control numberonly" name="phone" placeholder="Cell Phone*" value="{$shipping.phone}" data-parsley-minlength="10" data-parsley-required data-parsley-error-message="please enter valid phone number"  maxlength="12" def="{$shipping.phone}" tabindex="4">
                                    </div></div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mtop_20">
                                    <div class="form-group">
                                        <select class="form-control" name="country" id="country" data-parsley-required-message="Please select country"  required>
                                            <option value="">Please select country</option>
                                            <!-- {foreach $country as $key => $val}
                                             <option value="{$val.location_eng}" {if $val.location_eng == $shipping.country selected} {/if}>{$val.location_eng}</option>
                                             {/foreach}-->
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6 mtop_20">
                                    <div class="form-group">
                                        <div id="divstate">
                                            <select class="form-control" name="state" id="state" data-parsley-required-message="Please select state"  >


                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>



                            <div class="row">
                                <div class="col-md-6 mtop_20">
                                    <div class="form-group">
                                        <input class="form-control" placeholder="city" name="city" value="{$shipping.city}" def="{$shipping.city}"  data-parsley-required>
                                    </div>
                                </div>
                                <div class="col-md-6 mtop_20">
                                    <div class="form-group">
                                        <input type="text" class="form-control" name="address" placeholder="Address*" value="{$shipping.address}" data-parsley-required def="{$shipping.address}" tabindex="5">
                                    </div>
                                </div>
                            </div>

                            <input type="hidden" name="hidden_country" id="hidden_country" value="{$shipping.country}">
                            <input type="hidden" name="hidden_state" id="hidden_state" value="{$shipping.state}">

                            <div class="row">

                                <div class="col-md-6 mtop_20">
                                    <div class="form-group">
                                        <input type="text" class="form-control" name="zipcode" id="zipcode" placeholder="Zip Code*" value="{$shipping.zipcode}" data-parsley-required  data-parsley-error-message="please enter valid zipcode"   maxlength="8" def="{$shipping.zipcode}" tabindex="6">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mtop_20">
                                    <!-- <div>
                                     <input type="hidden" name="state" id="state" value="{$user.state}" />
                                                <input type="hidden" name="country" id="country" value="{$user.country}" />
                                                <input type="hidden" name="city" id="city" value="{$user.city}" />
                                     </div>  -->
                                    <div class="form-group addresscity">

                                    </div>

                                </div></div>
                        </div>
                    </div>
                </div></div></div>

        <div class="text-danger">{$error}</div>
        <div class="row cmargin-row ">
            <div class="col-md-6 pull-left">
                <div class="project_title tmtpd">Total Amount to Be Paid - <span>US ${($price)}</span><span></span><span class="rtri"></span></div>
                <input type="hidden" name="pay_amount" value="{$price}">
            </div>
            <div class="col-md-6">
                {if $failedpament == '0'}<div style="margin: 20px; color:#F00;">Error Occured with Payment. Please Contact Admin </div>{/if}
                {if $failedpament == '1'}
                    <div style="margin: 20px;"><button type="button" class="btn btn-danger" onclick="paywithpaypal()">Pay with PayPal</button></div>
                {/if}
            </div>
        </div>

       <!-- <div class="col-md-12">
            <div class="col-md-6"><b>Select Payment Method</b></div>
            <div class="col-md-6">
                <select name="paymentmethod" id="paymentmethod" required>
                    <option value="">Please Select</option>
                    {foreach $creditCards as $key=>$val}
                    <option value="{$val.id}">{$val.card_type} {$val.encrypt_card}</option>
                    {/foreach}
                    <option value="paypal">Add New Paypal</option>
                    <option value="cc">Add New Creditcard</option>
                </select>

            </div>
        </div>
        <div class="col-md-12 hide saved-drp chpad">
            <div type="submit" class="btn btn-success" value="Submit" id="cardprocessone"  onclick="cardSubmit()">Pay </div>
        </div>
        <div class="col-md-12  hide credit-drp">
            <div class="col-sm-3 padding-20">
                Card Holder Name
            </div>
            <div class="col-sm-6 padding-20">
                <input type="text" name="cardholder_name" data-braintree-name="cardholder_name" class="form-control col-md-4" value="" placeholder="Card holder name" data-parsley-required="true" data-parsley-error-message="Enter card holder name"/>
            </div>
            <div class="clear"></div>
            <div class="col-sm-3  padding-20">
                Credit Card Number
            </div>
            <div class="col-sm-6 padding-20">
                <input type="text" name="number" data-braintree-name="number" class="form-control" value="" placeholder="Credit card number" data-parsley-required="true" data-parsley-error-message="Enter credit card number"/>
            </div>
            <div class="clear"></div>
            <div class="col-sm-3  padding-20">
                Expiry Date
            </div>
            <div class="col-sm-2 padding-20">
                <input type="text" name="expiration_month" data-braintree-name="expiration_month" class="form-control col-md-3" value="" placeholder="mm" data-parsley-required="true" data-parsley-error-message="Enter month"/>
            </div>
            <div class="col-sm-2 padding-20">
                <input type="text" name="expiration_year" data-braintree-name="expiration_year" class="form-control col-md-3 " value="" placeholder="yyyy" data-parsley-required="true" data-parsley-error-message="Enter year"/>
            </div>
            <div class="clear"></div>
            <div class="col-sm-3  padding-20">
                CVV
            </div>
            <div class="col-sm-2 padding-20">
                <input type="text" name="cvv" data-braintree-name="cvv" class="form-control col-md-3" value="" placeholder="3 or 4 digit number" data-parsley-required="true" data-parsley-error-message="Enter CVV no"/>

            </div>
            <div class="clear"></div>
            <div class="col-md-6 padding-20">
                <button type="button" class="btn btn-success" value="Submit"  id="cardprocesstwo"  onclick="cardSubmit()">Pay via Card  </button>
                <span style="margin-left:10px;"><input type="checkbox" id="future" name="savecard" value="1"> Save for future payment</span>
                <input type="submit" class="submit-card hide" />
            </div>
        </div>
        <div class="col-md-12 hide paypal-drp">
            <div class="col-xs-12 col-sm-6 col-md-6">
                <div id="paypal-buttons" class="paypal-buttons hide"><img src="{$config.url}/images/paypal.png" alt="Pay with PayPal" style="display:inline-table !important;cursor:pointer;"></div>
                <div id="paypal-button" class="paypal-button"></div>
                <span><input type="checkbox" id="futurepal" name="savepaypal" value="1"> Save for future payment</span>
            </div>
        </div>-->

</div>
</div>
<!--<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#boxx" data-whatever="@mdo">Pay with PayPal</button>-->
</form>
</div>
</div>

<form action="{$paypalurltopay}" target="PPDGFrame" class="standard">
    <input type="submit" id="submitBtn" value="Pay with PayPal" style="display:none;" >
    <input id="type" type="hidden" name="expType" value="light">
    <input id="paykey" type="hidden" name="paykey" value="{$clientToken}">
</form>

<script src="https://www.paypalobjects.com/js/external/dg.js"  type="text/javascript" language="javascript">
</script><script  type="text/javascript" language="javascript">
    $(function()
    {
        var dgFlow = new PAYPAL.apps.DGFlow({ trigger: submitBtn});
    });
</script>
{include file="/common/footer-1.tpl" nocache}
<!--<script src="https://js.braintreegateway.com/v2/braintree.js"></script>-->
<script>
    function paywithpaypal()
    {

        if(true === $('#paypal-form').parsley().validate())
        {
            var params = $('#paypal-form').serialize();
            console.log(params);
            $.ajax({
                type:'POST',
                url:'/product/updateshippinginfobid?'+params,
                data:params,
                dataType:'json',
                success: function (data)
                {
                    $('#submitBtn').trigger('click');
                }
            });


        }
    }
  /*  function cardSubmit() {
        intializeForm('');
        if (true === $('#paypal-form').parsley().validate()) {
            $('#cardprocesstwo,#cardprocessone').html('processing...');
            /!*intializeForm(function () {
             $('.submit-card').click();
             });*!/
            $('.submit-card').click();
            /!* setTimeout(function () {
             checkStateCity('paypal-form', 2);
             }, 3000);*!/
        }else{

            return false;
        }
    }
    braintree.setup("{$clientToken}", "custom", {
        id: "paypal-form"
    });
    $(function () {
        $('#paymentmethod').on('change', function () {

            if ($(this).val() == 'paypal') {
                $('.paypal-drp').removeClass('hide');
                $('.credit-drp').addClass('hide');
                $('.saved-drp').addClass('hide');
                $('#future').attr('checked', false);
            }
            else if ($(this).val() == 'cc') {
                $('.credit-drp').removeClass('hide');
                $('.paypal-drp').addClass('hide');
                $('.saved-drp').addClass('hide');
                $('#futurepal').attr('checked', false);
            }
            else {
                $('.paypal-drp').addClass('hide');
                $('.credit-drp').addClass('hide');
                $('.saved-drp').removeClass('hide');
                $('#future').attr('checked', false);
                $('#futurepal').attr('checked', false);
            }
        });

        braintree.setup('{$clientToken}', "paypal", {
            container: "paypal-button",
            paymentMethodNonceInputField: "paymentMethodNonceInputField",
            onSuccess: function () {

                $('#overlay').fadeIn(800);
                $('.cart').addClass('waitfewsec');
                if (true === $('#paypal-form').parsley().validate()) {
                    setTimeout(function () {
                       /!* checkStateCity('paypal-form', 1);*!/
                        $('#paypal-form').submit();
                    }, 3000);
                    $('#paypal-buttons').removeClass('hide');
                    $('#paypal-button').addClass('hide');
                }
                else {
                    $('#paypal-buttons').on('click', function () {
                        $('#paypal-form').submit()
                    });
                    $('#paypal-buttons').removeClass('hide');
                    $('#paypal-button').addClass('hide');
                }
            },
            onCancelled: function () {
                $('#paypal-buttons').addClass('hide');
            },
            singleUse: false
        });


    });*/
    function clicked(ob) {
        ob.on('click', function () {
            console.log(52);
        });
    }

    function shipping_add(id) {
        if (id == 1) {
            if ($('input[name="delivery_address_shipping"]').is(":checked")) {
                $('input[name="delivery_address"]').prop('checked', false);
                /*$('input').each(function () {
                 $(this).val($(this).attr('def'));
                 });*/
                $('#country').val('{$shipping.country}');
                loadState();
                /* $('#country').val($('#country').attr('def'));
                 loadLocation('country', $('#country option[value="{$shipping.country}"]').attr('attr'), '{$shipping.state}', '{$shipping.city}');*/

                $('.ship_overlay').removeClass('hide');
            }
            else {
                $('input[name="delivery_address"]').prop('checked', true);
                $('.ship_overlay').addClass('hide');
            }
        }
        if (id == 0) {
            if ($('input[name="delivery_address"]').is(":checked")) {
                $('input[name="delivery_address_shipping"]').prop('checked', false);
                $('.ship_overlay').addClass('hide');
            }
            else {
                $('input[name="delivery_address_shipping"]').prop('checked', true);
                $('input').each(function () {
                    $(this).val($(this).attr('def'));
                });
                /*$('#country').val($('#country').attr('def'));*/
                /*loadLocation('country', $('#country option[value="{$shipping.country}"]').attr('attr'), '{$shipping.state}', '{$shipping.city}');*/
                $('.ship_overlay').removeClass('hide');
            }
        }

    }
    //braintree.setup("CLIENT-TOKEN-FROM-SERVER", "<integration>", options);

</script>
<script type="text/javascript">
    $(function () {

        var ctry = '{$shipping.country}';
        var s = '{$shipping.state}';
        if(ctry !='')
        {
            $('#country').val(ctry);

            loadState();

        }else{
            populateCountries("country", "state");
            populateCountries("country1", "state1");
        }
        /*if({$pro_detail.local_pick} == 0){
            $('#paypal-form').show();
            $('#noshipingsss').hide();

        }else{
            $('#paypal-form').hide();
            $('#noshipingsss').show();
            populateCountries("country1", "state1");
            $('#country1').val(ctry);
            loadState();
        }*/
        //loadLocation('state',$('#states option[value="{$users.state}"]').val(),'{$users.city}');

    });</script>
