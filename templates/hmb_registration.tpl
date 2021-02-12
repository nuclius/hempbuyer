{include file="/common/header-1.tpl" nocache}
<style>
#buyer_referral_status {
    float: right;
    padding: 15px 0px;
    position: absolute;
    top: 2px;
    right: 27px;
}
.pull-left {
    float: left;
}
</style>
<div id="step1_data" class="step_data active"> 
    <form class="pp-form user_form hb-reg-form" data-parsley-validate novalidate style="display: block;" id="step1_form">
        <div class="clearfix auth-container">
            <div class="auth-left">
                <div class="auth-content-wrapper max-595">
                    {* <div class="auth-logo">
                        <img src="./images/hempLogo.png" />
                    </div> *}
                    <div class="auth-shead">New to Hempbuyer</div>
                    <div class="auth-ctxt">Create Your Account Below</div>

                    {* {if $afcode!=''} *}
                        <div class="text-center m-4">
                            <a href="/register_referral">Click here</a> to REGISTER FOR REFERRAL AFFILIATE PROGRAM
                        </div>
                    {* {/if} *}

                    <div class="form-head">Register as</div>

                    <div class="formClass">
                        <div class="progress reg_prog_bar">
                            <div class="progress-bar progress-bar-striped bg-success progress-bar-animated"
                                role="progressbar" style="width: 10%" aria-valuenow="25" aria-valuemin="0"
                                aria-valuemax="100"></div>
                        </div>
                        <div class="text-danger">
                            <b>Note:</b> All fields are required.
                        </div>
                        <div class="form-group">
                            <label class="sf-label">Username</label>
                            <div class="icon-input">
                                <div class="icon-box">
                                    <img src="images/user.png" alt="" />
                                </div>
                                <input class="form-control" name="cg_username" id="cg_username" onblur="checkusername(this.value)" placeholder="Username"
                                    required />
                                <span id="umsg" class="reg-error"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="sf-label">Email</label>
                            <div class="icon-input">
                                <div class="icon-box pwd-box">
                                    <img src="images/email.png" alt="" />
                                </div>
                                <input type="email" id="cg_email" onblur="checkemail(this.value)" name="cg_email" class="form-control" placeholder="Email" required />
                                <span id="emsg" class="reg-error"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="sf-label">Password</label>
                            <div class="icon-input">
                                <div class="icon-box pwd-box">
                                    <img src="images/pwd.png" alt="" />
                                </div>
                                <input type="password" id="password" name="password" class="form-control"
                                    placeholder="Password" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="sf-label">Confirm Password</label>
                            <div class="icon-input">
                                <div class="icon-box pwd-box">
                                    <img src="images/pwd.png" alt="" />
                                </div>
                                <input type="password" id="password_confirm" data-parsley-equalto="#password"
                                    name="password_confirm" required class="form-control"
                                    placeholder="Confirm Password" />
                            </div>
                        </div>

                        <div class="row mar-top-25">
                            <div class="col-sm-12">
                                <div class="form-inline form-group">
                                    <label class="pp-label">Where have you been referred
                                        from?</label>
                                    <div class="row w-100 mar-top-25">
                                        <div class="col-sm-12 form-group m-0">
                                            <div class="radio">
                                                <input id="web_search" type="radio"
                                                    name="cg_refered_by" value="1" {if $users.refered_by==1}checked{/if} {if $ref_data.id}disabled{/if}>
                                                <label for="web_search">Web Search</label>
                                            </div>
                                        </div>
                                        <div class="col-sm-12 form-group m-0">
                                            <div class="radio">
                                                <input id="social" type="radio"
                                                    name="cg_refered_by" value="0" {if $users.refered_by==0}checked{/if} {if $ref_data.id}disabled{/if}>
                                                <label for="social">Social Media</label>
                                            </div>
                                        </div>
                                        <div class="col-sm-12 form-group m-0">
                                            <div class="radio">
                                                <input id="buyer_referral" type="radio"
                                                    name="cg_refered_by" value="2" {if $users.refered_by==2}checked{/if} {if $ref_data.id}disabled{/if}>
                                                <label for="buyer_referral">
                                                    HempBuyer Referral Partner
                                                    <span class="rinfo-info"><img src="/images/info.png" alt=""></span>
                                                    <span class="remail_info_text">
                                                        <p>HempBuyer Referral Partners earn money with buyer referrals.<br><a href="/banners" target="_blank">Learn More</a></p>
                                                    </span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-sm-12 form-group m-0">
                                            <div class="radio">
                                                <input id="referral_affiliate" type="radio" name="cg_refered_by" value="4" {if $ref_data.id}checked{/if} {if $ref_data.id || $afcode==''}disabled{/if}>
                                                <label for="referral_affiliate">
                                                    HempBuyer Referral Affiliate
                                                    <span class="rinfo-info"><img src="/images/info.png" alt=""></span>
                                                    <span class="remail_info_text">
                                                        <p>You need to click on an affiliate link or banner so the referral code can be populated. Please go back to the referring website and click the link or banner before proceeding.</p>
                                                    </span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-sm-12 form-group m-0">
                                            <div class="radio">
                                                <input id="other" type="radio"
                                                    name="cg_refered_by" value="3" {if $users.refered_by==3}checked{/if} {if $ref_data.id}disabled{/if}>
                                                <label for="other">Other</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="referred_error text-danger"></div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row ">
                            <div class="col-sm-12" id="social_media_dropdown" style="display: none;">
                                <div class="form-group">
                                    <div class="clearfix cselec-wrap">
                                        <select class="custom-select" name="social_media" id="social_media">
                                            <option value="linkedin">Linkedin</option>
                                            <option value="facebook">Facebook</option>
                                            <option value="twitter">Twitter</option>
                                            <option value="instagram">Instagram</option>
                                            <option value="other">Other</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12" id="other_social_media" style="display: none;">
                                <div class="form-group">
                                    <div class="clearfix">
                                        <input class="form-control" placeholder="Other Social Media" name="social_media_other" id="social_media_other" required="required" data-parsley-trigger="change">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="buyer_referral_div" style="display: none;">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <div class="clearfix">
                                        <input class="form-control" placeholder="Referral Full Name" name="ref_name" id="ref_name" required="required" data-parsley-trigger="change">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <div class="clearfix">
                                        <input class="form-control" placeholder="Referral Email" name="ref_email" id="ref_email" required="required" data-parsley-trigger="change">
                                        <span id="buyer_referral_status"></span>
                                        <span id="buyer_referral_error"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <div class="clearfix">
                                        <input class="form-control" placeholder="Date of Registration" name="ref_date" id="ref_date" required="required" data-parsley-trigger="change" readonly>
                                        <span id="buyer_referral_date"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="referral_affiliate_div" style="{if !$ref_data.id}display: none;{/if}">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <div class="clearfix">
                                        <input class="form-control" placeholder="Full Name" name="rf_name" id="rf_name" value="{$ref_data.name}" required="required" readonly data-parsley-trigger="change">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <div class="clearfix">
                                        <input class="form-control" placeholder="Referral Email" name="rf_email" id="rf_email" value="{$ref_data.email}" required="required" readonly data-parsley-trigger="change">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <div class="clearfix">
                                        <input class="form-control" placeholder="Referral Code" name="rf_code" id="rf_code" value="{$ref_data.code}" required="required" readonly data-parsley-trigger="change">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12" id="other_referral" style="display: none;">
                                <div class="form-group">
                                    <div class="clearfix">
                                        <input class="form-control" placeholder="Other Referral" name="ref_other" id="ref_other" required="required" data-parsley-trigger="change">
                                    </div>
                                </div>
                            </div>
                        </div>

                        {* <div class="row ">
                            <div class="col-sm-12">
                                <div class="form-inline form-group m-0">
                                    <label class="pp-label">Where have you been referred
                                        from?</label>
                                    <div class="w-100 d-flex mar-top-25 mar-btm-25">
                                        <div class="radio">
                                            <input id="web_search" type="radio"
                                                name="cg_refered_by" value="1" {if $users.refered_by==1}checked{/if} {if $ref_data.id}disabled{/if}>
                                            <label for="web_search">Web Search</label>
                                        </div>
                                        <div class="radio">
                                            <input id="social" type="radio"
                                                name="cg_refered_by" value="0" {if $users.refered_by==0}checked{/if} {if $ref_data.id}disabled{/if}>
                                            <label for="social">Social Media</label>
                                        </div>
                                        <div class="radio">
                                            <input id="buyer_referral" type="radio"
                                                name="cg_refered_by" value="2" {if $users.refered_by==2}checked{/if} {if $ref_data.id}disabled{/if}>
                                            <label for="buyer_referral">
                                                HempBuyer Referral Partner
                                                <span class="rinfo-info"><img src="/images/info.png" alt=""></span>
                                                <span class="remail_info_text">
                                                    <p>HempBuyer Referral Partners earn money with buyer referrals.<br><a href="/banners" target="_blank">Learn More</a></p>
                                                </span>
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <input id="referral_affiliate" type="radio" name="cg_refered_by" value="4" {if $ref_data.id || $afcode!=''}checked{/if} {if $ref_data.id || $afcode==''}disabled{/if}>
                                            <label for="referral_affiliate">
                                                HempBuyer Referral Affiliate
                                                <span class="rinfo-info"><img src="/images/info.png" alt=""></span>
                                                <span class="remail_info_text">
                                                    <p>You need to click on an affiliate link or banner so the referral code can be populated. Please go back to the referring website and click the link or banner before proceeding.</p>
                                                </span>
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <input id="other" type="radio"
                                                name="cg_refered_by" value="3" {if $users.refered_by==3}checked{/if} {if $ref_data.id}disabled{/if}>
                                            <label for="other">Other</label>
                                        </div>
                                    </div>
                                    <div class="referred_error text-danger"></div>
                                </div>
                            </div>
                        </div> *}

                        <div class="pt-3">
                            <button type="submit" class="btn btn-brown">NEXT</button>
                        </div>


                        <div class="ha-txt text-center">
                            Already Have an Account ? <a href="/signin">Login</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="footer reg-footer">
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
    </form>
</div>

