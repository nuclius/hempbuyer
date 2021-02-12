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
{include file="common/buyer-head.tpl" nocache}
{include file="time-common-loader.tpl" nocache}
    <h3>My Orders</h3>
    <div class="darkgray-form">
            <div class="tabs-form">
              <ul class="tabz">
                <a href="{$config['url']}/dashboard/activebids"><li>Active Bids</li></a>
                <a href="{$config['url']}/dashboard/wonbids"><li class="active">Bids Won</li></a>
                <a href="{$config['url']}/dashboard/myorders"><li>Buy Now</li></a>
                <a href="{$config['url']}/dashboard/activebids?cmd=lost"><li {if $cmd == 'lost'}class="active" {/if}>Bids Lost</li></a>
              </ul>
              <div class="tabz-content">
<form method="post" action="{$config.url}/dashboard/wonbids" name="frmSearchBuyerOrder" id="frmSearchBuyerOrder" class="siteForm ondark" rel="search">
  <table width="100%">
    <tbody>
      <tr>
        <td> <input class="search_filter" type="text" name="searchtitle" value="{$searchtitle}" placeholder="Keyword" title=""></td>
        <td> <input type="text" name="searchdateFrom" value="{$datefrom}" placeholder="Date From" id="datefrom" class="search_filter date-pick calendar" title=""> </td>
        <td> <input type="text" name="searchdateTo" value="{$dateto}" id="dateto" placeholder="Date To" class="search_filter date-pick calendar" title="" readonly autocomplete="off"> </td>
        <td> <input type="text" name="pricefrom" value="{$pricefrom}" class="search_filter" placeholder="Order From [$]" title=""></td><td> <input type="text" name="priceto" value="{$priceto}" class="search_filter" placeholder="Order To [$]" title=""></td>
        <td> <input type="submit" name="btn_submit" id="btn_submit" title="" value="Search"></td>
        <td> <a class="buttonNormal clearValues" href="javascript:void(0);">Clear</a></td>
      </tr>
    </tbody>
  </table>
