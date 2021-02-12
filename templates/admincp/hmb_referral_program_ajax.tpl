
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th width="30">No.</th>
                <th>Full Name</th>
                <th>Company Name</th>
                <th>Email</th>
                <th>Code</th>
                <th width="250">Address</th>
                {* <th>Status</th> *}
                <th>Total Referred</th>
                <th>Code Created Date</th>
            </tr>
        </thead>
        <tbody>
            {$usercount = 0}
            {foreach $listData as $key => $val}
            {$usercount = 1}
            <tr>
                <td>{(10 * ($page - 1)) + ($key + 1)}</td>
                <td>{$val.name}</td>
                <td>{$val.company}</td>
                <td>{$val.email}</td>
                <td>{$val.code}</td>
                <td>
                    {if $val.phone}Tel:{$val.phone}{/if} 
                    {if $val.address},{$val.address}{/if} 
                    {if $val.city},{$val.city}{/if} 
                    {if $val.state},{$val.state}{/if} - {$val.zipcode}
                </td>
                <td>{if $val.total_referred}{$val.total_referred}{else /}-{/if}</td>
                {* <td style="text-transform: capitalize;">
                    {$val.status}
                </td> *}
                <td>{$val.created_date}</td>
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
    
$(document).ready(function(){
    paginationData.totalRecord = '{$totalData}';
    paginationData.url = '/admincp/referral_program';
    paginationData.url = '/admincp/referral_program';
    paginationData.html_div = "list_div";
    paginationData.form_name = "referral_program_form";

});
</script>