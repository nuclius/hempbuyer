
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th width="30">No.</th>
                <th>Title</th>
                <th>Type</th>
                <th>Category</th>
                <th>Purchased User</th>
                <th>Purchased Qty</th>
                <th>Purchased Amount</th>
                <th>Purchased On</th>
                <th>Purchased Type</th>
                <th>Purchased Status</th>
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
                    <td>{$val.buyQty} {$val.unit_of_measurement}</td>
                    <td>${$val.paidAmount}</td>
                    <td>{$val.purchasedDate}</td>
                    <td style="text-transform: capitalize;">{$val.paidType}</td>
                    <td>{if $val.paidStatus==0}Not Paid{else/}Paid{/if}</td>
                </tr>
            {/foreach}
            {if $productcount == 0}
            <tr>
                <td colspan="12">
                    No Purchased History Found !
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
    paginationData.url = '/admincp/productPurchaseHistory';
    paginationData.html_div = "list_div";
    paginationData.form_name = "product_purchase_search_form";
});
</script>