<!DOCTYPE html>
<!--[if IE 8]> <html class="no-js lt-ie9 ie8" lang="en"> <![endif]-->
<!--[if IE 9]> <html class="ie9" lang="en"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en"> <!--<![endif]-->
<head>
  <!-- Metas
  ================================================== -->
  <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, user-scalable=no, target-densitydpi=device-dpi"/>
  <meta name="description" content="" />
  <meta property="og:description" content="Your Friend has invited to join {$config['url']}" />
  <meta property="og:image" content="{$config['url']}/images/logo.ic.png" />
  <meta name="keywords" content="" />
  <meta name="author" content="" />

<title>{$config.title}</title>

<!-- Favicon
  ================================================== -->
<link rel="shortcut icon" href="{$config['url']}/images/logo.ic.png">

<!-- Google fonts
  ================================================== -->

<link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,600,700,800,300' rel='stylesheet' type='text/css' />

<!-- bootstrap v3.0.2
  ================================================== -->

<link rel="stylesheet" href="{$config['externalcss']}bootstrap.css">

<!--font-awesome
  ================================================== -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" type="text/css">

<!-- CSS Custom
  ================================================== -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="{$config['externalcss']}reset-min.css" />
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}common.css" />
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}style.css" />
<!-- <link rel="stylesheet" type="text/css" href="{$config['externalcss']}chemexange.css" /> -->
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}theme{$themeno}.css" />
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}forward_home.css" />
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}jsfeaturestory_large.css" />
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}owl.carousel.css" />
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}common_responsive.css" />
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}common_responsive1.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/r/dt/dt-1.10.9/datatables.min.css"/>
    <script src="{$config['externaljs']}common.js" type="text/javascript"></script>
<!--Encrypt Password  From Front End-->
<script src="{$config['externaljs']}md5-min.js"  type="text/javascript"></script>
    <script src="{$config['externaljs']}country.js"  type="text/javascript"></script>
    <script src="{$config['externaljs']}html5lightbox.js"  type="text/javascript"></script>
<script type="text/javascript">

/*  function encrLogin(){

    var pwd =  $('#password').val();
    var hex = hex_md5(pwd)+'12345';
    var hmac = hex_md5(hex);

    $('#password').val(hmac);
    return true;
  }

  function encrLogin2(){

    var pwd =  $('#u_pass').val();
    var hex = hex_md5(pwd)+'12345';
    var hmac = hex_md5(hex);

    $('#u_pass').val(hmac);
    $('#loginform').submit();
  }*/

</script>
<!--Encrypt Password  From Front End ends-->
<script src="{$config.url}/socket.io/socket.io.js"></script>
<script type="application/javascript" src="{$config['externaljs']}owl.carousel.js"></script>
    <script src="{$config['externaljs']}ckeditor/ckeditor.js"></script>

<script>
  var socket = io.connect();
  var ILBASE = ASBASE = '{$config.url}';
  $(window).on('beforeunload', function(){
    socket.close();
  });
</script>
{foreach $external2css as $key => $val}
  <link rel="stylesheet" href="{$config['externalcss']}{$val}.css" type="text/css" />
{/foreach}

 <script type="text/javascript">
    $(document.documentElement).addClass('featurestory-enabled');
 </script>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
      <script src="js/respond.min.js"></script>

    <![endif]-->
<!--[if lt IE 9]>
<div class="menu_btm">
      <div class="row">

        <div class="col-md-6">

        </div>
      </div>
<![endif]-->

<script type="text/javascript">var switchTo5x=true;</script>
<script type="text/javascript" src="https://w.sharethis.com/button/buttons.js"></script>
<script type="text/javascript">
   stLight.options({
                publisher:'6f0428f3-831e-4577-8e5c-e1fdc2d3292d',
        });
   </script>
</head>
<script type="text/javascript">
    function CKupdate(){
        for ( instance in CKEDITOR.instances )
            CKEDITOR.instances[instance].updateElement();
    }
</script>

<body>

