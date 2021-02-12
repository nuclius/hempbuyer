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

<style>
.sortcol{
    cursor:pointer;
    position: relative;
    padding-right: 20px !important;
}
</style>

{include file="common/dashboard-navigation.tpl" nocache}

    <div class="container-fluid grey-bg xs-pdlr">
        <div class="container dashboard-con m50">
            <div class="row flex">
                <div class="col-sm-7 col-xs-6 margin-auto w100-480">
                    <ul class="nav nav-pills nav-justified">
                        {if $loged.business_settings.open_bid == 1}
                        <li ><a class="p20-15"  href="{$config.url}/dashboard/myrequests">Open Bid Market</a></li>
                        {/if}
                        <li class="active"><a class="p20-15" data-toggle="pill" href="#direct-buy">Direct Buy Market</a></li>
                    </ul>
                </div>
                <div class="col-sm-5 col-xs-6 margin-auto w100-480">
                    <form enctype="multipart/form-data" method="get" enctype="multipart/form-data"
            action="{$config.url}/dashboard/seller/rejected/">
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
                                <li class=""><a class=""  href="{$config.url}/dashboard/seller/selling">Products I'm Selling </a></li>
                                <li><a class=""  href="{$config.url}/dashboard/seller/sold"> Products I've Sold</a></li>
                                <!-- <li><a class="" data-toggle="pill" href="#d-ended">Ended</a></li> -->
                                 <li class=""><a class=""  href="{$config.url}/dashboard/seller/recuring">Recurring Purchases <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>
                                <li><a class=""  href="{$config.url}/dashboard/seller/negotiation">Direct Buy Negotiations
                    <!-- <img src="images/negotiable-grey.png" style="display:inline-block; margin-right:6px; margin-top: -10px;" class="img-responsive" alt=""> -->
                  </a></li>

                  <li><a class=""  href="{$config.url}/dashboard/seller/rejected">Rejected Proposals <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li>
                  <li class="active"><a class=""  href="{$config.url}/dashboard/seller/inventory">Inventory <!-- <i class="icon flaticon-shopping-cart" aria-hidden="true"></i> --></a></li>
                  <li><a class=""  href="{$config.url}/dashboard/seller/inventorbyproduct">Inventory By Product</a></li>
                 <!--  <li class=""><a class=""  href="{$config.url}/dashboard/seller/accepted">Accepted Proposals <i class="icon flaticon-shopping-cart" aria-hidden="true"></i></a></li> -->
                            </ul>
                            <div class="tab-content super-tab-content">
                                <div id="d-selling" class="tab-pane fade in active">
                                    <br>
                                    {if $myProducts.length > 0}
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover inventory_table">
                                            <thead>
                                                <tr>
                                                    <th width="30">No.</th>
                                                    <th width="40" sort="title" class="sortcol {if $sort_col=='title'}sort_{$direction}{/if} {if $sort_col!='title'}sort{/if}">Product name</th>
                                                    <th sort="description" class="sortcol {if $sort_col=='description'}sort_{$direction}{/if} {if $sort_col!='description'}sort{/if}">Product Description</th>
                                                    <th>Test Results</th>
                                                    <th sort="metrc_id" class="sortcol {if $sort_col=='metrc_id'}sort_{$direction}{/if} {if $sort_col!='metrc_id'}sort{/if}">METRC ID</th>
                                                    <th sort="units" class="sortcol {if $sort_col=='units'}sort_{$direction}{/if} {if $sort_col!='units'}sort{/if}">Unit of measure</th>
                                                    <th sort="qty" class="sortcol {if $sort_col=='qty'}sort_{$direction}{/if} {if $sort_col!='qty'}sort{/if}">Initial Quantity Available</th>
                                                    <th sort="items_in_recurring" class="sortcol {if $sort_col=='items_in_recurring'}sort_{$direction}{/if} {if $sort_col!='items_in_recurring'}sort{/if}">Recurring sales obligations</th>
                                                    <th sort="items_in_cart" class="sortcol {if $sort_col=='items_in_cart'}sort_{$direction}{/if} {if $sort_col!='items_in_cart'}sort{/if}">Quantity in cart pending check out</th>
                                                    <th sort="items_in_pending_delivery" class="sortcol {if $sort_col=='items_in_pending_delivery'}sort_{$direction}{/if} {if $sort_col!='items_in_pending_delivery'}sort{/if}" width="100">Quantity sold pending delivery</th>
                                                    <th sort="items_in_success_delivery" class="sortcol {if $sort_col=='items_in_success_delivery'}sort_{$direction}{/if} {if $sort_col!='items_in_success_delivery'}sort{/if}" width="100">Quantity sold success delivery</th>
                                                    <th sort="remain_quantity" class="sortcol {if $sort_col=='remain_quantity'}sort_{$direction}{/if} {if $sort_col!='remain_quantity'}sort{/if}" width="100">Net Quantity available to sell</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {foreach $myProducts as $key => $val}
                                                <tr>
                                                    <td>{(($page-1)*10)+($key+1)}</td>
                                                    <td>{$val.title}</td>
                                                    <td>{$val.description}</td>
                                                    <td>
                                                        {if $val.test_result != ''}
                                                            <a href="{$config.imgpath}testresult/{$projects.test_result}" onclick="window.open(this.href); return false;">
                                                                {$val.test_result_img} <i class="fa fa-list icon"></i>
                                                            </a>
                                                        {/if}
                                                        {if $val.test_result == ''}
                                                            -
                                                        {/if}
                                                    </td>
                                                    <td>{$val.metrc_id}</td>
                                                    <td>{$val.units}</td>
                                                    <td>{$val.qty}</td>
                                                    <td>{$val.items_in_recurring}</td>
                                                    <td>{$val.items_in_cart}</td>
                                                    <td>{$val.items_in_pending_delivery}</td>
                                                    <td>{$val.items_in_success_delivery}</td>
                                                    <td>{$val.remain_quantity}</td>
                                                </tr>
                                                {/foreach}
                                            </tbody>
                                        </table>
                                    </div>
                                    {/if}

                                <!-- {foreach $myProducts as $key => $val}
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
                                                                <li class="item"><a class="black" href="{$config.url}/product/sview/{$val.id}"><b class="caption">Prodct Name : </b> <span> {$val.title}</span></a></li>
                                                                <li class="item"><b class="caption">Quantity :  </b> <span> {$val.qty} {$val.units}</span></li>
                                                                <li class="item"><b class="caption">Available Quantity :  </b> <span> {$val.qty-$val.sold} {$val.units}</span></li>
                                                                <li class="item"><b class="caption">Price :</b> <span> ${$val.unit_price}/{$val.units}</span></li>
                                                                <li class="item"><b class="caption">Unit of Measure :</b> <span> {$val.units}</span></li>
                                                                <li class="item"><b class="caption">Description: </b> <span>{$val.description}</span>

                            {if $val.test_result != ''}
                            <li class="item"><b class="caption">View Test Result : </b> <span>
              <a href="{$config.imgpath}testresult/{$projects.test_result}" onclick="window.open(this.href); return false;"> {$val.test_result_img} <i class="fa fa-list icon"></i> </a>
              </span>
              {/if}

                                                            </ul>
                                                        </div>
                                                         <div class="col-md-6 col-sm-6">


                                                            {if $val.market_status == "sold" || $val.market_status == "closed"}
                                                                Product Sold
                                                            {/if}
                                                        </div>
                                                    </div>
                                                    </li>
                                            </ul>
                                        </div>
                                    </div>



                                 {/foreach}
                                  -->
                                  {if $myProducts.length < 1}
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

