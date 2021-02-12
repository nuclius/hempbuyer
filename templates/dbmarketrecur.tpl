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
<style>
.mr-10{
    margin-right: 10px;
}
</style>
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
            action="{$config.url}/dashboard/dbmarket/recuring/">
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
                                {if $loged.business_type != 'dispensary'}
                                <li><a class="white"  href="{$config.url}/dashboard/seller/selling">Seller</a></li>
                                {/if}
                            </ul>
                        </div>
                    </div>
                    <div class="tab-content sub-tab-content">
                        <div id="d-buyer" class="tab-pane buyer fade in active">
                            <h3>BUYER Dashboard</h3>
                            <ul class="nav nav-pills super-sub-link">

                                <li class=""><a class=""  href="{$config.url}/dashboard/dbmarket/">Purchases <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>

                                <li class="active"><a class=""  href="{$config.url}/dashboard/dbmarket/recuring">Recurring Purchases <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>

                                <li class=""><a class=""  href="{$config.url}/dashboard/dbmarket/negotiation">Direct Buy Negotiations </a></li>

                                <li class=""><a class=""  href="{$config.url}/dashboard/dbmarket/rejectorder">Rejected Orders <img src="/images/negotiable-grey.png" style="display:inline-block; margin-right:6px; margin-top: -10px;" class="img-responsive" alt=""></a></li>
                            </ul>
                            <div class="tab-content super-tab-content">

                                <div id="d-reccuring" class="tab-pane buyer fade in active">
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
                                                        <div class="col-sm-8">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span> {$val.title}</span></li>
                                                                <li class="item"><b class="caption">Total Quantity:  </b> <span> {$val.qty} {$val.short_unit}</span></li>

                                                                <li class="item"><b class="caption">Quantity Available:  </b> <span> {$val.qty - $val.sold} {$val.short_unit}</span></li>

                                                                <li class="item inline-block"><b class="caption">Start Date:  </b> <span> {$val.sdate} </span> <span class="slash">-</span></li>

                                                                <li class="item inline-block"><b class="caption">End Date:  </b> <span> {$val.edate} </span></li>

                                                                <li class="item"><b class="caption">Recurring Quantity:  </b> <span> {$val.quantity} {$val.short_unit}</span></li>
                                                                <li class="item"><b class="caption">Price :  </b> <span> ${$val.bprice}/{$val.short_unit}</span></li>
                                                                <li class="item"><b class="caption">Payment Type : </b> 
                                                                    <span>{if $val.cod==1}Cash on delivery{/if}{if $val.cod==0}Herbee coin{/if} </span>
                                                                </li>
                                                                <li class="item"><b class="caption">Frequency :  </b> <span>{$val.frequency}</span></li>
                                                                <a href="{$config.url}/dashboard/dbmarket/recuring/view/{$val.rid}"><li class="item"><b class="caption">Number of transactions :  </b> <span>
                                                                    {if $val.r_status == 'approve'}
                                                                        {$val.current_position}/{/if}{$val.count}
                                                                </span></li></a>
                                                                <li class="item">
                                                                    <div class="rating green-text">
                                                                        <b>Seller Rating:</b> <span class="stars" align="left">{$val.seller_rating}</span>
                                                                    </div>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-4">
                                                        {if $val.r_status == 'approve'}
                                                             <a style="cursor: pointer;" class="w100" class="btn-link green"> Approved &nbsp;</a>
