
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th width="30">No.</th>
                <th>Created By</th>
                <th>Ad Name</th>
                <th>Ad Title</th>
                <th>Targeting Sections</th>
                <th>Budget Per Click</th>
                <th>Budget Per Day</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            {$usercount = 0}
            {foreach $listData as $key => $val}
            {$usercount = 1}
            <tr>
                <td>{(10 * ($page - 1)) + ($key + 1)}</td>
                <td>{$val.name}</td>
                <td>{$val.ad_name}</td>
                <td>{$val.ad_title}</td>
                <td>{$val.target_sec_id}</td>
                <td>{$val.budget_per_click}</td>
                <td>{$val.budget_per_day}</td>
                <td style="text-transform: capitalize;">
                    {if $val.status == 'reject'}
                        Rejected
                    {else/}
                        {$val.status}
                    {/if}
                </td>
                <td>
                    <div style="display: flex;">
                        <a class="btn btn-success" id="add_approve_{$val.id}" href="javascript:void(0)" onclick="changeStatus('{$val.id}', 'active')" style="{if $val.status!='unapproved'}display:none;{/if}height: 38px;" title="Approve Ad">Approve</a> &nbsp;
                        <a class="btn btn-danger" id="add_reject_{$val.id}" href="javascript:void(0)" onclick="changeStatus('{$val.id}', 'reject')" style="{if $val.status!='unapproved'}display:none;{/if}height: 38px;" title="Reject Ad">Reject</a> &nbsp;

                        <a id="add_pause_{$val.id}" href="javascript:void(0)" onclick="changeStatus('{$val.id}', 'pause')" style="{if $val.status!='active'}display:none;{/if}" title="Pause Ad"><i class="far fa-pause-circle"></i></a> &nbsp;
                        <a id="add_play_{$val.id}" href="javascript:void(0)" onclick="changeStatus('{$val.id}', 'active')" style="{if $val.status!='pause'}display:none;{/if}"><i class="far fa-play-circle" title="Start Ad"></i></a> &nbsp;
                        <a href="javascript:void(0)" onclick="changeStatus('{$val.id}', 'remove')"><i class="far fa-times-circle" title="Remove Ad"></i></a> &nbsp;
                    </div>
                </td>
            </tr>
            {/foreach}
            {if $usercount == 0}
            <tr>
                <td colspan="12">
                    No Ads Found !
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
    paginationData.url = '/admincp/ads/all';
    paginationData.url = '/admincp/ads/all';
    paginationData.html_div = "list_div";
    paginationData.form_name = "ads_form";

});
</script>