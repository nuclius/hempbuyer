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
<div class="row">
  <div class="col-md-3"> {include file="left-nav-dashboard.tpl" nocache} </div>
  <div class="col-md-9">
        <div class="row lp_table">
           {foreach $packages as $key => $val}
            <div class="col-md-4 pricing-table {if $key == 1}price_box{/if} {if $key == 2}price_box1{/if} {if $key == 0}price_box2{/if}">
              <ul>
                <li class="title">
                 {$val.name} 
                </li>
                <li class="price">
                  1 {$phrase.lorieum_ipsum}
                </li>
                <li>
                  {$phrase.lorieum_ipsum}
                </li>
                <li>
                  {$phrase.lorieum_ipsum}
                </li>
                <li>
                  {$phrase.lorieum_ipsum}
                </li>
                <li>
                  {$phrase.lorieum_ipsum}
                </li>
                <li>
                  {$phrase.lorieum_ipsum}
                </li>
                <li class="ptitle rd_txt">${$val.price}</li>
                <li class="button">
                 <a href="{$config.url}/package/buy/{$val.id}"> <button class="btn btn-large lred">
                    {$phrase.buy_now}
                  </button></a>
                </li>
              </ul>
            </div>
            
            {/foreach} 
          </div>
      </div>
  </div>    

{include file="common/footer-1.tpl" nocache} 