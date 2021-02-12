{foreach $products as $key => $val}
    <div class="media mauc-media">
        <div class="media-left">
            <!-- <img src="images/pro8.png" alt="" /> -->
            {if !$val.avatar}
                <img src="/no_image.png" alt="No Image Available" onerror="this.onerror=null;this.src='/no_image.png';" />
            {else/}
                <img src="/uploads/product/{$val.avatar}" alt="No Image Available" onerror="this.onerror=null;this.src='/no_image.png';" />
            {/if}
        </div>
        <div class="media-body">
            <div class="row">
                <div class="col-md-8">
                    <h3 class="pro-title">
                        <a href="{$config.url}/product/view/{$val.id}">{$val.title}</a>
                    </h3>
                    <div class="row">
                        <div class="col-sm-7 pro-con">
                            <img src="/images/return.png" /> 
                            {if $val.type == 'auction'}
                                Start Price : ${$val.start_price}
                            {elseif $val.type == 'offer'}
                                Offer Price : ${$val.offer_price}
                            {else /}
                                Fixed Price : ${$val.fixed_price}
                            {/if}
                        </div>
                        <div class="col-sm-5 pro-con">
                            <img src="/images/pauction.png" /> Sold : {$val.totalSold}
                        </div>
                        <div class="col-sm-7 pro-con">
                            <img src="/images/total-quantity.png" /> 
                            {if $val.type == 'offer'}
                                Offer Quantity : {$val.offer_qty}
                            {else /}
                                Total Quantity : {$val.lots_available}
                            {/if}
                            {if $val.unit_of_measurement!='' and $val.unit_of_measurement!='0'} {$val.unit_of_measurement} {/if}
                        </div>
                        <div class="col-sm-5 pro-con">
                            <span class="bid-txt">BID</span> Total Bid : {$val.totalBid}
                        </div>
                        {if $val.type == 'auction'}
                            <div class="col-sm-7 pro-con">
                                <img src="/images/return.png" /> Reserve Price : ${$val.reserve_price}
                            </div>
                            <div class="col-sm-5 pro-con">
                                <img src="/images/pauction.png" /> Current Bid : ${if !$val.win_price}0{else /}{$val.win_price}{/if}
                            </div>
                        {/if}
                    </div>
                </div>
                <div class="col-md-4 text-center ptop-50"> 
                    <a href="{$config.url}/product/{$val.id}?draft=1" class="btn btn-brown">Edit</a>
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
