{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">

                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="icon flaticon-flower-with-leaves"></i> {$phrases.products}
                            </li>
                        </ol>
                    </div>
                </div>

                <!-- products_offered
products_delivered
products_sold
products_future -->
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-shopping-cart fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <!-- <div class="huge">{if $project.open > 0}{$project.open}{else} 0 {/if}</div> -->
                                        <div class="huge">{if $products_offered > 0}{$products_offered}{else} 0 {/if}</div>
                                        <div>Products Offered</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/projects/open">
                                <div class="panel-footer">
                                    <span class="pull-left" onclick="">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-green cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-times-circle fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <!-- <div class="huge">{if $project.closed > 0}{$project.closed}{else} 0 {/if}</div> -->
                                        <div class="huge">{if $products_delivered > 0}{$products_delivered}{else} 0 {/if}</div>
                                        <div>Products Delivered</div>

                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/projects/closed"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right" ><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-yellow cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-trophy fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <!-- <div class="huge"> {if $project.sold > 0}{$project.sold}{else} 0 {/if}</div> -->
                                        <div class="huge">{if $products_sold > 0}{$products_sold}{else} 0 {/if}</div>
                                        <div>Products Sold</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/projects/sold"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-red cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-road fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <!-- <div class="huge">{if $project.future > 0}{$project.future}{else} 0 {/if}</div> -->
                                        <div class="huge">{if $products_future > 0}{$products_future}{else} 0 {/if}</div>
                                        <div>Future Products</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/projects/future"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>

                 <div class="row">
                    <div class="col-lg-12">

                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-money"></i> Transactions
                            </li>
                        </ol>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-gavel fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{if $trans.bid > 0}{$trans.bid}{else} 0 {/if}</div>
                                        <div >Open Market Transactions</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/transaction/list/open"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right" ><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-green cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-money fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{if $trans.buy > 0}{$trans.buy}{else} 0 {/if}</div>
                                        <div>Direct Market Transactions</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/transaction/list/direct"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-yellow cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-users fa-5x"></i> 
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge"> {if $trans.winner > 0}{$trans.winner}{else} 0 {/if}</div>
                                        <div>Recurring Transactions</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/transaction/list/recurring"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-red cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-file-text fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <!-- <div class="huge">{if $trans.sold > 0}{$trans.sold}{else} 0 {/if}</div> -->
                                        <div>Transactions Summary</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/transaction/summery"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
                <!-- /.row -->

                 <div class="row">
                    <div class="col-lg-12">

                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-user"></i> {$phrases.users}
                            </li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-check-circle fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{if $users.active > 0}{$users.active}{else} 0 {/if}</div>
                                        <div>Active Users</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/users/active"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-green cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-users fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{if $users.moderate > 0}{$users.moderate}{else} 0 {/if}</div>
                                        <div>Rejected Users</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/users/moderate"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-yellow cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-user-times fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{if $users.unverified > 0}{$users.unverified}{else} 0 {/if}</div>
                                        <div>Pending Users</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/users/unverified"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-red cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-times fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{if $users.cancel > 0}{$users.cancel}{else} 0 {/if}</div>
                                        <div>Suspended Users</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/users/cancel"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>

                 <div class="row">
                    <div class="col-lg-12">

                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-user"></i> Ads
                            </li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-check-circle fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{if $ads_camps.active_camp > 0}{$ads_camps.active_camp}{else} 0 {/if}</div>
                                        <div>Active Campaign</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/ads/active"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-green cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-users fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{if $ads_camps.inactive_camp > 0}{$ads_camps.inactive_camp}{else} 0 {/if}</div>
                                        <div>Inactive Campaign</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/ads/inactive"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-yellow cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-user-times fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{if $ads.total_clicks > 0}{$ads.total_clicks}{else} 0 {/if}</div>
                                        <div>Total Ads Clicks</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/ads/active"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-red cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-times fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{if $ads.total_revenue > 0}{$ads.total_revenue}{else} 0 {/if}</div>
                                        <div>Ads Revenue</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/ads/active">
                                <div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-bank"></i> Payments
                            </li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-check-circle fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{if $users.funds > 0}{$users.funds}{else} 0 {/if}</div>
                                        <div>Funds to Herbee</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/payments/wire"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-green cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-users fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class=""><h4>{if $users.total_market_dollers > 0}{$users.total_market_dollers}{else} 0 {/if}</h4></div>
                                        <div>Total Market Dollars</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/payments/wire"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-yellow cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-user-times fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class=""><h4>{$transact.sold_amount + $transact.membership_amount}</h4></div>
                                        <div>Total Market Dollars Transacted</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/payments/wire"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-red cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-times fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{$transact.refund_req_amount}</div>
                                        <div>Dollars Requested from Hebee</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/payments/wire"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-money"></i> Fees
                            </li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-check-circle fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <!-- <div class="huge">{$reviews.total_reviews}</div> -->
                                        <div class="huge">0</div>
                                        <div>Transaction Fees</div>
                                    </div>
                                </div>
                            </div>
                            <a href=""><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-green cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-check-circle fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{$taxes_fees.total_distribution_tax}</div>
                                        <div>Distribution Fees</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/transaction/list/?tax_filter=distribution"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-yellow cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-check-circle fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <!-- <div class="huge">{$reviews.total_reviews}</div> -->
                                        <div class="huge">0</div>
                                        <div>Seller Representation Fees</div>
                                    </div>
                                </div>
                            </div>
                            <a href=""><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-red cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-check-circle fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <!-- <div class="huge">{$reviews.total_reviews}</div> -->
                                        <div class="huge">{$DistributorPayment}</div>
                                        <div>Testing Fees</div>
                                    </div>
                                </div>
                            </div>
                            <a href=""><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-star"></i> Taxes
                            </li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-check-circle fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{$taxes_fees.total_cultivation_tax}</div>
                                        <div>Cultivation Tax</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/transaction/list/?tax_filter=cultivation"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-green cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-check-circle fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{$taxes_fees.total_exise_tax}</div>
                                        <div>Excise Tax</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/transaction/list/?tax_filter=excise"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    
                </div>                
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-star"></i> Reviews
                            </li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-check-circle fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{$reviews.total_reviews}</div>
                                        <div>Reviews Posted</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/reviews/"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-handshake-o"></i> Relationships
                            </li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-check-circle fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{$relation.total_msgs}</div>
                                        <div>Relationship Messages</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/relationship/"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-green cus-white-bg">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-users fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">{$relation.total_revenue}</div>
                                        <div>Relationships Revenue</div>
                                    </div>
                                </div>
                            </div>
                            <a href="{$config.url}/admincp/relationship/"><div class="panel-footer">
                                    <span class="pull-left">{$phrases.view_details}</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div>

{include file="/admincp/footer.tpl" nocache}
