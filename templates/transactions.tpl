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
      <h4 class="ds_brd">{$phrase.my_transaction}</h4>
      <div class="row mblue_box">
        <div class="col-md-3"> {$phrase.description} </div>
        <div class="col-md-1"> {$phrase.type} </div>
        <div class="col-md-2"> {$phrase.amount} </div>
        <div class="col-md-2"> {$phrase.date} </div>
        <div class="col-md-2"> {$phrase.gateway} </div>
        <div class="col-md-1"> {$phrase.status} </div>
      </div>
      {if $transaction|count <=  0}
      <div class="col-md-12 text-center m-top-20 font-12">No Results Found</div>
      {else}
      {foreach $transaction as $key => $val}
      <div class="row mblue_box1">
        <div class="col-md-3">{$val.description} </div>
        <div class="col-md-1">{$val.type} </div>
        <div class="col-md-2">${$val.amount} </div>
        <div class="col-md-2">{$val.date_added}</div>
        <div class="col-md-2">{$val.gateway} </div>
        <div class="col-md-1">{$val.status} </div>
      </div>
      {/foreach}
      {/if}  {$pagination_html}</div>
  </div>
</div>
{include file="common/footer-1.tpl" nocache}
