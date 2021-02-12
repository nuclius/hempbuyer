<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    {if $previewData.id}
        
        {* <meta property="og:type"               content="article" /> *}
        {if $previewData.title}
            <meta prefix="og: http://ogp.me/ns#" property="og:title" content="{$previewData.title}" />
            <meta name="twitter:title" content="{$previewData.title}" />
        {/if}
        {if $previewData.productDocument[0].image}
            <meta prefix="og: http://ogp.me/ns#" property="og:image" content="{$config.url}/uploads/product/{$previewData.productDocument[0].image}" />
            <meta name="twitter:card" content="summary_large_image">
            <meta name="twitter:image" content="{$config.url}/uploads/product/{$previewData.productDocument[0].image}" alt="{$previewData.title}" />
        {/if}
        {if $previewData.description}
            {* <meta prefix="og: http://ogp.me/ns#" property="og:description" content="{$previewData.description}" />
            <meta name="twitter:description" content="{$previewData.description}" />
            <meta name="description" content="{$previewData.description}"> *}
            <meta prefix="og: http://ogp.me/ns#" property="og:description" content="Hempbuyer Auction is an online hemp trading and business development marketplace. We provide you a flexible and convenient platform for buying and selling your hemp products. It is your virtual B2B direct connection to hemp buyers and sellers." />
            <meta name="twitter:description" content="Hempbuyer Auction is an online hemp trading and business development marketplace. We provide you a flexible and convenient platform for buying and selling your hemp products. It is your virtual B2B direct connection to hemp buyers and sellers." />
        {/if}
        <meta prefix="og: http://ogp.me/ns#" property="og:url" content="{$config.url}/product/view/{$previewData.id}" />
        <meta name="twitter:site" content="Hempbuyer" />
        <meta name="twitter:domain" content="{$config.url}" />

        {if $previewData.meta_key}
            <meta name="keywords" content="{$previewData.meta_key}">
        {else /}
            <meta name="keywords" content="{$previewData.title}">
        {/if}
        {if $previewData.meta_title}
            <title>{$previewData.meta_title}</title>
        {/if}
        {if $previewData.meta_description}
            <meta name="description" content="{$previewData.meta_description}">
        {/if}
    {else /}
        <title>Hempbuyer</title>
        <meta name="description" content="Hempbuyer Auction is an online hemp trading and business development marketplace. We provide you a flexible and convenient platform for buying and selling your hemp products. It is your virtual B2B direct connection to hemp buyers and sellers." />
    {/if}
    <meta prefix="og: http://ogp.me/ns#" property="og:site_name" content="Hempbuyer" />
    <meta name="author" content="Hempbuyer">

    <link rel="icon" type="image/png" href="/images/favicon.png"/>
    <!-- bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    
    <!-- bootstrap end -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.min.css" rel="stylesheet">
    <!-- font -->
    <!-- carosal -->
    <!-- owl carosal -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
    <link rel="stylesheet" type="text/css" href="{$config['externalcss']}/jquery.datetimepicker.css" />
    <!-- css -->
    <link href="{$config.dpath}css/sweetalert2.min.css" rel="stylesheet">

    <link rel="stylesheet" href="{$config['externalcss']}flexslider.css">
    <link rel="stylesheet" href="{$config['externalcss']}rateit.css">
    <link rel="stylesheet" href="{$config['externalcss']}main.css">

    <!-- css -->

  <style>
    .loader {
    	position: fixed;
    	left: 0px;
    	top: 0px;
    	width: 100%;
    	height: 100%;
    	z-index: 999999;
    	background: url('../images/loading.gif') 50% 50% no-repeat rgb(249,249,249);
    }
    .apply-active a:hover {
        color: #5e9836;
    }
    .user_name_div {
        padding: 5px 0px 0px 6px;
    }
    .add_bank_warning {
        z-index: 1000;
        position: relative;
        margin: auto;
        width: 100%;
        display: -webkit-box;
        display: -ms-flexbox;
        display: flex;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
                justify-content: center;
        background: #faffd0;
        height: 40px;
        -webkit-box-align: center;
        -ms-flex-align: center;
                align-items: center;
                color: #000 !important;
                margin-bottom: -1px;
    }

    .add_bank_warning a{
        padding-left: 10px;
    padding-right: 10px;
    color: #7f8b1a;
    }


    .header-chat-notification {
        width: 50px;
        text-align: center;
        padding: 8px;
    }
    .header-chat-notification .dropdown-item {
        display: inline-block;
    }
    .header-chat-notification .h_chat_title {
        width: 100%;
    }
    .header-chat-notification .h_chat_message {
        width: 100%;
        float: left;
    }
    .header-chat-notification .h_chat_time {
        float: right;
        font-size: 12px;
        width: 100%;
        text-align: right;
    }
    .header-chat-notification .dropdown-menu {
        max-height: 300px;
        overflow: auto;
        box-shadow: 0px 6px 5px #ccc;
    }
