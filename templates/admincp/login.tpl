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

    <link href="https://cdn.datatables.net/1.10.9/css/dataTables.bootstrap.min.css" rel="stylesheet" >
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
    <link href="{$config.dpath}css/mystyle.css" rel="stylesheet">

    <link href="{$config.dpath}css/admin-mystyle.css" rel="stylesheet">

    <style type="text/css">
              .err-message {
        color : red;
      }
    </style>
    </head>

<script type="text/javascript">
    var ILBASE = ASBASE = '{$config.url}';
    function CKupdate(){
        for ( instance in CKEDITOR.instances )
            CKEDITOR.instances[instance].updateElement();
    }
</script>

<body class="admin-body-wrapper">
    <div class="cus-wrapper" id="wrapper">
        <nav class="navbar navbar-inverse navbar-fixed-top cus-navbar-fixed-top shadow" role="navigation" style="text-transform: capitalize;">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/admincp">
                  <img src="{$config.dpath}images/logo.png" alt="">
                </a>
            </div>

            <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
            <div class="collapse navbar-collapse navbar-ex1-collapse cus-admin-navbar">
            {if $loged.admin}
                <ul class="nav navbar-nav side-nav cus-side-nav style-1c">
                    <li  class="{$menu.dashboardmenu}">
                        <a href="{$config.url}/admincp/dashboard/"><i class="fa fa-fw fa-dashboard"></i>{$phrases.dashboard} </a>
                    </li>
                    <li class="{$menu.usersmenu}">
                        <a href="javascript:;" data-toggle="collapse" data-target="#users"  aria-expanded="false"><i class="fa fa-fw fa-user"></i>{$phrases.users}</a>
                        <ul id="users" class="collapse {if $menu.usersmenu} in {/if}" aria-expanded="false">
                            <li class="{$menu.addusersmenu}">
                                <a href="{$config.url}/admincp/users/add" {$auser}>{$phrases.add_users}</a>
                            </li>
                            <li class="{$menu.allusersmenu}">
                                <a href="{$config.url}/admincp/users/">{$phrases.all_users}</a>
                            </li>
                            <li class="{$menu.activeusersmenu}">
                                <a href="{$config.url}/admincp/users/active">{$phrases.active_users}</a>
                            </li>
<!--                             <li class="{$menu.moderateusersmenu}">
                                <a href="{$config.url}/admincp/users/moderate">{$phrases.moderate_users}</a>
                            </li> -->
                            <li class="{$menu.unverifiedusersmenu}">
                                <a href="{$config.url}/admincp/users/unverified">{$phrases.unverified_users}</a>
                            </li>
                             <li class="{$menu.cancelusersmenu}">
                                <a href="{$config.url}/admincp/users/cancel">{$phrases.cancelled_users}</a>
                            </li>
                            <li class="{$menu.searchusersmenu}">
                                <a href="{$config.url}/admincp/users/search">{$phrases.search_users}</a>
                            </li>
                        </ul>
                    </li>
                    <li class="{$menu.payments}">
                        <a href="javascript:;" data-toggle="collapse" data-target="#payments"  aria-expanded="false"><i class="fa fa-fw fa-money"></i>Payments</a>
                        <ul id="payments" class="collapse {if $menu.payments} in {/if}" aria-expanded="false">
                            <li class="{$menu.addusersmenu}">
                                <a href="{$config.url}/admincp/payments/wire" {$auser}>Wire Fund</a>
                            </li>
                            <li class="{$menu.allusersmenu}">
                                <a href="{$config.url}/admincp/payments/check">Check to Herbee</a>
                            </li>
                            <li class="{$menu.activeusersmenu}">
                                <a href="{$config.url}/admincp/payments/gateway">Payment Gateway</a>
                            </li>
                        </ul>
                    </li>
                    <li  class="{$menu.projectsmenu}">
                        <a href="javascript:;" data-toggle="collapse" data-target="#projects" ><i class="fa fa-fw fa-shopping-cart"></i>   {$phrases.products} </a>

                        <ul id="projects" class="collapse {if $menu.projectsmenu} in {/if}"  aria-expanded="true" >
<!--                             <li class="{$menu.projectsnewmenu}">
                                <a href="{$config.url}/admincp/projects/new">{$phrases.new_product}</a>
                            </li> -->
                            <li class="{$menu.projectsearchmenu}">
                                <a href="{$config.url}/admincp/projects/list">{$phrases.all_products}</a>
                            </li>