<div id="step2_data" class="step_data" style="display: none;"> 
    <form class="pp-form user_form hb-reg-form2" data-parsley-validate novalidate id="step2_form">
        <div class="clearfix auth-container">
                        <div class="auth-left">
                            <div class="auth-content-wrapper reg_main_step-2">
                                {* <div class="auth-logo">
                                    <img src="./images/hempLogo.png" />
                                </div> *}
                                <div class="auth-shead">New to Hempbuyer</div>
                                <div class="auth-ctxt">Create Your Account Below</div>
                                {if $afcode!=''}
                                    <div class="text-center m-4">
                                        <a href="/register_referral">Click here</a> to REGISTER FOR REFERRAL AFFILIATE PROGRAM
                                    </div>
                                {/if}
                                <div class="form-head">Register as</div>

                                <div class="progress reg_prog_bar">
                                    <div class="progress-bar progress-bar-striped bg-success progress-bar-animated"
                                        role="progressbar" style="width: 35%" aria-valuenow="25" aria-valuemin="0"
                                        aria-valuemax="100"></div>
                                </div>

                                <div class="reg-tabs">
                                    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link" id="individual_user" data-toggle="pill"
                                                href="#individual_user_tab" role="tab"
                                                aria-controls="individual_user_tab" aria-selected="false"
                                                onclick="setUser(100)">Individual</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" id="ind_auth_rep" data-toggle="pill"
                                                href="#ind_auth_rep_tab" role="tab" aria-controls="ind_auth_rep_tab"
                                                aria-selected="true" onclick="setUser(101)">Individual
                                                With Authorized
                                                Representative</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" id="pills-contact-tab" data-toggle="pill"
                                                href="#pills-contact" role="tab" aria-controls="pills-contact"
                                                aria-selected="false" onclick="setUser(102)">Registered
                                                Company With
                                                Authorized
                                                Representative</a>
                                        </li>
                                        <li>
                                            <span class="reg-info"><img src="/images/info.png" alt=""></span>
                                            <span class="reg_info_text">
                                                <p>An authorized representative is someone who has the legal right to
                                                    administrate the account. Examples: Company, Officer, Authorized
                                                    Employee, Broker or Sales Representative</p>
                                            </span>
                                        </li>
                                    </ul>
                                    <div class="tab-content" id="pills-tabContent">
                                        <div class="tab-pane fade" id="individual_user_tab" role="tabpanel"
                                            aria-labelledby="individual_user">
                                            <div class="text-danger">
                                                <b>Note:</b> All fields are required.
                                            </div>
                                            <div class="form1 user_form" id="form100">
                                                <input type="hidden" name="ref_user_id" id="ref_user_id" value="0">
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <div class="form-group ">
                                                            <label class="sf-label">Full Name</label>
                                                            <div class="icon-input">
                                                                <div class="icon-box">
                                                                    <img src="images/user.png" alt="" />
                                                                </div>
                                                                <input class="form-control" placeholder="Full Name"
                                                                    name="cg_name" id="cg_name" required />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <label class="sf-label">Email</label>
                                                            <div class="icon-input">
                                                                <div class="icon-box pwd-box">
                                                                    <img src="images/email.png" alt="" />
                                                                </div>
                                                                <input type="email" name="cg_email2"
                                                                    class="form-control" placeholder="Email"
                                                                    id="cg_email2" required />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <label class="sf-label">Phone Number (Mobile Phone Preferred)</label>
                                                            {* <span class="pos-rel">
                                                                <span class="phone-info"><img src="./images/info.png" alt=""></span>
                                                                <span class="phone_info_text">
                                                                    <p>A One Time Password (OTP) will be sent to mobile numbers via SMS or via voice message to landlines used to verify your identity.</p>
                                                                </span>
                                                            </span> *}
                                                            <div class="mobile_note text-danger">A One Time Password (OTP) will be sent to mobile numbers via SMS or via voice message to landlines used to verify your identity.</div>
                                                            <div class="icon-input">
                                                                <div class="icon-box pwd-box">
                                                                    <img src="images/flag.png" alt="" />
                                                                </div>
                                                                <input name="cg_phone" id="cg_phone"
                                                                    class="form-control phone_us" placeholder="+1 (111) 111-1111" required parsley-type="phone" data-parsley-trigger="change"
                                                                    data-parsley-minlength="17" 
                                                                    data-parsley-minlength-message="Phone number is invalid." />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group ">
                                                            <label class="sf-label">Street Address</label>
                                                            <div class="icon-input">
                                                                <div class="icon-box pwd-box">
                                                                    <img src="images/pwd.png" alt="" />
                                                                </div>
                                                                <input class="form-control"
                                                                    placeholder="Street Address/Suite/Unit/Other Number"
                                                                    name="cg_address" id="cg_address" required />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <div class="form-group ">
                                                            <label class="sf-label">City</label>
                                                            <div class="icon-input">
                                                                <div class="icon-box pwd-box">
                                                                    <img src="images/pwd.png" alt="" />
                                                                </div>
                                                                <input class="form-control" placeholder="City"
                                                                    name="cg_city" id="cg_city" required />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group ">
                                                            <label class="sf-label">State</label>
                                                            <div class="clearfix cselec-wrap">
                                                                <select class="custom-select" name="cg_state"
                                                                    id="cg_state" required style="height: 47px;">
                                                                    <option value="">Select State</option>
                                                                    {foreach $states as $key => $val}
                                                                        <option value="{$val.abbrev}" {if
                                                                            $product.category_id==$val.abbrev} selected
                                                                            {/if}>{$val.name} </option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <div class="form-group ">
                                                            <label class="sf-label">Zip</label>
                                                            <div class="icon-input">
                                                                <div class="icon-box pwd-box">
                                                                    <img src="images/pwd.png"
                                                                        alt="" />
                                                                </div>
                                                                <input class="form-control "
                                                                    placeholder="Zip" name="cg_zipcode"
                                                                    id="cg_zipcode" onkeypress='return isNumberKey(event)' required />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group ">
                                                            <label class="sf-label">Country</label>
                                                            <div class="clearfix cselec-wrap">
                                                                <select class="custom-select"
                                                                    name="cg_country"
                                                                    id="cg_country" required>
                                                                    <option>United States</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <div class="form-group ">
                                                            <label class="sf-label">SSN</label>
                                                            <span class="pos-rel">
                                                                <span class="ssn-info"><img src="./images/info.png" alt=""></span>
                                                                <span class="ssn_info_text">
                                                                    <p>Your EIN and or SSN is used to verify your identity.
                                                                        HempBuyer does NOT see nor store this information.
                                                                        LexisNexis® Risk Solutions services is a contracted to
                                                                        verify members identity for your safety.</p>
                                                                </span>
                                                            </span>
                                                            <div class="icon-input">
                                                                <div class="icon-box pwd-box">
                                                                    <img src="images/ssn.png" alt="" />
                                                                </div>
                                                                <input class="form-control cg_ssn"
                                                                    placeholder="123-12-1234" name="cg_ssn"
                                                                    id="cg_ssn" required />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group ">
                                                            <label class="sf-label">Date of Birth</label>
                                                            <div class="icon-input">
                                                                <div class="icon-box pwd-box">
                                                                    <img src="images/cal.png" alt="" />
                                                                </div>
                                                                <input class="form-control nt-cdate"
                                                                    placeholder="01-01-1974" name="cg_dob"
                                                                    id="cg_dob" required autocomplete="off"
                                                                    style="background-color: white; cursor: pointer;" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <div class="form-group ">
                                                            <label class="sf-label">License Type</label>
                                                            <div class="clearfix cselec-wrap">
                                                                <select class="custom-select"
                                                                    name="l_type" id="l_type" required>
                                                                    <option value="">Select License Type</option>
                                                                    <option value="cultivator">Cultivator</option>
                                                                    <option value="processor">Processor</option>
                                                                    <option value="manufacturer">Manufacturer</option>
                                                                    <option value="distributor">Distributor/ Handler</option>
                                                                    <option value="retailer">Retailer</option>
                                                                    <option value="other">Other</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group ">
                                                            <label class="sf-label">License Number</label>
                                                            <div class="icon-input">
                                                                <div class="icon-box pwd-box">
                                                                    <img src="images/ssn.png" alt="" />
                                                                </div>
                                                                <input class="form-control"
                                                                    placeholder="License Number"
                                                                    name="l_number" id="l_number" required />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row" id="other_license_type" style="display: none;">
                                                    <div class="col-sm-6">
                                                        <div class="form-group text-left">
                                                            <label class="sf-label">Other License Type</label>
                                                            <div class="clearfix ">
                                                                <input type="text" class="form-control"
                                                                    placeholder="Other License Type"
                                                                    name="l_type_other" id="l_type_other" required />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row align-items-end">
                                                    <div class="col-sm-6">
                                                        <div class="form-group ">
                                                            <label class="sf-label">License expiration
                                                                date</label>
                                                            <div class="icon-input">
                                                                <div class="icon-box pwd-box">
                                                                    <img src="images/cal.png" alt="" />
                                                                </div>
                                                                <input class="form-control license_date"
                                                                    placeholder="Enter license expiration date"
                                                                    name="cg_license_date"
                                                                    id="cg_license_date" required
                                                                    autocomplete="off"
                                                                    style="background-color: white; cursor: pointer;" /> 
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group ">
                                                            <label class="sf-label">License Issue Date</label>
                                                            <div class="icon-input">
                                                                <div class="icon-box pwd-box">
                                                                    <img src="images/cal.png" alt="" />
                                                                </div>
                                                                <input class="form-control l_issue_date"
                                                                    placeholder="Enter License Issue Date"
                                                                    name="l_issue_date" id="l_issue_date" autocomplete="off" required style="background-color: white; cursor: pointer;" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <div class="form-group ">
                                                            <label class="sf-label">License Country</label>
                                                            <div class="icon-input">
                                                                <div class="icon-box pwd-box">
                                                                    <img src="images/ssn.png" alt="" />
                                                                </div>
                                                                <input name="l_country" id="l_country"
                                                                    class="form-control" placeholder="Country" required data-parsley-trigger="change" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group ">
                                                            <label class="sf-label">State/province issuing license</label>
                                                            <div class="icon-input">
                                                                <div class="icon-box pwd-box">
                                                                    <img src="images/ssn.png" alt="" />
                                                                </div>
                                                                <input class="form-control"
                                                                    placeholder="State/province issuing license"
                                                                    name="l_state" id="l_state" required />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <div id="license_text"></div>
                                                            <label for="upload-lic"
                                                                class="upl_lab w-100 btn btn-brown sec-btn d-flex justify-content-center align-items-center">UPLOAD LICENSE/BUSINESS DOCS</label>
                                                            <input type="file" name="license" id="upload-lic"
                                                                class="upload-lic" required onchange="uploadFile(this, 'license');" />
                                                        </div>
                                                    </div>
                                                </div>

                                                
                                                <div class="mar-top-35">
                                                    <div class="form-group clearfix">
                                                        <div class="cus-check ">
                                                            <input type="checkbox" id="im_interested1" name="im_interested1">
                                                            <span class="checkmark"></span><label class="m-0" for="im_interested1">I am interested in advertising with banner/square ads with you.</label>
                                                        </div>
                                                    </div>
                                                    <div class="form-group clearfix">
                                                        <div class="cus-check ">
                                                            <input type="checkbox" id="i_have_read_open1" name="i_have_read_open1" required required data-parsley-mincheck="1" data-parsley-mincheck-message="This value is required.">
                                                            <span class="checkmark"></span><label class="m-0" for="i_have_read_open1">I have read and agree to abide by HempBuyer's Membership code of ethics.</label>
                                                        </div>
                                                    </div>

                                                    <div class="form-group clearfix">
                                                        <div class="cus-check ">
                                                            <input type="checkbox" name="terms" required data-parsley-required="true"
                                                                data-parsley-trigger="click" id="openTermConditionCheck1" required data-parsley-mincheck="1" data-parsley-mincheck-message="This value is required.">
                                                            <span class="checkmark"></span><label for="openTermConditionCheck1">I accept Terms & Conditions</label>
                                                        </div>
                                                    </div>
                                                </div>

                                                {* <div class="row ">
                                                    <div class="col-sm-12">
                                                        <div class="form-inline form-group m-0">
                                                            <label class="pp-label">Where have you been referred
                                                                from?</label>
                                                            <div class="w-100 d-flex mar-top-25 mar-btm-25">
                                                                <div class="radio">
                                                                    <input id="web_search" type="radio"
                                                                        name="cg_refered_by" value="1" {if $users.refered_by==1}checked{/if} {if $ref_data.id}disabled{/if}>
                                                                    <label for="web_search">Web Search</label>
                                                                </div>
                                                                <div class="radio">
                                                                    <input id="social" type="radio"
                                                                        name="cg_refered_by" value="0" {if $users.refered_by==0}checked{/if} {if $ref_data.id}disabled{/if}>
                                                                    <label for="social">Social Media</label>
                                                                </div>
                                                                <div class="radio">
                                                                    <input id="buyer_referral" type="radio"
                                                                        name="cg_refered_by" value="2" {if $users.refered_by==2}checked{/if} {if $ref_data.id}disabled{/if}>
                                                                    <label for="buyer_referral">
                                                                        HempBuyer Referral Partner
                                                                        <span class="rinfo-info"><img src="/images/info.png" alt=""></span>
                                                                        <span class="remail_info_text">
                                                                            <p>HempBuyer Referral Partners earn money with buyer referrals.<br><a href="/banners" target="_blank">Learn More</a></p>
                                                                        </span>
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <input id="referral_affiliate" type="radio" name="cg_refered_by" value="4" {if $ref_data.id || $afcode!=''}checked{/if} {if $ref_data.id || $afcode==''}disabled{/if}>
                                                                    <label for="referral_affiliate">
                                                                        HempBuyer Referral Affiliate
                                                                        <span class="rinfo-info"><img src="/images/info.png" alt=""></span>
                                                                        <span class="remail_info_text">
                                                                            <p>You need to click on an affiliate link or banner so the referral code can be populated. Please go back to the referring website and click the link or banner before proceeding.</p>
                                                                        </span>
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <input id="other" type="radio"
                                                                        name="cg_refered_by" value="3" {if $users.refered_by==3}checked{/if} {if $ref_data.id}disabled{/if}>
                                                                    <label for="other">Other</label>
                                                                </div>
                                                            </div>
                                                            <div class="referred_error text-danger"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row ">
                                                    <div class="col-sm-6" id="social_media_dropdown" style="display: none;">
                                                        <div class="form-group">
                                                            <div class="clearfix cselec-wrap">
                                                                <select class="custom-select" name="social_media" id="social_media">
                                                                    <option value="linkedin">Linkedin</option>
                                                                    <option value="facebook">Facebook</option>
                                                                    <option value="twitter">Twitter</option>
                                                                    <option value="instagram">Instagram</option>
                                                                    <option value="other">Other</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6" id="other_social_media" style="display: none;">
                                                        <div class="form-group">
                                                            <div class="clearfix">
                                                                <input class="form-control" placeholder="Other Social Media" name="social_media_other" id="social_media_other" required="required" data-parsley-trigger="change">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row" id="buyer_referral_div" style="display: none;">
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <div class="clearfix">
                                                                <input class="form-control" placeholder="Referral Full Name" name="ref_name" id="ref_name" required="required" data-parsley-trigger="change">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <div class="clearfix">
                                                                <!-- <input class="form-control" placeholder="Phone Number" name="ref_phone" id="ref_phone" required="required" data-parsley-trigger="change"> -->
                                                                <input class="form-control" placeholder="Referral Email" name="ref_email" id="ref_email" required="required" data-parsley-trigger="change">
                                                                <span id="buyer_referral_status"></span>
                                                                <span id="buyer_referral_error"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <div class="clearfix">
                                                                <input class="form-control" placeholder="Date of Registration" name="ref_date" id="ref_date" required="required" data-parsley-trigger="change" readonly>
                                                                <span id="buyer_referral_date"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row" id="referral_affiliate_div" style="{if !$ref_data.id}display: none;{/if}">
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <div class="clearfix">
                                                                <input class="form-control" placeholder="Full Name" name="rf_name" id="rf_name" value="{$ref_data.name}" required="required" readonly data-parsley-trigger="change">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <div class="clearfix">
                                                                <input class="form-control" placeholder="Referral Email" name="rf_email" id="rf_email" value="{$ref_data.email}" required="required" readonly data-parsley-trigger="change">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <div class="clearfix">
                                                                <input class="form-control" placeholder="Referral Code" name="rf_code" id="rf_code" value="{$ref_data.code}" required="required" readonly data-parsley-trigger="change">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-6" id="other_referral" style="display: none;">
                                                        <div class="form-group">
                                                            <div class="clearfix">
                                                                <input class="form-control" placeholder="Other Referral" name="ref_other" id="ref_other" required="required" data-parsley-trigger="change">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> *}

                                                <div class="pt-3 d-flex">
                                                    <button type="button" class="btn btn-secondary" onclick="goBack(1)">BACK</button>
                                                    <button type="submit" class="btn btn-brown">SIGN UP</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-pane fade" id="ind_auth_rep_tab" role="tabpanel"
                                            aria-labelledby="ind_auth_rep">
                                            <div class="text-danger">
                                                <b>Note:</b> All fields are required.
                                            </div>
                                            <div class="reg_main-form1 reg-upd-form1 form2" id="form101">
                                                <!-- <form class="reg_main-form"> -->
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Full Name</label>
                                                                <div class="icon-input">
                                                                    <div class="icon-box">
                                                                        <img src="images/user.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control" placeholder="Full Name" name="cg_name" id="cg_name" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="sf-label">Account Email</label>
                                                                 - Used to administrate your account
                                                                <span class="ainfo-info">&nbsp;<img src="/images/info.png" alt=""></span>
                                                                <span class="aemail_info_text">
                                                                    <p>Your authorized Rep will need access to this email to administrate your account</p>
                                                                </span>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/email.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control" placeholder="Account Email" name="cg_email2" id="cg_email2" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-sm-6"></div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="sf-label">Secondary Email</label>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/email.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control" placeholder="Secondary Email" name="cg_email3" id="cg_email3" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Business Name-DBA</label>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/pwd.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control cg_business_name" placeholder="Business Name" name="cg_business_name" id="cg_business_name" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Street Address</label>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/pwd.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control" placeholder="Street Address/Suite/Unit/Other Number" name="cg_address" id="cg_address" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">City</label>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/pwd.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control" placeholder="City" name="cg_city" id="cg_city" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">State</label>
                                                                <div class="clearfix cselec-wrap">
                                                                    <select class="custom-select" name="cg_state"
                                                                    id="cg_state" required style="height: 47px;">
                                                                    <option value="">Select State</option>
                                                                    {foreach $states as $key => $val}
                                                                    <option value="{$val.abbrev}" {if
                                                                        $product.category_id==$val.abbrev} selected
                                                                        {/if}>{$val.name} </option> {/foreach} </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Zip</label>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/pwd.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control" placeholder="Zip" name="cg_zipcode" id="cg_zipcode" onkeypress='return isNumberKey(event)' />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Representative Country</label>
                                                                <div class="clearfix cselec-wrap">
                                                                    <select class="custom-select" name="cg_country" id="cg_country">
                                                                        <option>United States</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Phone Number (Mobile Phone Preferred)</label>
                                                                {* <span class="pos-rel">
                                                                    <span class="phone-info"><img src="./images/info.png" alt=""></span>
                                                                    <span class="phone_info_text">
                                                                        <p>A One Time Password (OTP) will be sent to mobile numbers via SMS or via voice message to landlines used to verify your identity.</p>
                                                                    </span>
                                                                </span> *}
                                                                <div class="mobile_note text-danger">A One Time Password (OTP) will be sent to mobile numbers via SMS or via voice message to landlines used to verify your identity.</div>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/flag.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control phone_us" placeholder="+1 (111) 111-1111"  parsley-type="phone" data-parsley-trigger="change"
                                                                    data-parsley-minlength="17" 
                                                                    data-parsley-minlength-message="Phone number is invalid." name="cg_phone" id="cg_phone" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="sf-label">SSN</label>
                                                                <span class="pos-rel">
                                                                    <span class="ssn-info"><img src="./images/info.png" alt=""></span>
                                                                    <span class="ssn_info_text">
                                                                        <p>Your EIN and or SSN is used to verify your identity.
                                                                            HempBuyer does NOT see nor store this information.
                                                                            LexisNexis® Risk Solutions services is a contracted to
                                                                            verify members identity for your safety.</p>
                                                                    </span>
                                                                </span>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/ssn.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control cg_ssn" placeholder="123-12-1234" name="cg_ssn" id="cg_ssn" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep Name</label>
                                                                <div class="icon-input">
                                                                    <input class="form-control pad-lt-15" placeholder="Rep Name" name="cg_rep_name" id="cg_rep_name" />
                                                                </div>
                                                            </div>
                                                        </div>
                
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep SSN</label>
                                                                <span class="pos-rel">
                                                                    <span class="ssn-info"><img src="./images/info.png" alt=""></span>
                                                                    <span class="ssn_info_text">
                                                                        <p>Your EIN and or SSN is used to verify your identity.
                                                                            HempBuyer does NOT see nor store this information.
                                                                            LexisNexis® Risk Solutions services is a contracted to
                                                                            verify members identity for your safety.</p>
                                                                    </span>
                                                                </span>
                                                                <div class="icon-input">
                                                                    <input class="form-control pad-lt-15 cg_rep_ssn" placeholder="123-12-1234" name="cg_rep_ssn" id="cg_rep_ssn" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep Street Address</label>
                                                                <div class="icon-input">
                                                                    <input class="form-control pad-lt-15"
                                                                        placeholder="Rep Street Address" name="cg_rep_address" id="cg_rep_address" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep City</label>
                                                                <div class="icon-input">
                                                                    <input class="form-control pad-lt-15" placeholder="Rep City" name="cg_rep_city" id="cg_rep_city" />
                                                                </div>
                                                            </div>
                                                        </div>
                
                                                    </div>
                
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep State</label>
                                                                <div class="clearfix cselec-wrap">
                                                                    <select class="custom-select" name="cg_rep_state"
                                                                    id="cg_rep_state" required style="height: 47px;">
                                                                        <option value="">Select State</option>
                                                                        {foreach $states as $key => $val}
                                                                            <option value="{$val.abbrev}" {if
                                                                            $product.category_id==$val.abbrev} selected
                                                                            {/if}>{$val.name} </option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep Zip</label>
                                                                <div class="icon-input">
                                                                    <input class="form-control pad-lt-15" placeholder="Rep Zip" name="cg_rep_zipcode" id="cg_rep_zipcode" onkeypress='return isNumberKey(event)' />
                                                                </div>
                                                            </div>
                                                        </div>
                
                                                    </div>
                
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep Phone</label>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/flag.png" alt="" />
                                                                    </div>
                                                                    <input placeholder="+1 (111) 111-1111"
                                                                    name="cg_rep_phone" id="cg_rep_phone"
                                                                    class="form-control" required parsley-type="phone" data-parsley-trigger="change" />
                                                                </div>
                                                            </div>
                                                        </div>
                
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep Date of Birth</label>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/cal.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control nt-cdate" placeholder="01-01-1974" name="cg_dob"
                                                                    id="cg_dob" required autocomplete="off" style="background-color: white; cursor: pointer;" />
                                                                </div>
                                                            
                                                                    <!-- <input class="nt-cdate form-control pad-lt-15" placeholder="Rep DOB" name="cg_dob"
                                                                    id="cg_dob" required
                                                                    readonly="readonly" style="background-color: white; cursor: pointer;" /> -->

                                                            </div>
                                                        </div>
                                                    </div>

                                                    {* <div class="row ">
                                                        <div class="col-sm-12">
                                                            <div class="form-inline form-group m-0">
                                                                <label class="pp-label">Where have you been referred
                                                                    from?</label>
                                                                <div class="w-100 d-flex mar-top-25 mar-btm-25">
                                                                    <div class="radio">
                                                                        <input id="web_search" type="radio"
                                                                            name="cg_refered_by" value="1" {if $users.refered_by==1}checked{/if} {if $ref_data.id}disabled{/if}>
                                                                        <label for="web_search">Web Search</label>
                                                                    </div>
                                                                    <div class="radio">
                                                                        <input id="social" type="radio"
                                                                            name="cg_refered_by" value="0" {if $users.refered_by==0}checked{/if} {if $ref_data.id}disabled{/if}>
                                                                        <label for="social">Social Media</label>
                                                                    </div>
                                                                    <div class="radio">
                                                                        <input id="buyer_referral" type="radio"
                                                                            name="cg_refered_by" value="2" {if $users.refered_by==2}checked{/if} {if $ref_data.id}disabled{/if}>
                                                                        <label for="buyer_referral">
                                                                            HempBuyer Referral Partner
                                                                            <span class="rinfo-info"><img src="/images/info.png" alt=""></span>
                                                                            <span class="remail_info_text">
                                                                                <p>HempBuyer Referral Partners earn money with buyer referrals.<br><a href="/banners" target="_blank">Learn More</a></p>
                                                                            </span>
                                                                        </label>
                                                                    </div>
                                                                    <div class="radio">
                                                                        <input id="referral_affiliate" type="radio" name="cg_refered_by" value="4" {if $ref_data.id || $afcode!=''}checked{/if} {if $ref_data.id || $afcode==''}disabled{/if}>
                                                                        <label for="referral_affiliate">
                                                                            HempBuyer Referral Affiliate
                                                                            <span class="rinfo-info"><img src="/images/info.png" alt=""></span>
                                                                            <span class="remail_info_text">
                                                                                <p>You need to click on an affiliate link or banner so the referral code can be populated. Please go back to the referring website and click the link or banner before proceeding.</p>
                                                                            </span>
                                                                        </label>
                                                                    </div>
                                                                    <div class="radio">
                                                                        <input id="other" type="radio"
                                                                            name="cg_refered_by" value="3" {if $users.refered_by==3}checked{/if} {if $ref_data.id}disabled{/if}>
                                                                        <label for="other">Other</label>
                                                                    </div>
                                                                </div>
                                                                <div class="referred_error text-danger"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row ">
                                                        <div class="col-sm-6" id="social_media_dropdown" style="display: none;">
                                                            <div class="form-group">
                                                                <div class="clearfix cselec-wrap">
                                                                    <select class="custom-select" name="social_media" id="social_media">
                                                                        <option value="linkedin">Linkedin</option>
                                                                        <option value="facebook">Facebook</option>
                                                                        <option value="twitter">Twitter</option>
                                                                        <option value="instagram">Instagram</option>
                                                                        <option value="other">Other</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6" id="other_social_media" style="display: none;">
                                                            <div class="form-group">
                                                                <div class="clearfix">
                                                                    <input class="form-control" placeholder="Other Social Media" name="social_media_other" id="social_media_other" required="required" data-parsley-trigger="change">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row" id="buyer_referral_div" style="display: none;">
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <div class="clearfix">
                                                                    <input class="form-control" placeholder="Referral Full Name" name="ref_name" id="ref_name" required="required" data-parsley-trigger="change">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <div class="clearfix">
                                                                    <!-- <input class="form-control" placeholder="Phone Number" name="ref_phone" id="ref_phone" required="required" data-parsley-trigger="change"> -->
                                                                    <input class="form-control" placeholder="Referral Email" name="ref_email" id="ref_email" required="required" data-parsley-trigger="change">
                                                                    <span id="buyer_referral_status"></span>
                                                                    <span id="buyer_referral_error"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <div class="clearfix">
                                                                    <input class="form-control" placeholder="Date of Registration" name="ref_date" id="ref_date" required="required" data-parsley-trigger="change" readonly>
                                                                    <span id="buyer_referral_date"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row" id="referral_affiliate_div" style="{if !$ref_data.id}display: none;{/if}">
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <div class="clearfix">
                                                                    <input class="form-control" placeholder="Full Name" name="rf_name" id="rf_name" value="{$ref_data.name}" required="required" readonly data-parsley-trigger="change">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <div class="clearfix">
                                                                    <input class="form-control" placeholder="Referral Email" name="rf_email" id="rf_email" value="{$ref_data.email}" required="required" readonly data-parsley-trigger="change">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <div class="clearfix">
                                                                    <input class="form-control" placeholder="Referral Code" name="rf_code" id="rf_code" value="{$ref_data.code}" required="required" readonly data-parsley-trigger="change">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-sm-6" id="other_referral" style="display: none;">
                                                            <div class="form-group">
                                                                <div class="clearfix">
                                                                    <input class="form-control" placeholder="Other Referral" name="ref_other" id="ref_other" required="required" data-parsley-trigger="change">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div> *}
                
                                                    <div class="pt-3 d-flex">
                                                        <button type="button" class="btn btn-secondary" onclick="goBack(1)">BACK</button>
                                                        <button type="submit" class="btn btn-brown">NEXT</button>
                                                    </div>
                                                <!-- </form> -->
                                            </div>
                                        </div>
                                        <div class="tab-pane fade" id="pills-contact" role="tabpanel"
                                            aria-labelledby="pills-contact-tab">
                                            <div class="text-danger">
                                                <b>Note:</b> All fields are required.
                                            </div>
                                            <div class="reg_main-form1 reg-upd-form1 form3" id="form102">
                                                <!-- <form class="reg_main-form"> -->
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Full Name</label>
                                                                <div class="icon-input">
                                                                    <div class="icon-box">
                                                                        <img src="images/user.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control" placeholder="Full Name" name="cg_name" id="cg_name" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="sf-label">Email</label>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/email.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control" placeholder="Email" name="cg_email" id="cg_email" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Business Name</label>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/pwd.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control cg_business_name" placeholder="Business Name" name="cg_business_name" id="cg_business_name" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Street Address</label>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/pwd.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control" placeholder="Street Address/Suite/Unit/Other Number" name="cg_address" id="cg_address" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">City</label>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/pwd.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control" placeholder="City" name="cg_city" id="cg_city" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">State</label>
                                                                <div class="clearfix cselec-wrap">
                                                                    <select class="custom-select" name="cg_state"
                                                                    id="cg_state" required style="height: 47px;">
                                                                    <option value="">Select State</option>
                                                                    {foreach $states as $key => $val}
                                                                    <option value="{$val.abbrev}" {if
                                                                        $product.category_id==$val.abbrev} selected
                                                                        {/if}>{$val.name} </option> {/foreach} </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Zip</label>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/pwd.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control" placeholder="Zip" name="cg_zipcode" id="cg_zipcode" onkeypress='return isNumberKey(event)' />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep Country</label>
                                                                <div class="clearfix cselec-wrap">
                                                                    <select class="custom-select" name="cg_country" id="cg_country">
                                                                        <option>United States</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep Name</label>
                                                                <div class="icon-input">
                                                                    <input class="form-control pad-lt-15" placeholder="Rep Name" name="cg_rep_name" id="cg_rep_name" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="sf-label">EIN</label>
                                                                <span class="pos-rel">
                                                                    <span class="ssn-info"><img src="./images/info.png" alt=""></span>
                                                                    <span class="ssn_info_text">
                                                                        <p>Your EIN and or SSN is used to verify your identity.
                                                                            HempBuyer does NOT see nor store this information.
                                                                            LexisNexis® Risk Solutions services is a contracted to
                                                                            verify members identity for your safety.</p>
                                                                    </span>
                                                                </span>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/ssn.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control cg_ein" placeholder="12-1234567" name="cg_ein" id="cg_ein" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Phone Number (Mobile Phone Preferred)</label>
                                                                {* <span class="pos-rel">
                                                                    <span class="phone-info"><img src="./images/info.png" alt=""></span>
                                                                    <span class="phone_info_text">
                                                                        <p>A One Time Password (OTP) will be sent to mobile numbers via SMS or via voice message to landlines used to verify your identity.</p>
                                                                    </span>
                                                                </span> *}
                                                                <div class="mobile_note text-danger">A One Time Password (OTP) will be sent to mobile numbers via SMS or via voice message to landlines used to verify your identity.</div>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/flag.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control phone_us" placeholder="+1 (111) 111-1111"  parsley-type="phone" data-parsley-trigger="change"
                                                                    data-parsley-minlength="17" 
                                                                    data-parsley-minlength-message="Phone number is invalid." name="cg_phone" id="cg_phone" />
                                                                </div>
                                                            </div>
                                                        </div>
                
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep SSN</label>
                                                                <span class="pos-rel">
                                                                    <span class="ssn-info"><img src="./images/info.png" alt=""></span>
                                                                    <span class="ssn_info_text">
                                                                        <p>Your EIN and or SSN is used to verify your identity.
                                                                            HempBuyer does NOT see nor store this information.
                                                                            LexisNexis® Risk Solutions services is a contracted to
                                                                            verify members identity for your safety.</p>
                                                                    </span>
                                                                </span>
                                                                <div class="icon-input">
                                                                    <input class="form-control pad-lt-15 cg_rep_ssn" placeholder="123-12-1234" name="cg_rep_ssn" id="cg_rep_ssn" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep Street Address</label>
                                                                <div class="icon-input">
                                                                    <input class="form-control pad-lt-15"
                                                                        placeholder="Rep Street Address" name="cg_rep_address" id="cg_rep_address" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep City</label>
                                                                <div class="icon-input">
                                                                    <input class="form-control pad-lt-15" placeholder="Rep City" name="cg_rep_city" id="cg_rep_city" />
                                                                </div>
                                                            </div>
                                                        </div>
                
                                                    </div>
                
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep State</label>
                                                                <div class="clearfix cselec-wrap">
                                                                    <select class="custom-select" name="cg_rep_state"
                                                                    id="cg_rep_state" required style="height: 47px;">
                                                                        <option value="">Select State</option>
                                                                        {foreach $states as $key => $val}
                                                                            <option value="{$val.abbrev}" {if
                                                                            $product.category_id==$val.abbrev} selected
                                                                            {/if}>{$val.name} </option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep Zip</label>
                                                                <div class="icon-input">
                                                                    <input class="form-control pad-lt-15" placeholder="Rep Zip" name="cg_rep_zipcode" id="cg_rep_zipcode" onkeypress='return isNumberKey(event)' />
                                                                </div>
                                                            </div>
                                                        </div>
                
                                                    </div>
                
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep Phone</label>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/flag.png" alt="" />
                                                                    </div>
                                                                    <input placeholder="+1 (111) 111-1111"
                                                                    name="cg_rep_phone" id="cg_rep_phone"
                                                                    class="form-control" required parsley-type="phone" data-parsley-trigger="change" />
                                                                </div>
                                                            </div>
                                                        </div>
                
                                                        <div class="col-sm-6">
                                                            <div class="form-group ">
                                                                <label class="sf-label">Rep Date of Birth</label>
                                                                <div class="icon-input">
                                                                    <div class="icon-box pwd-box">
                                                                        <img src="images/cal.png" alt="" />
                                                                    </div>
                                                                    <input class="form-control nt-cdate" placeholder="01-01-1974" name="cg_dob"
                                                                    id="cg_dob" autocomplete="off" required style="background-color: white; cursor: pointer;" />
                                                                    <!-- <input class="nt-cdate form-control pad-lt-15" placeholder="Rep DOB" name="cg_dob"
                                                                    id="cg_dob" autocomplete="off" required readonly="readonly" style="background-color: white; cursor: pointer;" /> -->
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    {* <div class="row ">
                                                        <div class="col-sm-12">
                                                            <div class="form-inline form-group m-0">
                                                                <label class="pp-label">Where have you been referred
                                                                    from?</label>
                                                                <div class="w-100 d-flex mar-top-25 mar-btm-25">
                                                                    <div class="radio">
                                                                        <input id="web_search" type="radio"
                                                                            name="cg_refered_by" value="1" {if $users.refered_by==1}checked{/if} {if $ref_data.id}disabled{/if}>
                                                                        <label for="web_search">Web Search</label>
                                                                    </div>
                                                                    <div class="radio">
                                                                        <input id="social" type="radio"
                                                                            name="cg_refered_by" value="0" {if $users.refered_by==0}checked{/if} {if $ref_data.id}disabled{/if}>
                                                                        <label for="social">Social Media</label>
                                                                    </div>
                                                                    <div class="radio">
                                                                        <input id="buyer_referral" type="radio"
                                                                            name="cg_refered_by" value="2" {if $users.refered_by==2}checked{/if} {if $ref_data.id}disabled{/if}>
                                                                        <label for="buyer_referral">
                                                                            HempBuyer Referral Partner
                                                                            <span class="rinfo-info"><img src="/images/info.png" alt=""></span>
                                                                            <span class="remail_info_text">
                                                                                <p>HempBuyer Referral Partners earn money with buyer referrals.<br><a href="/banners" target="_blank">Learn More</a></p>
                                                                            </span>
                                                                        </label>
                                                                    </div>
                                                                    <div class="radio">
                                                                        <input id="referral_affiliate" type="radio" name="cg_refered_by" value="4" {if $ref_data.id || $afcode!=''}checked{/if} {if $ref_data.id || $afcode==''}disabled{/if}>
                                                                        <label for="referral_affiliate">
                                                                            HempBuyer Referral Affiliate
                                                                            <span class="rinfo-info"><img src="/images/info.png" alt=""></span>
                                                                            <span class="remail_info_text">
                                                                                <p>You need to click on an affiliate link or banner so the referral code can be populated. Please go back to the referring website and click the link or banner before proceeding.</p>
                                                                            </span>
                                                                        </label>
                                                                    </div>
                                                                    <div class="radio">
                                                                        <input id="other" type="radio"
                                                                            name="cg_refered_by" value="3" {if $users.refered_by==3}checked{/if} {if $ref_data.id}disabled{/if}>
                                                                        <label for="other">Other</label>
                                                                    </div>
                                                                </div>
                                                                <div class="referred_error text-danger"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row ">
                                                        <div class="col-sm-6" id="social_media_dropdown" style="display: none;">
                                                            <div class="form-group">
                                                                <div class="clearfix cselec-wrap">
                                                                    <select class="custom-select" name="social_media" id="social_media">
                                                                        <option value="linkedin">Linkedin</option>
                                                                        <option value="facebook">Facebook</option>
                                                                        <option value="twitter">Twitter</option>
                                                                        <option value="instagram">Instagram</option>
                                                                        <option value="other">Other</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6" id="other_social_media" style="display: none;">
                                                            <div class="form-group">
                                                                <div class="clearfix">
                                                                    <input class="form-control" placeholder="Other Social Media" name="social_media_other" id="social_media_other" required="required" data-parsley-trigger="change">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row" id="buyer_referral_div" style="display: none;">
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <div class="clearfix">
                                                                    <input class="form-control" placeholder="Referral Full Name" name="ref_name" id="ref_name" required="required" data-parsley-trigger="change">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <div class="clearfix">
                                                                    <input class="form-control" placeholder="Referral Email" name="ref_email" id="ref_email" required="required" data-parsley-trigger="change">
                                                                    <span id="buyer_referral_status"></span>
                                                                    <span id="buyer_referral_error"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <div class="clearfix">
                                                                    <input class="form-control" placeholder="Date of Registration" name="ref_date" id="ref_date" required="required" data-parsley-trigger="change" readonly>
                                                                    <span id="buyer_referral_date"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row" id="referral_affiliate_div" style="{if !$ref_data.id}display: none;{/if}">
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <div class="clearfix">
                                                                    <input class="form-control" placeholder="Full Name" name="rf_name" id="rf_name" value="{$ref_data.name}" required="required" readonly data-parsley-trigger="change">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <div class="clearfix">
                                                                    <input class="form-control" placeholder="Referral Email" name="rf_email" id="rf_email" value="{$ref_data.email}" required="required" readonly data-parsley-trigger="change">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <div class="clearfix">
                                                                    <input class="form-control" placeholder="Referral Code" name="rf_code" id="rf_code" value="{$ref_data.code}" required="required" readonly data-parsley-trigger="change">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-sm-6" id="other_referral" style="display: none;">
                                                            <div class="form-group">
                                                                <div class="clearfix">
                                                                    <input class="form-control" placeholder="Other Referral" name="ref_other" id="ref_other" required="required" data-parsley-trigger="change">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div> *}
                
                                                    <div class="pt-3 d-flex">
                                                        <button type="button" class="btn btn-secondary" onclick="goBack(1)">BACK</button>
                                                        <button type="submit" class="btn btn-brown">NEXT</button>
                                                    </div>
                                                <!-- </form> -->
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="ha-txt text-center">
                                    Already Have an Account ? <a href="/signin">Login</a>
                                </div>
                            </div>
                            <div class="footer reg-footer">
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
    </form>
