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
{include file="videoitem-css-new.tpl" nocache} 
<!--First Row start-->

<div class="row products_row">
    
    <div class="col-md-12 padlr">
    
    <div class="col-sm-4 npd">
        
    <div class="allbodr"> 
    <div class="col-md-12 padlr">
      <h3 class="text-center prodct">Seller Video</h3>
      <div id="local-media" class="" style="display:inline-block;"> </div>
    </div>
     </div>
        <div class="clearfix"></div>
        {if $projects.market_status == 'open'}{if $seller == 1}
    <div class="row">
         <div class="col-md-4 npd text-center"> </div>
      <div class="col-md-4 npd text-center">
        <button type="button" class="btn btn-success"  style="margin-top:10px;" onclick="startBidding();" >Start Bidding</button>
      </div>
     
    </div>
    {/if}{/if}
        
        
     </div>
    
     <div class="col-sm-5 npd">
    <div class="allbodr">
        <h3 class="text-center prodct">Live Video Auction</h3>
            <div class="col-md-12 padboth default-ht">
     
      <div class="col-md-8 col-md-offset-2">
        <div class=" " style="margin-top: 0px;"> {if $projects.market_status == 'open'}
          <div class="schedule text-center padboth font-12 font-semi-bold text-success m-btm-20">Meeting will begins in</div>
          <div id="DateCountdown"  class="text-center" ></div>
          <div id="BidCountdown"  ></div>
          {/if}
          {if $projects.market_status == 'closed'}
          <div class="schedule padboth text-center font-12 font-semi-bold text-success m-btm-20">Meeting Closed</div>
          <div class="row closed"><img src="{$config.url}/images/unsold.png"  class="img-responsives  unsv" /></div>
          {/if}
          {if $projects.market_status == 'sold'}
          <div class="schedule padboth text-center font-12 font-semi-bold text-success m-btm-20">Meeting Closed</div>
          <div class="row closed"><img src="{$config.url}/images/soldout.png"  class="img-responsives"/></div>
          {/if} </div>
      </div>
                
                 <div class="col-md-12  padboth1 text-center">
        <div class="brp">
          <div class="plbl">Bidding Price:  $ <span class="pric_l project_price">{$projects.wprice}</span></div>
        </div>
          
          <div class="vczlt brp">
          <div class="plbl">Reserve Price:  $<span class="pric_l">{$projects.rprice}</span></div>
        </div>
      </div>
      
    </div>
      </div>
     </div>
    
    <div class="col-sm-3 npd">
    <div class="allbodr">
        <h3 class="text-center prodct">Product</h3>
       <div class="col-md-12 padlr con_seller">
          <div class="prv_gbox"> 
            <div class="clearfix con_sp">
              <div class="">
                <div>{if $images}
                  <div id="myCarousel" class="carousel slide" data-ride="carousel"> 
                    <!-- <div class="sp-loading"><img src="{$config.url}/images/sp-loading.gif" alt=""><br>LOADING IMAGES</div> -->
                    
                    <ol class="carousel-indicators">
                      {foreach $images as $key => $val}
                      <li data-target="#myCarousel" data-slide-to="{$key}" {if $key == 0}class="active"{/if}></li>
                      {/foreach}
                    </ol>
                    <div class="carousel-inner" role="listbox"> {foreach $images as $key => $val}
                      <div class="item {if $key == 0}active{/if}"> 
                        <!-- <a href="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" data-lightbox="{$projects.title}" data-title="">  --> 
                        <img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" class="img-responsive" alt="1" id="zoom_{$key}"> 
                        <!-- </a> --> </div>
                      {/foreach} </div>
                    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev"> <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> <span class="sr-only">Previous</span> </a> <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next"> <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span> <span class="sr-only">Next</span> </a> </div>
                  {else if !images}
                  <div><a href="{$config['imgpath']}no_img.png" data-lightbox="{$projects.title}" data-title=""> <img src="{$config['imgpath']}no_img.png" class="img-responsive" alt="1" id="zoom_{$key}"></a></div>
                  {/if}</div>
                <div class=" col-md-12 padboth5 clearfix"> <a href="{$config.url}/profile/view/{$projects.user_id}" class="ftn16">{$projects.nick_name} </a></div>
                  <div class="panel-vw padboth col-md-12 clearfix"> <a href="{$config.url}/profile/view/{$projects.user_id}">View the Product </a></div>
                  
              </div>
              <div> </div>
            </div>
          </div>
        </div>
      </div>
     </div>
    </div>
       <div class="col-md-12 padlr padboth1">
 {if $seller != 1}
    <div class="col-sm-4 padlr">  
        
      <div class="col-md-12" style="padding-left: 4px;padding-right: 4px;">
        <div class="allbodr">
