{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}

<div class="container col-md-12">
    <div class="container col-md-7 col-md-offset-3 text-center">
    {if $pagetype == 'getpay'}
        <div class="col-md-9 col-md-offset-1 panel panel-default panel-heading">
            <div class="row h4">Store plan</div>
            <form id="storepayment" class="storepayment" name="storepayment" action="{$config.url}/stores/payforstore/dopay" method="post">
                <input type="hidden" name="storeid" value="{$storeid}">
                <div class="form-group row text-right">
                    <label for="plan" class="col-md-4" style="margin-top:7px;">Select Store plan: </label>
                    <div class="col-md-8">
                        <select class="form-control" name="plan_val" id="plan_val" onchange="$('#get_amount').html($('#plan_val option:selected').attr('attr-amt'));$('#no_products').html($('#plan_val option:selected').attr('attr-cnt'));">
                            <option value="0" attr-amt="0" attr-cnt="0">--Select--</option>
                            {foreach $store_plans as $key => $val}
                            {if $val.type == 'store'}
                            <option value="{$val.id}" attr-amt="{$val.amount}" attr-cnt="{$val.counts}">{$val.title}</option>
                            {/if}
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group row text-right">
                    <label for="amount" class="col-md-4" style="margin-top:7px;">Amount :</label>
                    <div class="col-md-8">
                        <div class="form-control text-left" id="get_amount">0</div>
                    </div>
                </div>
                <div class="form-group row text-right">
                    <label for="amount" class="col-md-4" style="margin-top:7px;">No of Products :</label>
                    <div class="col-md-8">
                        <div class="form-control text-left" id="no_products">0</div>
                    </div>
                </div>
                <button type="submit" style="display:none;" id="submitform"></button>
                <div class="form-group row text-center">
                    <button type="button" class="btn btn-default" onclick="location.href='{$config.url}/stores/edit/{$storeid}';">Cancel</button>
                    <button type="button" name="submit" class="btn btn-success submit_btn">Submit</button>
                </div>
            </form>
        </div>
    {else if $pagetype != 'getpay'}
        {if $failedpament == '0'}
            <div style="margin: 20px; color:#F00;">
                <!-- {$phrase.error_occured_with_payment_please_contact_admin} -->
                We getting some error like this on paypal. So please try again later.<br>
                {$paypalerr}
            </div>
            <script  type="text/javascript" language="javascript">
                $(function()
                {
                    setTimeout(function(){window.location.href = "/";}, 1000);
                });
            </script>
        {/if}
        {if $failedpament == '1'}
            <form action="{$paypalurltopay}" target="PPDGFrame" class="standard">
                <label for="buy">Buy Now:</label>
                <input type="image" id="submitBtn" value="Pay with PayPal" src="https://www.paypalobjects.com/en_US/i/btn/btn_paynowCC_LG.gif">
                <input id="type" type="hidden" name="expType" value="light">
                <input id="paykey" type="hidden" name="paykey" value="{$clientTokens}">
            </form>
        {/if}
    {/if}
    </div>
</div>
{if $pagetype == 'getpay'}
    <script type="text/javascript">
        $('body').on('click','.submit_btn',function() {
            if(Number($('#plan_val').val()) > 0) {
                $('#submitform').trigger('click');
            } else {
                alert("Please select any one plan to continue");
            }
        });
    </script>
{else if $pagetype != 'getpay' && $failedpament == '1'}
    <script src="https://www.paypalobjects.com/js/external/dg.js"  type="text/javascript" language="javascript"></script>
    <script type="text/javascript" charset="utf-8">
        $(function () {
            var dgFlow = new PAYPAL.apps.DGFlow({
                trigger : "submitBtn"
            });
        });
    </script>
{/if}

{include file="common/footer-1.tpl" nocache}
{include file="store/store-js.tpl" nocache}
