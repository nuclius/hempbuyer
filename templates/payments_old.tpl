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

{include file="/common/header-1.tpl" nocache}
<style type="text/css">
.dvPreview img{
  margin:10px;
}
</style>
<div class="container row sellp1">
<div class="daashbrd_cngpswd"><a href="/dashboard/mybids">Dashboard</a> &gt;&gt; {$phrase.payments}</div>
<div class="col-md-3 txtfun3 padlef0 mobile_view">
{include file="left-profile-nav.tpl" nocache}
</div>
<div class="ds npayment col-md-9 mobile_view">
  <!--<div class="ct_headt">Payment</div>-->
  <div class="panel panel-default">
    <div class=" panel-heading md_hide">
      <div class="row">

            <div class="col-md-6 pclr">{$phrase.description}</div>
            <div class="col-md-2 pclr" style="padding: 0 10px">{$phase.status}</div>
            <div class="col-md-2 pclr" style="padding: 0 10px">{$phrase.totalpaid}</div>
            <div class="col-md-2 pclr">{$phrase.action}</div>

      </div>
    </div>
      {if $payments|count <=  0}
      <div class="row mblue_box1 tno_bids"> {$phrase.no_payment_yet} </div>
      {else}
      {foreach $payments as $key => $val}
    <div class="panel-body">
      <div class="row">

              <div data-label="Description" class="account_p_lbl col-md-6">
			   <div class="checkout_right_con">
                <div class="pclr_pay">{$val.description} <!--#{$val.primary_id}--></div>
                <div class="parclr">{$phrase.credited}:{$val.date_added}</div>
                <div class="parclr">{if $val.user_id == $loged.userid} Debit {else if $val.user_id != $loged.user_id} Credit {/if}</div>
				</div>
              </div>
              <div data-label="Status" class="account_p_lbl col-md-2">
                <div class="parclr">{if $val.admin==2}{$phrase.refunded}{else if}{$val.type}{/if}

                </div>
              </div>
               <div data-label="TotalPaid" class="account_p_lbl col-md-2">
                <div class="parclr"><span class="curr_symbol">{$currency} </span> {$val.amount}</div>
              </div>
           <div data-label="Action" class="payments_btns account_p_lbl col-md-2">
              {if $val.status == 'paid'}
                 <button class="btn btn-danger" {if $val.type == 'sold'} onclick="window.location='{$config.url}/dashboard/invoice/{$val.buynow_id}'" {/if}  {if $val.type == 'winner'} onclick="window.location='{$config.url}/dashboard/invoice/{$val.buyid}'" {/if}>{$phrase.paid}</button>
              {/if}
               {if $val.status == 'unpaid' && $val.user_id == $loged.userid && $val.type == 'winner'} <label class="label label-danger" onclick="window.location='{$config.url}/product/payment/{$val.buyid}'">{$phrase.pay}</label> {/if}
              {if $val.status == 'unpaid' && $val.user_id != $loged.userid && $val.type == 'winner'} <label class="label label-danger" >{$phrase.unpaid}</label> {/if}
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
        <button class="btn btn-backn" onclick="window.location='{$config.url}/dashboard/paymentexport/'">{$phrase.export_as_csv}</button>
      </div>
</div>
</div>
</div>
<style media="screen">
    .btn-danger{
        color:#a4a4a4 !important;
    }
    .btn-danger:hover, .btn-danger:focus {
        color: #fff !important;
    }
</style>
{include file="/common/footer-1.tpl" nocache}
