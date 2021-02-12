
<div class="table-responsive">
    <table class="table table-bordered1 table-hover">
        <thead>
            <tr>
                <th width="30">No.</th>
                <!-- <th width="30"></th> -->
                <th>AD NAME</th>
                <th>STATUS</th>
                <th>UPDATED</th>
                <th>BUDGET/DAY</th>
                <th>CLICKS/DAY</th>
                <th>IMPRESSION</th>
                <th>ACTION</th>
            </tr>
        </thead>
        <tbody>
            {$usercount = 0}
            {foreach $adsData as $key => $val}
            {$usercount = 1}
            <tr>
                <td>{(10 * ($page - 1)) + ($key + 1)}</td>
                <!-- <td>
                    <input type="checkbox" name="checkUser" id="checkuser_{$val.id}" onchange="selectUsers({$val.id})">
                </td> -->
                <td>
                    {$val.ad_name}
                </td>
                <td style="text-transform: capitalize;">{$val.status}</td>
                <td>{$val.created_at}</td>
                <td class="text-center">${$val.budget_per_day}</td>
                <td class="text-center">${$val.budget_per_click}</td>
                <td class="text-center">{$val.no_of_clicks}</td>
                <td class="">
                    {if $val.status!='unapproved'}
                        {* <a id="add_pause_{$val.id}" href="javascript:void(0)" onclick="changeStatus('{$val.id}', 'pause')" style="{if $val.status!='active'}display:none;{/if}" title="Pause your Ad"><i class="far fa-pause-circle"></i></a>
                        <a id="add_play_{$val.id}" href="javascript:void(0)" onclick="changeStatus('{$val.id}', 'active')" style="{if $val.status=='active'}display:none;{/if}"><i class="far fa-play-circle" title="Start your Ad"></i></a> *}
                        <a href="javascript:void(0)" onclick="changeStatus('{$val.id}', 'remove')"><i class="far fa-times-circle text-green" title="Remove your Ad"></i></a>
                    {else/}
                    {/if}
                    <a href="javascript:void(0)" onclick="viewDetail('{$val.id}')"><i class="far fa-eye text-green" title="View your Ad details"></i></a>
                </td>
            </tr>
            {/foreach}
            {if $usercount == 0}
            <tr>
                <td colspan="7">
                    No Ads Found !
                </td>
            </tr>
            {/if}
        </tbody>
    </table>
</div>
<div id="pagination_html" data-total-record="{$totalData}"></div>
<script>
    $("#total_amount").html('{$total_amount}');
paginationData.totalRecord = '{$totalData}';
paginationData.url = '/advertisements_list';
paginationData.html_div = "ads_list";
paginationData.form_name = "ads_form";
/* $(document).ready(function(){

}); */
</script>