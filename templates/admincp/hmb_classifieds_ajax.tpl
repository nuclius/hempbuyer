
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th width="30">No.</th>
                <th>Created By</th>
                <th>Name</th>
                <th>Title</th>
                <th>Category</th>
                <th>Company Email</th>
                {* <th>Is Special</th> *}
                <th>Status</th>
                <th>Created Date</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            {$usercount = 0}
            {foreach $listData as $key => $val}
            {$usercount = 1}
            <tr>
                <td>{(10 * ($page - 1)) + ($key + 1)}</td>
                <td>{$val.created_by}</td>
                <td>{$val.name}</td>
                <td>{$val.title}</td>
                <td>{if $val.category}{$val.category}{else /}-{/if}</td>
                <td>{$val.email}</td>
                {* <td>{if $val.is_special}Yes{else/}No{/if}</td> *}
                <td style="text-transform: capitalize;">
                    {if $val.status == 'reject'}
                        Rejected
                    {else/}
                        {$val.status}
                    {/if}
                </td>
                <td>{$val.created_date}</td>
                <td>
                    {if $val.status == 'unapproved'}
                    <a style="width:100px!important" class="btn btn-success" id="add_approve_{$val.id}" href="javascript:void(0)" onclick="changeStatus('{$val.id}', 'active')" style="{if $val.status!='unapproved'}display:none;{/if}" title="Pause Ad">Approve</a>
                    <a style="width:100px!important;margin-top:5px" class="btn btn-danger" id="add_reject_{$val.id}" href="javascript:void(0)" onclick="changeStatus('{$val.id}', 'reject')" style="{if $val.status!='unapproved'}display:none;{/if}" title="Pause Ad">Reject</a>
                    {else/}
                    -
                    {/if}

                    <!-- <a id="add_pause_{$val.id}" href="javascript:void(0)" onclick="changeStatus('{$val.id}', 'pause')" style="{if $val.status!='active'}display:none;{/if}" title="Pause Ad"><i class="far fa-pause-circle"></i></a>
                    <a id="add_play_{$val.id}" href="javascript:void(0)" onclick="changeStatus('{$val.id}', 'active')" style="{if $val.status!='pause'}display:none;{/if}"><i class="far fa-play-circle" title="Start Ad"></i></a>
                    <a href="javascript:void(0)" onclick="changeStatus('{$val.id}', 'remove')"><i class="far fa-times-circle" title="Remove Ad"></i></a> -->
                </td>
            </tr>
            {/foreach}
            {if $usercount == 0}
            <tr>
                <td colspan="12">
                    No Classifieds Found !
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
    paginationData.url = '/admincp/classifieds/all';
    paginationData.url = '/admincp/classifieds/all';
    paginationData.html_div = "list_div";
    paginationData.form_name = "classifieds_form";

});
</script>