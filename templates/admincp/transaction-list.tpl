<div class="table-responsive">
<table class="table table-bordered table-hover">
    <thead>
        <tr>
            <th>{$phrases.date_added}</th>
            <th>{$phrases.transaction_id}</th>
            <th>Type</th>
            <th>Buyer Username</th>
            <th>Seller Username</th>
            <th>{$phrases.product_title}</th>
            <th>Product Category</th>
            <th>Product Subcategory</th>
            <th>Cancellation Insurance status</th>
            <th>Cancellation Insurance per(%)</th>
            <th>Cancellation Insurance Amount($)</th>
            <th>{$phrases.status}</th>
            <th>{$phrases.amount} (<span class="curr_symbol">{$currency}</span>)</th>
            <th>Distribution Fee(<span class="curr_symbol">{$currency}</span>)</th>
            <th>Cultivation Tax(<span class="curr_symbol">{$currency}</span>)</th>
            <th>Excise Tax(<span class="curr_symbol">{$currency}</span>)</th>
            <th>Fees to Herbee (<span class="curr_symbol">{$currency}</span>)</th>
            <th>Tax paid by buyer (<span class="curr_symbol">{$currency}</span>)</th>
            <th>Tax paid to state</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
      {if $pagination>0}
         {foreach $trans as $key => $val}	
            <tr>
                <td>{$val.date_add}</td>
                <td>{$val.transactionid}</td>
                <td>
                  {if $val.type == 'bought'}
                    {if $val.b_recurring == '1'}Recurring Product{/if}
                    {if $val.b_recurring == '0'}Product{/if}
                  {/if}
                  {if $val.type == 'ad_payment'}Ads{/if}
                  {if $val.type == 'refund_ad_payment'}Refund Ads Payment{/if}
                  {if $val.type == 'membership'}Membership{/if}
                  {if $val.type == 'wire_payment'}Wire funds{/if}
                  {if $val.type == 'check_payment'}Check funds{/if}
                  {if $val.type == 'relationship'}Relationship{/if}
                  {if $val.type == 'refund_request'}Refund request{/if}
                  {if $val.type == 'manual_payment'}{$val.istatus} by Admin{/if}
                  {if $val.type == 'refer_promo'}Referral Bonus{/if}
                </td>
                <td>{$val.username}</td>
                <td>
                  {if $val.seller_username == ''} NA {/if}
                  {if $val.seller_username != ''} {$val.seller_username} {/if}
                </td>
                <td>
                  {if $val.type == "bought"} {$val.title} {/if}
                  {if $val.type == 'ad_payment'} {$val.ad_name} {/if}
                  {if $val.type == 'refund_ad_payment'} {$val.ad_name} {/if}
                  {if $val.type == 'membership'}{$val.title}{/if}
                  {if $val.type == 'wire_payment'}{$val.title}{/if}
                  {if $val.type == 'check_payment'}{$val.title}{/if}
                  {if $val.type == 'relationship'}{$val.title}{/if}
                  {if $val.type == 'refund_request'}{$val.title}{/if}
                  {if $val.type == 'manual_payment'}{$val.title}{/if}
                  {if $val.type == 'refer_promo'}Referral Bonus{/if}
                </td>
                <td>{$val.parent_category_name}</td>
                <td>{$val.category_name}</td>
                <td>
                  {if $val.b_recurring == '1'}
                    {if $val.b_cancel_ins_status == 1}
                      Yes
                    {/if}
                    {if $val.b_cancel_ins_status == 0}
                      No
                    {/if}
                  {/if}
                  {if $val.b_recurring != '1'}
                    NA
                  {/if}
                 </td>
                 <td>
                  {if $val.b_recurring == '1'}
                    {if $val.b_cancel_ins_status == 1}
                      {$val.b_cancel_ins_per}
                    {/if}
                    {if $val.b_cancel_ins_status == 0}
                      No
                    {/if}
                  {/if}
                  {if $val.b_recurring != '1'}
                    NA
                  {/if}

                 </td>
                 <td>
                  {if $val.b_recurring == '1'}
                    {if $val.b_cancel_ins_status == 1}
                      {$val.b_cancel_ins_amt}
                    {/if}
                    {if $val.b_cancel_ins_status == 0}
                      No
                    {/if}
                  {/if}
                  {if $val.b_recurring != '1'}
                    NA
                  {/if}
                 </td>
                
                <td>{$val.istatus}</td>
                <td>{$val.i_amount}</td>
                <td>{$val.b_distribution_tax}</td>
                <td>{$val.b_cultivation_tax}</td>
                <td>{$val.b_excise_tax_amt}</td>
                <td>{$val.herbee_fee}</td>
                <td>{$val.tax_paid}</td>
                <td>{$val.state}</td>
                <td>{if $val.type == 'bought'}<a href="{$config.url}/dashboard/invoice/{$val.b_id}">View</a>{/if}</td>
            </tr>
         {/foreach}
      {else}
           <tr>
               <td colspan="15">
                   No transactions found !!!
               </td>
           </tr>
      {/if}
    </tbody>
</table>

</div>
{$pagination_html}