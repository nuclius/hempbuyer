
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th width="30">No.</th>
                <th>Title</th>
                <th>Type</th>
                <th style="width: 155px;">Category</th>
                <th style="width: 100px;">Start Date</th>
                <th style="width: 100px;">End date</th>
                {if $action=="featured"}
                    <th style="width: 130px;">Listing start date</th>
                    <th style="width: 130px;">Listing end date</th>
                {/if}
                <th style="width: 60px;">Status</th>
                {if $action=="all" || $action=="featured"}
                    <th style="width: 60px;">Featured</th>
                {/if}

                {if $action=="upcoming"}
                {else/}
                    <th width="100">Action</th>
                {/if}
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
                    <td>{$val.openDate}</td>
                    <td>{$val.closedDate}</td>
                    {if $action=="featured"}
                        <td>{if $val.f_start_date}{$val.f_start_date}{else /}-{/if}</td>
                        <td>{if $val.f_end_date}{$val.f_end_date}{else /}-{/if}</td>
                    {/if}
                    <td style="text-transform: capitalize;">{$val.market_status}</td>
                    <!-- <td>
                        <div class="form-group">
                            <select data-id="{$val.id}" data-status="{$val.market_status}" class="form-control change_product_status" id="status" name="status">
                                <option value="open" {if $val.market_status=='open'}selected{/if}>Open</option>
                                <option value="closed" {if $val.market_status=='closed'}selected{/if}>Closed</option>
                                <option value="sold" {if $val.market_status=='sold'}selected{/if}>Sold</option>
                                <option value="draft" {if $val.market_status=='draft'}selected{/if}>Draft</option>
                            </select>
                        </div>
                    </td> -->
                    {if $action=="all" || $action=="featured"}
                        <td>
                            {if $val.market_status != 'closed'}
                            <input type="checkbox" class="is_featured" id="is_featured__{$val.id}" data-toggle="toggle" data-on="Featured" data-off="Featured" {if $val.is_featured}checked{/if} data-enddate="{$val.end_date}">
                            {else/}
                            -
                            {/if}
                        </td>
                    {/if}
                    
                    {if $action=="upcoming"}
                    
                    {else/}
                        <td>
                            <a title='View / Edit' href="{$config.url}/admincp/product/{$val.id}">Edit</a> / 
                            <a title='Purchased History' href="{$config.url}/admincp/product/purchase/history/{$val.id}">Purchased History</a> /
                            <a title='Bid History' href="{$config.url}/admincp/product/bidding/history/{$val.id}">Bid History</a>
                        </td>
                    {/if}
                </tr>
            {/foreach}
            {if $productcount == 0}
            <tr>
                <td colspan="12">
                    No {$productstatus} Products Found !
                </td>
            </tr>
            {/if}
        </tbody>
    </table>
</div>
<div id="pagination_html" data-total-record="{$totalData}"></div>
<script>
var action = '{$action}';
$(document).ready(function() {
    paginationData.totalRecord = '{$totalData}';
    paginationData.url = '/admincp/products/'+action;
    paginationData.html_div = "list_div";
    paginationData.form_name = "product_search_form";
});
</script>