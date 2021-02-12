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


<link rel="stylesheet" href="{$config['externalcss']}lightslider.css">
<!-- <link  href="{$config['externalcss']}jquery.bxslider.min.css" rel="stylesheet"> --> <!-- 3 KB -->

<link rel="stylesheet" type="text/css" href="{$config['externalcss']}responsiveslides.css" />
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}lightbox.css" />
<link rel="stylesheet" type="text/css" href="{$config.url}/css/home_1.css" />
<!--<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>--> 

<link rel="stylesheet" href="{$config.url}/css/timecircle.css" />
<style>
@charset "utf-8";
/* CSS Document */
#remote-media
{
    padding: 0;
    display: inline-block;	
}
    .carousel-control { color: #777;}
    .ftn16 {  font-size: 16px; color: #555;}
#buyer-media,#remote-media
{
  margin:10px;	 min-height: 269px;
}
    #remote-media {  margin:0; }
    #buyer-media.buyer-media1 { min-height: 247px; margin: 0; overflow: hidden;}
    
    #buyer-media.buyer-media1 video { }
    
    .default-ht1 { min-height: 249px;}
    
    
#remote-media .videoFrame 
{
	width: 180px;
    margin: 20px 10px 5px 0px;
    height: 125px;
    padding: 0px !important;
        margin-right: 0px !important;
        margin-left: 5px !important;
    margin-bottom: 5px !important;
    margin-top: 5px !important;
} 
#remote-media video 
{
	width: 100%; height: inherit;
}
    
    #buyer-media.buyer-media1 .videoFrame  { 
        height: 247px;
    }
    
.sui-progressbar-text
{
    top: 146px !important;
    left: -40px !important;
    width: 200px !important;
}
#progressbar
{
 background:transparent;
 overflow:visible !important;	
}
svg:not(:root)
{
	overflow:visible !important;	
} 
.videoFrame img
{
    position: absolute;
    left: -40px;
    top: -10px;
    width: 200px;
}
    .vsold { margin-bottom: -80px;
    margin-right: -83px;
    width: 100px;
    float: right; }
   #BidCountdown canvas {     margin-bottom: -80px;
    margin-right: -83px;
    width: 84px;
    float: right;}
.videoFrame
{
  position:relative;	
}
.allbodr
{
	
}
.bids
{
    display: inline-block;
    width: 100%;
/*    margin: 10px;	*/
	    height: 269px;
    overflow-y: hidden;
    overflow-x: hidden;
}
.closed img
{
    width: 38%;
    margin: 0 auto;    padding: 0;
    text-align: center;
}
   .closed img.unsv { width: 34%; }
#local-media img.bidnow
{
    position: absolute;
    bottom: 0px;
    right: -10px;
    display: block;
    border: 2px solid #ccc;
    border-radius: 25px;
    height: 50px;
    width: 50px;
    z-index: 10000000;
    cursor: pointer;
	display:none;	
}
.sbidprice
{
    animation:animated_div 5s 1;
-moz-animation:animated_div 5s 1;
-webkit-animation:animated_div 5s 1;
-o-animation:animated_div 5s 1;

	position:absolute;
}
/*#remote-media .videoFrame, #buyer-media .videoFrame
{
	width: 200px;
	margin:0px 10px 5px 0px;
	height: 170px;
	padding:0px !important;
}
#remote-media video, #buyer-media video
{
	width: 198px;
}*/
.videoFrame
{
	position: relative;
    width: 100%;
    float: left;
    height: 234px;
    border-radius: 0px;
    padding: 0px !important;
    margin: 0px !important;
    background: #f2f2f2;
}
    .default-ht {     min-height: 235px; }
.videoFrame .uname.topper
{	
    background: #cb1f25;
}
.videoFrame .uname
{   
   position: absolute;
    width: 100%;
    height: 25px;
    bottom: 0;
    padding-top: 3px;
    left: 0px;
    text-align: center;
    background: #777777;
    color: #fff;
    font-size: 14px;
}

video
{ 
    width: 100%;
    height: 226px;
 
}
    #gallery_01 imgborder
    .active imgborder
    .modal {
        background: rgba(44, 41, 41, 0.66);
    }
    .products_row {
        padding: 15px 0;
        margin: 0;
        max-width: 100%; z-index: 9;
    }

    @keyframes animated_div
{
0%		transform
25%		transform
50%		transform
55%		transform
70%		transform
100%	transform
}

@-webkit-keyframes animated_div
{
0%		NaN
25%		NaN
50%		NaN
55%		NaN
70%		NaN
100%	NaN
}

@-moz-keyframes animated_div
{
0%   NaN
25%  NaN
50%  NaN
55%  NaN
70%  NaN
100% NaN
}

