{include file="common/header-1.tpl" nocache}

<!-- Page content -->

{include file="common/dashboard-navigation.tpl" nocache}

<!-- <div class="ui-widget">
  <label for="tags">Tags: </label>
  <input id="tags">
</div> -->
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
                     <form enctype="multipart/form-data" method="get" enctype="multipart/form-data" action="{$config.url}/dashboard/myrequests/all/"> 
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
                                <div id="active" class="tab-pane fade in active">

                                    {foreach $myProducts as $key => $val}

                                        <!-- new templates -->
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
                                            <div class="media-body item-col margin-auto grey-bg" style="min-height: 176px;">
                                                <ul class="p0">
                                                    <li>
                                                        <div class="row">
                                                            <div class="col-md-2 col-sm-6 pull-right">
                                                                <div class="inline-block ml-15 pull-right">
                                                                    <a class="" href="{$config.url}/dashboard/openbid/product/edit/{$val.id}"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                                                                    <a class="" href="{$config.url}/dashboard/openbid/product/delete/{$val.id}"><i class="fa fa-trash" aria-hidden="true"></i></a>
                                                                {if $val.total_requests <= 0}
                                                                    
                                                                {/if}
                                                                </div>
                                                            </div>
                                                            <div class="col-md-5 col-sm-6">
                                                                 <ul class="p0">
                                                                    <li class="item"><a class="black" href="{$config.url}/product/view/{$val.id}"><b class="caption">Product Name : </b> <span> {$val.title}</span></a></li>
                                                                    <li class="item"><b class="caption">Target Price :  </b> <span> ${$val.sprice} / {$val.short_unit}</span></li>
                                                                    <li class="item"><b class="caption">Total Quantity :  </b> <span> {$val.qty} {$val.units} </span></li>
                                                                   <!--  <li class="item"><b class="caption">Price per unit:  </b> <span> ${$val.unit_price}/{$val.short_unit}</span></li> -->
                                                                    <li class="item"><b class="caption">Time : </b> <span> {$val.start_date}<!-- 05/09/17 @ 12:05pm --></span></li>
                                                                </ul>
                                                            </div>
                                                            <div class="col-md-5 col-sm-6">
                                                                <ul class="p0">
                                                                    <li class="item"><b class="caption">Order Type :  </b> <span>{$val.order_type_text}</span></li>

                                                                    {if $val.trading_type == 'buy'}
                                                                        {if $val.order_type == 'partial'}
                                                                            <li class="item"><b class="caption">
                                                                            Available Quantity : </b> <span> {$val.rfilled_qty}    {$val.units} </span>
                                                                            </li>
                                                                        {/if}
                                                                    {/if}

                                                                    {if $val.trading_type == 'sell'}
                                                                        {if $val.order_type == 'partial'}
                                                                            <li class="item"><b class="caption">
                                                                            Available Quantity : </b> <span> {$val.rfilled_qty}    {$val.units} </span>
                                                                            </li>
                                                                        {/if}
                                                                    {/if}

                                                                    <li class="item"><a class="black" href="{$config.url}/dashboard/mycorders/{$val.id}"><b class="caption">Total Bids : </b> <span class="inline-block">{$val.total_requests}</span></a>
                                                                    </li>
                                                                    <li class="item"><a class="black" href="{$config.url}/dashboard/{if $val.trading_type=='sell'}mysale{/if}{if $val.trading_type=='buy'}mypurchase{/if}/{$val.id}"><b class="caption">Accepted Bids : </b> <span class="inline-block">{$val.accepted_requests}</span></a>
                                                                    </li>
                                                                    <li class="item"><a class="black" href="{$config.url}/dashboard/{if $val.trading_type=='sell'}myrsale{/if}{if $val.trading_type=='buy'}myrpurchase{/if}/{$val.id}"><b class="caption">Rejected Bids : </b> <span class="inline-block">{$val.rejected_requests}</span></a>
                                                                    </li>
                                                                </ul>
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
    <!--/ Page content -->

{include file="common/footer-1.tpl" nocache}

    <script type="text/javascript">

  $('#pagination').find('ul').addClass('pagination-ul flex m50 m-b-0');
  $('#pagination').find('ul').removeClass('pagination');

    </script>
    
</body>

</html>

<!-- <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/owl.carousel.min.js"> -->

</script>
</body>
</html>
