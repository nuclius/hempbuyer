{include file="/common/header-1.tpl" nocache}
<div class="col-md-12">
  <div class="dash_brd" style="padding:10px 0;"><a href="/dashboard/mybids">{$pharse.dashboard}</a> &gt;&gt; {$pharse.buynow}</div>
  <div class="check_wrapper"  style="margin:0; margin-bottom:4%;">
  <div class="prdt  gray_box">{$pharse.your_product}</div>
  
  

  
  
  <div class="clearfix search_list md_hide">
    <div class="pricelist ">{$pharse.item}</div>
    <div class="pricelist text-center">{$pharse.qty_ordered}</div>
    <div class="pricelist text-center">{$pharse.qty_added}</div>
    <div class="pricelist text-center">{$pharse.total_price(usd_$)}</div>
    <div class="pricelist text-center">{$pharse.refund_price(usd_$)}</div>
  </div>
  {foreach $buynow as $key => $val}
  <div class="search_list">
   <div class="pricelist1">
       <div data-label="Item Title" class="account_p_lbl item_ct"> {$val.title}</div>
      <div data-label="Item Image" class="account_p_lbl">
        <img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" class="wd100new">
      </div>
  </div>
  <div data-label="Qty Ordered" class="account_p_lbl pricelist11 p60 text-center">{$val.ordered}</div>
   <div data-label="Qty Added" class="account_p_lbl pricelist11 text-center">{$val.qty}</div>
  <div data-label="Total price(USD $)" class="account_p_lbl pricelist11 p60 text-center">{$pharse.us} ${currencyConverter($val.amount)}</div>
  <div data-label="Refund price(USD $)"class="account_p_lbl pricelist11 p60 text-center">{$pharse.us} ${$val.refund}</div>
  </div>
  
  {/foreach}

  <div class="row">
  <button type="button" class="btn btn-danger btns">{$pharse.paid_amount:}${$cart.amount}</button>
    {if $cart.refund > 0}
  <button type="button" class="btn btn-danger btns">{$pharse.refund_total:}${$cart.refund}</button>
    {/if}
  </div>
  
  </div>
  
  
  </div>
{include file="/common/footer-1.tpl" nocache} 
