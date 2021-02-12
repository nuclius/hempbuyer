<div class="row">
    {foreach $products as $key => $val}
    <div class="col-md-4">
        <div class="card sCard">
            <img class="card-img-top" src="./uploads/product/{$val.avatar}" alt="No Image Available" onerror="this.onerror=null;this.src='./no_image.png';" style="height: 200px">
            <div class="card-block cardbdyh">
                {if $val.watchlistFlag<=0}
                <i class="fa fa-heart addToWatchlist" title="Add to Watchlist" data-product_id="{$val.id}" data-status="active"></i>
                {else/}
                <i class="fa fa-heart addToWatchlist addedInWatchlist" title="Added in Watchlist" data-product_id="{$val.id}" data-status="inactive"></i>
                {/if}
                <h6 class="m-0 mt-1"><a href="{$config.url}/product/view/{$val.id}" class="text-dark" title="Product Tracking Id">#{$val.product_tracking_id}</a></h6>
                <h4 class="card-title"><a href="{$config.url}/product/view/{$val.id}" class="text-dark" title="{$val.title}">{$val.title}</a></h4>
                {if $val.type == 'auction'}
                    <p class="mb-1 sp-txt">{if $loged.userid}${$val.start_price}{/if}</p>
                    <p class="mb-1 tc-txt">Current Bid : {if $loged.userid}{if !$val.win_price} {else/} ${$val.win_price} {/if}{else/}-{/if}</p>
                    <div class="timer-txt" id="my{$val.id}">Closed</div>
                    <a href="{$config.url}/product/view/{$val.id}" class="btn btn-brown">{if $loged.userid==$val.user_id}View{else /}Bid Now{/if}</a>
                {elseif $val.type == 'offer'}
                    <p class="mb-1 sp-txt"></p>
                    <p class="mb-1 tc-txt">Offer Price: {if $loged.userid}${$val.offer_price}{else /}-{/if}</p>
                    <div class="timer-txt" id="my{$val.id}">Closed</div>
                    <a href="{$config.url}/product/view/{$val.id}" class="btn btn-brown">{if $loged.userid==$val.user_id}View{else /}Offer{/if}</a>
                {else/}
                    <p class="mb-1 sp-txt">{if $loged.userid}${$val.fixed_price}{/if}</p>
                    <p class="mb-1 tc-txt">&nbsp;</p>
                    <div class="timer-txt" id="my{$val.id}">Closed</div>
                    <a href="{$config.url}/product/view/{$val.id}" class="btn btn-brown">{if $loged.userid==$val.user_id}View{else /}Buy Now{/if}</a>
                {/if}
            </div>            
            <!-- <div class="upcoming">AVAILABLE</div> -->
        </div>
    </div>
    {/foreach}
    {if $products.length <= '0'}
        <div class="col-12 not_found">No Product Found! </div>
    {/if}
</div>
<nav class="text-right">
    {$pagination_html}
</nav>