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

<div class="row products_row">
  {foreach $proj as $key => $val}
    <div class="col-md-4 col-sm-6 col-xs-6 w100-480">
      <div class="thumbnail" onclick="window.location = '{$config['url']}/product/view/{$val.id}/{$val.title|replace:' ':'_'}'"  style="height:380px;">
        {if $val.feature}<div class="hfeatured">{$phrase.featured}</div>{/if}
        <div class="pro_img"><img class="img-responsive" src="{if $val.avatar == ''}{$config['imgpath']}no_img.png    {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" alt="{$val.title}">
                    </div>
		<div class="pro_name" >{$val.ptitle}</div>			
        
        <div class="caption"><input type="hidden" id="tim{$val.id}" value="{$val.closed}" /><input type="hidden" class="pages_titletimer" name="getallproids[]" value="{$val.id}" />
	<div class="row pt_btn">
		 <div class="col-md-8 col-sm-8 col-xs-8">
			{if $val.auction == 0}
			<div class="bid_amount"><span class="prl_lbl">{$phrase.buynow_price}:</span><br /><span class="curr_symbol">{$currency} </span>{$val.bprice}</div> 
			{else if $val.auction == 1}
			<div class="bid_amount"><span class="prl_lbl">{$phrase.start_price}:</span><br /><span class="curr_symbol">{$currency} </span><span id="price{$val.id}">{$val.wprice}</div>
			{/if}
			</div>
			<div  class="col-md-4 col-sm-4 col-xs-4">
			 {if $val.auction == 1}
                <div class="bid_amount"><span class="prl_lbl">{$phrase.bids}:</span><br /> {$val.bids} {$phrase.bids}</div> 
               {else if $val.auction == 0}
			   <div class="offer pro_offer" style="font-size:10px;">
                 {currencyConverter(100*{$val.mprice - $val.bprice}/$val.mprice)} % off
				</div>
             {/if}  
		</div>
	</div>
        <div class="row pt_btn">
		 <div class="col-md-8 col-sm-8 col-xs-8">
			
            <div class="timer font-10" id="my{$val.id}">{$val.day}</div>
			 {if $val.auction == 0}
                  <div class="bid_amount"><span class="prl_lbl">{$phrase.available}:</span>{$val.qty-$val.sold} Qty</div>
               {/if}   
          </div>
		  <div  class="col-md-4 col-sm-4 col-xs-4">
		  {if $val.auction == 1}
                 <button class="btn btn-black">{$phrase.bid_now}</button>
               {else if $val.auction == 0}
                 <button class="btn btn-danger">{$phrase.buy_now}</button>
             {/if}   
           </div>
         </div>
          <!--<div class="current_bidder">Current Highest Bidder:xyz</div> -->
          
        </div>
       
      </div>
     
    </div>
    {include file="time-loader.tpl" nocache}


    {/foreach}
  </div>

