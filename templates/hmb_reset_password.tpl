{include file="/common/header-1.tpl" nocache}

<div class="clearfix auth-container">
    <div class="auth-left login-padd"> 
        <div class="auth-content-wrapper max-595">
            {* <div class="auth-logo">
                <img src="/images/auth-logo.png" />
            </div> *}
            <!-- <div class="auth-shead">so glad to See You Again</div>
            <div class="auth-ctxt">Login to your account</div> -->
            <div class="form-head">Reset Password</div>
            <form class="reset_password_form" data-parsley-validate novalidate>
                <div class="form-group">
                    <label class="sf-label">New Password</label>
                    <div class="icon-input"> 
                         <div class="icon-box pwd-box">
                             <img src="/images/pwd.png" alt="" />
                         </div>
                         <input class="form-control" id="new-password" type="password" placeholder="Enter New Password" required />
                    </div> 
                </div>
                <div class="form-group">
                    <label class="sf-label">Confirm Password</label>
                    <div class="icon-input"> 
                         <div class="icon-box pwd-box">
                             <img src="/images/pwd.png" alt="" />
                         </div>
                         <input class="form-control" id="confirm-new-password" type="password" placeholder="Confirm New Password" required />
                    </div> 
                </div>
                <div class="pt-3">
                    <input type="hidden" id="user-id" value="{$id}">
                    <button type="button" class="btn btn-brown submit-reset-password">SUBMIT</button>
                    <span id="resetPasswordInfoError" style="text-align: center; color: red;"></span>
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
<div class="modal fade hb-modal" id="resetPasswordInfo-success" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                
                <img src="{$config.url}/images/logo.png" class="m-auto" />  
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body"> 
                <h4 class="text-center">RESET PASSWORD UPDATED SUCCESSFULLY</h4>
                <div class="lsc-msg">
                    <img src="/images/user-icon.png" alt="user">
                </div>
                <div class="ss-txt">
                    
                </div>
                <button class="btn btn-prev" type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="window.location.href='/signin'">
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
                    if ($("#resetPasswordInfo-success").css("display") == "block") {
                        $("#resetPasswordInfo-success").modal('hide')
                    }
 
                }
            });
        });
    
</script>

<script type="text/javascript">
    $(document).ready(function() {
        $('body').on('click', '.submit-reset-password', function (e) {
            if ($('.reset_password_form').parsley().validate()) {
                var userId = $('#user-id').val();
                var newPassword = $('#new-password').val();
                var confirmNewPassword = $('#confirm-new-password').val();
                if(newPassword !== confirmNewPassword) {
                    $('#resetPasswordInfoError').html('New Password & Confirm New Password not match');
                    return false;
                }
                if(userId && userId != 0 && userId != "undefined" && userId != null) {
                    $.ajax({
                        type: "POST",
                        url: "{$config.url}/resetPassword",
                        data: { userId : userId, newPassword : newPassword, confirmNewPassword : confirmNewPassword },
                        dataType: 'json',
                        success: function (data) {
                            if (data.status == 'success') {
                                $('#new-password').val('');
                                $('#confirm-new-password').val('');
                                $('#resetPasswordInfo-success').modal('show');
                            }
                            else
                                $('#resetPasswordInfoError').html(data.statusText);
                        }
                    });
                } else {
                    $('#resetPasswordInfoError').html('Cannot find user id');
                    return false;
                }
            }
        });
    });
</script>