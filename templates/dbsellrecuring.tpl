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
<script src="{$config.url}/js/countdown2.js"></script>
<!-- Page content -->
<style>
.mr-10{
    margin-right: 10px;
}
</style>

{include file="common/dashboard-navigation.tpl" nocache}

    <div class="container-fluid grey-bg xs-pdlr">
        <div class="container dashboard-con m50">
            <div class="row flex">
                <div class="col-sm-7 col-xs-6 margin-auto w100-480">
                    <ul class="nav nav-pills nav-justified">
                        {if $loged.business_settings.open_bid == 1}<li ><a class="p20-15"  href="{$config.url}/dashboard/myrequests">Open Bid Market</a></li>{/if}
                        <li class="active"><a class="p20-15" data-toggle="pill" href="#direct-buy">Direct Buy Market</a></li>
                    </ul>
                </div>
                <div class="col-sm-5 col-xs-6 margin-auto w100-480">
                    <form enctype="multipart/form-data" method="get" enctype="multipart/form-data"
            action="{$config.url}/dashboard/seller/recuring/">
                    <div class="row flex">
                        <!-- <div class="col-md-6">
                            <div class="row">
                                <div class="col-md-6">
                                    <label style="margin-bottom:2px;" for="">Transactions</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="From">
                                        <span class="input-group-addon" id="basic-addon2"><i class="fa fa-calendar" aria-hidden="true"></i></span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="" style="opacity:0;margin-bottom:2px;">Transactions</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="To">
                                        <span class="input-group-addon" id="basic-addon2"><i class="fa fa-calendar" aria-hidden="true"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div> -->
                        <div class="col-sm-12 text-right margin-auto m-b-0">
                            <input class="p5-15 border1 input-radius search-input bg-transparent" placeholder="Search" type="text" style="border-color:#d4d4d4;" name="search" value="{$search.search}">
                            <button type="submit" class="input-radius green-b b search-btn">
                                <i class="fa fa-search white" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>
                </form>
                </div>
            </div>
            <div class="tab-content main-tab-content">
            <div id="direct-buy" class="tab-pane white-bg active">
                    <div class="panel panel-success">
                        <div class="panel-heading green-bg p0">
                            <ul class="nav nav-pills sub-link">
                                {if $loged.business_settings.buy_db == 1}
                                <li class=""><a class="white"  href="{$config.url}/dashboard/dbmarket/">Buyer</a></li>
                                {/if}
                                <li class="active"><a class="white"  href="#d-seller">Seller</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="tab-content sub-tab-content">
                        <div id="d-seller" class="tab-pane buyer fade in active">
                            <h3>Seller Dashboard</h3>
                            <ul class="nav nav-pills super-sub-link">
                                <li class=""><a class="" href="{$config.url}/dashboard/seller/selling">Products I'm Selling </a></li>
                                <li><a class=""  href="{$config.url}/dashboard/seller/sold"> Products I've Sold</a></li>
                                <li class="active"><a class=""  href="{$config.url}/dashboard/seller/recuring">Recurring Purchases <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>
                                <!-- <li><a class="" data-toggle="pill" href="#d-ended">Ended</a></li> -->
                                <li><a class=""  href="{$config.url}/dashboard/seller/negotiation">Direct Buy Negotiations
                    <!-- <img src="images/negotiable-grey.png" style="display:inline-block; margin-right:6px; margin-top: -10px;" class="img-responsive" alt=""> -->
                  </a></li>

                  <li class=""><a class=""  href="{$config.url}/dashboard/seller/rejected">Rejected Proposals <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>
                  <li><a class=""  href="{$config.url}/dashboard/seller/inventory">Inventory <!-- <i class="icon flaticon-shopping-cart" aria-hidden="true"></i> --></a></li>
                  <li><a class=""  href="{$config.url}/dashboard/seller/inventorbyproduct">Inventory By Product</a></li>
                  <!-- <li class=""><a class=""  href="{$config.url}/dashboard/seller/accepted">Accepted Proposals <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li> -->
                            </ul>
                            <div class="tab-content super-tab-content">
                                <div id="d-selling" class="tab-pane fade in active">
                                {foreach $myProducts as $key => $val}
                                        <form id="accept_form{$val.r_id}" method="post" action="{$config.url}/product/recurring/request/accept/{$val.r_id}">
                                         </form>
                                         <form id="reject_form{$val.r_id}" method="post" action="{$config.url}/product/recurring/request/reject/{$val.r_id}">
                                         </form>
                                         <form id="cancel_form{$val.r_id}" method="post" action="{$config.url}/product/reccancellation/approve{$val.r_id}">
                                         </form>
                                    <div class="row flex p15-0">
                                        <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                                            <div class="product-thumb">
                                                <img src="{$config.imgpath}product/{$val.avatar}" class="img-responsive" alt="">
                                            </div>
                                        </div>
                                        <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                                            <ul class="p0">
                                                <li>
                                                    <div class="row">
                                                        
                                                        <div class="col-md-4 col-sm-6 col-xs-6 w100-480 pull-right">
                                                        <div class=" pull-right">
                                                        {if $val.r_status == 'unverified'}
                                                          <a style="cursor: pointer;" class="w100" class="btn-link" onclick="acceptRequest({$val.r_id})"> Accept <span class="slash">|</span></a>
                                                          <a style="cursor: pointer;" class="w100 red" class="btn-link" onclick="rejectRequest({$val.r_id})"> Reject</a>
                                                          {/if}
                                                        {if $val.r_status == 'approve'}
                                                          <span class="w100 green" class="btn-link"> Approved</span>
                                                          {/if}

