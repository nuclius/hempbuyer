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
        <div class="media-body">
            <div class="row">
                <div class="col-md-8">
                    <h3 class="pro-title">
                        <a href="{$config.url}/product/view/{$val.id}" class="product_title_a">{$val.title}</a>
                        <a href="javascript:void(0)" onclick="duplicatePost({$val.id})" data-toggle="tooltip" title="Duplicate this product" class="float-right product_duplicate_a"><i class="fa fa-clone"></i> Duplicate</a>
                        {if $val.totalBid==0 && $val.totalSold==0}
                            <a href="{$config.url}/product/{$val.id}" data-toggle="tooltip" title="Edit this product" class="float-right mr-3 product_edit_a"><i class="fa fa-edit"></i> Edit</a>
                        {/if}
                    </h3>
                    <div class="row">
                        <div class="col-sm-6 pro-con">
                            <img src="/images/return.png" /> 
                            {if $val.type == 'auction'}
                                Start Price : ${$val.start_price}
                            {elseif $val.type == 'offer'}
                                Offer Price : ${$val.offer_price}
                            {else /}
                                Fixed Price : ${$val.fixed_price}
                            {/if}
                        </div>
                        {if $val.type != "offer"}
                            <div class="col-sm-6 pro-con">
                                <img src="/images/pauction.png" /> Sold : {$val.totalSold}
                            </div>
                        {/if}
                        {if $val.type == "offer"}
                            <div class="col-sm-6 pro-con">
                                <img src="/images/total-quantity.png" /> Offer Quantity : {$val.offer_qty} {if $val.unit_of_measurement!='' and $val.unit_of_measurement!='0'} {$val.unit_of_measurement} {/if}
                            </div>
                        {/if}
                        <div class="col-sm-6 pro-con">
                            <img src="/images/total-quantity.png" /> Total Quantity : {$val.lots_available} {if $val.unit_of_measurement!='' and $val.unit_of_measurement!='0'} {$val.unit_of_measurement} {/if}
                        </div>
                        {if $val.type != "offer"}
                            <div class="col-sm-6 pro-con">
                                <span class="bid-txt">BID</span> Total Bid : {$val.totalBid}
                            </div>
                        {/if}
                        {if $val.type == 'auction'}
                            <div class="col-sm-6 pro-con">
                                <img src="/images/return.png" /> Reserve Price : ${$val.reserve_price}
                            </div>
                            <div class="col-sm-6 pro-con">
                                <img src="/images/pauction.png" /> Current Bid : ${if !$val.win_price}0{else /}{$val.win_price}{/if}
                            </div>
                        {/if}
                    </div>
                </div>
                <div class="col-md-4 text-center">
                    <img src="/images/chronometer.png" class="m-auto cm-icon" />
                    <div class="time-left">Time Left</div>
                    <div class="timer timer-txt" id="my{$val.id}">Closed</div> 
                    {if $val.type == 'auction'}
                        <button class="btn btn-prev open-product-bid-history" type="button" data-id="{$val.id}">BID HISTORY</button>
                    {/if}
                    {* {if $val.type == "offer"} *}
                        <button class="btn btn-prev open-offered-messages" type="button" id="open-offered-messages_{$val.id}" data-id="{$val.id}" data-type="{$val.type}" style="position: relative;">{if $val.type == "offer"}Offered Messages{else /}Buyer Messages{/if} <span class="unread_count" id="unread_count_p__{$val.id}" style="{if !$val.unread_count}display: none;{/if}">{$val.unread_count}</span></button>
                    {* {/if} *}
                    
                    {if $val.type == 'auction' && $val.auction_active == 0}
                        {* <button class="btn btn-prev open-product-bid-history" type="button" data-toggle="modal" data-target="#relist-modal" onclick="document.getElementById('RelistForm').reset();
                        $('#RelistForm').parsley().reset();$('#relistProjectId').val({$val.id}); $('#modalRelistInput').attr('min',{$val.moq})">
                                RELIST PRODUCT
                            </button> *}
                        <a href="{$config.url}/product/{$val.id}/?action=relist" class="btn btn-prev open-product-bid-history">RELIST PRODUCT</a>
                    {/if}
                    
                    <button class="btn btn-prev open-product-bid-history" type="button" onclick="openChangeEndDate('{$val.id}', '{$val.end_date}', '{$val.start_date}')">Change End Date</button>
                </div>
                <div class="form-inline check-group" style="position: absolute; right: 0;">
                    <div class="cus-check form-group">
                        <input type="checkbox" id="share_check__{$val.id}" name="type" class="typeCheckbox share_check" value="auction" data-toggle="tooltip" title="Check to add share list">
                        <span class="checkmark"></span>
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