@-o-keyframes animated_div
{
0%   transform
25%  transform
50%  transform
55%  transform
70%  transform
100% transform
}

    @media screen and (max-width: 980px)  {
        html {
            overflow-x:hidden;
        }
        .products_row {
            margin: 25px auto;
            max-width: 100%;
            padding: 0px;
        }

        .videop .btn {
            padding: 4px 4px;
            font-size: 12px;
        }
    }


    #winningbid{

        display:none;

    }

    #outbid{

        display:none;

    }

    @-webkit-keyframes blink {
        0% {
            background: #83F52C;
        }

        50% {
            background: rgba(255,0,0,0);
        }

        100% {
            background: #83F52C;
        }
    }

    @keyframes blink {
        0% {
            background: #83F52C;
        }

        50% {
            background: rgba(255,0,0,0);
        }

        100% {
            background: #83F52C;
        }
    }
    @-webkit-keyframes blinkingBorder {
        0% {
            background: #83F52C;
        }

        50% {
            border-color: rgba(255,0,0,0);
        }

        100% {
            background: #83F52C;
        }
    }

    @keyframes blinkingBorder {
        0% {
            background: #83F52C;
        }

        50% {
            border-color: rgba(255,0,0,0);
        }

        100% {
            background: #83F52C;
        }
    }



    
    .animationclass{

        border-radius: 74px !important;
        height: 146px !important;
        left: 51px !important;
        width: 147px !important;

        background-color: red;

        -webkit-animation-direction: normal;
        -webkit-animation-duration: 5s;
        -webkit-animation-iteration-count: infinite;
        -webkit-animation-name: blink;
        -webkit-animation-timing-function: ease;
        animation-direction: normal;
        animation-duration: 5s;
        animation-iteration-count: infinite;
        animation-name: blink;
        animation-timing-function: ease;

    }
	#slider {
        position: relative;
        overflow: hidden;
        margin: 20px auto 0 auto;
        border-radius: 4px;
    }

    #slider ul {
        position: relative;
        margin: 0;
        padding: 0;
        height: 200px;
        list-style: none;
    }


    .animslider
    {
        -webkit-animation-direction: normal;
        -webkit-animation-duration: 5s;
        -webkit-animation-iteration-count: infinite;
        -webkit-animation-name: blink;
        -webkit-animation-timing-function: ease;
        animation-direction: normal;
        animation-duration: 5s;
        animation-iteration-count: infinite;
        animation-name: blink;
        animation-timing-function: ease;
    }

    #slider ul li {
        position: relative;
        display: block;
        float: left;
        margin: 0;
        padding: 0;
        width: 300px;
        height: 200px;
        background: #ccc;
        text-align: center;



       /* line-height: 300px;*/
    }

    a.control_prev, a.control_next {
        position: absolute;
        top: 40%;
        z-index: 999;
        display: block;
        padding: 4% 3%;
        width: auto;
        height: auto;
        background: #2a2a2a;
        color: #fff;
        text-decoration: none;
        font-weight: 600;
        font-size: 18px;
        opacity: 0.8;
        cursor: pointer;
    }

    textarea.form-control {
    height: 54px;
}
    a.control_prev:hover, a.control_next:hover {
        opacity: 1;
        -webkit-transition: all 0.2s ease;
    }

    a.control_prev {
        border-radius: 0 2px 2px 0;
    }

    a.control_next {
        right: 0;
        border-radius: 2px 0 0 2px;
    }

    .slider_option {
        position: relative;
        margin: 10px auto;
        width: 160px;
        font-size: 18px;
    }



    #owl-demo .item{
        background: #3fbf79;
        padding: 30px 0px;
        margin: 10px;
        color: #FFF;
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        border-radius: 3px;
        text-align: center;
    }
    .customNavigation{
        text-align: center;
    }
      .customNavigation a{
          -webkit-user-select: none;
          -khtml-user-select: none;
          -moz-user-select: none;
          -ms-user-select: none;
          user-select: none;
          -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
      }
      #danger
      {
        display: none;
      }
    .block1_img {
        max-height: 180px;
        min-height: 150px;
        padding-top: 30px;
    }
    .pro_item pointer_cur
    {
        background-color: #27ad60;
    }
	.message-box
	{
	    position: relative;	
		padding-top: 14px;
		width: 85%;
		clear: both;
		float:left;
	}
	
	.visitor-message {
	clear: both;	
    -webkit-animation: show-text 7s ease-out;
    -moz-animation: show-text 7s ease-out;
	    position: relative;
    -o-animation: show-text 7s ease-out;
    -ms-animation: show-text 7s ease-out;
    animation: show-text 7s ease-out;
    color: #fff;
    border-radius: 7px;
    font-family: Helvetica Neue,Helvetica,Arial,sans-serif;
    font-size: 14px;
    background: #a4aeb0;
    float: right;
    width: 100%;
    padding: 5px 16px;
	position:relative;
	
}
    
    
    
    
    .visitor_name
{
    float: right;
   /* background: #ccc;*/
    padding: 5px 10px;
	display:inline-block;
    /*border-radius: 5px;*/
    font-size: 9px;
/*    margin-bottom: -10px;	*/
}.visitor-message-tip {
    content: '';
    position: absolute;
    border: 6px solid #fff;
    width: 0;
    height: 0;
    top: 25px;
    right: 100%;
    margin-top: -15px;
}
.right-box .visitor-message-tip {
    content: '';
    position: absolute;
    border: 6px solid #fff;
    width: 0;
    height: 0;
    top: 29px;
    right:0%;
    margin-top: -15px;
}
.visitor-message:after {
    font-size: 12px;
    color: #c1c1c1;
    position: absolute;
    top: -19px;
    left: 66px;
}.msg_group
{
   height:140px;
   width:100%;
   overflow-y:scroll;
   overflow-x:hidden;	
}
    .chatonline .search_category h3
	{
		cursor:pointer;
	}
	.chatonline .search_category
	{
	  background:#fff;
	  	
	}
	.chatonline
	{
	 /*     width: 400px;
 
		  position: fixed;right:0px;
		  bottom: 0px;
*/
		  background: transparent;
/*		  margin-bottom: -20px;	*/
	}
	.carousel-control
	{
	  width:auto !important;	
	}
	#myCarousel
	{
	  height:142px;	
	}
	.searengiw2{
    padding-left: 15px;
    padding-top: 4px;
}
    .carousel-indicators {  display: none; }
    #local-media {  min-height: 231px; max-height: 231px; }
    #local-media img {     max-height: 216px;  margin: 0 auto;}
    .carousel-inner > .item > img, .carousel-inner > .item > a > img {  margin: 0 auto;    max-height: 138px; }
    .con_sp { margin: 0 10px;}
    .panel-vw {  background: #777;  color: #fff;}
    .panel-vw a { color: #fff;}
    
    .fht { min-height: 165px; }

/*My Page Design*/

.allbodr {
	border: 1px solid #d8d7d7;
}
    .prv_gbox { margin-bottom: 0; }
.yourvideo {
	text-align: center;
    padding: 6px;
    background-color: #777;
    color: #fff;
}
.lva {
	text-align: center;
    padding: 9px;
    border: 1px solid;
    border-radius: 6px;
	color: #CB1F25;
	font-size: 18px;
    font-weight: 600;
}
    .schedule { font-size: 18px; font-weight: 600;}
.brp {
	text-align: center;
    padding: 2px;
/*    border: 1px solid #767676;*/
    border-radius: 6px;
	color: #02A4BD;
	font-size: 15px;
    font-weight: 600;
}
.pdis {
    font-size: 16px;
    font-family: 'Open Sans';
    color: #03A9F4;
    font-weight: 700;
    padding-bottom: 5px;
}
.fntsiz {
	font-size:12px;
}
.bluclr  {
	color:#02A4BD;
}
.fntbls {
	    font-weight: 700;
    font-size: 12px;
}
.mrgtp {
	margin-top: 12px;
}
.mrgtp5 {
	margin-top: 50px;
}
.mrgtp3 {
	margin-top: 30px;
}
.pdlft {
	padding-left: 0px;
}
.allpd {
	padding: 0;
}
.allpd1 {
	padding: 20px;
}
.mrglft {
	    margin-left: 15px;
}
.prodct {
	font-size: 16px;
    background: #00587d;
    color: #fff;
	padding: 10px;
    text-align: center;
    font-weight: 600;
	/*border-radius: 6px 6px 0 0;*/
}
.prodct1a {
	font-size: 16px;
    background: #00587d;
    color: #fff;
	padding: 5px;
    text-align: center;
    font-weight: 600;
	/*border-radius: 6px 6px 0 0;*/
}
.prodct-blk {
	font-size: 16px;
    background: #777;
    color: #fff;
	padding: 10px;
    text-align: center;
    font-weight: 600;
	/*border-radius: 6px 6px 0 0;*/
}
.prodct1 {
	font-size: 8px;
    background: #00587d;
    color: #fff;
    text-align: center;
    font-weight: 600;
}
    .btn.btn-success {  background: #cb1f25; border: 1px solid #a71a1f; }
    
    .btn.btn-success:hover { background: #a71a1f; border: 1px solid #61050a; }
    
.btn.btn-success.bgblue, .btn.btn-success.bgblue:hover {
	background-color: #00587d;border: 1px solid #00587d;
}
.usr {
	    text-align: center;
    margin-top: 8px;
}
.clrgrn {
	color: green;
}
.clrred {
	background-color: red;
}
    .search_category {     border: none; }
.call {
	
    /*margin-left: 27%;*/
    margin-bottom: 10px;
}
.allbodr
{
 width:100%;
 display:inline-block;	
}
.connect
{
 cursor:pointer;	
}
.animatethis {
    height: 200px;
    width: 400px;
    border: 1px solid #000;
    -webkit-animation: animate_bg 5s;
    animation: animate_bg 5s;
    -webkit-animation-iteration-count: infinite;
    animation-iteration-count: infinite;
}

@keyframes animate_bg {
    0%   {background:red;}
    50%  {background:green;}
    100% {background:blue;}
}
.youtbid {
	margin-top: -45px;
    margin-left: 80px;
    color: #fff;
    font-weight: 600;}
    
        .npd { padding: 0 3px;}
    
</style>
