{include file="/common/header-1.tpl" nocache}
<style type="text/css">
.dvPreview img{
  margin:10px;
}
</style>
<div class="row sellp1">
<div class="daashbrd_cngpswd"><a href="/dashboard/mybids">{$pharse.dashboard}</a> &gt;&gt; {$pharse.payments}</div>
<div class="col-md-3 txtfun3 padlef0 mobile_view">
{include file="left-profile-nav.tpl" nocache}
</div>
<div class="ds npayment col-md-9 mobile_view">
  <!--<div class="ct_headt">Payment</div>-->
  <div class="panel panel-default">
    <div class=" panel-heading md_hide">
      <div class="row">

            <div class="col-md-6 pclr">{$pharse.description}</div>
            <div class="col-md-2 pclr" style="padding: 0 10px">{$pharse.status}</div>
            <div class="col-md-2 pclr" style="padding: 0 10px">{$pharse.totalpaid}</div>
            <div class="col-md-2 pclr">{$pharse.action}</div>

      </div>
    </div>
      {if $payments|count <=  0}
      <div class="row mblue_box1 tno_bids"> {$pharse.no_payment_yet} </div>
      {else}
      {foreach $payments as $key => $val}
    <div class="panel-body">
      <div class="row">

              <div data-label="Description" class="account_p_lbl col-md-6">
			   <div class="checkout_right_con">
                <div class="pclr_pay">{$val.description} <!--#{$val.primary_id}--></div>
                <div class="parclr">{$pharse.credited:}{$val.date_added}</div>
                <div class="parclr">{if $val.user_id == $loged.userid} {$pharse.debit} {else if $val.user_id != $loged.user_id} {$pharse.credit} {/if}</div>
				</div>
              </div>
              <div data-label="Status" class="account_p_lbl col-md-2">
                <div class="parclr">{if $val.admin==2}Refunded{else if}{$val.type}{/if}

                </div>
              </div>
               <div data-label="TotalPaid" class="account_p_lbl col-md-2">
                <div class="parclr">US $ {$val.amount}</div>
              </div>
           <div data-label="Action" class="payments_btns account_p_lbl col-md-2">
              {if $val.status == 'paid'}
                 <button class="btn btn-danger" {if $val.type == 'sold'} onclick="window.location='{$config.url}/dashboard/invoice/{$val.buynow_id}'" {/if}  {if $val.type == 'winner'} onclick="window.location='{$config.url}/dashboard/invoice/{$val.buyid}'" {/if}>{$pharse.paid}</button>
              {/if}
               {if $val.status == 'unpaid' && $val.user_id == $loged.userid && $val.type == 'winner'} <label class="label label-danger" onclick="window.location='{$config.url}/product/payment/{$val.buyid}'">Pay</label> {/if}
              {if $val.status == 'unpaid' && $val.user_id != $loged.userid && $val.type == 'winner'} <label class="label label-danger" >{$pharse.unpaid}</label> {/if}
             </div>

      </div>
    </div>
    {/foreach}
      {/if}

  </div>
      <div class="col-md-9">
        {$pagination_html}
      </div>
      <div class="col-md-3">
        <button class="btn btn-backn" onclick="window.location='{$config.url}/dashboard/paymentexport/'">{$pharse.export_as_csv}</button>
      </div>
</div>
</div>
</div>

{include file="/common/footer-1.tpl" nocache}
