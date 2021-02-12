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
            action="{$config.url}/dashboard/seller/negotiation/">
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
                                <li class=""><a class=""  href="{$config.url}/dashboard/seller/sold"> Products I've Sold</a></li>
                                <li class=""><a class=""  href="{$config.url}/dashboard/seller/recuring">Recurring Purchases <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>
                                <!-- <li><a class="" data-toggle="pill" href="#d-ended">Ended</a></li> -->
                                <li class="active"><a class=""  href="#d-open-order">Direct Buy Negotiations
                  </a></li>

                  <li class=""><a class=""  href="{$config.url}/dashboard/seller/rejected">Rejected Proposals <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>
                  <li><a class=""  href="{$config.url}/dashboard/seller/inventory">Inventory <!-- <i class="icon flaticon-shopping-cart" aria-hidden="true"></i> --></a></li>
                  <li><a class=""  href="{$config.url}/dashboard/seller/inventorbyproduct">Inventory By Product</a></li>
                 
                            </ul>
                            <div class="tab-content super-tab-content">

                                <!-- / selling -->

                                <!-- / Sold -->

                                <!-- / ended -->
                                <div id="d-open-order" class="tab-pane fade in active">
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
                                                        <div class="col-sm-7">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Product Name : </b> <span>{$val.title}</span></li>
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> ${$val.unit_price}/{$val.units}</span></li>
                                                                <li class="item"><b class="caption">Price Offered : </b> <span> ${$val.bamt}/{$val.units}</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> {$val.bqty} </span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-5">
                                                            <a class="w100 accept" id="{$val.bid}" data-pid="{$val.id}" data-qty="{$val.bqty}"> Accept <span class="slash">|</span></a>
                                                            <a class="w100 red reject" id="{$val.bid}"> Reject<span class="slash">|</span></a>
                                                            <a class="w100 red"  data-toggle="modal" data-record-bid="{$val.bid}" data-target="#rejectMessage"> Reject with Message <i class="fa fa-envelope" aria-hidden="true"></i></a>
                                                            
                                                            <div class="rating green-text">
                                                                <br>
                                                                <b>Buyer Rating:</b> <span class="stars" align="left">{$val.buyer_rating}</span>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <span><b>Description</b></span>
                                                            <p class="description">
                                                               {$val.description}
                                                            </p>
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

                  </a></li>

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
                                                        <div class="col-sm-6 col-sm-6">
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

    $(document).ready(function () {

        $('#rejectMessage').on('show.bs.modal', function(e) {
            var data = $(e.relatedTarget).data();
             $('.bid', this).val(data.recordBid);
        });
        $('.rejmesgsend').click(function() {
            var bid = $('.bid').val();
             var rmesg = $('.rmesg').val();
            $.ajax({
              type : 'POST',
              dataType : 'json',
              url : '/btnrejectnegomesg',
              data : 'recur=1&bid='+bid+'&rmesg='+rmesg,
              success : function(data) {
                window.location.reload();


              }
            });


        });
        $('.accept').click(function() {
            var bid = this.id;
            var pid = $(this).attr("data-pid");
            var qty = $(this).attr("data-qty");
            $.ajax({
              type : 'POST',
              dataType : 'json',
              url : '/product/btnacceptnego',
              data : 'recur=1&bid='+bid+'&pid='+pid+'&qty='+qty,
              success : function(data) {
                // res.send(JSON.stringify({ 'error': false, 'success': 0, 'payment':false, link_url:'/payment/wirefund/1'}));
                if(data.error){
                    if(data.data.buynow_status){
                        swal("Request can not be accept due to payment is already done...");
                    } else {
                        swal("error occured");
                    }
                } else {
                    if(data.success == 0){

                        if(data.count){
                            alert("Only "+data.count+" available");
                        } 
                        
                    }     
                }
                      window.location= data.link_url;

              }
            });
        });

         $('.reject').click(function() {
            var bid = this.id;
            $.ajax({
              type : 'POST',
              dataType : 'json',
              url : '/btnrejectnego',
              data : 'recur=1&bid='+bid,
              success : function(data) {
                window.location.reload();


              }
            });


        });

    });
</script>
    <script type="text/javascript">

  $('#pagination').find('ul').addClass('pagination-ul flex m50 m-b-0');
  $('#pagination').find('ul').removeClass('pagination');


    $(document).ready(function() {
        // $('#feature-brands').owlCarousel();


        var owl = $('#feature-brands');
        owl.owlCarousel({
            items: 4,
            // loop:true,
            margin: 10,
            autoplay: true,
            autoplayTimeout: 1000,
            autoplayHoverPause: true
        });
        $('.play').on('click', function() {
            owl.trigger('play.owl.autoplay', [1000])
        })
        $('.stop').on('click', function() {
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
    function drawLines() {
        $.each($("path"), function(i, val) {
            var line = val;
            drawLine($(this), line);
        });
    }

    //draw the line
    function drawLine(container, line) {
        var length = 1;
        var pathLength = line.getTotalLength();
        var distanceFromTop = container.offset().top - $(window).scrollTop();
        var percentDone = 1 - (distanceFromTop / $(window).height());
        length = percentDone * pathLength;
        line.style.strokeDasharray = [length, pathLength].join(' ');
       //console.log("strokeDasharray: " + [length, pathLength].join(' '));
    }
    </script>
</body>

</html>

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
                autoplayHoverPause:true
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
