<!DOCTYPE html>
<html lang="en">
<head>
  <!-- Metas
  ================================================== -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta property="og:description" content="Your Friend has invited to join {$config['url']}" />
  <meta property="og:image" content="{$config['url']}/images/logo.ic.png" />
  {if $seomode == 'yes'}
    {if $product_title}
      <title>{$product_title}</title>
      <meta name="title" content="{$product_title}" />
      <meta name="description" content="{$product_desc}" />
      <meta name="keywords" content="{$product_tags}" />
    {/if}
    {if $metas.title}
      <title>{$metas.title}</title>
    {else}
      <title>{$config.title}</title>
    {/if}
    {if $metas.meta_desc}
      <meta name="description" content="{$metas.meta_desc}" />
    {else}
      <meta name="description" content="" />
    {/if}


  {else}
    <title>{$config.title}</title>
    <META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
  {/if}

<!-- Favicon
  ================================================== -->
<link rel="shortcut icon" href="{$config['url']}/images/logo.ic.png">

<!-- Google fonts
  ================================================== -->

<link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,600,700,800,300' rel='stylesheet' type='text/css' />
<link href="https://fonts.googleapis.com/css?family=Courgette" rel="stylesheet">



<!--font-awesome
  ================================================== -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" type="text/css">


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>


<!-- Forward CSS -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/r/dt/dt-1.10.9/datatables.min.css"/>
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}theme{$themeno}.css" />
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}style.css" />
<!-- Forward CSS -->



<script src="{$config['externaljs']}common.js" type="text/javascript"></script>
<!--Encrypt Password  From Front End-->
<script src="{$config['externaljs']}md5-min.js"  type="text/javascript"></script>
    <script src="{$config['externaljs']}country.js"  type="text/javascript"></script>
    <script src="{$config['externaljs']}html5lightbox.js"  type="text/javascript"></script>

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
<!-- The below js is of ShareThis. Update it periodically. -->
<script type="text/javascript">var switchTo5x=true;</script>
<script type="text/javascript" src="{$config['externaljs']}share.js"></script>
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

<!-- Phone number with country code -->
 <script src="{$config['externaljs']}intlTelInput.js"></script>
    <script>

$(function(){
  var telInput = $("#mobile-number"),
  errorMsg = $("#error-msg"),
  validMsg = $("#valid-msg");

  // initialise plugin
  telInput.intlTelInput({
    nationalMode: false,
    utilsScript: "{$config['externaljs']}utils.js"
  });

  // on blur: validate
  telInput.blur(function() {
    if ($.trim(telInput.val())) {
      if (telInput.intlTelInput("isValidNumber")) {
        validMsg.removeClass("hide");
      } else {
        telInput.addClass("error");
        errorMsg.removeClass("hide");
        validMsg.addClass("hide");
      }
    }
  });

  // on keydown: reset
  telInput.keydown(function() {

    telInput.removeClass("error");
    errorMsg.addClass("hide");
    validMsg.addClass("hide");
  });

});


</script>





<!-- Phone number with country code Ends Here-->