</form>

           </div>
            </div>
          </div>
                     <div class="tbl-listing">
            <h4>Items {$start_count} to {$end_count} of {$cnt} total</h4>
            <table>
              <tbody>
                <tr>
                  <th width="15%">Image</th>
                  <th width="40%">Ordered Products</th>
                  <th width="10%">Amount</th>
                  <th width="10%">Won Date</th>
                  <th width="25%">Action</th>
                </tr>
                  {if $mybids|count <=  0}

                   <tr> {$phrase.no_bids_found} </tr>

                  {else}

                    {foreach $mybids as $key => $val}
                    
                  <tr>

                  <td><div class="avatar"><img class="mail2 img-responsive img-circle"
                                 src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}"
                                 title="No Photo" alt="no_img"/>
                           </div></td>
                  <td class="cellitem"><span class="cellcaption">Ordered Products</span> {$val.title} (Qty:{if $val.qty == ''} 1 {else if $val.qty != ''} {$val.qty} {/if})  
                    <p class="Lis14 text-justify height_58">{$val.description}</p>
                  </td>
                    <td nowrap="nowrap"><span class="cellcaption">Total</span> 
          {$currency} {$val.amount}</td>
                    <td nowrap="nowrap"><span class="cellcaption">Won Date</span>
                        {$phrase.won_date}: {$val.date_add}  
                    </td>
                    <td nowrap="nowrap">
                           
                        {if $val.paid == 0}
                          <a class="actions" title="Pay" href="javascript:void(0);" onclick="window.location = '{$config.url}/product/payment/{$val.b_id}'"><img alt="" src="{$config.url}/images/business.svg"></a>
                        {/if}

                        {if $val.paid == 1 || $val.paid == 2}
                            <a class="actions" title="Feedback" href="javascript:void(0);" onclick="window.location='{$config.url}/dashboard/invoice/{$val.b_id}'"><img alt="" src="{$config.url}/images/view.svg"></a>
                            {if $val.release == 0}
                               <a class="actions" title="Release Fund" href="javascript:void(0);" onclick="doAction('release_buy',{$val.b_id})"><img alt="" src="{$config.url}/images/dollar-arrow.svg">
                            {/if}
                            {if $val.shipping_info != ''}<a class="actions" href="javascript:void(0);" title="Shipping" onclick="viewShippingTracking({$val.cart_id},{$val.b_id})"><img src="{$config.url}/images/box.svg" alt="" ></a>{/if}
                            {if $val.release == 0}<a class="actions" title="Cancel Fund" href="javascript:void(0);" onclick="doAction('cancel_buy',{$val.b_id})"><img alt="" src="{$config.url}/images/close.svg"></a>{/if}
                            {if $val.feedback == 0 and $val.release > 0}       
                            <a class="actions" title="Feedback" href="javascript:void(0);" onclick="doAction('feedback_buy',{$val.b_id})"><img alt="" src="{$config.url}/images/list.svg"></a>
                            {/if} 
                            {if $val.feedback == 1 and $val.release > 0}
                            <a class="actions" title="Feedback Review" href="javascript:void(0);" onclick="feedbackReview({$val.b_id})"><img alt="" src="{$config.url}/images/icon.svg"></a>{/if} 
                            {if !$val.dispute_id > 0}
                                <a class="actions" href="javascript:void(0);" title="Add Dispute" onclick="view_dispute({$val.id})"><img src="{$config.url}/images/hand.svg" alt="" ></a>
                            {/if}

                            {if $val.is_digital == 1}<a class="actions" href="javascript:void(0);" title="Download" onclick="window.location.href='{$config.url}/dashboard/download/{$val.b_id}'"><img src="{$config.url}/images/arrows.svg" alt="" ></a>{/if}               
                              
                            {if $val.shipping_info != ''}<a class="actions" href="javascript:void(0);" title="Shipping" onclick="viewShippingTracking({$val.cart_id},{$val.b_id})"><img src="{$config.url}/images/box.svg" alt="" ></a>{/if}


                        {/if}

                     
                      
                     
                             
                       
                       
                      
                  </td> 

                   
          
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
<script type="text/javascript">
function doAction(cmd,id)
{
    if(cmd == 'release_buy')
    {
        var r = confirm("Are You sure yo want to release the fund?");
        if (r == true) {
            window.location = '{$config.url}/dashboard/payment/release/buy/'+id
        } else {
            return false;
        }
    } 
    if(cmd == 'cancel_buy')
    {
        var r = confirm("Are You sure yo want to cancel the fund?");
        if (r == true) {
            window.location = '{$config.url}/dashboard/payment/cancel/buy/'+id
        } else {
            return false;
        }
    } 
    if(cmd == 'release')
    {
        var r = confirm("Are You sure yo want to release the fund?");
        if (r == true) {
            window.location = '{$config.url}/dashboard/payment/release/bid/'+id
        } else {
            return false;
        }
    } 
    if(cmd == 'cancel')
    {
        var r = confirm("Are You sure yo want to cancel the fund?");
        if (r == true) {
            window.location = '{$config.url}/dashboard/payment/release/bid/'+id
        } else {
            return false;
        }
    } 
    if(cmd == 'feedback_buy')
    {
       
            window.location = '{$config.url}/dashboard/payment/feedback/buy/'+id
    } 
    if(cmd == 'feedback')
    {
       
            window.location = '{$config.url}/dashboard/payment/feedback/bid/'+id
        
    }  

}
$(function(){
  $('.clearValues').click(function(){
      $('input.search_filter').val('');
  });


  jQuery('#datefrom').datetimepicker({
    timepicker:false,
    format:'Y/m/d',
    onShow:function( ct ){
        this.setOptions({
          maxDate:jQuery('#dateto').val()?jQuery('#dateto').val():false
        })
    },
  });

  jQuery('#dateto').datetimepicker({
    timepicker:false,
    format:'Y/m/d',
    onShow:function( ct ){
      this.setOptions({
        minDate:jQuery('#datefrom').val()?jQuery('#datefrom').val():false
      })
    },
  });




});
</script>

{include file="/common/footer-1.tpl" nocache}
<div class="modal fade" id="feedbackinfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
       <div class="modal-header"><h2 style="color: #000;font-size: 20px;font-weight: bold;">{$phrase.feedback}</h2></div>
       <div class="modal-body info-data"></div>    
    </div>
  
  </div>

</div>

<div class="modal fade" id="shippinginfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
     <div class="modal-header"><h2 style="color: #000;font-size: 20px;font-weight: bold;">{$phrase.shipping_info}</h2></div>
     <div class="modal-body info-data"></div>    
    </div>
  </div>

</div>