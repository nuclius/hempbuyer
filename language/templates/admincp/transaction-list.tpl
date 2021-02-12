<div class="table-responsive">
<table class="table table-bordered table-hover">
    <thead>
        <tr>
            <th>{$pharse.invoiceid}</th>
            <th>{$pharse.transaction_id}</th>
            <th>{$pharse.user}</th>
            <th>{$pharse.product_title}</th>
            <th>{$pharse.type}</th>
            <th>{$pharse.status}</th>
            <th>{$pharse.amount}</th>
            <th>{$pharse.gateway}</th>
            <th>{$pharse.description}</th>
            <th>{$pharse.date_added}</th>
        </tr>
    </thead>
    <tbody>
    {$transactioncount = 0}
     {foreach $trans as $key => $val}	
     {$transactioncount = 1}
        <tr>
            <td>{$val.id}</td>
            <td>{$val.transactionid}</td>
            <td>{$val.email}</td>
            <td>{$val.title} ({$val.pid})</td>
            <td>{$val.type}</td>
            <td>{$val.istatus}</td>
            <td>${$val.amount}</td>
            <td>{$val.gateway}</td>
            <td>{$val.description}</td>
            <td>{$val.date_add}</td>
        </tr>
     {/foreach}
     {if $transactioncount == 0}
         <tr>
             <td colspan="9">
                 {$pharse.no_transactions_found_!!!}
             </td>
         </tr>
      {/if}
    </tbody>
</table>
{$pagination_html}
</div>