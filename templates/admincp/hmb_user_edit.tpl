{include file="/admincp/header.tpl" nocache}
<style>
/* .tab-content {
    background: #fff;
    display: inline-block;
    margin: 20px 0px;
    padding: 20px 10px;
    width: 100%;
}
.nav-item.active a{
    background: #35681e !important;
} */
.tab-content {
    background: #fff;
    display: inline-block;
    padding: 40px 10px;
    width: 100%;
}

.nav-tabs .nav-item {
    margin-bottom: -1px;
}
.nav-tabs {
    border-bottom: 1px solid #ddd;
    margin: 0;
}
.nav>li>a {
    position: relative !important;
    display: block !important;
    padding: 10px 15px !important;
}
.nav-tabs .nav-link {
    padding: .5rem 0;
    margin: 0;
    font-weight: 600;
    color: #868686;
    cursor: pointer;
    border: 1px solid transparent;
}
.nav-tabs .nav-link.active, .nav-tabs .nav-link:hover {
    color: #5a9234;
    background-color: transparent;
    border-bottom: unset;
    cursor: pointer;
}
.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover {
    color: #5a9234;
    cursor: default;
    background-color: #fff;
    border: 1px solid #ddd;
    border-bottom-color: transparent;
}
.nav-tabs .nav-link:hover {
    background-color: #efefef;
}
input[type=radio] + label {
    display: inline-block;
    cursor: pointer;
    line-height: 20px;
    padding-left: 30px !important;
    margin-right: 15px;
    position: relative;
    font-size: 15px;
}
.radio_list .radio {
    width: 50%;
    float: left;
    margin: 7px 0px;
}
.radio_list .parsley-errors-list {
    display: none;
}
.icon-input .icon-box {
    width: 48px;
    height: 38px;
    text-align: center;
    position: absolute;
    left: 1px;
    top: 0;
    padding: 0px 0;
    display: flex;
    justify-content: center;
    align-items: center;
}
.icon-input .form-control {
    padding-left: 46px !important;
}
.form-control:disabled, .form-control[readonly] {
    background-color: #e9ecef !important;
    opacity: 1;
}
</style>

