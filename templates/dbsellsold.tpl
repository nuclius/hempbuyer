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
                <div class="col-sm-7 col-xs-6 margin-auto w100-480">
                    <ul class="nav nav-pills nav-justified">
                        {if $loged.business_settings.open_bid == 1}<li ><a class="p20-15"  href="{$config.url}/dashboard/myrequests">Open Bid Market</a></li>{/if}
                        <li class="active"><a class="p20-15" data-toggle="pill" href="#direct-buy">Direct Buy Market</a></li>
                    </ul>
                </div>
                <div class="col-sm-5 col-xs-6 margin-auto w100-480">
                  <form enctype="multipart/form-data" method="get" enctype="multipart/form-data"
            action="{$config.url}/dashboard/seller/sold/">
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
                                {if $loged.business_settings.buy_db == 1}
                                <li class=""><a class="white"  href="{$config.url}/dashboard/dbmarket/">Buyer</a></li>
                                {/if}
                                <li class="active"><a class="white" data-toggle="pill" href="#d-seller">Seller</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="tab-content sub-tab-content">
                        <div id="d-seller" class="tab-pane buyer fade in active">
                            <h3>Seller Dashboard</h3>
                            <ul class="nav nav-pills super-sub-link">
                                <li class=""><a class=""  href="{$config.url}/dashboard/seller/selling">Products I'm Selling </a></li>
                                <li class="active"><a class=""  href="#d-sold"> Products I've Sold</a></li>
                                <li class=""><a class=""  href="{$config.url}/dashboard/seller/recuring">Recurring Purchases <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>
                                <!-- <li><a class="" data-toggle="pill" href="#d-ended">Ended</a></li> -->
                                <li><a class=""  href="{$config.url}/dashboard/seller/negotiation">Direct Buy Negotiations
                    <!-- <img src="images/negotiable-grey.png" style="display:inline-block; margin-right:6px; margin-top: -10px;" class="img-responsive" alt=""> -->
                  </a></li>

                  <li class=""><a class=""  href="{$config.url}/dashboard/seller/rejected">Rejected Proposals <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>
                   <li><a class=""  href="{$config.url}/dashboard/seller/inventory">Inventory <!-- <i class="icon flaticon-shopping-cart" aria-hidden="true"></i> --></a></li>
                   <li><a class=""  href="{$config.url}/dashboard/seller/inventorbyproduct">Inventory By Product</a></li>
              <!--     <li class=""><a class=""  href="{$config.url}/dashboard/seller/accepted">Accepted Proposals <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li> -->
                            </ul>
                            <div class="tab-content super-tab-content">

                                <!-- / selling -->
                                <div id="d-sold" class="tab-pane fade in active">

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
                                                                <li class="item"><a href="{$config.url}/product/view/{$val.id}"><b class="caption">Product Name : </b> <span> {$val.title}</span></a></li>
                                                                <li class="item"><b class="caption">Price :  </b> <span> ${$val.bprice}  / {$val.short_unit} </span></li>
                                                                <li class="item"><b class="caption">Quantity :  </b> <span> {$val.qty} {$val.units}</span></li>
                                                                <li class="item">
                                                                <b class="caption">Started Time : </b> <span> {$val.date_added} </span>
                                                                </li>
                                                                <li class="item">
                                                                    <div class="rating green-text">
                                                                        <b>Buyer Rating:</b> <span class="stars" align="left">{$val.buyer_rating}</span>
                                                                    </div>
                                                                </li>
                                                                {if $val.b_recurring ==1}
                                                                <a href="{$config.url}/dashboard/dbmarket/recuring/view/{$val.rid}">
                                                                    <li class="item"><b class="caption">Number of transactions :  </b> <span>
                                                                        {$val.current_position} of {$val.count}</span>
                                                                    </li>
                                                                </a>
                                                                {/if}
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <ul class="p0">
                                                             {if $val.b_recurring ==1}
                                                             <li class="item"><b class="caption">Purchase type : </b>Recurring</li>
                                                             {/if}
                                                             {if $val.negotiable ==1}
                                                             <li class="item"><b class="caption">Purchase type : </b>Negotiable</li>
                                                             {/if}
                                                             <li class="item"><b class="caption">Requested Quantity:  </b> <span> {$val.b_qty} {$val.units}</span></li>
                                                             <li class="item"><b class="caption">Payment Type : </b> 
                                                                <span>{if $val.cod==1}Cash on delivery{/if}{if $val.cod==0}Herbee coin{/if} </span>
                                                            </li>
                                                             {if $val.b_paid_status == 1}
                                                             <li class="item"><b class="caption">Paid Amount:  </b> <span> ${$val.b_total_amount} (${$val.bprice} / {$val.short_unit}) </span></li>
                                                              <li class="item"><b class="caption">Sales Tax : </b> <span> {$val.b_stax_per}%</span></li>
                                                              <li class="item"><b class="caption">Paid Date :  </b>
                                                                <span> {$val.b_paid_date} </span>
                                                               </li>
                                                             {/if}
                                                            </ul>
                                                            <ul class="p0">
                                                                {if $val.b_recurring ==1}

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

                                                        {if $val.b_paid_status == 1}
                                                        <div class="col-sm-12">
                                                            <hr>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button" disabled="true">Funds Released</button>
                                                            <a href="{$config.url}/dashboard/invoice/{$val.b_id}"><button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Receipt</button></a>

                                                            {if $val.b_shipping_status == 0}
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" id="shipping" type="button" name="button" onclick="confirmShipping({$val.b_id},{$val.b_shipping_status}, {$val.buyer_id})">Delivered</button>
                                                            {/if}
                                                            {if $val.b_shipping_status == 1}
                                                            <lable class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" type="button" name="button"  disabled>Delivered</lable>
                                                            {/if}
                                                            </div>
                                                        {/if}
                                                        {if $val.b_paid_status == 0}
                                                            <div class="col-sm-12">
                                                                <hr>
                                                                <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button" disabled="true">Payment Pending</button>
                                                                <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="payment_received" onclick="paymentReceived({$val.b_id})">Payment Received</button>
                                                            </div>
                                                        {/if}
                                                    </div>
                                                    {if $val.b_paid_status == 1}
                                                        {if $val.b_shipping_status == 0}
                                                        <div class=row>
                                                          <div class="col-sm-12 text-center">
                                                            <div class="green-txt mt-15">
                                                                    Product must be delivered within the time below.  Once delivered, click the Delivered button
                                                            </div>
                                                          </div>
                                                        </div>
                                                        <div class=row>
                                                            <div class="col-sm-12">
                                                              <div class="pull-right mt-5">
                                                              <h3><span id="timer_{$val.b_id}" class="timer_{$val.b_id}"></span></h3>
                                                              <!-- <b><strong></strong></b>     -->
                                                              </div>
                                                            </div>
                                                        </div>

                                                        {/if}
                                                    {/if}
                                                    {if $val.b_delivery_status == 1}
                                                        <div class=row>
                                                            <div class="col-sm-12 text-center">
                                                              <div class="green-txt mt-15">
                                                                      Product has been delivered
                                                              </div>
                                                            </div>
                                                        </div>
                                                    {/if}
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
                                <!-- / Sold -->
                                <!-- / ended -->
                                <!-- / Open Order -->
                            </div>
                        </div>
                    </div>
                </div>
                 </div>
    </div>
    </div>
    </div>
    <!--/ Page content -->
