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

<div class="pric_l">
  <div class="rtext">${$projects.wprice}</div>
  <div class="gray_txt">{if $projects.market_status == 'open' or $projects.market_status == 'draft'}<h3 class="countdown" id="my{$projects.id}">{$projects.day}</h3>{else} {$phrase.auction_closed}{/if}</div>
  <div class="proc_title">{$projects.title}</div>
  {if $projects.market_status == 'open'}<button class="btn bid_now" data-toggle="modal" data-target="#confirmbid ">{$phrase.bid_now}</button>{/if}
  <div class="gray_txt">
    <div>{$phrase.value_price} ${$projects.mprice}</div>
    <div>{$phrase.bids_credit} ${$config.general['eachbidpay']}</div>
  </div>
  {if $projects.market_status == 'open' and $projects.buynow}<div class="dashed_sep"></div>
 <button class="btn btn-primary" data-toggle="modal" data-target="#buybid ">{$phrase.buy_now} ${$projects.bprice}</button>{/if}
</div>
<div class="bid_history">
  <div class="bid_hh">{$phrase.bid_history}</div>
  <div class="bid_his"> {if $bcnt == 0}
    <ul>
      <li>
        <p class="no_data proc_title">{$phrase.no_bids_yet}</p>
      </li>
    </ul>
    {else}
    {foreach $bids as $key => $val}
    <div>{$val.name} <!--2014-12-17 03:29:39--> ${$val.proposed_amount}</div>
    {/foreach}
    <div class="total_bids">{$phrase.total_bids} : <span class="lcntbid">{$bcnt}</span> <span class="pull-right"><a href=""><i class="fa fa-chevron-right"></i></a></span></div>
    {/if} </div>
</div>