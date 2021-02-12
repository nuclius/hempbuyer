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
                <div class="col-md-10">
                    <h3 class="pro-title">
                        <a href="{$config.url}/product/view/{$val.id}" class="float-left">{$val.title}</a>
                        {if $val.status != 'paid'}
                            {if $val.shipping_id==0}
                                <a id="setshipping_{$val.id}" class="btn btn-info setshipping_btn float-right" href="/set_shipping_info?id={$val.id}&buynow_id={$val.buynow_id}">SET SHIPPING ADDRESS</a>
                            {elseif $val.shipping_amount_added==1 && $val.buynow_total_amount > 2500}
                                
                            {elseif $val.shipping_amount_added==1}
                                <a id="paynow_{$val.id}" class="btn btn-info paynow_btn float-right" href="javascript:void(0)" onclick="openTermPopup('{$val.id}','{$val.buynow_id}')">PAY NOW</a>
                            {/if}
                        {/if}
                    </h3>
                    <div class="row">
                        <div class="row ps-row">
                            <div class="col-sm-6 pro-con">
                                <img src="/images/return.png" /> Product Price : ${numberWithCommas($val.amount)}
                            </div>
                            <div class="col-sm-6 pro-con">
                                <img src="/images/pauction.png" /> Won Date : {$val.wonDate}
                            </div>
                            <div class="col-sm-6 pro-con">
                                <img src="/images/total-quantity.png" /> Total Quantity : {$val.lots_available} {if $val.unit_of_measurement!='' and $val.unit_of_measurement!='0'} {$val.unit_of_measurement} {/if}
                            </div>
                            <div class="col-sm-6 pro-con">
                                <img src="/images/plus.png" /> Status : 
                                {* {if $val.paid == '1'}
                                    <span class="text-success">Paid</span>
                                {elseif $val.shipping_amount_added == 0 && $val.shipping_id > 0}
                                    <span class="text-warning">Waiting for shipping amount</span>
                                {elseif $val.shipping_amount_added == 1 && $val.buynow_total_amount > 2500 && $val.user_type==''}
                                    <span class="text-warning">Waiting for Escrow Details</span>
                                {elseif $val.shipping_amount_added == 1 && $val.buynow_total_amount > 2500 && $val.user_type!=''}
                                    <span class="text-warning">ADD TRANSACTION ID</span>
                                {else /}
                                    <span class="text-danger">Not Paid</span>
                                {/if} *}
                                {if $val.status == 'waiting_for_shipping_address'}
                                    <span class="text-warning">Set Shipping Address</span>
                                {elseif $val.status == 'waiting_for_shipping_amount'}
                                    <span class="text-warning">Waiting for Shipping Amount</span>
                                {elseif $val.status == 'waiting_for_escrow_details'}
                                    <span class="text-warning">Waiting for Escrow Details</span>
                                {elseif $val.status == 'waiting_for_escrow_payment'}
                                    <span class="text-warning">Set Escrow Transaction Id</span>
                                {elseif $val.status == 'waiting_for_seller_confirmation'}
                                    <span class="text-warning">Waiting for Seller Confirmation</span>
                                {elseif $val.status == 'not_paid'}
                                    <span class="text-danger">Not Paid</span>
                                {elseif $val.status == 'paid'}
                                    <span class="text-success">Paid</span>
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="auction-won">
                    <div class="pp-txt">
                        AUCTION WON
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