<!--
                            <li class="{$menu.dealshmenu}">
                                <a href="{$config.url}/admincp/projects/homepage">{$phrases.deals_of_the_day}</a>
                            </li>
                            <li class="{$prosetclass}">
                                <a href="{$config.url}/admincp/pro_settings">Product Settings</a>
                            </li> -->
                        </ul>
                    </li>
                       <li class="{$menu.adsmenu}">
                        <a href="javascript:;" data-toggle="collapse" data-target="#ads"  aria-expanded="false"><i class="fa fa-fw flaticon-business ad-icon"></i>Ads</a>
                        <ul id="ads" class="collapse {if $menu.adsmenu} in {/if}" aria-expanded="false">
                            <li class="{$menu.adsmenustore}">
                                <a href="{$config.url}/admincp/ads/store">Store</a>
                            </li>
                            <li class="{$menu.adsmenuproduct}">
                                <a href="{$config.url}/admincp/ads/product">Product</a>
                            </li>
                            <li class="{$menu.adsmenubrand}">
                                <a href="{$config.url}/admincp/ads/brand">Brand</a>
                            </li>

                            <li class="{$menu.adsmenubrand}">
                                <a href="{$config.url}/admincp/settings/ads">Ads Settings</a>
                            </li>

                        </ul>
                    </li>
<!--                     <li class="{$menu.bannermenu}">
                        <a href="{$config.url}/admincp/banner/list"><i class="fa fa-fw fa-picture-o"></i>  {$phrases.banner} </a>
                    </li> -->

<!--                     <li class="{$menu.disputes}">
                        <a href="{$config.url}/admincp/view_disputes"><i class="fa fa-fw fa-file"></i>  {$phrases.disputes} </a>
                    </li>
 -->
                    <li class="risk_management" style="color:white">
                        <a href="{$config.url}/admincp/risk_management"><i class="fa fa-fw fa-file"></i>  {$phrases.risk_management} </a>
                    </li>

                    <li class="{$menu.membershipmenu}">
                         <a href="javascript:;" data-toggle="collapse" data-target="#membership" ><i class="fa fa-fw fa-newspaper-o"></i>   {$phrases.membership}</a>
                         <ul id="membership" class="collapse {if $menu.membershipmenu} in {/if}"  aria-expanded="true" >
                          <li class="{$menu.plannewmenu}"><a href="{$config.url}/admincp/membership/plans/" > <i class="fa fa-fw fa-sitemap"></i>   {$phrases.plans} </a></li>
                          <li class="{$menu.rolenewmenu}"><a href="{$config.url}/admincp/membership/roles/" > <i class="fa fa-fw fa-sitemap"></i>   {$phrases.roles}</a></li>
                          <li class="{$menu.permissionewmenu}"><a href="{$config.url}/admincp/membership/permission/" > <i class="fa fa-fw fa-sitemap"></i>   {$phrases.membership}</a></li>
                         </ul>

                    </li>
                    <li class="{$menu.categoriesmenu}">
                        <a href="{$config.url}/admincp/categories/list/" > <i class="fa fa-fw fa-tag"></i>   {$phrases.categories}</a>
                    </li>
                    <!-- <li class="{$menu.storecategoriesmenu}">
                        <a href="{$config.url}/admincp/storecategories/list/" > <i class="fa fa-fw fa-tags"></i>  Store Categories</a>
                    </li> -->
                    <!-- <li class="{$menu.primarystoremenu}">
                        <a href="{$config.url}/admincp/primarystore/list/" > <i class="fa fa-fw flaticon-business ad-icon"></i>  Primary Store</a>
                    </li> -->
<!--                     <li class="{$menu.storesubmenu}">
                        <a href="{$config.url}/admincp/storesubscription" > <i class="fa fa-fw fa-thumbs-up"></i>  Store Subscription</a>
                    </li> -->
<!--                     <li class="{$menu.messagesmenu}">
                        <a href="{$config.url}/admincp/messages/" > <i class="fa fa-fw fa-envelope"></i>   {$phrases.messages}</a>
                    </li> -->
                    <li class="{$menu.relationmess}">
                        <a href="{$config.url}/admincp/relationship/" > <i class="fa fa-fw flaticon-working-team ad-icon"></i>   Relationship Details</a>
                    </li>
                    <li class="{$menu.reviewsmenu}">
                        <a href="{$config.url}/admincp/reviews/" > <i class="fa fa-fw flaticon-research-work ad-icon"></i>   {$phrases.reviews}</a>
                    </li>

