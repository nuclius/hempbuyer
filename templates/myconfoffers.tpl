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

    <div class="clearfix grey-bg xs-pdlr">
        <div class="container dashboard-con m50">
            <div class="row">
                <div class="col-sm-7 col-md-6 margin-auto">
                    <ul class="nav nav-pills nav-justified">
                        <li class="active"><a class="p20-15" data-toggle="pill" href="#open-bid">Open Bid Market</a></li>
                        <li><a class="p20-15"  href="{$config.url}/dashboard/dbmarket/">Direct Buy Market</a></li>
                    </ul>
                </div>
                <div class="col-sm-5 col-md-6 margin-auto mt-res-10">
                    <form enctype="multipart/form-data" method="get" enctype="multipart/form-data" action="{$config.url}/dashboard/mypurchase/all/">
                            <input class="p5-15 border1 input-radius search-input bg-transparent" placeholder="Search" type="text" style="border-color:#d4d4d4;" name="search" value="{$search.search}">
                            <button type="submit" class="input-radius green-b b search-btn">
                                <i class="fa fa-search white" aria-hidden="true"></i>
                            </button>
                </form>
                </div>
            </div>

            <div class="tab-content main-tab-content">
                <div id="open-bid" class="tab-pane fade in active white-bg">
                    <div class="panel panel-success">
                        <div class="panel-heading green-bg p0">

                        </div>
                    </div>
                    <div class="tab-content sub-tab-content">

                        <div id="buyer" class="tab-pane buyer fade in active">
                            {include file="common/dashboardob_menu.tpl" nocache}
                            <div class="tab-content super-tab-content">
                                <div id="#won" class="tab-pane fade in active">

                                    {foreach $myProducts as $key => $val}

                                    <div class="media">
                                        <div class="media-left product-thumb">
                                               {if $mypurchase == 1}
                                                    <div class="w100 green-bg p10 text-center tit-btn">
                                                        <span class="white">BUY</span>
                                                    </div>
                                               {/if}
                                               {if $mysale == 1}
                                                    <div class="w100 green-bg p10 text-center tit-btn">
                                                        <span class="white">SELL</span>
                                                    </div>
                                               {/if}

                                                {if $val.avatar == ''}
                                                     <img class="res-centering" src="{$config.url}/images/no_img.png" width="170px" class="img-responsive" alt="">
                                                {/if}
                                                {if $val.avatar != ''}
                                                     <img class="res-centering" src="{$config.imgpath}product/{$val.avatar}" width="170px" class="img-responsive" alt="">
                                                {/if}
                                            </div>
                                        <div class="media-body item-col margin-auto grey-bg">
                                            <ul class="p0">
                                                <li>
                                                    <div class="row">
                                                        <div class="col-md-6 col-sm-6">
                                                            <ul class="p0">
                                                                <li class="item"><a href="{$config.url}/product/view/{$val.id}"><b class="caption">Product Name : </b> <span> {$val.title}</span></a></li>
                                                                <li class="item"><b class="caption">Target Price :  </b> <span> ${$val.sprice}  / {$val.short_unit} </span></li>
                                                                <li class="item"><b class="caption">Quantity :  </b> <span> {$val.qty} {$val.units}</span></li>
                                                                <li class="item">
                                                                <b class="caption">Time : </b> <span> {$val.req_date} </span>
                                                                </li>
                                                                {if $mypurchase == 1}
                                                                <li class="item">
                                                                    <div class="rating green-text">
                                                                        <b>Seller Rating:</b> <span class="stars" align="left">{$val.seller_rating}</span>
                                                                    </div>
                                                                </li>
                                                                {/if}
                                                                
                                                                <!-- ===================== start change by divyesh (changes) ===================== -->
                                                                {if ($val.ue_stax=='y') && ($val.p_trading_type == 'buy')}
                                                                    <li class="item"><b class="caption">Sales Tax : </b> <span> {$val.ue_stax_per}%</span></li>
                                                                {/if}
                                                                <!-- ===================== end change by divyesh (changes) ===================== -->
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <ul class="p0">
                                                             <li class="item"><b class="caption">Quantity Offered:  </b> <span> {$val.req_qty} {$val.units}</span></li>
                                                             <li class="item"><b class="caption">Price Offered:  </b> <span> ${$val.req_amount * $val.req_qty} (${$val.req_amount} / {$val.short_unit}) </span></li>

                                                             <!-- ===================== start change by divyesh (changes) ===================== -->
                                                            <!-- <li class="item"><b class="caption">Sales Consultant Fee : </b> <span> {$val.consultant_fee}%</span></li> -->
                                                            <!-- ===================== end change by divyesh (changes) ===================== -->
                                                             <li class="item"><b class="caption">Accepted at : </b> <span> {$val.req_accepted_date} </span></li>
                                                                {if $val.req_test_result != ''}
                                                                <li class="item">
                                                                 <a href="{$config.imgpath}testresult/{$val.req_test_result}" onclick="window.open(this.href); return false;">
                                                                 <b class="caption">View Test Result </b>
                                                                <i class="fa fa-list icon"></i> </a>
                                                                </li>
                                                                {/if}
                                                                {if $val.buynow_id && $val.paid_status == 1}
                                                                    <li class="item"><b class="caption">Order Status : </b> <span>{if $val.order_status}{$val.order_status}{else\}not yet shipped{/if}</span></li>
                                                                {/if}
                                                            </ul>

                                                        </div>
                                                        <div class="col-xs-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                {$val.description}
                                                            </p>
                                                            <hr>
                                                            {if $mypurchase == 1}
                                                                {if $val.paid_status == 1}
                                                                    <lable class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button" data-toggle="modal" data-target="#deliveryDetails">
                                                                        Delivery Details
                                                                    </lable>
                                                                {/if}
                                                                {if $val.paid_status != 1}
                                                                <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button" onclick="window.location = '{$config.url}/product/payment/{$val.buynow_id}'" >Pay</button>
                                                                {/if}
                                                            {/if}
                                                            {if $mysale == 1}
                                                                {if $val.paid_status == 1}
                                                                    {if $val.behalf_cc_id > 0}
                                                                        <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">
                                                                            Cash Payment
                                                                        </button>
                                                                    {/if}
                                                                    {if $val.behalf_cc_id < 1}
                                                                        <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">
                                                                            Funds Released
                                                                        </button>
                                                                    {/if}
                                                                    

                                                                    
                                                                {/if}
                                                                {if $val.paid_status != 1}
                                                                <lable class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button" disabled>Payment Pending</lable>
                                                                {/if}

                                                            {/if}


                                                            {if $val.buynow_id && $val.paid_status == 1}
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button" onclick="window.location = '{$config.url}/dashboard/invoice/{$val.buynow_id}'">View Receipt</button>
                                                            {/if}

                                                             {if $mypurchase == 1 && $val.paid_status == 1}
                                                            <!-- {$loged.userid}
                                                            {$val.buyer_id}
                                                            {$val.seller_id}{$val.buynow_id} -->
                                                                {if $loged.userid == $val.i_user_id}
                                                                    {if $val.i_shipping_status == 0}
                                                                    <button class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" id="shipping" type="button" name="button" onclick="confirmShipping({$val.buynow_id},{$val.i_shipping_status}, {$val.buyer_id})">Delivered</button><!-- <button class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" id="shipping" type="button" name="button" onclick="confirmShipping({$val.i_id},{$val.i_shipping_status}, {$val.seller_id})">Delivered</button> -->
                                                                    {/if}
                                                                    {if $val.i_shipping_status == 1}
                                                                    <lable class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" type="button" name="button" disabled>Delivered</lable>
                                                                    {/if}
                                                                {/if}

                                                                {if $loged.userid != $val.i_user_id}
                                                                    {if $val.i_shipping_status == 1}
                                                                        {if $val.i_delivery_status == 0}
                                                                        <button class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" type="button" id="delivery" name="button" onclick="confirmDelivery({$val.buynow_id},{$val.i_delivery_status},{$val.buyer_id},{$val.id})">Received</button>
                                                                        <!-- <button class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" type="button" id="delivery" name="button" onclick="confirmDelivery({$val.i_id},{$val.i_delivery_status},{$val.buyer_id},{$val.id})">Received</button> -->
                                                                        {/if}
                                                                        {if $val.i_delivery_status == 1}
                                                                       <lable class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" type="button" name="button"  disabled>Received</lable>
                                                                        {/if}
                                                                    {/if}
                                                                {/if}
                                                            {/if}

                                                            {if $mysale == 1}
                                                                {if $loged.userid != $val.i_user_id && $val.paid_status == 1}
                                                                    {if $val.i_shipping_status == 0}
                                                                    <button class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" id="shipping" type="button" name="button" onclick="confirmShipping({$val.buynow_id},{$val.i_shipping_status}, {$val.seller_id})">Delivered</button>
                                                                    {/if}
                                                                    {if $val.i_shipping_status == 1}
                                                                    <lable class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" type="button" name="button"  disabled>Delivered</lable>
                                                                    {/if}
                                                                {/if}

                                                                {if $loged.userid == $val.i_user_id && $val.paid_status == 1}
                                                                    {if $val.i_shipping_status == 1}
                                                                        {if $val.i_delivery_status == 0}
                                                                        <button class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" type="button" id="delivery" name="button" onclick="confirmDelivery({$val.buynow_id},{$val.i_delivery_status}, {$val.seller_id})">Received</button>
                                                                        {/if}
                                                                        {if $val.i_delivery_status == 1}
                                                                        <lable class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" type="button" name="button"  disabled>Received</lable>
                                                                        {/if}
                                                                    {/if}
                                                                {/if}
                                                            {/if}

                                                            <!-- {$val.i_paid_date} -->
                                                            {if $mysale == 1}
                                                                {if $val.paid_status == 1 && $val.i_shipping_status == 0}
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

                                                                      <h3><span id="timer_{$val.buynow_id}" class="timer_{$val.buynow_id}"></span></h3>
                                                                      <!-- <b><strong></strong></b>     -->
                                                                      </div>
                                                                    </div>
                                                                </div>

                                                                {/if}
                                                            {/if}

                                                            {if $mypurchase == 1}
                                                                {if $val.paid_status == 1 && ($val.i_delivery_status == 0 && $val.i_shipping_status == 1)}

                                                                <div class="row">
                                                                    <div class="col-sm-12">
                                                                      <div class="pull-right green-txt mt-5">
                                                                              Thanks for your purchase.  You can view your order by hitting the View Invoice button.  Your product will be delivered to your listed shipping address within 72 hours.  If product is not received in 72 hours, please advise Herbee.
                                                                          </div>
                                                                    </div>
                                                                    </div>
                                                                <div class=row>
                                                                    <div class="col-sm-12">
                                                                      <div class="pull-right mt-5">

                                                                      <h3><span id="dtimer_{$val.buynow_id}" class="dtimer_{$val.buynow_id}"></span></h3>
                                                                      <!-- <b><strong></strong></b>     -->
                                                                      </div>
                                                                    </div>
                                                                </div>
                                                                {/if}

                                                            {/if}
