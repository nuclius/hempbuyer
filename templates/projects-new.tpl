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
<style>
.pro_img img {
    position: inherit;
    left: 0px;
    right: 0px;
    top: 0px;
    bottom: 0px;
    margin: auto;
    height: 200px;
   width: 170px;
    margin-top: 20px;
    margin-bottom: 20px;
	font-size: 15px;
line-height: 24px;
}
</style>
<div class="grid">
  {foreach $proj as $key => $val}
    <div class="col-md-4 col-sm-6 col-xs-6 w100-480" >
      <div class="thumbnail" onclick="window.location = '{$config['url']}/product/view/{$val.id}/{$val.title|replace:' ':'_'}'" style="height:421px;">
        {if $val.feature}<div class="hfeatured">{$phrase.featured}</div>{/if}
        <div class="pro_img"><img class="img-responsive" alt='{$val.title}' src="{if $val.avatar == ''}{$config['imgpath']}no_img.png    {elseif $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}">
        
     
        
        </div>
    <div class="pro_name" >{$val.ptitle}</div>      
        
        <div class="caption"><input type="hidden" id="tim{$val.id}" value="{$val.closed}" /><input type="hidden" class="pages_titletimer" name="getallproids[]" value="{$val.id}" />
  <div class="row pt_btn">
     <div class="col-md-8 col-sm-8 col-xs-8">
      {if $val.vauction == 1}
      <div class="bid_amount"><span class="prl_lbl">Base Price:</span><br /> <span class="curr_symbol">{$currency} </span> <span class="format">{$val.wprice}</span></div> 
      {elseif $val.auction == 0}
      <div class="bid_amount"><span class="prl_lbl">{$phrase.buynow_price}:</span><br /> <span class="curr_symbol">{$currency} </span> <span class="format">{$val.bprice}</span></div> 
      {elseif $val.auction == 1}
      <div class="bid_amount"><span class="prl_lbl">{$phrase.start_price}:</span><br /> <span class="curr_symbol">{$currency} </span> <span id="price{$val.id}" class="format">{$val.wprice}</span></div>
      {/if}
      </div>
      <div  class="col-md-4 col-sm-4 col-xs-4">
       {if $val.auction == 1}

                <div class="bid_amount"><span class="prl_lbl">{$phrase.bids}:</span><br /> {$val.bids}  {if $val.bids == 1 || $val.bids == 0} {$phrase.bid} {elseif $val.bids > 1} {$phrase.bids} {/if}</div>
               {elseif $val.auction == 0 && $val.vauction == 0}

         <div class="offer pro_offer" style="font-size:10px;">
                 {currencyConverter(100*{$val.mprice - $val.bprice}/$val.mprice)} % {$phrase.off}
        </div>
             {/if}  
    </div>
  </div>
        <div class="row pt_btn">
     <div class="col-md-8 col-sm-8 col-xs-8">
      
            <div class="font-10 timer" data-pid="{$val.id}" id="my{$val.id}">{$val.day}</div>

            {if $val.auction == 0 && $val.vauction == 0}
                  <div class="bid_amount"><span class="prl_lbl">{$phrase.available}:</span>{$val.qty-$val.sold - $val.booked} {$phrase.qty}</div>
               {/if}   
               {if $val.vauction == 1}
                 <img src="{$config.url}/images/video/camera.jpg" style="width:40px;" />
               
               {/if}
          </div>
      <div  class="col-md-4 col-sm-4 col-xs-4">
     
      {if $val.auction == 1}

                   <button class="btn btn-black">{$phrase.bid_now}</button>
      {/if}{if $val.vauction == 1}
                   <button class="btn btn-danger">Join Now</button>              
       {/if}{if $val.auction == 0 && $val.vauction == 0}
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
<div class="list hide">    
  {foreach $proj as $key => $val}

       <!--product1 start-->

    <div class="col-md-12 well well-bg" onclick="window.location = '{$config['url']}/product/view/{$val.id}'">

      <div class="col-md-3">
        {if $val.feature}<div class="hfeatured">{$phrase.featured}</div>{/if}
        <img class="img-responsive" alt='{$val.title}' src="{if $val.avatar == ''}{$config['imgpath']}no_img.png    {elseif $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}">
        

      </div>

      <div class="col-md-9 prod-right-box">
          <div class="col-md-12">
              <h3>{$val.ptitle}</h3>
          </div>

           <div class="caption"><input type="hidden" id="tim{$val.id}" value="{$val.closed}" /><input type="hidden" class="pages_titletimer" name="getallproids[]" value="{$val.id}" />

          <div class="col-md-12">
            <br/><br/><br/>
          </div>


        
          <div class="col-md-6 prod-left-area"> 
          <div class="col-md-8 buy-price">
              {if $val.auction == 0 and $val.vauction == 0}
                <strong>Buynow Price:</strong><br /> <span class="curr_symbol">{$currency} </span> <span class="format">{$val.bprice}</span>
                {elseif $val.auction == 1}
               <strong>{$phrase.start_price}:</strong><br /> <span class="curr_symbol">{$currency} </span> <span id="price{$val.id}" class="format">{$val.wprice}</span>
              {/if}
            </div> 
            <div class="col-md-4 offer-price">
            
                {if $val.auction == 1}

                <div class="bid_amount"><span class="prl_lbl">{$phrase.bids}:</span><br /> {$val.bids}  {if $val.bids == 1 || $val.bids == 0} {$phrase.bid} {elseif $val.bids > 1} {$phrase.bids} {/if}</div>
               {else if $val.auction == 0 && $val.vauction == 0}
                <div class="offer pro_offer" style="font-size:10px;">
                 {currencyConverter(100*{$val.mprice - $val.bprice}/$val.mprice)} % {$phrase.off}
                </div>
             {/if} 
            </div>
          </div>  
       

        <div class="col-md-6 prod-right-area">
          <div class="col-md-6 buy-price">
                <div class="font-10 timer" data-pid="{$val.id}" id="mys{$val.id}">{$val.day}</div>

                {if $val.auction == 0 && $val.vauction == 0}
                  <div class="bid_amount"><span class="prl_lbl">{$phrase.available}:</span>{$val.qty-$val.sold - $val.booked} {$phrase.qty}</div>
               {/if}   
             </div>

            <div class="col-md-6">
               {if $val.auction == 1}
                 <button class="btn btn-black">{$phrase.bid_now}</button>
               {else if $val.auction == 0}
                 <button class="btn btn-danger">{$phrase.buy_now}</button>
                {/if}
            </div>

          </div>

        </div>

        </div>

      </div>


<!--product1 end-->

    {include file="time-loader2.tpl" nocache}

  {/foreach}
  <div class="font-10" id="timer"></div>

</div>
  </div>


<style>
.pro_img img {

	font-size: 15px;
line-height: 24px;
}
</style>