</style>
</head>

<div class="loader"></div>

<header class="hh-wrap">
    <nav class="navbar navbar-expand-md navbar-expand-lg">
        <div class="container">
            <ul class="navbar-nav ml-auto apply-active top-menu" id="mail_menu">
                {if $loged.userid}
                {* <li class="nav-item apply-active">
                    <a class="btn btn-primary show-seller-dashboard-active" href="/product" style="line-height: 17px;">
                        Post Product
                    </a>
                </li> *}
                <!-- Small Devices -->
                <li class="nav-item d-md-none">
                    <a class="nav-link" href="/profileInfo">
                        <img src="/images/user-prof.png" alt="" /> PROFILE
                    </a>
                </li>
                <li class="nav-item d-md-none">
                    <a class="nav-link" href="/logout">
                            <img src="/images/turn-off.png" alt="" /> LOGOUT
                    </a>
                </li> 
                <!-- Small Devices End -->
                {/if}
                <li class="nav-item d-none d-md-block">
                    <a class="nav-link" href="tel:1-800-420-4196">
                        <i class="fa fa-phone-alt"></i> 1-800-420-4196
                    </a>
                </li>
                <li class="nav-item d-none d-md-block">
                    <a class="nav-link" href="/contactUs">
                        <i class="fa fa-map-marker-alt"></i> Contact
                    </a>
                </li>
                {if !$loged.userid}
                <li class="nav-item">
                    <a class="nav-link" href="/signup">
                        <i class="fa fa-user"></i> Register
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/signin">
                        <i class="fa fa-sign-in-alt"></i> Login
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/banners">
                    <i class="fas fa-user-plus"></i> Referral Program
                    </a>
                </li>
                {/if}
                {if $loged.userid}
                    <li class="nav-item">
                    <a class="nav-link active" href="/banners">
                    <i class="fas fa-user-plus"></i> Referral Program
                    </a>
                </li>
                <li class="nav-item  notify-wrap d-md-block">
                    <div class="dropdown header-chat-notification">
                        <figure class="m-0 d-inline-block" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-bell" style="font-size: 18px;"></i>
                            <span class="unread_count_header" id="" style="{if $unread_chat_list.length < 1}display: none;{/if}">{$unread_chat_list.length}</span>
                        </figure>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink" id="chat_notification_list">
                            {foreach $unread_chat_list as $key => $val}
                                <a class="dropdown-item" href="{if $val.seller_id == $loged.userid}/seller/openAuction?chat_popup={$val.product_id}{else /}/product/view/{$val.product_id}?chat_popup={$val.product_id}{/if}">
                                    <span class="h_chat_title"><b>Product:</b> {$val.product_title}</span>
                                    <span class="h_chat_message">{$val.message}</span>
                                    <span class="h_chat_time">{$val.created_date}</span>
                                </a>
                            {/foreach}
                            {if $unread_chat_list.length < 1}
                                <span>No notification found.</span>
                            {/if}
                        </div>
                    </div>
                </li>
                <li class="nav-item d-none d-md-block">
                    <div class="dropdown header-profile-pic">
                        <figure class="m-0 d-inline-block" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            {* <img src="/uploads/{$loged.profilepic}" class="img-responsive user-prof" alt="No Image Available" onerror="this.onerror=null;this.src='/no_user_image.png';"> *}
                            <div class="user_name_div">
                                <span class="">Hi,</span> <a href="javascript:void(0)" class="">{$loged.username} <i class="fas fa-caret-down"></i></a>
                            </div>
                        </figure>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                            <a class="dropdown-item" href="/seller/openAuction">
                             <i class="fas fa-tachometer-alt"></i> SELLER DASHBOARD
                            </a>
                            <a class="dropdown-item" href="/buyer/activeAuction">
                             <i class="fas fa-tachometer-alt"></i> BUYER DASHBOARD
                            </a>
                            <a class="dropdown-item" href="/product">
                            <i class="fas fa-clipboard"></i> POST PRODUCT
                            </a>
                            <a class="dropdown-item" href="/profileInfo">
                            <i class="fas fa-user-circle"></i> PROFILE
                            </a>
                            <a class="dropdown-item" href="/logout">
                            <i class="fas fa-sign-out-alt"></i> LOGOUT
                            </a>
                        </div>
                    </div>
                </li>
                {/if}
            </ul>
        </div>
    </nav>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <div class="brand-div text-center">
                <a class="navbar-brand m-auto" href="/">
                    <img src="{$config.url}/images/hempLogo.png" />
                </a>
                <button class="menu-bar d-md-none"><span class="fa fa-bars"></span></button>
                <button id="searchBar" class="search-bar d-md-none"><span class="fa fa-search"></span></button>
            </div>
            <div class="navbar-collapse" id="navbarCollapse">
                <ul class="navbar-nav ml-auto apply-active amm-menu">
                    <li class="nav-item">
                        <a class="nav-link" href="/aboutUs">Our Story</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/how_it_works">How It Works</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/values_ethics">
                            Values/Ethics
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/market">
                            Auction & Market
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/classified">
                            Classifieds
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" target="_blank" href="https://hempbuyer.com/blog/">
                            Blog
                        </a>
                    </li>
                    <li>
                        <button class="search-bar sbLg"><span class="fa fa-search"></span></button>
                    </li>
                    <li class="nav-item d-md-none">
                        <a class="nav-link" href="tel:1-800-420-4196">
                            <i class="fa fa-phone-alt"></i> 1-800-420-4196
                        </a>
                    </li>
                    <li class="nav-item d-md-none">
                        <a class="nav-link" href="/contactUs">
                            <i class="fa fa-map-marker-alt"></i> Contact
                        </a>
                    </li>

                    <!-- Small Devices -->
                    {if $loged.userid}
                    <li class="nav-item d-md-none">
                        <a class="nav-link" href="/seller/openAuction">
                            <img src="/images/speedometer.png"  alt="" /> SELLER DASHBOARD
                        </a>
                    </li>
                    <li class="nav-item d-md-none">
                        <a class="nav-link" href="/buyer/activeAuction">
                            <img src="/images/speedometer.png"  alt="" /> BUYER DASHBOARD
                        </a>
                    </li>
                    {/if}

                    <!-- Small Devices End -->
                    
                    <a class="d-none menu-close"><i class="fa fa-times"></i></a>
                </ul>
                <ul class="navbar-nav ml-auto tsearch-wrap">
                    <form action="/market" method="get">
                        <input class="form-control" placeholder="Search" name="keywordSeachHome">
                    </form>
                    <a id="siClose" class="d-none si-close"><i class="fa fa-times"></i></a>
                </ul>
            </div>
        </div>
    </nav>
    {if $loged.userid && $loged.bank_account_added == 0}
        <div class="text-danger text-center add_bank_warning">
            <b><i class="fas fa-university"></i> Note:</b> <a href="/bank">Click here</a> to add your bank account number to buy and sell your product.
        </div>
        <style type="text/css">
            @media (max-width: 767px) {
                header { 
                    max-height: 148px;
                }
                .auth-container .auth-left.login-padd, .pp-form.hb-reg-form, .pp-form.hb-reg-form2, .pp-form.hb-reg-form3, .db-iwrap {
                    margin-top:148px;
                }
            } 
        </style>
    {/if}
