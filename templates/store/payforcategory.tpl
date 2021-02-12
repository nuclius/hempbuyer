{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}


<div class="container col-md-12">
    <div class="container col-md-7 col-md-offset-3 text-center">
    {if $pagetype == 'getpay'}
        <div class="col-md-9 col-md-offset-1 panel panel-default panel-heading">
            <div class="row h4">Store Categories plan</div>
            <form id="storepayment" name="storepayment" action="/stores/addcat/dopay" method="post">
                <input type="hidden" name="storeid" value="{$storeid}">
                <div class="form-group row text-right">
                    <label for="plan" class="col-md-6" style="margin-top:7px;">Select no of additional Categories: </label>
                    <div class="col-md-6">
                        <select class="form-control text-left" name="totalcount" id="newsubcat">
                        </select>
                    </div>
                </div>
                <div class="form-group row text-right">
                    <label for="amount" class="col-md-6" style="margin-top:7px;">Amount for per Category :</label>
                    <div class="col-md-6">
                        {foreach $store_plans as $key => $val}
                            {if $val.type == 'category'}
                                <input type="hidden" name="plan_val" value="{$val.id}">
                                <div class="form-control text-left" attr-val="{$val.amount}" id="amount">{$val.amount}</div>
                            {/if}
                        {/foreach}
                    </div>
                </div>
                <div class="form-group row text-center">
                    <button type="button" class="btn btn-default" onclick="location.href='{$config.url}/store/edit/{$storeid}';">Cancel</button>
                    <button type="submit" name="submit" class="btn btn-success">Submit</button>
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
{if $pagetype != 'getpay' && $failedpament == '1'}
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
{if $pagetype == 'getpay'}
    <script type="text/javascript">
        var sel_cat = "{$selected_category}";
            sel_cat = sel_cat.split(',');
        var sel_cat_len = sel_cat.length;
        var sel_cat1 = "{$subcat}";
            sel_cat1 = sel_cat1.split(',');
        var sel_cat1_len = sel_cat1.length;
        total = Number(sel_cat_len)- Number(sel_cat1_len);
        var optn = '';
        for (var i = 0; i < total; i++) {
            var cnt = i+1;
            optn += '<option value="'+cnt+'">'+cnt+'</option>';
        }
        $('#newsubcat').html(optn);
    </script>
{/if}
