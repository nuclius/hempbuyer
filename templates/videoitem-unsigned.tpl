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

{include file="common/headerv-1.tpl" nocache}
{include file="time-common-loader.tpl" nocache}
{include file="videoitem-css.tpl" nocache}
<div class="row products_row">
   <div class="col-md-2 padboth1">{if $images}
    {foreach $images as $key => $val}
    {if $key == 0} 
    <!-- <a href="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" data-lightbox="{$projects.title}" data-title="">  --><img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" class="img-responsive" alt="1" id="zoom_{$key}"> 
    <!-- </a> --> 
    {/if}
    {/foreach}
    
    {else if !images} <a href="{$config['imgpath']}no_img.png" data-lightbox="{$projects.title}" data-title=""> <img src="{$config['imgpath']}no_img.png" class="img-responsive" alt="1" id="zoom_{$key}"></a> {/if}
    
  </div>
  <div class="col-md-10">
    <div class="row">
      <div class="col-md-4">
        <div class="project_title" style="border-radius:0; width:100%">{$projects.title}</div>
        <div class="ctgrychm div">
          <div class="plbl">Bidding Price:</div>
          <div class="pright_lbl"> US <span class="pric_l project_price">{$projects.wprice}</span></div>
        </div>
        <div class="ctgrychm div">
          <div class="plbl">Reserve Price:</div>
          <div class="pright_lbl"> US <span class="pric_l">{$projects.rprice}</span></div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="search_category "> {if $projects.market_status == 'closed'}
          <h3 class="schedule text-center font-12 font-semi-bold text-success m-btm-20">Meeting Closed</h3>
          <div class="row"><img src="{$config.url}/images/unsold.png"  class="img-responsive unsld"/></div>
          {elseif $projects.market_status == 'sold'}
          <h3 class="schedule text-center font-12 font-semi-bold text-success m-btm-20">Meeting Closed</h3>
          <div class="row"><img src="{$config.url}/images/soldout.png" class="img-responsive unsld"/></div>
          {else}
          <h3 class="schedule text-center font-12 font-semi-bold text-success m-btm-20">Meeting will begins in</h3>
          <div id="DateCountdown"   class="text-center" ></div>
          <div id="BidCountdown"  ></div>
            <p>&nbsp;</p>
          <div class="btn btn-danger" onclick="window.location.href='{$config.url}/register';">Register to join the room</div>
          <div class="btn btn-danger" onclick="window.location.href='{$config.url}/login';">Login to join the room</div>
              <p>&nbsp;</p>
          {/if} </div>
      </div>
    </div>
  </div>
 