</div>



<div id="step3_data" class="step_data active" style="display: none;"> 
    <form class="pp-form user_form" data-parsley-validate novalidate style="display: block;" id="step3_form">
        <input type="hidden" name="ref_user_id" id="ref_user_id" value="0">
         <div class="clearfix auth-container">
                        <div class="auth-left">
                            <div class="auth-content-wrapper reg_main_step-2">
                                {* <div class="auth-logo">
                                    <img src="./images/auth-logo.png" />
                                </div> *}
                                <div class="auth-shead">New to Hempbuyer</div>
                                <div class="auth-ctxt">Create Your Account Below</div>
                                {if $afcode!=''}
                                    <div class="text-center m-4">
                                        <a href="/register_referral">Click here</a> to REGISTER FOR REFERRAL AFFILIATE PROGRAM
                                    </div>
                                {/if}
                                <div class="form-head">Register as</div>

                                <div class="progress reg_prog_bar">
                                    <div class="progress-bar progress-bar-striped bg-success progress-bar-animated"
                                        role="progressbar" style="width: 85%" aria-valuenow="25" aria-valuemin="0"
                                        aria-valuemax="100"></div>
                                </div>
                                <div class="reg-tabs">
                                    <ul class="nav nav-pills mb-3" id="pills-tab1" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link nav_100" id="individual_user" data-toggle="pill"
                                                href="#individual_user_tab" role="tab"
                                                aria-controls="individual_user_tab" aria-selected="false">Individual</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link nav_101" id="ind_auth_rep" data-toggle="pill"
                                                href="#ind_auth_rep_tab" role="tab" aria-controls="ind_auth_rep_tab"
                                                aria-selected="true">Individual
                                                With Authorized
                                                Representative</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link nav_102" id="pills-contact-tab" data-toggle="pill"
                                                href="#pills-contact" role="tab" aria-controls="pills-contact"
                                                aria-selected="false">Registered
                                                Company With
                                                Authorized
                                                Representative</a>
                                        </li>
                                        <li>
                                            <span class="reg-info"><img src="/images/info.png" alt=""></span>
                                            <span class="reg_info_text">
                                                <p>An authorized representative is someone who has the legal right to
                                                    administrate the account. Examples: Company, Officer, Authorized
                                                    Employee, Broker or Sales Representative</p>
                                            </span>
                                        </li>
                                    </ul>
                                    <div class="tab-content" id="pills-tabContent">
                                        <div class="tab-pane fade" id="individual_user_tab" role="tabpanel"
                                            aria-labelledby="individual_user">
                                        </div>
                                    </div>
                                </div>


                                <div class="lic-form-box">
                                    <div class="text-danger mb-2">
                                        <b>Note:</b> All fields are required.
                                    </div>
                                    <h3>Is Your Account Managed By An Authorized Representative?</h3>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group uar-wrap">
                                                <div id="verification_document_text"></div>
                                                <label for="upload-lic10"
                                                    class="upl_lab w-100 btn btn-green d-flex justify-content-center align-items-center">UPLOAD
                                                    AUTHORIZED REPRESENTATIVE FORM</label>
                                                <input type="file" name="verification_doc" class="upload-lic"
                                                    id="upload-lic10" onchange="uploadFile(this, 'verification_document');" />
                                                <a class="btn btn-green btn-round" style="top: 10px" data-toggle="modal" data-target="#download_verification_form"><i class="fa fa-question"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <div id="license_text"></div>
                                                <label for="upload-doc11"
                                                    class="upl_lab w-100 btn btn-green d-flex justify-content-center align-items-center">UPLOAD LICENSE/BUSINESS DOCS</label>
                                                <input type="file" name="license" id="upload-doc11"
                                                    class="upload-lic" onchange="uploadFile(this, 'license');" />
                                                <!-- <a class="btn btn-green btn-round" data-toggle="modal" data-target="#download_license_form" style="float: right; margin-right: -33px; margin-top: -29px;"><i class="fa fa-question"></i></a> -->
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mar-top-25">
                                        <div class="col-sm-12">
                                            <div class="form-group text-left">
                                                <span>What if I do not have a hemp industry license? <a href="javascript:void(0)" data-toggle="modal" data-target="#download_license_form">Click Here</a></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mar-top-25">
                                        <div class="col-sm-12">
                                            <div class="form-group text-left">
                                                <span class="float-left">I request a license exemption.&nbsp;&nbsp;</span>
                                                <span class="cus-check float-left">
                                                    <input type="checkbox" name="license_requested" id="license_requested" value="1">
                                                    <span class="checkmark"></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mar-top-25">
                                        <div class="col-sm-12">
                                            <div class="form-group text-left">
                                                <label class="sf-label">License Type</label>
                                                <div class="clearfix cselec-wrap">
                                                    <!-- <select class="custom-select"
                                                        name="l_type" id="l_type" required>
                                                        <option value="producer">Producer</option>
                                                        <option value="processor">Processor</option>
                                                        <option value="none">None</option>
                                                    </select> -->
                                                    <select class="custom-select"
                                                        name="l_type" id="l_type" required>
                                                        <option value="">Select License Type</option>
                                                        <option value="cultivator">Cultivator</option>
                                                        <option value="processor">Processor</option>
                                                        <option value="manufacturer">Manufacturer</option>
                                                        <option value="distributor">Distributor/ Handler</option>
                                                        <option value="retailer">Retailer</option>
                                                        <option value="other">Other</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row mar-top-25" id="other_license_type" style="display: none;">
                                        <div class="col-sm-12">
                                            <div class="form-group text-left">
                                                <div class="clearfix ">
                                                    <input type="text" class="form-control"
                                                        placeholder="Other License Type"
                                                        name="l_type_other" id="l_type_other" required />
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mar-top-25">
                                        <div class="col-sm-12">
                                            <div class="form-group text-left">
                                                <label class="sf-label">License Number</label>
                                                <div class="icon-input">
                                                    <div class="icon-box pwd-box">
                                                        <img src="images/ssn.png" alt="" />
                                                    </div>
                                                    <input type="text" class="form-control"
                                                        placeholder="License Number"
                                                        name="l_number" id="l_number" required />
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mar-top-25">
                                        <div class="col-sm-12">
                                            <div class="form-group text-left">
                                                <label class="sf-label">License expiration date</label>
                                                <div class="icon-input">
                                                    <div class="icon-box">
                                                        <img src="images/cal.png" alt="" />
                                                    </div>
                                                    <input type="text" class="form-control license_date"
                                                        placeholder="Enter license expiration date"
                                                        name="cg_license_date" id="cg_license_date"
                                                        required autocomplete="off"
                                                        style="background-color: white; cursor: pointer;" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row mar-top-25">
                                        <div class="col-sm-12">
                                            <div class="form-group text-left">
                                                <label class="sf-label">License issue date</label>
                                                <div class="icon-input">
                                                    <div class="icon-box pwd-box">
                                                        <img src="images/cal.png" alt="" />
                                                    </div>
                                                    <input type="text" class="form-control l_issue_date"
                                                        placeholder="Enter license issue date"
                                                        name="l_issue_date" id="l_issue_date" required autocomplete="off" style="background-color: white; cursor: pointer;" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mar-top-25">
                                        <div class="col-sm-12">
                                            <div class="form-group text-left">
                                                <label class="sf-label">State/province issuing license</label>
                                                <div class="icon-input">
                                                    <div class="icon-box pwd-box">
                                                        <img src="images/ssn.png" alt="" />
                                                    </div>
                                                    <input type="text" class="form-control"
                                                        placeholder="State/province issuing license"
                                                        name="l_state" id="l_state" required />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mar-top-25">
                                        <div class="col-sm-12">
                                            <div class="form-group text-left">
                                                <label class="sf-label">Representative Country</label>
                                                <div class="icon-input">
                                                    <div class="icon-box pwd-box">
                                                        <img src="images/ssn.png" alt="" />
                                                    </div>
                                                    <input type="text" name="l_country" id="l_country"
                                                        class="form-control" placeholder="Country" required data-parsley-trigger="change" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row mar-top-25 only_102">
                                        <div class="col-sm-12">
                                            <div class="form-group text-left">
                                                <label class="sf-label">State/province of Business Incorporation</label>
                                                <div class="icon-input">
                                                    <div class="icon-box pwd-box">
                                                        <img src="images/ssn.png" alt="" />
                                                    </div>
                                                    <input type="text" class="form-control"
                                                        placeholder="State/province of Business Incorporation"
                                                        name="l_state_business" id="l_state_business" required />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mar-top-25 only_102">
                                        <div class="col-sm-12">
                                            <div class="form-group text-left">
                                                <label class="sf-label">State Registry Number</label>
                                                <div class="icon-input">
                                                    <div class="icon-box pwd-box">
                                                        <img src="images/ssn.png" alt="" />
                                                    </div>
                                                    <input type="text" class="form-control"
                                                        placeholder="State Registry Number"
                                                        name="l_state_number" id="l_state_number" required />
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- <div class="row mar-top-35">
                                        <div class="col-sm-12">
                                            <div class="form-inline form-group">
                                                <label class="pp-label">Where have you been referred
                                                    from?</label>
                                                <div class="w-100 d-flex mar-top-25 mar-btm-25">
                                                    <div class="radio">
                                                        <input type="text" id="gram" type="radio"
                                                            name="cg_refered_by" value="0">
                                                        <label for="gram">Web Search:</label>
                                                    </div>
                                                    <div class="radio">
                                                        <input type="text" id="kilos" type="radio"
                                                            name="cg_refered_by" checked="checked" value="1">
                                                        <label for="kilos">Linkedin</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div> -->
                                    
                                    {* <div class="row mar-top-25">
                                        <div class="col-sm-12">
                                            <div class="form-inline form-group">
                                                <label class="pp-label">Where have you been referred
                                                    from?</label>
                                                <div class="row w-100 mar-top-25 mar-btm-25">
                                                    <div class="col-sm-7 form-group">
                                                        <div class="radio">
                                                            <input id="web_search" type="radio"
                                                                name="cg_refered_by" value="1" {if $users.refered_by==1}checked{/if} {if $ref_data.id}disabled{/if}>
                                                            <label for="web_search">Web Search</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-5 form-group">
                                                        <div class="radio">
                                                            <input id="social" type="radio"
                                                                name="cg_refered_by" value="0" {if $users.refered_by==0}checked{/if} {if $ref_data.id}disabled{/if}>
                                                            <label for="social">Social Media</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-7 form-group">
                                                        <div class="radio">
                                                            <input id="buyer_referral" type="radio"
                                                                name="cg_refered_by" value="2" {if $users.refered_by==2}checked{/if} {if $ref_data.id}disabled{/if}>
                                                            <label for="buyer_referral">
                                                                HempBuyer Referral Partner
                                                                <span class="rinfo-info"><img src="/images/info.png" alt=""></span>
                                                                <span class="remail_info_text">
                                                                    <p>HempBuyer Referral Partners earn money with buyer referrals.<br><a href="/banners" target="_blank">Learn More</a></p>
                                                                </span>
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-7 form-group">
                                                        <div class="radio">
                                                            <input id="referral_affiliate" type="radio" name="cg_refered_by" value="4" {if $ref_data.id}checked{/if} {if $ref_data.id || $afcode==''}disabled{/if}>
                                                            <label for="referral_affiliate">
                                                                HempBuyer Referral Affiliate
                                                                <span class="rinfo-info"><img src="/images/info.png" alt=""></span>
                                                                <span class="remail_info_text">
                                                                    <p>You need to click on an affiliate link or banner so the referral code can be populated. Please go back to the referring website and click the link or banner before proceeding.</p>
                                                                </span>
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-5 form-group">
                                                        <div class="radio">
                                                            <input id="other" type="radio"
                                                                name="cg_refered_by" value="3" {if $users.refered_by==3}checked{/if} {if $ref_data.id}disabled{/if}>
                                                            <label for="other">Other</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="referred_error text-danger"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="col-sm-12" id="social_media_dropdown" style="display: none;">
                                            <div class="form-group">
                                                <div class="clearfix cselec-wrap">
                                                    <select class="custom-select" name="social_media" id="social_media">
                                                        <option value="linkedin">Linkedin</option>
                                                        <option value="facebook">Facebook</option>
                                                        <option value="twitter">Twitter</option>
                                                        <option value="instagram">Instagram</option>
                                                        <option value="other">Other</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-12" id="other_social_media" style="display: none; margin-top: 10px;">
                                            <div class="form-group">
                                                <div class="clearfix">
                                                    <input type="text" class="form-control" placeholder="Other Social Media" name="social_media_other" id="social_media_other" required="required" data-parsley-trigger="change">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row" id="buyer_referral_div" style="display: none;">
                                        <div class="col-sm-12" style="margin-top: 10px;">
                                            <div class="form-group">
                                                <div class="clearfix">
                                                    <input type="text" class="form-control" placeholder="Referral Full Name" name="ref_name" id="ref_name" required="required" data-parsley-trigger="change">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-12" style="margin-top: 10px;">
                                            <div class="form-group">
                                                <div class="clearfix" style="position: relative;">
                                                    <!-- <input class="form-control" placeholder="Phone Number" name="ref_phone" id="ref_phone" required="required" data-parsley-trigger="change"> -->
                                                    <input type="text" class="form-control" placeholder="Referral Email" name="ref_email" id="ref_email" required="required" data-parsley-trigger="change">
                                                    <span id="buyer_referral_status" style="right: -20px; top: 0px;"></span>
                                                    <span id="buyer_referral_error pull-left"></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-12" style="margin-top: 10px;">
                                            <div class="form-group">
                                                <div class="clearfix">
                                                    <input type="text" class="form-control" placeholder="Date of Registration" name="ref_date" id="ref_date" required="required" data-parsley-trigger="change" readonly>
                                                    <span id="buyer_referral_date"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row" id="referral_affiliate_div" style="{if !$ref_data.id}display: none;{/if}">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <div class="clearfix">
                                                    <input class="form-control" placeholder="Full Name" name="rf_name" id="rf_name" value="{$ref_data.name}" required="required" readonly data-parsley-trigger="change">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-12" style="margin-top: 10px;">
                                            <div class="form-group">
                                                <div class="clearfix">
                                                    <input class="form-control" placeholder="Referral Email" name="rf_email" id="rf_email" value="{$ref_data.email}" required="required" readonly data-parsley-trigger="change">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-12" style="margin-top: 10px;">
                                            <div class="form-group">
                                                <div class="clearfix">
                                                    <input class="form-control" placeholder="Referral Code" name="rf_code" id="rf_code" value="{$ref_data.code}" required="required" readonly data-parsley-trigger="change">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12" id="other_referral" style="display: none;">
                                            <div class="form-group" style="margin-top: 10px;">
                                                <div class="clearfix">
                                                    <input type="text" class="form-control" placeholder="Other Referral" name="ref_other" id="ref_other" required="required" data-parsley-trigger="change">
                                                </div>
                                            </div>
                                        </div>
                                    </div> *}

                                </div>

                                <div class="mar-top-35 mw-445">
                                    <div class="form-group clearfix">
                                        <div class="cus-check ">
                                            <input type="checkbox" id="im_interested" name="im_interested">
                                            <span class="checkmark"></span><label class="m-0" for="im_interested">I am interested in advertising with banner/square ads with you.</label>
                                        </div>
                                    </div>
                                    <div class="form-group clearfix">
                                        <div class="cus-check ">
                                            <input type="checkbox" id="i_have_read_open" name="i_have_read_open" required required data-parsley-mincheck="1" data-parsley-mincheck-message="This value is required.">
                                            <span class="checkmark"></span><label class="m-0" for="i_have_read_open">I have read and agree to abide by HempBuyer's Membership code of ethics.</label>
                                        </div>
                                    </div>

                                    <div class="form-group clearfix">
                                        <div class="cus-check ">
                                            <input type="checkbox" name="terms" required data-parsley-required="true"
                                                data-parsley-trigger="click" id="openTermConditionCheck" required data-parsley-mincheck="1" data-parsley-mincheck-message="This value is required.">
                                            <span class="checkmark"></span><label for="openTermConditionCheck">I accept Terms & Conditions</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="pt-3 d-flex" style="padding-bottom: 20px;">
                                    <button type="button" class="btn btn-secondary" onclick="goBack(2)">BACK</button>
                                    <button type="submit" class="btn btn-brown" id="signUpBtn">SIGN UP</button>
                                </div>
                            </div>
                        </div>
                    </div>
    </form>
