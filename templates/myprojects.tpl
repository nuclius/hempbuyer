
{include file="common/header-1.tpl" nocache}


<!-- Page content -->

<div class="container-fluid bgBannerFluid">
    <h1>Dashboard</h1>
        <div class="row">
            <div class="col-sm-12 confLinkCol">


                <ul>
                  <a href="{$config.url}/market/selection"><li>
                    <!-- <span class="icon flaticon-auction"></span> -->
                    Market Selection</li></a>
                  <a href="open-bid-market.html"><li><span class="icon flaticon-auction"></span>Open Market</li></a>
                  <a href="directbuy.html"><li><span class="icon flaticon-shopping-cart"></span>Direct Market</li></a>
                  <a href="store-view.html"><li><span class="flaticon-business icon"></span>My Store</li></a>
                  <a href="#"><li><img src="{$config['url']}/images/ads.png" alt="">Advertising </li></a>
                  <a href="#"><li><span class="icon flaticon-research-work"></span>Research</li></a>

                  <li style="position:relative">
                    <button class="dropdown-toggle" type="button" id="menu1" data-toggle="dropdown"><i class="flaticon-settings"></i>Settings
                    <span class="caret"></span></button>
                    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">

                    <li role="presentation"><a role="menuitem" tabindex="-1" href="dashboard-profile.html">Profile</a></li>
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Messages</a></li>
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Payments</a></li>
                     <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Contact information</a></li>
                     <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Password changes</a></li>
                     <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Shipping address changes</a></li>
                     <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Billing and Account information</a></li>
                     <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Notifications</a></li>
                     <!-- <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Open Bid Market</a></li>
                     <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Direct Buy Market</a></li> -->

                    </ul>
                  </li>

                </ul>
            </div>
        </div>
</div>