</header>


<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script src="{$config['externaljs']}common.js?id={$file_revision}" type="text/javascript"></script> 
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="{$config.url}/js/hmb/jquery.mask.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/webfont/1.6.16/webfont.js"></script>
<script type="text/javascript" src="{$config.url}/js/jquery.rateit.js"></script>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> -->
<script src="{$config.url}/socket.io/socket.io.js"></script>
<script src="{$config.url}/js/common_admin.js"></script>

<script>
var clockws = [];
    var targetDate = [];
    var startDate = [];
    var clearvar = [];
    var timeProject = [];
    var currentTime = new Date('{$datenow}');
    var socket = io.connect('{$config.url}');
    var currentDateTime = new Date('{$datenow}');
    socket.on('sliservertime', function(msg){
    currentTime  = new Date(msg.dTime);
// console.log(msg.dTime);  
    });
</script>

<script>
$('.menu-bar, .menu-close').click(function(){
    $('body').toggleClass('smenu');
});

$('.search-bar, .si-close').click(function(){
    $('body').toggleClass('show-sw');
    console.log('works')
})

$('html, body').css({
    overflow: 'hidden',
    height: '100%'
});
$(window).on('load', function() {
    $('html, body').css({
        overflow: 'auto',
        height: 'auto'
    });
    /*setImmediate(function() {
        $('.loader').fadeOut();
    });*/
    $('.loader').fadeOut();

    /**
     *  Apply Active Class from Current Page
     */
    var currentPath = window.location.pathname;
    var currentPathHash = window.location.hash;
    $('.apply-active li a').removeClass('active');
    $('.apply-active li a[href="'+currentPath+'"]').addClass('active');

    $('.apply-active li a[href="/'+currentPathHash+'"]').addClass('active');
    setTimeout(function() {
        $('.header-chat-notification a').removeClass('active');
    }, 200);
});


