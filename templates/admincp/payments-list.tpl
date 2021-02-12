<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>{$phrases.name}</th>
                <th>{$phrases.email}</th>
                <th>{$phrases.balance}</th>
                <th>Enter Balance</th>
                <!-- <th>{$phrases.action}</th> -->
            </tr>
        </thead>
        <tbody>
            {$usercount = 0} {foreach $users as $key => $val} {$usercount = 1}
            <tr>
                <td>{$val.first_name} {$val.last_name}</td>
                <td>{$val.email}</td>
                <td>$<span  id="bal_{$val.id}">{$val.balance}</span></td>
                <td>
                    <div class="form-group baln-inpt">
                        <input type="text" name="inc_bal{$val.id}" id="inc_bal{$val.id}" />
                        <button class="btn btn-success" id="inc_bal_btn" onclick="updateBalance({$val.id})">Change Balance</button>
                    </div>
                </td>
<!--                 <td>
                    <a title='View' href="{$config.url}/admincp/users/view/{$val.id}"></a> &nbsp;
                    <a title='Edit' href="{$config.url}/admincp/users/edit/{$val.id}"></a> &nbsp; {if $val.status == 'active'}
                    <a onclick=tempLogin('{$val.email}',{$val.id}) style="cursor: pointer;">Switch User</a> {/if}
                </td> -->
            </tr>
            {/foreach} {if $usercount == 0}
            <tr>
                <td colspan="5">
                    No {$userstatus} Users found !
                </td>
            </tr>
            {/if}
        </tbody>
    </table>
    {$pagination_html}
</div>
<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Enter the message <small></small></h4>
            </div>
            <div class="modal-body">
                <textarea id="reject-message" name="rejectMessage" class="reject-message" style="width:100%"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="submitreject">Submit</button> 
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>