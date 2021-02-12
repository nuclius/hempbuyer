<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <!--             <th>{$phrases.transaction_id}</th> -->
                <th>Select</th>
                <th>Transaction Id</th>
                <th>Buyer Username</th>
                <th>Seller Username</th>
                <th>Product Name</th>
                <th># of Recurring Transactions</th>
                <th>Price</th>
                <th>Remaining Transactions</th>
                <th>Cancelation Insurance Reserve </th>
                <th>Cancellation Requests </th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            {if $recurrings.length > 0}
                {foreach $recurrings as $key => $val}
                <tr>
                    <td><input type="checkbox" name="checkUser" id="checkuser_{$val.id}" onchange="selectUsers({$val.id})"></td>
                    <td>{$val.id}</td>
                    <td>{$val.username}</td>
                    <td>{$val.seller_username}</td>
                    <td>{$val.title}</td>
                    <td>{$val.count}</td>
                    <td>{$val.amount}</td>
                    <td>{$val.remaining}</td>
                    <td>{$val.reserve_price}</td>
                    <td>
                        {if $val.aapprove_status == 0 && $val.sapprove_status == 1}
                        <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button" onclick="cancellation({$val.id})">Cancel</button>
                        {/if}
                    </td>
                    <td>
                        {if $val.aapprove_status == 0}
                            {if $val.status == 'approve'} active {/if}
                            {if $val.status == 'unverified'} Unverified {/if}
                            {if $val.status == 'reject'} Rejected {/if}
                        {/if}
                        {if $val.aapprove_status == 1} Cancelled {/if}
                    </td>
                    <!-- <td>Recurring requested date</td> -->
                </tr>
                {/foreach}
            {/if}
            {if $recurrings.length <=0} <tr>
                <td colspan="9">
                    <b>No Recurrings Found !!!</b>
                </td>
                </tr>
            {/if}
        </tbody>
    </table>
    {$pagination_html}
</div>
