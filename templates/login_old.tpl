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
<div class="row">
<style>
footer {
  margin-top: 160px;
  position: inherit;
}
</style>
 
  <!-- LOGIN STARTS!-->
  
  <div class="login_middle  m-top-50">
   
    <div class="login_lft">
      <div class="text-danger">{$login_error}</div>
      <form action="{$config['url']}/login/save" method="post" id="ad" enctype="multipart/form-data" onsubmit="return encrLogin()" data-parsley-validate>
        <input type="hidden" name="loginpage" value="1" />
        <div class="login_form">
          <div class="log_fields">
            <p>{$phrase.email}<span class="red">*</span>:</p>
            <input type="text" id="username" name="username" value="{$cookieemail}" data-parsley-required-message="Email is required" placeholder="Enter Email Id"  class="form-control" required>
          </div>
          <span class="red fl"></span>
          <div class="log_fields">
            <p>{$phrase.password} <span class="red">*</span>:</p>
            <input type="password" id="password" name="password" value="{$cookiepassword}" data-parsley-required-message="Password is required" placeholder="Password" class="form-control" required>
            <input type="hidden" id="last_url" name="last_url" value="{$last_url}" class="form-control">
          </div>
        </div>
        <span class="red fl"></span>
        <div class="login_check">
          <input type="checkbox" name="remember" id="rememberme" value="1" checked="checked">
          <p class="remeber"><label for="rememberme">{$phrase.remember_me}</label></p>
          <label><a href="{$config['url']}/login/forgot_password" title="Forgot password">{$phrase.forgot_password}</a></label>
        </div>
            
            <input type="submit" name="login" value="Sign In" class="btn btn-danger"  title="SIGNIN"> 

            <script type="in/Login" ></script>
         
        <div style="padding-top: 10px; float:left"> <span class="Loading_Img" style="display:none">
          <p style="width:195px; padding-left: 0px; color:black;font: bold 13px/16px arial;"> <img src="http://unieauction.com/platinum-demo/public/white/images/ajax-loader.gif" alt="loading"> <strong class="pls_wit" style="padding-top:0px; float:right; margin: -14px 90px;"> {$phrase.processing}... </strong> </p>
          </span> </div>
      </form>
    </div>
    <div class="login_rgt">


      <!--<div class="login-social">
        <p>Login With</p>
      </div>
      <div class="login_net">
        <ul>
          <li><a href="#" title="Login with facebook"><img src="{$config['dpath']}images/f_connect.png" alt="Login with facebook"></a></li>
          <li><a href="#" title="Twitt-connect"><img src="{$config['dpath']}images/twitt_connect.png" alt="Twitt-connect"></a> </li>
        </ul>
      </div>
      <span class="other">
      <label>(OR)</label>
      </span>-->
      <div class="login_account">
        <h2>{$phrase.still_not_a_member}</h2>
        <p>{$pharse.bid_on_or_buy_items_buy_and_sell}</p>
        <p>{$pharse.connect_with_our_growing_community_and_more}</p>
       <a data-target="#registration" data-toggle="modal" href="" class="btn btn-danger">{$pharse.register}</a>
      </div>
    </div>
  </div>
  <!-- LOGIN ENDS!--> 
  
</div>
</div>



{include file="common/footer-1.tpl" nocache}