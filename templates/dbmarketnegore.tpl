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
                <div class="col-md-6 col-sm-7 margin-auto">
                    <ul class="nav nav-pills nav-justified">
                        <li ><a class="p20-15" href="{$config.url}/dashboard/myrequests">Open Bid Market</a></li>
                        <li class="active"><a class="p20-15" data-toggle="pill" href="#direct-buy">Direct Buy Market</a></li>
                    </ul>
                </div>
                <div class="col-md-5 col-sm-7 margin-auto">
                    <form enctype="multipart/form-data" method="get" enctype="multipart/form-data"
            action="{$config.url}/dashboard/dbmarket/rejectorder/">
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
                                <li><a class="white" href="{$config.url}/dashboard/seller/selling">Seller</a></li>
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
                                <!-- <li><a class="" data-toggle="pill" href="#d-ended">Ended</a></li> -->
                                <li><a class="" data-toggle="pill" href="#d-open-order">Direct Buy Negotiations
                    <!-- <img src="images/negotiable-grey.png" style="display:inline-block; margin-right:6px; margin-top: -10px;" class="img-responsive" alt=""> -->
                  </a></li>
                            </ul>
                        </div>
                        <div id="d-buyer" class="tab-pane buyer fade in active">
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
                                                                <li class="item"><b class="caption">Suggested Price : </b> <span> ${$val.sprice}/{$val.units}</span></li>
                                                                <li class="item"><b class="caption">Price Offered</b> <span> ${$val.proposed_amount}/{$val.units}</span></li>
                                                                <li class="item"><b class="caption">Quantity Requested :  </b> <span> {$val.qty_request} </span></li>
                                                                <li>
                                                                    <div class="rating green-text">
                                                                        <b>Seller Rating:</b> <span class="stars" align="left">{$val.seller_rating}</span>
                                                                    </div>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <span class="red">If you would like to change your offer please return to the item in the store and submit a new Bid</span>

                                                            {if $val.reject_mesg!=''}
                                                            <span class="slash">|</span>
                                                            <a class="w100" href="#viewMessage" data-toggle="modal" data-target="#viewMessage" data-record-mess="{$val.reject_mesg}"> View Message</a>
                                                            {/if}
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

        $('#viewMessage').on('show.bs.modal', function(e) {
            var data = $(e.relatedTarget).data();
             $('.mess123', this).html(data.recordMess);
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
