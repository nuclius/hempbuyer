<!--============================================================================*\
|| ########################################################################## ||
|| # Auction Software Marketplace[*]version[*] Build [*]build[*]
|| # ---------------------------------------------------------------------- # ||
|| # Customer License # [*]license[*]
|| # ---------------------------------------------------------------------- # ||
|| # Copyright ©2014–[*]year[*] Develop Scripts LLC. All Rights Reserved    # ||
|| # This file may not be redistributed in whole or significant part.       # ||
|| # ------------- AUCTION SOFTWARE IS NOT FREE SOFTWARE ------------------ # ||
|| # http://www.auctionsoftwaremarketplace.com|support@auctionsoftware.com  # ||
|| # ---------------------------------------------------------------------- # ||
|| ########################################################################## ||
\*============================================================================ -->

{include file="common/header-1.tpl" nocache}
{if $sellers == 1}
{include file="common/seller-head.tpl" nocache}
{else}
{include file="common/buyer-head.tpl" nocache}
{/if}
        
          
                  
          <div class="gap"></div>
          <div class="clearfix"></div>
                    <div class="darkgray-form clearfix">
            <div class="left-txt">Items {$start_count} to {$end_count} of {$cnt} total</div>
          </div>
          <div class="tbl-listing">
            <table>
              <tbody>
                <tr>
                  <th width="10%">ID</th>
                  <th width="24%">Date</th>
                  <th width="10%">Credit</th>
                  <th width="10%">Debit</th>
                  <th width="36%">Description</th>
                  <th width="10%">Status</th>
                </tr>

                {if $payments|count <=  0}
                <div class="row mblue_box1 tno_bids"> {$phrase.no_payment_yet} </div>
                {else}
                {foreach $payments as $key => $val}
                <tr>
                  <td><span class="cellcaption">ID</span>TN-{$val.id}</td>
                  <td><span class="cellcaption">Date</span>{$val.date_added}</td>
                  <td><span class="cellcaption">Credit</span><span class="nowrap">
                    {if $val.user_id == $loged.userid} {$currency} 0.00 {else if $val.user_id != $loged.user_id}  {$currency} {$val.amount}{/if}
                  </span></td>
                  <td class="cellitem"><span class="cellcaption">Debit</span><span class="nowrap">
                  {if $val.user_id == $loged.userid} {$currency} {$val.amount} {else if $val.user_id != $loged.user_id} {$currency} 0.00 {/if}</span></td>
                  <td class="cellitem"><span class="cellcaption">Description</span>{$val.description}</td>
                  <td class="cellitem"><span class="cellcaption">Status</span><span class="txtHightlight green"> 
                  {if $val.status == 'paid'}
                  <label class="label label-success" onclick="window.location='{$config.url}/dashboard/invoice/{$val.buyid}'">{$phrase.paid}</label> {/if}
                  {if $val.status == 'unpaid' && $val.user_id == $loged.userid && $val.type == 'winner'} <label class="label label-danger" onclick="window.location='{$config.url}/product/payment/{$val.buyid}'">{$phrase.pay}</label> {/if}
              {if $val.status == 'unpaid' && $val.user_id != $loged.userid && $val.type == 'winner'} <label class="label label-danger" >{$phrase.unpaid}</label> {/if}</span></td>
                </tr>
                {/foreach}
                {/if}
                   
                     </tbody>
            </table>
              <div class="pager">
               <div class="col-md-6 text-right">{$pagination_html}</div>
              </div>
                      </div>
                  </div>
        
      </div>
    </div>

</div>
</div>
{include file="/common/footer-1.tpl" nocache}