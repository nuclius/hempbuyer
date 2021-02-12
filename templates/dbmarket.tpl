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

{include file="common/dashboard-navigation.tpl" nocache}

    <div class="container-fluid grey-bg xs-pdlr">
        <div class="container dashboard-con m50">
            <div class="row flex">
                <div class="col-md-6 col-sm-7 margin-auto">
                    <ul class="nav nav-pills nav-justified">
                        {if $loged.business_settings.open_bid == 1}
                        <li ><a class="p20-15"  href="{$config.url}/dashboard/myrequests">Open Bid Market</a></li>
                        {/if}
                        <li class="active"><a class="p20-15" data-toggle="pill" href="#direct-buy">Direct Buy Market</a></li>
                    </ul>
                </div>
                <div class="col-md-6 col-sm-5 margin-auto">
                    <form enctype="multipart/form-data" method="get" enctype="multipart/form-data"
            action="{$config.url}/dashboard/dbmarket/">
                    <div class="row flex">
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
                                <li class="active"><a class="white" data-toggle="pill" href="#d-buyer">Buyer</a></li>
                                {if $loged.business_type != 'dispensary'}
                                <li><a class="white"  href="{$config.url}/dashboard/seller/selling">Seller</a></li>
                                {/if}
                            </ul>
                        </div>
                    </div>
                    <div class="tab-content sub-tab-content">
                        <div id="d-seller" class="tab-pane buyer fade in">
                            <h3>Seller Dashboard</h3>
                            <ul class="nav nav-pills super-sub-link">
                                <li class="active"><a class="" data-toggle="pill" href="#d-selling">Products I'm Selling </a></li>
                                <li><a class="" data-toggle="pill" href="#d-sold"> Products I've Sold</a></li>
                                <li><a class="" data-toggle="pill" href="#d-open-order">Direct Buy Negotiations
                  </a></li>
                            </ul>
                        </div>
                        <div id="d-buyer" class="tab-pane buyer fade in active">
                            <h3>BUYER Dashboard</h3>
                            <ul class="nav nav-pills super-sub-link">
                                <li class="active"><a class="" data-toggle="pill" href="#d-buynow">Purchases <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>
                                <li class=""><a class=""  href="{$config.url}/dashboard/dbmarket/recuring">Recurring Purchases <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>
                                <li class=""><a class=""  href="{$config.url}/dashboard/dbmarket/negotiation">Direct Buy Negotiations
                  </a></li>

                                <li class=""><a class=""  href="{$config.url}/dashboard/dbmarket/rejectorder">Rejected Orders <img src="/images/negotiable-grey.png" style="display:inline-block; margin-right:6px; margin-top: -10px;" class="img-responsive" alt=""></a></li>
                            </ul>
                            <div class="tab-content super-tab-content">
                                <br>
                                <div class="row">
                                    <div class="col-sm-1 col-md-1 col-xs-4">
                                        <label style="padding-top: 5px;">Filter By:</label>
                                    </div>
                                    <div class="col-sm-2 col-md-2 col-xs-4">
                                        <form id="filterSearchForm" enctype="multipart/form-data" method="get" enctype="multipart/form-data" action="{$config.url}/dashboard/dbmarket/">
                                            <select name="filter" id="filter_search" class="form-control" onchange="filterPurchased()">
                                                <option value="">All</option>
                                                <option value="received" {if $filter=='received'}selected{/if}>Received</option>
                                                <option value="recurring" {if $filter=='recurring'}selected{/if}>Recurring</option>
                                                <option value="cod_paid" {if $filter=='cod_paid'}selected{/if}>COD paid</option>
                                            </select>
                                        </form>
                                    </div>
                                </div>
                                <br>

                                <div id="d-buynow" class="tab-pane fade in active">
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
                                                        <div class="col-sm-6">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">
                                                                Product Name : </b> <span> {$val.title}</span></li>
                                                                <!-- <li class="item"><b class="caption">Quantity :  </b> <span> {$val.qty} {$val.units}</span></li> -->
                                                                <li class="item"><b class="caption">Price :  </b> <span> ${$val.bprice}/{$val.short_unit}</span></li>
                                                                <li class="item"><b class="caption">Payment Type : </b> 
                                                                <span>{if $val.cod==1}Cash on delivery{/if}{if $val.cod==0}Herbee coin{/if} </span>
                                                                </li>
                                                                {if $val.b_paid_status == 1}            
                                                                    <li class="item"><b class="caption">Requested Quantity :  </b> 
                                                                    <span> {$val.b_qty} </span>
                                                                    </li>
                                                                    <li class="item"><b class="caption">Paid Date :  </b> 
                                                                    <span> {$val.b_paid_date} </span>
                                                                    </li>
                                                                    <li class="item"><b class="caption">Paid Amount :  </b> 
                                                                    <span> ${$val.b_total_amount} / {$val.short_unit} </span>
                                                                    </li>
                                                                    
                                                                    {if $val.count}
                                                                    <li class="item"><b class="caption">Frequency :  </b> <span>{$val.frequency}</span></li>
                                                                        <!-- <a href="{$config.url}/dashboard/dbmarket/recuring/view/{$val.rid}">
                                                                            <li class="item"><b class="caption">Number of transactions :  </b> <span>
                                                                                {if $val.r_status == 'approve'}{$val.current_position}/{/if}{$val.count}
                                                                            </li>
                                                                        </a> -->
                                                                    {/if}
                                                                    {if $val.b_order_status}
                                                                    <li class="item"><b class="caption">Shipping Status :  </b> 
                                                                    <span>
                                                                        {if $val.b_order_status == 'ready_to_ship'}Product ready to ship{/if}
                                                                        {if $val.b_order_status == 'received'}Product received for shipping{/if}
                                                                        {if $val.b_order_status == 'picked_up'}Product picked up for shipping{/if}
                                                                        {if $val.b_order_status == 'arrived'}Product arrived for shipping{/if}
                                                                        {if $val.b_order_status == 'departed'}Product departed for shipping{/if}
                                                                        {if $val.b_order_status == 'onsite'}Product onsite for shipping{/if}
                                                                        {if $val.b_order_status == 'waiting'}Product waiting for shipping{/if}
                                                                        {if $val.b_order_status == 'delivered'}Product delivered{/if}
                                                                        {if $val.b_order_status == 'undeliverable'}Product undeliverable{/if}
                                                                        {if $val.b_order_status == 'canceled'}Shipping has been canceled{/if}
                                                                    </span>
                                                                    </li>
                                                                    {/if}

                                                                    <li class="item">
                                                                        <div class="rating green-text">
                                                                            <b>Seller Rating:</b> <span class="stars" align="left">{$val.seller_rating}</span>
                                                                        </div>
                                                                    </li>
                                                                    {if $val.b_recurring ==1}
                                                                    <a href="{$config.url}/dashboard/dbmarket/recuring/view/{$val.rid}">
                                                                        <li class="item"><b class="caption">Number of transactions :  </b> <span>
                                                                            {$val.current_position} of {$val.count}</span>
                                                                        </li>
                                                                    </a>
                                                                    {/if}
                                                                {/if}
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <ul class="p0">
                                                                {if $val.b_recurring ==1}
                                                                    <li class="item"><b class="caption">Purchase type : </b>Recurring</li>
                                                                    {if $val.b_cancel_ins_status == 1}
                                                                        <li class="item"><b class="caption">Cancellation Insurance : </b> Yes
                                                                        </li>
                                                                        <li class="item"><b class="caption">Cancellation Insurance(%) : </b> {$val.b_cancel_ins_per}%
                                                                        </li>
                                                                        <li class="item"><b class="caption">Cancellation Insurance($) : </b> ${$val.b_cancel_ins_amt}
                                                                        </li>
                                                                        {if $val.b_reserve_amt > 0}
                                                                            <li class="item"><b class="caption">Reserve amount($) : </b> ${$val.b_reserve_amt}
                                                                            </li>
                                                                        {/if}
                                                                    {/if}
                                                                    {if $val.b_cancel_ins_status == 0}
                                                                        <li class="item"><b class="caption">Cancellation Insurance : </b> No
                                                                        </li>
                                                                    {/if}
                                                                        <li class="item"><b class="caption">Sales Tax(%) : </b> {$val.b_stax_per} %
                                                                        </li>
                                                                        <li class="item"><b class="caption">Sales Tax($) : </b> ${$val.b_stax_amt}
                                                                        </li>
                                                                        <li class="item"><b class="caption">Herbee fee(%) : </b> {$val.b_commission_per} %
                                                                        </li>
                                                                        <li class="item"><b class="caption">Herbee fee($) : </b> ${$val.b_commission_amt}
                                                                        </li>
                                                                    {if $val.b_cancel_ins_status == 0}
                                                                        <li class="item"><b class="caption">Cancellation Insurance : </b> No
                                                                        </li>
                                                                    {/if}
                                                                {/if}
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                {$val.description}
                                                            </p>
                                                            <hr>

                                                            {if $val.b_paid_status == 1}
                                                            <lable class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button" data-toggle="modal" data-target="#deliveryDetails">
                                                                        Delivery Details
                                                            </lable>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button" onclick="window.location = '{$config.url}/dashboard/invoice/{$val.b_id}'">View Receipt</button>
                                                            {/if}
                                                            <!--  && $val.b_shipping_status == 1 -->
                                                            {if $val.b_paid_status == 1}
                                                                {if $val.b_delivery_status == 0}
                                                                <button class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" id="shipping" type="button" name="button" onclick="confirmDelivery({$val.b_id},{$val.b_delivery_status}, {$val.seller_id}, {$val.id}, {$val.store_id})">
                                                                    Received
                                                                </button>
                                                                {/if}
                                                                {if $val.b_delivery_status == 1}
                                                                <lable class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" type="button" name="button" disabled>Received</lable>
                                                                {/if}
                                                                <!--  && $val.b_shipping_status == 1 -->
                                                                {if $val.b_delivery_status == 0}
                                                                    <div>
                                                                        <div class="pull-right green-txt">
                                                                            Thanks for your purchase.  You can view your order by hitting the View Invoice button.  Your product will be delivered to your listed shipping address within 72 hours.  If product is not received in 72 hours, please advise Herbee.
                                                                        </div>
                                                                    </div>
                                                                    
                                                                    <div class="">
                                                                        <div class="pull-right">

                                                                        <h3><span id="dtimer_{$val.b_id}" class="dtimer_{$val.b_id}"></span></h3>
                                                                        </div>
                                                                    </div>
                                                                {/if}
                                                            {/if}
                                                            {if $val.b_paid_status == 0}
                                                                <div class="col-sm-12">
                                                                    <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button" disabled="true">Payment Pending</button>
                                                                </div>
                                                            {/if}

                                                            <!-- {if $val.b_paid_status == 1}
                                                                {if $val.b_shipping_status == 0}
                                                                <div class=row>
                                                                    <div class="col-sm-12">
                                                                      <div class="pull-right mt-5">
                                                                      <h3><span id="timer_{$val.b_id}" class="timer_{$val.b_id}"></span></h3>
                                                                      </div>
                                                                    </div>
                                                                </div>
        
                                                                {/if}
                                                            {/if} -->

                                                        </div>
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
                            </div>
                        </div>
                    </div>
                </div>
                 </div>
    </div>
    </div>
    </div>
    <!--/ Page content -->
