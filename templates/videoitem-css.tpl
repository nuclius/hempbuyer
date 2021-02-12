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

.videoFrame
{
  position:relative;	
}
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
#remote-media .videoFrame
{
	width: 200px;
	margin:0px 10px 5px 0px;
	height: 170px;
	padding:0px !important;
}
#remote-media video
{
	width: 198px;
}
.videoFrame
{
	position: relative;
	margin:0px 15px 15px 0px;
	width: 250px;
    float: left;
    height: 205px;
    margin-bottom: 15px;
    border-radius: 5px;
    background: #f00;
}
.videoFrame .uname.topper
{	
    background: #f00;
}
.videoFrame .uname
{   
    position: absolute;
    width: 100%;
    height: 20px;
    bottom: 0px;
    left: 0px;
    text-align: center;
    background: #0f0;
    color: #fff;
    font-size: 14px;
    }.carousel-inner > .item > img, .carousel-inner > .item > a > img { 
    margin: 0 auto;    max-height: 138px;
    }
video
{
    width: 250px;
}
    #gallery_01 imgborder
    .active imgborder
    .modal {
        background: rgba(44, 41, 41, 0.66);
    }
    .products_row {
        padding: 15px 0;
        margin: 0;
        max-width: 100%;
    }

    @keyframes animated_div
{
0%		{transform: rotate(0deg);left:0px;}
25%		{transform: rotate(20deg);left:0px;}
50%		{transform: rotate(0deg);left:500px;}
55%		{transform: rotate(0deg);left:500px;}
70%		{transform: rotate(0deg);left:500px;background:#1ec7e6;}
100%	{transform: rotate(-360deg);left:0px;}
}

@-webkit-keyframes animated_div
{
0%		{-webkit-transform: rotate(0deg);left:0px;}
25%		{-webkit-transform: rotate(20deg);left:0px;}
50%		{-webkit-transform: rotate(0deg);left:500px;}
55%		{-webkit-transform: rotate(0deg);left:500px;}
70%		{-webkit-transform: rotate(0deg);left:500px;background:#1ec7e6;}
100%	{-webkit-transform: rotate(-360deg);left:0px;}
}

@-moz-keyframes animated_div
{
0%   {-moz-transform: rotate(0deg);left:0px;}
25%  {-moz-transform: rotate(20deg);left:0px;}
50%  {-moz-transform: rotate(0deg);left:500px;}
55%  {-moz-transform: rotate(0deg);left:500px;}
70%  {-moz-transform: rotate(0deg);left:500px;background:#1ec7e6;}
100% {-moz-transform: rotate(-360deg);left:0px;}
}

@-o-keyframes animated_div
{
0%   {transform: rotate(0deg);left:0px;}
25%  {transform: rotate(20deg);left:0px;}
50%  {transform: rotate(0deg);left:500px;}
55%  {transform: rotate(0deg);left:500px;}
70%  {transform: rotate(0deg);left:500px;background:#1ec7e6;}
100% {transform: rotate(-360deg);left:0px;}
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
		padding-top: 20px;
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
    font-size: 16px;
    background: #a4aeb0;
    float: right;
    width: 100%;
    padding: 10px 16px 11px;
	position:relative;
	
}.visitor_name
{
    float: right;
   /* background: #ccc;*/
    padding: 5px 10px;
	display:inline-block;
    /*border-radius: 5px;*/
    font-size: 9px;
    margin-bottom: -10px;	
}.visitor-message-tip {
    content: '';
    position: absolute;
    border: 6px solid #fff;
    width: 0;
    height: 0;
    top: 29px;
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
	  	
	}.unsld {     max-height: 100px;
    margin: 0 auto; }
	.chatonline
	{
	      width: 400px;
		  position: fixed;right:0px;
		  bottom: 0px;
		  background: transparent;
		  margin-bottom: -20px;	
	}
	.carousel-control
	{
	  width:auto !important;	
	}
	#myCarousel
	{
	  height:125px;	
	}
</style>