</div>

 <!-- HB CODE OF ETHICS Modal -->
 <div class="modal fade hb-modal" id="hbEthics" data-backdrop="static" data-keyboard="false" tabindex="-1"
 aria-labelledby="hbEthicsModalLabel" aria-hidden="true">
 <div style="padding: 0; transform: translate(0,0)" class="static-cont modal-dialog modal-dialog-centered modal-lg modal-dialog-scrollable">
     <div class="modal-content">
         <div class="modal-header">
         <img src="{$config.url}/images/logo.png" class="m-auto" />
             {* <h5 class="modal-title" id="hbEthicsModalLabel">Values, Ethics & Conduct</h5> *}
             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                 <span aria-hidden="true">&times;</span>
             </button>
         </div>
         <div class="modal-body">
             <div class="media-body" id='escrow'>
             <div class="media static-cont" style="padding-top: 0">
                <div class="about-us">
                <div class="media-body" style="padding: 15px">
                <h1>HEMPBUYER CORE VALUES</h1>
                <ol>
                    <li>The right thing to do is always the right thing to do.</li>
                    <li>Our members benefit before we do.</li>
                    <li>Always be respectful of people's resources, large or small.</li>
                    <li>Treat our members as valued human beings.</li>
                    <li>Our success is measured through the experience of creating value and facilitating the success of others.</li>
                    <li>Our mission is to transform the world and the lives of others through the work we do.</li>
                    <li>Always finish what you start; when you make a promise, keep it.</li>
                    <li>Conduct business with courage, joy and fun; a warrior's spirit and a servant”s heart.</li>
                    <li>Make an impact, leave the earth, people and all of life better than you found them.</li>
                    <li>Do as much good as you can.</li>
                </ol>

                <h1>ETHICS STATEMENT</h1>
                <p>HempBuyer serves the hemp industries worldwide through those who share our mission of honesty, professionalism, integrity, character and compassion.</p>

                <h1>HEMPBUYER AUCTION CODE OF CONDUCT </h1>
                <p>HEMPBUYER AUCTION MEMBERS ARE COMMITTED AND  AGREE TO:</p>

                <ol>
                    <li>Members agree to treat others with respect, dignity and fairness: as they would want to be treated and conversely to not treat members in a way they would not want to be treated.  We agree to hold ourselves to a higher ethical standard for both ourselves and the industry.</li>
                    <li>Members shall act with integrity by adhering to the letter and spirit of Hempbuyer core values and code of conduct.</li>
                    <li>Members' conduct shall positively reflect themselves, their profession, Hempbuyer and the industries we serve.</li>
                    <li>Members offering  or providing goods or services shall do so only in a manner consistent  with applicable law and under terms and conditions that are timely and accurately described to others.</li>
                    <li>Members offering  or providing goods or services shall do so only in a manner consistent  with applicable law and under terms and conditions that are timely and accurately described to others.</li>
                    <li> Members shall not solicit or communicate with others through deceptive or unfair communications or in any manner inconsistent with applicable law.</li>
                    <li>Members shall only represent goods and services that they have the legal and ethical rights to offer.</li>
                    <li>Members shall describe their range of services and products with honesty and accuracy.</li>
                    <li>Members shall accurately represent their professional qualifications, licenses and certifications.</li>
                    <li>Members shall make a good-faith effort to resolve concerns received from customers about the products and services they offer or provide to them. </li>
                    <li>Members shall neither accept nor condone the actions of other members that are inconsistent with this Code of Conduct. Members knowledgeable about potential material violations of this Code of Conduct agree to bring them to the attention of HempBuyer Auction</li>
                    <li>Members shall not intentionally mislead other members as to the pertinent facts relating to a transaction, including quality, quantity, test results, standard operating procedures, closing costs, or associated fees.</li>
                    <li>Members shall not engage in conduct involving dishonesty, fraud, deceit or misrepresentation, or knowingly make false or misleading statements to a client, employer, employee, professional colleague, government or other regulatory body or official or any other person or entity. </li>
                    <li>Members shall interact with a manner that reflects positively on the reputation of the industry.</li>
                    <li>Members shall agree to uphold and abide by the HempBuyer Code of Ethics.</li>
                </ol>

            </div>
            <div class="form-group clearfix pl-4">
            <div class="cus-check ">
                <input type="checkbox" id="i_have_read" name="i_have_read" required required data-parsley-mincheck="1" data-parsley-mincheck-message="This value is required.">
                <span class="checkmark"></span><label class="m-0" for="i_have_read">I have read and agree to
                abide by HempBuyer's Membership code of ethics.</label>
            </div>
        </div>
                </div> 
         </div>
             </div>
         </div>
     </div>
 </div>
