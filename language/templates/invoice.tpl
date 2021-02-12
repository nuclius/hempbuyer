{include file="common/header-1.tpl" nocache}
<div class="main_container">
<style>
.cust {
    font-size: 22px;
    color: #555555;
    padding: 3px 21px;
    font-weight: bold;
}
.amt_paid {
    font-size: 20px;
    color: #555555;
    margin: 0px auto;
    padding: 14px 32px;
    font-weight: bold;
}
.trans_dtls {
    font-size: 22px;
    padding: 10px;
    color: #555555;
    font-weight: bold;
}
.order {
    margin: 11px 28px;
    font-size: 22px;
    color: #555555;
    font-weight: bold;
}
</style>
<div class="dash_acct" style="color: black;"><span onClick="window.location='{$config['url']}/dashboard/my'">{$pharse.dashboard}</span>  &gt;&gt;  <span onClick="window.history.back();">{$pharse.accounting}</span>  &gt;&gt;   {$pharse.transaction} <a id="print_invoice" href="#" style="cursor:pointer"><span style="float:right"><input type="button" class="btn btn-danger" value="Print"></span></a>
</div>
<div class="row amt_invoice1">
<div class="amt_paid">{$pharse.amount:} ${currencyConverter($invoice.amt - $invoice.refundamt)}</div>
<div class="invoice">{$pharse.this_invoice_has_been_paid_in_date_of} {$invoice.pay_date}</div>
</div>
  <div class="row">
  
  <div class="col-md-6">
  <div class="tgray_box">
    <div class=" cust">{$pharse.customer_billing_information}</div>
    <div class="cacell">{$invoice.first_name} {$invoice.last_name}<br />
               {$invoice.email}
               </div>
    <div class="cacell">{$invoice.address}, {$invoice.city}, {$invoice.state}, {$invoice.country}</div>
    <div class="cacell">{$invoice.phone}</div>
  </div>
  </div>

    <div class="col-md-6">
    <div class="tgray_box">
    <div class=" cust">{$pharse.transaction_trading_partner}</div>
    <!--<div class="cacell">{$invoice.name}
               </div>
    <div class="cacell">{if $invoice.uaddress != NULL}{$invoice.uaddress}{/if}</div>-->
        <div class="cacell">{$invoice.name}<br />
            {$invoice.email}
        </div>
        <div class="cacell">{if $invoice.seller_address} {$invoice.seller_address} ,{/if} {if $invoice.seller_city} {$invoice.seller_city},{/if} {$invoice.seller_state}, {$invoice.seller_country}</div>
        <div class="cacell">{if $invoice.seller_phone} {$invoice.seller_phone} {/if}</div>
</div>
</div>
</div>
<div class="row tranc_details">
<h5 class="trans_dtls">{$pharse.transaction_details}</h5>
<div class="col-md-3 padright">
<h6 class="trans">{$pharse.transaction_id}</h6>
<h6 class="value easp1">{$invoice.trans_id}</h6>
<h6 class="value">{$pharse.created:} {$invoice.create_date}</h6>
</div>
<div class="col-md-2">
<h6 class="trans">{4pharse.transaction_type}</h6>
<h6 class="value easp1">{4pharse.debit}</h6>
<h6 class="value">{$pharse.invoice_status:} {if $invoice.paid == 1}Paid{/if}{if $invoice.paid == 0}UnPaid{/if}</h6>
</div>
<div class="col-md-4">
<h6 class="trans">{$pharse.generated_by} </h6>
<h6 class="value easp1">{$pharse.billing_and_payments}</h6>
<h6 class="value">{$pharse.created_date:} {$invoice.create_date}</h6>
</div>
<div class="col-md-3 padle" style="padding-right: 1px;">
<h6 class="trans">To</h6>
<h6 class="value easp1">{$invoice.name}</h6>
<h6 class="value">{$pharse.paid_date:} {$invoice.pay_date}</h6>
</div>
</div>
<div class="row order_details">
<div class="order">{$pharse.order_details}</div>
<div class="paid">{$pharse.product_title} - {$invoice.title}</div>
<div class="prices">{$pharse.total:_us} ${currencyConverter($invoice.amt - $invoice.refundamt)}</div>
</div>
</div>
{literal}
<script>
$(function(){
$("#print_invoice").click(function(){
createPopup($('header').html()+$('.main_container').html()+$('footer').html());
})
});
</script>
{/literal}
{include file="common/footer-1.tpl" nocache} 