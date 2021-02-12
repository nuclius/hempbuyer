<!--============================================================================*\
|| ########################################################################## ||
|| # Auction Software Marketplace[*]version[*] Build [*]build[*]
|| # ---------------------------------------------------------------------- # ||
|| # Customer License # [*]license[*]
|| # ---------------------------------------------------------------------- # ||
|| # Copyright �2014�[*]year[*] Develop Scripts LLC. All Rights Reserved    # ||
|| # This file may not be redistributed in whole or significant part.       # ||
|| # ------------- AUCTION SOFTWARE IS NOT FREE SOFTWARE ------------------ # ||
|| # http://www.auctionsoftwaremarketplace.com|support@auctionsoftware.com  # ||
|| # ---------------------------------------------------------------------- # ||
|| ########################################################################## ||
\*============================================================================ -->

{include file="common/header-1.tpl" nocache}
<script src="{$config.url}/js/countdown.js"></script>
<!--{include file="time-common-loader.tpl" nocache}-->
<script src="{$config.url}/js/bootstrap.youtubepopup.js"></script>

<script type="text/javascript">
    var clock = [];
    var targetDate = [];
    var clearvar = [];
    var timeProject = [];

  $(document).ready(function(){

    try {
      /*$('.bxslider').bxSlider({
        pagerCustom: '#bx-pager',
        adaptiveHeight: true,
        mode: 'fade'
      }); */

      $('#lightSlider').lightSlider({
        gallery: true,
        item: 1,
        slideMargin: 0,
        thumbItem: 5
    });

      $('.zoomit').zoom({
        magnify:0.65
      });

      $(".youtube").YouTubeModal({width: 640, height: 480});
    }
    catch(e){
       //console.log(e);
    }

  });


</script>
<script type="text/javascript" src="{$config.url}/js/lightslider.min.js"></script>

<!-- <script src="{$config.url}/js/jquery.bxslider.min.js"></script> --> <!-- 16 KB -->
<script src="{$config.url}/js/responsiveslides.min.js"></script>
<script src="{$config.url}/js/jquery.zoom.min.js"></script>
<style>
    .initial_caps{
        text-transform: capitalize;
    }
   /* div#bx-pager img{
      width:23%;
    }
    .bx-wrapper .bx-controls-direction a{
      z-index: 2 !important;
    }*/
    .zoom {
      display:inline-block;
      position: relative;
    }

    /* magnifying glass icon */
    .zoom:after {
      content:'';
      display:block;
      width:33px;
      height:33px;
      position:absolute;
      top:0;
      right:0;
      background:url(icon.png);
    }

    .zoom img {
      display: block;
    }
    ul#lightSlider li .img-responsive{
      height:200px !important;
      margin: 0px auto;
      text-align:  center;
    }
    .zoomImg{
      width: auto !important;
    }

    .zoom img::selection { background-color: transparent; }
    .zoom img::selection { background-color: transparent; }

    #ex2 img:hover { cursor: url(grab.cur), default; }
    #ex2 img:active { cursor: url(grabbed.cur), default; }
</style>
<link rel="stylesheet" href="{$config['externalcss']}lightslider.css">
<!-- <link  href="{$config['externalcss']}jquery.bxslider.min.css" rel="stylesheet"> --> <!-- 3 KB -->

<link rel="stylesheet" type="text/css" href="{$config['externalcss']}responsiveslides.css" />
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}lightbox.css" />
<link rel="stylesheet" type="text/css" href="{$config.url}/css/common_responsive1.css" />


<script>

var  placedbid = '{$placedbid}';
var  market_status = '{$projects.market_status}';
var placecontract ='{$placecontract}';

if(placedbid == 1)
{
 $(function()
 {
     $('#cnx').modal('show');
 });
}
if(placecontract == 1)
{
 $(function()
 {
  //alert(2);
     $('#sellerinfoconfirm').modal('show');
 });
}


function setIntrevalMain(id,market_status)
{
 //console.log(id);
   clearvar[id] =  setInterval(function(){
                                          timeProject[id] = new Date();

                                          if(targetDate[id] >= new Date(timeProject[id]))
                                          {
                                             clock[id].innerHTML = countdown(targetDate[id]).toString();
                                          }
                                          else
                                          {

                                              if(market_status == 'open')
                                              {
                                               window.location = '{$config.url}/product/close/'+id;
                                               clock[id].innerHTML = 'Closed';
                                              }
                                          }

                                      }, 1000);
}
/*function setIntreval(id,market_status)
{
 //console.log(id);
 //console.log(targetDate[id]);
   clearvar[id] =  setInterval(function(){
                                          //timeProject[id] = new Date(timeProject[id].getTime() + 1000*1);
       timeProject[id] = new Date();
                                          if(targetDate[id] >= new Date(timeProject[id]))
                                          {
                                             clock[id].innerHTML = countdown(targetDate[id]).toString();
                                          }
                                          else
                                          {


                                              $('input:submit').prop('disabled',true);
                                               clock[id].innerHTML = 'Closed';

                                          }

                                      }, 1000);
}*/
function meee(id,dateee,price)
  {
 // id = '126';
 // alert(dateee);
    clearInterval(clearvar[id]);
    clock[id] = document.getElementById('my'+id)
    , targetDate[id] = new Date(dateee); // Jan 1, 2050;

    clock[id].innerHTML = countdown(targetDate[id]).toString();
     setIntreval(id,'');

  }




  </script>
