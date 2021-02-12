{include file="/common/header-1.tpl" nocache}
{if $failedpament == '0'}<div style="margin: 20px; color:#F00;">{$pharse.error_occured_with_payment._please_contact_admin} </div>
<script  type="text/javascript" language="javascript">
    $(function()
    {
        setTimeout(function(){window.location.href = "/";}, 1000);
    });
</script>
{/if}
{if $failedpament == '1'}
<div >{$pharse.processing....}</div>
<div style="font-size: 18px; color:#ff0; "></div>
<form action="{$paypalurltopay}" target="PPDGFrame" class="standard">
    <input type="submit" id="submitBtn" value="Pay with PayPal" style="display:none;" >
    <input id="type" type="hidden" name="expType" value="light">
    <input id="paykey" type="hidden" name="paykey" value="{$clientToken}">
</form>
{literal}
<script src="https://www.paypalobjects.com/js/external/dg.js"  type="text/javascript" language="javascript">
</script>
<script  type="text/javascript" language="javascript">
    $(function()
    {
        var dgFlow = new PAYPAL.apps.DGFlow({ trigger: submitBtn});
        setTimeout(function(){$('#submitBtn').trigger('click');}, 1000);
    });
</script>
{/literal}
{/if}
{include file="/common/footer-1.tpl" nocache}
