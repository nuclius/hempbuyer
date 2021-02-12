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
<div class="modal fade" id="terms-and-condition" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header border-0 p0 ">
                <div class="panel panel-success border-0">
                    <div class="panel-heading green-bg">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h3>Terms and Conditions</h3>
                    </div>
                </div>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-10 col-md-offset-1">
                        <div class="row">
                            <div class="col-md-12 pslr0 text-left mr-cklab mrbt10 scall">
                                <div class="scrl" id="style-1">
                                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                                </div>
                            </div>
                        </div>
                        <div class="checkbox">
                            <label class="p0">
                                <input type="checkbox" value="">
                                <span class="cr"><i class="cr-icon fa fa-check"></i></span> I have accepted the <a target="_blank" href="{$config.url}/terms">terms and conditions</a>
                            </label>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default btn-d-b green-b m0">Proceed</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="success" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header border-0 p0 ">
                <div class="panel panel-success border-0">
                    <div class="panel-heading green-bg">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h3>Payment Successfully Done !!!</h3>
                    </div>
                </div>
            </div>
            <div class="modal-body">
                <p class="f16 p35 text-center lh-22 black">
                    <span class="green-text" style="font-size:1.5em">Congratulations!</span>
                    <br>
                    <br> You have successfully sent a check to Herbee! An account specialist will verify these funds and credit your account within 48 hours.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-d-b btn-d-g m5">Proceed to Herbee</button>
            </div>
        </div>
    </div>
</div>
<!-- Page content -->
<!-- <div class="container-fluid bgBannerFluid">
    <h1 style="top:50%;">Time to Fund Your Herbee Account</h1>
</div> -->
{include file="common/dashboard-navigation.tpl" nocache}
<div class="container-fluid grey-bg xs-pdlr">
    <div class="container dashboard-settings-con m50">
        <div class="row">
            {include file="common/payment-sidebar.tpl" nocache}
            <!-- / Sddebar -->
            <div class="col-md-9 content-area">
                <div class="row">
                    <div class="panel panel-success m5 m-t-0">
                        <div class="panel-heading green-bg">
                            <h3>Send a check to Herbee</h3>
                        </div>
                    </div>
                    <div class="col-md-12 white-bg-2 p35 shadow">
                        <div class="row">
                            <div class="col-xs-12 notifications  xs-pdlr">
                                <p class="description mb-25 lh-22">
                                    You can send a check for the amount of funds you would like to use on the exchange plus your monthly membership fee.
                                </p>
                                <ul class="p0 lh-22 mb-25">
                                    <li class=""><b>Please make all checks payable to the Herbal Electronic Exchange LLC</b> </li>
                                    <br>
                                    <li class=""><b>Checks can be mailed to the following address: </b></li>
                                    <li class="grey-text">Herbal Electronic Exchange, LLC</li>
                                    <li class="grey-text">3401 12th St NE #4563 </li>
                                    <li class="grey-text">Washington DC 20017</li>
                                </ul>
                                <hr>
                                <div class="row">
                                    <div class="col-md-12">
                                        <p>Please send an email to accounts@herbee.com to alert account specialists that your check is in the mail. Please allow 72 hours for receipt and confirmation of your funds. Herbee will extend your credit for the balance of your wired funds within 48 hours according the following <a href="#" data-target="#terms-and-condition" data-toggle="modal">Terms and Conditions</a>. </p>
                                        <form action="/payment/request/checkpayment" method="POST" id="fund_request_form" class="registration-form" enctype="multipart/form-data" data-parsley-validate onsubmit="return checkTerms();">
                                            <div class="row">
                                                <div class="col-md-12 margin-auto">
                                                    <div class="form-group">
                                                            <input type="hidden" value="{$userbalance.balance}" name="total">
                                                        <input class="w100 p15 pb15 grey-bg border-0" type="amount" id="amount" placeholder="Place Amount" name="amount" data-parsley-type="digits" min='1' data-parsley-trigger="keyup" data-parsley-required data-parsley-required-message="Enter the Amount to proceed">
                                                    </div>
                                                </div>
                                            </div>
                                                                                       <div class="agree_terms check_opt">
                                                <div class="checkbox">
                                                    <label>
                                                        <!-- <input data-parsley-trigger="change focusout" type="checkbox" value=""> -->
                                                        <input data-parsley-trigger="change focusout" type="checkbox" name="agree" value="1" id="agree" />&nbsp;
                                                        <span class="cr"><i class="cr-icon fa fa-check"></i></span> I have accepted the <a target="_blank" href="{$config.url}/terms">terms and conditions</a>
                                                    </label>
                                                </div>
                                            </div>
 <div class="modal-footer">
                            <button type="submit" class="btn btn-default btn-d-b green-b m0">Proceed</button>
                        </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- / Content Area -->
    </div>
    <!-- Parent Row -->
</div>
<!-- dashboard-settings-con -->
</div>
<!--/ Page content -->
{include file="common/footer-1.tpl" nocache}
<script type="text/javascript">
function checkTerms() {
    if ($('.check_opt input[type="checkbox"]').is(':checked')) {
        return true;
        //checkSignup();
    } else {
        alert('Please accept terms and conditions');
    }
    return false;
}
</script>
</body>

</html>