<div class="container-fluid">

    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li class="active"> Users <i class="fa fa-angle-double-right"></i> {if $users.id == 0 or $users.id == ''} Add {else} Edit {/if} Users <i class="fa fa-angle-double-right"></i> {$users.username} </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
        {if $error == 'saved'}
            <div class="alert alert-success"><strong>Saved!</strong>
            {if $stat_msg !=''}
                {$stat_msg}
            {else}
                {$users.name} profile was successfully changed.
            {/if}
            </div>
        {elseif $error != ''}
            <div class="alert alert-danger"><strong>{$error}</strong></div>
        {/if}
            

                <input type="hidden" value="{$users.id}" name="id"/>
                <ul class="nav nav-tabs mb-3" id="pills-tab" role="tablist" style="background: #fff; font-size: 16px;">
                    <li class="nav-item active">
                      <a class="nav-link" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">Basic Detail</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">
                        {if $users.role == 1}
                            Individual
                        {elseif $users.role == 2}
                            Individual With Authorized Representative
                        {else/}
                            Registered Company With Authorized Representative
                        {/if}
                      </a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact" aria-selected="false">License</a>
                    </li>
                  </ul>
                  <div class="tab-content" id="pills-tabContent">
                    <div class="tab-pane fade active in" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                        <form enctype="multipart/form-data" class="admin_form" data-parsley-validate id="passwordForm" method="post" enctype="multipart/form-data" action="{$config.url}/{$loged.adminUrl}/users/save">
                            <div class="col-sm-1"></div>
                            <div class="col-sm-9">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Username :</label>
                                            <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Username" value="{$users.username}"
                                                    id="username" name="username" data-parsley-group="block1"  data-parsley-pattern-message="Invalid username" data-parsley-required required  tabindex="1" disabled>
                                            <span id="username-check-err" class="err-message"></span>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Email :</label>
                                            <input class="form-control {if $users.id>0}auctiondisable{/if}" data-parsley-trigger="change focusout" data-parsley-type="email" name="email" type="email" value="{$users.email}" id="email" placeholder="Enter Email-ID" data-parsley-group="block1" data-parsley-required required disabled>
                                            <span id="email-check-err" class="err-message"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Password:
                                                <small>(leave empty to keep same)</small>
                                            </label>
                                            <input type="password" data-parsley-trigger="change focusout" class="form-control" name="password" id="password"
                                                data-parsley-group="block1" id="password" name="password" data-parsley-minlength="6"
                                                data-parsley-minlength-message="Please enter a minimum of 6 characters"
                                                data-parsley-length-message="Please enter a minimum of 6 characters"
                                                data-parsley-type-message="Password should be alphanumeric" data-parsley-required required data-parsley-trigger="blur">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Confirm Password:</label>
                                            <input type="password" data-parsley-trigger="change focusout" class="form-control" name="cpassword" data-parsley-group="block1" data-parsley-equalto="#password" data-parsley-minlength="6"
                                                data-parsley-minlength-message="Please enter a minimum of 6 characters"
                                                data-parsley-length-message="Please enter a minimum of 6 characters"
                                                data-parsley-type-message="Password should be alphanumeric" data-parsley-required required data-parsley-trigger="blur">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-4">
                                        <button id="adminsub_button" type="submit" class="btn btn-success">Change Password</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                        <form enctype="multipart/form-data" class="admin_form" data-parsley-validate id="userDetailForm" method="post" enctype="multipart/form-data" action="{$config.url}/{$loged.adminUrl}/users/save">
                            <input type="hidden" name="role" id="role" value="{$users.role}">
                            <input type="hidden" name="user_id" id="user_id" value="{$users.id}">

                            <div class="col-sm-1"></div>
                            <div class="col-sm-10">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Full Name:</label>
                                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Full Name" value="{$users.name}" name="name" id="name" data-parsley-group="block1" required>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Email:</label>
                                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Email" value="{$users.email2}" name="email2" id="email2" required>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Phone:</label>
                                        <div class="icon-input">
                                            <div class="icon-box pwd-box">
                                                <img src="{$config.url}/images/flag.png" alt="" />
                                            </div>
                                            <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Phone" value="{$users.phone}" name="phone" id="phone" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Street Address:</label>
                                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Street Address" value="{$users.address}" name="address" id="address" required>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>City:</label>
                                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter City" value="{$users.city}" name="city" id="city" required>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>State:</label>
                                        <select class="form-control" name="state" id="state_abbr">
                                            <option value="">Select State</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Zip:</label>
                                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Zip"
                                        value="{$users.zipcode}"
                                                name="zipcode" id="zipcode" required>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Country:</label>
                                        <select class="form-control" name="country" id="country_abbr" required>
                                            <option value="">Select Country</option>
                                        </select>
                                    </div>
                                </div>

                                {if $users.role == 1}
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>SSN:</label>
                                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter SSN" value="{$users.ssn}" name="ssn" id="ssn" required>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>DOB:</label>
                                        <div class="icon-input">
                                            <div class="icon-box pwd-box">
                                                <img src="{$config.url}/images/cal.png" alt="" />
                                            </div>
                                            <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter DOB" value="{$users.dob}" name="dob" id="dob" required>
                                            <script type="text/javascript">
                                                $('#dob').datetimepicker({ format: 'MM-DD-YYYY',icons:
                                                {
                                                    time: 'fa fa-clock-o',
                                                    date: 'fa fa-calendar',
                                                    up: 'fa fa-chevron-up',
                                                    down: 'fa fa-chevron-down',
                                                    previous: 'fa fa-chevron-left',
                                                    next: 'fa fa-chevron-right',
                                                    today: 'fa fa-check',
                                                    clear: 'fa fa-trash',
                                                    close: 'fa fa-times'
                                                }}).on("dp.change", function (e) {  });
                                        </script>
                                        </div>
                                    </div>
                                </div>
                                {/if}
                            
                                {if $users.role == 2 || $users.role == 3}
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Rep Name:</label>
                                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Rep Name" value="{$users.rep_name}" name="rep_name" id="rep_name" required>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Business Name-DBA:</label>
                                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Business Name" value="{$users.business_name}" name="business_name" id="business_name">
                                    </div>
                                </div>

                                {if $users.role == 2}
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>SSN:</label>
                                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter SSN" value="{$users.ssn}" name="ssn" id="ssn" required>
                                    </div>
                                </div>
                                {/if}
                                {if $users.role == 3}
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>EIN:</label>
                                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter EIN" value="{$users.ein}" name="ein" id="ein" required>
                                    </div>
                                </div>
                                {/if}

                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Rep SSN:</label>
                                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Rep SSN" value="{$users.rep_ssn}" name="rep_ssn" id="rep_ssn" required>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Rep Street Address:</label>
                                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Rep Street Address" value="{$users.rep_address}" name="rep_address" id="rep_address" required>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Rep City:</label>
                                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Rep City" value="{$users.rep_city}" name="rep_city" id="rep_city" required>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Rep State:</label>
                                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Rep State" value="{$users.rep_state}" name="rep_state" id="rep_state" required>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Rep Zip:</label>
                                        <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Rep Zip" value="{$users.rep_zipcode}" name="rep_zipcode" id="rep_zipcode" required>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Rep Phone:</label>
                                        <div class="icon-input">
                                            <div class="icon-box pwd-box">
                                                <img src="{$config.url}/images/flag.png" alt="" />
                                            </div>
                                            <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Rep Phone" value="{$users.rep_phone}" name="rep_phone" id="rep_phone" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Rep DOB:</label>
                                        <div class="icon-input">
                                            <div class="icon-box pwd-box">
                                                <img src="{$config.url}/images/cal.png" alt="" />
                                            </div>
                                            <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter Rep DOB" value="{$users.dob}" name="dob" id="dob" required>
                                            <script type="text/javascript">
                                                $('#dob').datetimepicker({ minDate:moment(), format: 'MM-DD-YYYY',icons:
                                                {
                                                    time: 'fa fa-clock-o',
                                                    date: 'fa fa-calendar',
                                                    up: 'fa fa-chevron-up',
                                                    down: 'fa fa-chevron-down',
                                                    previous: 'fa fa-chevron-left',
                                                    next: 'fa fa-chevron-right',
                                                    today: 'fa fa-check',
                                                    clear: 'fa fa-trash',
                                                    close: 'fa fa-times'
                                                }}).on("dp.change", function (e) { });
                                            </script>
                                        </div>
                                    </div>
                                </div>
                                {/if}
                            
                                <div class="col-sm-12">
                                    <input id="adminsub_button" type="submit" class="btn btn-success submit_form pull-right" value="Save">
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
                        <form enctype="multipart/form-data" class="admin_form" data-parsley-validate id="licenseDetailForm" method="post" enctype="multipart/form-data" action="{$config.url}/{$loged.adminUrl}/users/save">
                            <input type="hidden" name="role" id="role" value="{$users.role}">
                            <input type="hidden" name="user_id" id="user_id" value="{$users.id}">
                            <input type="hidden" name="license" id="license" value="{$users.license}">
                            <input type="hidden" name="verification_doc" id="verification_document" value="{$users.verification_doc}">
                            <input type="hidden" name="ref_user_id" id="ref_user_id" value="{$users.ref_user_id}">

                            <div class="row">
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5">
                                    {if $users.role == 2 || $users.role == 3}
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <div id="verification_document_text"><a target="_blank" href="{$config.url}/uploads/verification_document/{$users.verification_doc}">{$users.verification_doc}</a>&nbsp;</div>
                                                <label for="upload-lic10"
                                                    class="upl_lab w-100 btn btn-green d-flex justify-content-center align-items-center" style="width: 100%;">UPLOAD
                                                    VERIFICATION DOCUMENT</label>
                                                <input type="file" name="document" class="upload-lic"
                                                    id="upload-lic10" onchange="uploadFile(this, 'verification_document');" />
                                            </div>
                                        </div>
                                    </div>
                                    {/if}
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <!-- <label>Email:</label> -->
                                                <div id="license_text"><a target="_blank" href="{$config.url}/uploads/license/{$users.license}">{$users.license}</a>&nbsp;</div>
                                                <label for="upload-lic"
                                                    class="upl_lab w-100 btn btn-brown justify-content-center align-items-center" style="width: 100%;">UPLOAD
                                                    LICENSE</label>
                                                <input type="file" name="license_doc" id="upload-lic"
                                                    class="upload-lic" onchange="uploadFile(this, 'license');" />
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="col-sm-5">

                                    <div class="row ">
                                        <div class="col-sm-12">
                                            <div class="form-inline form-group m-0">
                                                <label class="pp-label">Where have you been referred
                                                    from?</label>
                                                <div class="w-100 d-flex mar-btm-25 radio_list">
                                                    <div class="radio">
                                                        <input id="social" type="radio"
                                                            name="cg_refered_by" value="0" {if $users.refered_by==0}checked{/if} style="display: none;">
                                                        <label for="social">Social Media</label>
                                                    </div>
                                                    <div class="radio">
                                                        <input id="web_search" type="radio"
                                                            name="cg_refered_by" value="1" {if $users.refered_by==1}checked{/if} style="display: none;">
                                                        <label for="web_search">Web Search:</label>
                                                    </div>
                                                    <div class="radio">
                                                        <input id="buyer_referral" type="radio"
                                                            name="cg_refered_by" value="2" {if $users.refered_by==2}checked{/if} style="display: none;">
                                                        <label for="buyer_referral">HempBuyer Referral Partner</label>
                                                    </div>
                                                    <div class="radio">
                                                        <input id="referral_affiliate" type="radio" name="cg_refered_by" value="4" {if $users.ref_code}checked{/if} style="display: none;">
                                                        <label for="referral_affiliate">HempBuyer Referral Affiliate</label>
                                                    </div>
                                                    <div class="radio">
                                                        <input id="other" type="radio"
                                                            name="cg_refered_by" value="3" {if $users.refered_by==3}checked{/if} style="display: none;">
                                                        <label for="other">Other</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="col-sm-12" id="social_media_dropdown" style="{if $users.refered_by!=0}display: none;{/if}">
                                            <div class="form-group">
                                                <div class="clearfix ">
                                                    <select class="custom-select" name="social_media" id="social_media">
                                                        <option value="linkedin" 
                                                        {if $users.ref_social_media=='linkedin'}selected{/if}>Linkedin</option>
                                                        <option value="facebook" 
                                                        {if $users.ref_social_media=='facebook'}selected{/if}>Facebook</option>
                                                        <option value="twitter" {if $users.ref_social_media=='twitter'}selected{/if}>Twitter</option>
                                                        <option value="instagram" {if $users.ref_social_media=='instagram'}selected{/if}>Instagram</option>
                                                        <option value="other" {if $users.ref_social_media=='other'}selected{/if}>Other</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-12" id="other_social_media" style="{if $users.ref_social_media!='other'}display: none;{/if}">
                                            <div class="form-group">
                                                <div class="clearfix">
                                                    <input class="form-control" placeholder="Other Social Media" name="social_media_other" id="social_media_other" required="required" data-parsley-trigger="change" value="{$users.ref_social_media_other}">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row" id="buyer_referral_div"  style="{if $users.refered_by!=2}display: none;{/if}">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <div class="clearfix">
                                                    <input class="form-control" placeholder="Referral Full Name" name="ref_name" id="ref_name" required="required" data-parsley-trigger="change" value="{$users.ref_name}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <div class="clearfix">
                                                        <!-- <input class="form-control" placeholder="Phone Number" name="ref_phone" id="ref_phone" required="required" data-parsley-trigger="change" style="width: calc(100% - 20px); float: left;"> -->
                                                        <input class="form-control" placeholder="Referral Email" name="ref_email" id="ref_email" required="required" data-parsley-trigger="change" value="{$users.ref_email}">
                                                    <span id="buyer_referral_status" style="float: right; padding: 8px 0px; margin: -38px -15px;"></span>
                                                    <span id="buyer_referral_error"></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <div class="clearfix">
                                                    <!-- <div class="icon-input">
                                                        <div class="icon-box pwd-box">
                                                            <img src="{$config.url}/images/cal.png" alt="" />
                                                        </div> -->
                                                        <input class="form-control" placeholder="Date of Registration" name="ref_date" id="ref_date" required="required" data-parsley-trigger="change" value="{$users.ref_date}" readonly>
                                                    <!-- </div> -->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row" id="referral_affiliate_div" style="{if !$users.ref_code}display: none;{/if}">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <div class="clearfix">
                                                    <input class="form-control" placeholder="Full Name" name="rf_name" id="rf_name" value="{$users.rf_name}" required="required" readonly data-parsley-trigger="change">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-12" style="margin-top: 10px;">
                                            <div class="form-group">
                                                <div class="clearfix">
                                                    <input class="form-control" placeholder="Referral Email" name="rf_email" id="rf_email" value="{$users.rf_email}" required="required" readonly data-parsley-trigger="change">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-12" style="margin-top: 10px;">
                                            <div class="form-group">
                                                <div class="clearfix">
                                                    <input class="form-control" placeholder="Referral Code" name="rf_code" id="rf_code" value="{$users.ref_code}" required="required" readonly data-parsley-trigger="change">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="col-sm-12" id="other_referral" style="{if $users.refered_by!=3}display: none;{/if}">
                                            <div class="form-group">
                                                <div class="clearfix">
                                                    <input class="form-control" placeholder="Other Referral" name="ref_other" id="ref_other" required="required" data-parsley-trigger="change" value="{$users.ref_other}">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>                            
                            <div class="row " style="margin-bottom: 20px;">
                                <div class="col-sm-1"></div>
                                <div class="col-sm-11">
                                    <div class="form-group text-left">
                                        <span class="pull-left">I request a license exemption.&nbsp;&nbsp;</span>
                                        <span class="cus-check pull-left">
                                            <input type="checkbox" name="license_requested" id="license_requested" value="1" {if $users.license_requested==1}checked{/if}>
                                            <span class="checkmark"></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label>License expiration date:</label>
                                                <div class="icon-input">
                                                    <div class="icon-box pwd-box">
                                                        <img src="{$config.url}/images/cal.png" alt="" />
                                                    </div>
                                                    <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter License expiration date" value="{$users.license_date}" name="license_date" id="license_date" data-parsley-group="block1" required>
                                                    <script type="text/javascript">
                                                        $('#license_date').datetimepicker({ format: 'MM-DD-YYYY',icons:
                                                        {
                                                            time: 'fa fa-clock-o',
                                                            date: 'fa fa-calendar',
                                                            up: 'fa fa-chevron-up',
                                                            down: 'fa fa-chevron-down',
                                                            previous: 'fa fa-chevron-left',
                                                            next: 'fa fa-chevron-right',
                                                            today: 'fa fa-check',
                                                            clear: 'fa fa-trash',
                                                            close: 'fa fa-times'
                                                        }}).on("dp.change", function (e) {  });
                                                </script>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group ">
                                                <label class="">License Issue Date</label>
                                                <div class="icon-input">
                                                    <div class="icon-box pwd-box">
                                                        <img src="{$config.url}/images/cal.png" alt="" />
                                                    </div>
                                                    <input class="form-control l_issue_date" placeholder="Enter License Issue Date" name="l_issue_date" id="l_issue_date" required style="background-color: white; cursor: pointer;" value="{$users.l_issue_date}" />
                                                    <script type="text/javascript">
                                                        $('#l_issue_date').datetimepicker({  format: 'MM-DD-YYYY',icons:
                                                        {
                                                            time: 'fa fa-clock-o',
                                                            date: 'fa fa-calendar',
                                                            up: 'fa fa-chevron-up',
                                                            down: 'fa fa-chevron-down',
                                                            previous: 'fa fa-chevron-left',
                                                            next: 'fa fa-chevron-right',
                                                            today: 'fa fa-check',
                                                            clear: 'fa fa-trash',
                                                            close: 'fa fa-times'
                                                        }}).on("dp.change", function (e) { });
                                                    </script>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group ">
                                                <label class="">Country</label>
                                                <div class="icon-input">
                                                    <div class="icon-box pwd-box">
                                                        <img src="{$config.url}/images/ssn.png" alt="" />
                                                    </div>
                                                    <input name="l_country" id="l_country"
                                                        class="form-control" placeholder="Country" required parsley-type="phone" data-parsley-trigger="change" value="{$users.l_country}" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    {if $users.role == 3}
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group text-left">
                                                <label class="">State/province of Business Incorporation</label>
                                                <div class="icon-input">
                                                    <div class="icon-box pwd-box">
                                                        <img src="{$config.url}/images/ssn.png" alt="" />
                                                    </div>
                                                    <input class="form-control"
                                                        placeholder="State/province of Business Incorporation"
                                                        name="l_state_business" id="l_state_business" required value="{$users.l_state_business}" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    {/if}
                                </div>
                                
                                <div class="col-sm-5">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label class="">State/province issuing license</label>
                                                <div class="icon-input">
                                                    <div class="icon-box pwd-box">
                                                        <img src="{$config.url}/images/ssn.png" alt="" />
                                                    </div>
                                                    <input class="form-control"
                                                        placeholder="State/province issuing license"
                                                        name="l_state" id="l_state" required value="{$users.l_state}" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group ">
                                                <label class="">License Type</label>
                                                <div class="clearfix">
                                                    {if $users.role == 2 || $users.role == 3}
                                                        <select class="custom-select"
                                                            name="l_type" id="l_type" required>
                                                            <option value="cultivator" {if $users.l_type=='cultivator'}selected{/if}>Cultivator</option>
                                                            <option value="processor" {if $users.l_type=='processor'}selected{/if}>Processor</option>
                                                            <option value="hemp_seed_breeder" {if $users.l_type=='hemp_seed_breeder'}selected{/if}>Hemp Seed Breeder</option>
                                                            <option value="hemp_handler" {if $users.l_type=='hemp_handler'}selected{/if}>Hemp Handler</option>
                                                            <option value="other" {if $users.l_type=='other'}selected{/if}>Other</option>
                                                        </select>
                                                    {else/}
                                                        <select class="custom-select"
                                                            name="l_type" id="l_type" required>
                                                            <option value="producer" {if $users.l_type=='producer'}selected{/if}>Producer</option>
                                                            <option value="processor" {if $users.l_type=='processor'}selected{/if}>Processor</option>
                                                            <option value="none" {if $users.l_type=='none'}selected{/if}>None</option>
                                                        </select>
                                                    {/if}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                <div class="row" id="other_license_type" style="{if $users.l_type!='other'}display: none;{/if}">
                                        <div class="col-sm-12">
                                            <div class="form-group text-left">
                                                <label class="">Other License Type</label>
                                                <div class="clearfix ">
                                                    <input class="form-control"
                                                        placeholder="Other License Type"
                                                        name="l_type_other" id="l_type_other" value="{$users.l_type_other}" required />
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label class="">License Number</label>
                                                <div class="icon-input">
                                                    <div class="icon-box pwd-box">
                                                        <img src="{$config.url}/images/ssn.png" alt="" />
                                                    </div>
                                                    <input class="form-control"
                                                        placeholder="License Number"
                                                        name="l_number" id="l_number" required value="{$users.l_number}" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    {if $users.role == 3}
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group text-left">
                                                <label class="">State Registry Number</label>
                                                <div class="icon-input">
                                                    <div class="icon-box pwd-box">
                                                        <img src="{$config.url}/images/ssn.png" alt="" />
                                                    </div>
                                                    <input class="form-control"
                                                        placeholder="State Registry Number"
                                                        name="l_state_number" id="l_state_number" required value="{$users.l_state_number}" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    {/if}

                                    <div class="row">
                                        <div class="col-sm-12">
                                        <input id="adminsub_button" type="submit" class="btn btn-success submit_form pull-right" value="Save">
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </form>

                    </div>
                </div>
            </div>
                  
                <!-- <div class="col-sm-4">
                <div class="form-group">
                    <label>Profile Pic :</label><br/>

                    <div class="pro_image img-wrapper">
                    <img id="pro_image" src="{if $users.avatar == ''} {$config.url}/images/no_img.png {else if $users.avatar != ''}{$config['imgpath']}profile/{$users.avatar}{/if}"
                            width="82" title="{$users.name}" height="83" alt="{$val.title}"></a> </div> <br>
                    <div class="fileUpload btn btn-primary redbg5 w100"><span>Browse</span>
                        <input id="uploadBtn" type="file" class="upload" name="profile_image">
                    </div>
                    <span id="pro_img-err" class="err-message"></span>
                </div>
                </div> -->
        </div>
    </div>

    <!-- /.row -->
