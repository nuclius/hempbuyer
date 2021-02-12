                        <!-- 'active','unsubscribe','moderate','unverified','deactivate' -->
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                {if $action == wire}
                <th>Fund receipt</th>
                {/if}
                <th>Name</th>
                <th>Email</th>
                <th>Available Balance</th>
                <th>Requested Funds</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            {if $pagination > 0}
                {foreach $fund_requests as $key => $val}
                <tr>
                    {if $action == wire}
                    <td>
                        <a href="{$config.imgpath}wirefund_receipt/{$val.wirefund_receipt}" onclick="window.open(this.href); return false;"> <img src="{if $val.wirefund_receipt == ''} {$config['url']}/images/no_imf.png {else if $val.wirefund_receipt != ''}{$config['imgpath']}wirefund_receipt/{$val.wirefund_receipt}{/if}" width="50" height="50" onError="this.src='{$config['url']}/images/no_imf.png"></a>
                    </td>
                    {/if}
                    <td>{$val.first_name} {$val.last_name}</td>
                    <td>{$val.email}</td>
                    <td id="bal_{$val.id}">$<span>{$val.balance}</span></td>
                    <td id="amt_{$val.id}">$<span>{$val.amount}</span></td>
                    <td>
                        {if $menu.refund == 'active'}
                        <div class="form-group">
                            <div class="form-group">
                                <select data-id="{$val.id}" class="form-control refstatus_{$val.id}" id="refstatus" name="refstatus"
                                {if $val.status=='approve'} disabled data-toggle="tooltip" title="Payment approved. Cannot change again." {/if}
                                {if $val.status!='approve'}style="cursor: pointer" {/if}>
                                    <option value="unverified" {if $val.status=='unverified'} selected {/if}>Unverified</option>
                                    <option value="approve" {if $val.status=='approve'} selected {/if}>Approve{if $val.status=='approve'}d{/if}</a>
                                    </option>
                                    <option value="reject" {if $val.status=='reject'} selected {/if}>Reject{if $val.status=='reject'}ed{/if}</option>
                                </select>
                            </div>
                        </div>
                        {/if}
                        {if $menu.refund != 'active'}
                        <div class="form-group">
                            <div class="form-group">
                                <select data-id="{$val.id}" class="form-control status_{$val.id}" id="status" name="status"
                                {if $val.status=='approve'} disabled data-toggle="tooltip" title="Payment approved. Cannot change again." {/if}
                                {if $val.status!='approve'}style="cursor: pointer" {/if}>
                                    <option value="unverified" {if $val.status=='unverified'} selected {/if}>Unverified</option>
                                    <option value="approve" {if $val.status=='approve'} selected {/if}>Approve{if $val.status=='approve'}d{/if}</a>
                                    </option>
                                    <option value="reject" {if $val.status=='reject'} selected {/if}>Reject{if $val.status=='reject'}ed{/if}</option>
                                </select>
                            </div>
                        </div>
                        {/if}

                    </td>
                    <td>

                        {if $val.status=='reject'}

                        <a style="cursor: pointer;" class="w100" class="btn-link" onclick="viewMessage('{$val.reject_msg}')"> View Message</a>
                        {/if}
                        <!-- &nbsp; -->

                        <a class="w100" class="btn-link" href="{$config.url}/admincp/payments/edit/{$val.id}">View/Edit</a>
                        <a class="w100 contact_modal" class="btn-link" data-toggle="modal" data-id="{$val.id}" data-email="{$val.email}" data-target="#wireContact">Contact</a>
                    </td>
                </tr>
                {/foreach}

            {/if}
            {if $pagination <= 0}
                <tr><td colspan="6" align="center"><h3>No Records found...</h3></td></tr>
            {/if}
            {if $usercount == 0}
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

</div>
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Enter the message <small></small></h4>
            </div>
            <div class="modal-body">
                <textarea placeholder="Please enter message" id="reject-message" name="rejectMessage" class="reject-message" style="width:100%"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="submitreject">Submit</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
