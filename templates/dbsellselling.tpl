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
            action="{$config.url}/dashboard/seller/selling/">
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
                                <li class="active"><a class="white"  href="#d-seller">Seller</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="tab-content sub-tab-content">
                        <div id="d-seller" class="tab-pane buyer fade in active">
                            <h3>Seller Dashboard</h3>
                            <ul class="nav nav-pills super-sub-link">
                                <li class="active"><a class="" data-toggle="pill" href="#d-selling">Products I'm Selling </a></li>
                                <li><a class=""  href="{$config.url}/dashboard/seller/sold"> Products I've Sold</a></li>
                                <!-- <li><a class="" data-toggle="pill" href="#d-ended">Ended</a></li> -->
                                <li class=""><a class=""  href="{$config.url}/dashboard/seller/recuring">Recurring Purchases <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>
                                <li><a class=""  href="{$config.url}/dashboard/seller/negotiation">Direct Buy Negotiations
                    <!-- <img src="images/negotiable-grey.png" style="display:inline-block; margin-right:6px; margin-top: -10px;" class="img-responsive" alt=""> -->
                  </a></li>

                  <li class=""><a class=""  href="{$config.url}/dashboard/seller/rejected">Rejected Proposals <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>
                  <li><a class=""  href="{$config.url}/dashboard/seller/inventory">Inventory <!-- <i class="icon flaticon-shopping-cart" aria-hidden="true"></i> --></a></li>
                  <li><a class=""  href="{$config.url}/dashboard/seller/inventorbyproduct">Inventory By Product</a></li>
                <!--   <li class=""><a class=""  href="{$config.url}/dashboard/seller/accepted">Accepted Proposals <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li> -->
                            </ul>
                            <div class="tab-content super-tab-content">
                                <div id="d-selling" class="tab-pane fade in active">
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
                                                        <div class="col-sm-10">
                                                            <ul class="p0">
                                                                <li class="item"><a class="black" href="{$config.url}/product/sview/{$val.id}"><b class="caption">Prodct Name : </b> <span> {$val.title}</span></a></li>
                                                                <li class="item"><b class="caption">Quantity Available :  </b> <span> {$val.qty} </span></li>
                                                                <li class="item"><b class="caption">Price :</b> <span> ${$val.unit_price}/{$val.units}</span></li>
                                                                <li class="item"><b class="caption">Unit of Measure :</b> <span> {$val.units}</span></li>
                                                                <!-- <li class="item"><b class="caption">Buyer ratng: </b>
                                                                <span>
                                                                   <i class="fa fa-star" aria-hidden="true"></i>
                                                                   <i class="fa fa-star" aria-hidden="true"></i>
                                                                   <i class="fa fa-star" aria-hidden="true"></i>
                                                                   <i class="fa fa-star" aria-hidden="true"></i>
                                                                   <i class="fa fa-star-o" aria-hidden="true"></i>
                                                                </span>
                                                                </li> -->
                                                                <li class="item"><b class="caption">Description: </b> <span>{$val.description}</span>

                                                            {if $val.test_result != '' && $val.cannabis_type == 'y'}
                                                            <li class="item"><b class="caption">View Test Result : </b> <span>
                                                              <a href="{$config.imgpath}testresult/{$val.test_result}" onclick="window.open(this.href); return false;"> {$val.test_result_img} <i class="fa fa-list icon"></i> </a>
                                                                <!-- <a href="#" download>File.pdf <i class="fa fa-download icon"></i> </a> -->
                                                              </span>
                                                              {/if}
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-2 text-right">
                                                            <a href="{$config.url}/dashboard/product/edit/{$val.id}"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                                                            <a href="{$config.url}/dashboard/product/delete/{$val.id}"><i class="fa fa-trash" aria-hidden="true"></i></a>
                                                        <!-- {if $val.sold == 0}
                                                           {if $val.countrecur == 0 && $val.countnego == 0}
                                                                
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
                                <!-- / selling -->
                                <div id="d-sold" class="tab-pane fade in">
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
                                                                <li class="item"><b class="caption">Quantity : </b> <span> 20</span></li>
                                                                <li class="item"><b class="caption">Paid Amount :  </b> <span> $1000 </span></li>
                                                                <!-- <li class="item"><b class="caption">Buyer ratng: </b>
                                                                    <span>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star-o" aria-hidden="true"></i>
                               </span>
                                                                </li> -->
                                                                <li class="item"><b class="caption">Paid Date : </b> <span> 05/09/17 @ 12:05pm</span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <hr>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Shipping Details</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Add Shipping Tracker Info</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Payment Released</button>
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
                                                                <li class="item"><b class="caption">Quantity : </b> <span> 20</span></li>
                                                                <li class="item"><b class="caption">Paid Amount :  </b> <span> $1000 </span></li>
                                                                <li class="item"><b class="caption">Buyer ratng: </b>
                                                                    <span>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star-o" aria-hidden="true"></i>
                               </span>
                                                                </li>
                                                                <li class="item"><b class="caption">Paid Date : </b> <span> 05/09/17 @ 12:05pm</span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <hr>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Shipping Details</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Add Shipping Tracker Info</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Payment Released</button>
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
                                                                <li class="item"><b class="caption">Quantity : </b> <span> 20</span></li>
                                                                <li class="item"><b class="caption">Paid Amount :  </b> <span> $1000 </span></li>
                                                                <li class="item"><b class="caption">Buyer ratng: </b>
                                                                    <span>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star-o" aria-hidden="true"></i>
                               </span>
                                                                </li>
                                                                <li class="item"><b class="caption">Paid Date : </b> <span> 05/09/17 @ 12:05pm</span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <hr>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Shipping Details</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Add Shipping Tracker Info</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Payment Released</button>
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
                                                                <li class="item"><b class="caption">Quantity : </b> <span> 20</span></li>
                                                                <li class="item"><b class="caption">Paid Amount :  </b> <span> $1000 </span></li>
                                                                <li class="item"><b class="caption">Buyer ratng: </b>
                                                                    <span>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star-o" aria-hidden="true"></i>
                               </span>
                                                                </li>
                                                                <li class="item"><b class="caption">Paid Date : </b> <span> 05/09/17 @ 12:05pm</span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <hr>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Shipping Details</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Add Shipping Tracker Info</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Payment Released</button>
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
                                                                <li class="item"><b class="caption">Quantity : </b> <span> 20</span></li>
                                                                <li class="item"><b class="caption">Paid Amount :  </b> <span> $1000 </span></li>
                                                                <li class="item"><b class="caption">Buyer ratng: </b>
                                                                    <span>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star-o" aria-hidden="true"></i>
                               </span>
                                                                </li>
                                                                <li class="item"><b class="caption">Paid Date : </b> <span> 05/09/17 @ 12:05pm</span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <hr>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Shipping Details</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Add Shipping Tracker Info</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Payment Released</button>
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
                                                                <li class="item"><b class="caption">Quantity : </b> <span> 20</span></li>
                                                                <li class="item"><b class="caption">Paid Amount :  </b> <span> $1000 </span></li>
                                                                <li class="item"><b class="caption">Buyer ratng: </b>
                                                                    <span>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star" aria-hidden="true"></i>
                                 <i class="fa fa-star-o" aria-hidden="true"></i>
                               </span>
                                                                </li>
                                                                <li class="item"><b class="caption">Paid Date : </b> <span> 05/09/17 @ 12:05pm</span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <hr>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Shipping Details</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Add Shipping Tracker Info</button>
                                                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Payment Released</button>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <!-- / Sold -->
                                <div id="d-ended" class="tab-pane fade in">
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
                                                                <li class="item"><b class="caption">Quantity Available for Bid  :  </b> <span> 20 </span></li>
                                                                <li class="item"><b class="caption">Sold :</b> <span> 10</span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                                                            </p>
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
                                                                <li class="item"><b class="caption">Quantity Available for Bid  :  </b> <span> 20 </span></li>
                                                                <li class="item"><b class="caption">Sold :</b> <span> 10</span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                                                            </p>
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
                                                                <li class="item"><b class="caption">Quantity Available for Bid  :  </b> <span> 20 </span></li>
                                                                <li class="item"><b class="caption">Sold :</b> <span> 10</span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                                                            </p>
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
                                                                <li class="item"><b class="caption">Quantity Available for Bid  :  </b> <span> 20 </span></li>
                                                                <li class="item"><b class="caption">Sold :</b> <span> 10</span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                                                            </p>
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
                                                                <li class="item"><b class="caption">Quantity Available for Bid  :  </b> <span> 20 </span></li>
                                                                <li class="item"><b class="caption">Sold :</b> <span> 10</span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                                                            </p>
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
                                                                <li class="item"><b class="caption">Quantity Available for Bid  :  </b> <span> 20 </span></li>
                                                                <li class="item"><b class="caption">Sold :</b> <span> 10</span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                                                            </p>
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
                                                                <li class="item"><b class="caption">Quantity Available for Bid  :  </b> <span> 20 </span></li>
                                                                <li class="item"><b class="caption">Sold :</b> <span> 10</span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                                                            </p>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <!-- / ended -->
                                <div id="d-open-order" class="tab-pane fade in">
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
                                                        <div class="col-sm-7">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> $20/Unit</span></li>
                                                                <li class="item"><b class="caption">Price Offered</b> <span> $10/Unit</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> 20 </span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <a class="w100" href="#"> Accept <span class="slash">|</span></a>
                                                            <a class="w100 red" href="#"> Reject<span class="slash">|</span></a>
                                                            <a class="w100 red" href="rejectMessage" data-toggle="modal" data-target="#rejectMessage"> Reject with Message <i class="fa fa-envelope" aria-hidden="true"></i></a>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                                                            </p>
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
                                                        <div class="col-sm-7">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> $20/Unit</span></li>
                                                                <li class="item"><b class="caption">Price Offered</b> <span> $10/Unit</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> 20 </span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <!-- <a class="w100" href="#"> Accept <span class="slash">|</span></a>
                            <a class="w100 red" href="#"> Reject<span class="slash">|</span></a>
                            <a class="w100 red" href="rejectMessage" data-toggle="modal" data-target="#rejectMessage"> Reject with Message <i class="fa fa-envelope" aria-hidden="true"></i></a> -->
                                                            <span> Order confirmed by the buyer</span>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                                                            </p>
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
                                                        <div class="col-sm-7">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> $20/Unit</span></li>
                                                                <li class="item"><b class="caption">Price Offered</b> <span> $10/Unit</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> 20 </span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <a class="w100" href="#"> Accept <span class="slash">|</span></a>
                                                            <a class="w100 red" href="#"> Reject<span class="slash">|</span></a>
                                                            <a class="w100 red" href="rejectMessage" data-toggle="modal" data-target="#rejectMessage"> Reject with Message <i class="fa fa-envelope" aria-hidden="true"></i></a>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                                                            </p>
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
                                                        <div class="col-sm-7">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> $20/Unit</span></li>
                                                                <li class="item"><b class="caption">Price Offered</b> <span> $10/Unit</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> 20 </span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <a class="w100" href="#"> Accept <span class="slash">|</span></a>
                                                            <a class="w100 red" href="#"> Reject<span class="slash">|</span></a>
                                                            <a class="w100 red" href="rejectMessage" data-toggle="modal" data-target="#rejectMessage"> Reject with Message <i class="fa fa-envelope" aria-hidden="true"></i></a>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                                                            </p>
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
                                                        <div class="col-sm-7">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> $20/Unit</span></li>
                                                                <li class="item"><b class="caption">Price Offered</b> <span> $10/Unit</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> 20 </span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <a class="w100" href="#"> Accept <span class="slash">|</span></a>
                                                            <a class="w100 red" href="#"> Reject<span class="slash">|</span></a>
                                                            <a class="w100 red" href="rejectMessage" data-toggle="modal" data-target="#rejectMessage"> Reject with Message <i class="fa fa-envelope" aria-hidden="true"></i></a>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                                                            </p>
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
                                                        <div class="col-sm-7">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> $20/Unit</span></li>
                                                                <li class="item"><b class="caption">Price Offered</b> <span> $10/Unit</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> 20 </span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <a class="w100" href="#"> Accept <span class="slash">|</span></a>
                                                            <a class="w100 red" href="#"> Reject<span class="slash">|</span></a>
                                                            <a class="w100 red" href="rejectMessage" data-toggle="modal" data-target="#rejectMessage"> Reject with Message <i class="fa fa-envelope" aria-hidden="true"></i></a>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                                                            </p>
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
                                                        <div class="col-sm-7">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> $20/Unit</span></li>
                                                                <li class="item"><b class="caption">Price Offered</b> <span> $10/Unit</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> 20 </span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <a class="w100" href="#"> Accept <span class="slash">|</span></a>
                                                            <a class="w100 red" href="#"> Reject<span class="slash">|</span></a>
                                                            <a class="w100 red" href="rejectMessage" data-toggle="modal" data-target="#rejectMessage"> Reject with Message <i class="fa fa-envelope" aria-hidden="true"></i></a>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                                                            </p>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
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

{include file="common/footer-1.tpl" nocache}

    <script type="text/javascript">

  $('#pagination').find('ul').addClass('pagination-ul flex m50 m-b-0');
  $('#pagination').find('ul').removeClass('pagination');

    </script>

</body>

</html>
