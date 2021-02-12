
{include file="common/header-1.tpl" nocache}


<!--Section1 start Here-->
<section class="reg-bg disflx">
    <div class="container-fluid market-selection-fluid margin-auto">
        <div class="container market-selection-con">
            <div class="row">

                <div class="col-md-3 col-sm-4 transparent-sidebar p0">
                    <ul class="p0 res-tab-p res-mob-flex">
                        <li class=" black-b">
                            <a class="white" href="{$config.url}/profile_settings"><span class="flaticon-settings icon"></span>User Panel</a>
                            <!-- <ul class="see-all">
                                <li><a href="#">See All</a></li>
                            </ul> -->
                        </li>
                        <li class="">
                            <a href="{$config.url}/directbuy#feature-store" class="white" href="directbuy.html"><span class="icon flaticon-business feature-store-icon"></span>Featured Stores</a>
                        </li>
                        <li class="">
                            <a class="white" href="{$config.url}/directbuy#feature-brand"><span class="icon"><img src="{$config['url']}/images/featured.png" class="img-responsive" alt=""></span>Featured Cannabis Brands</a>
                        </li>
                        <!-- <li class="">
                            <a class="white" href="{$config.url}/directbuy#feature-suppliers"><span class="icon"><img src="{$config['url']}/images/deals.png" class="img-responsive" alt=""></span>Featured Suppliers</a>
                        </li> -->
                        <!-- <li class="">
                            <a class="white" href="directbuy.html"><span class="icon"><img src="{$config['url']}/images/sellers.png" class="img-responsive" alt=""></span>Top Sellers</a>
                        </li>
                        <li class="">
                            <a class="white" href="directbuy.html"><span class="icon"><img src="{$config['url']}/images/movers.png" class="img-responsive" alt=""></span>Top Movers</a>
                        </li> -->
                        <li class="">
                            <a href="{$config.url}/directbuy#trending-id" class="white" href="directbuy.html"><span class="icon"><img src="{$config['url']}/images/trending.png" class="img-responsive" alt=""></span>Trending Products</a>
                        </li>