<!--                   <li class="{$menu.paymentmenu}">
                        <a href="javascript:;" data-toggle="collapse" data-target="#payment"> <i class="fa fa-fw fa-credit-card"></i>    {$phrases.payment}</a>

                        <ul id="payment" class="collapse {if $menu.paymentmenu} in {/if}"  aria-expanded="true" style="  font-size: 12px;">
                         <li class="{$menu.paymentmodulesmenu}"><a href="{$config.url}/admincp/paymentmodules/" > <i class="fa fa-fw fa-sitemap"></i>  {$phrases.payment_modules}</a> </li>
                           <li class="{$menu['withdrawalmenu']}"><a href="{$config.url}/admincp/withdrawal/" ><i class="fa fa-fw fa-money"></i>   {$phrases.withdrawal}</a> </li>
                           </ul>
                    </li> -->
<!--                     <li class="{$menu.currencysetup}">
                        <a href="{$config.url}/admincp/currency_management" > <i class="fa fa-fw fa-file"></i>   {$phrases.currency_management}</a>
                    </li> -->

<!--                     <li class="{$menu.currencysetup}">
                        <a href="{$config.url}/admincp/language_management" > <i class="fa fa-fw fa-file"></i>   {$phrases.language_manager}</a>
                    </li> -->

                  <!-- <li class="{$menu.shippingmenu}">
                        <a href="{$config.url}/admincp/shipping/" > <i class="fa fa-fw fa-file"></i>   {$phrases.shipping_api}</a>
                    </li> -->

<!--                     <li class="{$menu.managementmenu}">
                        <a href="javascript:;" data-toggle="collapse" data-target="#management"> <i class="fa fa-fw fa-edit"></i>   {$phrases.management}</a>

                        <ul id="management" class="collapse {if $menu.managementmenu} in {/if}"  aria-expanded="true" style="  font-size: 12px;">
                         <li class="{$menu.reportsmenu}"><a href="{$config.url}/admincp/reports/" > <i class="fa fa-fw fa-edit"></i>   {$phrases.report_management}</a> </li>
                          <li class="{$menu.notificationmenu}"><a href="{$config.url}/admincp/notification/" > <i class="fa fa-fw fa-edit"></i>   Notification Management</a> </li>
                          <li class="{$menu.emailmgtmenu}"><a href="{$config.url}/admincp/mailers/" > <i class="fa fa-fw fa-edit"></i>  {$phrases.email_sms_management} </a> </li>
                          <li class="{$menu.emailtemplatemenu}"><a href="{$config.url}/admincp/emailtemplate/" > <i class="fa fa-fw fa-edit"></i>  {$phrases.email_template_management}</a> </li>
                           <li class="{$menu.smstemplatemenu}"><a href="{$config.url}/admincp/smstemplate/" > <i class="fa fa-fw fa-edit"></i>  {$phrases.sms_template_management}</a> </li>
                          <li class="{$menu.feedbackmenu}"><a href="{$config.url}/admincp/feedbacknew/" > <i class="fa fa-fw fa-edit"></i>  {$phrases.feedback_management}</a></li>
                         </ul>

                    </li> -->

                    <!--
                    <li class="{$menu.disputemenu}">
                        <a href="{$config.url}/admincp/dispute/" > <i class="fa fa-fw fa-file"></i>  Dispute</a>
                    </li>
                -->
                    <li class="{$menu.referralmenu}">
                        <a href="{$config.url}/admincp/referral/" > <i class="fa fa-fw fa-money"></i>  {$phrases.referrals}</a>
                    </li>

<!--                     <li class="{$menu['transactionmenu']}">
                        <a href="{$config.url}/admincp/transaction/list/" ><i class="fa fa-fw fa-money"></i>  {$phrases.transactions}</a>
                    </li> -->

<!--                     <li class="{$menu['blogmenu']}">
                        <a href="{$config.url}/admincp/blog/" ><i class="fa fa-fw fa-money"></i>  {$phrases.blog}</a>
                    </li> -->
<!--                     <li class="{$menu.forums}">
                        <a href="javascript:;" data-toggle="collapse"  data-target="#forums"  aria-expanded="true"><i class="fa fa-fw fa-money"></i>  {$phrases.forum}</a>
                        <ul id="forums" class="collapse {if $menu.forums} in {/if}" aria-expanded="false" >
                            <li class="{$menu.forumsquestions}">
                                <a href="{$config.url}/admincp/forumquests/" ><i class="fa fa-fw fa-money"></i>  {$phrases.forum_questions}</a>
                            </li>
                            <li class="{$menu.forumscats}">
                                <a href="{$config.url}/admincp/forumcats/" ><i class="fa fa-fw fa-money"></i>  {$phrases.forum_categories}</a>
                            </li>
                        </ul>
                    </li> -->