{include file="common/footer-1.tpl" nocache}

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
          $('#viewMessage1').on('show.bs.modal', function(e) {
            var data = $(e.relatedTarget).data();
             $('.mess1231', this).html(data.recordMess);
        });

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

var fquery = '{$fquery}';
var base = '{$config.url}';
$(document).ready(function() {
    $(document).on('click', '.sortcol', function(){
        var href = '';
        var sort_this = $(this).attr('sort');
        var direction_this = $(this).hasClass('sort_asc') ? 'desc' : 'asc';
        var params = [];
        var sorted = 0;
        if(fquery != '') {
            params = fquery.split('&');
            
            for (let index = 0; index < params.length; index++) {
                const element = params[index];
                console.log('element', element);
                const elements = element.split('=')[0];
                console.log('elements', elements);
                if(elements == 'sort') {
                    params[index] = 'sort=' + sort_this;
                    sorted = 1;
                } else if(elements == 'direction') {
                    params[index] = 'direction=' + direction_this;
                }
                if(params.length-1 == index) {
                    if(sorted == 0) {
                        sort=
                        href = base + '/dashboard/seller/inventory/?sort=' + sort_this + '&direction=asc&' + params.join('&');
                    } else {
                        href = base + '/dashboard/seller/inventory/?' + params.join('&');
                    }
                    window.location.href = href;
                }
            }
        } else {
            href = base + '/dashboard/seller/inventory/?sort=' + sort_this + '&direction=asc';
            window.location.href = href;
        }
        console.log('href', href);
        console.log('params', params);
        
        // window.location.href = '';
    });
});
</script>
</body>
</html>
