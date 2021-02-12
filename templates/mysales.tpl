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
{include file="common/seller-head.tpl" nocache}

          <h3>My Sales</h3>
                    <div class="darkgray-form">
            <div class="tabs-form">
              <ul class="tabz">
                <a href="{$config['url']}/dashboard/mysales"><li class="active">Sold Items</li></a>
                <a href="{$config['url']}/dashboard/myselling"><li>Selling Items</li></a>
                <a href="{$config['url']}/dashboard/myselling?cmd=draft"><li {if $cmd == 'draft'}class="active" {/if}>Draft Items</li></a>
                <a href="{$config['url']}/dashboard/myselling?cmd=closed"><li {if $cmd == 'closed'}class="active" {/if}>Closed Items</li></a>
              </ul>
              <div class="tabz-content">
              <form method="post" action="{$config.url}/dashboard/mysales" name="frmSearchSalesOrder" id="frmSearchSalesOrder" class="siteForm ondark" rel="search">
                  <table width="100%">
                    <tbody>
                      <tr>
                        <td> 
                          <input type="text" class="search_filter" name="searchsales" value="{$searchsales}" placeholder="Keyword" title="">
                        </td>
                        
                        <td> 
                          <input type="text" class="search_filter" name="date_from" id="date_from" value="{$date_from}" placeholder="Date From" class="date-pick calendar" readonly="" title="">
                        </td>
                        <td> 
                          <input type="text" class="search_filter" name="date_to" id="date_to" value="{$date_to}" placeholder="Date To" class="date-pick calendar" readonly="" title="">
                        </td>
                        <td> 
                          <input type="text" class="search_filter" name="minprice_vendor" value="{$minprice_vendor}" placeholder="From [$]" title="">
                        </td>
                        <td> 
                          <input type="text" class="search_filter" name="maxprice_vendor" value="{$maxprice_vendor}" placeholder="To [$]" title="">
                        </td>
                        <td> 
                          <input type="submit" name="btn_submit" id="btn_submit" title="" value="Search">
                        </td>
                        <td> 
                          <a class="buttonNormal clearValues" href="javascript:void(0);">Clear
                          </a>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                  <input type="hidden" name="mode" value="search" title="">
                  <input type="hidden" name="page" value="1" title="">
                </form>            
      </div>
          </div>
          </div>
                     <div class="tbl-listing">
            <h4>Items {$start_count} to {$end_count} of {$cnt} total</h4>
            <table>
              <tbody>
                <tr>
                  <th width="35%">Name</th>
                  <th width="15%">Date</th>
                  <th width="10%">Price</th>
                  <th width="12%">Status</th>
                  <th width="25%">Action</th>
                </tr>
                {if $projects|count <=  0}
                 <tr colspan="5"> No Products Found </div> 
                {else}  
                {foreach $projects as $key => $val}
                <tr>
                <td><span class="cellcaption">Name</span>{$val.title}</td>
                <td><span class="cellcaption">Date</span>{if $val.paid} {$val.paid_date} {/if}{if !$val.paid}Not Paid {/if}</td>
                  <td><span class="cellcaption">Price</span>{$currency} {$val.amount-$val.refund}</td>
                  <td><span class="cellcaption">Status</span>
                    {if $val.paid and $val.release == 1} Payment Confirmed {/if}
                    {if $val.paid and $val.release == 2} Payment Cancelled {/if}
                    {if !$val.paid and $val.release == 0} Unpaid {/if}
                    {if $val.paid and $val.release == 0} Paid {/if}
                  </td>

                  <td><span class="cellcaption">Action</span>

                  <a class="actions disabled" href="{$config['url']}/product/view/{$val.project_id}" title="View Order"><img src="{$config.url}/images/view.svg" alt=""></a>

                  {if $val.paid}
                     <a class="actions disabled" href="javascript:void(0);" onclick="viewShippingInfo({$val.cart_id})" title="View Shipping Details"><img src="{$config.url}/images/box.svg" alt=""></a>
                  {/if}
                  {if $val.tracking_number == '' and $val.paid && $val.shipping_description !='Local pick up only'}
                    <a class="actions disabled" href="javascript:void(0);" onclick="addShippingInfo({$val.cart_id},{$val.id},this)" title="Add Shipping Tracker Info"><img src="{$config.url}/images/route.svg" alt=""></a>
                  {/if}


                   <!-- <a class="actions disabled" href="/account/cancel_order/623" title="Cancel Order"><img src="{$config.url}/images/close.svg" alt=""></a> --></td>
              

                </tr>
                {/foreach} 
                {/if} 
               </tbody>
            </table>
                        <div class="pager">
             
                {$pagination_html}
             
            </div>
                      </div>
                    
        </div>
        
      </div>
    </div>


</div> 
</div>
<script>
$(function(){

  $('.clearValues').click(function(){
      $('input.search_filter').val('');
  });
  jQuery('#date_from').datetimepicker({
    timepicker:false,
    format:'Y/m/d',
    onShow:function( ct ){
        this.setOptions({
          maxDate:jQuery('#date_to').val()?jQuery('#date_to').val():false
        })
    },
  });

  jQuery('#date_to').datetimepicker({
    timepicker:false,
    format:'Y/m/d',
    onShow:function( ct ){
      this.setOptions({
        minDate:jQuery('#date_from').val()?jQuery('#date_from').val():false
      })
    },
  });
})
</script>
{include file="common/footer-1.tpl" nocache}
<div class="modal fade" id="shippinginfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
     <div class="modal-header"><h2 style="color: #000;font-size: 20px;font-weight: bold;">Shipping Details</h2></div>
     <div class="modal-body info-data"></div>    
    </div>
  </div>

    </div>

    <div class="modal fade" id="feedbackinfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
     <div class="modal-header"><h2 style="color: #000;font-size: 20px;font-weight: bold;">Feedback</h2></div>
     <div class="modal-body info-data"></div>    
    </div>
  
  </div>

    </div>