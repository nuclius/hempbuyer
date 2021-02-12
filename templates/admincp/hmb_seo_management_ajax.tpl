<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th width="30">No.</th>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Meta Title</th>
                <th>Meta Key</th>
                <th>Meta Description</th>
                <th width="100">Action</th>
            </tr>
        </thead>
        <tbody>
            {$usercount = 0}
            {foreach $listData as $key => $val}
            {$usercount = 1}
            <tr>
                <td>{(10 * ($page - 1)) + ($key + 1)}</td>
                <td><a href="{$config.url}/product/view/{$val.product_id}" target="_blank">{$val.product_id}</a></td>
                <td>{$val.product_title}</td>
                <td>
                    <input type="text" id="meta_title__{$val.id}" value="{$val.meta_title}">
                </td>
                <td>
                    <input type="text" id="meta_key__{$val.id}" value="{$val.meta_key}">
                </td>
                <td>
                    <textarea type="text" id="meta_description__{$val.id}">{$val.meta_description}</textarea>
                </td>
                <td>
                    <button type="button" name="release" id="release" class="btn btn-primary mt-2px" onclick="update_medata('{$val.id}')">Save</button>
                </td>
            </tr>
            {/foreach}
            {if $usercount == 0}
            <tr>
                <td colspan="12">
                    No Meta found!
                </td>
            </tr>
            {/if}
        </tbody>
    </table> 
</div>
<div id="pagination_html" data-total-record="{$totalData}"></div>
<script>
    paginationData.totalRecord = '{$totalData}';
    paginationData.url = '/admincp/seo_management';
    paginationData.html_div = "list_div";
    paginationData.form_name = "search_form";
</script>