<body>



 {if $mode neq 'yes'}
  <nav class="navbar-custom" role="navigation">
   <div class="container">
    <div class="row">
        <div class="col-md-5 col-sm-5 col-xs-12 pull-left cust_serrr">{$phrase.customer_service} 9722005516</div>


        <div class="col-md-7 col-sm-6 col-xs-12 welcome-msg text-right">
          <div class="pull-left ab1" style="margin-right:5px" >
            <span class="cursor ">{$phrase.view_as}</span>  &nbsp;
            &nbsp; <form action="{$config['url']}/index/changetheme" id="change_theme" class="pull-right" method="post" enctype="multipart/form-data"  >
                <input type="hidden" name="gopage"  value= "{$config['url']}{$pageofjs}">
                <select onChange="$('#change_theme').submit()" name="themeno" style="color:#000">
                    <option value="0" {if $themeno == 0} selected {/if}>Black Forest</option>
                    <option value="1" {if $themeno == 1} selected {/if}>Baby blue</option>
                    <option value="2" {if $themeno == 2} selected {/if}>Glossy Byzantium</option>
                    <option value="3" {if $themeno == 3} selected {/if}>Deep Red</option>
                    <option value="4" {if $themeno == 4} selected {/if}>Auction stone </option>
                </select>
            </form>

         </div>
        <div class="pull-left ab1" style="margin-right:5px">
            <span class="cursor ">{$phrase.login_as}</span>  &nbsp;
            <form action="{$config['url']}/login/save" id="autologin" method="post" class=" pull-right" enctype="multipart/form-data"  >
                 <input type="hidden" name="autologin"  value= "1">
                 <input type="hidden" name="username" id="autologinuserid"  value= "">
                 <select onChange="loginauto(this)" name="autologinoption" style="color:#000;width:76px;">
                    <option value="0" {if $autologin == 0} selected {/if}>Select</option>
                    <option value="buyer" {if $autologin == 'buyer'} selected {/if}>Buyer</option>
                    <option value="seller" {if $autologin == 'seller'} selected {/if}>Seller</option>
                    <option value="admin" {if $autologin == 'admin'} selected {/if}>Admin</option>
                 </select>
            </form>
         </div>


           <div class="wlcome_rht pull-right">
        {$phrase.welcome!}
          {if $loged.userid > 0}<a href="{$config.url}/profile_settings">{$loged.first_name}</a> <a href="{$config.url}/login/logout" >{$phrase.log_out}</a>{else}<a href="" data-toggle="modal" data-target="#registration">{$phrase.register}</a> or <a href=""  data-toggle="modal" data-target="#Login">{$phrase.sign_in}</a>{/if} </div>
           </div>
      </div>
  </div>
 </nav>
 {/if}
    <div class="timer_cnt" style="display:none;">
       <span> {$phrase.please_pay_with_in}<font class="cnter">{$timer}</font> seconds. <a href="{$config.url}/product/checkout/confirm/">{$phrase.pay_now}</a> </span>
    </div>
 <div class="print_header">
  <header>
   <div class="container">
    <div class="row">
       <div class="col-md-4 col-sm-4 col-xs-12 logo_container"> <a href="{$config.url}"><img  class="img-responsive" src="{$config.url}/images/home/logo.png" class="img-responsive" alt="Auctionsoftware"/></a> </div>
       {if $mode neq 'yes'}
        <div class="col-md-8 col-sm-8 col-xs-12 pull-right print_hide" style="padding-left: 0;padding-right: 0;">
        <div class="col-md-8 col-sm-8 col-xs-12 pull-left" style="padding-left: 0;padding-right: 0;">
        <ul class="list-inline new_bright_li">
            <li><a href="{$config.url}/search/?type=1">{$phrase.auction}</a></li>
            <li><a href="{$config.url}/search/?type=2">{$phrase.buy_now}</a></li>
            <li><a href="{$config.url}/search/?type=3">{$phrase.featured}</a></li>
            <li><a href="{$config.url}/search/?type=4">Video</a></li>
            {if $config.stores.enable == 'yes' && $loged.userid > 0}
            <li><a href="{$config.url}/stores/mystore/dashboard">{$phrase.your_store}</a></li>
            {/if}
            {if $loged.userid > 0}
            <li><a href="{$config.url}/classified">{$phrase.classified}</a></li>
            {/if}
            {if $loged.userid > 0}
            <li><a href="{$config.url}/forum">{$phrase.forum}</a></li>
            {/if}
            <li><a href="{$config.url}/stores/dashboard"  style="border-right: transparent !important;">Stores</a></li>
        </ul>
        </div>
        <div class="col-md-4 col-sm-4 col-xs-12 customer_service_block" style="text-align: right;">
        <a href="#" data-toggle="modal" {if $loged.pid != ''} data-target="#stre1" {/if}> <div class="cart_himg col-md-3 pull-left"  >
            <div class="cartyynew cart" style="cursor: pointer;">{if $loged.pid == ''}0{else}{$loged.pid|count}


          {/if}</div>
          </div>
          <div class="col-md-9 nmyaccount" >

          {if $loged.userid > 0}
            <a href="{$config.url}/dashboard/" title="{$loged.first_name}" class="dropdown-toggle macc" data-toggle="dropdown">{$phrase.my_account} <span class="caret"></span> </a>

                <ul class="dropdown-menu animated-dropdown">
                  <li><a href="{$config.url}/product/post">{$phrase.sell_an_item}</a></li>
                  <li><a href="{$config.url}/dashboard/mybids">{$phrase.buyer_dashboard}</a></li>
                  <li><a href="{$config.url}/dashboard/my">{$phrase.seller_dashboard}</a></li>
                  <li><a href="{$config.url}/dashboard/messages"> {$phrase.messages} <span class="msg_counter">{$msgcount}</span></a></li>
                  <li><a href="{$config.url}/dashboard/watchlist">{$phrase.watchlist}</a></li>
                  <!--{if $config.stores.enable}
                  <li><a href="{$config.url}/stores/create">Your Store</a></li>
                  {/if}-->
                  <li><a href="{$config.url}/profile_settings">{$phrase.profile}</a></li>
                    <li><a href="{$config.url}/membership/setup">{$phrase.membership}</a></li>
                  <li><a href="{$config.url}/dashboard/payments">{$phrase.payments}</a></li>
                  <li><a href="{$config.url}/dashboard/payment/saved">{$phrase.saved_payments}</a></li>
                    <li><a href="{$config.url}/adwords/show_adwords">{$phrase.my_banner_ads}</a></li>
                  </ul>
                  {else}
                  Guest
                  {/if}
                </div>
         </div>
      </div>
      {/if}
     </div>
  </div>
 </header>
 </div>
  {if $mode neq 'yes'}
 <section class="search_portion">
    <div class="container">
        <div class="row">
        <div class="col-md-12">
        <div class="row header-bot">
           <!-- start navigation -->
           <div class="col-xs-6 col-sm-5 col-md-3 navigation22">
            <ul>
               <li class="active"><a href="javascript:void(0)"><span>Shop by category</span></a>
                <ul>
                   <li aria-haspopup="true"><a href="{$config.url}/search/" title="All categories" role="menuitem" class="nav-menu-link"><strong>All categories</strong></a>
                    <div class="clearfix dropdown" style="">
                       <div class="col pull-left">
                        <ul>
                          {$i=0}
                          {foreach $category as $key => $val}<span style="display:none">{$i++}</span>
                          	{if $i <= 15}<li><a href="{$config.url}/search/cid/{$val.id}/{$val.name}" title="{$val.name}">{$val.name}</a></li>{/if}                          {/foreach}
                         </ul>
                      </div>
                       <div class="col pull-left">
                        <ul>
                          {$i=0}
                          {foreach $category as $key => $val}<span style="display:none">{$i++}</span>
                          	{if $i > 15 && $i <= 30}<li><a href="{$config.url}/search/cid/{$val.id}/{$val.name}" title="{$val.name}">{$val.name}</a></li>{/if}                          {/foreach}
                         </ul>
                      </div>
                      <div class="clear"></div>
                       <div class="row-link"><a href="{$config.url}/search/" title="All categories">All categories</a></div>
                     </div>
                  </li>
                  {foreach $category as $key => $val}
                   {if $val.parent_id == 0}
                   <li aria-haspopup="true"><a href="{$config.url}/search/cid/{$val.id}/{$val.name}" title="{$val.name}" role="menuitem" class="nav-menu-link">{$val.name}</a>

                    <div class="clearfix dropdown">
                      <div class="col pull-left {$val.rgt}">
                        <ul>
                          {$i=0}
                          {foreach $category as $key2 => $val2}
                              {if $i <= 15}
                                   {if $val2.lft > $val.lft and $val2.rgt < $val.rgt}

                                        <span style="display:none">{$i++}</span>
                                        <li><a href="{$config.url}/search/cid/{$val2.id}/{$val2.name}" title="{$val2.name}"> {$i = 1}{while $i <= $val2.depth-1}
                                          --&nbsp;&nbsp;
                                          {$i= $i+1}
                                        {/while} {$val2.name}</a></li>
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
                                    <li><a href="{$config.url}/search/cid/{$val2.id}/{$val2.name}" title="{$val2.name}">{$val2.name}</a></li>
                                  {/if}
                              {/if}
                          {/foreach}
                        </ul>
                       </div>
                       <div class="clear"></div>
                       <div class="row-link">
                       	   <a href="{$config.url}/search/cid/{$val.id}/{$val.name}" title="All categories in {$val.name}">All categories in {$val.name}</a>
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
            <!-- <div class="modal-backdrop fade in" style="height: 508px; background-color:transparent">
            </div> -->
            <div class="modal-dialog pokks1s" role="document">
                <div class="modal-content">
                    <div class="downPopUpArrow">&nbsp;
                    </div>
                    <div class="modal-header subi7s">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="subi8s">&times;</span></button>
                    </div>
                    <div class="modal-body" style="min-height: 0px;">
                        {$total = 0}
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
                                    <div class="vcz2f subi3s ">{$val.qty_add} X {sumFloat($val.bprice,$val.shipping_price)}</div>
                                </div>
                                <div class="col-md-2" style="cursor: pointer"><a onclick="removecartitemjay('{$val.id}',{$t});"><b>X</b></a></div>
                             </div>
                        </div>
                        {$total=sumFloat($total,$val.qty_add)*sumFloat($val.bprice,$val.shipping_price)}
                        {/foreach}
                    </div>
                    <div class="modal-footer subi2s">
                        <div class="col-md-12 subi5s">Total: <span class="subi6s">$<span class="total_amt subi6s">{currencyConverter($total)}</span></span></div>
                        <div class="col-md-12">
                            <button type="button" class="btn btn-dangernew" onclick="location.href='/product/checkout/cart'">View Cart</button>
                            <button type="button" class="btn btn-dangernew" onclick="location.href='/product/checkout/confirm'">Checkout</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
 {/if}
 <div class="main_wrapper">
 <div class="container ">
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
<style type="text/css">
 .pad-left-right-0px
 {
    padding-left: 0px !important;
    padding-right: 0px !important;
 }
 .list-inline > li {
    display: inline-block;
    padding-right: 2px !important;
    padding-left: 1px  !important;
}
</style>
