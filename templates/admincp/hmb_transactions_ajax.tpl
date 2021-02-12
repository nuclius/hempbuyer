<input type="hidden" id="net_revenue_data" value="{$net_revenue}">
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th width="30">No.</th>
                <th>InvoiceId</th>
                <th>Transaction ID</th>
                <th>User</th>
                <th>Seller User</th>
                <th>Product Title</th>
                <th>Shipping Charge</th>
                <th>Transaction Fee</th>
                <th>Status</th>
                <th>Amount</th>
                <th>Gateway</th>
                <th style="min-width: 130px;">Date Added</th>
                <th>Transaction Contract</th>
                {* <th width="127" style="display: flex;">Action</th> *}
            </tr>
        </thead>
        <tbody>
            {$usercount = 0}
            {foreach $listData as $key => $val}
            {$usercount = 1}
            <tr>
                <td>{(7 * ($page - 1)) + ($key + 1)}</td>
                <td><a href="{$config.url}/invoice/{$val.id}" target="_blank">{$val.id}</a></td>
                <td>{if $val.transactionid}{$val.transactionid}{else /}-{/if}</td>
                <td>{$val.buyer_email}</td>
                <td>{$val.seller_email}</td>
                <td><a href="{$config.url}/product/view/{$val.product_id}" target="_blank">{$val.product_title}</a></td>
                <td>${numberWithCommas($val.shipping_amount)}</td>
                <td>${numberWithCommas($val.transaction_fee)}</td>
                <td class="text-capitalize">{$val.istatus}</td>
                <td style="text-align: right;">${numberWithCommas($val.amount)}</td>
                <td>{$val.gateway}</td>
                <td>{$val.date_added}</td>
                <td>
                    <input type="file" name="transaction_contract" id="transaction_contract__{$val.id}" style="width: 98px !important;">
                    {if $val.transaction_contract}<a target="_blank" href="{$config.url}/uploads/{$val.transaction_contract}">{$val.transaction_contract}</a>{/if}
                </td>
                {* <td>
                    {if $val.gateway != 'escrow'}
                        {if $val.release_status == 'pending'}
                            {if $val.is_primary}
                                <button type="button" name="release" id="release" class="btn btn-primary mt-2px" onclick="release_payment('{$val.id}', {$val.release_amount})">Release</button>
                                <button type="button" name="reject" id="reject" class="btn btn-danger mt-2px" onclick="reject_payment('{$val.id}')">Reject</button>
                            {else /}
                                <button type="button" name="reject" id="reject" class="btn btn-danger mt-2px" onclick="send_mail_to_seller_for_add_bank('{$val.seller_user_id}')" title="Send mail to seller know them to add their bank details">Send Mail</button>
                            {/if}
                        {else /}
                            <span>{$val.release_status}</span>
                        {/if}
                    {/if}
                </td> *}
            </tr>
            {/foreach}
            {if $usercount == 0}
            <tr>
                <td colspan="12">
                    No Referral users found!
                </td>
            </tr>
            {/if}
        </tbody>
    </table> 
</div>
<div id="pagination_html" data-total-record="{$totalData}"></div>
<script>
    
paginationData.totalRecord = '{$totalData}';
paginationData.url = '/admincp/transactions';
paginationData.html_div = "list_div";
paginationData.form_name = "search_form";
$(document).ready(function(){

});
</script>