<style>
.searengiw2{
    padding-left: 15px;
    padding-top: 4px;
}
	</style>



 {if $mode neq 'yes'}
  <nav class="navbar-custom" role="navigation">
   <div class="container">
    <div class="row">
        <div class="col-md-5 col-sm-5 col-xs-12 pull-left cust_serrr">{$pharse.customer_service} 9722005516</div>


        <div class="col-md-7 col-sm-6 col-xs-12 welcome-msg text-right">
          <div class="pull-left ab1" style="margin-right:5px" >
            <span class="cursor ">View as</span>  &nbsp;
            &nbsp; <form action="{$config['url']}/index/changetheme" id="change_theme" class="pull-right" method="post" enctype="multipart/form-data"  >
             <input type="hidden" name="gopage"  value= "{$config['url']}{$pageofjs}">
                 <select onChange="$('#change_theme').submit()" name="themeno" style="color:#000">

                    <option value="0" {if $themeno == 0} selected {/if}>{$pharse.black_forest}</option>
                     <option value="1" {if $themeno == 1} selected {/if}>{$pharse.baby_blue}</option>
                    <option value="2" {if $themeno == 2} selected {/if}>{$pharse.glossy_byzantium}</option>
                    <option value="3" {if $themeno == 3} selected {/if}>{$pharse.deep_red}</option>
                    <option value="4" {if $themeno == 4} selected {/if}>{$pharse.auction_stone} </option>
                 </select>
            </form>

         </div>
        <div class="pull-left ab1" style="margin-right:5px">
            <span class="cursor ">Login as</span>  &nbsp;
            <form action="{$config['url']}/login/save" id="autologin" method="post" class=" pull-right" enctype="multipart/form-data"  >
                 <input type="hidden" name="autologin"  value= "1">
                 <input type="hidden" name="username" id="autologinuserid"  value= "">
                 <select onChange="loginauto(this)" name="autologinoption" style="color:#000;width:100px;">
                    <option value="0" {if $autologin == 0} selected {/if}>{$pharse.select}</option>
                    <option value="buyer" {if $autologin == 'buyer'} selected {/if}>{$pharse.buyer}</option>
                    <option value="seller" {if $autologin == 'seller'} selected {/if}>{$pharse.seller}</option>
                    <option value="admin" {if $autologin == 'admin'} selected {/if}>{$pharse.admin}</option>
                 </select>
            </form>
         </div>


           <div class="wlcome_rht pull-right">
        
          {if $loged.userid > 0}<a href="{$config.url}/profile_settings">{$loged.first_name}</a> <a href="{$config.url}/login/logout" >{$pharse.log_out}</a>{else}<a href="" data-toggle="modal" data-target="#registration">{$pharse.register}</a> or <a href=""  data-toggle="modal" data-target="#Login">{$pharse.sign_in}</a>{/if} </div>
           </div>
      </div>
  </div>
 </nav>
 {/if}
    <div class="timer_cnt" style="display:none;">
       <span>{$pharse.please_pay_with_in}  <font class="cnter">{$timer}</font> {$pharse.seconds}. <a href="{$config.url}/product/checkout/confirm/">{$pharse.bay_now}</a> </span>
    </div>

  <header>
   <div class="container">
    <div class="row">
       <div class="col-md-4 col-sm-4 col-xs-12 logo_container"> <a href="{$config.url}"><img  class="img-responsive" src="{$config.url}/images/home/logo.png" class="img-responsive" alt="Auctionsoftware"/></a> </div>
       {if $mode neq 'yes'}
       <div class="col-md-8 col-sm-8 col-xs-12 pull-right" style="padding-left: 0;padding-right: 0;">
        <div class="col-md-7 col-sm-7 col-xs-6 pull-left" style="padding-left: 0;padding-right: 0;">
          <ul class="list-inline new_bright_li">
             <li><a href="{$config.url}/search/?type=1">{$pharse.auction}</a></li>
             <li><a href="{$config.url}/search/?type=2">{$pharse.bay_now}</a></li>
             <li><a href="{$config.url}/search/?type=3">{$pharse.featured}</a></li>
              {if $config.stores.enable && $loged.userid > 0}
              <li><a href="{$config.url}/stores/create">{$pharse.your_store}</a></li>
              <li><a href="{$config.url}/classified" style="border-right: transparent !important;">{$pharse.classified}</a></li>
              {/if}
          </ul>
       </div>
        <div class="col-md-6 col-sm-5 col-xs-6 customer_service_block">
        <a href="#" data-toggle="modal" {if $loged.pid != ''} data-target="#stre1" {/if}> <div class="cart_himg col-md-3 pull-left" style="width:130px" >
            <div class="cartyynew cart" style="cursor: pointer;">{if $loged.pid == ''}0{else}{$loged.pid|count}


          {/if}</div>
          </div>
          <div class="col-md-9 nmyaccount" style="width:135px;">

          {if $loged.userid > 0}
            <a href="{$config.url}/dashboard/" title="{$loged.first_name}" class="dropdown-toggle macc" data-toggle="dropdown">{$pharse.my_account} <span class="caret"></span> </a>

                <ul class="dropdown-menu animated-dropdown">
                  <li><a href="{$config.url}/product/post">{$pharse.sell_an_item}</a></li>
                  <li><a href="{$config.url}/dashboard/mybids">{$pharse.buyer_dashboard}</a></li>
                  <li><a href="{$config.url}/dashboard/my">{$pharse.seller_dashboard}</a></li>
                  <li><a href="{$config.url}/dashboard/messages">{$pharse.messages}</a></li>
                  <li><a href="{$config.url}/dashboard/watchlist">{$pharse.watchlist}</a></li>
                  <!--{if $config.stores.enable}
                  <li><a href="{$config.url}/stores/create">Your Store</a></li>
                  {/if}-->
                  <li><a href="{$config.url}/profile_settings">{$pharse.profile}</a></li>
                    <li><a href="{$config.url}/membership/setup">{$pharse.membership}</a></li>
                  <li><a href="{$config.url}/dashboard/payments">{$pharse.payments}</a></li>
                  <li><a href="{$config.url}/dashboard/payment/saved">{$pharse.saved_payments}</a></li>
                    <li><a href="{$config.url}/adwords/show_adwords">{$pharse.my_banner_ads}</a></li>
                  </ul>
                  {else}
                  {$pharse.guest}
                  {/if}
                </div>
         </div>
      </div>
      {/if}
     </div>
  </div>
 </header>
  {if $mode neq 'yes'}
 <section class="search_portion">
   <div class="container">
    <div class="row">
       <div class="col-md-12">
        <div class="row header-bot">
           <!-- start navigation -->
           <div class="col-xs-6 col-sm-5 col-md-3 navigation22">
            <ul>
               <li class="active"><a href="javascript:void(0)"><span>{$pharse.shop_by_category}</span></a>
                <ul>
                   <li aria-haspopup="true"><a href="{$config.url}/search/" title="All categories" role="menuitem" class="nav-menu-link"><strong>{$pharse.all_categories}</strong></a>
                    <div class="dropdown" style="">
                       <div class="col pull-left">
                        <ul>
                          {$i=0}
                          {foreach $category as $key => $val}<span style="display:none">{$i++}</span>
                          	{if $i <= 15}<li><a href="{$config.url}/search/?cid={$val.id}" title="{$val.name}">{$val.name}</a></li>{/if}                          {/foreach}
                         </ul>
                      </div>
                       <div class="col pull-left">
                        <ul>
                          {$i=0}
                          {foreach $category as $key => $val}<span style="display:none">{$i++}</span>
                          	{if $i > 15 && $i <= 30}<li><a href="{$config.url}/search/?cid={$val.id}" title="{$val.name}">{$val.name}</a></li>{/if}                          {/foreach}
                         </ul>
                      </div>
                      <div class="clear"></div>
                       <div class="row-link"><a href="{$config.url}/search/" title="All categories">{$pharse.all_categories}</a></div>
                     </div>
                  </li>
                  {foreach $category as $key => $val}
                   {if $val.parent_id == 0}
                   <li aria-haspopup="true"><a href="{$config.url}/search/?cid={$val.id}" title="{$val.name}" role="menuitem" class="nav-menu-link">{$val.name}</a>

                    <div class="dropdown">
                      <div class="col pull-left">
                        <ul>
                          {$i=0}
                          {foreach $category as $key2 => $val2}
                              {if $i <= 15}
                                   {if $val2.parent_id == $val.id}
                                        <span style="display:none">{$i++}</span>
                                        <li><a href="{$config.url}/search/?cid={$val2.id}" title="{$val2.name}">{$val2.name}</a></li>
                                   {/if}
                              {/if}
                         {/foreach}
                         </ul>
                      </div>
                       <div class="col pull-left">
                        <ul>
                          {$i=0}
                          {foreach $category as $key2 => $val2}
                              {if $i > 15 && $i <= 30}
                                  {if $val2.parent_id == $val.id}
                                    <span style="display:none">{$i++}</span>
                                    <li><a href="{$config.url}/search/?cid={$val2.id}" title="{$val2.name}">{$val2.name}</a></li>
                                  {/if}
                              {/if}
                          {/foreach}
                        </ul>
                       </div>
                       <div class="clear"></div>
                       <div class="row-link">
                       	   <a href="{$config.url}/search/?cid={$val.id}" title="All categories in {$val.name}">{$pharse.all_categories_in} {$val.name}</a>
                       </div>
                     </div>
                  </li>
                  {/if}
                   {/foreach}
                 </ul>
              </li>
             </ul>
          </div>
           <!-- end navigation -->
           <!-- start search -->
           <div class="col-md-9 col-sm-7 col-xs-6 search pull-right">
            <form action="{$config.url}/search" id="user_search" name="user_search" method="post" enctype="multipart/form-data">
              <!-- <label>Search</label>-->
               <!-- start search-box -->
               <div class="nopadmar">
                   <!--<div class="search-menu"> <a href="javascript:;" title="All categories" class="menu-link"><span id="search-menu-selected">All categories</span></a> </div>-->
                   <div class="search_igrp input-group">
                     <input autocomplete="off" spellcheck="false" class="top_search form_control11" value="{$search_search}" name="search" id="search"  maxlength="300">
					 <span class="input-group-addon" onclick="document.getElementById('user_search').submit();">
						<input type="submit" value="" class="button" ><span><img src="{$config.url}/images/home/searengi.png" class="searengiw2"></span>
					</span>
				   </div>
              </div>
               <!-- end search-box -->
            </form>
          </div>
           <!-- end search -->

         </div>
      </div>
     </div>
  </div>


    <div class="dsl1">
        <div class="modal fade" id="stre1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-backdrop fade in" style="height: 508px; background-color:transparent">

            </div>
            <div class="modal-dialog pokks1s" role="document">
                <div class="modal-content">
                    <div class="downPopUpArrow">&nbsp;
                    </div>
                    <div class="modal-header subi7s">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="subi8s">&times;</span></button>

                    </div>
                    <div class="modal-body" style="min-height: 0px;">
                        {foreach $loged.products as $key => $val}
                        <div class="col-md-12 div{$val.id}">
                            <div class="col-md-12 new2l subi1s">
                                 <div class="col-md-3">
                                    <!--<img  src="{$config.url}/images/home/ladpen2.png" class="img-responsive" />-->
                                     <img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" class="img-responsive">
                                </div>
                                <div class="col-md-7">
                                    <div class=" subi4s ">{$val.title}</div>
                                    {$t = $val.qty_add*sumFloat($val.bprice,$val.shipping_price)}
                                    <div class="vcz2f subi3s ">{$val.qty_add} X {currencyConverter($val.bprice)}</div>
                                </div>
                                <div class="col-md-2" style="cursor: pointer"><a onclick="removecartitemjay('{$val.id}',{$t});"><b>X</b></a></div>
                             </div>
                        </div>
                        {$total=$total+$val.qty_add*sumFloat($val.bprice,$val.shipping_price)}
                        {/foreach}

                    </div>
                    <div class="modal-footer subi2s">
                            <div class="col-md-12 subi5s">Total: <span class="subi6s">$<span class="total_amt subi6s">{currencyConverter($total)}</span></span></div>

                        <div class="col-md-12">
                            <button type="button" class="btn btn-dangernew" onclick="location.href='/product/checkout/cart'">{$pharse.view_cart}</button>
                            <button type="button" class="btn btn-dangernew" onclick="location.href='/product/checkout/confirm'">{$pharse.checkout}</button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

 </section>
 {/if}
 <div class="main_wrapper">
 <div class="container">
<script>
function changetheme(dis) {
  $("#change_theme").submit();
}

</script>

<script>
$('.dropdown').hover(function(){
  $('.dropdown-toggle', this).trigger('click');
});
</script>