<div class="modal reccuring-modal fade" id="deliveryDetails" role="dialog">
        <div class="modal-dialog modal-sm" style="width: 35% !important;">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <div class="panel panel-success">
                        <div class="panel-heading green-bg">
                            <h3>Thanks for your purchase...!</h3>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <p class="description">
                        Thanks for your purchase.  You can view your order by hitting the View Receipt button.  Your product will be delivered to your listed shipping address within 72 hours.  If product is not received in 72 hours, please advise Herbee.
                    </p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default btn-d black-g btnrecurg" type="button" name="button" data-toggle="modal" data-target="#deliveryDetails">Close</button>
                </div>
            </div>
        </div>
    </div>
{include file="common/footer-1.tpl" nocache}

    <script type="text/javascript">

    {foreach $myProducts as $key => $val}
        setTimer({$val.b_id}, '{$val.bid_timer}');
        function setTimer(id,et) {
            console.log('id,et', id,et);
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

  $('#pagination').find('ul').addClass('pagination-ul flex m50 m-b-0');
  $('#pagination').find('ul').removeClass('pagination');


  /* Timer started here */

    {foreach $myProducts as $key => $val}
    
        setDTimer({$val.b_id}, '{$val.bid_timer}');

        function setDTimer(id,et) {

            // var target_date = new Date(2017, 12, 23, 0, 0, 0);
            var current_date = new Date();
            var target_date  = new Date(et);

            //Create the countdown object
            var count = new Countdown(target_date, current_date);

            //Run the countdown
            count.countdown(function(obj) {
                $('#dtimer_'+id).html(obj.thours+'H : '+obj.minutes+'M : '+obj.seconds+'S');
            });

        }

    {/foreach}



    /* END timer here */
    function confirmDelivery(inId, status, num, pid, sid){
        if(status == 0){
            $.ajax({
                type: 'POST',
                url: '/product/update/deliverystatus',
                data: {
                    id : inId,
                    status: status+1,
                },
                dataType: 'json',
                success: function(data) {
                    if (data == 1){
                        $('#delivery').prop('disabled','true');
                        $('#delivery').removeAttr("onclick");
                        window.location = '{$config.url}/dashboard/seller_performance/' + num+'/' + pid + '/' + sid+'/?buy_id='+inId;
                        // alert('Shipping status Changed');
                    }
                }

            });
        }  else {

            swal('Product already marked as delivered...!');
        }

    }

    function filterPurchased() {
        $("#filterSearchForm").submit();
        // var value = $("#filter_search").val();
        // console.log('{$fquery}');
        // window.location = '{$config.url}/dashboard/dbmarket/?search=&page=' + value+'/' + pid + '/' + sid+'/?buy_id='+inId;
    }
</script>
</body>
</html>