<!--                                                             <span id="days"></span>/
                                                            <span id="hours"></span>/
                                                            <span id="minutes"></span>/
                                                            <span id="seconds"></span> -->
                                                            <!-- <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button" data-toggle="modal" data-target="#shippinginfo">View Shipping Tracking</button> -->
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                    {/foreach}

                                    {if $pagination < 1}
                                       <h2 class="text-center res-f12">No Records Found...!</h2>
                                    {/if}

                                </div>

                            </div>
                        </div>
                    </div>
                </div>
             </div>
            <div id="pagination">
                {$pagination_html}
            </div>

        </div>
    </div>

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
</div>

    </div>
    </div>
    <!--/ Page content -->

{include file="common/footer-1.tpl" nocache}

    <script type="text/javascript">
        function acceptRequest(id){
            $('#accept_form'+id).submit();
        };
    </script>
    <script type="text/javascript">
        function rejectRequest(id){
            $('#reject_form'+id).submit();
        };
    </script>

    <script type="text/javascript">

      $('#pagination').find('ul').addClass('pagination-ul flex m50 m-b-0');
      $('#pagination').find('ul').removeClass('pagination');

    </script>

    <script>
 /* Timer started here */
    {foreach $myProducts as $key => $val}
        {if $mysale == 1}
            setTimer({$val.buynow_id}, '{$val.confirmed_timer}');

            function setTimer(id,et) {
                console.log('id,et', id,et);

                // var target_date = new Date(2017, 12, 23, 0, 0, 0);
                var current_date = new Date();
                var target_date  = new Date(et);

                //Create the countdown object
                var count = new Countdown(target_date, current_date);

                //Run the countdown
                count.countdown(function(obj) {
                    $('#timer_'+id).html(obj.thours+'H : '+obj.minutes+'M : '+obj.seconds+'S');
                });

            }
        {/if}

        {if $mypurchase == 1}
            setDTimer({$val.buynow_id}, '{$val.bn_del_timer}');

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
        {/if}
    {/foreach}



    /* END timer here */

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
                        window.location = '{$config.url}/dashboard/buyer_performance/' + num;
                        // alert('Shipping status Changed');
                    }

                }

            });
        } else {
            swal('Product already marked as shipped..');
        }

    }

    function confirmDelivery(inId, status, num, pid){
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
                        window.location = '{$config.url}/dashboard/seller_performance/' + num+'/' + pid;
                        // alert('Shipping status Changed');
                    }
                }

            });
        } else {

            swal('Product already marked as delivered...!');
        }
        }

    </script>

</body>

</html>

<!-- <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/owl.carousel.min.js"> -->