</div>
{include file="/admincp/footer.tpl" nocache}


<script src="{$config['externaljs']}scripts.js" type="text/javascript"></script>
<script>
    $('#ssn').mask('000-00-0000');
    $('#rep_ssn').mask('000-00-0000');
    $('#ein').mask('00-0000000');
    $('#phone').mask('+1 (000) 000-0000');
    $('#ref_phone').mask('+1 (000) 000-0000');

    var user_id = '{$users.id}';
    var referal_verified = 0;
    $(document).ready(function() {
        $("#country_abbr").val("United States");
        $("#country_abbr").trigger("change");
        $("#state_abbr").val("{$users.state}");
        // $('#dob').datetimepicker({
        //     timepicker:false,
        //     format:'m-d-Y'
        // });
        // $('#license_date').datetimepicker({
        //     timepicker:false,
        //     format:'m-d-Y'
        // });
        // $('#l_issue_date').datetimepicker({
        //     timepicker:false,
        //     format:'m-d-Y'
        // });
        /* $('#ref_date').datetimepicker({
            timepicker:false,
            format:'m-d-Y'
        }); */

        $(document).on('change', '#licenseDetailForm [name="cg_refered_by"]', function(){
            var type = $(this).val();
            var form = '#'+$(this).closest("form").attr("id")+' ';
            /* $(form+"#ref_other").val("");
            $(form+"#social_media_other").val("");
            $(form+"#ref_name").val("");
            $(form+"#ref_email").val(""); */
            $(form+"#buyer_referral_status").html('');
            $(form+"#buyer_referral_error").html('');

            $(form+"#social_media_dropdown").slideUp();
            $(form+"#other_social_media").slideUp();
            $(form+"#other_referral").slideUp();
            $(form+"#buyer_referral_div").slideUp();
            $(form+"#referral_affiliate_div").slideUp();

            if(type == '0') {
                $(form+"#social_media_dropdown").slideDown();
                if($(form+"#social_media").val() == 'other') {
                    $(form+"#other_social_media").slideDown();
                }
            } else if(type == '2') {
                $(form+"#buyer_referral_div").slideDown();
                // $(form+"#ref_date").val("");
            } else if(type == '3') {
                $(form+"#other_referral").slideDown();
            } else if(type == '4') {
                $(form+"#referral_affiliate_div").slideDown();
            }
        });
        $(document).on('change', '#licenseDetailForm #social_media', function(){
            var type = $(this).val();
            var form = '#'+$(this).closest("form").attr("id")+' ';
            if(type == 'other') {
                $(form+"#other_social_media").slideDown();
                $(form+"#ref_other").val("");
            } else {
                $(form+"#other_social_media").slideUp();
                $(form+"#social_media_other").val("");
            }
        });
        $(document).on('change', '#l_type', function(){
            var value = $(this).val();
            if(value == 'other') {
                $("#other_license_type").slideDown();
            } else {
                $("#other_license_type").slideUp();
            }
        });

        $(document).on('change keyup', '#licenseDetailForm #ref_email', function(){
            var value = $("#ref_email").val();
            var form = '#'+$(this).closest("form").attr("id")+' ';
            verify_referral(value, form);
        });

        $(document).on("submit", "#passwordForm", function(e) {
            e.preventDefault();
            console.log('$(this).parsley().validate()', $(this).parsley().validate());
            if ($(this).parsley().validate()) {
                var userObj = {
                    user_id: user_id,
                    password: $("#password").val()
                };
                $.ajax({
                    method: "POST",
                    url: '/admincp/changePassword',
                    data: userObj,
                    dataType: 'JSON',
                    cache: false,
                    success: function (data) {
                        console.log('data', data);
                        if (data.status == 200) {
                            document.getElementById('passwordForm').reset();
                            swal('Password has been changed.');
                        }
                    }
                });
            }
        });

        $(document).on("submit", "#userDetailForm", function(e) {
            e.preventDefault();
            console.log('$(this).parsley().validate()', $(this).parsley().validate());
            if ($(this).parsley().validate()) {
                var formArr = $(this).serializeArray();
                var userObj = {};
                if (formArr.length) {
                    for (var index = 0; index < formArr.length; index++) {
                        const element = formArr[index];
                        userObj[formArr[index].name] = formArr[index].value;
                    }
                }
                console.log('userObj', userObj);
                
                $.ajax({
                    method: "POST",
                    url: '/admincp/saveUserDetail',
                    data: userObj,
                    dataType: 'JSON',
                    cache: false,
                    success: function (data) {
                        console.log('data', data);
                        if (data.status == 200) {
                            // document.getElementById('userDetailForm').reset();
                            swal('License detail has been saved.');
                        }
                    }
                });
            }
        });

        $(document).on("submit", "#licenseDetailForm", function(e) {
            e.preventDefault();
            if(!referal_verified && $("#buyer_referral").prop("checked")) {
                $("#ref_email").focus();
                return true;
            }
            
            console.log('$(this).parsley().validate()', $(this).parsley().validate());
            if ($(this).parsley().validate()) {
                var formArr = $(this).serializeArray();
                var userObj = {};
                if (formArr.length) {
                    for (var index = 0; index < formArr.length; index++) {
                        const element = formArr[index];
                        userObj[formArr[index].name] = formArr[index].value;
                    }
                }
                console.log('userObj', userObj);
                
                $.ajax({
                    method: "POST",
                    url: '/admincp/saveUserLicenseDetail',
                    data: userObj,
                    dataType: 'JSON',
                    cache: false,
                    success: function (data) {
                        console.log('data', data);
                        if (data.status == 200) {
                            // document.getElementById('userDetailForm').reset();
                            swal('License detail has been saved.');
                        }
                    }
                });
            }
        });
    });
    
    function verify_referral(email, form) {
        console.log('email, form', email, form);
        if(email.trim() != '') {
            var userObj = {
                    ref_email: email
                };
            $.ajax({
                method: "POST",
                url: '/user/verify_referral',
                data: userObj,
                dataType: 'JSON',
                cache: false,
                success: function (data) {
                    console.log('data', data);
                    if (data.exist == 'Y') {
                        referal_verified = 1;
                        console.log('form', form);
                        $(form+"#ref_date").val(data.created_at);
                        $(form+"#ref_user_id").val(data.userid);
                        $(form+"#buyer_referral_status").html('<i class="fa fa-check text-success" title="referral is available"></i>');
                        $(form+"#buyer_referral_error").html('');
                        $(form+"#buyer_referral_error").removeClass('text-danger');
                        $(form+"#buyer_referral_error").addClass('text-success');
                    } else {
                        referal_verified = 0;
                        $(form+"#ref_date").val("");
                        $(form+"#ref_user_id").val("0");
                        $(form+"#buyer_referral_status").html('<i class="fa fa-times text-danger" title="There is no referral available"></i>');
                        $(form+"#buyer_referral_error").html('Buyer referral is Invalid.');
                        $(form+"#buyer_referral_error").removeClass('text-success');
                        $(form+"#buyer_referral_error").addClass('text-danger');
                        $(form+"#ref_email").focus();
                    }
                }
            });
        }
    }
    
    var uploadedFiles = {};
    function uploadFile(obj, file_type)
    {
        var files = $(obj)[0].files;
        console.log('files', files);
        var formData = new FormData();
        for (let index = 0; index < files.length; index++) {
            const element = files[index];
            formData.append(file_type, element);
        }
        formData.append('type', file_type);

        // $("#certificateDocumentLoader").show();
        console.log('formData', formData);
        var cntfle = files.length;
        $.ajax({
            url : '/uploadFile/'+cntfle,
            type : 'POST',
            xhr: function() {
                var myXhr = $.ajaxSettings.xhr();
                return myXhr;
            },
            data : formData,
            processData: false,
            contentType: false,
            success : function(response) {
                if(response.files.length) {
                    // createCertificateHtml(response.certificates);
                    $(obj).closest('div').find('#'+file_type+'_text').html(response.files[0].originalname);
                    uploadedFiles[file_type] = response.files[0].name;
                    $("#"+file_type).val(response.files[0].name);
                }
                console.log('response', response);
            },
            error: function(e)
            {
                console.log(e);
            },
        }).done(function() {
            $("#certificateDocumentLoader").hide();
        });
    }