<!--
                                                            {$val.cancelreq}
                                                            {$val.sapprove_status}
                                                            {$val.aapprove_status}
 -->
                                                          {if $val.cancelreq == 1 && $val.sapprove_status == 0 && $val.aapprove_status == 0}
                                                          <button class="btn btn-default btn-d-b green-b shadow-btn m0 " data-record-srid="{$val.r_id}" type="button" name="button" data-toggle="modal" data-target="#cancellation_approval" >Cancel</button>
                                                           {/if}
                                                           {if $val.cancelreq == 1 && $val.sapprove_status == 1 && $val.aapprove_status == 0}
                                                          Waiting for admin approval...
                                                           {/if}
                                                           {if $val.cancelreq == 1 && $val.sapprove_status == 1 && $val.aapprove_status == 1}
                                                          Recurring was cancelled at {$val.cancelled_at}
                                                           {/if}


                                                        {if $val.r_status == 'reject'}
                                                          <span class="w100 red" class="btn-link"> Rejected</span>
                                                          {/if}

                                                        </div>

                                                        </div>
                                                        <div class="col-sm-8">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span> {$val.title}</span></li>
                                                                <li class="item"><b class="caption">Quantity Available:  </b> <span> {$val.qty} {$val.short_unit} </span></li>

                                                                <li class="item inline-block"><b class="caption">Start Date:  </b> <span> {$val.ssdate} </span> <span class="slash">-</span></li>

                                                                <li class="item inline-block"><b class="caption">End Date:  </b> <span> {$val.eedate} </span></li>

                                                                <li class="item"><b class="caption">Reccuring Quantity:  </b> <span> {$val.quantity} {$val.short_unit}</span></li>

                                                                <li class="item"><b class="caption">Payment Type : </b> 
                                                                <span>{if $val.cod==1}Cash on delivery{/if}{if $val.cod==0}Herbee coin{/if} </span>
                                                                </li>

                                                                <li class="item"><b class="caption">Price :  </b> <span> ${$val.bprice}/{$val.short_unit}</span></li>

                                                                <li class="item"><b class="caption">Frequency :  </b> <span>{$val.frequency}</span></li>

                                                                <a href="{$config.url}/dashboard/dbmarket/recuring/view/{$val.r_id}">
                                                                    <li class="item"><b class="caption">Number of transactions :  </b> <span>{if $val.r_status == 'approve'}
                                                                        {$val.current_position}/{/if}{$val.count}
                                                                    </span></li>
                                                                </a>
                                                                <div class="rating green-text">
                                                                  <b>Seller Rating:</b> <span class="stars" align="left">{$val.seller_rating}</span>
                                                                </div>
                                                            </ul>
                                                        </div>
                                                        <!-- <div class="col-sm-2">
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0 " data-record-rid="{$val.rid}" type="button" name="button" data-toggle="modal" data-target="#rec-cancel" >Approve</button>
                                                        </div>
                                                        <div class="col-sm-2">
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0 " data-record-rid="{$val.rid}" type="button" name="button" data-toggle="modal" data-target="#rec-cancel" >Cancel</button>
                                                        </div> -->
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                               {$val.description}
                                                            </p>
                                                            
                                                            <!-- <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button> -->
                                                        </div>
                                                        {if $val.r_status == 'approve'}
                                                        <div class="col-sm-12">
                                                            {if $val.current_r_date!=0}
                                                            <hr>
                                                            <div class="item" style="display: inline-block;width: 100%;padding: 3px 0px;">
                                                                <span style="float:left;margin:9px 0px;">Current product delivery date: {$val.current_r_date}</span>

                                                                {if $val.b_shipping_status == 0}
                                                                <button class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" id="shipping" type="button" name="button" onclick="confirmShipping({$val.b_id},{$val.b_shipping_status}, {$val.buyer_id})">Delivered</button>
                                                                {/if}
                                                                {if $val.b_shipping_status == 1}
                                                                <lable class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" type="button" name="button"  disabled>Delivered</lable>
                                                                {/if}
                                                                
                                                                {if $val.b_shipping_status == 0}
                                                                <h4 class="pull-right mr-10"><span id="timer_{$val.b_id}" class="timer_{$val.b_id} pull-right"></span></h4>
                                                                {/if}
                                                            </div>
                                                            {/if}
                                                            {if $val.next_r_date!=0}
                                                            <div class="item" style="display: inline-block;width: 100%;padding: 3px 0px;">
                                                                <span style="float:left;margin:9px 0px;">Next product delivery date: {$val.next_r_date}</span>

                                                                <lable class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" type="button" name="button"  disabled>Delivered</lable>
                                                                <h4 class="pull-right mr-10">72H : 00M : 00S</h4>
                                                            </div>
                                                            {/if}
                                                        </div>
                                                        {/if}
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                     {/foreach}
                                      {if $pagination < 1}
                                        <div class="row flex p15-0">
                                            <div class="col-sm-12 margin-auto p-r-0">
                                                <h2 class="text-center res-f12">No Records Found...!</h2>
                                            </div>
                                        </div>
                                    {/if}
                                     <div id="pagination">
                                    {$pagination_html}
                                </div>

                                </div>
                                <!-- / selling -->

                                <!-- / Sold -->

                                <!-- / Open Order -->
                            </div>
                        </div>
                        <div id="d-buyer" class="tab-pane buyer fade in">
                            <h3>BUYER Dashboard</h3>
                            <ul class="nav nav-pills super-sub-link">
                                <!-- <li class=""><a class="" data-toggle="pill" href="#d-accepted-order">Accepted Order <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li> -->
                                <li class=""><a class=""  href="{$config.url}/dashboard/dbmarket/">Purchases <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>
                                <li class=""><a class=""  href="{$config.url}/dashboard/dbmarket/recuring">Recurring Purchases <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>
                                <li class=""><a class=""  href="{$config.url}/dashboard/dbmarket/negotiation">Direct Buy Negotiations
                    <!-- <img src="images/negotiable-grey.png" style="display:inline-block; margin-right:6px; margin-top: -10px;" class="img-responsive" alt=""> -->
                  </a></li>
                                <!-- <li class=""><a class="" data-toggle="pill" href="#d-rejected-bids">Rejected Bids <img src="images/negotiable-grey.png" style="display:inline-block; margin-right:6px; margin-top: -10px;" class="img-responsive" alt=""></a></li> -->
                                <li class="active"><a class="" data-toggle="pill" href="#d-rejected-orders">Rejected Orders <img src="/images/negotiable-grey.png" style="display:inline-block; margin-right:6px; margin-top: -10px;" class="img-responsive" alt=""></a></li>
                            </ul>
                            <div class="tab-content super-tab-content">



                                <!-- / d-recurring -->

                                <!-- / d-Accecpted order-->

                                <!-- / d-buyer-open-type -->

                                <!-- / d-Rejected-bids -->
                                <div id="d-rejected-orders" class="tab-pane buyer fade in active">
                                 {foreach $myProducts as $key => $val}
                                    <div class="row flex p15-0">
                                        <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                                            <div class="product-thumb">
                                                <img src="{$config.imgpath}product/{$val.avatar}" class="img-responsive" alt="">
                                            </div>
                                        </div>
                                        <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                                            <ul class="p0">
                                                <li>
                                                    <div class="row">
                                                        <div class="col-md-6 col-sm-6">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span>{$val.title}</span></li>
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> $20/Unit</span></li>
                                                                <li class="item"><b class="caption">Price Offered</b> <span> $10/Unit</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> 20 </span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <span class="red">Your bid was rejected by the seller
                                <span class="slash">|</span>
                                                            </span>
                                                            <a class="w100" href="#viewMessage" data-toggle="modal" data-target="#viewMessage"> View Message</a>
                                                        </div>
                                                        <div class="col-xs-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                               {$val.description}
                                                            </p>
                                                            <hr>
                                                            <!-- <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button> -->
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>




                                     {/foreach}
                                     <div id="pagination">
                                    {$pagination_html}
                                </div>
                                </div>
                                <!-- / d-rejected-orders -->
                            </div>
                        </div>
                    </div>
                </div>
                 </div>
    </div>
    </div>
    </div>
    <!--/ Page content -->

    <div class="container">
    <!-- Rucurring purchase cancel -->
    <div class="modal reccuring-modal fade" id="cancellation_approval" role="dialog">
        <div class="modal-dialog modal-sm" style="width: 35% !important;">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <div class="panel panel-success">
                        <div class="panel-heading green-bg">
                            <h3>Are you sure ?</h3>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="srid" class="srid" name="srid" value="">
                    <h3>You want to cancel</h3>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default btn-d black-g btnrecurg" id="c_approve" type="button" name="button" data-toggle="modal" data-target="#">Confirm </button>
                </div>
            </div>
        </div>
    </div>
