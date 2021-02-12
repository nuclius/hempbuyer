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

{include file="common/header-1.tpl" nocache}
<div class="main_container">
  <div class="row dashboard">
    <div class="col-md-3"> {include file="left-nav-dashboard.tpl" nocache} </div>
    <div class="col-md-9">
      <h4 class="ds_brd">{$phrase.refferals}</h4>
      <div class="row mblue_box">
        <div class="col-md-6">{$phrase.referral_link} </div>
        <div class="col-md-6">{$phrase.referral_bonus_per_user_signup}</div>
      </div>
      <div class="row mblue_box1">
        <div class="col-md-6">{$config['url']}/register/{$referrallink} </div>
        <div class="col-md-6"> ${$config['referral_bonus']}</div>
        
       <div class="row col-md-6" style="text-align:center">  <!--<div> <h2> Share Your Referral Link </h2> </div>-->
        <span class='st_sharethis_large' st_image ="http://www.auctionsoftware.com/wp-content/uploads/2014/09/banner_middle.png"  st_url = "{$config['url']}/register/{$referrallink}" st_title="Auction Software" st_summary="Start your own auction website with the Industry  most Powerful, Secure & Highly featured Auction Script script 'Auction Script'. We provide a complete solution for starting your own auction script websites." displayText='ShareThis'></span> <span class='st_facebook_large' st_image ="http://www.auctionsoftware.com/wp-content/uploads/2014/09/banner_middle.png"  st_url = "{$config['url']}/register/{$referrallink}" st_title="Auction Software" st_summary="Start your own auction website with the Industry  most Powerful, Secure & Highly featured Auction Script script 'Auction Script'. We provide a complete solution for starting your own auction script websites." displayText='facebook'></span> <span class='st_twitter_large' st_image ="http://www.auctionsoftware.com/wp-content/uploads/2014/09/banner_middle.png"  st_url = "{$config['url']}/register/{$referrallink}" st_title="Auction Software" st_summary="Start your own auction website with the Industry  most Powerful, Secure & Highly featured Auction Script script 'Auction Script'. We provide a complete solution for starting your own auction script websites." displayText='Tweet'></span> <span class='st_linkedin_large' st_image ="http://www.auctionsoftware.com/wp-content/uploads/2014/09/banner_middle.png"  st_url = "{$config['url']}/register/{$referrallink}" st_title="Auction Software" st_summary="Start your own auction website with the Industry  most Powerful, Secure & Highly featured Auction Script script 'Auction Script'. We provide a complete solution for starting your own auction script websites." displayText='LinkedIn'></span> <span class='st_pinterest_large' st_image ="http://www.auctionsoftware.com/wp-content/uploads/2014/09/banner_middle.png"  st_url = "{$config['url']}/register/{$referrallink}" st_title="Auction Software" st_summary="Start your own auction website with the Industry  most Powerful, Secure & Highly featured Auction Script script 'Auction Script'. We provide a complete solution for starting your own auction script websites." displayText='Pinterest'></span> <span class='st_email_large' st_image ="http://www.auctionsoftware.com/wp-content/uploads/2014/09/banner_middle.png"  st_url = "{$config['url']}/register/{$referrallink}" st_title="Auction Software" st_summary="Start your own auction website with the Industry  most Powerful, Secure & Highly featured Auction Script script 'Auction Script'. We provide a complete solution for starting your own auction script websites." displayText='Email'></span> </div> </div>
      <div class="row mblue_box md_hide">
        <div class="col-md-2 ">{$phrase.image} </div>
        <div class="col-md-3">{$phrase.name} </div>
        <div class="col-md-3"> {$phrase.email} </div>
        <div class="col-md-2">{$phrase.joined}</div>
         <div class="col-md-2">{$phrase.status}</div>
      </div>
      {if($referral|count>0)}
      {foreach $referral as $refer}
      <div class="row mblue_box1">
        <div data-label="Image" class="col-md-2 account_p_lbl"><a href=""><img width="50" height="50" src="{if $refer.avatar == ''} {$config['imgpath']}no_img.png {else if $refer.avatar != ''}{$config['url']}/uploads/profile/{$refer.avatar}{/if}" title="" alt="" align="center"></a></div>
        <div data-label="Name" class="col-md-3 account_p_lbl"><a href="">{$refer.first_name} {$refer.last_name} </a></div>
        <div data-label="Email" class="col-md-3 account_p_lbl"> {$refer.email} </div>
        <div data-label="Joined" class="col-md-2 account_p_lbl"> {$refer.added} </div>
        <div data-label="Status" class="col-md-2 account_p_lbl"> {if $refer.status == 1} 
             {$phrase.approved}
             {elseif $refer.status == 0}
              {$phrase.pending} 
             {/if} </div>
      </div>
      {/foreach}
      {else}
     <div class="col-md-12 text-center m-top-20 font-12">  {$phrase.no_referrals_found} </div> 
      {/if} </div>
  </div>
</div>
</div>
{include file="common/footer-1.tpl" nocache} 
<script type="text/javascript">var switchTo5x=true;</script>
<script type="text/javascript" src="http://w.sharethis.com/button/buttons.js"></script>
<script type="text/javascript">stLight.options({publisher: "5a91affa-b85c-4f7f-b59a-f54ade10d67a",shorten:false, doNotHash: true, doNotCopy: false, hashAddressBar: false});</script>
{include file="common/footer.tpl" nocache}