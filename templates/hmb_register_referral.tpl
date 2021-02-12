{include file="/common/header-1.tpl" nocache}
<style>
</style>
<div class="home-container">
    <form class="user_form hb-reg-form" data-parsley-validate novalidate style="display: block;" id="referral_form">
        <div class="clearfix auth-container">
            <div class="auth-left">
                <div class="auth-content-wrapper max-595">
                    {* <div class="auth-logo">
                        <img src="./images/auth-logo.png" />
                    </div>
                    <div class="text-center mb-4" style="font-size: 18px;">CLICK <a href="/signin">HERE</a> FOR BUYER & SELLER LOGIN</div> *}

                    <div class="text-center mb-4" style="font-size: 18px;">REFERRAL PROGRAM AFFILIATES LOGIN <a href="/signin_referral">HERE</a></div>

                    <div class="form-head" style="font-size: 18px;">Register for Referral Affiliate Program</div>

                    <div class="formClass pl-5 pr-5 pt-3">
                        <div class="form-group">
                            <label class="sf-label">Full Name</label>
                            <div class="icon-input">
                                <div class="icon-box">
                                    <img src="images/user.png" alt="" />
                                </div>
                                <input class="form-control" name="rf_name" id="rf_name" placeholder="Full Name" required data-parsley-trigger="change" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="sf-label">Company Name</label>
                            <div class="icon-input">
                                <div class="icon-box">
                                    <img src="{$config.url}/images/pwd.png" alt="" />
                                </div>
                                <input class="form-control" name="rf_company_name" id="rf_company_name" placeholder="Company Name" required data-parsley-trigger="change" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="sf-label">Email</label>
                            <div class="icon-input">
                                <div class="icon-box pwd-box">
                                    <img src="images/email.png" alt="" />
                                </div>
                                <input type="email" id="rf_email" name="rf_email"
                                    class="form-control" placeholder="Email" required data-parsley-trigger="change" />
                                <span id="rf_emsg" class="text-danger"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="sf-label">Password</label>
                            <div class="icon-input">
                                <div class="icon-box pwd-box">
                                    <img src="images/pwd.png" alt="" />
                                </div>
                                <input type="password" id="rf_password" name="rf_password" class="form-control"
                                    placeholder="Password" required data-parsley-trigger="change" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="sf-label">Confirm Password</label>
                            <div class="icon-input">
                                <div class="icon-box pwd-box">
                                    <img src="images/pwd.png" alt="" />
                                </div>
                                <input type="password" id="rf_password_confirm" data-parsley-equalto="#rf_password"
                                    name="rf_password_confirm" required class="form-control"
                                    placeholder="Confirm Password" data-parsley-trigger="change" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="sf-label">Phone Number</label>
                            <div class="icon-input">
                                <div class="icon-box">
                                    <img src="{$config.url}/images/pwd.png" alt="" />
                                </div>
                                <input class="form-control" name="rf_phone" id="rf_phone" placeholder="Phone Number" required data-parsley-trigger="change" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="sf-label">Street Address</label>
                            <div class="icon-input">
                                <div class="icon-box">
                                    <img src="{$config.url}/images/pwd.png" alt="" />
                                </div>
                                <input class="form-control" name="rf_address" id="rf_address" placeholder="Street Address" required data-parsley-trigger="change" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="sf-label">City</label>
                            <div class="icon-input">
                                <div class="icon-box">
                                    <img src="{$config.url}/images/pwd.png" alt="" />
                                </div>
                                <input class="form-control" name="rf_city" id="rf_city" placeholder="City" required data-parsley-trigger="change" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="sf-label">State</label>
                            <div class="icon-input">
                                <div class="icon-box">
                                    <img src="{$config.url}/images/pwd.png" alt="" />
                                </div>
                                <input class="form-control" name="rf_state" id="rf_state" placeholder="State" required data-parsley-trigger="change" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="sf-label">Zipcode</label>
                            <div class="icon-input">
                                <div class="icon-box">
                                    <img src="{$config.url}/images/pwd.png" alt="" />
                                </div>
                                <input class="form-control" name="rf_zipcode" id="rf_zipcode" placeholder="Zipcode" required data-parsley-trigger="change" />
                            </div>
                        </div>
                        <div class="pt-3">
                            <button type="submit" class="btn btn-brown" id="register_referral_button">Register</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </form>
</div>

<!-- js -->
<div class="modal fade hb-modal" id="reg-success" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button> -->
            </div>
            <div class="modal-body"> 
                <h4 class="text-center">YOU HAVE BEEN SUCCESSFULLY REGISTERED</h4>
                <div class="lsc-msg">
                    <img src="./images/user-icon.png" alt="user">
                </div>
                <div class="ss-txt">
                    Referral code sent to your email.
                </div>
                <button class="btn btn-prev" data-dismiss="modal" onclick="redirect_to_login()">
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
                    if ($("#reg-success").css("display") == "block") {
                        $("#reg-success").modal('hide')
                    }
                }
            });
        });
    
</script>
<script>
$(document).ready(function(){
    $(document).on('keypress', '#rf_email', function(){
        $("#rf_emsg").html("");
    });
    var currentTab = 0; // Current tab is set to be the first tab (0)
    $(document).on('submit', '#referral_form', function (e) {
        e.preventDefault();
        $("#register_referral_button").attr('disabled', 'disabled');
        $("#register_referral_button").append('<i class="fa fa-spinner fa-spin ml-3"></i>');
        
        var formArr = $("#referral_form").serializeArray();

        var productObj = {};
        var productData = formArr ? formArr : [];
        if (productData.length) {
            for (var index = 0; index < productData.length; index++) {
                const element = productData[index];
                productObj[productData[index].name] = productData[index].value;
            }
        }

        $("#rf_emsg").html("");
        $.ajax({
            method: "POST",
            url: '/register_referral',
            data: productObj,
            dataType: 'JSON',
            cache: false,
            success: function (data) {
                console.log('data', data);
                if (data.status == 200) {
                    // $('#successBtn').click();
                    $('#reg-success').modal()
                } else if (data.status == 222) {
                    $("#rf_emsg").html("Email already registered");
                    $("#rf_email").focus();
                }
                $("#register_referral_button").attr('disabled', false);
                $("#register_referral_button").find('i').remove();
            }
        });
    });
});
function redirect_to_login() {
    window.location.href = '/signin_referral';
}
</script>
