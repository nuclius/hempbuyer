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

<style type="text/css">
.pdbut .btn
{
  margin:10px;
}
</style>
<div class="container row sellp1">
<div class="col-md-10 padlef0">
{include file="selling-menu.tpl" nocache}
      {if $mybids|count <=  0}
     <div class="row mblue_box1 tno_bids"> {$phrase.no_won_auction_found} </div>
      {else}
      {foreach $mybids as $key => $val}
       <div class="row sellp border-btm">
        <div class="col-md-2 padlef0 photo_pbox">
        <img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" class="wd100" />
        </div>
        <div class="col-md-8">
         <div class="Listft16"><a href="{$config['url']}/product/view/{$val.project_id}"  title="{$val.ptitle}">{$val.title}</a></div>
         <p class="Lis14 text-justify height_58">{$val.description}</p>
         <div class="clearfix price">
			<div class="gray_bbox"> {$phrase.quantity} : {if $val.qty == ''} 1 {else if $val.qty != ''} {$val.qty} {/if}</div> 
			<div class="gray_bbox">price:<span class="curr_symbol">{$currency} </span> <span id="price{$val.amount}" class="format">{$val.amount}</span> </div>
			<div class="gray_bbox"> {$phrase.won_date}: {$val.date_add} </div>
		 </div>       
			<div class="clearfix">
          {if $val.paid == 0}
                   <button type="button" class="btn btn-danger bttns" onclick="window.location = '{$config.url}/product/payment/{$val.b_id}'" style="margin-top:5px;">{$phrase.pay_now}</button>
                {/if}
                {if $val.paid == 1 || $val.paid == 2}
                <button type="button" class="btn btn-danger" onclick="window.location='{$config.url}/dashboard/invoice/{$val.b_id}'" style="margin-top:5px;">{$phrase.view_invoice}</button>
                {if $val.release == 0}<button type="button" class="btn btn-danger" onclick="doAction('release_buy',{$val.b_id})" style="margin-top:5px;">{$phrase.release_fund}</button>{/if}
                {if $val.shipping_info != ''}<button type="button" class="btn btn-danger" onclick="viewShippingTracking({$val.cart_id},{$val.b_id})" style="margin-top:5px;">{$phrase.view_shipping_tracking}</button>{/if}                
                {if $val.release == 0}<button type="button" class="btn btn-danger"  onclick="doAction('cancel_buy',{$val.b_id})" style="margin-top:5px;">{$phrase.cancel_fund}</button>{/if}
                {if $val.release == 2}<button type="button" class="btn btn-danger" style="margin-top:5px;">{$phrase.fund_cancelled}</button>{/if}
                {if $val.release == 1}<button type="button" class="btn btn-danger" style="margin-top:5px;">{$phrase.fund_released}</button>{/if}
                {if $val.feedback == 0 and $val.release > 0}<button type="button" class="btn btn-danger"  style="margin-top:5px;" onclick="doAction('feedback_buy',{$val.b_id})">{$phrase.leave_a_feedback}</button>{/if}
                {if $val.feedback == 1 and $val.release > 0}<button type="button" class="btn btn-danger"  style="margin-top:5px;" onclick="feedbackReview({$val.b_id})">{$phrase.feedback_detail}</button>{/if}
                 {if $val.dispute_id > 0}
                <input type="hidden" id="dispute{$val.dispute_id}" value='{$val.message}'>
                <button type="button" class="btn btn-danger bttns" style="margin-top:5px;" onclick="view_dispute_details({$val.dispute_id},'{$val.subject}')">{$phrase.show_dispute} </button>

                 {/if}
                {if !$val.dispute_id > 0}
                <button type="button" class="btn btn-danger bttns" style="margin-top:5px;" onclick="view_dispute({$val.id})">{$phrase.add_dispute}</button>
                {/if}
                
                {/if}
			</div>
         </div>   
        </div>
        
      {/foreach}  

{$pagination_html}
{/if}
</div>
<div class="dpad_zero col-md-2 col-xs-12 pull-right">
	<div class="r_btns"><a class="btn btn-danger" href="{$config.url}/dashboard/mybids">Buy An Item</a></div>
	<div class="r_btns"><a class="btn btn-default" href="{$config.url}/dashboard/messages">Messages</a></div>
	<div class="r_btns"><a class="btn btn-default" href="{$config.url}/profile_settings">Profile</a></div>
	<div class="r_btns"><a class="btn btn-default" href="{$config.url}/dashboard/payments">Payments</a></div>

    {include file="adwords.tpl" nocache}
</div>
<script type="text/javascript">
function doAction(cmd,id)
{
    if(cmd == 'release_buy')
    {
        var r = confirm("Are You sure yo want to release the fund?");
        if (r == true) {
            window.location = '{$config.url}/dashboard/payment/release/buy/'+id
        } else {
            return false;
        }
    } 
    if(cmd == 'cancel_buy')
    {
        var r = confirm("Are You sure yo want to cancel the fund?");
        if (r == true) {
            window.location = '{$config.url}/dashboard/payment/cancel/buy/'+id
        } else {
            return false;
        }
    } 
    if(cmd == 'release')
    {
        var r = confirm("Are You sure yo want to release the fund?");
        if (r == true) {
            window.location = '{$config.url}/dashboard/payment/release/bid/'+id
        } else {
            return false;
        }
    } 
    if(cmd == 'cancel')
    {
        var r = confirm("Are You sure yo want to cancel the fund?");
        if (r == true) {
            window.location = '{$config.url}/dashboard/payment/release/bid/'+id
        } else {
            return false;
        }
    } 
    if(cmd == 'feedback_buy')
    {
       
            window.location = '{$config.url}/dashboard/payment/feedback/buy/'+id
    } 
    if(cmd == 'feedback')
    {
       
            window.location = '{$config.url}/dashboard/payment/feedback/bid/'+id
        
    }  

}
</script>








</div>
</div>
{include file="common/footer-1.tpl" nocache} 
<div class="modal fade" id="shippinginfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
     <div class="modal-header"><h2 style="color: #000;font-size: 20px;font-weight: bold;">{$phrase.shipping_info}</h2></div>
     <div class="modal-body info-data"></div>    
    </div>
  </div>

    </div>
  </div>
  <div class="modal fade" id="feedbackinfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
     <div class="modal-header"><h2 style="color: #000;font-size: 20px;font-weight: bold;">{$phrase.feedback}</h2></div>
     <div class="modal-body info-data"></div>    
    </div>
  
  </div>

    </div>
  </div>