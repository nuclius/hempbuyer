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

<!--Section1 start Here-->
<section class="reg-bg disflx">
  <div class="container mrato lgn-bx reg-bg-clr res-width width-40-768" data-aos="zoom-in">
      <h3>Login</h3>
        <div class="ront-lin">
            <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
            <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
            <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
            <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
            <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
        </div>
        <div class="reg-instl">
        <div class="text-danger">{$login_error}</div>

        <!-- <form action="{$config['url']}/login/save" method="post" id="ad" enctype="multipart/form-data" onsubmit="return encrLogin()" data-parsley-validate> -->
        <form action="{$config['url']}/login/save" method="post" id="ad" enctype="multipart/form-data" data-parsley-validate>
        <input type="hidden" name="loginpage" value="1" />
<!--           <form> -->
                <div class="row">
                  <div class="col-md-12">
                        <div class="input-group">
                          <!-- <input type="text" class="form-control" placeholder="User Name"> -->
                          <input type="email" id="username" name="username" value="{$cookieemail}" data-parsley-required-message="Email is required" data-trigger="change" autocomplete="off" placeholder="Email-ID"  class="form-control" data-parsley-errors-container="#email-err" required tabindex="1">
                          <span class="input-group-addon" id="basic-addon2"><i class="flaticon-user"></i></span>
                        </div>
                        <span id="email-err"></span>
                    </div>
                    <div class="col-md-12">
                        <div class=" input-group">
                          <!-- <input type="text" class="form-control" placeholder="Password" > -->
                          <input type="password" id="password" name="password" value="{$cookiepassword}" data-parsley-required-message="Password is required" placeholder="Password" class="form-control" data-parsley-errors-container="#password-err" required  tabindex="2">
                          <span class="input-group-addon" id="basic-addon2"><i class="flaticon-key"></i></span>
                        </div>
                        <span id="password-err"></span>
                    </div>
                </div>
                <div class="row">
                  <span class="col-md-6 col-sm-6 col-xs-6 mr-cklab mrtp0 text-left res-text-left w100-480">
                        <div class="checkbox mrtb0 res-m20-0">
                          <label class="pdlf0">
                            <input type="checkbox" name="remember" value="1"  {if $cookieremember == 1} checked {/if} tabindex="3">
                            <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                            Remember me
                          </label>
                        </div>
                    </span>
                    <span class="col-md-6 col-sm-6 col-xs-6 text-right res-text-left w100-480 align-adjust"><a href="{$config['url']}/login/forgot_password" class="fnt15" style="color:#3a3a3a "  tabindex="5">Forgot Password?</a></span>
                </div>
                <div class="text-right mrtp20">
                  <button type="submit" class="btn btn-grn wid100"  tabindex="4">Login</button>
                </div>
                <div class="mrtp10 text-right">
                <a href="{$config['url']}/register/1" class="fnt15" style="color:#3a3a3a "  tabindex="6">Create an account?</a>
                </div>

            </form>
        </div>
    </div>
</section>
<!--Section1 end Here-->

{include file="common/footer-1.tpl" nocache}
</body>
</html>
