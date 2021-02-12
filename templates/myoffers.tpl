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

<style type="text/css">
    #myoffer-sell {
        border: 5px solid #eb6023;
    }

    #myoffer-buy {
        border: 5px solid #2381eb;
        ;
    }
</style>

{include file="common/dashboard-navigation.tpl" nocache}

<div class="clearfix grey-bg xs-pdlr">
    <div class="container dashboard-con m50">
        <div class="row">
            <div class="col-sm-7 col-md-6 margin-auto">
                <ul class="nav nav-pills nav-justified">
                    <li class="active">
                        <a class="p20-15" data-toggle="pill" href="#open-bid">Open Bid Market</a>
                    </li>
                    <li>
                        <a class="p20-15" href="{$config.url}/dashboard/dbmarket/">Direct Buy Market</a>
                    </li>
                </ul>
            </div>
            <div class="col-sm-5 col-md-6 margin-auto mt-res-10">
                <form enctype="multipart/form-data" method="get" enctype="multipart/form-data" action="{$config.url}/dashboard/myoffers/all/"> 
                    <input class="p5-15 border1 input-radius search-input bg-transparent" placeholder="Search" type="text" style="border-color:#d4d4d4;"
                                    name="search" value="{$search.search}">
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
                                <form id="accept_form{$val.req_id}" method="post" action="{$config.url}/product/request/accept/{$val.id}">
                                    <!-- request id  -->
                                    <input type="hidden" name="req_id" value="{$val.req_id}" />

                                </form>
                                <form id="reject_form{$val.req_id}" method="post" action="{$config.url}/product/request/reject/{$val.id}">
                                    <!-- request id  -->
                                    <input type="hidden" name="req_id" value="{$val.req_id}" />
                                </form>
                                <div class="media">
                                    <div class="media-left product-thumb">  
                                            <div class="w100 green-bg p10 text-center tit-btn">
                                                {if $val.trading_type == 'buy'}
                                                <span class="white">SELL</span>
                                                {/if} {if $val.trading_type == 'sell'}
                                                <span class="white">BUY</span>

                                                {/if}
                                            </div>
                                            {if $val.avatar == ''}
                                            <img class="res-centering" src="{$config.url}/images/no_img.png" width="170px" class="img-responsive" alt=""> {/if} {if $val.avatar != ''}
                                            <img class="res-centering" src="{$config.imgpath}product/{$val.avatar}" width="170px" class="img-responsive" alt=""> {/if} 
                                    </div>
                                    <div class="media-body item-col margin-auto grey-bg">
                                        <ul class="p0">
                                            <li>
                                                <div class="row">
                                                    <div class="col-md-4 col-sm-6 col-xs-6 w100-480">
                                                        <ul class="p0">
                                                            <li class="item">
                                                                <a href="{$config.url}/product/view/{$val.id}">
                                                                    <b class="caption">Product Name : </b>
                                                                    <span> {$val.title}</span>
                                                                </a>
                                                            </li>
                                                            <li class="item">
                                                                <b class="caption">Target Price : </b>
                                                                <span> ${$val.sprice} / {$val.short_unit}</span>
                                                            </li>
                                                            <li class="item">
                                                                <b class="caption">Quantity : </b>
                                                                <span> {$val.qty} {$val.unit} </span>
                                                            </li>
                                                            <!--  <li class="item"><b class="caption">Price per unit:  </b> <span> ${$val.unit_price}/{$val.short_unit}</span></li> -->
                                                            <li class="item">
                                                                <b class="caption">Bid Date : </b>
                                                                <span> {$val.req_date}
                                                                    <!-- 05/09/17 @ 12:05pm -->
                                                                </span>
                                                            </li>
                                                            <li class="item">
                                                                <div class="rating green-text">
                                                                    <b>Seller Rating:</b> <span class="stars" align="left">{$val.seller_rating}</span>
                                                                </div>
                                                            </li>
                                                            <!-- ===================== start change by divyesh (changes) ===================== -->
                                                            <!-- <li class="item">
                                                                <b class="caption">Sales Consultant Fee : </b>
                                                                <span> {$val.consultant_fee}%</span>
                                                            </li> -->
                                                            <!-- ===================== end change by divyesh (changes) ===================== -->
                                                        </ul>
                                                    </div>
                                                    <div class="col-md-4 col-sm-6 col-xs-6 w100-480">
                                                        <ul class="p0">
                                                            <li class="item">
                                                                <b class="caption">Order Type : </b>
                                                                <span> {$val.order_type_text} </span>
                                                            </li>

                                                            {if $val.trading_type == 'buy'}
                                                            <li class="item">
                                                                <b class="caption">Quantity Requested : </b>
                                                                <span> {$val.qty} {$val.units} </span>
                                                            </li>
                                                            <li class="item">
                                                                <b class="caption">Quantity Fulfilled : </b>
                                                                <span> {$val.req_qty} {$val.units}</span>
                                                            </li>

                                                            {if $val.ue_stax=='y'}
                                                            <li class="item">
                                                                <b class="caption">Sales Tax : </b>
                                                                <span> {$val.ue_stax_per}%</span>
                                                            </li>
                                                            {/if} {/if} {if $val.trading_type == 'sell'}
                                                            <li class="item">
                                                                <b class="caption">Quantity Available for Bid : </b>
                                                                <span> {$val.qty} {$val.units}</span>
                                                            </li>
                                                            <li class="item">
                                                                <b class="caption">Quantity Requested : </b>
                                                                <span> {$val.req_qty} {$val.units} </span>
                                                            </li>
                                                            {/if}

                                                            <li class="item">
                                                                <b class="caption">Price Offered : </b>
                                                                <span> ${$val.req_amount * $val.req_qty} (${$val.req_amount} / {$val.short_unit})</span>
                                                            </li>
                                                            
                                                            {if $val.req_test_result != ''}
                                                            <li class="item">
                                                                <a href="{$config.imgpath}testresult/{$val.req_test_result}" onclick="window.open(this.href); return false;">
                                                                    <b class="caption">View Test Result </b>
                                                                    <i class="fa fa-list icon"></i>
                                                                </a>
                                                            </li>
                                                            {/if}
                                                        </ul>
                                                    </div>
                                                    <div class="col-md-4 col-sm-6 col-xs-6 w100-480">

                                                        {if $val.req_accepted == 1}
                                                            <span class="green">Your bid was accepted</span>
                                                        {/if}
                                                        {if $val.req_rejected == 1}
                                                            <span class="red">Your bid was rejected</span>
                                                            {if $val.req_rejected_msg != ''}
                                                                <span class="slash">|</span>
                                                                <a style="cursor: pointer;" class="w100" class="btn-link" onclick="viewMessage('{$val.req_rejected_msg}')"> View Message</a>
                                                            {/if}
                                                        {/if}
                                                        {if $val.req_accepted == 0 && $val.req_rejected == 0}
                                                            <span class="green">Your bid is pending review by the buyer</span>
                                                        {/if}


                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                                {/foreach} {if $pagination
                                < 1}  
                                    <h2 class="text-center res-f12">
                                        No Records Found...!
                                    </h2> 
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
    <!--/ Page content -->

{include file="common/footer-1.tpl" nocache}

    <script type="text/javascript">
        function acceptRequest(id){
            $('#accept_form'+id).submit();
        };


    </script>

    <script type="text/javascript">
        function viewMessage(rejtxt){
        $("#rej_msg").text(rejtxt);
        $("#viewMessage").modal();
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
   
</body>

</html>