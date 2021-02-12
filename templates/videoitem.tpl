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
  <div class="col-md-3">
    <div id="local-media"></div>
  </div>
  <div class="col-md-7">
    <div class="row">
      <div class="col-md-6">
        <div class="project_title">{$projects.title}</div>
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
        <div class="search_category"> {if $projects.market_status == 'closed'}
          <h3 class="schedule text-center font-12 font-semi-bold text-success m-btm-20">Meeting Closed</h3>
          <div class="row"><img src="{$config.url}/images/unsold.png" /></div>
          {elseif $projects.market_status == 'sold'}
          <h3 class="schedule text-center font-12 font-semi-bold text-success m-btm-20">Meeting Closed</h3>
          <div class="row"><img src="{$config.url}/images/soldout.png" /></div>
          {else}
          <h3 class="schedule text-center font-12 font-semi-bold text-success m-btm-20">Meeting will begins in</h3>
          <div id="DateCountdown"  ></div>
          <div id="BidCountdown"  ></div>
          {/if} </div>
      </div>
    </div>
  </div>
  <div class="col-md-2">{if $images}
    {foreach $images as $key => $val}
    {if $key == 0} 
    <!-- <a href="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" data-lightbox="{$projects.title}" data-title="">  --><img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" class="img-responsive" alt="1" id="zoom_{$key}"> 
    <!-- </a> --> 
    {/if}
    {/foreach}
    
    {else if !images} <a href="{$config['imgpath']}no_img.png" data-lightbox="{$projects.title}" data-title=""> <img src="{$config['imgpath']}no_img.png" class="img-responsive" alt="1" id="zoom_{$key}"></a> {/if}
    <div class="col-md-12 m-top-10 text-center"><a href="javascript:void(0);" onclick="$('#productInfo').modal('show');">Product Info</a></div>
  </div>
</div>
<div class="row products_row">
  <div class="col-md-8">
    <div class="search_category">
      <h3 class="text-center font-12 font-semi-bold text-success m-btm-20">Video Conference Room</h3>
      <div id="remote-media" style="display:inline-block;"></div>
    </div>
  </div>
  <div class="col-md-4">
    <div class="search_category">
      <h3 class="text-center font-12 font-semi-bold text-success m-btm-20">Bid History</h3>
      <div class="bids" style="    display: inline-block;">{foreach $bids as $key => $val}
        <div class="col-md-12">
          <div class="col-md-6 text-danger">{$val.nick_name}</div>
          <div class="col-md-6 text-danger">${$val.proposed_amount}</div>
        </div>
        {/foreach}</div>
    </div>
  </div>
</div>
{if $seller ==  1 and $projects.market_status == 'open'}
<div class="search_category">
  <h3 class="text-center font-12 font-semi-bold text-success m-btm-20">Seller Area</h3>
  <div class="row products_row">
    <div class="col-md-12">
      <div class="search_category">
        <h3 class="text-center font-12 font-semi-bold text-success m-btm-20">Invite Users</h3>
        <form id="invite_users" method="post" data-parsley-validate action="javascript:sendVideoInvite('{$id}');">
          <div class="row ">
            <div class="col-md-6  m-top-20"><strong>Email</strong></div>
            <div class="col-md-6  m-top-20"><strong>Name</strong></div>
          </div>
          <div class="row add_invite">
            <div class="row">
              <div class="col-md-6  m-top-20">
                <input type="email" class="form-control" name="email" data-parsley-required />
              </div>
              <div class="col-md-4  m-top-20">
                <input type="text"  class="form-control" name="name" data-parsley-required />
              </div>
              <div class="col-md-2 m-top-20"></div>
            </div>
            <div class="row">
              <div class="col-md-6  m-top-20">
                <input type="email" class="form-control" name="email" data-parsley-required />
              </div>
              <div class="col-md-4  m-top-20">
                <input type="text"  class="form-control" name="name" data-parsley-required />
              </div>
              <div class="col-md-2 m-top-20"></div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-4  m-top-20">
              <input type="submit" class="btn btn-danger"  value="Send Invite"  />
            </div>
            <div class="col-md-4  m-top-20">
              <button type="button" class="btn btn-danger"  value="Inviter List" onclick="inviterList();$('#invitorlist').modal('show');">Inviter List</button>
            </div>
            <div class="col-md-4  m-top-20">
              <button class="btn btn-danger"   value="" onclick="$('.add_invite').append($('.email_box').html());" type="button">Add Another Invite</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <div class="row email_box hide">
    <div class="row ">
      <div class="col-md-6  m-top-20">
        <input type="email" class="form-control" name="email" data-parsley-required />
      </div>
      <div class="col-md-4  m-top-20">
        <input type="text"  class="form-control" name="name" data-parsley-required />
      </div>
      <div class="col-md-2   m-top-20" style="cursor:pointer;" onclick="$(this).parent().remove();">Remove</div>
    </div>
  </div>
  <div class="row products_row">
    <div class="col-md-6">
      <div class="search_category">
        <h3 class="text-center font-12 font-semi-bold text-success m-btm-20">Available Users</h3>
        <div class="logger"></div>
      </div>
    </div>
    <div class="col-md-6">
      <div class="search_category">
        <h3 class="text-center font-12 font-semi-bold text-success m-btm-20">Active Users</h3>
        <div class="connecter"></div>
      </div>
    </div>
  </div>
  <div class="row products_row">
    <div class="col-md-12">
      <div class="search_category">
        <h3 class="text-center font-12 font-semi-bold text-success m-btm-20">Conference Log</h3>
        <div id="log"  style="display:inline-table;">
          <p>&gt;&nbsp;<span id="log-content" class="text-danger">Preparing to listen</span>...</p>
        </div>
      </div>
    </div>
  </div>
