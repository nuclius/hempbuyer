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
            <div class="row" style="padding-right: 30px">
                <div class="col-md-8">
                    <h3 class="pro-title mb-0">
                        <a href="{$config.url}/product/view/{$val.product_id}">{$val.title}</a>
                    </h3>
                    <div class="row ps-row">
                        {if $val.status == 'paid'}
                            <div class="col-sm-6 pro-con">
                                <img src="/images/return.png" /> Paid Amount : ${numberWithCommas($val.total_amount)}
                            </div>
                            <div class="col-sm-6 pro-con">
                                <img src="/images/pauction.png" /> Paid Date : {$val.paid_date}
                            </div>
                            <div class="col-sm-6 pro-con">
                                <img src="/images/total-quantity.png" /> Total Quantity : {$val.qty} {if $val.unit_of_measurement!='' and $val.unit_of_measurement!='0'} {$val.unit_of_measurement} {/if}
                            </div>
                        {else /}
                            <div class="col-sm-6 pro-con">
                                <img src="/images/return.png" /> Product Price : ${numberWithCommas($val.amount)}
                            </div>
                            <div class="col-sm-6 pro-con">
                                <img src="/images/pauction.png" /> {if $list_type == 'Auction'}Won Date{else /}Buy Date{/if} : {$val.buyDate}
                            </div>
                            <div class="col-sm-6 pro-con">
                                <img src="/images/total-quantity.png" /> Total Quantity : {$val.qty} {if $val.unit_of_measurement!='' and $val.unit_of_measurement!='0'} {$val.unit_of_measurement} {/if}
                            </div>
                        {/if}
                        <div class="col-sm-12 pro-con">
                            <img src="/images/plus.png" /> Status : 
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
                <div class="col-md-3 text-center"> 
                    <div class="ps-action pp-bts">
                        {if $val.totalBid != '0'}
                        <button class="btn btn-prev" type="button">
                            YOU WON
                        </button>
                        {/if}
                        
                        {if $val.status == 'waiting_for_shipping_address'}
                            <a id="setshipping_{$val.product_id}" class="btn btn-info setshipping_btn float-right" href="/set_shipping_info?id={$val.product_id}&invoice_id={$val.invoice_id}">SET SHIPPING ADDRESS</a>
                        {elseif $val.status == 'waiting_for_escrow_payment'}
                            <a id="paynow_{$val.product_id}" class="btn btn-info float-right" href="javascript:void(0)" onclick="openAddTransactionIdPopup('{$val.escrow_id}','{$val.invoice_id}')">ADD TRANSACTION ID</a>
                        {elseif $val.status == 'not_paid'}
                            <a id="paynow_{$val.product_id}" class="btn btn-info paynow_btn float-right" href="javascript:void(0)" onclick="openTermPopup('{$val.product_id}','{$val.invoice_id}')">PAY NOW</a>
                        {elseif $val.status == 'paid'}
                            <a class="btn btn-prev" href="/invoice/{$val.invoice_id}">REVIEW TRANSACTION DOC</a>
                        {/if}
                        {if $val.user_type!=''}
                            <a class="btn btn-info float-right" href="javascript:void(0)" onclick="openEscrowDetailsPopup('{$val.user_name}', '{$val.user_company}', '{$val.user_email}', '{$val.user_phone}', '{$val.bank_name}', '{$val.account_name}', '{$val.account_number}', '{$val.routing_number}')">AGENT CONTACT DETAILS</a>
                        {/if}


                        {if $val.feedback_sended==0}
                            <button id="feedbackbtn_{$val.invoice_id}" class="btn btn-prev" type="button" onclick="openFeedbackPopup({$val.product_id}, '{$val.invoice_id}', $(this))" data-toggle="modal" data-target="#send_feedback_popup">
                                LEAVE FEEDBACK
                            </button>
                        {/if}
                        {if $val.feedback_received}
                            <button class="btn btn-prev open-product-bid-history" data-toggle="modal" data-target="#view_feedback_popup" type="button" onclick="viewFeedback('{$val.feedback_id}')">VIEW FEEDBACK</button>
                        {/if}

                        {if $val.totalMessage==0}
                        <button class="btn btn-prev" type="button" onclick="openMessagePopup({$val.product_id}, {$val.seller_id}, '{$val.seller_email}','{$val.seller_name}', $(this))" data-toggle="modal" data-target="#send_message_popup">
                            CHAT WITH SELLER
                        </button>
                        {/if} 
                        
                    </div>
                </div>
                {if $list_type == 'Auction'}
                    <div class="auction-won">
                        <div class="pp-txt">
                            AUCTION WON
                        </div>
                    </div>
                {else /}
                    <div class="auction-won">
                        <div class="pp-txt">
                            BUY
                        </div>
                    </div>
                {/if}
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

