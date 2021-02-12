{foreach $products as $key => $val}
    <div class="media mauc-media">
        <div class="media-left" style="width: 200px;">
            <!-- <img src="images/pro8.png" alt="" /> -->
            {if !$val.avatar}
                <img src="/no_image.png" alt="No Image Available" onerror="this.onerror=null;this.src='/no_image.png';" />
            {else/}
                <img src="/uploads/product/{$val.avatar}" alt="No Image Available" onerror="this.onerror=null;this.src='/no_image.png';" />
            {/if}
        </div>
        <div class="media-body ml-3">
            <div class="row">
                <div class="col-md-9">
                    <h3 class="pro-title">
                        <a href="{$config.url}/product/view/{$val.id}">{$val.title}</a>
                    </h3>
                    <div class="row ps-row">
                        <div class="col-sm-6 pro-con">
                            <img src="/images/return.png" /> Start Price : ${$val.start_price}
                        </div>
                        <div class="col-sm-6 pro-con">
                            <img src="/images/pauction.png" /> Lost Date : {$val.lostDate}
                        </div>
                        <div class="col-md-6 pro-con">
                            <img src="/images/total-quantity.png" /> Total Quantity : {$val.lots_available} {if $val.unit_of_measurement!='' and $val.unit_of_measurement!='0'} {$val.unit_of_measurement} {/if}
                        </div> 
                    </div>
                </div>
                <div class="pay-pending">
                    <div class="pp-txt">
                        AUCTION LOST
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