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
<div class="main_container">
  <div class="row dashboard">
    <div class="col-md-3"> {include file="left-nav-dashboard.tpl" nocache} </div>
    <div class="col-md-9"> 
      <h4 class="ds_brd">{$phrase.shipping_address}</h4>
      {if $shipping|count == 0} <a href="{$config['url']}/dashboard/Address/shipping" title="ADD SHIPPING ADDRESS" name="key">
      <button class="btn edit_shipin">{$phrase.add_shipping_address}</button>
      </a> {/if}
      {if $shipping|count > 0}
      <!--<h4 class="shead">Shipping Address</h4>-->
      <div class="row mblue_box">
        <div class="ship_add">{$phrase.name} </div>
        <div class="ship_add">{$phrase.address}</div>
        <div class="ship_add"> {$phrase.state} </div>
        <div class="ship_add">{$phrase.city}</div>
        <div class="ship_add">{$phrase.postcode} </div>
        <div class="ship_add">{$phrase.phone_no} </div>
        <div class="ship_add"> {$phrase.options}</div>
      </div>
      <div class="row mblue_box1">
        <div class="ship_add">{$shipping.name}</div>
        <div class="ship_add">{$shipping.address1} {if $shipping.address2 !=''},  {$shipping.address2} {/if} </div>
        <div class="ship_add"> {$shipping.state} </div>
        <div class="ship_add">{$shipping.city} </div>
        <div class="ship_add">{$shipping.zipcode} </div>
        <div class="ship_add">{$shipping.phone} </div>
        <div class="ship_add"> <a href="{$config['url']}/dashboard/Address/shipping" title="Edit" class="delet_link">Edit</a> &nbsp;  &nbsp; <a href="{$config['url']}/dashboard/RemoveAddress/shipping" title="Edit" class="delet_link">Delete</a> </div>
      </div>
      {/if}
      
      
      
      <h4 class="ds_brd m-top-20">{$phrase.billing_address}</h4>
      {if $billing|count == 0}<a href="{$config['url']}/dashboard/Address/billing" title="ADD BILLING ADDRESS" name="key">
      <button class="btn edit_shipin">{$phrase.add_billing_address}</button>
      </a> {/if} 
      {if $billing|count > 0}
     <!-- <h4 class="shead">Billing Address</h4>-->
      <div class="row mblue_box">
        <div class="ship_add">{$phrase.name} </div>
        <div class="ship_add">{$phrase.address}</div>
        <div class="ship_add"> {$phrase.state} </div>
        <div class="ship_add">{$phrase.city}</div>
        <div class="ship_add">{$phrase.postcode} </div>
        <div class="ship_add">{$phrase.phone_no} </div>
        <div class="ship_add"> {$phrase.options}</div>
      </div>
      <div class="row mblue_box1" style="background:none">
        <div class="ship_add">{$billing.name}</div>
        <div class="ship_add">{$billing.address1} {if $billing.address2 !=''} ,  {$billing.address2}{/if} </div>
        <div class="ship_add"> {$billing.state} </div>
        <div class="ship_add">{$billing.city} </div>
        <div class="ship_add">{$billing.zipcode} </div>
        <div class="ship_add">{$billing.phone} </div>
        <div class="ship_add"> <a href="{$config['url']}/dashboard/Address/billing" title="Edit" class="delet_link">Edit</a> &nbsp;  &nbsp; <a href="{$config['url']}/dashboard/RemoveAddress/billing" title="Edit" class="delet_link">Delete</a> </div>
      </div>
      {/if} </div>
  </div>
</div>
{include file="common/footer-1.tpl" nocache} 
<style>
.ship_add
{
	width:106px !important;
}
</style>