socket.on('offer_message', function (data) {
    console.log("data--==-=-=-==88888888888888888888888888888888888888888-=")
    console.log(data)
    if(+'{$loged.userid}' == +data.receiver_id) {
        console.log('data', data);
        $(".chat_other_div").remove();
        var message = data.message.replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '<br>');
        var html = '<a class="dropdown-item" href="' + (data.seller_id == '{$loged.userid}' ? '/seller/openAuction?chat_popup='+data.product_id : '/product/view/'+data.product_id+'?chat_popup='+data.product_id) + '">'
                    +'<span class="h_chat_title"><b>Product:</b> '+ data.product_title + '</span>'
                    +'<span class="h_chat_message">' + message + '</span>'
                    +'<span class="h_chat_time">' + data.created_date + '</span>'
                +'</a>';
        $("#chat_notification_list").prepend(html);
        var unread = +$(".unread_count_header").html();
        if(unread) {
            $(".unread_count_header").html(unread+1);
        } else {
            $(".unread_count_header").html(1);
        }
        $(".unread_count_header").show();
    }
});
</script>

{* <script>

var searchBar = document.getElementById("searchBar");
var searchClose = document.getElementById("siClose");

searchBar.addEventListener("click", toggleFunc)
searchClose.addEventListener("click", toggleFunc)

function toggleFunc(){
    var bodyTag = document.getElementsByTagName('body')
  console.log('works', bodyTag[0])
  bodyTag[0].classList.toggle("show-sw");
}

</script> *}
  
{foreach $external2js as $key => $val}
<script src="{$config['externaljs']}{$val}.js" type="text/javascript"></script>
{/foreach}