</div>
<div class="modal fade hb-modal" id="hbEthics1" data-backdrop="static" data-keyboard="false" tabindex="-1"
aria-labelledby="hbEthicsModalLabel" aria-hidden="true">
<div style="padding: 0; transform: translate(0,0)" class="static-cont modal-dialog modal-dialog-centered modal-lg modal-dialog-scrollable">
    <div class="modal-content">
        <div class="modal-header">
        <img src="{$config.url}/images/logo.png" class="m-auto" />
            {* <h5 class="modal-title" id="hbEthicsModalLabel">Values, Ethics & Conduct</h5> *}
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body">
            <div class="media-body" id='escrow'>
            <div class="media static-cont" style="padding-top: 0">
               <div class="about-us">
               <div class="media-body" style="padding: 15px">
               <h1>HEMPBUYER CORE VALUES</h1>
               <ol>
                   <li>The right thing to do is always the right thing to do.</li>
                   <li>Our members benefit before we do.</li>
                   <li>Always be respectful of people's resources, large or small.</li>
                   <li>Treat our members as valued human beings.</li>
                   <li>Our success is measured through the experience of creating value and facilitating the success of others.</li>
                   <li>Our mission is to transform the world and the lives of others through the work we do.</li>
                   <li>Always finish what you start; when you make a promise, keep it.</li>
                   <li>Conduct business with courage, joy and fun; a warrior's spirit and a servant”s heart.</li>
                   <li>Make an impact, leave the earth, people and all of life better than you found them.</li>
                   <li>Do as much good as you can.</li>
               </ol>

               <h1>ETHICS STATEMENT</h1>
               <p>HempBuyer serves the hemp industries worldwide through those who share our mission of honesty, professionalism, integrity, character and compassion.</p>

               <h1>HEMPBUYER AUCTION CODE OF CONDUCT </h1>
               <p>HEMPBUYER AUCTION MEMBERS ARE COMMITTED AND  AGREE TO:</p>

               <ol>
                   <li>Members agree to treat others with respect, dignity and fairness: as they would want to be treated and conversely to not treat members in a way they would not want to be treated.  We agree to hold ourselves to a higher ethical standard for both ourselves and the industry.</li>
                   <li>Members shall act with integrity by adhering to the letter and spirit of Hempbuyer core values and code of conduct.</li>
                   <li>Members' conduct shall positively reflect themselves, their profession, Hempbuyer and the industries we serve.</li>
                   <li>Members offering  or providing goods or services shall do so only in a manner consistent  with applicable law and under terms and conditions that are timely and accurately described to others.</li>
                   <li>Members offering  or providing goods or services shall do so only in a manner consistent  with applicable law and under terms and conditions that are timely and accurately described to others.</li>
                   <li> Members shall not solicit or communicate with others through deceptive or unfair communications or in any manner inconsistent with applicable law.</li>
                   <li>Members shall only represent goods and services that they have the legal and ethical rights to offer.</li>
                   <li>Members shall describe their range of services and products with honesty and accuracy.</li>
                   <li>Members shall accurately represent their professional qualifications, licenses and certifications.</li>
                   <li>Members shall make a good-faith effort to resolve concerns received from customers about the products and services they offer or provide to them. </li>
                   <li>Members shall neither accept nor condone the actions of other members that are inconsistent with this Code of Conduct. Members knowledgeable about potential material violations of this Code of Conduct agree to bring them to the attention of HempBuyer Auction</li>
                   <li>Members shall not intentionally mislead other members as to the pertinent facts relating to a transaction, including quality, quantity, test results, standard operating procedures, closing costs, or associated fees.</li>
                   <li>Members shall not engage in conduct involving dishonesty, fraud, deceit or misrepresentation, or knowingly make false or misleading statements to a client, employer, employee, professional colleague, government or other regulatory body or official or any other person or entity. </li>
                   <li>Members shall interact with a manner that reflects positively on the reputation of the industry.</li>
                   <li>Members shall agree to uphold and abide by the HempBuyer Code of Ethics.</li>
               </ol>

           </div>
           <div class="form-group clearfix pl-4">
           <div class="cus-check ">
               <input type="checkbox" id="i_have_read1" name="i_have_read1" required required data-parsley-mincheck="1" data-parsley-mincheck-message="This value is required.">
               <span class="checkmark"></span><label class="m-0" for="i_have_read1">I have read and agree to
               abide by HempBuyer's Membership code of ethics.</label>
           </div>
       </div>
               </div> 
        </div>
            </div>
        </div>
    </div>
