
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th width="30">No.</th>
                <th>Username</th>
                <th>User Type</th>
                <th>Email Address</th>
                <th>License Expiration Date</th>
                <th>User Registration Date</th>
                <th>Referred From</th>
                <th width="100">Status</th>
                <th width="100">Action</th>
            </tr>
        </thead>
        <tbody>
            {$usercount = 0}
            {foreach $users as $key => $val}
            {$usercount = 1}
            <tr>
                <td>{(10 * ($page - 1)) + ($key + 1)}</td>
                <td>{$val.username}</td>
                <td>
                    {if $val.role == 1}
                        Buyer
                    {elseif $val.role == 2}
                        Seller
                    {else/}
                        Other
                    {/if}
                </td>
                <td>
                    <a class="w100 contact_modal" class="btn-link" data-toggle="modal" data-id="{$val.id}"
                        data-email="{$val.email}" data-target="#wireContact">{$val.email}</a>
                </td>
                <td>{$val.expiration_date}</td>
                <td>{$val.created_at}</td>
                <td>
                    {if $val.refered_by == 2}
                        Hempbuyer Referral
                    {elseif $val.refered_by == 4}
                        Referral Affiliate
                    {else /}
                        Normal
                    {/if}
                </td>
                <td>
                    <div class="form-group">
                        <select data-id="{$val.id}" data-status="{$val.status}" class="form-control change_user_status" id="status" name="status">
                            <option value="pending" {if $val.status=='pending'}selected{/if}>Pending </option>
                            <option value="active" {if $val.status=='active'}selected{/if}>Active</option>
                            <option value="inactive" {if $val.status=='inactive'}selected{/if}>Inactive</option>
                            <!-- <option value="suspend" {if $val.status=='suspend'}selected{/if}>Suspend</option> -->
                        </select>
                    </div>
                </td>
                <td>
                    <a title='View' href="{$config.url}/admincp/user/{$val.id}">View</a>
                </td>
            </tr>
            {/foreach}
            {if $usercount == 0}
            <tr>
                <td colspan="12">
                    No {$userstatus} Users Found !
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
    paginationData.url = '/admincp/users/all';
    paginationData.url = '/admincp/users/all';
    paginationData.html_div = "list_div";
    paginationData.form_name = "user_search_form";

});
</script>