</div>
{/if}
{if $projects.market_status == 'open'}
{if $seller ==  1 and $phone == ''}
<div class="col-md-12 number_class">
  <div  class="col-md-3">
    <button id="add-number" class="btn btn-success m-top-10">After All people Joined Allocate Number</button>
  </div>
</div>
{elseif $phone == ''}
<div class="col-md-12 number_class">
  <div  class="col-md-3">
    <button id="add-number" class="btn btn-success m-top-10" style="display:none;">Allocate Number</button>
  </div>
</div>
{/if}
{if $seller ==  1 and $phone != ''}
<div class="col-md-12 number_class">
  <div  class="col-md-3">
    <button  class="btn btn-success m-top-10">Call Now:{$phone}</button>
  </div>
</div>
{elseif $phone != ''}
<div class="col-md-12 number_class">
  <div  class="col-md-3">
    <button  class="btn btn-success m-top-10">Call Now:{$phone}</button>
  </div>
</div>
{/if}
{/if}
<div class="clear m-top-20 m-btm-20"></div>
<div class="modal fade" id="invitorlist" tabindex="-1" role="dialog" aria-labelledby="invitorlist" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header" style="text-align: center;">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span id="closeafnt" class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel"><b> Inviter List </b></h4>
      </div>
      <div class="modal-body">
        <div class="table-responsive">
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
          {$pagination_html} </div>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="productInfo" tabindex="-1" role="dialog" aria-labelledby="productInfo" aria-hidden="false">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header" style="text-align: center;">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span id="closeafnt" class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel"><b> Product Info </b></h4>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-md-4">
            <div class="col-md-12"> {$titl = 0}
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
                  {/foreach} </div><a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev"> <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> <span class="sr-only">Previous</span> </a> <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next"> <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span> <span class="sr-only">Next</span> </a>
              </div>
              {else if !images}
              <div><a href="{$config['imgpath']}no_img.png" data-lightbox="{$projects.title}" data-title=""> <img src="{$config['imgpath']}no_img.png" class="img-responsive" alt="1" id="zoom_{$key}"></a></div>
              {/if} </div>
             <div class="col-md-12 con_seller m-top-20">
            <div class="prv_gbox">
              <div class="seller_info">SELLER INFO</div>
              <div class="clearfix con_sp">
                <div class="">
                  <div> {if $projects.uimage == ''}<img src="{$config.url}/images/blankimg.png">{else}<img src="{$config.url}/uploads/profile/{$projects.uimage}" width="150">{/if}</div>
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
          </div>
        <div class="col-md-8">
          <div class="ctgrychm div">
            <div class="plbl">Payment Method :</div>
            <div class="ppimg"><img src="{$config.url}/images/productview.png" class="img-responsive"></div>
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
        <div class="col-md-12">
          <div class="ct_headt">Product Description</div>
          <p> {$projects.description} </p>
        </div>
      </div>
    </div>
  </div>
</div>
{include file="common/footer-1.tpl" nocache}
<div class="chatonline">
<div class="search_category">
  <h3 onclick="chatOpen(this)">Chat Online <span style="float:right;" ><i class="fa fa-sort-desc"></i></span></h3>
  <div class="chat-content">
    <div class="row">
      <div class="col-md-12 msg_group"></div>
      <div class="col-md-9 m-top-10">
        <textarea class="chatmsg form-control" rows="3"  ></textarea>
      </div>
      <div class="col-md-3 m-top-20">
        <input type="submit" class="btn btn-success" value="Send" onclick="sendChatMsg();" />
      </div>
    </div>
  </div>
</div>
{include file="videoitem-js.tpl" nocache}
<table class="invitehide">
  <tbody>
    <tr>
      <td>##name</td>
      <td>##email</td>
      <td>##accept</td>
    </tr>
  </tbody>
</table>