<!--                     <li class="{$menu.seotools}">
                                <a href="{$config.url}/admincp/seotools">SEO Tools</a>
                            </li> -->
<!-- <<<<<<< HEAD -->
                    <!-- <li class="{$menu.connections}">
                        <a href="javascript:;" data-toggle="collapse"  data-target="#connections"  aria-expanded="true"><i class="fa fa-fw fa-money"></i>  {$phrases.connections}</a>
=======
                    <li class="{$menu.connections}">
                        <a href="javascript:;" data-toggle="collapse"  data-target="#connections"  aria-expanded="true"><i class="fa fa-fw fa-connectdevelop"></i>  {$phrases.connections}</a>
>>>>>>> e473c5aee48a2a8c325a6c0041483fc83e15522c
                        <ul id="connections" class="collapse {if $menu.connections} in {/if}" aria-expanded="false" >
                            <li class="{$menu.guests}">
                                <a href="{$config.url}/admincp/guest_users/" ><i class="fa fa-fw fa-user"></i>  {$phrases.guests}</a>
                            </li>
                            <li class="{$menu.logged}">
                                <a href="{$config.url}/admincp/logged_users/" ><i class="fa fa-fw fa-sign-in"></i>  {$phrases.logged}</a>
                            </li>
                        </ul>
                    </li> -->
                    <li class="{$menu['storemenu']}">
                        <a href="{$config.url}/admincp/stores/" ><i class="fa fa-fw flaticon-business ad-icon"></i>  {$phrases.stores}</a>
                    </li>
  <!--                   <li class="{$menu.settingsmenu}">
                        <a href="javascript:;" data-toggle="collapse"  data-target="#settings"  aria-expanded="true">
                        <i class="fa fa-fw fa-cog"></i>  {$phrases.server_settings}</a>
                        <ul id="settings" class="collapse {if $menu.settingsmenu} in {/if}" aria-expanded="false" >
                            <li class="{$menu.commonsettingsmenu}">
                                <a href="{$config.url}/admincp/settings/common">
                                  <i class="fa fa-fw fa-cog"></i>{$phrases.system}</a>
                            </li>
                            <li class="{$menu.generalsettingsmenu}">
                                <a href="{$config.url}/admincp/settings/general">
                                  <i class="fa fa-fw fa-cog"></i>{$phrases.general}</a>
                            </li>
                            <li class="{$menu.generalsettingsmenu}">
                                <a href="{$config.url}/admincp/settings/authenticate">
                                  <i class="fa fa-fw fa-cog"></i>{$phrases.authenticate}</a>
                            </li>

                            <li class="{$menu.modesettingsmenu}">
                                <a href="{$config.url}/admincp/settings/mode">
                                  <i class="fa fa-fw fa-cog"></i>{$phrases.maintenance_mode} </a>
                            </li>
                            <li class="{$menu.paypalsettingsmenu}">
                                <a href="{$config.url}/admincp/settings/paypal">
                                  <i class="fa fa-fw fa-paypal"></i>{$phrases.paypal}</a>
                            </li>


                             <li class="{$menu.databasesettingsmenu}">
                                <a href="{$config.url}/admincp/settings/database">
                                  <i class="fa fa-fw fa-database"></i>{$phrases.database}</a>
                            </li>
                            <li class="{$menu.cardsettingsmenu}">
                                <a href="{$config.url}/admincp/settings/card">
                                  <i class="fa fa-fw fa-cc-mastercard"></i>{$phrases.credit_card}</a>
                            </li>

                            <li class="{$menu.customeriosettingsmenu}">
                                <a href="{$config.url}/admincp/settings/customerio">CustomerIO</a>
                            </li>
                            <li class="{$menu.facebooksettingsmenu}">
                                <a href="{$config.url}/admincp/settings/facebook">{$phrases.facebook}</a>
                            </li>

                             <li class="{$menu.linkedinsettingsmenu}">
                                <a href="{$config.url}/admincp/settings/linkedin">{$phrases.linkedin}</a>
                            </li>

                        </ul>
                    </li> -->