<!--                                                              {$val.cancelreq}
                                                             {$val.sapprove_status}
                                                             {$val.aapprove_status}
 -->                                                             {if $val.cancelreq == '1' && $val.sapprove_status == '0'}Cancel Request sent...{/if}
                                                             {if $val.cancelreq == '1' && $val.sapprove_status == '1' && $val.aapprove_status==0}Cancellation request sent to admin...{/if}
                                                             {if $val.cancelreq == '1' && $val.sapprove_status == '1' && $val.aapprove_status=='1'}Recurring Cancelled{/if}
                                                             {if $val.cancelreq == 0}<button class="btn btn-default btn-d-b green-b shadow-btn m0 " data-record-rid="{$val.rid}" type="button" name="button" data-toggle="modal" data-target="#rec-cancel" >Cancel</button>{/if}
                                                        {/if}                                                        {if $val.r_status == 'reject'}
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0 " data-record-rid="{$val.rid}" type="button" name="button" disabled="true">Rejected</button>
                                                        {/if}
                                                        {if $val.r_status == 'unverified'}
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0 " data-record-rid="{$val.rid}" type="button" name="button" disabled="true">Pending approval</button>
                                                        {/if}
                                                        </div>
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

                                                                {if $val.b_delivery_status == 0}
                                                                <button class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" id="shipping" type="button" name="button" onclick="confirmDelivery({$val.b_id},{$val.b_delivery_status}, {$val.seller_id}, {$val.id}, {$val.store_id})">
                                                                    Received
                                                                </button>
                                                                {/if}
                                                                {if $val.b_delivery_status == 1}
                                                                <lable class="btn btn-default btn-d-b green-b shadow-btn m0 pull-right" type="button" name="button" disabled>Received</lable>
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
                                <!-- / d-recurring -->
                                <div id="d-accepted-order" class="tab-pane fade">
                                 {foreach $myProducts3 as $key => $val}
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
                                                        <div class="col-sm-12">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span> {$val.title}</span></li>
                                                                <li class="item"><b class="caption">Quantity :  </b> <span> {$val.qty_request} </span></li>
                                                                <li class="item"><b class="caption">Price:  </b> <span> ${$val.unit_price}/{$val.units}</span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                 {$val.description}
                                                            </p>
                                                            <hr>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Pay</button>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                {/foreach}
                                </div>
                                <!-- / d-Accecpted order-->
                                <div id="d-buyer-open-type" class="tab-pane fade">
                                {foreach $myProducts3 as $key => $val}
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
                                                                <li class="item"><b class="caption">Product Name : </b> <span> {$val.title}</span></li>
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> $20/Unit</span></li>
                                                                <li class="item"><b class="caption">Price Offered</b> <span> $10/Unit</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> {$val.qty_request} </span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <span>Awaiting Seller Response <span class="slash">|</span></span>
                                                            <!-- <a class="w100 grey" href="" disabled> Confirm</a> -->
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                {$val.description}
                                                            </p>
                                                            <hr>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Pay</button>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                     {/foreach}
                                </div>
                                <!-- / d-buyer-open-type -->
                                <div id="d-rejected-bids" class="tab-pane fade">
                                    <div class="row flex p15-0">
                                        <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                                            <div class="product-thumb">
                                                <img src="images/hover-item.png" class="img-responsive" alt="">
                                            </div>
                                        </div>
                                        <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                                            <ul class="p0">
                                                <li>
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> $20/Unit</span></li>
                                                                <li class="item"><b class="caption">Price Offered</b> <span> $10/Unit</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> 20 </span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <span class="red">Your order Was rejected
                                <!-- <span class="slash">|</span> -->
                                                            </span>
                                                            <!-- <!-- <a class="w100" href="#"> Confirm</a> -->-->
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                                            </p>
                                                            <hr>
                                                            <!-- <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button> -->
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="row flex p15-0">
                                        <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                                            <div class="product-thumb">
                                                <img src="images/hover-item.png" class="img-responsive" alt="">
                                            </div>
                                        </div>
                                        <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                                            <ul class="p0">
                                                <li>
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> $20/Unit</span></li>
                                                                <li class="item"><b class="caption">Price Offered</b> <span> $10/Unit</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> 20 </span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <span class="red">Your order Was rejected
                                <!-- <span class="slash">|</span> -->
                                                            </span>
                                                            <!-- <!-- <a class="w100" href="#"> Confirm</a> -->-->
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                                            </p>
                                                            <hr>
                                                            <!-- <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button> -->
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="row flex p15-0">
                                        <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                                            <div class="product-thumb">
                                                <img src="images/hover-item.png" class="img-responsive" alt="">
                                            </div>
                                        </div>
                                        <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                                            <ul class="p0">
                                                <li>
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> $20/Unit</span></li>
                                                                <li class="item"><b class="caption">Price Offered</b> <span> $10/Unit</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> 20 </span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <span class="red">Your order Was rejected
                                <!-- <span class="slash">|</span> -->
                                                            </span>
                                                            <!-- <!-- <a class="w100" href="#"> Confirm</a> -->-->
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                                            </p>
                                                            <hr>
                                                            <!-- <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button> -->
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="row flex p15-0">
                                        <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                                            <div class="product-thumb">
                                                <img src="images/hover-item.png" class="img-responsive" alt="">
                                            </div>
                                        </div>
                                        <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                                            <ul class="p0">
                                                <li>
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> $20/Unit</span></li>
                                                                <li class="item"><b class="caption">Price Offered</b> <span> $10/Unit</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> 20 </span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <span class="red">Your order Was rejected
                                <!-- <span class="slash">|</span> -->
                                                            </span>
                                                            <!-- <!-- <a class="w100" href="#"> Confirm</a> -->-->
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                                            </p>
                                                            <hr>
                                                            <!-- <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button> -->
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="row flex p15-0">
                                        <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                                            <div class="product-thumb">
                                                <img src="images/hover-item.png" class="img-responsive" alt="">
                                            </div>
                                        </div>
                                        <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                                            <ul class="p0">
                                                <li>
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> $20/Unit</span></li>
                                                                <li class="item"><b class="caption">Price Offered</b> <span> $10/Unit</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> 20 </span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <span class="red">Your order Was rejected
                                <!-- <span class="slash">|</span> -->
                                                            </span>
                                                            <!-- <!-- <a class="w100" href="#"> Confirm</a> -->-->
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                                            </p>
                                                            <hr>
                                                            <!-- <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button> -->
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="row flex p15-0">
                                        <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                                            <div class="product-thumb">
                                                <img src="images/hover-item.png" class="img-responsive" alt="">
                                            </div>
                                        </div>
                                        <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                                            <ul class="p0">
                                                <li>
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> $20/Unit</span></li>
                                                                <li class="item"><b class="caption">Price Offered</b> <span> $10/Unit</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> 20 </span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <span class="red">Your order Was rejected
                                <!-- <span class="slash">|</span> -->
                                                            </span>
                                                            <!-- <!-- <a class="w100" href="#"> Confirm</a> -->-->
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                                            </p>
                                                            <hr>
                                                            <!-- <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button> -->
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <!-- / d-Rejected-bids -->
                                <div id="d-rejected-orders" class="tab-pane fade">
                                 {foreach $myProducts4 as $key => $val}
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

{include file="common/footer-1.tpl" nocache}
<script type="text/javascript">

    $(document).ready(function () {

        $('#rec-cancel').on('show.bs.modal', function(e) {
            var data = $(e.relatedTarget).data();
             $('.rid', this).val(data.recordRid);
        });
        $('.btnrecurg').click(function() {
          /* if($(".btncheckrecur").prop('checked') == true){ */
           var rid = $('.rid').val();
            $.ajax({
              type : 'POST',
              dataType : 'json',
              url : '/product/btncheckrecur',
              data : 'recur=1&rid='+rid,
              success : function(data) {
               //console.log(data);
                window.location.reload();

              }
            });

            /*}*/
        });

    });
    
    {foreach $myProducts as $key => $val}
        setDTimer({$val.b_id}, '{$val.b_timer}');

        function setDTimer(id,et) {
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
</script>
    <script type="text/javascript">

  $('#pagination').find('ul').addClass('pagination-ul flex m50 m-b-0');
  $('#pagination').find('ul').removeClass('pagination');

    </script>

</body>

</html>
