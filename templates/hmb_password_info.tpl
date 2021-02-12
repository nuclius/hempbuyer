{include file="/common/header-1.tpl" nocache}

<!-- <div class="clearfix auth-container" style="padding-top: 100px !important;"> -->
<section class="db-wrapper db-iwrap">
    {include file="/common/header-2.tpl" nocache}
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <h3 class="acc-head">
                    PROFILE
                </h3>
            </div>
            <!-- <div class="col-sm-6">
                <div class="form-inline wt-wrap">
                    <div class="clearfix cselec-wrap sort-by">
                        <select class="custom-select">
                            <option>Sort By</option>
                        </select>
                    </div> 
                </div>
            </div> -->
        </div>
         <div class="db-content">
            <div class="db-menu">
                <ul class="">
                    <li><a href="/profileInfo" class="">Profile Info</a></li>
                    <li><a href="/passwordInfo" class="active">Change Password</a></li>
                    <li><a href="/paymentInfo" class="">Payment</a></li>
                    <li><a href="/transactionsInfo" class="">Transactions</a></li>
                    <li><a href="/bank_details" class="">Bank Details</a></li> 

                    <!-- <li><a href="/passwordInfo" class="">Change Password</a></li>
                    <li><a href="/paymentInfo" class="">Payment</a></li>
                    <li><a href="/transactionInfo" class="">Transactions</a></li> -->
                </ul>
            </div>
            <div class="db-right-con bg-gray">
                <form class="cpwd-form password_info mt-3" data-parsley-validate novalidate id="password_info">
                    <div class="form-group">
                        <label class="sf-label">Old Password</label>
                        <div class="icon-input"> 
                             <div class="icon-box pwd-box">
                                 <img src="images/pwd.png" alt="" />
                             </div>
                             <input class="form-control" id="old-password" type="password" placeholder="Enter Old Password" required />
                        </div> 
                    </div>
                    <div class="form-group">
                        <label class="sf-label">New Password</label>
                        <div class="icon-input"> 
                             <div class="icon-box pwd-box">
                                 <img src="images/pwd.png" alt="" />
                             </div>
                             <input class="form-control" id="new-password" type="password" placeholder="Enter New Password" required />
                        </div> 
                    </div>
                    <div class="form-group">
                        <label class="sf-label">Confirm Password</label>
                        <div class="icon-input"> 
                             <div class="icon-box pwd-box">
                                 <img src="images/pwd.png" alt="" />
                             </div>
                             <input class="form-control" id="confirm-new-password" type="password" placeholder="Confirm New Password" required />
                        </div> 
                    </div>
                    <div class="pt-3">
                        <input type="hidden" id="user-id" value="{$id}">
                        <button class="btn btn-brown btn-lg save_password_info" type="button">SAVE CHANGES</button>
                        <span id="passwordInfoError" style="text-align: center; color: red;"></span>
                    </div>
                </form>
            </div>
         </div>
    </div>
</section>

<script>
       $(document).ready(function (e) {
           console.log('called1')
            $(document).keypress(function (e) {
                if (e.which == 13) {
                    console.log('called')
                    if ($("#passwordInfo-success").css("display") == "block") {
                        $("#passwordInfo-success").modal('hide')
                    }
                }
            });
        });
    
</script>
<div class="modal fade hb-modal" id="passwordInfo-success" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">  
                <h4 class="text-center">YOU HAVE BEEN SUCCESSFULLY UPDATED YOUR PASSWORD</h4>
                <div class="lsc-msg">
                    <img src="./images/user-icon.png" alt="user">
                </div>
                <!-- <div class="ss-txt">
                    YOU HAVE BEEN SUCCESSFULLY UPDATED
                </div> -->
                <button class="btn btn-prev" type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    THANK YOU
                </button>
            </div> 
        </div>
    </div>
</div>

{include file="/common/footer-1.tpl" nocache}

<script language="javascript" type="text/javascript">
    $(document).ready(function() {
        $('body').on('click', '.save_password_info', function (e) {
            if ($('.password_info').parsley().validate()) {
                var userId = $('#user-id').val();
                console.log('userId', userId);
                var oldPassword = $('#old-password').val();
                var newPassword = $('#new-password').val();
                var confirmNewPassword = $('#confirm-new-password').val();
                if(oldPassword === newPassword) {
                    $('#passwordInfoError').html('Old Password & New Password are same');
                    return false;
                }
                if(newPassword !== confirmNewPassword) {
                    $('#passwordInfoError').html('New Password & Confirm New Password not match');
                    return false;
                }
                if(userId && userId != 0 && userId != "undefined" && userId != null) {
                    $.ajax({
                        type: "POST",
                        url: "{$config.url}/updatePasswordInfo",
                        data: { userId : userId, oldPassword : oldPassword, newPassword : newPassword, confirmNewPassword : confirmNewPassword },
                        dataType: 'json',
                        success: function (data) {
                            if (data.status == 'success') {
                                $('#old-password').val('');
                                $('#new-password').val('');
                                $('#confirm-new-password').val('');
                                $('#passwordInfo-success').modal('show');
                            }
                            else
                                $('#passwordInfoError').html(data.statusText);
                        }
                    });
                } else {
                    $('#passwordInfoError').html('Cannot find user id');
                    return false;
                }
            }
        });
    });
</script>