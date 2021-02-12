<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Admin</title>

    <!-- Bootstrap Core CSS -->
    <link href="{$config.dpath}css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="{$config['externalcss']}font-awesome.css">

    <!-- Custom CSS -->
    <link href="{$config.dpath}css/sb-admin.css" rel="stylesheet">
    <link rel="stylesheet" href="{$config.dpath}css/flaticon.css">
    <!-- Font awsome -->
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}intlTelInput.css">
    <link rel="stylesheet" href="{$config.dpath}css/datePicker.css" type="text/css" />
    <link rel="stylesheet" href="{$config.dpath}css/jquery.datetimepicker.css" type="text/css" />
    <link href="https://cdn.datatables.net/1.10.9/css/dataTables.bootstrap.min.css" rel="stylesheet">
    {foreach $external2css as $key => $val}
    <link rel="stylesheet" href="{$config['externalcss']}{$val}.css" type="text/css" />
    {/foreach}
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="{$config['externaljs']}country.js" type="text/javascript"></script>
    <script src="{$config['externaljs']}ckeditor/ckeditor.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.min.css" rel="stylesheet">
    <link href="{$config.dpath}css/mystyle.css" rel="stylesheet">

    <link href="{$config.dpath}css/admin-mystyle.css" rel="stylesheet">
    <link href="{$config.dpath}css/sweetalert2.min.css" rel="stylesheet">
    <link href="{$config.dpath}css/datePicker.css" rel="stylesheet">
    <script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>
    <script src="{$config.url}/js/common_admin.js"></script>
    <script src="{$config.url}/socket.io/socket.io.js"></script>

    <style type="text/css">
        .err-message {
            color: red;
        }
        .fa-5x {
            font-size: 5em !important;
        }
    </style>
</head>

<script type="text/javascript">
  var config_url = '{$config.url}';
  var base_url = '{$config.url}';

    var ILBASE = ASBASE = '{$config.url}';
    function CKupdate() {
        for (instance in CKEDITOR.instances)
            CKEDITOR.instances[instance].updateElement();
    }
    var socket = io.connect();
    var servertime = new Date();
    /* socket.on('kva_server_time', function (omg) {
        servertime = new Date(omg);
        return false;
    }); */
    socket.on('sliservertime', function(msg){
        servertime  = new Date(msg.dTime);
        return false;
    });

    var logic = function (currentDateTime) {
        if (currentDateTime.getDate() == servertime.getDate()) {
            this.setOptions({
                minTime: addZero(servertime.getHours()) + ':' + addZero(servertime.getMinutes())
            });
        } else
            this.setOptions({
                minTime: '00:00'
            });
    };
    function addZero(i) {
        if (i < 10) {
            i = "0" + i;
        }
        return i;
    }
</script>