</div>


{include file="common/footer-1.tpl" nocache}

    <script type="text/javascript">

  $('#pagination').find('ul').addClass('pagination-ul flex m50 m-b-0');
  $('#pagination').find('ul').removeClass('pagination');
    </script>

       <script type="text/javascript">
        function acceptRequest(id){
            $('#accept_form'+id).submit();
        };
    </script>

    <script type="text/javascript">
        function viewMessage(rejtxt){
        $("#rej_msg").text(rejtxt);
        $("#viewMessage").modal();
    };
</script>

    <script type="text/javascript">
        function rejectRequest(id){
            $('#reject_form'+id).submit();
        };

        function approveCancellation(id){
            $('#cancel_form'+id).submit();
        };

        $('#cancellation_approval').on('show.bs.modal', function(e) {
            var data = $(e.relatedTarget).data();
           //console.log(data);
             $('.srid', this).val(data.recordSrid);
        });

        $('#c_approve').click(function() {
          /* if($(".btncheckrecur").prop('checked') == true){ */
           var rid = $('.srid').val();
            $.ajax({
              type : 'POST',
              dataType : 'json',
              url : '/product/reccancellation/approve',
              data : 'recur=1&rid='+rid,
              success : function(data) {
               //console.log(data);
                window.location.reload();

              }
            });

            /*}*/
        });

        {foreach $myProducts as $key => $val}
            setTimer({$val.b_id}, '{$val.b_timer}');

            function setTimer(id,et) {
                // var target_date = new Date(2017, 12, 23, 0, 0, 0);
                var current_date = new Date();
                var target_date  = new Date(et);

                //Create the countdown object
                var count = new Countdown(target_date, current_date);

                //Run the countdown
                count.countdown(function(obj) {
                    $('.timer_'+id).html(obj.thours+'H : '+obj.minutes+'M : '+obj.seconds+'S');
                });
            }
        {/foreach}

        function confirmShipping(inId, status, num){
            if(status == 0){
                $.ajax({
                    type: 'POST',
                    url: '/product/update/shippingstatus',
                    data: {
                        id : inId,
                        status: status+1,
                    },
                    dataType: 'json',
                    success: function(data) {
                        if (data == 1){
                            $('#shipping').prop('disabled','true');
                            $('#shipping').removeAttr("onclick");
                            $('#shipping').parent().find('.timer_').html('');
                            window.location = '{$config.url}/dashboard/buyer_performance/' + num+'/?buy_id='+inId;
                            // alert('Shipping status Changed');
                        }
                    }
                });
            } else {
                swal('Product already marked as shipped...!');
            }
        }
    </script>

</body>

</html>