$('input[type=radio][name=stax]').change(function() {
    // //console.log('running');
  if (this.value == 'y') {
    $('input[type=text][name=stax_per]').prop('disabled', false);
    $('input[type=text][name=stax_per]').prop('data-toggle','tooltip');
    $('input[type=text][name=stax_per]').attr({ "data-parsley-required-message" : "Please enter sales tax" , "data-parsley-required":true });
    $('input[type=text][name=stax_per]').prop('title','Enter the sales tax(%)...!');
    $('#stax_per-err').show();
    $('#staxSetting').show();
  }
  if (this.value == 'n') {
    $('input[type=text][name=stax_per]').val(0);
    $('input[type=text][name=stax_per]').prop('disabled', true);
    $('input[type=text][name=stax_per]').prop('data-toggle','tooltip');
    $('input[type=text][name=stax_per]').removeAttr("data-parsley-required data-parsley-min data-required");
    $('input[type=text][name=stax_per]').prop('title','Select yes to enable...!');
    $('#stax_per-err').hide();
    $('#staxSetting').hide();
  }
});

$('#certificates').filestyle({
    input: false,
    buttonName: 'btn btn-default btn-d-b btn-d-g m5',
    iconName: '',
    buttonText: 'UPLOAD'
});

$('#licenses').filestyle({
    input: false,
    buttonName: 'btn btn-default btn-d-b btn-d-g m5',
    iconName: '',
    buttonText: 'UPLOAD'
});

   function chooseCert() {
      $("#certificates").click();
   }
   function chooseLic() {
    //   $("#licenses").click();
   }
