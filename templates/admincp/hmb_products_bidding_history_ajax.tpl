
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th width="30">No.</th>
                <th>Title</th>
                <th>Type</th>
                <th>Category</th>
                <th>Bid User</th>
                <th>Bid Amount</th>
                <th>Bid On</th>
                <th>Bid Awarded</th>
            </tr>
        </thead>
        <tbody>
            {$productcount = 0}
            {foreach $product as $key => $val}
                {$productcount = 1}
                <tr>
                    <td>{(10 * ($page - 1)) + ($key + 1)}</td>
                    <td>{$val.title}</td>
                    <td style="text-transform: capitalize;">{$val.type}</td>
                    <td>{$val.categoryName}</td>
                    <td>{$val.name}</td>
                    <td>${$val.proposed_amount}</td>
                    <td>{$val.bidDate}</td>
                    <td>{if $val.awarded=='0'} No {else/} Yes {/if}</td>
                </tr>
            {/foreach}
            {if $productcount == 0}
            <tr>
                <td colspan="12">
                    No Bidding History Found !
                </td>
            </tr>
            {/if}
        </tbody>
    </table>
</div>
<div id="pagination_html" data-total-record="{$totalData}"></div>
<script>
    
$(document).ready(function() {
    paginationData.totalRecord = '{$totalData}';
    paginationData.url = '/admincp/productBiddingHistory';
    paginationData.html_div = "list_div";
    paginationData.form_name = "product_bid_search_form";
});
</script>