</div>
</div>
<!-- HB CODE OF ETHICS Modal End -->

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
                    WELCOME
                </div>
                <button class="btn btn-prev" data-dismiss="modal" onclick="redirect_success()">
                    THANK YOU
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade hb-modal" id="reg-question" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content" style="overflow: auto; height: 500px;">
            <div class="modal-header">  
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button> -->
            </div>
            <div class="modal-body"> 
                <h4 class="text-center">Please Provide Authentication Details!</h4>
               <div id="authDiv"></div>
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

                    if ($("#terms-accept").css("display") == "block") {
                        $("#terms-accept").modal('hide')
                    }
                    
                }
            });
        });
    
</script>

<div class="modal fade hb-modal" id="reg-error" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" /> 
            </div>
            <div class="modal-body">

                <h4 class="text-center">Something Went Wrong!</h4>
                <div class="lsc-msg">
                    <img src="./images/user-icon.png" alt="user">
                </div>
                <h3 class="lsc-msg" id="errorMsgModal"></h3>
                <h5 class="text-center mb-4">HBA uses LexisNexis® Risk Solutions for KYC (know your customer) verification services.</h5>

                <button class="btn btn-prev" data-dismiss="modal">
                    Edit Registration
                </button>
                <div class="text-center mb-3">Or</div>
                <div class="text-center">call us at <a href='tel:1-800-420-4196' style="text-transform: none;" class=''><i class="fas fa-phone-alt"></i> 1-800-420-4196</a> or email <a href='mailto:support@hempbuyer.com' style="text-transform: none;" class=''><i class="fas fa-envelope"></i> support@hempbuyer.com</a></div>
            </div>
        </div>
    </div>
</div>


<div class="modal fade hb-modal" id="terms-accept" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" /> 
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body" style="max-height: 400px; overflow: auto;">
                <h4 class="text-center">I ACCEPT TERMS & CONDITIONS</h4>
                <div class="ss-txt" style="padding: 15px;">
                This Agreement constitutes a legally binding agreement between each User and HempBuyer.

                This Terms and Conditions Agreement (hereinafter, this “Agreement”) outlines the basis and manner in which HempBuyer is willing to provide Users (as hereinafter defined) with access to, and use of Services (as defined hereinafter). As used in this Agreement, the term “Services” shall mean, collectively, the following: (1) providing an online platform for Users to buy and sell industrial hemp, (2) assisting Users with making and receiving payment for transactions conducted through HempBuyer’s Website (www.hempbuyer.com) (hereinafter, the “Website”), and (3) the other services described in this Agreement.
                
                HempBuyer may make changes to any part of this Agreement at any time with notice to the Users. When such a change is proposed, HempBuyer will notify all Users of that change, as well as the date that the change will take effect.
                
                Each Account (as defined hereinafter) and User is responsible for ensuring that it (and all of its Accounts and Users) have read, understood, and acknowledge this Agreement and future revisions.
                
                By continuing to access and use the Services, each User represents that it accepts, and agrees to be bound by, the latest version of the Agreement. If, following any such change or amendment, any User who no longer agrees to be bound by this Agreement (as amended) must notify HempBuyer in writing and, upon HempBuyer’s receipt of such written notice, agree to discontinue its use of the Services. Any such notice must be provided to @ admin@hempbuyer.com.
                </div>
                <div class="form-group clearfix m-0">
                    <div class="cus-check " style="display: inline-block;">
                        <input type="checkbox" name="terms" id="checkTermCondition" required data-parsley-required="true"
                            data-parsley-trigger="click">
                        <span class="checkmark"></span><label for="checkTermCondition">I accept Terms & Conditions</label>
                    </div>
                </div>
                <!-- <button class="btn btn-prev" data-dismiss="modal">
                    THANK YOU
                </button> -->
            </div>
        </div>
    </div>
