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
{include file="time-common-loader.tpl" nocache}
<script type="text/javascript">
  var clock = [];
  var targetDate = [];
  var clearvar = [];
  var timeProject = [];
</script>

          <h3>My Sales</h3>
                    <div class="darkgray-form">
            <div class="tabs-form">
              <ul class="tabz">
                <a href="{$config['url']}/dashboard/mysales"><li>Sold Items</li></a>
                <a href="{$config['url']}/dashboard/myselling"><li {if $cmd != 'draft' && $cmd != 'closed'} class="active" {/if}>Selling Items</li></a>
                <a href="{$config['url']}/dashboard/myselling?cmd=draft"><li {if $cmd == 'draft'}class="active" {/if}>Draft Items</li></a>
                <a href="{$config['url']}/dashboard/myselling?cmd=closed"><li {if $cmd == 'closed'}class="active" {/if}>Closed Items</li></a>

              </ul>
              <div class="tabz-content">
              <form method="post" action="{$config.url}/dashboard/myselling?cmd={$cmd}" name="frmSearchSalesOrder" id="frmSearchSalesOrder" class="siteForm ondark" rel="search">
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
                  <th>Image</th>
                  <th>Name</th>
                  <th>Sold</th>
                  <th>Price</th>
                  <th>Status</th>
                  <th>Action</th>
                </tr>
                {if $projects|count <=  0}
                 <tr colspan="5"> No Products Found </div> 
                {else}  
                {foreach $projects as $key => $val}
                <tr>
                <td><div class="avatar"><img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" class="mail2 img-responsive img-circle" /></div></td>
                <td><span class="cellcaption">Name</span>{$val.title}</td>
                <td>{$val.sold}</td>
                  <td><span class="cellcaption">Price</span>{if $val.buynow == 1}
                                                                  {$currency} {$val.bprice}
                                                            {else if $val.buynow == 0}
                                                              <button class="btn btn-default bid_hbtn" style="margin-top: 3px;"  onclick="bidHistory({$val.id})">Bid History</button> &nbsp; <span style="color:red;font-weight:bold">{{$val.bids}} Bids</span>
                                                            {/if}</td>
                  <td><span class="cellcaption">Status</span>
                    <span id="my{$val.id}">{if $val.status == 'open' or $val.status == 'draft'}
                        {$val.day}
                      {else if $val.status != 'open'}
                      Closed
                    {/if}</span>
                  </td>

                  <td><span class="cellcaption">Action</span><a class="actions disabled" href="{$config['url']}/product/view/{$val.id}" title="View Order"><img src="{$config.url}/images/view.svg" alt=""></a> <!-- <a class="actions disabled" href="/account/cancel_order/623" title="Cancel Order"><img src="{$config.url}/images/close.svg" alt=""></a> -->
                  <a class="actions" href="javascript:void(0);" title="Transfer Product" onclick="tranfer_option({$val.id})"><img src="{$config.url}/images/transfer.svg" alt="" ></a>

                  {if $cmd != 'closed'}<a class="actions" href="{$config['url']}/dashboard/product/edit/{$val.id}" title="Edit Product"><img src="{$config.url}/images/editing.svg" alt="" ></a>
                  {/if}
                  </td>
              

                </tr>
                {include file="time-loader.tpl" nocache}
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

<!-- Trnasfer ownership -->

<script language="javascript" type="text/javascript">
          $(function() { $('.myp').addClass('act_class'); } );
</script> 
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
{include file="common/footer-1.tpl" nocache}

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
                  <ul class="dropdown-menu dropdown-menus col-md-12" style="width: 100%;" role="menu" aria-labelledby="menu1">
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