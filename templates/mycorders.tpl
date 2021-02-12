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

    <div class="clearfix grey-bg xs-pdlr">
        <div class="container dashboard-con m50">
            <div class="row flex">
                <div class="col-sm-7 col-md-6 margin-auto">
                    <ul class="nav nav-pills nav-justified">
                        <li class="active"><a class="p20-15" data-toggle="pill" href="#open-bid">Open Bid Market</a></li>
                        <li><a class="p20-15"  href="{$config.url}/dashboard/dbmarket/">Direct Buy Market</a></li>
                    </ul>
                </div>
                <div class="col-sm-5 col-md-6 margin-auto mt-res-10">
                    <form enctype="multipart/form-data" method="get" enctype="multipart/form-data"
            action="{$config.url}/dashboard/mycorders/all/">
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
                            {include file="common/dashboardob_menu.tpl"}
                            <div class="tab-content super-tab-content">
                                <div id="orders-confirm" class="tab-pane fade in active">

                                    {foreach $myProducts as $key => $val}
                                        <form id="accept_form{$val.req_id}" method="post" action="{$config.url}/product/request/accept/{$val.id}" >
                                        <!-- request id  -->
                                            <input type="hidden" name="req_id" value="{$val.req_id}"/>

                                         </form>
                                         <form id="reject_form{$val.req_id}" method="post" action="{$config.url}/product/request/reject/{$val.id}" >
                                        <!-- request id  -->

                                            <input type="hidden" name="req_id" value="{$val.req_id}"/>

                                         </form>
                                    <div class="media">
                                            <div class="media-left product-thumb">
                                                <div class="w100 green-bg p10 text-center tit-btn">
                                                    {if $val.trading_type == 'buy'}
                                                      <span class="white">BUY</span>
                                                    {/if}
                                                    {if $val.trading_type == 'sell'}
                                                      <span class="white">SELL</span>

                                                    {/if}
                                                </div>
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

                                                        <div class="col-md-4 col-sm-6 col-xs-6 w100-480">
                                                            <ul class="p0">
                                                               <li class="item"><a href="{$config.url}/product/view/{$val.id}"><b class="caption">Product Name : </b> <span> {$val.title}</span></a></li>
                                                                <li class="item"><b class="caption">Target Price :  </b> <span> ${$val.sprice} / {$val.short_unit}</span></li>

                                                                {if $val.trading_type == 'buy'}
                                                                 <li class="item"><b class="caption">Quantity Requested:  </b> <span> {$val.qty} {$val.units}</span></li>
                                                                {/if}

                                                                {if $val.trading_type == 'sell'}
                                                                 <li class="item"><b class="caption">Quantity Available:  </b> <span> {$val.qty} {$val.units}</span></li>
                                                                {/if}
                                                                  <!--<li class="item"><b class="caption">Price per unit:  </b> <span> ${$val.unit_price}/{$val.short_unit}</span></li> -->
                                                                <li class="item"><b class="caption">Bid Date : </b> <span> {$val.req_date}<!-- 05/09/17 @ 12:05pm --></span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-4 col-sm-6 col-xs-6 w100-480">
                                                            <ul class="p0">
                                                                <li class="item"><b class="caption">Order Type :  </b> <span> {$val.order_type_text} </span></li>

                                                                {if $val.trading_type == 'buy'}
                                                                    {if $val.order_type == 'partial'}
                                                                        <li class="item"><b class="caption"> Quantity Requested : </b> <span> {$val.rfilled_qty} {$val.units} </span></li>
                                                                    {/if}
                                                                    <li class="item"><b class="caption">Quantity Fulfilled : </b> <span> {$val.req_qty} {$val.units}</span></li>
                                                                   <!--  <li class="item"><b class="caption">Total Quantity Fulfilled : </b> <span> {$val.filled_qty} {$val.units}</span></li> -->
                                                                {/if}

                                                                {if $val.trading_type == 'sell'}
                                                                 {if $val.order_type == 'partial'}
                                                                 <li class="item"><b class="caption">Quantity Available for Bid : </b> <span> {$val.rfilled_qty} {$val.units}</span></li>
                                                                {/if}
                                                                    <li class="item"><b class="caption">Quantity Requested : </b> <span> {$val.req_qty} {$val.units} </span></li>
                                                                    <!-- <li class="item"><b class="caption">Total Quantity Requested : </b> <span> {$val.filled_qty} {$val.units}</span></li> -->
                                                                    <!--<li class="item"><b class="caption">Quantity Fulfilled : </b> <span> {$val.req_qty} {$val.units}</span></li><li class="item"><b class="caption">Total Quantity Fulfilled : </b> <span> {$val.filled_qty} {$val.units}</span></li> -->
                                                                {/if}

                                                                <li class="item"><b class="caption">Price Offered : </b> <span> ${$val.req_amount * $val.req_qty} (${$val.req_amount} / {$val.short_unit})</span></li>

                                                                {if $val.ue_stax=='y' && $val.p_trading_type}
                                                            <li class="item"><b class="caption">Sales Tax : </b> <span> {$val.ue_stax_per}%</span></li>
                                                        {/if}


                                                                {if $val.req_test_result != ''}
                                                                <li class="item">
                                                                 <a href="{$config.imgpath}testresult/{$val.req_test_result}" onclick="window.open(this.href); return false;">
                                                                 <b class="caption">View Test Result </b>
                                                                <i class="fa fa-list icon"></i> </a>
                                                                </li>
                                                                {/if}


                                                            </ul>
                                                        </div>
                                                        <div id="acceptReq" class="col-md-4 col-sm-12 col-xs-12 w100-480 pl-0 text-right">
                                                          <a  style="cursor: pointer;" class="w100 res-display-block res-mt-7" class="btn-link" onclick="acceptRequest({$val.req_id})"> Accept <span class="slash">|</span></a>
                                                          <a  style="cursor: pointer;" class="w100 red res-display-block res-mt-7" class="btn-link" onclick="rejectRequest({$val.req_id})"> Reject<span class="slash">|</span></a>
                                                          <a  style="cursor: pointer;" class="w100 red res-display-block res-mt-7" onclick="rejectRequestMsg('{$val.id}','{$val.req_id}')"> Reject with Message <i class="fa fa-envelope" aria-hidden="true"></i></a><!-- {$val.req_user_id} -->
                                                          <div class="rating green-text">
                                                              <br>
                                                            Seller Rating: <span class="stars" align="left">{$val.seller_rating}</span>
                                                          </div>
                                                          <div class="rating green-text">
                                                                <br>
                                                                <b>Buyer Rating:</b> <span class="stars" align="left">{$val.buyer_rating}</span>
                                                            </div>
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
    </div>
    </div>

    <!-- Reject message enter -->
