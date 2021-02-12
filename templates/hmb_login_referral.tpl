{include file="/common/header-1.tpl" nocache}

<div class="clearfix auth-container">
    <div class="auth-left login-padd"> 
        <div class="auth-content-wrapper max-595">
            {* <div class="auth-logo">
                <img src="{$config.url}/images/auth-logo.png" />
            </div> *}
            <div class="auth-shead">so glad to See You Again</div>
            <div class="auth-ctxt">Login to your account</div>
                <div class="text-center mb-4" style="font-size: 18px;">REFERRAL PROGRAM AFFILIATES REGISTER <a href="/register_referral">HERE</a></div>
            <div class="form-head">Referral login as</div>
            <form class="user_login_form" data-parsley-validate novalidate>
                <div class="form-group">
                    <label class="sf-label">Email or Username</label>
                    <div class="icon-input"> 
                        <div class="icon-box">
                            <img src="{$config.url}/images/user.png" alt="" />
                        </div>
                        <input class="form-control" type="text" name="login_username" id="login_username" placeholder="Email or Username" required value="{$cookieemail}" />
                        <!-- <span id="emsg" class="reg-error"></span> -->
                    </div> 
                </div>
                <div class="form-group">
                    <label class="sf-label">Password</label>
                    <div class="icon-input"> 
                        <div class="icon-box pwd-box">
                            <img src="{$config.url}/images/pwd.png" alt="" />
                        </div>
                        <input class="form-control" type="password" name="login_password" id="login_password" placeholder="Password" required value="{$cookiepassword}" />
                    </div> 
                </div>
                {* <div class="form-group clearfix">
                    <div class="cus-check float-left">
                        {if $cookieremember == 1}
                            <input type="checkbox" checked="checked" name="login_remember" id="login_remember">
                        {else/}
                            <input type="checkbox" name="login_remember" id="login_remember">
                        {/if}
                        <span class="checkmark"></span>Remember me
                    </div>
                    <div class="float-right">
                        <a class="ha-txt" href="/forgotPassword">Forgot Your Password?</a>
                    </div>
                </div> *}
                <div class="pt-3">
                    <!-- <button type="button" class="btn btn-brown" data-toggle="modal" data-target="#login-success">LOGIN</button> -->
                    <button type="submit" class="btn btn-brown submit-login">LOGIN</button>
                    <span id="loginError" style="text-align: center;"></span>
                </div>
            </form>
            <div class="ha-txt text-center">
                Don't You Have an Account ? <a href="{$config.url}/register_referral">Register</a> 
            </div>
        </div>
        <div class="footer max-640">
            <nav class="navbar navbar-expand"> 
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link dbclr" href="/terms_of_use" target="_blank">Terms of Use</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link dbclr" href="/privacy_policy" target="_blank">Privacy Policy</a>
                        </li>
                    </ul>
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item dbclr">
                            Copyright © {$current_year} Lucky Dog, LLC
                        </li>
                    </ul> 
            </nav>
        </div>
    </div> 
</div> 
<div class="modal fade hb-modal" id="login-success" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close login-redirect" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">
                <h4 class="text-center">YOU HAVE BEEN SUCCESSFULLY LOGGED IN</h4>
                <div class="lsc-msg">
                    <img src="{$config.url}/images/user-icon.png" alt="user">
                </div>
                <div class="ss-txt login-username">
                    WELCOME! JERRY LIDWIN
                </div>
                <button class="btn btn-prev login-redirect">
                    THANK YOU
                </button>
            </div> 
        </div>
    </div>
</div>

<script>
       $(document).ready(function (e) {
           console.log('called1')
            $(document).keypress(function (e) {
                if (e.which == 13) {
                    console.log('called')
                    if ($("#login-success").css("display") == "block") {
                        $("#login-success").modal('hide')
                    }
                }
            });
        });
    
</script>

<script type="text/javascript">
    $(document).ready(function() {
        $('body').on('submit', '.user_login_form', function (e) {
            e.preventDefault();
            if ($('.user_login_form').parsley().validate()) {
                var dataobj = {
                    login_username : $('#login_username').val(),
                    login_password : $('#login_password').val(),
                    login_remember : $('#login_remember').is(":checked") ? 1 : 0
                };
                $.ajax({
                    type: "POST",
                    url: "{$config.url}/checkReferralUser",
                    data: dataobj,
                    dataType: 'json',
                    success: function (data) {
                        if (data.status == 'success') {
                            $('#login-success .login-username').html('WELCOME ' + data.data.name);
                            $('#login-success').modal('show');
                        } else 
                            $('#loginError').html(data.statusText).css('color', 'red');
                            //$('#loginError').html('Invalid login credentials').css('color', 'red');
                    }
                });
            }
        });

        $('body').on('click', '.login-redirect', function() {
            window.location.href = '/banners';
        });
    });
</script>