<div class="container-fluid grey-bg xs-pdlr">

    <div class="container dashboard-con m50">

        <div class="row flex">

            <div class="col-sm-7 col-md-6 margin-auto">
              <ul class="nav nav-pills nav-justified">

                <li class="active"><a class="p20-15" data-toggle="pill" href="#open-bid">Open Bid Market</a></li>
                <li><a class="p20-15" data-toggle="pill" href="#direct-buy">Direct Buy Market</a></li>

              </ul>
            </div>

            <div class="col-sm-5 col-md-6 margin-auto mt-res-10">
                 <div class="row flex">
                   <div class="col-md-6 col-sm-8">
                     <div class="row">

                       <div class="col-sm-6">
                         <label style="margin-bottom:2px;" for="">Transactions</label>
                         <div class="input-group">
                          <input type="text" class="form-control" placeholder="From">
                          <span class="input-group-addon" id="basic-addon2"><i class="fa fa-calendar" aria-hidden="true"></i></span>
                        </div>
                       </div>

                       <div class="col-sm-6">
                          <label for="" style="opacity:0;margin-bottom:2px;">Transactions</label>
                         <div class="input-group">
                          <input type="text" class="form-control" placeholder="To">
                          <span class="input-group-addon" id="basic-addon2"><i class="fa fa-calendar" aria-hidden="true"></i></span>
                        </div>

                       </div>

                     </div>
                   </div>
                  <div class="col-md-12 col-sm-12 text-right margin-auto m-b-0">
                   <input class="p5-15 border1 input-radius search-input bg-transparent" placeholder="Search" type="text" style="border-color:#d4d4d4;" name="" value="">
                   <button type="button" name="button" class="input-radius green-b b search-btn">
                       <i class="fa fa-search white" aria-hidden="true"></i>
                   </button>
                  </div>
                 </div>
            </div>

        </div>

      <div class="tab-content main-tab-content">

        <div id="open-bid" class="tab-pane fade in active white-bg">

         <div class="panel panel-success">
           <div class="panel-heading green-bg p0">

            <ul class="nav nav-pills sub-link">

              <li class="active"><a class="white" data-toggle="pill" href="#buyer">Buyer</a></li>
              <li><a class="white" data-toggle="pill" href="#seller">Seller</a></li>
              <li class="pull-right"><a class="white" href="#" download><i class="fa fa-download icon" aria-hidden="true"></i> Download info</a></li>

            </ul>

           </div>
         </div>

         <div class="tab-content sub-tab-content">

           <div id="seller" class="tab-pane buyer fade in">

            <h3>Seller Dashboard</h3>

            <ul class="nav nav-pills super-sub-link">

              <li class="active"><a class="" data-toggle="pill" href="#selling">I'm Selling </a></li>
              <li><a class="" data-toggle="pill" href="#sold"> I've Sold </a></li>
              <li><a class="" data-toggle="pill" href="#ended">Ended</a></li>

            </ul>

            <div class="tab-content super-tab-content">

             <div id="selling" class="tab-pane fade in active">

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-10">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
                         <li class="item"><b class="caption">Sold :</b> <span> 10</span></li>
                         <li class="item"><b class="caption">Buyer ratng: </b>
                          <span>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star-o" aria-hidden="true"></i>
                          </span>
                        </li>
                        <li class="item"><b class="caption">Features: </b> <span>For Men, Medic</span>
                        </ul>

                       </div>

                       <div class="col-sm-2 text-right">
                         <a href="#"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-10">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
                         <li class="item"><b class="caption">Sold :</b> <span> 10</span></li>
                         <li class="item"><b class="caption">Buyer ratng: </b>
                          <span>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star-o" aria-hidden="true"></i>
                          </span>
                        </li>
                        <li class="item"><b class="caption">Features: </b> <span>For Men, Medic</span>
                        </ul>

                       </div>

                       <div class="col-sm-2 text-right">
                         <a href="#"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-10">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
                         <li class="item"><b class="caption">Sold :</b> <span> 10</span></li>
                         <li class="item"><b class="caption">Buyer ratng: </b>
                          <span>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star-o" aria-hidden="true"></i>
                          </span>
                        </li>
                        <li class="item"><b class="caption">Features: </b> <span>For Men, Medic</span>
                        </ul>

                       </div>

                       <div class="col-sm-2 text-right">
                         <a href="#"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-10">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
                         <li class="item"><b class="caption">Sold :</b> <span> 10</span></li>
                         <li class="item"><b class="caption">Buyer ratng: </b>
                          <span>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star-o" aria-hidden="true"></i>
                          </span>
                        </li>
                        <li class="item"><b class="caption">Features: </b> <span>For Men, Medic</span>
                        </ul>

                       </div>

                       <div class="col-sm-2 text-right">
                         <a href="#"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-10">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
                         <li class="item"><b class="caption">Sold :</b> <span> 10</span></li>
                         <li class="item"><b class="caption">Buyer ratng: </b>
                          <span>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star-o" aria-hidden="true"></i>
                          </span>
                        </li>
                        <li class="item"><b class="caption">Features: </b> <span>For Men, Medic</span>
                        </ul>

                       </div>

                       <div class="col-sm-2 text-right">
                         <a href="#"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-10">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
                         <li class="item"><b class="caption">Sold :</b> <span> 10</span></li>
                         <li class="item"><b class="caption">Buyer ratng: </b>
                          <span>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star" aria-hidden="true"></i>
                           <i class="fa fa-star-o" aria-hidden="true"></i>
                          </span>
                        </li>
                        <li class="item"><b class="caption">Features: </b> <span>For Men, Medic</span>
                        </ul>

                       </div>

                       <div class="col-sm-2 text-right">
                         <a href="#"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>



             </div>

             <!-- / selling -->

             <div id="sold" class="tab-pane fade in">

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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


             <div id="ended" class="tab-pane fade in">

              <div class="row flex p15-0">
               <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                <div class="product-thumb">
                  <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                </div>
               </div>
               <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                 <ul class="p0">

                   <li>
                    <div class="row">

                      <div class="col-sm-6">

                       <ul class="p0">
                        <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                        <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
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
                  <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                </div>
               </div>
               <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                 <ul class="p0">

                   <li>
                    <div class="row">

                      <div class="col-sm-6">

                       <ul class="p0">
                        <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                        <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
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
                  <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                </div>
               </div>
               <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                 <ul class="p0">

                   <li>
                    <div class="row">

                      <div class="col-sm-6">

                       <ul class="p0">
                        <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                        <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
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
                  <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                </div>
               </div>
               <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                 <ul class="p0">

                   <li>
                    <div class="row">

                      <div class="col-sm-6">

                       <ul class="p0">
                        <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                        <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
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
                  <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                </div>
               </div>
               <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                 <ul class="p0">

                   <li>
                    <div class="row">

                      <div class="col-sm-6">

                       <ul class="p0">
                        <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                        <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
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
                  <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                </div>
               </div>
               <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                 <ul class="p0">

                   <li>
                    <div class="row">

                      <div class="col-sm-6">

                       <ul class="p0">
                        <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                        <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
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
                  <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                </div>
               </div>
               <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                 <ul class="p0">

                   <li>
                    <div class="row">

                      <div class="col-sm-6">

                       <ul class="p0">
                        <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                        <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
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

            </div>

           </div>

           <div id="buyer" class="tab-pane buyer fade in active">

            <h3>BUYER Dashboard</h3>

            <ul class="nav nav-pills super-sub-link">

              <li class="active"><a class="" data-toggle="pill" href="#active">Active</a></li>
              <li><a class="" data-toggle="pill" href="#won">Bids Accepted</a></li>
              <li><a class="" data-toggle="pill" href="#lost">Bids Rejected</a></li>

            </ul>

            <div class="tab-content super-tab-content">

             <div id="active" class="tab-pane fade in active">

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Target Price :  </b> <span> $1000 </span></li>
                         <li class="item"><b class="caption">Price Offer:  </b> <span> $1500</span></li>
                         <li class="item"><b class="caption">Time : </b> <span> 05/09/17 @ 12:05pm</span></li>
                        </ul>

                       </div>

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Date Available :  </b> <span class="orange"> Available Now</span></li>
                         <li class="item"><b class="caption">Order Type :  </b> <span>  Partial Allowed</span></li>
                         <li class="item"><b class="caption">Available Quantity : </b> <span> 150lbs</span></li>
                         <li class="item"><b class="caption">Quantity Requested : </b> <span> 250lbs </span></li>
                        </ul>

                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Target Price :  </b> <span> $1000 </span></li>
                         <li class="item"><b class="caption">Price Offer:  </b> <span> $1500</span></li>
                         <li class="item"><b class="caption">Time : </b> <span> 05/09/17 @ 12:05pm</span></li>
                        </ul>

                       </div>

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Date Available :  </b> <span class="orange"> Available Now</span></li>
                         <li class="item"><b class="caption">Order Type :  </b> <span>  Partial Allowed</span></li>
                         <li class="item"><b class="caption">Available Quantity : </b> <span> 150lbs</span></li>
                         <li class="item"><b class="caption">Quantity Requested : </b> <span> 250lbs </span></li>
                        </ul>

                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Target Price :  </b> <span> $1000 </span></li>
                         <li class="item"><b class="caption">Price Offer:  </b> <span> $1500</span></li>
                         <li class="item"><b class="caption">Time : </b> <span> 05/09/17 @ 12:05pm</span></li>
                        </ul>

                       </div>

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Date Available :  </b> <span class="orange"> Available Now</span></li>
                         <li class="item"><b class="caption">Order Type :  </b> <span>  Partial Allowed</span></li>
                         <li class="item"><b class="caption">Available Quantity : </b> <span> 150lbs</span></li>
                         <li class="item"><b class="caption">Quantity Requested : </b> <span> 250lbs </span></li>
                        </ul>

                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Target Price :  </b> <span> $1000 </span></li>
                         <li class="item"><b class="caption">Price Offer:  </b> <span> $1500</span></li>
                         <li class="item"><b class="caption">Time : </b> <span> 05/09/17 @ 12:05pm</span></li>
                        </ul>

                       </div>

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Date Available :  </b> <span class="orange"> Available Now</span></li>
                         <li class="item"><b class="caption">Order Type :  </b> <span>  Partial Allowed</span></li>
                         <li class="item"><b class="caption">Available Quantity : </b> <span> 150lbs</span></li>
                         <li class="item"><b class="caption">Quantity Requested : </b> <span> 250lbs </span></li>
                        </ul>

                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Target Price :  </b> <span> $1000 </span></li>
                         <li class="item"><b class="caption">Price Offer:  </b> <span> $1500</span></li>
                         <li class="item"><b class="caption">Time : </b> <span> 05/09/17 @ 12:05pm</span></li>
                        </ul>

                       </div>

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Date Available :  </b> <span class="orange"> Available Now</span></li>
                         <li class="item"><b class="caption">Order Type :  </b> <span>  Partial Allowed</span></li>
                         <li class="item"><b class="caption">Available Quantity : </b> <span> 150lbs</span></li>
                         <li class="item"><b class="caption">Quantity Requested : </b> <span> 250lbs </span></li>
                        </ul>

                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Target Price :  </b> <span> $1000 </span></li>
                         <li class="item"><b class="caption">Price Offer:  </b> <span> $1500</span></li>
                         <li class="item"><b class="caption">Time : </b> <span> 05/09/17 @ 12:05pm</span></li>
                        </ul>

                       </div>

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Date Available :  </b> <span class="orange"> Available Now</span></li>
                         <li class="item"><b class="caption">Order Type :  </b> <span>  Partial Allowed</span></li>
                         <li class="item"><b class="caption">Available Quantity : </b> <span> 150lbs</span></li>
                         <li class="item"><b class="caption">Quantity Requested : </b> <span> 250lbs </span></li>
                        </ul>

                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>

             </div>

             <!-- / Active -->

             <div id="won" class="tab-pane fade in">

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Highest Price :  </b> <span> $1000 </span></li>
                         <li class="item"><b class="caption">Won Date : </b> <span> 05/09/17 @ 12:05pm</span></li>
                        </ul>

                       </div>

                       <div class="col-sm-12">
                        <span><b>Description</b></span>
                         <p class="description">

                          Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                         </p>

                         <hr>

                         <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View invoice</button>

                         <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Shipping Tracking</button>

                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Highest Price :  </b> <span> $1000 </span></li>
                         <li class="item"><b class="caption">Won Date : </b> <span> 05/09/17 @ 12:05pm</span></li>
                        </ul>

                       </div>

                       <div class="col-sm-12">
                        <span><b>Description</b></span>
                         <p class="description">

                          Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                         </p>

                         <hr>

                         <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View invoice</button>

                         <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Shipping Tracking</button>

                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Highest Price :  </b> <span> $1000 </span></li>
                         <li class="item"><b class="caption">Won Date : </b> <span> 05/09/17 @ 12:05pm</span></li>
                        </ul>

                       </div>

                       <div class="col-sm-12">
                        <span><b>Description</b></span>
                         <p class="description">

                          Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                         </p>

                         <hr>

                         <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View invoice</button>

                         <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Shipping Tracking</button>

                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Highest Price :  </b> <span> $1000 </span></li>
                         <li class="item"><b class="caption">Won Date : </b> <span> 05/09/17 @ 12:05pm</span></li>
                        </ul>

                       </div>

                       <div class="col-sm-12">
                        <span><b>Description</b></span>
                         <p class="description">

                          Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                         </p>

                         <hr>

                         <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View invoice</button>

                         <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Shipping Tracking</button>

                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>

               <div class="row flex p15-0">
                <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                 <div class="product-thumb">
                   <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                 </div>
                </div>
                <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                  <ul class="p0">

                    <li>
                     <div class="row">

                       <div class="col-sm-6">

                        <ul class="p0">
                         <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                         <li class="item"><b class="caption">Highest Price :  </b> <span> $1000 </span></li>
                         <li class="item"><b class="caption">Won Date : </b> <span> 05/09/17 @ 12:05pm</span></li>
                        </ul>

                       </div>

                       <div class="col-sm-12">
                        <span><b>Description</b></span>
                         <p class="description">

                          Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                         </p>

                         <hr>

                         <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View invoice</button>

                         <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Shipping Tracking</button>

                       </div>

                     </div>
                    </li>


                  </ul>
                </div>
               </div>

               <div class="row flex p15-0">
               <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                <div class="product-thumb">
                  <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                </div>
               </div>
               <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                 <ul class="p0">

                   <li>
                    <div class="row">

                      <div class="col-sm-6">

                       <ul class="p0">
                        <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                        <li class="item"><b class="caption">Highest Price :  </b> <span> $1000 </span></li>
                        <li class="item"><b class="caption">Won Date : </b> <span> 05/09/17 @ 12:05pm</span></li>
                       </ul>

                      </div>

                      <div class="col-sm-12">
                       <span><b>Description</b></span>
                        <p class="description">

                         Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
                        </p>

                        <hr>

                        <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View invoice</button>

                        <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Shipping Tracking</button>

                      </div>

                    </div>
                   </li>


                 </ul>
               </div>
              </div>

             </div>

             <!-- / Won -->






             <div id="lost" class="tab-pane fade in">

              <div class="row flex p15-0">
               <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                <div class="product-thumb">
                  <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                </div>
               </div>
               <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                 <ul class="p0">

                   <li>
                    <div class="row">

                      <div class="col-sm-6">

                       <ul class="p0">
                        <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                        <li class="item"><b class="caption">Highest Price :  </b> <span> $1000 </span></li>
                        <li class="item"><b class="caption">Quantity </b> <span> 20</span></li>
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
                  <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                </div>
               </div>
               <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                 <ul class="p0">

                   <li>
                    <div class="row">

                      <div class="col-sm-6">

                       <ul class="p0">
                        <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                        <li class="item"><b class="caption">Highest Price :  </b> <span> $1000 </span></li>
                        <li class="item"><b class="caption">Quantity </b> <span> 20</span></li>
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
                  <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                </div>
               </div>
               <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                 <ul class="p0">

                   <li>
                    <div class="row">

                      <div class="col-sm-6">

                       <ul class="p0">
                        <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                        <li class="item"><b class="caption">Highest Price :  </b> <span> $1000 </span></li>
                        <li class="item"><b class="caption">Quantity </b> <span> 20</span></li>
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
                  <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                </div>
               </div>
               <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                 <ul class="p0">

                   <li>
                    <div class="row">

                      <div class="col-sm-6">

                       <ul class="p0">
                        <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                        <li class="item"><b class="caption">Highest Price :  </b> <span> $1000 </span></li>
                        <li class="item"><b class="caption">Quantity </b> <span> 20</span></li>
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
                  <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                </div>
               </div>
               <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                 <ul class="p0">

                   <li>
                    <div class="row">

                      <div class="col-sm-6">

                       <ul class="p0">
                        <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                        <li class="item"><b class="caption">Highest Price :  </b> <span> $1000 </span></li>
                        <li class="item"><b class="caption">Quantity </b> <span> 20</span></li>
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
                  <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                </div>
               </div>
               <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                 <ul class="p0">

                   <li>
                    <div class="row">

                      <div class="col-sm-6">

                       <ul class="p0">
                        <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                        <li class="item"><b class="caption">Highest Price :  </b> <span> $1000 </span></li>
                        <li class="item"><b class="caption">Quantity </b> <span> 20</span></li>
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

             <!-- / lost -->

            </div>

           </div>

          </div>

         </div>
         <!-- / sub-tab-content -->


         <!-- ***************************************************** ...................................../////open-bid*********************************************************************************************************************************************************************************************************************************************************************** -->


            <div id="direct-buy" class="tab-pane white-bg fade">

             <div class="panel panel-success">
               <div class="panel-heading green-bg p0">

                <ul class="nav nav-pills sub-link">

                  <li class="active"><a class="white" data-toggle="pill" href="#d-buyer">Buyer</a></li>
                  <li><a class="white" data-toggle="pill" href="#d-seller">Seller</a></li>

                </ul>

               </div>
             </div>

             <div class="tab-content sub-tab-content">

               <div id="d-seller" class="tab-pane buyer fade in">

                <h3>Seller Dashboard</h3>

                <ul class="nav nav-pills super-sub-link">

                  <li class="active"><a class="" data-toggle="pill" href="#d-selling">I'm Selling </a></li>
                  <li><a class="" data-toggle="pill" href="#d-sold"> I've Sold </a></li>
                  <li><a class="" data-toggle="pill" href="#d-ended">Ended</a></li>
                  <li><a class="" data-toggle="pill" href="#d-open-order">Open Order <img src="{$config['url']}/images/negotiable-grey.png" style="display:inline-block; margin-right:6px; margin-top: -10px;" class="img-responsive" alt=""></a></li>

                </ul>

                <div class="tab-content super-tab-content">

                 <div id="d-selling" class="tab-pane fade in active">

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-10">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity Available :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price :</b> <span> $10/Unit</span></li>
                             <li class="item"><b class="caption">Unit of Measure :</b> <span> Pounds</span></li>
                             <li class="item"><b class="caption">Buyer ratng: </b>
                              <span>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star-o" aria-hidden="true"></i>
                              </span>
                            </li>
                            <li class="item"><b class="caption">Features: </b> <span>For Men, Medic</span>
                            </ul>

                           </div>

                           <div class="col-sm-2 text-right">
                             <a href="#"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-10">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity Available :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price :</b> <span> $10/Unit</span></li>
                             <li class="item"><b class="caption">Unit of Measure :</b> <span> Pounds</span></li>
                             <li class="item"><b class="caption">Buyer ratng: </b>
                              <span>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star-o" aria-hidden="true"></i>
                              </span>
                            </li>
                            <li class="item"><b class="caption">Features: </b> <span>For Men, Medic</span>
                            </ul>

                           </div>

                           <div class="col-sm-2 text-right">
                             <a href="#"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-10">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity Available :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price :</b> <span> $10/Unit</span></li>
                             <li class="item"><b class="caption">Unit of Measure :</b> <span> Pounds</span></li>
                             <li class="item"><b class="caption">Buyer ratng: </b>
                              <span>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star-o" aria-hidden="true"></i>
                              </span>
                            </li>
                            <li class="item"><b class="caption">Features: </b> <span>For Men, Medic</span>
                            </ul>

                           </div>

                           <div class="col-sm-2 text-right">
                             <a href="#"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-10">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity Available :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price :</b> <span> $10/Unit</span></li>
                             <li class="item"><b class="caption">Unit of Measure :</b> <span> Pounds</span></li>
                             <li class="item"><b class="caption">Buyer ratng: </b>
                              <span>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star-o" aria-hidden="true"></i>
                              </span>
                            </li>
                            <li class="item"><b class="caption">Features: </b> <span>For Men, Medic</span>
                            </ul>

                           </div>

                           <div class="col-sm-2 text-right">
                             <a href="#"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-10">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity Available :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price :</b> <span> $10/Unit</span></li>
                             <li class="item"><b class="caption">Unit of Measure :</b> <span> Pounds</span></li>
                             <li class="item"><b class="caption">Buyer ratng: </b>
                              <span>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star-o" aria-hidden="true"></i>
                              </span>
                            </li>
                            <li class="item"><b class="caption">Features: </b> <span>For Men, Medic</span>
                            </ul>

                           </div>

                           <div class="col-sm-2 text-right">
                             <a href="#"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-10">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity Available :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price :</b> <span> $10/Unit</span></li>
                             <li class="item"><b class="caption">Unit of Measure :</b> <span> Pounds</span></li>
                             <li class="item"><b class="caption">Buyer ratng: </b>
                              <span>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star" aria-hidden="true"></i>
                               <i class="fa fa-star-o" aria-hidden="true"></i>
                              </span>
                            </li>
                            <li class="item"><b class="caption">Features: </b> <span>For Men, Medic</span>
                            </ul>

                           </div>

                           <div class="col-sm-2 text-right">
                             <a href="#"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>



                 </div>

                 <!-- / selling -->

                 <div id="d-sold" class="tab-pane fade in">

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                      <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                    </div>
                   </div>
                   <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                     <ul class="p0">

                       <li>
                        <div class="row">

                          <div class="col-sm-6">

                           <ul class="p0">
                            <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                            <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
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
                      <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                    </div>
                   </div>
                   <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                     <ul class="p0">

                       <li>
                        <div class="row">

                          <div class="col-sm-6">

                           <ul class="p0">
                            <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                            <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
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
                      <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                    </div>
                   </div>
                   <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                     <ul class="p0">

                       <li>
                        <div class="row">

                          <div class="col-sm-6">

                           <ul class="p0">
                            <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                            <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
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
                      <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                    </div>
                   </div>
                   <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                     <ul class="p0">

                       <li>
                        <div class="row">

                          <div class="col-sm-6">

                           <ul class="p0">
                            <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                            <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
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
                      <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                    </div>
                   </div>
                   <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                     <ul class="p0">

                       <li>
                        <div class="row">

                          <div class="col-sm-6">

                           <ul class="p0">
                            <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                            <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
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
                      <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                    </div>
                   </div>
                   <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                     <ul class="p0">

                       <li>
                        <div class="row">

                          <div class="col-sm-6">

                           <ul class="p0">
                            <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                            <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
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
                      <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                    </div>
                   </div>
                   <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                     <ul class="p0">

                       <li>
                        <div class="row">

                          <div class="col-sm-6">

                           <ul class="p0">
                            <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                            <li class="item"><b class="caption">Quantity  :  </b> <span> 20 </span></li>
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
                      <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                            <a class="w100 red" href="#"> Reject with Message <i class="fa fa-envelope" aria-hidden="true"></i></a>


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
                      <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                            <a class="w100 red" href="#"> Reject with Message <i class="fa fa-envelope" aria-hidden="true"></i></a> -->

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
                      <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                            <a class="w100 red" href="#"> Reject with Message <i class="fa fa-envelope" aria-hidden="true"></i></a>


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
                      <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                            <a class="w100 red" href="#"> Reject with Message <i class="fa fa-envelope" aria-hidden="true"></i></a>


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
                      <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                            <a class="w100 red" href="#"> Reject with Message <i class="fa fa-envelope" aria-hidden="true"></i></a>


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
                      <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                            <a class="w100 red" href="#"> Reject with Message <i class="fa fa-envelope" aria-hidden="true"></i></a>


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
                      <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                            <a class="w100 red" href="#"> Reject with Message <i class="fa fa-envelope" aria-hidden="true"></i></a>


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

               <div id="d-buyer" class="tab-pane buyer fade in active">

                <h3>BUYER Dashboard</h3>

                <ul class="nav nav-pills super-sub-link">

                  <li class="active"><a class="" data-toggle="pill" href="#d-buynow">Purchases <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>
                  <li class=""><a class="" data-toggle="pill" href="#d-accepted-order">Accepted Order <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>
                  <li class=""><a class="" data-toggle="pill" href="#d-buyer-open-type">Open Order <img src="{$config['url']}/images/negotiable-grey.png" style="display:inline-block; margin-right:6px; margin-top: -10px;" class="img-responsive" alt=""></a></li>
                  <li class=""><a class="" data-toggle="pill" href="#d-rejected-bids">Rejected Bids <img src="{$config['url']}/images/negotiable-grey.png" style="display:inline-block; margin-right:6px; margin-top: -10px;" class="img-responsive" alt=""></a></li>
                  <li class=""><a class="" data-toggle="pill" href="#d-rejected-orders">Rejected Orders <img src="{$config['url']}/images/negotiable-grey.png" style="display:inline-block; margin-right:6px; margin-top: -10px;" class="img-responsive" alt=""></a></li>


                </ul>

                <div class="tab-content super-tab-content">

                 <div id="d-buynow" class="tab-pane fade in active">

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-12">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price :  </b> <span> $1500/Unit</span></li>
                            </ul>

                           </div>

                           <div class="col-sm-12">

                            <span><b>Description</b></span>
                            <p class="description">
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            </p>

                            <hr>

                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button>


                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-12">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price :  </b> <span> $1500/Unit</span></li>
                            </ul>

                           </div>

                           <div class="col-sm-12">

                            <span><b>Description</b></span>
                            <p class="description">
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            </p>

                            <hr>

                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button>


                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-12">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price :  </b> <span> $1500/Unit</span></li>
                            </ul>

                           </div>

                           <div class="col-sm-12">

                            <span><b>Description</b></span>
                            <p class="description">
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            </p>

                            <hr>

                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button>


                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-12">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price :  </b> <span> $1500/Unit</span></li>
                            </ul>

                           </div>

                           <div class="col-sm-12">

                            <span><b>Description</b></span>
                            <p class="description">
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            </p>

                            <hr>

                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button>


                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-12">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price :  </b> <span> $1500/Unit</span></li>
                            </ul>

                           </div>

                           <div class="col-sm-12">

                            <span><b>Description</b></span>
                            <p class="description">
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            </p>

                            <hr>

                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button>


                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-12">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price :  </b> <span> $1500/Unit</span></li>
                            </ul>

                           </div>

                           <div class="col-sm-12">

                            <span><b>Description</b></span>
                            <p class="description">
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            </p>

                            <hr>

                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">View Invoice</button>


                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>



                 </div>

                 <!-- / d-buynow -->


                 <div id="d-accepted-order" class="tab-pane fade in">

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-12">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price:  </b> <span> $1500</span></li>
                            </ul>

                           </div>

                           <div class="col-sm-12">

                            <span><b>Description</b></span>
                            <p class="description">
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            </p>

                            <hr>

                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Pay</button>


                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-12">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price Offer:  </b> <span> $1500/Unit</span></li>
                            </ul>

                           </div>

                           <div class="col-sm-12">

                            <span><b>Description</b></span>
                            <p class="description">
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            </p>

                            <hr>

                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Pay</button>


                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-12">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price Offer:  </b> <span> $1500/Unit</span></li>
                            </ul>

                           </div>

                           <div class="col-sm-12">

                            <span><b>Description</b></span>
                            <p class="description">
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            </p>

                            <hr>

                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Pay</button>


                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-12">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price Offer:  </b> <span> $1500/Unit</span></li>
                            </ul>

                           </div>

                           <div class="col-sm-12">

                            <span><b>Description</b></span>
                            <p class="description">
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            </p>

                            <hr>

                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Pay</button>


                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-12">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price Offer:  </b> <span> $1500/Unit</span></li>
                            </ul>

                           </div>

                           <div class="col-sm-12">

                            <span><b>Description</b></span>
                            <p class="description">
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            </p>

                            <hr>

                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Pay</button>


                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-sm-12">

                            <ul class="p0">
                             <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Quantity :  </b> <span> 20 </span></li>
                             <li class="item"><b class="caption">Price Offer:  </b> <span> $1500/Unit</span></li>
                            </ul>

                           </div>

                           <div class="col-sm-12">

                            <span><b>Description</b></span>
                            <p class="description">
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            </p>

                            <hr>

                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Pay</button>


                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>



                 </div>

                 <!-- / d-Accecpted order-->


                 <div id="d-buyer-open-type" class="tab-pane fade in active">

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                             <span>Transaction has been accepted by the seller <span class="slash">|</span></span>
                            <a class="w100 grey" href="" disabled> Confirm</a>

                           </div>

                           <div class="col-sm-12">

                            <span><b>Description</b></span>
                            <p class="description">
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            </p>

                            <hr>

                            <button class="btn btn-default btn-d-b green-b shadow-btn m0" type="button" name="button">Pay</button>


                           </div>

                         </div>
                        </li>


                      </ul>
                    </div>
                   </div>

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                             <span>Transaction has been accepted by the seller <span class="slash">|</span></span>
                            <a class="w100" href="#"> Confirm</a>

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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                             <span>Transaction has been accepted by the seller <span class="slash">|</span></span>
                            <a class="w100" href="#"> Confirm</a>

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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                             <span>Transaction has been accepted by the seller <span class="slash">|</span></span>
                            <a class="w100" href="#"> Confirm</a>

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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                             <span>Transaction has been accepted by the seller <span class="slash">|</span></span>
                            <a class="w100" href="#"> Confirm</a>

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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                             <span>Transaction has been accepted by the seller <span class="slash">|</span></span>
                            <a class="w100" href="#"> Confirm</a>

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

                 <!-- / d-buyer-open-type -->

                 <div id="d-rejected-bids" class="tab-pane fade in active">

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                            <!-- <a class="w100" href="#"> Confirm</a> -->

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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                            <!-- <a class="w100" href="#"> Confirm</a> -->

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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                            <!-- <a class="w100" href="#"> Confirm</a> -->

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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                            <!-- <a class="w100" href="#"> Confirm</a> -->

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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                            <!-- <a class="w100" href="#"> Confirm</a> -->

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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                            <!-- <a class="w100" href="#"> Confirm</a> -->

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

                 <div id="d-rejected-orders" class="tab-pane fade in active">

                   <div class="row flex p15-0">
                    <div class="col-sm-3 col-md-2 col-xs-12 margin-auto p-r-0 res-p-l-0 res-p-l-0-767">
                     <div class="product-thumb">
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                             <span class="red">Your bid was rejected by the seller
                                <span class="slash">|</span>
                           </span>
                            <a class="w100" href="#"> Update Bid</a>

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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                             <span class="red">Your bid was rejected by the seller
                                <span class="slash">|</span>
                           </span>
                            <a class="w100" href="#"> Update Bid</a>

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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                             <span class="red">Your bid was rejected by the seller
                                <span class="slash">|</span>
                           </span>
                            <a class="w100" href="#"> Update Bid</a>

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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                             <span class="red">Your bid was rejected by the seller
                                <span class="slash">|</span>
                           </span>
                            <a class="w100" href="#"> Update Bid</a>

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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
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
                             <span class="red">Your bid was rejected by the seller
                                <span class="slash">|</span>
                           </span>
                            <a class="w100" href="#"> Update Bid</a>

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
                       <img src="{$config['url']}/images/hover-item.png" class="img-responsive" alt="">
                     </div>
                    </div>
                    <div class="col-sm-9 col-md-10 col-xs-12 item-col margin-auto grey-bg">
                      <ul class="p0">

                        <li>
                         <div class="row">

                           <div class="col-md-6 col-sm-6">

                            <ul class="p0">
                            <li class="item"><b class="caption">Product Name : </b> <span> Awesome Product</span></li>
                             <li class="item"><b class="caption">Suggested Price : </b> <span> $20/Unit</span></li>
                             <li class="item"><b class="caption">Price Offered</b> <span> $10/Unit</span></li>
                             <li class="item"><b class="caption">Quantity Requested :  </b> <span> 20 </span></li>

                            </ul>

                           </div>


                           <div class="col-md-6 col-sm-6">
                             <span class="red">Your bid was rejected by the seller
                                <span class="slash">|</span>
                           </span>
                            <a class="w100" href="#"> Update Bid</a>

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

                 <!-- / d-rejected-orders -->


                </div>

               </div>

              </div>

            </div>

             <!-- *****************************************=======================================================................................../////Directbuy************************************************************************************************************************************************************************************************************************************************************ -->


         </div>

         <!-- pagination -->

         <ul class="pagination-ul flex m50 m-b-0">
             <a href="#"><li class="inactive"><span class="fa fa-angle-left"></span></li></a>
             <a href="#"><li class="active">1</li></a>
             <a href="#"><li>2</li></a>
             <a href="#"><li>3</li></a>
             <a href="#"><li>4</li></a>
             <a href="#"><li><span class="fa fa-angle-right"></span></li></a>
         </ul>

        </div>


      </div>


    </div>


