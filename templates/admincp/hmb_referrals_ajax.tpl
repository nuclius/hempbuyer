
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th width="30">No.</th>
                <th width="40">Buyer Name</th>
                <th>Buyer Email</th>
                <th>Buyer Join Date</th>
                <th>Referral Name</th>
                <th>Referral Email</th>
                <th>Referral Join Date</th>
            </tr>
        </thead>
        <tbody>
            {$usercount = 0}
            {foreach $users as $key => $val}
            {$usercount = 1}
            <tr>
                <td>{(10 * ($page - 1)) + ($key + 1)}</td>
                <td>{$val.name}</td>
                <td>{$val.email}</td>
                <td>{$val.join_date}</td>
                <td>{$val.ref_name}</td>
                <td>{$val.ref_email}</td>
                <td>{$val.ref_join_date}</td>
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
    paginationData.url = '/admincp/referrals/all';
    paginationData.url = '/admincp/referrals/all';
    paginationData.html_div = "list_div";
    paginationData.form_name = "user_search_form";

});
</script>