<!--          <h3 class="text-center prodct-blk">Your Video</h3>-->
          <div class="col-md-12 ">
            <div id="buyer-media" class="buyer-media1"> </div>
          </div>
          <div class="col-md-12 mrgtp5 outbid hide"><img src="{$config.url}/images/video/outbit.png" class="img-responsive">
                        <P class="youtbid">You are Outbid!</P></div>
        </div>
      </div>
    
      </div>
          {/if}   
           <div class="col-md-4 padlr text-center  ">
               {if $projects.market_status == 'open'}
       <div class="col-md-12 npd ">
    <div class="allbodr default-ht1  padboth1"> <img src="{$config.url}/images/video/phone.png" class="call">
      <p class="padboth">Join by Phone</p>
      <button type="button" class="btn btn-success" id="add-number"  style="margin-top:10px;" >Call Now: {$phone} </button>
    </div></div>
        {/if}          
  </div>
           
     
           {if $projects.market_status == 'open'}
      {if $seller == 1}
      <div class="col-md-4 npd ">
        <div class="allbodr default-ht1">
          <h3 class="text-center prodct-blk">Available Users</h3>
          <div class="logger"></div>
          <div class="text-center">
            <button type="button" class="btn btn-success bgblue"  style="margin-top:10px;" data-toggle="modal" onclick="inviterList();$('#invitorlist').modal('show');">Invite Users</button>
          </div>
        </div>
      </div>
      <div class="col-md-4 npd ">
        <div class="allbodr default-ht1"  >
          <h3 class="text-center prodct-blk">Active Users</h3>
          <div class="connecter"></div>
        </div>
      </div>
      {/if}{/if}  
          <div class="clearfix"></div>
    
     
           
           
    
    </div>
    
<!--
  <div class="col-md-3">
    <div class="col-md-12 mrgtp">
      <div class="allbodr" style="    height: 247px;">
        <h3 class="text-center prodct" >Bid History</h3>
        <div class="bids" style="display: inline-block;"></div>
      </div>
    </div>
  </div>
-->
<!--
  <div class="col-md-6">
    <div class="col-md-12 text-center"><span class="lva">LIVE VIDEO AUCTION</span></div>

    <div class="row products_row">
    </div>
 
  <div class="col-md-3">
    <div class="row">
      <div class="allbodr mrglft">
       
 
        <div class="col-md-12">
          <div class="pdis">Product Description</div>
          <p class="fntsiz">{$projects.description} </p>
        </div>
        <div class="col-md-12">
          <div class="col-md-3 allpd mrgtp">
            <div class="prodct1">SELLER INFO</div>
            <div>{if $projects.uimage == ''}<img src="{$config.url}/images/blankimg.png"  width="100%">{else}<img src="{$config.url}/uploads/profile/{$projects.uimage}" width="100%">{/if}</div>
          </div>
          <div class="col-md-9">
            <div class="loriem col-md-12">
              <div class="plbl fntbls">Seller Location: <span class="bluclr"> {$projects.sell_location}</span></div>
              <div class="plbl fntbls">Shipping Fee: <span class="bluclr">$ {$projects.shipping_price}</span></div>
              <div class="plbl fntbls">Shipping information: <span class="bluclr">{$projects.shipping_description}</span></div>
            </div>
          </div>
          <div class="col-md-12 ">
            <div class="pdis">Payment Method :</div>
            <div class=""><img src="{$config.url}/images/productview.png" class="img-responsive"></div>
          </div>
        </div>
 
        <div class="clearfix"></div>
      </div>
    </div>
  </div>
 
</div>
-->

<!--First Row End-->
{if $projects.market_status == 'open'}
<div class="row products_row">
  <div class="col-md-6 npd">
    <div class="allbodr">
      <h3 class="text-center prodct">Video Conference Room</h3>
      <div id="remote-media" ></div>
    </div>
  </div>
  
    
      <div class="col-md-6 padlr">
    <div class="col-md-6 npd">
    <div class="allbodr">
         <h3 class="text-center prodct" >Bid History</h3>
        <div class="bids" style="display: inline-block;"></div>
        </div>
    </div>
          
          <div class="col-md-6 npd">
    <div class="allbodr">
         <h3 class="text-center prodct" style="background: #f5262d;"> <i class="fa fa-weixin"></i> Live Chat</h3>
       
        <div class="chatonline"> 