<body class="admin-body-wrapper">
    <div id="wrapper">
        <nav class="navbar navbar-inverse navbar-fixed-top cus-navbar-fixed-top shadow" role="navigation"
            style="text-transform: capitalize;">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                {if $loged.admin}
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="fa fa-bars"></span>
                </button>
                {/if}
                <a class="navbar-brand" href="/admincp">
                    <img src="{$config.dpath}images/logo.png" alt="">
                </a> 
            </div>
            {* {if $loged.admin && $loged.role==0}
                <a class="btn btn-top2 btn-success" href="/admincp/subadmin">
                    Create Sub Admin
                </a>
            {/if} *}
            <a href="{$config.url}/login/logout" class="btn btn-top btn-success">Logout</a>

            <div class="collapse navbar-collapse navbar-ex1-collapse cus-admin-navbar">
                <a class="visible-xs menu-close" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                  <i class="fa fa-times"></i>
                </a>
                {if $loged.admin && $loged.role==0}

                <ul class="nav navbar-nav side-nav cus-side-nav style-1c">

                    <li class="{$menu.dashboardmenu}">
                        <a href="{$config.url}/admincp/dashboard/"><i
                                class="fa fa-fw fa-home"></i>{$phrases.dashboard}
                        </a>
                    </li>

                    {* <li class="{$menu.subadmin}">
                        <a href="javascript:;" data-toggle="collapse" data-target="#subadmin" aria-expanded="false"><i
                                class="fa fa-fw fa-user"></i>Subadmin</a>
                        <ul id="subadmin" class="collapse {if $menu.subadmin} in {/if}" aria-expanded="false">
                            <li class="{$menu.all}">
                                <a href="{$config.url}/admincp/subadmin/all">Subadmin List</a>
                            </li>
                        </ul>
                    </li> *}

                    <!-- ===================== start change by divyesh (added) ===================== -->
                    <li class="{$menu.consultantmenu}" style="display: none;">
                        <a href="javascript:;" data-toggle="collapse" data-target="#consultant"> <i
                                class="fa fa-fw fa-area-chart"></i> Sales Consultant</a>
                        <ul id="consultant" class="collapse {if $menu.consultantmenu} in {/if}" aria-expanded="true">
                            <li class="{$menu.salesusers}"><a href="{$config.url}/admincp/salesusers/search">Users List</a></li>
                            <li class="{$menu.consultan_code}">
                                <a href="{$config.url}/admincp/consultant_code/add">Generate code</a>
                            </li>
                            <li class="{$menu.consultan_codeList}"><a
                                    href="{$config.url}/admincp/consultant_code/all">Generated Code List</a></li>

                            <li class="{$menu.consultantmenuSub}">
                                <a href="javascript:;" data-toggle="collapse" data-target="#consultantSub"> <i
                                        class="fa fa-fw fa-file"></i> Reports</a>

                                <ul id="consultantSub" class="collapse {if $menu.consultantmenuSub} in {/if}"
                                    aria-expanded="true">
                                    <li class="{$menu.report_client}"><a
                                            href="{$config.url}/admincp/report/clients/search">Client Report</a></li>
                                    <li class="{$menu.report_sales_transaction}"><a
                                            href="{$config.url}/admincp/report/sales-transaction/search">Sales
                                            transaction Report</a></li>
                                </ul>
                            </li>

                            <li class="{$menu.purchase}"><a href="{$config.url}/admincp/purchase">Purchase</a></li>

                            <li class="{$menu.purchaseHistory}"><a href="{$config.url}/admincp/purchase-history/search">Purchase History</a></li>

                        </ul>
                    </li>
                    <!-- ===================== end change by divyesh (added) ===================== -->

                    <li class="{$menu.usersmenu}">
                        <a href="javascript:;" data-toggle="collapse" data-target="#users" aria-expanded="false"><i
                                class="fa fa-fw fa-user"></i>{$phrases.users}</a>
                        <ul id="users" class="collapse {if $menu.usersmenu} in {/if}" aria-expanded="false">
                           
                            <li class="{$menu.searchusersmenu}">
                                <a href="{$config.url}/admincp/users/search">Users List</a>
                            </li>
 
                        </ul>
                    </li>
                    <li class="{$menu.subscription_usersmenu}">
                        <a href="{$config.url}/admincp/subscription_users/"> <i class="fa fa-fw fa-users"></i>
                            Subscription Users</a>
                    </li>

                    <li class="{$menu.projectsmenu}">
                        <a href="javascript:;" data-toggle="collapse" data-target="#projects"><i
                                class="fa fa-fw fa-shopping-cart"></i>
                            {$phrases.products} </a>

                        <ul id="projects" class="collapse {if $menu.projectsmenu} in {/if}" aria-expanded="true"> 
                            <li class="{$menu.allprojectsmenu}">
                                <a href="{$config.url}/admincp/products">Auctions List</a>
                            </li>
                            <li class="{$menu.featuredprojectsmenu}">
                                <a href="{$config.url}/admincp/products/featured">Featured Auctions</a>
                            </li>
                            <li class="{$menu.upcomingprojectsmenu}">
                                <a href="{$config.url}/admincp/products/upcoming">Upcoming Auctions</a>
                            </li>
                            <li class="{$menu.offermessagemenu}">
                                <a href="{$config.url}/admincp/product/offer_message">Chat Message</a>
                            </li>
                        </ul>
                    </li>
                    <li class="{$menu.seo_management}">
                        <a href="{$config.url}/admincp/seo_management/"> <i class="fa fa-fw fa-shopping-cart"></i>
                            SEO Management</a>
                    </li>
                    <li class="{$menu.adsmenu}">
                        <a href="{$config.url}/admincp/ads/"> <i class="fa fa-fw fa-money"></i>
                            Ads</a>
                    </li>
                    <li class="{$menu.classifiedsmenu}">
                        <a href="{$config.url}/admincp/classifieds/"> <i class="fa fa-fw fa-money"></i>
                            Classifieds</a>
                    </li>

                    <li class="{$menu.measurementsmenu}">
                        <a href="javascript:;" data-toggle="collapse" data-target="#measurements"><i
                                class="fa fa-fw fa-shopping-cart"></i>
                            {if $phrases.measurements} $phrases.measurement {else/} Measurements {/if}</a>
                        <ul id="measurements" class="collapse {if $menu.measurementsmenu} in {/if}" aria-expanded="true">
                            <li class="{$menu.allmeasurementsmenu}">
                                <a href="{$config.url}/admincp/measurements">Measurements List</a>
                            </li>
                        </ul>
                    </li>

                    <li class="{$menu.payments}" style="display: none;">
                        <a href="javascript:;" data-toggle="collapse" data-target="#payments" aria-expanded="false"><i
                                class="fa fa-fw fa-money"></i>Payments</a>
                        <ul id="payments" class="collapse {if $menu.payments} in {/if}" aria-expanded="false">
                            <li class="{$menu.wire}">
                                <a href="{$config.url}/admincp/payments/wire">Funds via Wire</a>
                            </li>
                            <li class="{$menu.check}">
                                <a href="{$config.url}/admincp/payments/check">Funds via Check</a>
                            </li>
                            <li class="{$menu.gateway}">
                                <a href="{$config.url}/admincp/payments/gateway">Funds via Payment Gateway</a>
                            </li>
                            <li class="{$menu.refund}">
                                <a href="{$config.url}/admincp/payments/refund">Refunds Requested</a>
                            </li> 
                        </ul>
                    </li>
                     
                    <li class="{$menu.categoriesmenu}">
                        <a href="{$config.url}/admincp/categories/list/"> <i class="fa fa-fw fa-tag"></i>
                            {$phrases.categories}</a>
                    </li> 
                    <li class="{$menu.messagesmenu}">
                        <a href="{$config.url}/admincp/messages/"> <i class="fa fa-fw fa-envelope"></i>
                            {$phrases.messages}</a>
                    </li>
                    <li class="{$menu.contactmsgsmenu}">
                        <a href="{$config.url}/admincp/contact/msgs"> <i class="fa fa-fw fa-envelope"></i>
                            Service Messages</a>
                    </li> 
                    <li class="{$menu.reviewsmenu}">
                        <a href="{$config.url}/admincp/reviews/"> <i
                                class="fa fa-fw flaticon-research-work ad-icon"></i>
                            {$phrases.reviews}</a>
                    </li>
 

                    <li class="{$menu.managementmenu}">
                        <a href="javascript:;" data-toggle="collapse" data-target="#management"> <i
                                class="fa fa-fw fa-edit"></i>
                            {$phrases.management}</a>

                        <ul id="management" class="collapse {if $menu.managementmenu} in {/if}" aria-expanded="true"
                            style="  font-size: 12px;">
                            <li class="{$menu.reportsmenu}" style="display: none;"><a href="{$config.url}/admincp/reports/"> <i
                                        class="fa fa-fw fa-edit"></i>
                                    {$phrases.report_management}</a> </li> 
                            <li class="{$menu.emailtemplatemenu}"><a href="{$config.url}/admincp/emailtemplate/"> <i
                                        class="fa fa-fw fa-edit"></i> {$phrases.email_template_management}</a> </li> 
                        </ul>

                    </li> 

                    <li class="{$menu.referral_program_menu}">
                        <a href="{$config.url}/admincp/referral_program/"> <i class="fa fa-fw fa-money"></i> Referral Affiliate Program</a>
                    </li>
                    <li class="{$menu.referralmenu}">
                        <a href="{$config.url}/admincp/referrals/"> <i class="fa fa-fw fa-money"></i>
                            {$phrases.referrals}</a>
                    </li>
                    <li class="{$menu.referral_banner_menu}">
                        <a href="{$config.url}/admincp/referral_banners/"> <i class="fa fa-fw fa-money"></i>
                            Referral Banners</a>
                    </li>
                    <li class="{$menu.transactions_menu}">
                        <a href="{$config.url}/admincp/transactions/"> <i class="fa fa-fw fa-money"></i>
                            Transactions</a>
                    </li>
                    <li class="{$menu.withdrawal_request_menu}">
                        <a href="{$config.url}/admincp/withdrawal_request/"> <i class="fa fa-fw fa-money"></i>
                            Withdrawal Request</a>
                    </li>

                    <li class="{$menu['transactionmenu']}" style="display: none;">
                        <a href="javascript:;" data-toggle="collapse" data-target="#transaction"> <i
                                class="fa fa-fw fa-money"></i>
                            Transaction Details</a>
                        <ul id="transaction" class="collapse {if $menu.transactionmenu} in {/if}" aria-expanded="true">
                            <li class="{$menu.list}"><a href="{$config.url}/admincp/transaction/list/"> All
                                    Transactions </a></li>
                            <li class="{$menu.open}"><a href="{$config.url}/admincp/transaction/list/open"> Open Market
                                    Transactions </a></li>
                            <li class="{$menu.direct}"><a href="{$config.url}/admincp/transaction/list/direct"> Direct
                                    Market Transactions </a></li>
                            <li class="{$menu.recurring}"><a href="{$config.url}/admincp/transaction/list/recurring">
                                    Recurring Transactions </a></li>
                            <li class="{$menu.summery}"><a href="{$config.url}/admincp/transaction/summery/">
                                    Transactions Summary </a></li>
                        </ul>

                    </li> 
                    <li class="{$menu.settingsmenu}">
                        <a href="{$config.url}/admincp/settings/general"><i class="fa fa-fw fa-cog"></i>General
                            Settings</a>
                    </li>
                     
                    <li class="{$menu.pagesmenu}">
                        <a href="{$config.url}/admincp/static/pages"><i class="fa fa-fw fa-file"></i>
                            {$phrases.pages}</a>
                    </li>
 
                </ul>
                {/if}
                {if $loged.admin && ($loged.role==2 || $loged.role==3)}
                <ul class="nav navbar-nav side-nav cus-side-nav style-1c">
                        <!-- ===================== start change by divyesh (added) ===================== -->
                        <li class="{$menu.consultantmenu}">
                            <a href="javascript:;" data-toggle="collapse" data-target="#consultant">
                              <i class="fa fa-fw fa-area-chart"></i> Sales Consultant </a>
                            <ul id="consultant" class="collapse {if $menu.consultantmenu} in {/if}" aria-expanded="true">
                                <li class="{$menu.salesusers}"><a href="{$config.url}/salesadmin/salesusers/search">
                                  <i class="fa fa-user"></i>Users List</a></li>
                                <li class="{$menu.consultan_code}">
                                    <a href="{$config.url}/salesadmin/consultant_code/add">
                                      <i class="fa fa-code"></i> Generate code </a>
                                </li>
                                <li class="{$menu.consultan_codeList}"><a
                                        href="{$config.url}/salesadmin/consultant_code/all">
                                        <i class="fa fa-list-alt"></i> Generated Code List </a></li>

                                <li class="{$menu.consultantmenuSub}">
                                    <a href="javascript:;" data-toggle="collapse" data-target="#consultantSub">
                                      <i class="fa fa-fw fa-file"></i> Reports</a>

                                    <ul id="consultantSub" class="collapse {if $menu.consultantmenuSub} in {/if}"
                                        aria-expanded="true">
                                        <li class="{$menu.report_client}"><a
                                                href="{$config.url}/salesadmin/report/clients/search">Client Report</a></li>
                                        <li class="{$menu.report_sales_transaction}"><a
                                                href="{$config.url}/salesadmin/report/sales-transaction/search">Sales
                                                transaction Report</a></li>
                                    </ul>
                                </li>

                                <li class="{$menu.purchase}"><a href="{$config.url}/salesadmin/purchase">
                                  <i class="fa fa-money"></i> Purchase</a></li>

                                <li class="{$menu.purchaseHistory}"><a href="{$config.url}/salesadmin/purchase-history/search">
                                  <i class="fa fa-history"></i> Purchase History</a></li>
                            </ul>
                        </li>
                        <!-- ===================== end change by divyesh (added) ===================== -->

                    </ul>
                {/if}

                 {if $loged.admin && $loged.role==4}

                <!-- <div class="collapse navbar-collapse navbar-ex1-collapse cus-admin-navbar">       -->
                    <ul class="nav navbar-nav side-nav cus-side-nav style-1c">
                            <!-- ===================== start change by jakir (added) ===================== -->
                        <li class="active">
                            <a href="javascript:;" data-toggle="collapse" data-target="#consultant" class="" aria-expanded="true">
                                <i class="fa fa-fw fa-area-chart"></i> Distributor Consultant </a>
                            <ul id="consultant" in="" aria-expanded="true" class="collapse in" style="">
                                <li class="{$menu['transactionmenu']}">
                                    <a href="{$config.url}/distributoradmin/transaction/product/" data-toggle="collapse" data-target="#transaction"> <i class="fa fa-fw fa-money"></i>
                                        Transaction Details</a>
                                </li>
                                <li class="{$menu['storemenu']}">
                                    <a href="{$config.url}/distributoradmin/stores/"><i class="fa fa-fw flaticon-business ad-icon"></i>
                                        Stores</a>
                                </li>
                                <li class="{$menu['product_invoices']}">
                                    <a href="{$config.url}/distributoradmin/product_invoices/"><i class="fa fa-fw fa-file-text"></i>
                                        Invoices</a>
                                </li>
                                <li class="{$menu.settingsmenu}">
                                    <a href="{$config.url}/distributoradmin/distributor/general"><i class="fa fa-fw fa-cog"></i>General
                                        Settings</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                <!-- </div> -->
                {/if}

            </div>

            <!-- /.navbar-collapse -->
        </nav>

        <div id="page-wrapper">