</script>

<script language="javascript" type="text/javascript">
/* document.getElementById("licenses").onchange = function () {

  if(projectLoad1(this)){
    var reader = new FileReader();

    reader.onload = function (e) {
        ////console.log(e);
        // get loaded data and render thumbnail.
        document.getElementById("license").src = e.target.result;
    };

    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
} else {
    $(this).val('');
    $(this).parents().find(".badge").remove();
    document.getElementById("license").src = "{$config.url}/images/no_img.png"
    // error message here
    // alert("not an image");
}
}; */

// document.getElementById("certificates").onchange = function () {
//   if(projectLoad1(this)){

//       var reader = new FileReader();

//       reader.onload = function (e) {
//         ////console.log(e);
//           // get loaded data and render thumbnail.
//           document.getElementById("certificate").src = e.target.result;
//       };

//       // read the image file as a data URL.
//       reader.readAsDataURL(this.files[0]);
//   } else {
//       $(this).val('');
//       $(this).parents().find(".badge").remove();
//       document.getElementById("certificates").src = "{$config.url}/images/no_img.png"
//       // error message here
//       // alert("not an image");
//   }

// };

    function checkStateCity(form, id) {
        ////console.log(id);
        ////console.log("http://maps.googleapis.com/maps/api/geocode/json?address=" + $('#' + form + ' #zipcode').val());
        var params = {};
        if (window.XDomainRequest) {
            if (window.XDomainRequest) {
                var xdr = new XDomainRequest();
                var query = "http://maps.googleapis.com/maps/api/geocode/json?address=" + $('#' + form + ' #zipcode').val();
                if (xdr) {
                    xdr.onload = function () {
                        ////console.log(JSON.parse(xdr.responseText));
                        sZipcode(JSON.parse(xdr.responseText), form, id);
                    }
                    xdr.onerror = function () { /* error handling here */
                    }
                    xdr.open('GET', query);
                    xdr.send();
                }
            }
        }
        else {
            $.ajax({
                type: "GET",
                url: "http://maps.googleapis.com/maps/api/geocode/json?address=" + $('#' + form + ' #zipcode').val(),
                data: params,
                success: function (data) {
                    sZipcode(data, form, id);
                }
            });
        }
    }

    function sZipcode(data, form, id) {
        //console.log(data);
        if (data['results'].length > 0) {
            var m = data['results'][0]['address_components'].length;

            $('#' + form + ' #city').val(data['results'][0]['address_components'][m - 3]['long_name']);
            $('#' + form + ' #state').val(data['results'][0]['address_components'][m - 2]['long_name']);
            $('#' + form + ' #country').val(data['results'][0]['address_components'][m - 1]['long_name']);
            $('#' + form + ' .addresscity').html($('#city').val() + ',' + $('#state').val() + ',' + $('#country').val());
            if (id > 0) {
                $('#' + form).submit();
            }
        }
        else {
            alert('Invalid Zipcode');
            //$('#'+form+' #zipcode').focus();
            $('#' + form + ' .addresscity').html('Invalid Zipcode');
            return false;
        }
    }

    var initValues = {};

    {if {$mcats} != ''}
        var initValues = '{$mcats}'.split(',');
    {/if}

    //alert(initValues);
    $(':checkbox[name^="categories"]').each(function () {
        $(this).prop("checked", ($.inArray($(this).val(), initValues) != -1));
    });

    $(function () {
        $('input[name="categories[]"]').each(function () {
            $(this).on('click', function () {
                var pid = $(this).attr('pid');
                var vid = $(this).attr('value');
                if (pid > 0) {
                    if (!$(this).is(':checked')) {
                        $('input[name="categories[]"][value="' + pid + '"]').attr('checked', false);
                    }
                }
                else {
                    if ($(this).is(':checked')) {
                        $('input[name="categories[]"][pid="' + vid + '"]').each(function () {
                            $(this).attr('checked', false);
                            $(this).click();
                        });
                    }
                    else {
                        $('input[name="categories[]"][pid="' + vid + '"]').each(function () {
                            $(this).attr('checked', false);
                        });
                    }
                }
            });
        });
        var ctry = '{$users.country}';
        //console.log(ctry);
        if (ctry != '') {

            $('#country').val(ctry);
            if ($('#country option[value="{$users.country}"]').length > 0) {
                loadLocation('country', $('#country option[value="{$users.country}"]').attr('attr'), '{$users.state}', '{$users.city}');
            }
        }
        var country = '{$users.country}';
        if (country != '') {
            $('#country').val(country);
            loadState();
        }

    });


    function checkEmailExist(email) {
        //console.log(email);
        if(email != '{$users.email}') {
            data = {
                email: email
            };
            $.ajax({
                datatype: 'json',
                type: "POST",
                url: "/register/check_email_exist",
                data: data,
                success: function (html) {
                    //console.log(html);
                    if (html.status) {
                        $('#divExisteEailReg').css('display', 'none');
                    } else {
                        $('#email').val('');
                        $('#divExisteEailReg').css('display', 'block');
                    }
                }
            });
        }else{
            return true;
        }
    }

    //Image uploading
    // document.getElementById("uploadBtn").onchange = function () {
    //     if(projectLoad1(this)){
            
    //         var reader = new FileReader();
    //         reader.onload = function (e) {
    //             // get loaded data and render thumbnail.
    //             document.getElementById("pro_image").src = e.target.result;
    //             //console.log(JSON.stringify(e));
    //         };
    //         // read the image file as a data URL.
    //         reader.readAsDataURL(this.files[0]);
    //     } else {
    //         $(this).val('');
    //         $(this).parents().find(".badge").remove();
    //         document.getElementById("pro_image").src = "{$config.url}/images/no_img.png"
    //         // error message here
    //         // alert("not an image");
    //     }

    // };


</script>
