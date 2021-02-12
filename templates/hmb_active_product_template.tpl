{foreach $products as $key => $val}
    <div class="media mauc-media">
        <div class="media-left" style="width: 200px;"> 
            {if !$val.avatar}
                <img src="/no_image.png" alt="No Image Available" onerror="this.onerror=null;this.src='/no_image.png';" />
            {else/}
                <img src="/uploads/product/{$val.avatar}" alt="No Image Available" onerror="this.onerror=null;this.src='/no_image.png';" />
            {/if}
        </div>
        <div class="media-body">
            <div class="row">
                <div class="col-md-7">
                    <h3 class="pro-title">
                        <a href="{$config.url}/product/view/{$val.id}">{$val.title}</a>
                    </h3>
                    <div class="row">
                        <div class="col-sm-7 pro-con">
                            <img src="/images/return.png" /> Start Price : ${$val.start_price}
                        </div>
                        <div class="col-sm-5 pro-con">
                            <img src="/images/pauction.png" /> Sold : {$val.totalSold}
                        </div>
                        <div class="col-sm-7 pro-con">
                            <img src="/images/total-quantity.png" /> Total Quantity : {$val.lots_available} {if $val.unit_of_measurement!='' and $val.unit_of_measurement!='0'} {$val.unit_of_measurement} {/if}
                        </div>
                        <div class="col-sm-5 pro-con">
                            <span class="bid-txt">BID</span> Total Bid : {$val.totalBid}
                        </div>
                    </div>
                </div>
                <div class="col-md-5 text-center">
                    <img src="/images/chronometer.png" class="m-auto cm-icon" />
                    <div class="time-left">Time Left</div>
                    <div class="timer timer-txt" id="my{$val.id}">Closed</div>
                    <div id="myBid{$val.id}"><a href="/product/view/{$val.id}" class="btn btn-brown">Bid Now</a></div> 
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