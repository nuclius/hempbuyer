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

{include file="/common/header-1.tpl" nocache}
<style type="text/css">
.dvPreview img{
  margin:10px;
}
.category ul{
  display:none;
}
.search_tbar {
	margin:0;
}
.table-responsive {
	overflow-x:visible;
	  padding-bottom: 20px;
  padding-top: 20px;
	
}
.stab {
	border:1px solid #ccc;
	line-height:26px;
}
.stab th {
	background: #e9e9e8;
}
.stab2 {
	color:#000;
	line-height:24px;
}
.stab3 {
	color:#999;
	font-size:12px;
	line-height:24px;
}
.stab3 a {
}
.stab2 th {
	background: #f3f3f3;
	padding-left:25px !important;
}
.stab2 td {
	border-top:none !important;
	padding-left:25px !important;
}
@media(max-width:992px) {
.stab {
    border: none;
    padding: 0px;
    padding: 0!important;
    margin: 0px;
    display: block;
}
}
</style>
<!-- Go to www.addthis.com/dashboard to customize your tools -->

<div class="row shipwrap referrals">
<div class="daashbrd_cngpswd"><a href="/dashboard/my">Dashboard</a> &gt;&gt; {$phrase.referrals}</div>
<div class="col-md-3 txtfun3 padlef0 mobile_view">
{include file="left-profile-nav.tpl" nocache}
</div>
<div class="col-md-9 ship_tinf mobile_view">
 <div class="panel panel-default">
<div class="col-md-12 search_tbar">
<div class="col-md-7 sbar_lbl ct_headt" style="color: #000;">
    {$phrase.referrals}
      </div>
      
      
  <!--div class="col-md-1 sbar_lbl">
  Filter By
  </div>
  <div class="col-md-4">
    <select class="form-control" id="orderby">
      <option value="1">1 Weak</option>
      <option value="2">1 Month</option>
      
    </select>
  </div-->
  </div>
  <div class="col-md-12 text-center refer2">{$phrase.refer_and_earn_bonus_points}</div>
    <div class="col-md-12 text-center refer3">
      <span class='st_facebook_large' st_url='{$config.url}/?ref={$loged.userid}&med=fb' displayText='Facebook'></span>
      <span class='st_twitter_large' st_url='{$config.url}/?ref={$loged.userid}&med=twi' displayText='Tweet' st_title="{$title}"></span>
      <span class='st_linkedin_large' st_url='{$config.url}/?ref={$loged.userid}&med=in' displayText='LinkedIn'></span>
      <span class='st_pinterest_large' st_url='{$config.url}/?ref={$loged.userid}&med=pin' displayText='Pinterest'></span>
      <span class='st_email_large' st_url='{$config.url}/?ref={$loged.userid}&med=mail' displayText='Email'></span>
      <span class='st_sharethis_large' st_url='{$config.url}/?ref={$loged.userid}&med=share' displayText='ShareThis'></span>
      
    </div>
       
  
  <!-- Go to www.addthis.com/dashboard to customize your tools -->

  
<div style="clear:both;"></div>
</div>

<h3>{$phrase.you_have} <span style="color:red">{{$bonus}}</span> {$phrase.bonus_points_remaining}

  
  <div>
  <table class="table stab stab2">
  <tr class="md_hide" style="font-weight: bold;">
  <th>{$phrase.image}</th>
  <th>{$phrase.name}</th>
  <th>{$phrase.email}</th>
  <th>{$phrase.date_joined}</th>
  <th>{$phrase.source}</th>
  </tr>
  
  {$reviewcount = 0}
  {foreach $refers as $key => $val}   
  {$reviewcount = 1}
  <tr class="account_p_lbl">
    <td data-label="Image" class="account_p_lbl"><a href=""><img width="50" height="50" src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['url']}/uploads/profile/{$val.avatar}{/if}" title="" alt="" align="center"></a></td>
    <td data-label="Name" class="account_p_lbl">{$val.first_name}</td>
    <td data-label="Email" class="account_p_lbl">{$val.email}</td>
    <td data-label="Joined" class="account_p_lbl">{$val.date_added}</td>
    <td data-label="Source" class="account_p_lbl">{$val.source}</td>
  </tr>
{/foreach}
</table>
{if $reviewcount ==0}
   <div  class="account_p_lbl text-center">
         {$phrase.no_referrals_found} !
	</div>
{/if} 

  {$pagination_html} 
  
  <div style="clear:both;"></div>
</div>
  
  
<div style="clear:both;"></div>



</div>
</div>
{$disable_zip_popup = 1}
{include file="/common/footer-1.tpl" nocache} 
  
  
  <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog refer10" role="document">
    <div class="modal-content refer7">
      <div class="modal-header refer5">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="refer6">{$phrase.close}</span></button>
        <h4 class="modal-title " id="myModalLabel">{$phrase.select_your_email_service}</h4>
      </div>
      <div class="modal-body">
       <div class="col-md-12 refer4">
       <a href="#"><img src="{$config.url}/images/gm.png" /></a>
       <a href="#"><img src="{$config.url}/images/ym.jpg" /></a>
       <a href="#"><img src="{$config.url}/images/ot.jpg" /></a>
       <a href="#"><img src="{$config.url}/images/em.jpg" /></a>
       </div>
     
     <div class="col-md-12 refer4"><img src="{$config.url}/images/home/logo.png" alt="Auctionsoftware"></div>
     <div class="col-md-6 refer8">{$phrase.powered_by} <a href="#"><img src="{$config.url}/images/sh.jpg" /> <span>Share This</span></a></div>
     <div class="col-md-6 refer9"><a href=""#>Sign in</a> <span> | </span><a href="#"> Do not track</a></div>

      </div>
    </div>
  </div>
</div>