<script>

function closediv()
{

  $("#sellerinfo").hide();

}
function check()
{

  var lastbid=$("#lstbid").val();
  var checkwsprice=$("#checkwsprice").val();
  var num=parseFloat(checkwsprice);
  var nums=(num).toFixed(2);

  // var num=checkwsprice.toFixed(2);
   //alert(num);
if(parseFloat(nums) <= parseFloat(lastbid))
{
alert("Your bid amount must be greater than the minimum bid amount to place. Please retry by entering a higher amount.");
    return false;
}else{
    if(false === $('#add-submitbid').parsley().validate())
    {
        return false;
    }else{
        $('input:submit').attr('disabled',true);
    }

}
}
</script>
<style>
#gallery_01 img{border:2px solid white;}
.active img{border:2px solid #333 !important;}
.modal {
  background: rgba(44, 41, 41, 0.66);
}
.products_row {
  padding: 15px 0;
  margin: 0;
  max-width: 100%;
}
.txt_center
{
  text-align: center;
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

    .highbidder{
        color:green;
        font-weight: 600;
        font-size: 16px;
    }

    .outbid{
        color:red;
        font-weight: 600;
        font-size: 16px;
    }
    }
</style>
<script>  var clock = [];  var targetDate = [];  var clearvar = []; </script>

<div class="row products_row">
<div>{if $inwatchlist}<a class="addwatchlist" onclick="javascript:void(0);" {if $projects.market_status != 'open'} style="display:none" {/if}>Added To Watchlist</a> {else}<a class="addwatchlist" id="addwatchlist" onclick="addtowatchlist({$projects.id})" href="javascript:void(0);" title="+ Add to Watchlist" rel="727" class="addwatchlist" name="#" {if $projects.market_status != 'open'} style="display:none" {/if}>Add to Watchlist</a> {/if}

&nbsp; <span> {if $user_bidded_status} <span class="real_bid_status highbidder ">{if $highbid} {$phrase.you_are_the_highest_bidder} </span> {else} <span style="color:red" class="real_bid_status outbid"> {$phrase.you_have_been_outbid} </span>{/if}{/if} </span>
</div>
<div class="project_title">{$projects.title}</div>
<div class="clearfix">
  <div class="col-md-4">
    <div class="col-md-10">


      <!-- <div class="sp-loading"><img src="{$config.url}/images/sp-loading.gif" alt=""><br>LOADING IMAGES</div> -->
     <ul id="lightSlider">
        {$titl = 0}
        {if $images}
        {foreach $images as $key => $val}

         <!-- <a href="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" data-lightbox="{$projects.title}" data-title="">  --><li data-thumb="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" id='ex{$titl++}' class="zoomit"><img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" class="img-responsive" alt="1" id="zoom_{$key}"></li>
        <!-- </a> -->

        {/foreach}

        {else if !images}
          <li><a href="{$config['imgpath']}no_img.png" data-lightbox="{$projects.title}" data-title=""> <img src="{$config['imgpath']}no_img.png" class="img-responsive" alt="1" id="zoom_{$key}"></a></li>
        {/if}

    </ul>
    </div>
    {if $projects.document != ''}

  <div class="videop">

    <a href="{$projects.document}" class="btn btn-default youtube html5lightbox" ><img class="youtube " id="youtubeimage" style="width: 80px;"   /> click here to see the video</a>
  </div>
  <script>
  var val = "{$projects.document}";
var myString = val.substr(val.indexOf("=") + 1)
 $('#youtubeimage').attr("src","http://img.youtube.com/vi/"+myString+"/1.jpg");

  </script>

    {/if}
  <!--<div class="map_lbl">
   Location shown on the map is in the general vicinity of the actual location.
   </div>
   <div class="map_pbox">
   </div>-->
  </div>
  <div class="col-md-8">
    <div class="row">
      <div class="col-md-8 ctg">
        <div class="ctgrychm">
          <div class="plbl">{$phrase.category} :</div>
        <div class="pright_lbl">
        {$elem = 1}
        {foreach $cat as $cats}
        {$elem = +$elem + 1}
          
          {$cats}
          
        {if $elem != $catnos+1}
         - 
        {/if}
        {/foreach}
        
        </div>
        </div>
        <div class="ctgrychm div">
          <div class="plbl">{$phrase.time_left} :</div>
          <div class="pright_lbl">{if !($live_status)} {$phrase.product_not_went_to_live} {elseif $projects.qty - $projects.sold -$projects.booked <= 0} {$phrase.auction_closed} {elseif $projects.market_status == 'open' or $projects.market_status == 'draft'}
              <h3 class="countdown" id="my{$projects.id}"style="text-align:left;">{$projects.day}</h3>
            {elseif $projects.market_status == 'moderate'} {$phrase.waiting_for_admin_approval}
            {else}
              {$phrase.auction_closed}{/if}</div>
        </div>
        {if $projects.buynow}
        <div class="ctgrychm div">
          <div class="plbl">{$phrase.buy_now_price} :</div>
          <div class="pright_lbl"> US $<span class="format">{$projects.bprice}</span></div>
        </div>
    <div class="ctgrychm div">
          <div class="plbl">{$phrase.retail_price} :</div>
          <div class="pright_lbl">US $<span class="format">{$projects.mprice}</span></div>
        </div>
        <div class="ctgrychm div">
          <div class="plbl">{$phrase.quantity_available} :</div>
          <div class="pright_lbl">{if $projects.qty - $projects.sold > 0} {$projects.qty - $projects.sold -$projects.booked} {else} 0 {/if}</div>
        </div>

        <div class="ctgrychm div">
          <div class="plbl ysave">{$phrase.you_save}:</div>
          <div class="pright_lbl"><span class="pp_ldata">US $ {subFloat($projects.mprice,$projects.bprice)}</span> <span class="pro_offer">{currencyConverter(100*{$projects.mprice - $projects.bprice}/$projects.mprice)} % off</span></div>
        </div>

        {/if}
        {if $projects.auction}
        <div class="ctgrychm div">
          <div class="plbl">{$phrase.current_bid} :</div>
          <div class="pright_lbl"> US $<span class="pric_l format">{$projects.wprice} </span>  {if $reservemeet}_reserve_price_met_{/if}</div>
        </div>
        {/if}
          {foreach $cat_question as $key => $val}
          <div class="ctgrychm">
              <div class="plbl">{$val.name}:</div>
              <div class="pright_lbl">{$val.value}</div>
          </div>
          {/foreach}
    <!--<div class="ctgrychm div">
          <div class="pull-left">Start Date:</div>
          <div class="img">{$projects.stime}</div>
        </div>
    <div class="ctgrychm div">
          <div class="pull-left">End Date:</div>
          <div class="img">{$projects.ctime}</div>
        </div>-->
         {if $projects.auction}
 {if $user_location != $projects.sell_location && $projects.sell_location != '' && $loged.userid > 0} 
  
  <div style= 'width:100%;color:red;clear:both; font-weight:bold; text-align:center'>{$phrase.seller_not_ship_product_to_your_location}  </div>
  
  {/if}


     <form id="submitbid"  action="{$config.url}/product/confirm/" method="post" enctype="multipart/form-data" data-parsley-validate class="form-inline" onsubmit="return check()">

        <input type="hidden" name="id" value="{$projects.id}" />
        <div class="ctgrychm div">
          <div class="plbl">{$phrase.place_your_bid} : </div>
         <div class="pright_lbl">
     <div class="pull-left">
      <div>
          <input type="digit" class="form-control pbid_amount floatpoint" data-parsley-errors-container="#bid_validation" style="padding: 6px;" data-parsley-min="{$next_bid}"   name="wsprice" id="checkwsprice" placeholder="$ 0.00" {if $config.general.proxy_bidding > 0} data-parsley-multipleof="10" {/if}  required></div>
          <div class="bid" style="display:none" >
              {$phrase.last_bid}:<span class="pric_l">{$projects.wprice}</span>
          </div>
          <input type="hidden" id="lstbid" value="{$projects.wprice}" />
      </div>

      <div class="pull-left">

          <input type="submit" {if $loged.userid > 0} {else} onclick="window.location='{$config.url}/login'" {/if}class="btn btn-danger" {if $projects.user_id == $loged.userid || $projects.market_status != 'open'} disabled {/if}  {if $user_location != $projects.sell_location && $projects.sell_location != ''} disabled {/if} {if $blocked == 1} disabled {/if} value="Submit Bid" > </input></div>



             <!--<div class="pull-left" style="margin-top: -22px;"><p> <a href="javascript:void(0);" class="bid"  data-toggle="modal" data-target="#bidhistory">[{$bcnt} bids]</a></p><button type="button" onClick="check()"class="btn btn-danger" {if $projects.user_id == $loged.userid} disabled {/if} {if $user_location != $projects.sell_location && $projects.sell_location != ''} disabled {/if} > Submit Bid</button></div>-->
        </div>


    </div>

      </form>

       {/if}
       {if $projects.buynow==1}
        {if $user_location != $projects.sell_location && $projects.sell_location != '' && $loged.userid > 0}  <div style= 'width:100%;color:red;clear:both; font-weight:bold; text-align:center'>{$phrase.seller_not_ship_product_to_your_location} </div>{/if}

       <div class="ctgrychm div form-inline">
          <div class="plbl">{$phrase.buy_now_quantity}</div>
         <div class="pright_lbl">
     <div class="pull-left">
      <div><input type="text" id="qty_add" class="form-control pbid_amount numberonly" name="qty"  placeholder="" required></div> <div class="bid"><span class=""></span></div>
      </div>
      <div class="pull-left">
        {if $loged.userid > 0}
        {assign var="cnt" value=$loged.pid.indexOf($projects.id)}
        <!--<button type="button" class="btn btn-danger  addcart {if $projects.user_id == $loged.userid} disabled {/if}" onClick="addToCart('{$projects.id}');"  {if $user_location != $projects.sell_location && $projects.sell_location != ''} disabled {/if} ><span>{if $cnt >= 0} Remove Cart {else if $projects.id > 0} Add To Cart {/if}</span></button>-->

          <button type="button" class="btn btn-danger  addcart {if $projects.user_id == $loged.userid} disabled {/if}" onClick="addToCart('{$projects.id}');" {if $blocked == 1} disabled {/if} {if $user_location != $projects.sell_location && $projects.sell_location != ''} disabled {/if} {if $projects.qty - $projects.sold <= 0}disabled{/if}><span>{if $projects.id > 0} {$phrase.add_to_cart} {/if}</span></button>
        {else}
        <button type="button"  class="btn btn-danger addcrt" onclick="window.location='{$config.url}/login'" {if $projects.qty - $projects.sold <= 0}disabled{/if}><i class="fa fa-shopping-cart" ></i>{$phrase.add_to_cart}</button>

        {/if}
        <br /> </div></div></div>
        {/if}
          {if $projects.auction}
              <div class="ctgrychm" >
                  <div class="plbl"></div>
                  <div class="pright_lbl" id="bid_validation"></div>
              </div>
              <div class="ctgrychm">
                  <div class="plbl"></div>
                  {if $projects.user_id != $loged.userid}  
                  <div class="pright_lbl">Enter US $<span id="next_bid">{$next_bid} </span> or more</div>
                  {/if}
              </div>
              {if $user_bidded_status}
                  <div class="ctgrychm">
                      <div class="plbl">{$phrase.your_last_bid} :</div>
                      <div class="pright_lbl"> US ${$current_bid} </div>
                  </div>
              {/if}
          <div class="ctgrychm" >
              <div class="plbl">{$phrase.total_bids} :</div>
              <div class="pright_lbl">  <p>
                  <a style="" href="javascript:void(0);" class="bid"  data-toggle="modal" data-target="#bidhistory">[{$bcnt} bids]</a>

              </p></div>
          </div>
        {/if}
        {if $projects.is_digital == 1}
         <div class="ctgrychm div">
          <div class="col-md-6 plbl">{$phrase.digital_items} :</div>
         <div class="col-md-6  m-bottom-20">
          {foreach $digital_items as $key => $val}<div class="ppimg  m-top-10">{$val.image}</div>{/foreach}</div>
        </div>
        {/if}
        <div class="ctgrychm div">
          <div class="plbl">{$phrase.payment_method} :</div>
          <div class="ppimg"><img src="{$config.url}/images/productview.png" class="img-responsive"></div>
        </div>
      <!--  {if $projects.auction}
        <button type="button" class="btn btn-danger {if $projects.user_id == $loged.userid} disabled {/if}" data-toggle="modal" data-target="#confirmbid">Bid Now</button>
        {/if} </div>-->

        <div class="loriem col-md-12">
      {if $projects.sell_location} <div class="ct_headt initial_caps"  >{$phrase.seller_location}: {$projects.sell_location}</div>{/if}
    <div class="ct_headt">{$phrase.shipping_details}</div>
   <div class="ctgrychm div">
          <div class="plbl">{$phrase.shipping_fee}:</div>
          <div class="pright_lbl pred_tlbl">$ {$projects.shipping_price}</div>
        </div>
     <div class="ctgrychm div">
          <div class="plbl">{$phrase.shipping_information}:</div>
          <div class="pright_lbl">{$projects.shipping_description}</div>
        </div>
  </div>


    </div>
      <div class="col-md-4 con_seller">
     <div class="prv_gbox">
        <div class="seller_info">{$phrase.seller_info}</div>
        <div class="clearfix con_sp">
          <div class="">
       <div> {if $projects.uimage == ''}<img src="{$config.url}/images/blankimg.png">{else}<img src="{$config.url}/uploads/profile/{$projects.uimage}" width="150">{/if}</div>
       <div class="seller_name1 clearfix"> <a href="{$config.url}/profile/view/{$projects.user_id}">{$users.first_name} {$users.last_name|truncate:1:""} </a></div>
      </div>
      <div>
          {if $projects.review > 4.5}
          <div class="ratings_pv">
            <i class="fa fa-star"></i>
            <i class="fa fa-star"></i>
            <i class="fa fa-star"></i>
            <i class="fa fa-star"></i>
            <i class="fa fa-star"></i>
           </div>
          {elseif $projects.review > 4}
          <div class="ratings_pv">
              <i class="fa fa-star"></i>
              <i class="fa fa-star"></i>
              <i class="fa fa-star"></i>
              <i class="fa fa-star"></i>
              <i class="fa fa-star-half-empty"></i>
          </div>
          {elseif $projects.review > 3.5}
          <div class="ratings_pv">
            <i class="fa fa-star"></i>
            <i class="fa fa-star"></i>
            <i class="fa fa-star"></i>
            <i class="fa fa-star"></i>
            <i class="fa fa-star-o"></i>
           </div>
          {elseif $projects.review > 3}
          <div class="ratings_pv">
              <i class="fa fa-star"></i>
              <i class="fa fa-star"></i>
              <i class="fa fa-star"></i>
              <i class="fa fa-star-half-empty"></i>
              <i class="fa fa-star-o"></i>
          </div>
          {elseif $projects.review > 2.5}
          <div class="ratings_pv">
              <i class="fa fa-star"></i>
              <i class="fa fa-star"></i>
              <i class="fa fa-star"></i>
              <i class="fa fa-star-o"></i>
              <i class="fa fa-star-o"></i>
          </div>
          {elseif $projects.review > 2}
          <div class="ratings_pv">
              <i class="fa fa-star"></i>
              <i class="fa fa-star"></i>
              <i class="fa fa-star-half-empty"></i>
              <i class="fa fa-star-o"></i>
              <i class="fa fa-star-o"></i>
           </div>
          {elseif $projects.review > 1.5}
          <div class="ratings_pv">
              <i class="fa fa-star"></i>
              <i class="fa fa-star"></i>
              <i class="fa fa-star-o"></i>
              <i class="fa fa-star-o"></i>
              <i class="fa fa-star-o"></i>
          </div>
          {elseif $projects.review > 1}
          <div class="ratings_pv">
            <i class="fa fa-star"></i>
            <i class="fa fa-star-half-empty"></i>
            <i class="fa fa-star-o"></i>
            <i class="fa fa-star-o"></i>
            <i class="fa fa-star-o"></i>
            </div>
          {elseif $projects.review > .5}
          <div class="ratings_pv">
                <i class="fa fa-star"></i>
                <i class="fa fa-star-o"></i>
                <i class="fa fa-star-o"></i>
                <i class="fa fa-star-o"></i>
                <i class="fa fa-star-o"></i>
            </div>
          {elseif $projects.review > 0}
          <div class="ratings_pv">
            <i class="fa fa-star-half-empty"></i>
            <i class="fa fa-star-o"></i>
            <i class="fa fa-star-o"></i>
            <i class="fa fa-star-o"></i>
           <i class="fa fa-star-o"></i>
           </div>
          {else}
          <div class="ratings_pv">
          <i class="fa fa-star-o"></i>
          <i class="fa fa-star-o"></i>
          <i class="fa fa-star-o"></i>
          <i class="fa fa-star-o"></i>
          <i class="fa fa-star-o"></i></div>
          {/if} </div>

        <div class="cont_sller">
         {if $loged.userid > 0 and $loged.userid != $projects.user_id}
          <button type="button" {if $blocked == 1} disabled {/if} class="btn btn-danger bttns" data-toggle="modal" data-target="#sellerinfo"><i class="fa fa-envelope-o"></i>&nbsp;&nbsp;&nbsp;{$phrase.contact_seller}</button>

         {/if}
        </div>
    </div>
    <!--<div class="" {if $projects.buynow==0}style="display:none;"{/if}> {if $projects.qty - $projects.sold > 0}
        {if $loged.userid > 0}
        {assign var="cnt" value=$loged.pid.indexOf($projects.id)}
        <button type="button" class="btn btn-default btns2 addcart {if $projects.user_id == $loged.userid} disabled {/if}" onClick="addToCart('{$projects.id}');"><i class="fa fa-shopping-cart" lattr="Processing"></i>&nbsp;&nbsp;&nbsp;<span>{if $cnt >= 0} Remove Cart {else if $projects.id > 0} Add To Cart {/if}</span></button>
        {else} <a href="{$config.url}/login">
        <button type="button"  class="btn btn-default btns2"><i class="fa fa-shopping-cart"></i>&nbsp;&nbsp;&nbsp;Add To Cart</button>
        </a> {/if}
        {/if} </div>-->
      </div>

    </div>

  <div class="loriem col-md-12">
    <div class="ct_headt">{$phrase.product_description}</div>
    <p> {$projects.description} </p>
  </div>
  </div>

</div>
</div>

<div class="video-conference" id="videos-container">




</div>
<div class="discconect" onclick="disconnect()">Disconnect All</div>
<div class="discconect" onclick="disconnectMe()">{$phrase.disconnect_me}</div>
<div class="discconect" onclick="connectMe()">{$phrase.connect_me}</div>


<script src="//cdn.webrtc-experiment.com/firebase.js">
    </script>
<script src="//cdn.webrtc-experiment.com/RTCMultiConnection.js">
</script>
<script language="javascript" type="text/javascript">
function disconnectMe()
{
 //console.log(connection.userid);	
  connection.disconnect(connection.userid);	
  connection.refresh(); 
}
function connectMe()
{
	     //$('.video-conference').html('');  
		 connection.refresh(); 
         connection.join('req_create_room_room_{$prdt.id}');
		 connection.connect();
  
}

if('{$loged.userid}' != '')
{ 
var sessions = {};
var videosContainer = document.getElementById('videos-container') || document.body;
function emitRoomonceagain()
{
var lname = '{$loged.last_name}';
var resultss = {
            roomId : 'room_{$prdt.id}',   
            userid:'{$loged.userid}' ,
			name:'{$loged.first_name}',
			id:'{$prdt.id}',
			uid:'{$loged.userid}'
			
			
        }


socket.emit('req_create_room', resultss);
socket.emit('req_create_room_room_{$prdt.id}', resultss);
}
emitRoomonceagain();
var connection = new RTCMultiConnection();
connection.userid = 'req_create_room_room_{$loged.userid}';
connection.dontOverrideSession = false;
connection.session = {
	audio: true,
	video: true
};
		
connection.onstream = function(e) {
e.mediaElement.width = 600;
if($('#'+e.mediaElement.id).length > 0)
{
	$('#'+e.mediaElement.id).remove();
}
videosContainer.insertBefore(e.mediaElement, videosContainer.firstChild);
rotateVideo(e.mediaElement);
scaleVideos();
};

function rotateVideo(mediaElement) {
mediaElement.style[navigator.mozGetUserMedia ? 'transform' : '-webkit-transform'] = 'rotate(0deg)';
setTimeout(function() {
	mediaElement.style[navigator.mozGetUserMedia ? 'transform' : '-webkit-transform'] = 'rotate(360deg)';
}, 1000);
}

connection.onstreamended = function(e) {
console.log(e);
e.mediaElement.style.opacity = 0;
rotateVideo(e.mediaElement);
setTimeout(function() {
	
	connection.join('req_create_room_room_{$prdt.id}' || 'Anonymous');
    connection.connect();
}, 1000);
};		


connection.onNewSession = function(session) {
if (sessions[session.sessionid]) return;
sessions[session.sessionid] = session;
	connection.join(session);

};
var connected = false;               
socket.on('req_create_room', function(msg){
console.log(msg);
if(msg.room == 'create' && '{$prdt.id}' == msg.id && !connected)
{
	connection.open('req_create_room_room_{$prdt.id}' || 'Anonymous');
    connection.connect();
	window.onresize = scaleVideos;	
	connected = true;
}
if(msg.room == 'started' && '{$prdt.id}' == msg.id && !connected)
{
	            
        connection.join('req_create_room_room_{$prdt.id}');
        connection.connect();
		window.onresize = scaleVideos;	
		connected = true;
}
});
socket.on('req_create_room_room_{$prdt.id}', function(msg){
	   var allow = false;
	   if(typeof(msg[0]) !== 'undefined')
	   {
	    var l = msg[0].topbidders.length;
        for(i in msg[0].topbidders)
		   {
			  if('{$loged.userid}' == msg[0].topbidders[i])
			  {
				
				  allow = true;
			  }
			  if(i == l-1)
			  {
				  if(!allow && '{$prdt.user_id}' != '{$loged.userid}')
				  {
					  connection.disconnect();
					 ////console.log('disconnect');
				  }
				  else
				  {
					  connection.join('req_create_room_room_{$prdt.id}');
					  connection.connect();
					 //console.log('connect');
				  }
			  }
			  
		     }
		   }
		
});
function disconnect()
{
  connection.disconnect();	
}
function scaleVideos() {
            var videos = document.querySelectorAll('video'),
                length = videos.length,
                video;

            var minus = 130;
            var windowHeight = 700;
            var windowWidth = 600;
            var windowAspectRatio = windowWidth / windowHeight;
            var videoAspectRatio = 4 / 3;
            var blockAspectRatio;
            var tempVideoWidth = 0;
            var maxVideoWidth = 0;

            for (var i = length; i > 0; i--) {
                blockAspectRatio = i * videoAspectRatio / Math.ceil(length / i);
                if (blockAspectRatio <= windowAspectRatio) {
                    tempVideoWidth = videoAspectRatio * windowHeight / Math.ceil(length / i);
                } else {
                    tempVideoWidth = windowWidth / i;
                }
                if (tempVideoWidth > maxVideoWidth)
                    maxVideoWidth = tempVideoWidth;
            }
            for (var i = 0; i < length; i++) {
                video = videos[i];
                if (video)
                    video.width = maxVideoWidth - minus;
            }
        }
}
</script>	
 <div class="simpro_lbl">{if $similar_product_count > 0} {$phrase.similar_products_for_other_sellers} {else} {$phrase.no_products_found} {/if}</div>

   {$proj=$oproject}
   {include file="projects-new.tpl" nocache}

</div>
<div class="modal fade" id="confirmbid" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm" id="messagebox">
    <div class="modal-content">  <div class="modal-header">
      <img src="{$config.url}/images/logoc.png" class="img-responsives"/>
       </div>
      <div class="modal-body">
      <form id="submitbid2"  action="{$config.url}/product/confirm/" method="post" enctype="multipart/form-data" class="form-inline" >
        <input type="hidden" name="id" value="{$projects.id}" />
        <div class="form-group">
          <label for="email">{$phrase.place_your_bid} </label>
          <input type="text" class="form-control floatpoint" style="padding:6px 0px;"name="wsprice" id="checkwsprice" placeholder="$ 0.00" required>
          <div class="bid" style="display:none">{$phrase.last_bid}:<span class="pric_l">{$projects.wprice}</span></div>
          <input type="hidden" id="lstbid" value="{$projects.wprice}" />
        </div>
        <button type="button" onClick="check()"class="btn btn-danger"> {$phrase.submit_bid}</button>
      </form>
    </div>
    </div>
  </div>
</div>
{if $placedbid}
<div class="modal fade" id="cnx" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
   <div class="modal-content">

    <div class="modal-header">
        <img src="{$config.url}/images/logoc.png" class="img-responsives"/>
         </div>
        <div class="modal-body">
      <div class="cong">{$phrase.congratulations}<img src ="{$config.url}/images/thumb.png"></div>
      <div class="bid_succes">{$phrase.bidded_successfully}!....</div>
      <button type="button" class="btn btn-danger butns" data-dismiss="modal">{$phrase.ok}</button>
    </div>
  </div>

  </div>
  </div>
</div>
{/if}



<div class="modal fade" id="bidhistory" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
      <img src="{$config.url}/images/logoc.png" class="img-responsives"/>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><img src="{$config.url}/images/close.png" style="position: absolute;right: -10px;top: -15px;" width="27px" height="27px" /></button>
      </div>
      <div class="modal-body bid_history">
      <h5 class="bid_hlbl">{$phrase.bid_history}</h5>
      <div class="panel panel-default">
        <div class="panel-heading">
          <div class="row">
            <div class="col-md-5">
              {$phrase.user_name}
            </div>
            <div class="col-md-4">
              {$phrase.date_time}
            </div>
            <div class="col-md-3">
            {$phrase.amount}
            </div>
          </div>
        </div>
        <div class="panel-body">
         {if $bids|count <=  0}
      <div class="row">
    <div class="col-md-12 txt_center">{$phrase.no_bids_found} </div>
    </div>
      {else}
      {foreach $bids as $key => $val}
        <div class="row">
          <div data-label="User Name" class="col-md-5">{$val.name}</div>
          <div data-label="Bid Amount" class="col-md-4">{$val.date_add}</div>
           <div data-label="Bid Time" class="col-md-3" >US $ <span id="price{$val.proposed_amount}" class="format">{$val.proposed_amount}</span></div>
           <!--<script>
          var num = {$val.proposed_amount};
          var result = num.toFixed(2);
          $('#c{$val.bidids}').text('Us $'+result);
             </script>
                <script>-->

        </div>
       {/foreach}
      {/if}
        </div>
      </div>
    </div>
    </div>
  </div>
</div>



<div class="modal fade" id="sellerinfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
      <img src="{$config.url}/images/logoc.png" class="img-responsives"/>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><img src="{$config.url}/images/close.png" style="position: absolute;right: -10px;top: -15px;" width="27px" height="27px" /></button>
      </div>
      <div class="modal-body">
       <form action="{$config.url}/product/contact/" method="post" data-parsley-validate enctype="multipart/form-data" class="form-inline">
        <input type="hidden" name="id" value="{$projects.id}" />
        <div class="row">
          <div class="col-md-12">
          <h2 style="font-weight: bold;">{$phrase.message}</h2>
          <textarea class="form-control" name="message" data-parsley-required-message="Please enter message" data-parsley-required  style="width:100%;background: #EBEBEB;height:150px;/*margin-left:25px;*/" placeholder="Contact Seller..."> </textarea>
          </div>
          <div class="col-md-5">
          <input type="submit" type="button" style="margin: 11px 0px 11px 97px;" class="btn btn-danger" value="Submit">
          </div>
        </div>
        </form>
    </div>
    </div>
  </div>
</div>
{if $placecontract}
<div class="modal fade" id="sellerinfoconfirm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
   <div class="modal-header">
      <img src="{$config.url}/images/logoc.png" class="img-responsives"/>
  </div>
   <div class="modal-body">

      <div class="cong">{$phrase.thank_you}<img src ="{$config.url}/images/thumb.png"></div>
      <div class="bid_succes">{$phrase.message_sent_successfully}!....</div>
      <button type="button" class="btn btn-danger butns" data-dismiss="modal">{$phrase.ok}</button>
    </div>
  </div>
  </div>
</div>
{/if}

<span class="video-link" data-video-id="y-PKffm2uI4dk" data-video-width="1280px" data-video-height="720px" data-video-autoplay="1" ></span>
{include file="common/footer-1.tpl" nocache}

<script language="javascript" type="text/javascript">
if(typeof(clearvar) === 'undefined')
{
  var clock = [];  var targetDate = [];  var clearvar = []; var timeProject = [];
}
$(function(){

   /* window.ParsleyValidator.addValidator('multipleof', {
        requirementType: 'integer',
        validateNumber: function(value, requirement) {
            return 0 === value % requirement;
        },
        messages: {
            en: 'This value should be a multiple of %s',
            fr: 'Cette valeur doit �tre un multiple de %s'
        }
    });*/




        timeProject['{$projects.id}'] = new Date('{$datenow}');
        clearvar['{$projects.id}'] = setInterval(function () {
        });
        setIntrevalMain('{$projects.id}', '{$projects.market_status}');
        clock['{$projects.id}'] = document.getElementById('my{$projects.id}');
        targetDate['{$projects.id}'] = new Date('{$projects.closed}');

        clock['{$projects.id}'].innerHTML = countdown(targetDate['{$projects.id}']).toString();
        $(function () {
            $('.myp').addClass('act_class');
        });
    if(placedbid == 1) {
        var pid = '{$projects.id}';

        var dt = '{$projects.closed}';
       //console.log(dt);
        var resultss = {
            id: pid,
            date: dt,
            price: '{$projects.wprice}',
            pric_l: $('.pric_l').html(),
            bid_history: $('.bid_history').html(),
            bidder_id : '{$highbid_user_id}'
        }
       //console.log(resultss);

        socket.emit('bidAddtime', resultss);
    }
})
socket.on('bidAddtime', function (msg) {
    // meee(msg.id,msg.date);
   ////console.log("In socket on "+JSON.stringify(msg));
    if ('{$projects.id}' == msg.id) {
        $('.pric_l').html(msg.pric_l);
        $('.bid_history').html(msg.bid_history);
        $('.sbid').html($('.lcntbid').html());

        if('{$user_bidded_status}'){
            if(msg.bidder_id == '{$user_id}'){

                var nextbid = (parseFloat({$next_bid})).toFixed(2);
                $('.real_bid_status').html('You are the highest bidder');
                $('.real_bid_status').addClass('highbidder');
                $('bid_msg').removeClass('outbid');
                $('#next_bid').html(nextbid);

                $('#lstbid').val({$current_bid});

                /*$('bid_msg').html('You have been outbid');
                $('bid_msg').addClass('green');
                $('bid_msg').removeClass('red');*/
            }else{
                $('.real_bid_status').html('You have been outbid');
                $('.real_bid_status').addClass('outbid');
                $('bid_msg').removeClass('highbidder');
                if(parseInt({$config.general.proxy_bidding}) > 0){
                    var nextbid = (parseFloat(msg.price) + 10).toFixed(2);
                }else{
                    var nextbid = (parseFloat(msg.price) + 1).toFixed(2);
                }

                $('#next_bid').html(nextbid);
                $('#lstbid').val(msg.price);
              /*  $('bid_msg').html('You have been outbid');
                $('bid_msg').addClass('red');
                $('bid_msg').removeClass('green');*/
            }
        }else{
            if(parseInt({$config.general.proxy_bidding}) > 0){
                var nextbid = (parseFloat(msg.price) + 10).toFixed(2);
            }else{
                var nextbid = (parseFloat(msg.price) + 1).toFixed(2);
            }

            $('#next_bid').html(nextbid);

            $('#lstbid').val(msg.price);
        }

        meee(msg.id, msg.date, msg.price);
    }
});

     </script>
<script type="text/javascript">

$(function()
{

  projectLoad();
   var sync1 = $(".main-preview");


        sync1.owlCarousel({
          singleItem : true,
          slideSpeed : 500,
          navigation: true,
          navigationText: ['<i class="fa fa-chevron-left"></i>','<i class="fa fa-chevron-right"></i>'],
          pagination:false,
          responsiveRefreshRate : 200,
        });




});
function addToCart(id)
{
  //console.log(parseInt($('#qty_add').val()));
  //console.log($('.addcart').find('span').html().indexOf("Add"));
  if((parseInt($('#qty_add').val()) <= 0 || $('#qty_add').val() == '') &&  $('.addcart').find('span').html().indexOf("Add") >= 0)
  {
        alert('Please select atleast one quantity');
        return false;
  }
  $.ajax({
    type : 'GET',
      url  : '/product/cart/'+id+'?qty='+$('#qty_add').val(),
      data : {},
      dataType : 'json',
      success  : function(data)
      {
       //console.log(data);
        if((!(data.membership_status)) && data.success){

            window.location = '{$config.url}/product/membership_reached';
            return false;
        }
             if(data.success)
             {
               if(data.add)
               {
                 $('.addcart').find('span').html(' Remove Cart');
                 var k = parseInt($('.cart').html());
                 k = k + 1;
                 if(k < 0)
                 {
                  k = 0;
                 }
                 $('.cart').html(k);
                 if(k > 0)
                 {
                  window.location = '{$config.url}/product/checkout/cart/'
                 }
               }
               else
               {
                $('.addcart').find('span').html(' Add to Cart');
                var k = parseInt($('.cart').html());
                 k = k - 1;
                 if(k < 0)
                 {
                  k = 0;
                 }
                 $('.cart').html(k);

               }
                if(k == 1 && data.add)
                {
                  $('.timer_cnt .cnter').html({$config.general.cart_timer}-1);
                  runTimer();
                }

             }
             else
             {
                 if(data.error == '')
                 {
                  window.location = '{$config.url}/login';
                 }
                 else
                 {
                  alert(data.error);
                 }
             }
      }

  });
}
</script>
{if $bidshow}
<script type="text/javascript">
$(function()
{
  $('#confirmbid').modal();
});</script>
{/if}
{if $buyshow}
<script type="text/javascript">
$(function()
{
  $('#buybid').modal();
});</script>
{/if}
<script>


$(document).ready(function() {
if({$error}){
    alert("cannot bid lower than original proxy amount")
}
   $("#slider4").responsiveSlides({
  auto: false,
  pager: false,
  nav: true,
  speed: 500,
  namespace: "callbacks",
  before: function () {
    $('.events').append("<li>before event fired.</li>");
  },
  after: function () {
    $('.events').append("<li>after event fired.</li>");
  }
  });
    if(parseInt({$cnt}) >= 0){
        $('.addcart').prop('disabled',true);
    }

});
</script>
