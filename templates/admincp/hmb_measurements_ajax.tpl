<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th width="30">No.</th>
                <th>Measurement Name</th>
                <th>Status</th> 
            </tr>
        </thead>
        <tbody>
            {$usercount = 0}
            {foreach $measurement as $key => $val}
            {$usercount = 1}
            <tr>
                <td>{(10 * ($page - 1)) + ($key + 1)}</td>
                <td>{$val.unit_name}</td>
                <td>
                    <div class="form-group">
                        <select data-id="{$val.id}" data-status="{$val.status}" class="form-control change_measurement_status" id="status" name="status">
                            <option value="Active" {if $val.status=='Active'}selected{/if}>Active</option>
                            <option value="Inactive" {if $val.status=='Inactive'}selected{/if}>Inactive</option>
                        </select>
                    </div>
                </td> 
            </tr>
            {/foreach}
            {if $usercount == 0}
            <tr>
                <td colspan="12">
                    No {$measurementstatus} Measurements Found !
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
    paginationData.url = '/admincp/measurements/all';
    paginationData.html_div = "list_div";
    paginationData.form_name = "measurement_search_form";
});
</script>