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

<div class="tabz-content">
              <h3>Your Product Purchases</h3>
              <div class="orders-list">
                <ul>
                  <li> <a href="{$config['url']}/dashboard/myorders"><span class="txt-big">{$currency} {$debits} </span>
                    <p>Total Purchases</p>
                    </a> </li>
                  <li><a href="{$config['url']}/dashboard/myorders"><span class="txt-big">{$orders} </span>
                    <p>Total Orders</p>
                    </a> </li>
                    <li> <a href="{$config['url']}/dashboard/newmessages"><span class="txt-big">{$msgcount}</span>
                    <p>Unread Messages</p>
                    </a> </li>
                </ul>
              </div>
              
              <div class="banks-tbs">
                <div id="bank-info-tab" style="display: block; width: 100%; margin: 0px;">
                   <h3>Personal Information</h3>
                  <a class="view-more" id="editinfotab" href="{$config['url']}/profile_settings">Edit Information</a>
                  <div class="resp-tabs-container">
                    <div class="resp-tab-content resp-tab-content-active" aria-labelledby="tab_item-0" style="display:block">
                      <table class=" tbl-normal">
                        <tbody>
                          <tr>
                            <td><strong>Username:</strong> {$users.first_name} </td>
                            <td><strong>Email:</strong> {$users.email}</td>
                          </tr>
                          <tr>
                            <td><strong>Name:</strong> {$users.first_name} {$users.last_name}</td>
                            <td><strong>Phone:</strong> {$users.phone} <span class="smallItalicText">({if $users.phone neq ''}
                {if $users.verifyphone eq 0}
               <a href="{$config.url}/dashboard/notification_manager" class="btn btn-default btn-danger">Verify</a> {/if}{/if}
               {if $users.verifyphone eq 1}
               <span style="color:#075A0B;font-weight:bold">{$phrase.verified}</span>
               {/if} )</span></td>
                          </tr>
                          <tr>
                            <td><strong>Location:</strong> {$users.address1}, {$users.city},{$users.state}</td>
                            <td><strong>Member Since:</strong> {$users.created_at}</td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                    
                    </div>
                    
                    </div>
                  </div>
                </div>
              
              
              
              
              
              
              <div class="gap"></div>
              <div class="tbl-dashboard">
                <div class="tbl-left">
                  <h3>Latest 5 Orders</h3>
                  <div class="latest-order">
                    <table class="tbl-normal">
                      <tbody>
                          
                        <tr>
                          <th>Order Particulars</th>
                          <th width="25%">Amount/Status</th>
                          <th width="22%">Status</th>
                        </tr>

                        {$reviewcount = 0}   
                        {assign var=val value=1}   
                          {foreach $products as $key => $val}
                          {$reviewcount = 1}  
                            
                            {assign var=vals value=$vals+1}
                            {if $vals <= 5}
                            
                          <tr>
                            <td><span class="cellcaption">Order Particulars</span>{$val.date_added}<br>
                            
                            <span class="cellcaption">Ordered Products</span><strong>{$val.title}</strong> (Qty:{if $val.qty == ''} 1 {else if $val.qty != ''} {$val.qty} {/if}) 
                                       
                                       
                            </td>
                            <td><span class="cellcaption">Amount</span>{if $val.release == 2} {$phrase.fund_cancelled} {/if}
                        {if $val.release == 1} {$phrase.fund_released} {/if}  
                        <br> <strong>{$currency} {$val.proposed_amount - $val.refund_amount}</strong></td>
                            <td nowrap="nowrap">
                           
             
                            
                          <!--<a class="actions" title="Send a message" href="/account/send_message/order/672"><img alt="" src="images/message.svg"></a>-->
                          {if $val.release == 0}<a class="actions" title="Cancel Fund" href="javascript:void(0);" onclick="doAction('cancel_buy',{$val.b_id})"><img alt="" src="{$config.url}/images/close.svg"></a>{/if}
                          
                          {if $val.release == 0}
                          <a class="actions" title="Release Fund" href="javascript:void(0);" onclick="doAction('release_buy',{$val.b_id})"><img alt="" src="{$config.url}/images/dollar-arrow.svg"></a>
                          {/if}

                          {if $val.buynow == 1}
                              <a class="actions" title="Invoice" href="javascript:void(0);" onclick="window.location='{$config.url}/dashboard/invoice/{$val.b_id}'"><img alt="" src="{$config.url}/images/view.svg"></a>
                          {/if}  
                         
                           {if $val.feedback == 0 and $val.release > 0}       
                              <a class="actions" title="Feedback" href="javascript:void(0);" onclick="doAction('feedback_buy',{$val.b_id})"><img alt="" src="{$config.url}/images/list.svg"></a>
                          {/if}       
                          {if $val.feedback == 1 and $val.release > 0}
                              <a class="actions" title="Feedback Review" href="javascript:void(0);" onclick="feedbackReview({$val.b_id})"><img alt="" src="{$config.url}/images/icon.svg"></a>

                          {/if}  
                           {if $val.dispute_id > 0}
                             <input type="hidden" id="dispute{$val.dispute_id}" value='{$val.message}'>
                              <a class="actions" href="javascript:void(0);" title="Show Dispute" onclick="view_dispute_details({$val.dispute_id},'{$val.subject}')"><img src="{$config.url}/images/home.svg" alt="" ></a>
                          {/if}
                          {if !$val.dispute_id > 0}
                            <a class="actions" href="javascript:void(0);" title="Add Dispute" onclick="view_dispute({$val.id})"><img src="{$config.url}/images/hand.svg" alt="" ></a>
                          {/if}

                          {if $val.is_digital == 1}<a class="actions" href="javascript:void(0);" title="Download" onclick="window.location.href='{$config.url}/dashboard/download/{$val.b_id}'"><img src="{$config.url}/images/arrows.svg" alt="" ></a>{/if}               
                          
                          {if $val.shipping_info != ''}<a class="actions" href="javascript:void(0);" title="Shipping" onclick="viewShippingTracking({$val.cart_id},{$val.b_id})"><img src="{$config.url}/images/box.svg" alt="" ></a>{/if}
                      </td> 
                        </tr>
                           {/if}
                           {/foreach}             
                           {if $reviewcount ==0}
                               <tr>
                                   <td colspan="4">
                                     No Orders
                                   </td>
                               </tr>
                           {/if}
                          </tbody>
                    </table>
                  </div>
                  
                  
                  
                  
                  <div class="gap"></div>
                </div>
            <div class="tbl-right">
              <h3>Latest Messages</h3>
              <div class="message-list">
                
                    <ul>
                       {$reviewcount = 0}      
                          {foreach $messages as $key => $val}
                          {$reviewcount = 1}  
                            <li>
                                <div class="pic">
                                  {if $loged.userid == $val.from_id}

                                    <img class="mail2 img-responsive img-circle"
                                       src="{if $val.tavatar == ''} {$config['imgpath']}no_img.png {else if $val.tavatar != ''}{$config['url']}/uploads/profile/{$val.tavatar}{/if}"
                                       title="No Photo" alt="no_img"/>
                                 
                                  {else if $loged.userid != $val.from_id}
                                   <img class="mail2 img-responsive img-circle"
                                       src="{if $val.favatar == ''} {$config['imgpath']}no_img.png {else if $val.favatar != ''}{$config['url']}/uploads/profile/{$val.favatar}{/if}"
                                       title="No Photo" alt="no_img"/>
                                  {/if}
                                </div>
                                <div class="text">
                                  <h4>{if $loged.userid == $val.from_id}
                                      <strong>{$val.tname}</strong>
                                    {else if $loged.userid != $val.from_id}
                                      <strong>{$val.fname}</strong>
                                    {/if}
                                  </h4>
                                  <p> {$val.subject}</p>
                                  <a class="readmore" href="{$config.url}/dashboard/messages/view/{$val.r_id}"><img alt="" src="{$config['url']}/images/reammore.png"></a>
                                </div>
                            </li>
                          {/foreach}
                          {if $reviewcount ==0}
                             <li>
                                 <div class="text">
                                   No messages
                                 </div>
                             </li>
                         {/if}
                        
                      </ul>
                
                
              </div>
            </div>
              </div>
            </div>
            </div>
            
