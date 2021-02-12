{foreach $products as $key => $val}
    <div class="media mauc-media">
        <div class="media-left" style="width: 200px;">
            <!-- <img src="images/pro8.png" alt="" /> -->
            {if $val.watchlistFlag<=0}
                <i class="fa fa-heart addToWatchlist" title="Add to Watchlist" data-product_id="{$val.id}" data-status="active"></i>
            {else/}
                <i class="fa fa-heart addToWatchlist addedInWatchlist" title="Added in Watchlist" data-product_id="{$val.id}" data-status="inactive"></i>
            {/if}
            {if !$val.avatar}
                <img src="/no_image.png" alt="No Image Available" onerror="this.onerror=null;this.src='/no_image.png';" />
            {else/}
                <img src="/uploads/product/{$val.avatar}" alt="No Image Available" onerror="this.onerror=null;this.src='/no_image.png';" />
            {/if}
        </div>
        <div class="media-body">
            <div class="row">
                <div class="col-12">
                    <h3 class="pro-title">
                        <a href="{$config.url}/product/view/{$val.id}">{$val.title}</a>
                    </h3>
                    <div class="row">
                        <div class="col-sm-6 pro-con">
                        {if $val.type=="fixed"}
                            <img src="/images/return.png" /> Fixed Price : ${$val.fixed_price}
                        {elseif $val.type=="offer"}
                            <img src="/images/return.png" /> Offer Price : ${$val.offer_price}
                        {else /}
                            <img src="/images/return.png" /> Start Price : ${$val.start_price}
                        {/if}
                        </div>
                        <div class="col-sm-6 pro-con">
                            <img src="/images/pauction.png" /> Watchlist Date : {$val.watchlistDate}
                        </div>
                        <div class="col-sm-6 pro-con">
                            <img src="/images/total-quantity.png" /> Total Quantity : {$val.lots_available} {if $val.unit_of_measurement!='' and $val.unit_of_measurement!='0'} {$val.unit_of_measurement} {/if}
                        </div>
                        {if $val.type!="offer"}
                            <div class="col-sm-6 pro-con">
                                <span class="bid-txt">BID</span> Total Bid : {$val.totalBid}
                            </div>
                        {/if}
                    </div>
                </div> 
            </div>
        </div>
    </div>
{/foreach}

{if $products.length==0}
    <div class="text-center not_found">No Product Found! </div>
{/if}

<nav class="text-right">
     {$pagination_html}
</nav>