<!--                         <li class="">
                            <a class="white" href="#"><span class="icon"><img src="{$config['url']}/images/discovery.png" class="img-responsive" alt=""></span>Tech Discovery</a>
                        </li> -->
                    </ul>
                </div>

                <div class="col-md-9 col-sm-8 transparent-content-area res-tab-p res-mob w100-767">
                    <h1 class="text-center">
                        Welcome to Herbee! <br>
                        <span>What are you looking to do?</span>
                    </h1>
                    <div class="row">
                        <div class="col-md-12">
                            {if $loged.business_settings.open_bid == 1}
                            <a  href="{$config.url}/dashboard/myoffers"><div class="col-md-3 items-col res-items-col-992">
                                <div class="row">
                                    <div class="col-md-12 large-icon green-b2">
                                        <span class="icon flaticon-admin-with-cogwheels"></span>
                                    </div>
                                    <div class="col-md-12 title white-bg">
                                        <a href="{$config.url}/dashboard/myoffers">Market Activity Dashboard</a>
                                    </div>
                                </div>
                            </div></a>
                            {else}
                            <a href="{$config.url}/dashboard/seller/selling"><div class="col-md-3 items-col res-items-col-992">
                                <div class="row">
                                    <div class="col-md-12 large-icon green-b2">
                                        <span class="icon flaticon-admin-with-cogwheels"></span>
                                    </div>
                                    <div class="col-md-12 title white-bg">
                                        <a href="{$config.url}/dashboard/seller/selling">Market Activity Dashboard</a>
                                    </div>
                                </div>
                            </div></a>
                            {/if}
                            {if $loged.business_type!='dispensary'}
                            {if $storeid == 0}
                            <a href="{$config.url}/stores/create">
                            {/if}
                            {if $storeid > 0}
                            <a href="{$config.url}/stores/view/{$storeid}">
                            {/if}
                            <div class="col-md-3 items-col res-items-col-992">
                                <div class="row">
                                    <div class="col-md-12 large-icon green-b2">
                                        <span class="icon flaticon-business"></span>
                                    </div>
                                    <div class="col-md-12 title white-bg">
                                    {if $storeid > 0}
                                        <a href="{$config.url}/stores/view/{$storeid}">My store</a>
                                     {/if}
                                      {if $storeid == 0}
                                        <a href="{$config.url}/stores/create">Create store</a>
                                     {/if}
                                    </div>
                                </div>
                            </div></a>
                            {/if}

                            {if $loged.business_settings.open_bid == 1}
                            <a  href="{$config.url}/openbid/market">
                                <div class="col-md-3 items-col res-items-col-992">

                                <div class="row">
                                    <div class="col-md-12 large-icon green-b2">
                                        <span class="icon flaticon-auction"></span>
                                    </div>
                                    <div class="col-md-12 title white-bg">
                                       open bid market
                                    </div>
                                </div>
                            </div></a>
                            {/if}

                            <a href="{$config.url}/directbuy"><div class="col-md-3 items-col res-items-col-992">
                                <div class="row">
                                    <div class="col-md-12 large-icon green-b2">
                                        <span class="icon flaticon-shopping-cart"></span>
                                    </div>
                                    <div class="col-md-12 title white-bg">
                                        <a href="{$config.url}/directbuy">direct buy market</a>
                                    </div>
                                </div>
                            </div></a>
                        <!-- </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12"> -->

                            <!-- <a href="{$config.url}/dashboard/market/research"><div class="col-md-3 items-col res-items-col-992"  >
                                <div class="row">
                                    <div class="col-md-12 large-icon green-b2">
                                        <span class="icon flaticon-research-work"></span>
                                    </div>
                                    <div class="col-md-12 title white-bg">
                                        research
                                    </div>
                                </div>
                            </div></a> -->
                            <!-- <a href="{$config.url}/dashboard/relationship/inbox"><div class="col-md-3 items-col res-items-col-992">
                                <div class="row">
                                    <div class="col-md-12 large-icon green-b2">
                                        <span class="icon flaticon-working-team"></span>
                                    </div>
                                    <div class="col-md-12 title white-bg">
                                        relationships
                                    </div>
                                </div>
                            </div></a> -->
                            <a href="{$config.url}/newsfeed"><div class="col-md-3 items-col res-items-col-992">
                                <div class="row">
                                    <div class="col-md-12 large-icon green-b2">
                                        <span class="icon flaticon-blog-1"></span>
                                    </div>
                                    <div class="col-md-12 title white-bg">
                                        News
                                    </div>
                                </div>
                            </div></a>
                            <a href="{$config.url}/distribution"><div class="col-md-3 items-col res-items-col-992">
                                <div class="row">
                                    <div class="col-md-12 large-icon green-b2">
                                        <span class="icon flaticon-blog"></span>
                                    </div>
                                    <div class="col-md-12 title white-bg">
                                        Distribution and Finishing Services
                                    </div>
                                </div>
                            </div></a>

                        </div>


                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<div class="modal fade in" id="success" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header border-0 p0">
                <div class="panel panel-success border-0">
                    <div class="panel-heading green-bg">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h3>Payment Successfully Done !!!</h3>
                    </div>
                </div>
            </div>
            <div class="modal-body">
                <p class="f16 p35 text-center lh-22 black">
                    <span class="green-text" style="font-size:1.5em">Congratulations!</span>
                    <br>
                    <br> Membership purchased successfully....!</p>
            </div>
            <div class="modal-footer">
                <a type="button" class="btn btn-default btn-d-b btn-d-g m5" data-dismiss="modal" aria-hidden="true">Proceed to Herbee</a>
            </div>
<!--             <div class="modal-footer">
                <a type="button" class="btn btn-default btn-d-b btn-d-g m5" href="{$config.url}/market/selection">Proceed to Herbee</a>
            </div> -->
        </div>
    </div>
</div>
<div class="modal fade in" id="adv_err" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header border-0 p0">
                <div class="panel panel-success border-0">
                    <div class="panel-heading green-bg">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                </div>
            </div>
            <div class="modal-body">
                <p class="f16 p35 text-center lh-22 black">
                    <br> Advertising Page Not Available....!</p>
            </div>
            <div class="modal-footer">
                <a type="button" data-dismiss="modal" aria-hidden="true">Close</a>
            </div>
        </div>
    </div>
</div>


<!--Section1 end Here-->

{include file="common/footer-1.tpl" nocache}
{if $error == 'success'}
<script type="text/javascript">
 $('#success').modal().show();
</script>
{/if}
{if $error == 'ads_err'}
<script type="text/javascript">
 $('#adv_err').modal().show();
</script>
{/if}
</body>
</html>
