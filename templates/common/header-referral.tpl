<head>
    <title>Hempbuyer</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta prefix="og: http://ogp.me/ns#" property="og:site_name" content="Hempbuyer" />
    <meta name="author" content="Hempbuyer">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
    <link rel="stylesheet" type="text/css" href="{$config['externalcss']}/jquery.datetimepicker.css" />
    <link href="{$config.dpath}css/sweetalert2.min.css" rel="stylesheet">
    <link rel="stylesheet" href="{$config['externalcss']}flexslider.css">
    <link rel="stylesheet" href="{$config['externalcss']}rateit.css">
    <link rel="stylesheet" href="{$config['externalcss']}main.css">

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
</style>
</head>

<div class="loader"></div>

<header class="hh-wrap">
    <nav class="navbar navbar-expand-md navbar-expand-lg">
        <div class="container">
            <div class="brand-div text-center">
                <a class="navbar-brand m-auto" href="/">
                    <img src="{$config.url}/images/hempLogo.png" />
                </a>
                <button class="menu-bar d-md-none"><span class="fa fa-bars"></span></button> 
            </div>
            <ul class="navbar-nav ml-auto apply-active top-menu" id="mail_menu">
                <li class="nav-item d-none d-md-block">
                    <a class="nav-link" target="_blank" href="https://hempbuyerblog.auctionsoftware.com/">
                        Blog
                    </a>
                </li>
                <li class="nav-item d-none d-md-block">
                    <a class="nav-link" href="javascript:void(0)">
                        <i class="fa fa-phone-alt"></i> 1-800-420-4196
                    </a>
                </li>
                <li class="nav-item d-none d-md-block">
                    <a class="nav-link" href="/contactUs">
                        <i class="fa fa-map-marker-alt"></i> Contact
                    </a>
                </li>
                {if !$loged_referral.email}
                    <li class="nav-item">
                        <a class="nav-link" href="/register_referral">
                            <i class="fa fa-user"></i> Register
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/signin_referral">
                            <i class="fa fa-sign-in-alt"></i> Login
                        </a>
                    </li>
                {/if}
                {if $loged_referral.email}
                    <li class="nav-item">
                        <a class="nav-link" href="/logout_referral">
                            <img src="/images/turn-off.png" alt="" /> LOGOUT
                        </a>
                    </li>
                {/if}
            </ul>
        </div>
    </nav>
    <div class="navbar-collapse" id="navbarCollapse">
        <ul class="navbar-nav mr-auto apply-active amm-menu"> 
            <li class="nav-item d-md-none">
                <a class="nav-link" target="_blank" href="https://hempbuyerblog.auctionsoftware.com/">
                    Blog
                </a>
            </li>
            <li class="nav-item d-md-none">
                <a class="nav-link" href="javascript:void(0)">
                    <i class="fa fa-phone-alt"></i> 1-800-420-4196
                </a>
            </li>
            <li class="nav-item d-md-none">
                <a class="nav-link" href="/contactUs">
                    <i class="fa fa-map-marker-alt"></i> Contact
                </a>
            </li> 
            <a class="d-none menu-close"><i class="fa fa-times"></i></a>
        </ul> 
    </div>
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
})

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
});
</script>
  
{foreach $external2js as $key => $val}
<script src="{$config['externaljs']}{$val}.js" type="text/javascript"></script>
{/foreach}