<div class="table-responsive">
    <table class="table table-bordered1 table-hover">
        <thead>
            <tr>
                <th width="30">No.</th>
                <th>Account Name</th>
                <th>Account Number</th>
                <th>Routing Number</th>
                <th>Status</th>
                <th>Created Date</th>
                <th width="200">ACTION</th>
            </tr>
        </thead>
        <tbody>
            {$usercount = 0}
            {foreach $list_data as $key => $val}
            {$usercount = 1}
            <tr>
                <td>{(10 * ($page - 1)) + ($key + 1)}</td>
                <!-- <td>
                    <input type="checkbox" name="checkUser" id="checkuser_{$val.id}" onchange="selectUsers({$val.id})">
                </td> -->
                <td>{$val.account_name}</td>
                <td>{$val.account_number}</td>
                <td>{$val.routing_number}</td>
                <td style="text-transform: capitalize;">{$val.status}</td>
                <td>{$val.created_date}</td>
                <td>
                    {if $val.is_primary == 0}
                        <button class="btn btn-danger min-width-auto float-right ml-3" onclick="delete_bank({$val.id})">Delete</button>
                        <a class="btn btn-prev min-width-auto float-right ml-3" href="/bank/{$val.id}">Edit</a>
                        <button class="btn btn-prev min-width-auto float-right" onclick="set_primary_bank({$val.id})">Set Primary</button>
                    {else /}
                        <span class="text-success"><i class="fa fa-check"></i> Primary</span>
                    {/if}
                </td>
            </tr>
            {/foreach}
            {if $usercount == 0}
            <tr>
                <td colspan="7">
                    No Bank Found !
                </td>
            </tr>
            {/if}
        </tbody>
    </table>
</div>
<div id="pagination_html" data-total-record="{$totalData}"></div>
<script>
    var action = '';
    paginationData.totalRecord = +'{$totalData}';
    paginationData.url = '/bank_list/' + action;
    paginationData.html_div = "list_div";
    paginationData.form_name = "list_form";
    $(document).ready(function () {
    });
</script>