</div>



<!--/ Page content -->



{include file="common/footer-1.tpl" nocache}

<script src="js/style.js"></script>
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/aos.js"></script>
<script src="js/owl.carousel.min.js"></script>
<!-- <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/owl.carousel.min.js"> -->

</script>
<script type="text/javascript">
    $(document).ready(function(){
        // $('#feature-brands').owlCarousel();


            var owl = $('#feature-brands');
            owl.owlCarousel({
                items:4,
                // loop:true,
                margin:10,
                autoplay:true,
                autoplayTimeout:1000,
                autoplayHoverPause:true,
                responsiveClass:true,
                responsive:{
                    0:{
                        items:1,
                    },
                    600:{
                        items:3,
                    },
                    1000:{
                        items:4,
                    }
              }
            });
            $('.play').on('click',function(){
                owl.trigger('play.owl.autoplay',[1000])
            })
            $('.stop').on('click',function(){
                owl.trigger('stop.owl.autoplay')
            })


    });
</script>
<script>
   AOS.init({
      offset: 200,
      duration: 600,
      easing: 'ease-in-sine',
      delay: 100,
    });
</script>
<script type="text/javascript">
//On scroll call the draw function
$(window).scroll(function() {
drawLines();
});

//If you have more than one SVG per page this will pick it up
function drawLines(){
$.each($("path"), function(i, val){
  var line = val;
  drawLine($(this), line);
});
}

//draw the line
    function drawLine(container, line){
var length = 1;
var pathLength = line.getTotalLength();
var distanceFromTop = container.offset().top - $(window).scrollTop();
var percentDone = 1 - (distanceFromTop / $(window).height());
length = percentDone * pathLength;
line.style.strokeDasharray = [length,pathLength].join(' ');
console.log("strokeDasharray: "+[length,pathLength].join(' '));
}
</script>
</body>
</html>