<!--                       <li class="{$menu.languagemenu}">
                        <a href="javascript:;" data-toggle="collapse"  data-target="#language"  aria-expanded="true">
                        <i class="fa fa-fw fa-language"></i> {$phrases.language_settings}</a>
                        <ul id="language" class="collapse {if $menu.languagemenu} in {/if}" aria-expanded="false" >
                            <li class="{$menu.phraselanguagemenu}">
                                <a href="{$config.url}/admincp/language/phrase">{$phrases.phrases}</a>
                            </li>
                            <li class="{$menu.newphraselanguagemenu}">
                                <a href="{$config.url}/admincp/language/newphrase">{$phrases.new_phrase}</a>
                            </li>
                            <li class="{$menu.membershipmenu}">
                                <a href="{$config.url}/admincp/membership">MemberShip</a>
                            </li>
                             <li class="{$menu.languagelanguagemenu}">
                                <a href="{$config.url}/admincp/language/language">{$phrases.select_language}</a>
                            </li>
                            <li class="{$menu.importlanguagemenu}">
                                <a href="{$config.url}/admincp/language/import">{$phrases.import}</a>
                            </li>
                            <li class="{$menu.exportlanguagemenu}">
                                <a href="{$config.url}/admincp/language/export">{$phrases.export}</a>
                            </li>
                        </ul>
                    </li> -->
                    <!--<li class="{$menu.templatemenu}">
                        <a href="{$config.url}/admincp/template/"><i class="fa fa-fw fa-file"></i> Template</a>
                    </li>-->
<!--                     <li class="{$menu.escrowmenu}">
                        <a href="{$config.url}/admincp/escrow/"><i class="fa fa-fw fa-file"></i> {$phrases.escrow_payments}</a>
                    </li> -->
                    <li class="{$menu.pagesmenu}">
                        <a href="{$config.url}/admincp/static/pages"><i class="fa fa-fw fa-file"></i>  {$phrases.pages}</a>
                    </li>

                    <li>
                        <a href="{$config.url}/login/logout"><i class="fa fa-fw fa-power-off"></i>  {$phrases.logout}</a>
                    </li>

                </ul>
            </div>
            {/if}
            <!-- /.navbar-collapse -->
        </nav>

        <div class="cus-page-wrapper" id="page-wrapper">
  <div class="col-md-6 shadow white-bg p35">
      {if $error == 'saved'}
      <div class="alert alert-success"> <strong>Saved!</strong> {$users.first_name} profile was successfully changed. </div>
      {elseif $error != ''}
      <div class="alert alert-danger"> <strong>{$error}</strong> </div>
      {/if}
      <!-- Page Heading -->
      <div class="row flex">
        <div class="col-sm-10 col-md-10 margin-auto" style="margin-top:2%;">
          <ol class="breadcrumb bg-transparent">
            <li class="active"> <!-- <i class="fa fa-user"></i> --> Login </li>
          </ol>
        </div>
      </div>
      <!-- /.row -->

      <div class="row flex">

        <div class="col-sm-10 col-md-10 margin-auto">
        <!-- <form action="{$config['url']}/admin/login/save" onsubmit="return encrLogin()" method="post"  enctype="multipart/form-data"  > -->
        <form action="{$config['url']}/admin/login/save" method="post"  enctype="multipart/form-data"  >
          <div class="form-label">
            <label>User Name </label>
            <input type="text" id="username" name="username" placeholder="Enter username" value="admin@auctionsoftware.com"  class="form-control w100 p15 pb15  new-white-bg">
          </div>
          <div class="form-label">
            <label>Password </label>
            <input type="password" placeholder="Enter password" id="password" name="password" value="12345678"  class="w100 p15 pb15  new-white-bg">
          </div>
          <br/>
          <div class=""  style="margin-bottom:2%;">
            <button type="submit" value="Login" name="id" class="btn btn btn-default btn-d-b green-b m0">LOGIN</button>
          </div>
        </form>
         </div>
      </div>

      <!-- /.row -->


</div>
<!--Encrypt Password  From Front End-->
<script src="{$config['externaljs']}md5-min.js"  type="text/javascript"></script>

<script type="text/javascript">

  /* function encrLogin(){

    var pwd =  $('#password').val();
    var hex = hex_md5(pwd)+'12345';
    var hmac = hex_md5(hex);

    $('#password').val(hmac);
    return true;
  } */
</script>
<!--Encrypt Password  From Front End-->
{include file="/admincp/footer.tpl" nocache}