<div class="container">

  <!-- Modal -->
  <div class="modal fade" id="rejectMessage1" role="dialog">
    <div class="modal-dialog modal-sm wd50">

      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header p0">

          <div class="panel panel-success border-0">
            <div class="panel-heading green-bg">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3>Enter Your Message</h3>
            </div>
          </div>
        </div>

              <form id="reject_modal_form" method="post" action="" data-parsley-validate>
        <div class="modal-body">
          <div class="row">
            <div class="col-md-offset-1 col-md-10">
               <!--    <p class="description"> -->
               <div>
                    <input id="rej_id" type="hidden" name="req_id" value=""/>
                    <textarea class="grey-bg w100 border-0 p15 pb15" placeholder="Please Comment Here" name="rej_msg" rows="6" cols="80" data-parsley-required-message="Message is required" required></textarea><br>
                    </div>
               <!--    </p> -->


            </div>
          </div>
        </div>
        <div class="modal-footer">
 <button class="btn btn-default btn-d-b green-b m0" type="submit">SEND</button>
        </div>
             </form>
      </div>

    </div>
  </div>

</div>

    <!--/ Page content -->

{include file="common/footer-1.tpl" nocache}

    <script type="text/javascript">
        function acceptRequest(id){
            $('#acceptReq').html("Request accepted");
            $('#accept_form'+id).submit();
        };
    </script>
    <script type="text/javascript">
        function rejectRequest(id){
            $('#acceptReq').html("Request rejected");
            $('#reject_form'+id).submit();
        };
    </script>
    <script type="text/javascript">
            function rejectRequestMsg(id, req_id){
                console.log(id);
            $("#rejectMessage1").find("#rej_id").val(req_id);
            $("#rejectMessage1").find("#reject_modal_form").attr('action', "{$config.url}/product/request/reject/"+id);
            $("#rejectMessage1").modal();
        };
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
            autoplayHoverPause: true,
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