<script type="text/javascript">
$(function()
{
  projectLoad();

                  
    $("#submit_id").click(function(e){
      e.preventDefault();
      var mailid =  $('#transfer_mail').val(); 

                  $.ajax({
                     type:'POST',
                     url:'/dashboard/check_if_exist',
                     data : { bid : mailid },
                     success: function ( response )
                     {

                        if( response == "exist" ){
                          
                          $('#transfer_product').submit();
                        }
                        else{
                          alert("User Email does not exist");
                        }
                     }

                  });
                  
              
                
               //$('#vpcheckout').submit();
            
           
    });




});
function bidHistory(id)
{

  $.ajax({
   url:'{$config.url}/bidhistory/'+id,
   type:'GET',
    success:function(data)
    {
      
       $('.panel-body').html(data.html);
       $('#bid_history').modal('show');
    }
  });
}
function tranfer_option(id){

  $('#product_id').val(id);
  $('#transfer').modal('show');
}
$(function(){

$( "#transfer_mail" ).keydown(function() {
      var mailid =  $('#transfer_mail').val();
      $('.dropdown').removeClass('open');
       $.ajax({
             type:'POST',
             url:'/dashboard/getmailids',
             data : { bid : mailid },
             success: function (data)
             {

                  $('.dropdown').addClass('open');
                  $('.dropdown-menus').html('');
                  $('.dropdown-menus').html( data );

              }

        });


  });

  $(".dropdown-menus").on('click',"li a",function(e){
      $('#transfer_mail').val( $(this).html() );
      $('.dropdown').removeClass('open');
  });
});