<div class="modal fade" id="shippinginfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
     <div class="modal-header"><h2 style="color: #000;font-size: 20px;font-weight: bold;">Shipping Details</h2></div>
     <div class="modal-body info-data"></div>
    </div>
  </div>

    </div>
{include file="common/footer-1.tpl" nocache}

    <script type="text/javascript">


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

    function paymentReceived(inId){
        $.ajax({
            type: 'POST',
            url: '/product/payment_received',
            data: {
                id : inId
            },
            dataType: 'json',
            success: function(data) {
                if (data.success == 1){
                    window.location.reload();
                }
            }
        });
    }

        function viewShippingInfo(cartid) {
    var params = {
        'id' : cartid
    }
    $.ajax({
        type : 'POST',
        url : '/product/shippinginfo',
        data : params,
        dataType : 'json',
        success : function(data) {
            $('#shippinginfo .info-data').html(data.html);
            $('#shippinginfo').modal();
        }
    });
}

function viewShippingTracking(cartid, buynowid) {
    var params = {
        'id' : cartid,
        'bid' : buynowid
    }
    $.ajax({
        type : 'POST',
        url : '/product/viewshippingtrackinfo',
        data : params,
        dataType : 'json',
        success : function(data) {
            $('#shippinginfo .info-data').html(data.html);
            $('#shippinginfo').modal();
        }
    });
}
function saveShippingInfo() {
    var params = $('#shipping-track-info').serialize();
   //console.log(params);
    $.ajax({
        type : 'POST',
        url : '/product/updateshippinginfo?' + params,
        data : params,
        dataType : 'json',
        success : function(data) {
            $('.modal').modal('hide');
            $(temp).remove();
            if (data.error) {
                window.location = '{$config.url}';
            } else {
                setTimeout(function() {
                    alert('Shipment Tracking Info Updated');
                }, 1000);
            }
        }
    });
}

function addShippingInfo(cartid, buynowid, obj) {
    var params = {
        'id' : cartid,
        'bid' : buynowid
    }
    temp = obj;
    $.ajax({
        type : 'POST',
        url : '/product/addshippinginfo',
        data : params,
        dataType : 'json',
        success : function(data) {
            $('#shippinginfo .info-data').html(data.html);
            $('#shippinginfo').modal();
        }
    });
}
  $('#pagination').find('ul').addClass('pagination-ul flex m50 m-b-0');
  $('#pagination').find('ul').removeClass('pagination');

</script>
</body>

</html>
