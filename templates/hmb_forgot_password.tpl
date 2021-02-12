{include file="/common/header-1.tpl" nocache}

<div class="clearfix auth-container">
    <div class="auth-left login-padd"> 
        <div class="auth-content-wrapper max-595">
            {* <div class="auth-logo">
                <img src="/images/auth-logo.png" />
            </div> *}
            <!-- <div class="auth-shead">so glad to See You Again</div>
            <div class="auth-ctxt">Login to your account</div> -->
            <div class="form-head">Forgot Password</div>
            <form class="forgot_password_form" data-parsley-validate novalidate>
                <div class="form-group">
                    <label class="sf-label">Email / Username</label>
                    <div class="icon-input"> 
                        <div class="icon-box">
                            <img src="images/user.png" alt="" />
                        </div>
                        <input class="form-control" type="text" name="forgot_password_username" id="forgot_password_username" placeholder="Email / Username" required />
                    </div> 
                </div>                
                <div class="pt-3">
                    <button type="button" class="btn btn-brown submit-forgot-password">SUBMIT</button>
                    <span id="submitError" style="text-align: center;"></span>
                </div>
            </form>
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
                <button type="button" class="close forgot-password-redirect" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">  
                <h4 class="text-center">RESET PASSWORD LINK SENT TO YOUR EMAIL</h4> 
                <div class="lsc-msg">
                    <img src="./images/user-icon.png" alt="user">
                </div>
                <div class="ss-txt">
                    
                </div>
                <button class="btn btn-prev forgot-password-redirect">
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
        $('body').on('click', '.submit-forgot-password', function (e) {
            if ($('.forgot_password_form').parsley().validate()) {
                var dataobj = {
                    login_username : $('#forgot_password_username').val()
                };
                $.ajax({
                    type: "POST",
                    url: "{$config.url}/checkUserEmail",
                    data: dataobj,
                    dataType: 'json',
                    success: function (data) {
                        if(data.status == 'success') {
                            $('#forgot_password_username').val('');
                            $('#submitError').html(data.statusText).css('color', 'green');
                        } else {
                            $('#submitError').html(data.statusText).css('color', 'red');
                        }
                    }
                });
            }
        });

        $('body').on('click', '.forgot-password-redirect', function() {
            window.location.href = '/signin';
        });
    });
</script>