<!--  <h3 class="text-center prodct" onclick="chatOpen(this)" style="height:50px;">Chat Online<span style="float:right;" ><i class="fa fa-sort-desc"></i></span></h3>-->
  <div class="chat-content">
    <div class="row" style="margin:10px;">
      <div class="col-md-12 msg_group"></div>
      <div class="col-md-12 m-top-10">
        <textarea class="chatmsg form-control"  ></textarea>
      </div>
      <div class="col-md-12 text-center m-top-20">
        <input type="submit" class="btn btn-success" value="Send" onclick="sendChatMsg();" />
      </div>
    </div>
  </div> 
        
        
        </div>
    </div>
          
          
    </div>
          
          </div> 
    </div> 
    
{if $seller == 1}
<div class="row products_row">
  <div class="col-md-12 padlr">
    <div class="allbodr">
      <h3 class="text-center prodct-blk">Conference Log</h3>
      <div id="log" class="col-md-12 fht padboth"  style="display:inline-table;">
        <p><span id="log-content" class="text-danger"></span></p>
        
      </div>
    </div>
  </div>
  {/if}
  
</div>
{/if}
<div class="hide">
  <div class="alog">
    <div class="usr ###name">
      <p class="col-md-12 ftn600 padboth5"> <span class="col-md-6   pdlft">###name</span> <span class="col-md-6 pdlft clrgrn connect" onclick="connect('###name',this);">Connect</span> </p>
    </div>
  </div>
  <div class="avlog">
    <div class="usr ###name">
      <p class="col-md-12 ftn600 padboth5"> <span class="col-md-6">###name</span> <span class="col-md-4 clrgrn">Active</span> </p>
    </div>
  </div>
</div>
{include file="common/footer-1.tpl" nocache}
<div class="modal fade" id="invitorlist" tabindex="-1" role="dialog" aria-labelledby="invitorlist" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header" style="text-align: center;">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span id="closeafnt" class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel"><b> Inviter List </b></h4>
      </div>
      <div class="modal-body">
        <div class="row">
        <div class="col-md-12">
        <form id="invite_users" method="post" data-parsley-validate action="javascript:sendVideoInvite('{$id}');">
          <div class="row ">
            <div class="col-md-6  m-top-20"><strong>Email</strong></div>
            <div class="col-md-6  m-top-20"><strong>Name</strong></div>
          </div>
          <div class="row add_invite">
              <div class="col-md-6  m-top-20">
                <input type="email" class="form-control" name="email" data-parsley-required />
              </div>
              <div class="col-md-4  m-top-20">
                <input type="text"  class="form-control" name="name" data-parsley-required />
              </div>
              <div class="col-md-2 m-top-20"></div>
            
              <div class="col-md-6  m-top-20">
                <input type="email" class="form-control" name="email" data-parsley-required />
              </div>
              <div class="col-md-4  m-top-20">
                <input type="text"  class="form-control" name="name" data-parsley-required />
              </div>
              <div class="col-md-2 m-top-20"></div>
            
          </div>
          </div>
          </div>
          <div class="row">
            <div class="col-md-4  m-top-20">
              <input type="submit" class="btn btn-danger"  value="Send Invite"  />
            </div>
            <div class="col-md-4  m-top-20"> </div>
            <div class="col-md-4  m-top-20">
              <button class="btn btn-danger"   value="" onclick="$('.add_invite').append($('.email_box').html());" type="button">Add Another Invite</button>
            </div>
          </div>
        </form>
        <div class="table-responsive m-top-20"> 
          <table class="table table-bordered table-hover">
            <thead>
              <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Accept</th>
              </tr>
            </thead>
            <tbody>
            
            {foreach $inviteList as $key => $val}
            <tr>
              <td>{$val.name}</td>
              <td>{$val.email}</td>
              <td>{if $val.accept == 0} No Replied {elseif $val.accept == 1} Accept {elseif $val.accept == 2} Decline {/if}</td>
            </tr>
            {/foreach}
              </tbody>
            
          </table>
        </div>
      </div>
    </div>
  </div>
</div>

{include file="videoitem-js-new.tpl" nocache}
<table class="invitehide hide">
  <tbody>
    <tr>
      <td>##name</td>
      <td>##email</td>
      <td>##accept</td>
    </tr>
  </tbody>
</table>
<div class="row email_box hide">
      <div class="col-md-6  m-top-20">
        <input type="email" class="form-control" name="email" data-parsley-required />
      </div>
      <div class="col-md-4  m-top-20">
        <input type="text"  class="form-control" name="name" data-parsley-required />
      </div>
      <div class="col-md-2   m-top-20" style="cursor:pointer;" onclick="$(this).parent().remove();">Remove</div>
    
  </div>