</div>
<div class="row products_row" style="padding:0;">
  <div class="col-md-12">
    <div class="search_category"  style="margin:0;">
      <h3 class="text-center font-12 font-semi-bold text-success m-btm-20">Product Info</h3>
      <div id="remote-media"><div class="row">
        <div class="col-md-4">
          <div class="col-md-12 padboth"> 
            
            <!-- <div class="sp-loading"><img src="{$config.url}/images/sp-loading.gif" alt=""><br>LOADING IMAGES</div> -->
            
              {$titl = 0}
              {if $images}
              <div id="myCarousel" class="carousel slide" data-ride="carousel"> 
                <!-- <div class="sp-loading"><img src="{$config.url}/images/sp-loading.gif" alt=""><br>LOADING IMAGES</div> -->
                
                <ol class="carousel-indicators">
                  {foreach $images as $key => $val}
                  <li data-target="#myCarousel" data-slide-to="{$key}" {if $key == 0}class="active"{/if}></li>
                  {/foreach}
                </ol>
                <div class="carousel-inner" role="listbox"> 
                  {foreach $images as $key => $val}
                  <div class="item {if $key == 0}active{/if}"> 
                    <!-- <a href="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" data-lightbox="{$projects.title}" data-title="">  --> 
                    <img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" class="img-responsive" alt="1" id="zoom_{$key}">
                    <!-- </a> --> </div>
                  {/foreach}</div> <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev"> <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> <span class="sr-only">Previous</span> </a> <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next"> <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span> <span class="sr-only">Next</span> </a>
              </div>
              {else if !images}
              <div><a href="{$config['imgpath']}no_img.png" data-lightbox="{$projects.title}" data-title=""> <img src="{$config['imgpath']}no_img.png" class="img-responsive" alt="1" id="zoom_{$key}"></a></div>
              {/if}
          </div>
          </div>
        <div class="col-md-5">
          <div class="ctgrychm div">
            <div class="plbl">Payment Method :</div>
            <div class="ppimg"><img src="{$config.url}/images/productview.png" class="img-responsive" style="max-width: 180px;"></div>
          </div>
          <!--  {if $projects.auction}
        <button type="button" class="btn btn-danger {if $projects.user_id == $loged.userid} disabled {/if}" data-toggle="modal" data-target="#confirmbid">Bid Now</button>
        {/if} </div>-->
          
          <div class="loriem col-md-12"> {if $projects.sell_location}
            <div class="ct_headt initial_caps"  >Seller Location: {$projects.sell_location}</div>
            {/if}
            <div class="ct_headt">SHIPPING DETAILS</div>
            <div class="ctgrychm div">
              <div class="plbl">Shipping Fee:</div>
              <div class="pright_lbl pred_tlbl">$ {$projects.shipping_price}</div>
            </div>
            <div class="ctgrychm div">
              <div class="plbl">Shipping information:</div>
              <div class="pright_lbl">{$projects.shipping_description}</div>
            </div>
          </div>
          {foreach $cat_question as $key => $val}
          <div class="ctgrychm">
            <div class="plbl">{$val.name}:</div>
            <div class="pright_lbl">{$val.value}</div>
          </div>
          {/foreach} </div>
          
          
          
          <div class="col-md-3 con_seller">
            <div class="prv_gbox">
              <div class="seller_info">SELLER INFO</div>
              <div class="clearfix con_sp">
                <div class="">
                  <div> {if $projects.uimage == ''}<img src="{$config.url}/images/blankimg.png" height="100">{else}<img src="{$config.url}/uploads/profile/{$projects.uimage}" height="160">{/if}</div>
                  <div class="seller_name1 clearfix"> <a href="{$config.url}/profile/view/{$projects.user_id}">{$users.first_name} {$users.last_name|truncate:1:""} </a></div>
                </div>
                <div> {if $projects.review > 4.5}
                  <div class="ratings_pv"> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> </div>
                  {elseif $projects.review > 4}
                  <div class="ratings_pv"> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-half-empty"></i> </div>
                  {elseif $projects.review > 3.5}
                  <div class="ratings_pv"> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-o"></i> </div>
                  {elseif $projects.review > 3}
                  <div class="ratings_pv"> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-half-empty"></i> <i class="fa fa-star-o"></i> </div>
                  {elseif $projects.review > 2.5}
                  <div class="ratings_pv"> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> </div>
                  {elseif $projects.review > 2}
                  <div class="ratings_pv"> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-half-empty"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> </div>
                  {elseif $projects.review > 1.5}
                  <div class="ratings_pv"> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> </div>
                  {elseif $projects.review > 1}
                  <div class="ratings_pv"> <i class="fa fa-star"></i> <i class="fa fa-star-half-empty"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> </div>
                  {elseif $projects.review > .5}
                  <div class="ratings_pv"> <i class="fa fa-star"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> </div>
                  {elseif $projects.review > 0}
                  <div class="ratings_pv"> <i class="fa fa-star-half-empty"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> </div>
                  {else}
                  <div class="ratings_pv"> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i></div>
                  {/if} </div>
                <div class="cont_sller"> {if $loged.userid > 0 and $loged.userid != $projects.user_id}
                  <button type="button" {if $blocked == 1}disabled {/if} class="btn btn-danger bttns" data-toggle="modal" data-target="#sellerinfo"><i class="fa fa-envelope-o"></i>&nbsp;&nbsp;&nbsp;Contact Seller</button>
                  {/if} </div>
              </div>
            </div>
          </div>
          
        <div class="col-md-12">
          <div class="ct_headt">Product Description</div>
          <p> {$projects.description} </p>
        </div>
      </div></div>
    </div>
  </div>
  
</div>



<div class="clear m-top-20 m-btm-20"></div>



{include file="common/footer-1.tpl" nocache}
{include file="videoitem-unsigned-js.tpl" nocache}

