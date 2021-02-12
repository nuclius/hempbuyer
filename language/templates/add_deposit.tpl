{include file="/common/header-1.tpl" nocache}
<style>
    .padding_200 {
        padding: 7px 2px;
    }
</style>
<div class="col-md-12 mjusd1" style="color:#000;">{$pharse.deposit}</div>
{if $error}
<div class="alert alert-danger">{$error}</div>{/if}
<div class="col-md-12">
    <div class="col-md-1"></div>
    <form action="/adwords/pay" id="paypal-form" method="post" data-parsley-validate enctype="multipart/form-data">
        <div class="col-offset-6 centered">
        <input type="hidden" name="paymentMethodNonceInputField" id='paymentMethodNonceInputField' />

            <div class="col-md-12" style="margin-top:20px">
            <div class="col-md-2"></div>
                <div class="col-md-2 padle" style="padding-right:0;margin-top: 7px;">
                    <span class="padee5">{$pharse.amount} </span></div>
                <div class="col-md-4 padle">
                    <input type="text" class="form-control" name="amount" required>
                    </div>

            </div>



        <div class="col-md-12" style="margin-top:20px">
        <div class="col-md-2"></div>
            <div class="col-md-2 padle" style="padding-right:0;margin-top: 7px;">
                <span class="padee5">{$pharse.select_payment_method}  </span></div>
            <div class="col-md-4 padle">
                <select name="paymentmethod" id="paymentmethod"  class="form-control" required>
                    <option value="">{$pharse.please_select}</option>

                    {foreach $creditCards as $key=>$val}

                    <option value="{$val.id}">{$val.card_type} {$val.encrypt_card}</option>

                    {/foreach}

                    <option value="paypal">{$pharse.add_new_paypal}</option>
                    <option value="cc">{$pharse.add_new_creditcard}</option>
                </select></div>

        </div>

        <div class="col-md-offset-3 col-md-6  hide credit-drp">
            <div class="col-md-6 padding_200"> {$pharse.card_holder_name} </div>
            <div class="col-md-6 padding_200">
                <input type="text" name="cardholder_name"  placeholder="Enter Card Holder Name" data-braintree-name="cardholder_name" class="form-control col-md-4 creditclass" value="" required data-parsley-required />
            </div>
            <div class="col-md-6 padding_200"> {$pharse.credit_card_number} </div>
            <div class="col-md-6 padding_200">
                <input type="text" name="number" data-braintree-name="number" class="form-control creditclass" placeholder="Enter Card Number" value="" required data-parsley-required />
            </div>
            <div class="col-md-6 padding_200"> {$pharse.expiry_date} </div>
            <div class="col-md-2 padding_200">
                <input type="text" name="expiration_month" data-braintree-name="expiration_month " placeholder="Month" required data-parsley-required class="form-control col-md-3" value="" />
            </div>
            <div class="col-md-2 padding_200">
                <input type="text" name="expiration_year" placeholder="Year" data-braintree-name="expiration_year " required data-parsley-required class="form-control col-md-3 " value="" />
            </div>
            <div class="col-md-6 padding_200"> {$pharse.cvv} </div>
            <div class="col-md-2 padding_200">
                <input type="text" required data-parsley-required name="cvv" placeholder="CVV" data-braintree-name="cvv" class="form-control col-md-3 creditclass" value=""/>
            </div>
            <!--<div class="col-md-12 padding_200">
                <input type="checkbox" id="future" name="savecard" value="1">
                <label for="future">Save for future payment</label>
            </div>-->
            <!--<div class="col-md-12 padding_200">
                <div type="submit" class="btn btn-success" value="Submit" id="cardprocessone" onclick="cardSubmit()">Pay via Card </div>
                <input type="submit" class="submit-card hide" />
            </div>-->
        </div>

        <div class="col-md-12 hide paypal-drp">
            <div class="col-xs-12 col-sm-6 col-md-6 pull-right">
                <div id="paypal-button" class="paypal-button pull-left"></div>
                <div id="paypal-buttons" class="paypal-buttons hide" onclick="cardSubmit();"><img src="{$config.url}/images/paypal.png" alt="Pay with PayPal" style="display:inline-table !important;cursor:pointer;"> </div>

            </div>

        </div>


        <div class="col-md-12 text-center" style="margin-top: 13px;">
            <button type="submit" class="btn btn-danger">{$pharse.pay}</button>
        </div>
    </div>
    </form>

</div>

{include file="/common/footer-1.tpl" nocache}

<script src="https://js.braintreegateway.com/v2/braintree.js"></script>

<script>
    function cardSubmit()
    {



        var payment = $("#paymentmethod").val();


        if(payment != "paypal" && payment != "cc")
        {

            // $('.submit-card').click();

            //  $(".creditclass").prop('required',false);

            $('.credit-drp').remove();

            $('.submit-card').click();

            /* $(".creditclass").prop('required',false);

             if(true === $('form[name="membership_pay"]').parsley().validate())
             {

             $('.submit-card').click();

             } */
        }
        else
        {
            if(true === $('form[name="membership_pay"]').parsley().validate())
            {

                $('.submit-card').click();

            }
        }


    }
    braintree.setup("{$clientToken}", "custom", {
        id: "paypal-form"
    });
    $(function(){

        $('#paymentmethod').on('change',function(){

            if($(this).val() == 'paypal')
            {

                $('.paypal-drp').removeClass('hide');
                $('.credit-drp').addClass('hide');
                $('.saved-drp').addClass('hide');
                $('#future').attr('checked',false);
            }
            else if($(this).val() == 'cc')
            {
                $('.credit-drp').removeClass('hide');
                $('.paypal-drp').addClass('hide');
                $('.saved-drp').addClass('hide');
                $('#futurepal').attr('checked',false);
            }
            else
            {
                $('.paypal-drp').addClass('hide');
                $('.credit-drp').addClass('hide');
                $('.saved-drp').removeClass('hide');
                $('#future').attr('checked',false);
                $('#futurepal').attr('checked',false);
            }
        });

        braintree.setup('{$clientToken}', "paypal", {
            container: "paypal-button",
            paymentMethodNonceInputField : "paymentMethodNonceInputField",
            onSuccess : function(){

                $('.credit-drp').remove();
                $('form[name="membership_pay"]').submit();

            },
            onCancelled: function(){
                $('#paypal-buttons').addClass('hide');
            },
            singleUse : false
        });


    });

</script>