</div>
<div class="modal fade hb-modal" id="terms-accept1" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" /> 
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body" style="max-height: 400px; overflow: auto;">
                <h4 class="text-center">I ACCEPT TERMS & CONDITIONS</h4>
                <div class="ss-txt" style="padding: 15px;">
                This Agreement constitutes a legally binding agreement between each User and HempBuyer.

                This Terms and Conditions Agreement (hereinafter, this “Agreement”) outlines the basis and manner in which HempBuyer is willing to provide Users (as hereinafter defined) with access to, and use of Services (as defined hereinafter). As used in this Agreement, the term “Services” shall mean, collectively, the following: (1) providing an online platform for Users to buy and sell industrial hemp, (2) assisting Users with making and receiving payment for transactions conducted through HempBuyer’s Website (www.hempbuyer.com) (hereinafter, the “Website”), and (3) the other services described in this Agreement.
                
                HempBuyer may make changes to any part of this Agreement at any time with notice to the Users. When such a change is proposed, HempBuyer will notify all Users of that change, as well as the date that the change will take effect.
                
                Each Account (as defined hereinafter) and User is responsible for ensuring that it (and all of its Accounts and Users) have read, understood, and acknowledge this Agreement and future revisions.
                
                By continuing to access and use the Services, each User represents that it accepts, and agrees to be bound by, the latest version of the Agreement. If, following any such change or amendment, any User who no longer agrees to be bound by this Agreement (as amended) must notify HempBuyer in writing and, upon HempBuyer’s receipt of such written notice, agree to discontinue its use of the Services. Any such notice must be provided to @ admin@hempbuyer.com.
                </div>
                <div class="form-group clearfix m-0">
                    <div class="cus-check " style="display: inline-block;">
                        <input type="checkbox" name="terms" id="checkTermCondition1" required data-parsley-required="true"
                            data-parsley-trigger="click">
                        <span class="checkmark"></span><label for="checkTermCondition1">I accept Terms & Conditions</label>
                    </div>
                </div>
                <!-- <button class="btn btn-prev" data-dismiss="modal">
                    THANK YOU
                </button> -->
            </div>
        </div>
    </div>
</div>

<div class="modal fade hb-modal" id="download_verification_form" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" /> 
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">
                <h4 class="text-center">AUTHORIZED REPRESENTATIVE FORM</h4>
                <div class="ss-txt">
                    <p>For a representative to administrate your account, authorization is required. Please upload your signed authorization form or E-sign our "Authorized Representative Form" here: <a target="_blank" href="https://docs.hempbuyer.com/authorized-business-representative-form/">Sign the form</a></p>
                    <p>You may also email your document/form to: admin@hempbuyer.com</p>
                    <p>If you have questions, please call 800-420-4196</p>
                    <p>Your account may need additional  review and approval to be complete.</p>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade hb-modal" id="download_license_form" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered modal-lg modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" /> 
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body" style="max-height: 400px; overflow: auto;">
                
                <h4 class="text-center">EXEMPTION FROM LICENSE FORM INFORMATION</h4>
                <div class="ss-txt">
                    
                    <p>LICENSE EXEMPTION</p>

                    <p>What happens if I don't have a hemp industry license? Can I still attain an account?</p>
                    <p>Yes, HBA may grant a license exemption. Exemptions are considered on a case by case basis.</p>
                    <p>Most exemptions are granted for ancillary providers and participants, who are not required to have a hemp industry license or states/countries that have certain exempt categories for hemp and hemp products.</p>
                    <p>Please note, if an exemption is requested, your renewal date will be 1 year from date of issuance of exemption and you will be required to resubmit and resign the code of conduct for HBA at renewal time.</p>
                    <p>If you do not have a license, you are required to provide evidence of your business. Upload evidence of your business.</p>

                    <p>Acceptable documents include:</p>
                    <p>1. Business license</p>
                    <p>2. Seller's Permit</p>
                    <p>3. EIN document</p>
                    <p>IMPORTANT: All documents must from a government agency, be legible and clear.</p>
                    <p>You may also email your documents to: admin@hempbuyer.com. If you have questions, please call 800-420-4196</p>
                </div>
            </div>
        </div>
    </div>
</div>

<input type="button" class="btn btn-brown" data-toggle="modal" hidden id="successBtn" data-target="#reg-success">