</script>
{include file="/common/footer-1.tpl" nocache}
<!-- Bids Display -->
<div class="modal fade" id="bid_history" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
      <img src="{$config.url}/images/logoc.png" class="img-responsives"/>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><img src="{$config.url}/images/close.png" style="position: absolute;right: -10px;top: -15px;" width="27px" height="27px" /></button>
      </div>
      <div class="modal-body bid_history">
      <h5 class="bid_hlbl">Bid History</h5>
      <div class="panel panel-default">
        <div class="panel-heading">
          <div class="row">
            <div class="col-md-5">
              User Name/State
            </div>
            <div class="col-md-3">
              Email
            </div>
            <div class="col-md-2">
              Date & Time
            </div>
            <div class="col-md-2">
            Amount
            </div>
          </div>
        </div>
        <div class="panel-body">
          <div class="row">
            <div class="col-md-5">
              
            </div>
            <div class="col-md-4">
              
            </div>
            <div class="col-md-3">
            
            </div>
          </div>
        </div>
      </div>
    </div>
    </div>
  </div>
</div>

<!-- Bids Display Ends Here -->
<!-- Transfer module -->

<div class="modal fade" id="transfer" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
      <img src="{$config.url}/images/logoc.png" class="img-responsives"/>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><img src="{$config.url}/images/close.png" style="position: absolute;right: -10px;top: -15px;" width="27px" height="27px" /></button>
      </div>
      <div class="modal-body transfer">
      <h5 class="bid_hlbl">Transfer owner ship</h5>
      <div class="panel panel-default">
        <div class="panel-heading">
          <div class="row">
            <div class="col-md-8">
              <form action="{$config['url']}/dashboard/transfer_ownership" method="post" id="transfer_product" data-parsley-validate>
                <div class="col-md-8">
                <div class="dropdown">
                  <input type="email" class="form-control" name="transfer_mail" id="transfer_mail" placeholder="Email Id" required autocomplete="off">
                  <ul class="dropdown-menu dropdown-menus col-md-12" role="menu" aria-labelledby="menu1">
                  </ul>
                </div>
                <input type="hidden" class="form-control" name="product_id" id="product_id"  required>
                </div>
                <div class="col-md-2"><button type="submit" class="btn btn-default" id="submit_id">Transfer</button></div>
              </form>
            </div>
            
            
          </div>
        </div>
        
      </div>
    </div>
    </div>
  </div>
</div>



<!-- Transfer module ends Here -->