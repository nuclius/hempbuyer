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
        <div class="media-body pdr-28">
            <div class="row">
                <div class="col-md-10">
                    <h3 class="pro-title clearfix">
                        <a href="{$config.url}/product/view/{$val.product_id}">{$val.title}</a>
                        {* {if $val.paidStatus == '0'}
                            {if $val.shipping_id > 0 && $val.shipping_amount_added == 0}
                                <a id="paynow_{$val.id}" href="javascript:void(0)" class="btn btn-info paynow_btn float-right" onclick="set_shipping_amount('{$val.bidId}', '{$val.shipping_id}')">Set Shipping Amount</a>
                            {elseif $val.shipping_id > 0 && $val.shipping_amount_added == 1 && $val.buynow_total_amount > 2500 && $val.user_type==''}
                                <a class="btn btn-info float-right" href="{$config.url}/escrow_details/{$val.bidId}">Add Escrow details</a>
                            {elseif $val.shipping_id > 0 && $val.shipping_amount_added == 1 && $val.buynow_total_amount > 2500 && $val.user_type!='' && $val.escrow_transaction_id!=''}
                                <a class="btn btn-info float-right" href="javascript:void(0)" onclick="confirm_payment('{$val.escrow_transaction_id}', '{$val.bidId}', '{$val.projectId}')">Confirm Payment</a>
                            {/if}
                        {/if} *}

                        {if $val.status == 'waiting_for_shipping_amount'}
                            <a id="paynow_{$val.invoice_id}" href="javascript:void(0)" class="btn btn-info paynow_btn float-right" onclick="set_shipping_amount('{$val.invoice_id}', '{$val.shipping_id}')">Set Shipping Amount</a>
                        {elseif $val.status == 'waiting_for_escrow_details'}
                            <a class="btn btn-info float-right" href="{$config.url}/escrow_details/{$val.invoice_id}">Add Escrow details</a>
                        {elseif $val.status == 'waiting_for_seller_confirmation'}
                            <a class="btn btn-info float-right" href="javascript:void(0)" onclick="confirm_payment('{$val.escrow_transaction_id}', '{$val.invoice_id}', '{$val.product_id}')">Confirm Payment</a>
                        {/if}
                    </h3>
                    <div class="row ps-row">
                        <div class="col-sm-8"> 
                            {if $val.status == 'paid'}
                                <div class="pro-con">
                                    <img src="/images/return.png" /> Paid Amount : ${numberWithCommas($val.total_amount)}
                                </div>
                                <div class="pro-con">
                                    <img src="/images/pauction.png" /> Paid Date : {$val.paid_date}
                                </div>
                            {else /}
                                <div class="pro-con">
                                    <img src="/images/return.png" /> Product Amount : ${numberWithCommas($val.amount)}
                                </div>
                            {/if}

                            <div class="pro-con">
                                <img src="/images/total-quantity.png" /> Total Quantity : {$val.qty} {if $val.unit_of_measurement!='' and $val.unit_of_measurement!='0'} {$val.unit_of_measurement} {/if}
                            </div>
                            {if $val.user_type!='' && $val.escrow_transaction_id!=''}
                                <div class="pro-con">
                                    <img src="/images/plus.png" /> Escrow Transaction ID: {$val.escrow_transaction_id}
                                </div>
                            {/if}
                            <div class="pro-con">
                                <img src="/images/plus.png" /> Status : 
                                {* {if $val.shipping_id < 1}
                                    <span class="text-warning">Waiting for shipping address</span>
                                {elseif $val.shipping_id > 0 &&  $val.shipping_amount_added == 0}
                                    <span class="text-warning">Update Shipping Amount</span>
                                {elseif $val.shipping_id > 0 &&  $val.shipping_amount_added == 1 && $val.paidStatus < 1}
                                    <span class="text-warning">Pending payment</span>
                                {elseif $val.paidStatus > 0}
                                    <span class="text-success">Paid</span>
                                {/if} *}
                                {if $val.status == 'waiting_for_shipping_address'}
                                    <span class="text-warning">Waiting for shipping address</span>
                                {elseif $val.status == 'waiting_for_shipping_amount'}
                                    <span class="text-warning">Set Shipping Amount</span>
                                {elseif $val.status == 'waiting_for_escrow_details'}
                                    <span class="text-warning">Add Escrow Details</span>
                                {elseif $val.status == 'waiting_for_escrow_payment'}
                                    <span class="text-warning">Waiting for Escrow Transaction Id</span>
                                {elseif $val.status == 'waiting_for_seller_confirmation'}
                                    <span class="text-warning">Update Payment Confirmation</span>
                                {elseif $val.status == 'not_paid'}
                                    <span class="text-danger">Pending payment</span>
                                {elseif $val.status == 'paid'}
                                    <span class="text-success">Paid</span>
                                {/if}
                            </div>
                        </div>
                        <div class="col-sm-4">
                            {if $val.feedback_received}
                                <button class="btn btn-prev open-product-bid-history" data-toggle="modal" data-target="#view_feedback_popup" type="button" onclick="viewFeedback('{$val.feedback_id}')">VIEW FEEDBACK</button>
                                
                                {if $val.feedback_sended==0}
                                    <button id="feedbackbtn_{$val.invoice_id}" class="btn btn-prev open-product-bid-history" data-toggle="modal" data-target="#send_feedback_popup" type="button" onclick="openFeedbackPopup({$val.product_id}, {$val.invoice_id}, $(this))">LEAVE FEEDBACK</button>
                                {/if}
                            {/if}
                        </div>
                    </div>
                </div>
                {if $val.status == 'paid'}
                    <div class="auction-won">
                        <div class="pp-txt">
                            PAYMENT SUCCESS
                        </div>
                    </div>
                {else /}
                    <div class="auction-lost">
                        <div class="pp-txt">
                            PAYMENT PENDING
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