<script>
function redirect_success() {
    window.location.href = '/market';
}
$(document).ready(function(){
    if('{$ref_data.id}') {
        $('#step2_form').find('[name="cg_refered_by"]').trigger("change");
        $('#step3_form').find('[name="cg_refered_by"]').trigger("change");
    }
    $('.cg_ssn').mask('000-00-0000');
    $('.l_issue_date').mask('00-00-0000', { placeholder: '12-31-1974' });
    $('.license_date').mask('00-00-0000', { placeholder: '12-31-1974' });
    $('.cg_rep_ssn').mask('000-00-0000');
    $('.cg_ein').mask('00-0000000');
    $('.phone_us').mask('+1 (000) 000-0000');
    $('#ref_phone').mask('+1 (000) 000-0000');
    $("input[name='cg_dob']").mask('00-00-0000', { placeholder: '12-31-1974' });
    //$('#cg_rep_phone').mask('+1 (000) 000-0000');
    $('#ind_auth_rep_tab #cg_rep_phone').mask('+1 (000) 000-0000');
    $('#pills-contact #cg_rep_phone').mask('+1 (000) 000-0000');
    var today = new Date();
    var dates = (today.getMonth()>9 ? '' : '0') + (today.getMonth()+1) + '-' + today.getDate() + '-' + today.getFullYear();
    /* setTimeout(() => {
        $("#ref_date").val(dates);
    }, 1000); */
    /* Start Fill data for text */
    /* $("#cg_username").val('dfg');
    $("#cg_email").val('google@gmail.com');
    $("#password").val('123456');
    $("#password_confirm").val('123456'); */

    /* End Fill data for text */

    $(document).on('change', 'input[name="cg_refered_by"]', function(){
        $(".referred_error").html("");
        var type = $(this).val();
        console.log('type', type);
        var form = '#'+$(this).closest("form").attr("id")+' ';
        console.log('form', form);
        $(form+"#ref_other").val("");
        $(form+"#social_media_other").val("");
        $(form+"#ref_name").val("");
        $(form+"#ref_email").val("");
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
            $(form+"#ref_date").val(dates);
        } else if(type == '3') {
            $(form+"#other_referral").slideDown();
        } else if(type == '4') {
            $(form+"#referral_affiliate_div").slideDown();
        }
    });
    $(document).on('change', '#step2_form #social_media, #step3_form #social_media', function(){
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
        var form = '#'+$(this).closest("form").attr("id")+' ';
        if(value == 'other') {
            $(form+"#other_license_type").slideDown();
        } else {
            $(form+"#other_license_type").slideUp();
        }
    });
    $(document).on('change', '#license_requested', function(){
        var checked = $(this).prop('checked');
        console.log('checked', checked);
        if(checked) {
            $('#step3_form').parsley().destroy();
            $('#step3_form').find('input[type=text],select').each(function () {
                $(this).removeAttr('required');
                $(this).trigger('change');
            });
        } else {
            $('#step3_form').find('input[type=text],select').each(function () {
                $(this).attr('required', 'true')
                $(this).trigger('change');
            });
        }
    });
    

    $(document).on('change keyup', '#step2_form #ref_email, #step3_form #ref_email', function(){
        var value= $(this).val();
        var form = '#'+$(this).closest("form").attr("id")+' ';
        verify_referral(value, form);
    });

    $(document).on('change', '#openTermConditionCheck', function(){
        if($("#openTermConditionCheck").prop("checked") == true) {
            $('#terms-accept').modal();
            $("#openTermConditionCheck").prop("checked", false);
        } else {
            $("#checkTermCondition").prop("checked", false);
        }
    });
    $(document).on('change', '#checkTermCondition', function(){
        if($(this).prop("checked")) {
            $("#openTermConditionCheck").prop("checked", "checked");
            $('#terms-accept').modal('toggle');
        } else {
            $("#openTermConditionCheck").prop("checked", false);
        }
    });
    $("#terms-accept").on('shown.bs.modal', function(){
        $("#terms-accept").find(".modal-body").scrollTop(0);
    });
    $(document).on('change', '#openTermConditionCheck1', function(){
        if($("#openTermConditionCheck1").prop("checked") == true) {
            $('#terms-accept1').modal();
            $("#openTermConditionCheck1").prop("checked", false);
        } else {
            $("#checkTermCondition1").prop("checked", false);
        }
    });
    $(document).on('change', '#checkTermCondition1', function(){
        if($(this).prop("checked")) {
            $("#openTermConditionCheck1").prop("checked", "checked");
            $('#terms-accept1').modal('toggle');
        } else {
            $("#openTermConditionCheck1").prop("checked", false);
        }
    });
    $("#terms-accept1").on('shown.bs.modal', function(){
        $("#terms-accept1").find(".modal-body").scrollTop(0);
    });

    $(document).on('change', '#i_have_read_open', function(){
        if($("#i_have_read_open").prop("checked") == true) {
            $('#hbEthics').modal();
            $("#i_have_read_open").prop("checked", false);
        } else {
            $("#i_have_read").prop("checked", false);
        }
    });
    $(document).on('change', '#i_have_read', function(){
        if($(this).prop("checked")) {
            $("#i_have_read_open").prop("checked", "checked");
            $('#hbEthics').modal('toggle');
        } else {
            $("#i_have_read").prop("checked", false);
        }
    });
    $("#hbEthics").on('shown.bs.modal', function(){
        $("#hbEthics").find(".modal-body").scrollTop(0);
    });
    $(document).on('change', '#i_have_read_open1', function(){
        if($("#i_have_read_open1").prop("checked") == true) {
            $('#hbEthics1').modal();
            $("#i_have_read_open1").prop("checked", false);
        } else {
            $("#i_have_read1").prop("checked", false);
        }
    });
    $(document).on('change', '#i_have_read1', function(){
        if($(this).prop("checked")) {
            $("#i_have_read_open1").prop("checked", "checked");
            $('#hbEthics1').modal('toggle');
        } else {
            $("#i_have_read1").prop("checked", false);
        }
    });
    $("#hbEthics1").on('shown.bs.modal', function(){
        $("#hbEthics1").find(".modal-body").scrollTop(0);
    });
    
    var currentTab = 0; // Current tab is set to be the first tab (0)
    $(document).on('submit', '.user_form', function (e) {
        console.log('user_form');
        e.preventDefault();
        var step = +($(this).attr('id').split('_')[0])[4];
        console.log('$("#step" + step + "_form").parsley().validate()', $("#step" + step + "_form").parsley().validate());
        if ($("#step" + step + "_form").parsley().validate()) {
            if ($("#emsg").hasClass("intro")) {
                return false;
            }
            if(step == 1 && $('#step' + step + '_form input[name="cg_refered_by"]:checked').length < 1) {
                $(".referred_error").html("This value is required.");
                return true;
            }
            // if (true) {

            storeLocalData(step);
            if (step != 2 || userType != 100) {

                if (step == 1) {
                    var dataobj = {
                        cg_email: $('#cg_email').val()
                    };
                    //$('#cg_email2').val($('#cg_email').val());
                    $.ajax({
                        type: "POST",
                        url: "{$config.url}/user/checkmail",
                        data: dataobj,
                        success: function (data) {
                            if (data.email === 'Y') {
                                // $('#cg_email').val('');
                                $('#emsg').show();
                                $("#emsg").addClass("intro");
                                var a = {};
                                a["color"] = "red";
                                // a["padding-left"]="224px";
                                a["font-size"] = "13px";
                                $('#emsg').html('Email already exist, please use different!').css(
                                    a);
                                $("#cg_email").focus();
                            } else {
                                $('#cg_email2').val($('#cg_email').val());
                                $('#emsg').hide();
                                $("#emsg").removeClass("intro");
                                gotoStep(step + 1);
                            }
                        }
                    });

                    var dataobj = {
                        username: $('#cg_username').val()
                    };
                    $.ajax({
                        type: "POST",
                        url: "{$config.url}/user/checkusername",
                        data: dataobj,
                        success: function (data) {
                            if (data.username === 'Y') {
                                // $('#cg_username').val('');
                                $('#umsg').show();
                                var a = {};
                                a["color"] = "red";
                                // a["padding-left"]="224px";
                                a["font-size"] = "13px";
                                $('#umsg').html('Username already exist, please use different!').css(
                                    a);
                                $("#cg_username").focus();
                            } else {
                                $('#umsg').hide();
                                gotoStep(step + 1);
                            }
                        }
                    });
                    // checkemail($('#cg_email').val())
                } else {
                    if (step == 2 && userType != 100)
                        gotoStep(step + 1);
                    else
                        saveUser();

                }
            } else {
                saveUser();
            }
        } else {
            $("#step" + step + "_form").parsley().validate();
            return true;
        }
    });
});

    function gotoStep(step) {

        $(".step-item").removeClass('active');
        $(".steps-wrapper").find('div').removeClass('active');
        $(".step_data").hide();

        for (let index = 1; index <= step; index++) {
            $('#step' + index + '_data #cg_email2').val($('#cg_email').val());

            $("#step" + (index - 1) + "_data").hide();
            $("#step" + index + "_data").show();
            $(".step" + (index - 1)).addClass('active');
            $(".step" + index).find('div').addClass('active');
        }
        window.scrollTo({ top: 200, behavior: 'smooth' });
    }



    /* Start save data to localStorage */
    function storeLocalData(step) {
        var elements = [];
        // $('#step'+step+'_form input, #step'+step+'_form select, #step'+step+'_form textarea').each(
        $('.user_form input, .user_form select, .user_form textarea').each(
            function (index) {
                var input = $(this);
                var name = input.attr('name');
                var type = input.attr('type') ? input.attr('type') : (input[0].selectedIndex != undefined ?
                    'select' : 'text');
                var val = input.val();
                if (type == 'checkbox' || type == 'radio') {
                    val = input.prop('checked');
                } else if (type == 'file') {
                    if (name == 'certificateDocument') {
                        val = certificates;
                    } else if (name == 'productDocument') {
                        val = productDocument;
                    }
                }
                var obj = {
                    type: type,
                    id: input.attr('id'),
                    name: name,
                    value: val
                };
                elements.push(obj);
            }
        );
        localStorage.setItem('draftedUser', JSON.stringify(elements));
        console.log('elements', elements);
    }
    /* End save data to localStorage */

    function checkusername(username) {
        // console.log(email)
        $('#umsg').hide();
        if(username.trim() == '') {
            return true;
        }
        var dataobj = {
            username: username
        };
        $.ajax({
            type: "POST",
            url: "{$config.url}/user/checkusername",
            data: dataobj,
            success: function (data) {
                if (data.username === 'Y') {
                    // $('#cg_email').val('');
                    $('#umsg').show();
                    var a = {};
                    a["color"] = "red";
                    // a["padding-left"]="224px";
                    a["font-size"] = "13px";
                    $('#umsg').html('Username already exist, please use different!').css(a);

                } else {
                    $('#umsg').hide();
                }
            }
        });
    }
    function checkemail(email) {
        // console.log(email)
        $('#emsg').hide();
        if(email.trim() == '') {
            return true;
        }
        var dataobj = {
            cg_email: email
        };
        $.ajax({
            type: "POST",
            url: "{$config.url}/user/checkmail",
            data: dataobj,
            success: function (data) {
                if (data.email === 'Y') {
                    // $('#cg_email').val('');
                    $('#emsg').show();
                    $("#emsg").addClass("intro");
                    var a = {};
                    a["color"] = "red";
                    // a["padding-left"]="224px";
                    a["font-size"] = "13px";
                    $('#emsg').html('Email already exist, please use different!').css(a);

                } else {
                    $('#emsg').hide();
                    $("#emsg").removeClass("intro");
                }
            }
        });
    }

    var referal_verified = 0;
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
                        $(form+"#buyer_referral_error").html('The user not exist in our system.');
                        $(form+"#buyer_referral_error").removeClass('text-success');
                        $(form+"#buyer_referral_error").addClass('text-danger');
                        $(form+"#ref_email").focus();
                    }
                }
            });
        }
    }

    /* Start Upload File */
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
    /* End Upload File */

    var dt = new Date();
    var pastYear = dt.getFullYear() - 18;
    dt.setFullYear(pastYear);
    console.log(dt);
    
   $(".nt-cdate").datetimepicker({
        'format': 'm-d-Y',
        'formatDate': 'm-d-Y',
        'pickTime': false,
        'timepicker': false,
        'datepicker': true,
        'defaultDate': new Date(dt),
        'maxDate': new Date(dt),
        'endDate': new Date(dt),
        'closeOnDateSelect': true,
        'validateOnBlur': true,
        constrainInput: false,
        scrollMonth: false,
        yearEnd: new Date(dt).getFullYear(),
        scrollInput: false,
        onClose: function () {
            var bdate = $('#cg_bdate').val();

            //console.log(bdate,redate)
            // if (bdate.length > 0) {
            //     var x = 'parsley-id-' + document.getElementById("cg_bdate").getAttribute('data-parsley-id');
            //     document.getElementById(x).style.display = "none";
            // }

        },
        onChangeDateTime: function (dp, $input) {
            console.log('called', $(this).datetimepicker)
            var curDate = new Date(dp);
            var maxDate = new Date(dt);
            var minDate = new Date('1919    /01/01');
            maxDate.setDate(maxDate.getDate() + 1); // add one day
            maxDate.setHours(0, 0, 0, 0); // clear time portion for correct results
            if (curDate > maxDate) {
                // alert("Invalid date");
                $input.val(convertDate(maxDate))
            }
            if (curDate < minDate) {
                // alert("Invalid date");
                $input.val(convertDate(maxDate))
            }
        }
    });
    $(".license_date").datetimepicker({
        'format': 'm-d-Y',
        'formatDate': 'm-d-Y',
        'pickTime': false,
        'timepicker': false,
        'datepicker': true,
        'defaultDate': new Date(),
        'minDate': new Date(),
        // 'endDate': new Date(),
        'closeOnDateSelect': true,
        'validateOnBlur': true,
        constrainInput: false,
        scrollMonth: false,
        // yearEnd: new Date().getFullYear(),
        scrollInput: false,
        onClose: function () {
        }
    });
    $(".l_issue_date").datetimepicker({
        'format': 'm-d-Y',
        'formatDate': 'm-d-Y',
        'pickTime': false,
        'timepicker': false,
        'datepicker': true,
        'defaultDate': new Date(),
        // 'minDate': new Date(),
        // 'endDate': new Date(),
        'closeOnDateSelect': true,
        'validateOnBlur': true,
        constrainInput: false,
        scrollMonth: false,
        // yearEnd: new Date().getFullYear(),
        scrollInput: false,
        onClose: function () {
        }
    });

    userType = 100;
    function setUser(id) {
        userType = id;
        if(userType == 101) {
            $(".only_102").hide();
        } else {
            $(".only_102").show();
        }
        console.log('userType', userType);
        document.getElementById('step2_form').reset();
        $('#form1').trigger("reset");
        $('#form2').trigger("reset");
        $('#form3').trigger("reset");
        $("#pills-tab1").find('a').addClass('disabled');
        $(".nav_"+userType).removeClass('disabled');
        $(".nav_"+userType).trigger('click');

        $(":input").each(function () {
            $(this).attr('data-parsley-trigger', 'change');
        });

        if (id == 101) {
            $("#individual_user_tab :input").each(function () {
                $(this).removeAttr('required')
            });

            $("#pills-contact :input").each(function () {
                $(this).removeAttr('required')
            });

            $("#ind_auth_rep_tab :input").each(function () {
                $(this).attr('required', 'true')
            });

            $(".auth-shead").html("LICENSE DATA, EXEMPTION FORM & AUTHORIZED REPRESENTATIVE FORM");
            $(".auth-ctxt").html("");

            $('#ind_auth_rep_tab #cg_email2').val($('#step1_form #cg_email').val());
        }


        if (id == 100) {
            $("#individual_user_tab :input").each(function () {
                $(this).attr('required', 'true')
            });

            $("#pills-contact :input").each(function () {
                $(this).removeAttr('required')
            });

            $("#ind_auth_rep_tab :input").each(function () {
                $(this).removeAttr('required')
            });

            $(".auth-shead").html("LICENSE DATA & EXEMPTION FORM");
            $(".auth-ctxt").html("");

            $('#individual_user_tab #cg_email2').val($('#step1_form #cg_email').val());
        }

        if (id == 102) {
            $("#individual_user_tab :input").each(function () {
                $(this).removeAttr('required')
            });

            $("#ind_auth_rep_tab :input").each(function () {
                $(this).removeAttr('required')
            });

            $("#pills-contact :input").each(function () {
                $(this).attr('required', 'true')
            });

            $(".auth-shead").html("LICENSE DATA, EXEMPTION FORM & AUTHORIZED REPRESENTATIVE FORM");
            $(".auth-ctxt").html("");

            $('#pills-contact #cg_email').val($('#step1_form #cg_email').val());
        }

        $("input[name='cg_refered_by']").each(function () {
            $(this).removeAttr('required')
        });
        $(".cg_business_name").each(function () {
            $(this).removeAttr('required')
        });
    }

    function submitAuthentication(){
        $('#reg-question').modal('hide');

$('[name="cg_refered_by"]').attr('disabled', false);
        var steps = userType==100 ? 2 : 3;
        var form = '#step'+steps+'_form ';

        if(!referal_verified && $(form+"#buyer_referral").prop("checked")) {
            $(form+"#ref_email").focus();
            return true;
        }
var formArray = [];
        for (let index = 1; index <= steps; index++) {
            var innerDiv = '';
            if(index == 2) { innerDiv=' #form'+userType+' *'; }
            console.log('innerDiv', innerDiv, index);
            var formArr = $("#step" + index + "_form"+innerDiv).serializeArray();
            console.log('formArr', formArr);
            formArray = formArray.concat(formArr);
        }

        var productObj = {};
        var productData = formArray ? formArray : [];
        if (productData.length) {
            for (var index = 0; index < productData.length; index++) {
                const element = productData[index];
                productObj[productData[index].name] = productData[index].value;
            }
        }
        productObj['user_type'] = userType;
        Object.assign(productObj, uploadedFiles);
        // productObj['productDocument'] = productDocument;
        // productObj['certificatesDocument'] = certificates;

        $.ajax({
            method: "POST",
            url: '/user/signupAuthentication',
            data: { lexisDt : $('#lexisForm').serialize(), formDt : productObj },
            dataType: 'JSON',
            cache: false,
            success: function (data) {
                console.log('data', data);
                if (data.status == 200) {
                    // $('#successBtn').click();
                    $('#reg-success').modal()
                    document.getElementById('step2_form').reset();
                    $("#social_media_dropdown").slideUp();
                    $("#other_social_media").slideUp();
                    $("#other_referral").slideUp();
                    $("#license_text").html("");
                }
                 else if (data.status == 400) {

                    $('#errorMsgModal').html(data.info);
                    $('#reg-error').modal()
                    // alert('Something wend wrong, please check details!')
                }
            }
        });

    }
    function saveUser() {
        $('[name="cg_refered_by"]').attr('disabled', false);
        var steps = userType==100 ? 2 : 3;
        var form = '#step'+steps+'_form ';

        if(!referal_verified && $(form+"#buyer_referral").prop("checked")) {
            $(form+"#ref_email").focus();
            return true;
        }
        console.log('$(input[name="cg_refered_by"]).prop("checked")', $('input[name="cg_refered_by"]').prop("checked"));
        if(steps == 1 && $(form+'input[name="cg_refered_by"]:checked').length < 1) {
            $(".referred_error").html("This value is required.");
            return true;
        }
        $(".referred_error").html("");


        var formArray = [];
        for (let index = 1; index <= steps; index++) {
            var innerDiv = '';
            if(index == 2) { innerDiv=' #form'+userType+' *'; }
            console.log('innerDiv', innerDiv, index);
            var formArr = $("#step" + index + "_form"+innerDiv).serializeArray();
            console.log('formArr', formArr);
            formArray = formArray.concat(formArr);
        }

        var productObj = {};
        var productData = formArray ? formArray : [];
        if (productData.length) {
            for (var index = 0; index < productData.length; index++) {
                const element = productData[index];
                productObj[productData[index].name] = productData[index].value;
            }
        }
        productObj['user_type'] = userType;
        Object.assign(productObj, uploadedFiles);
        // productObj['productDocument'] = productDocument;
        // productObj['certificatesDocument'] = certificates;

        $.ajax({
            method: "POST",
            url: '/user/signup',
            data: productObj,
            dataType: 'JSON',
            cache: false,
            success: function (data) {
                console.log('data', data);
                if (data.status == 200) {

                    $('#authDiv').html(data.info);
                    $('#reg-question').modal()
                    return;
                    
                }

                else if (data.status == 400) {

                    $('#errorMsgModal').html(data.info);
                    $('#reg-error').modal()
                    // alert('Something wend wrong, please check details!')
                }
            }
        });
    }
    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode != 46 && charCode > 31
        && (charCode < 48 || charCode > 57))
            return false;

        return true;
    }
    function goBack(gostep)  {
        $(".step_data").hide();
        $("#step"+gostep+"_data").show();
        window.scrollTo({ top: 200, behavior: 'smooth' });
    }
</script>

<style>
    .formClass {
        max-width: 456px;
        padding: auto;
        margin: auto;
    }
    body {
        padding-right: 0px !important;
    }
    #download_license_form p, #download_verification_form p {
        text-align: left;
        margin: 0px;
    }
</style>