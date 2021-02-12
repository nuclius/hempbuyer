
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th width="30">No.</th>
                <th>Email</th>
                <th width="100">Existing User</th>
                <th width="200">Subscribe Date</th>
            </tr>
        </thead>
        <tbody>
            {$usercount = 0}
            {foreach $users as $key => $val}
            {$usercount = 1}
            <tr>
                <td>{(10 * ($page - 1)) + ($key + 1)}</td>
                <td>{$val.email}</td>
                <td>{if $val.existing_user}<i class="fa fa-check text-success"></i>{else/}<i class="fa fa-times text-danger"></i>{/if}</td>
                <td>{$val.created_at}</td>
            </tr>
            {/foreach}
            {if $usercount == 0}
            <tr>
                <td colspan="12">
                    No Subscription Users Found !
                </td>
            </tr>
            {/if}
        </tbody>
    </table> 
</div>
<div id="pagination_html" data-total-record="{$totalData}"></div>
<script>
    
$(document).ready(function(){
    paginationData.totalRecord = '{$totalData}';
    paginationData.url = '/admincp/subscription_users/all';
    paginationData.url = '/admincp/subscription_users/all';
    paginationData.html_div = "list_div";
    paginationData.form_name = "user_search_form";

});
</script>