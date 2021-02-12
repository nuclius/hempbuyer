
{include file="common/header-1.tpl" nocache}

<style type="text/css">
  form.registration-form fieldset {
  display: none;
}
</style>
<!--Section1 start Here-->
<section class="reg-bg disflx">
   <div class="container mrato reg-bg-clr" data-aos="zoom-in">
      <h3>User Details</h3>
        <div class="ront-lin">
            <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
            <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
            <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
            <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
            <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
        </div>
        <br>
        {$externaljs}
        <span class="err-message">{$error}</span>
        <div class="reg-instl">
            <form action="/register/save" method="POST" id="registration_form" class="registration-form" enctype="multipart/form-data" data-parsley-validate onsubmit="return checkTerms();">

<!-- Step 1 -->
<fieldset>
                  <div class="row">
                      <div class="col-md-6">

                      <!-- Business name -->

                            <div class="input-group">

                              <!-- <input type="text" class="form-control" id="business_name" name="business_name" placeholder="Business Name" value="{$registerdata.business_name}"> -->

                              <input data-parsley-trigger="change focusout"  class="form-control" type="text" name="business_name"
                                   data-parsley-required-message="Please enter Business Name" placeholder="Business Name" class="form-control" data-required="true" data-parsley-pattern="^[A-Za-z0-9 ]*$" pattern="^[A-Za-z0-9 ]*$" data-parsley-pattern-message="Invalid buisness name." data-parsley-group="block1" data-parsley-required data-parsley-errors-container="#business_name-err" data-parsley-group="block1"/>

                              <span class="input-group-addon" id="basic-addon2"><i class="flaticon-bank-building"></i></span>
                            </div>
                            <span id="business_name-err" class="err-message"></span>
                        </div>
                        <div class="col-md-6">
                                          <!-- Phonn number here -->
                            <div class=" input-group">
                              <!-- <input data-parsley-trigger="change focusout" type="text" class="form-control" id="phone" name="phone" placeholder="Phone" value="{$registerdata.phone}"> -->
                                   <input class="form-control" data-parsley-trigger="change focusout"  type="text" id="phone" data-mask="000-000-0000" name="phone" placeholder="Phone" data-parsley-minlength="12" data-parsley-minlength-message="Enter the 10 digit phone number"
                                    data-parsley-required-message="Please enter Phone Number" class="form-control"
                                    data-required="true" data-parsley-required
                                    data-parsley-errors-container="#phone-err" data-parsley-group="block1"/>
                                    <!-- <input data-parsley-trigger="change focusout" class="form-control" type="text" id="phone" name="phone" placeholder="Phone"
                                    data-parsley-type="number" data-parsley-type="Enter the 10 digit phone number"
                                    maxlength="10"
                                    data-parsley-required-message="Please enter Phone Number" class="form-control"
                                    data-parsley-maxlength="10" data-parsley-maxlength-message="Enter the 10 digit phone number"
                                    data-parsley-minlength="10" data-parsley-minlength="Enter the 10 digit phone number"
                                    data-required="true" data-parsley-required
                                    data-parsley-group="block1" data-parsley-errors-container="#phone-err" data-parsley-group="block1"/> -->
                              <span class="input-group-addon" id="basic-addon2"><i class="flaticon-auricular-phone-symbol-in-a-circle"></i></span>
                            </div>
                            <span id="phone-err" class="err-message"></span>
                        </div>
                    </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">
                        <!-- <input data-parsley-trigger="change focusout" type="text" class="form-control" id="username" name="username" placeholder="Username" value="{$registerdata.username}"> -->

                        <input data-parsley-trigger="change focusout" class="form-control" type="text" id="username" name="username"
                               data-parsley-required-message="Please enter Username" placeholder="Username" class="form-control"
                               data-required="true" data-parsley-required
                               data-parsley-pattern="^[A-Za-z0-9]*$"
                               pattern="^[A-Za-z0-9]*$" data-parsley-pattern-message="Invalid username!"
                               data-parsley-group="block1"
                               data-parsley-errors-container="#username-err" data-parsley-group="block1"/>
                          <span class="input-group-addon" id="basic-addon2"><i class="flaticon-user"></i></span>
                        </div>
                        <span id="username-err" class="err-message"></span>
                        <span id="username-check-err" class="err-message"></span>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                        <!-- <input data-parsley-trigger="change focusout" type="email" class="form-control" name="email" id="email" placeholder="Email" value="{$registerdata.email}"> -->
                        <input data-parsley-trigger="change focusout" class="form-control" type="email" id="email" name="email"
                               data-parsley-required-message="Please enter Email ID" placeholder="Business Email" class="form-control"
                               data-required="true" data-parsley-required
                               data-parsley-group="block1"
                               data-parsley-errors-container="#email-register-err" data-parsley-group="block1"/>
                          <span class="input-group-addon" id="basic-addon2"><i class="flaticon-email"></i></span>
                        </div>
                        <span id="email-register-err" class="err-message"></span>
                        <span id="email-check-err" class="err-message"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">
                        <input data-parsley-trigger="change focusout" type="password" class="form-control" id="password" name="password" placeholder="Password" value="" data-parsley-required-message="Please enter Password" data-parsley-minlength="6" data-parsley-minlength="Password should at least 6 characters"  data-required="true" data-parsley-required data-parsley-errors-container="#password-register-err" data-parsley-group="block1">
                          <span class="input-group-addon" id="basic-addon2"><i class="flaticon-key"></i></span>
                        </div>
                        <span id="password-register-err" class="err-message"></span>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                        <input data-parsley-trigger="change focusout" type="password" class="form-control" id="cpassword" name="cpassword" placeholder="Confirm Password" value="" data-parsley-required-message="Please enter Password to confirm" data-parsley-equalto="#password" data-required="true" data-parsley-required data-parsley-errors-container="#cpassword-err" data-parsley-group="block1">
                          <span class="input-group-addon" id="basic-addon2"><i class="flaticon-confirm"></i></span>
                        </div>
                        <span id="cpassword-err" class="err-message"></span>
                    </div>
                </div>
                <input data-parsley-trigger="change focusout" type="hidden" name="count" id="count" value=1 />
              <div class="row fields">
                <div id="field1" class="col-md-12 pos-rlt bg-add">

                    <a id="add-more" class="add-more" onclick="addContact()" ><i class="fa fa-plus-circle pos-rit"  aria-hidden="true"></i></a>

                    <div class="row">
                      <div class="col-md-6">
                          <div class="input-group">
                          <input data-parsley-trigger="change focusout" type="text" class="form-control" id="fname0" placeholder="First Name" name="contacts[0][fname]" data-parsley-minlength="3" data-parsley-minlength-message="please enter a minimum of 3 characters." data-parsley-pattern="^[A-Za-z]*$"
                                 pattern="^[A-Za-z]*$" data-parsley-required-message="Please enter First Name" data-required="true" data-parsley-required data-parsley-errors-container="#fname0-err" data-parsley-group="block1">
                            <span class="input-group-addon" id="basic-addon2"><i class="flaticon-user"></i></span>
                          </div>
                          <span id="fname0-err" class="err-message"></span>
                      </div>
                      <div class="col-md-6">
                          <div class="input-group">
                          <input data-parsley-trigger="change focusout" type="text" class="form-control" id="lname0" placeholder="Last Name"  name="contacts[0][lname]"  data-parsley-pattern="^[A-Za-z]*$"
                                 pattern="^[A-Za-z]*$" data-parsley-required-message="Please enter Last Name" data-required="true" data-parsley-required data-parsley-errors-container="#lname0-err" data-parsley-group="block1">
                            <span class="input-group-addon" id="basic-addon2"><i class="flaticon-user"></i></span>
                          </div>
                          <span id="lname0-err" class="err-message"></span>
                      </div>
                    </div>

                    <div class="row">
                      <div class="col-md-6">
                          <div class="input-group">
                          <input data-parsley-trigger="change focusout" class="form-control" type="text"
                                  name="contacts[0][phone]" id="phone0" placeholder="Phone"
                                  data-mask="000-000-0000"
                                  data-parsley-minlength="12" data-parsley-minlength-message="Enter the 10 digit phone number"
                                  data-parsley-notequalto="#phone"
                                  data-required="true" data-parsley-required
                                  data-parsley-group="block1" data-parsley-errors-container="#phone0-err"/><!--  <input data-parsley-trigger="change focusout" class="form-control" type="text" name="contacts[0][phone]" id="phone0" placeholder="Phone"
                                  data-parsley-type="number" data-parsley-type="Enter the 10 digit phone number"
                                  maxlength="10"
                                  data-parsley-required-message="Please enter Phone Number" class="form-control"
                                  data-parsley-maxlength="10" data-parsley-maxlength-message="Enter the 10 digit phone number"
                                  data-parsley-minlength="10"
                                  data-parsley-notequalto="#phone"
                                  data-parsley-minlength="Enter the 10 digit phone number"
                                  data-required="true" data-parsley-required
                                  data-parsley-group="block1" data-parsley-errors-container="#phone0-err"/> -->

                                    <!-- <input data-parsley-trigger="change focusout" type="text" class="form-control" id="phone0" placeholder="Direct Phone" name="contacts[0][phone]" data-parsley-required-message="Please enter valid phone number" data-required="true" data-parsley-required data-parsley-errors-container="#phone0-err" data-parsley-group="block1"> -->
                            <span class="input-group-addon" id="basic-addon2"><i class="flaticon-auricular-phone-symbol-in-a-circle"></i></span>
                          </div>
                          <span id="phone0-err" class="err-message"></span>
                       </div>
                      <div class="col-md-6">
                          <div class="input-group">
                          <input data-parsley-trigger="change focusout" type="email" class="form-control" id="email0" placeholder="Email" name="contacts[0][email]" data-parsley-required-message="Please enter valid Email" data-required="true" data-parsley-required data-parsley-errors-container="#email0-err" data-parsley-group="block1" data-parsley-notequalto="#email">
                            <span class="input-group-addon" id="basic-addon2"><i class="flaticon-email"></i></span>
                          </div>
                          <span id="email0-err" class="err-message"></span>
                      </div>
                    </div>

                </div>
                </div>
                        <div class="clearfix"></div>
                        <div class="text-right" style="margin-top: 15px">
                            <!-- <button type="button" class="btn btn-next">Next</button> -->
                            <button type="button" class="btn btn-next btn-grn">Next <i class="fa flaticon-arrow-point-to-right"></i></button>
                            <!-- <button type="button" class="btn btn-previous">Previous</button> -->
                            <!--                                 <button type="submit" class="btn btn-grn">Submit<i class="flaticon-arrow-point-to-right"></i></button> -->
                        </div>
                    <div class="text-center">
                        <ul class="pagination">
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link btn-next" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                        </ul>
                    </div>
                    </fieldset>
                    <!-- Step 2 -->
          <fieldset>

               <div class="col-md-12 pdlr0">
                  <p class="ship-hed">Shipping Info <small><span class="pull-right err-message">{$reg_error}</span></small></p>
                </div>

                <div class="row">
                  <div class="col-md-12 form-group">
                      <textarea class="form-control" name="shipping_address" rows="4" id="shipping_address" placeholder="Address" data-parsley-required-message = "shipping address required" data-parsley-required data-parsley-trigger="keyup" data-parsley-minlength="10" data-parsley-maxlength="100"  data-parsley-pattern="^[a-zA-Z0-9,\n ]*$" pattern="^[a-zA-Z0-9,\n ]*$" data-parsley-pattern-message="Invalid Address" data-parsley-minlength-message="Required minimum 10 characters" data-parsley-validation-threshold="10" data-parsley-group="block2" data-parsley-errors-container="#shipping_address-err" ></textarea>
                      <span id="shipping_address-err" class="err-message"></span>
                      <!-- <textarea id="message" class="form-control" name="message" ></textarea> -->
                    </div>
                  <div class="col-md-6">
                        <div class="form-group">
                        <select class="form-control" name="shipping_country" id="shipping_country" data-parsley-required-message="Please select country" place-holder="Select country" data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#shipping_country-err">
                            <option value="">Select country</option>
                        </select>
                        <span id="shipping_country-err" class="err-message"></span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                        <select class="form-control" name="shipping_state" id="shipping_state"  data-parsley-required data-parsley-required-message="Please select state" place-holder="Select state"  data-parsley-required data-parsley-group="block2">
                                <option value="">Select state</option>
                            </select>
                        <span id="shipping_state-err" class="err-message"></span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">

                        <input data-parsley-trigger="change focusout" class="form-control" placeholder="City" id="shipping_city" name="shipping_city" data-parsley-required class="form-control" type="text" data-parsley-required-message="Please enter city" data-parsley-pattern="^[A-Za-z]*$" pattern="^[A-Za-z]*$" class="form-control" data-required="true"  data-parsley-pattern="^[a-zA-Z ]*$" pattern="^[a-zA-Z ]*$" data-parsley-pattern-message="Invalid city"  data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#shipping_city-err"/>
                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                         <span id="shipping_city-err" class="err-message"></span>
                    </div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <select class="form-control" name="shipping_region" id="shipping_region"  data-parsley-required data-parsley-required-message="Please select region" place-holder="Select Region"  data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#shipping_region-err">
                                <option value="">Region</option>
                                <option value="north west">North West</option>
                                <option value="south west">South West</option>
                                <option value="north east">North East</option>
                                <option value="south east">South East</option>
                            </select>
                          <span id="shipping_region-err" class="err-message"></span>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">
                        <input data-parsley-trigger="change focusout" class="form-control" id="shipping_zip" type="text" name="shipping_zip"  data-parsley-required class="form-control"
                          maxlength="6"
                          data-parsley-maxlength="6" data-parsley-maxlength-message="Enter the 5-6 character zip code"
                          data-parsley-minlength="5" data-parsley-minlength-message="Enter the 5-6 character zip code" data-parsley-required-message="Please enter zip code" placeholder="Zip Code" class="form-control" data-required="true" data-parsley-group="block2" data-parsley-required data-parsley-errors-container="#shipping_zip-err"/>
                          <!-- <input data-parsley-trigger="change focusout" class="form-control" id="shipping_zip" type="text" name="shipping_zip"  data-parsley-required class="form-control"
                          maxlength="6"
                          data-parsley-maxlength="6" data-parsley-maxlength-message="Enter the 5-6 character zip code"
                          data-parsley-minlength="5" data-parsley-minlength-message="Enter the 5-6 character zip code" data-parsley-required-message="Please enter zip code" placeholder="Zip Code" class="form-control" data-required="true" data-parsley-group="block2" data-parsley-required data-parsley-errors-container="#shipping_zip-err"/> -->
                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="shipping_zip-err" class="err-message"></span>
                    </div>
                </div>
                <div class="col-md-12 pdlr0 mrtp30">
                  <p class="ship-hed">Billing Info</p>
                </div>

<!--                 <div class="row">
                  <div class="col-md-12 form-group"> -->
<!--                       <div class="radio radio-inline radio-primary pull-left">
                        <input data-parsley-trigger="change focusout" type="radio" name="billing_type" id="radio1" value="card">
                          <label for="radio1"> Credit / Debit Card </label>
                        </div> -->
<!--                         <div class="radio radio-inline radio-primary">
                        <input data-parsley-trigger="change focusout" type="radio" name="billing_type" id="radio2" value="bank"  checked="checked">
                          <label for="radio2"> Bank Account information</label>
                        </div>
                    </div>
                  </div> -->
                <!-- <div id="card_details" hidden>
                  <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">
                        <input data-parsley-trigger="change focusout" class="form-control" id="cardholder_name" name="cardholder_name" data-parsley-required class="form-control" type="text" data-parsley-required-message="Please enter name on card" placeholder="Name on Card" class="form-control" data-required="true" data-parsley-required  data-parsley-group="block2" data-parsley-errors-container="#cardholder_name-err"/>

                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="cardholder_name-err" class="err-message"></span>
                    </div>
                    <div class="col-md-6">
                        <div class=" input-group">
                         <input data-parsley-trigger="change focusout" class="form-control" id="card_number" name="card_number" data-parsley-required class="form-control"
                          type="text"
                          data-mask="0000 0000 0000 0000"
                          data-parsley-minlength="19" data-parsley-minlength-message="Enter the 16 digit card number"
                         data-parsley-required-message="Please enter card number" placeholder="Card Number" class="form-control" data-required="true" data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#card_number-err"/>

                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="card_number-err" class="err-message"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">

                         <input data-parsley-trigger="change focusout" class="form-control" id="cvv_number" name="cvv_number" data-parsley-required class="form-control" type="text" data-parsley-type="number" data-parsley-required-message="Please enter CVV number"
                         minlength="3"
                         data-mask="000"
                         data-parsley-minlength="3" data-parsley-minlength-message="CVV number should be 3 digits"
                         placeholder="CCV Number" class="form-control" data-required="true" data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#cvv_number-err"/>
                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="cvv_number-err" class="err-message"></span>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                         <input data-parsley-trigger="change focusout" class="form-control" id="expiry_date" name="expiry_date" data-parsley-required class="form-control" type="text"
                         data-mask="00/00"
                         data-parsley-minlength="5" data-parsley-minlength-message="date should be in format of (MM/YY)"
                         data-parsley-pattern = "^(1[0-2]|0[1-9]|\d)\/(20\d{2}|19\d{2}|0(?!0)\d|[1-9]\d)$"
                         data-parsley-required-message="Please enter expiry date" placeholder="Expiration Date (MM/YY)" class="form-control" data-required="true" data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#expiry_date-err"/>
                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="expiry_date-err" class="err-message"></span>
                    </div>
                </div>
                  </div> -->
                  <div id="bank_details">
                <div class="row">
                  <div class="col-md-6">
                        <div class="input-group">
                        <input data-parsley-trigger="change focusout" class="form-control" name="bank_name" data-parsley-required class="form-control" type="text" data-parsley-required-message="Please enter bank name" placeholder="Bank Name" class="form-control" data-parsley-required  data-parsley-group="block2" data-parsley-errors-container="#bank_name-err"/>
                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="bank_name-err" class="err-message"></span>
                    </div>
                    <div class="col-md-6">
                        <div class=" input-group">
                          <input data-parsley-trigger="change focusout" class="form-control" name="account_number" data-parsley-required class="form-control" type="text" data-parsley-type="number" data-parsley-required-message="Please enter bank account number" placeholder="Bank Account Number" class="form-control" data-required="true" data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#account_number-err"/>
                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="account_number-err" class="err-message"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">
                         <input data-parsley-trigger="change focusout" class="form-control" name="account_name" data-parsley-required class="form-control" type="text" data-parsley-required-message="Please enter bank account name" placeholder="Bank Account Name" class="form-control" data-required="true" data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#account_name-err"/>
                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="account_name-err" class="err-message"></span>
                    </div>
                    <div class="col-md-6">
                    <div class="form-group">
                        <select class="form-control" name="account_type" id="account_type"  data-parsley-required data-parsley-required-message="Please select account type" place-holder="Select Account type"  data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#account_type1-err">
                            <option value="">Account Type</option>
                            <option value="checking">Checking</option>
                            <option value="saving">Saving</option>
                          </select>

                      </div>
                      <span id="account_type1-err" class="err-message"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">
                         <input data-parsley-trigger="change focusout" class="form-control" name="routing_number" data-parsley-type="number" data-parsley-required class="form-control" type="text" data-parsley-required-message="Please enter routing number" placeholder="Routing number" class="form-control" data-required="true" data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#routing_number-err"/>
                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="routing_number-err" class="err-message"></span>
                    </div>
                </div>
                </div>
                <div class="row text-left mr-cklab mrbt10">
                       <div class="checkbox">
                          <label>
                            <input data-parsley-trigger="change focusout" type="checkbox" id="check_address" name="check_address">
                            <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                            Same as shipping address
                          </label>
                        </div>
                </div>

                <div class="row">
                  <div class="col-md-12 form-group">
                        <textarea class="form-control" name="billing_address" rows="4" id="billing_address" placeholder="Address" data-parsley-required-message = "billing address required" data-parsley-required data-parsley-trigger="keyup" data-parsley-minlength="10" data-parsley-maxlength="100" data-parsley-pattern="^[a-zA-Z0-9,\n ]*$" pattern="^[a-zA-Z0-9,\n ]*$" data-parsley-pattern-message="Invalid Address" data-parsley-minlength-message="Required minimum 10 characters" data-parsley-validation-threshold="10" data-parsley-group="block2" data-parsley-errors-container="#billing_address-err"></textarea>
                        <span id="billing_address-err" class="err-message" ></span>
                    </div>
                  <div class="col-md-6">
                        <div class="form-group">

                          <select class="form-control" name="billing_country" id="billing_country" data-parsley-required-message="Please select country" data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#billing_country-err">
                              <option value="">Select country</option>
                          </select>
                          <span id="billing_country-err" class="err-message"></span>

                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                          <select class="form-control" name="billing_state" id="billing_state" data-parsley-required-message="Please select state" data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#billing_state-err">
                                  <option value="">Select state</option>
                          </select>
                          <span id="billing_state-err" class="err-message"></span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">
                          <input data-parsley-trigger="change focusout" class="form-control" id="billing_city" name="billing_city" data-parsley-required class="form-control" type="text" placeholder="City" data-parsley-required-message="Please enter city" class="form-control" data-required="true"  data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#billing_city-err"/>
                          <!-- <input data-parsley-trigger="change focusout" class="form-control" placeholder="city" name="billing_city" value="{$shipping.city}"  data-parsley-required> -->
                        <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="billing_city-err" class="err-message"></span>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                        <input data-parsley-trigger="change focusout" class="form-control" name="billing_zip" id="billing_zip"  data-parsley-required class="form-control" type="text" data-parsley-required-message="Please enter zip code" placeholder="Zip Code" class="form-control" data-required="true" data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#billing_zip-err" data-parsley-maxlength="6" data-parsley-maxlength-message="Enter the 5-6 character zip code" maxlength="6"
                          data-parsley-minlength="5" data-parsley-minlength-message="Enter the 5-6 character zip code" />
                        <!-- <input data-parsley-trigger="change focusout" type="text" class="form-control" name="billing_zip" id="exampleInputEmail1" placeholder="Zip Code"> -->
                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="billing_zip-err" class="err-message"></span>
                    </div>
                </div>
                    <div class="text-right">
                        <button type="button" class="btn btn-previous btn-grn"><i class="fa flaticon-arrow-point-to-right fa-flip-horizontal"></i> Previous</button>
                        <button type="button" class="btn btn-next btn-grn">Next<i class="flaticon-arrow-point-to-right"></i></button>

                        <!--                                 <button type="submit" class="btn btn-grn">Submit<i class="flaticon-arrow-point-to-right"></i></button> -->
                    </div>
                    <div class="text-center">
                        <ul class="pagination">
                            <li class="page-item"><a class="page-link btn-previous" onclick="">1</a></li>
                            <li class="page-item active"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link btn-next" href="#">3</a></li>
                        </ul>
                    </div>
                    </fieldset>
                    <!-- step 3 -->
                    <fieldset>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                          <select class="form-control" name="business_type" id="business_type" data-parsley-required-message="Please select Business type" place-holder="Business Type" data-parsley-required data-parsley-group="block3" data-parsley-errors-container="#business_type-err">
                          <!-- <select class="form-control" id="business_type"> -->
                          <!-- 'grower','producer','dispensary','supplier' -->
                            <option value="">Business Type</option>
                            <option value="grower">Grower</option>
                            <option value="producer">Producer</option>
                            <option value="dispensary">Dispensary</option>
                            <option value="supplier">Supplier</option>
                          </select>

                        </div>
                        <span id="business_type-err" class="err-message"></span>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                          <input data-parsley-trigger="change focusout" class="form-control" name="ein_number" data-parsley-required class="form-control" type="text" data-parsley-required-message="Please enter EIN number" placeholder="EIN N0." class="form-control" data-required="true" data-parsley-group="block3" data-parsley-required data-parsley-group="block3" data-parsley-errors-container="#ein_number-err"/>
                       <!--  <input data-parsley-trigger="change focusout" type="text" class="form-control" id="ein_number" > -->
                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="ein_number-err" class="err-message"></span>
                    </div>
                </div>

                <div class="row mrbt15 text-left">
                    <div class="col-md-6 text-center">
                      <label class="lab-clr"> Upload Licence Here</label>
                        <div class="reg_file_upload">
                          <input data-parsley-trigger="change focusout" type="file" id="licenses" name="licenses" data-parsley-required-message="Please Upload License" data-parsley-errors-container="#lic_img-err" data-parsley-fileextension='jpg jpeg gif png' required/>
                        </div>
                        <div style="overflow: hidden;" class="mt-15">
                        <img id="license" src="{$config.url}/images/no_img.png" height="100px" style="margin: auto; display: block;" />
                        </div>
                        <button type="button" class="btn btn-grn wid100 fnt14 mt-15" onclick="chooseLic();">Upload</button>
                        <span id="lic_img-err" class="err-message"></span>
                    </div>
                    <div class="col-md-6 text-center">
                      <label class="lab-clr"> Upload Business Certificate Here</label>
                        <div class="reg_file_upload">
                          <input data-parsley-trigger="change focusout" type="file" id="certificates" name="certificates" data-parsley-required-message="Please Upload Certificate"  data-parsley-errors-container="#cert_img-err" required data-parsley-fileextension='jpg jpeg gif png' required/>
                        </div>
                        <div style="overflow: hidden;" class="mt-15">
                          <img id="certificate" src="{$config.url}/images/no_img.png" height="100px" style="margin: auto; display: block;" />
                        </div>

                        <button type="button" class="btn btn-grn wid100 fnt14 mt-15" onclick="chooseCert();">Upload</button>
                        <span id="cert_img-err" class="err-message"></span>
                    </div>
                    <!-- <div class="col-md-6">
                      <label class="lab-clr"> Upload Business Certificate Here</label>
                        <input data-parsley-trigger="change focusout" type="file" class="btn btn-grn wid100 fnt14">Upload
                    </div> -->
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">
                          <input data-parsley-trigger="change focusout" type="text" class="form-control" id="ref_code" placeholder="Referal Code (If Any)" value="{$loged.ref}" name="referals">
                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                    </div>
<!--                     <div class="col-md-6 form-group text-left ">
                        <label class="lab-clr"> Transaction Notification</label>
                          <div>
                            <div class="radio radio-inline radio-primary pull-left">
                            <input data-parsley-trigger="change focusout" type="radio" name="trans_notification" id="trans_notification1" value="email" checked>
                            <label for="trans_notification1"> Email </label>
                            </div>
                          <div class="radio radio-inline radio-primary">
                            <input data-parsley-trigger="change focusout" type="radio" name="trans_notification" id="trans_notification2" value="text">
                          <label for="trans_notification2"> Text </label>
                          </div>
                        </div>
                    </div> -->
                </div>

<!--                 <div class="row text-left mr-cklab mrbt10">
                   <div class="checkbox">
                      <label>
                        <input data-parsley-trigger="change focusout" type="checkbox" name="product_offer"  id="product_offer" checked="y" unchecked="n">
                        <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                        Would you like to be notified of new product offers?
                      </label>
                    </div>
                </div> -->
                <div class="row text-left mr-cklab mrbt10">
   <!--                 <div class="checkbox"> -->
<!--                       <label> -->
<!--                         <input data-parsley-trigger="change focusout" type="checkbox" name="sell_offer" id="sell_offer" checked="y" unchecked="n"> -->
                        <!-- <span class="cr"><i class="cr-icon fa fa-check"></i></span> -->

                        <div class="col-md-12 form-group form-inline text-left ">
                            <label class="lab-clr">Would you like to be notified of new product offers?</label>
                              <!-- <div> -->
                              <div class="radio radio-inline radio-primary ">
                                <input data-parsley-trigger="change focusout" type="radio" name="product_offer" id="product_offer1" value="y">
                                <label for="product_offer1"> Yes </label>
<!--                               </div>
                              <div class="radio radio-inline radio-primary"> -->
                                <input data-parsley-trigger="change focusout" type="radio" name="product_offer" id="product_offer2" value="n">
                                <label for="product_offer2"> No </label>
                              </div>
                              <!-- </div> -->
                        </div>
                        <div class="col-md-12 form-group form-inline text-left ">
                            <label class="lab-clr">Would you like to add sales tax?</label>
                              <!-- <div> -->
                              <div class="radio radio-inline radio-primary ">
                                <input data-parsley-trigger="change focusout" type="radio" name="stax" id="stax1" value="y">
                                <label for="stax1"> Yes </label>
<!--                               </div>
                              <div class="radio radio-inline radio-primary"> -->
                                <input data-parsley-trigger="change focusout" type="radio" name="stax" id="stax2" value="n">
                                <label for="stax2"> No </label>
                              </div>
                              <!-- </div> -->
                        </div>
                        <div class="col-md-12 form-group form-inline text-left ">
                            <label class="lab-clr">Enter the sales tax</label>
                        <div class="input-group">
                          <input data-parsley-trigger="change focusout" class="form-control" name="stax_per" data-parsley-required class="form-control" type="text" data-parsley-required-message="Please enter EIN number" placeholder="EIN N0." class="form-control" data-required="true" data-parsley-group="block3" data-parsley-required data-parsley-group="block3" data-parsley-errors-container="#stax_per-err"/>
                       <!--  <input data-parsley-trigger="change focusout" type="text" class="form-control" id="stax_per" > -->
                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="stax_per-err" class="err-message"></span>
                        </div>
<!--                       </label> -->
<!--                     </div> -->
                </div>
                <div class="col-md-12 pslr0 text-left mr-cklab mrbt10 scall">
                <div class="scrl" id="style-1">
                  Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="row text-left mr-cklab mrbt10 ">
                  <div class="agree_terms check_opt">
                   <div class="checkbox">
                      <label>
                        <!-- <input data-parsley-trigger="change focusout" type="checkbox" value=""> -->
                        <input data-parsley-trigger="change focusout" type="checkbox" name="agree" value="1" id="agree"/>&nbsp;
                        <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                        I have accepted the <a target="_blank" href="{$config.url}/terms">terms and conditions</a>
                      </label>
                    </div>
                    </div>
                </div>
                        <div class="text-right">
                            <!-- <button type="button" class="btn btn-next">Next</button> -->
                            <button type="button" class="btn btn-previous btn-grn"><i class="fa flaticon-arrow-point-to-right fa-flip-horizontal"></i> Previous</button>
                            <button type="submit" class="btn btn-grn">Submit<i class="flaticon-arrow-point-to-right"></i></button>
                        </div>
                    <div class="text-center">
                        <ul class="pagination">
                            <li class="page-item"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link btn-previous" href="#">2</a></li>
                            <li class="page-item active"><a class="page-link" href="#">3</a></li>
                        </ul>
                    </div>
                    </fieldset>
                    <!-- End forms -->
<!--                     <div class="text-right">
                        <button type="submit" class="btn btn-grn">Submit<i class="flaticon-arrow-point-to-right"></i></button>
                    </div> -->

                </form>
        </div>
    </div>
</section>
<!--Section1 end Here-->


{include file="common/footer-1.tpl" nocache}
<!-- <script src='https://www.google.com/recaptcha/api.js'></script> -->
<script src="{$config['externaljs']}scripts.js" type="text/javascript"></script>

<script>
    $(function () {
        var ctry = '{$shipping.country}';
        if (ctry != '')
            $('#shipping_country').val(ctry);
            $('#billing_country').val(ctry);
    });

    $(function () {
        ////console.log("{$users}");
        populateCountries("billing_country", "billing_state");
        populateCountries("shipping_country", "shipping_state");
        var ctry = '{$users.country}';
        if (ctry != '')
            $('#shipping_country').val(ctry);
            $('#billing_country').val(ctry);
        loadState();
    });
</script>
<script>
$('#check_address').change(function() {

        if($('#check_address').prop("checked")){

          $('#billing_address').val($('#shipping_address').val());
          $('#billing_country').val($('#shipping_country').val()).change();
          $('#billing_state').val($('#shipping_state').val()).change();
          $('#billing_city').val($('#shipping_city').val());
          $('#billing_zip').val($('#shipping_zip').val());
      $('#registration_form').parsley().validate("block2");
        }else{
           $('#billing_address').val('');
           $('#billing_country').val('');
           $('#billing_state').val('');
           $('#billing_city').val('');
           $('#billing_zip').val('');
           $('#registration_form').parsley().validate("block2");
        }
      $('#registration_form').parsley().validate("block2");
    });

</script>

<script>
  window.ParsleyValidator.addValidator('notequalto',
    function (value, requirement) {
        return value !== $(requirement).val();
    }, 32)
    .addMessage('en', 'notequalto', 'This values should not be the same.');


    window.ParsleyValidator.addValidator('fileextension', function (value, requirement) {
            var fileExtension = value.split('.').pop();
                var arr = requirement.split(" ");
                for (var i = 0; i < arr.length; i++) {
                  if(arr[i] === fileExtension){
                    return fileExtension === arr[i];
                  }
                }

        }, 32)
        .addMessage('en', 'fileextension', 'Image format allows only(jpg, jpeg, png)');

  function addContact() {

    var next = 1;

   //console.log("add-more clicked");

        next = parseInt($("#count").val());
        next = next + 1;

        ////console.log(next);
       //console.log($("#count").val(next));


        prev = next-1;
        nprev = prev - 1;

       //console.log("next"+next);
       //console.log("prev"+prev);

        // $("#field"+prev+" a").removeClass("add-more").addClass("remove-contact");
        // $("#field"+prev+" a i").removeClass("fa-plus-circle").addClass("fa-minus-circle");
        // $('#field'+prev+' #add-more').remove();
        var field = "\#field"+next;

        ////console.log(field);
        // $('#field'+prev).prepend('<a id="remove-contact" class="remove-contact"  onclick=removeContact(\"'+field+'\")><i class="fa fa-minus-circle pos-rit"  aria-hidden="true"></i></a>');
          ////console.log('<a id="remove-contact" class="remove-contact"  onclick=removeContact(\''+field+'\')><i class="fa fa-minus-circle pos-rit"  aria-hidden="true"></i></a>');

        var newIn = '<div id="field'+next+'" class="col-md-12 pos-rlt bg-add"><a id="remove-contact" class="remove-contact" onclick=removeContact(\"'+field+'\")><i class="fa fa-minus-circle pos-rit" aria-hidden="true"></i></a><div class="col-md-6 pdlf0"><div class="input-group"> <input data-parsley-trigger="change focusout" type="text" class="form-control" id="fname'+prev+'" placeholder="First Name" name="contacts['+prev+'][fname]"  data-parsley-required-message="Please enter First Name" data-parsley-pattern="^[A-Za-z]*$" pattern="^[A-Za-z]*$" data-required="true" data-parsley-required data-parsley-group="block1" data-parsley-errors-container="#fname'+prev+'-err"> <span class="input-group-addon" id="basic-addon2"><i class="flaticon-user"></i></span></div><span id="fname'+prev+'-err" class="err-message"></span></div> <div class="col-md-6 pdrt0"> <div class="input-group"> <input data-parsley-trigger="change focusout" type="text" class="form-control" id="lname'+prev+'" placeholder="Last Name"  name="contacts['+prev+'][lname]"  data-parsley-required-message="Please enter Last Name" data-required="true" data-parsley-required  data-parsley-group="block1" data-parsley-errors-container="#lname'+prev+'-err"><span class="input-group-addon" id="basic-addon2"><i class="flaticon-user"></i></span> </div> <span id="lname'+prev+'-err" class="err-message"></span></div> <div class="col-md-6 pdlf0"><div class="input-group"><input data-parsley-trigger="change focusout" class="form-control" type="text" data-mask="000-000-0000" data-parsley-minlength="12" data-parsley-minlength-message="Enter the 10 digit phone number" name="contacts['+prev+'][phone] id="phone'+prev+'" placeholder="Phone" data-parsley-type="number" data-parsley-required-message="Please enter Phone Number" class="form-control" data-parsley-notequalto="#phone" data-required="true" data-parsley-required data-parsley-group="block1" data-parsley-errors-container="#phone'+prev+'-err"/> <span class="input-group-addon" id="basic-addon2"><i class="flaticon-auricular-phone-symbol-in-a-circle"></i></span> </div><span id="phone'+prev+'-err" class="err-message"></span></div><div class="col-md-6 pdrt0"><div class="input-group"><input data-parsley-trigger="change focusout" type="email" class="form-control" id="email'+prev+'" placeholder="Email" name="contacts['+prev+'][email]" data-parsley-notequalto="#email" data-parsley-required-message="Please enter valid Email" data-required="true" data-parsley-required data-parsley-group="block1" data-parsley-errors-container="#email'+prev+'-err"><span class="input-group-addon" id="basic-addon2"><i class="flaticon-email"></i></span></div><span id="email'+prev+'-err" class="err-message"></span></div></div>';

        /*'<input data-parsley-trigger="change focusout" class="form-control" type="text" data-mask="000-000-0000" maxlength="10"  name="contacts['+prev+'][phone] id="phone'+prev+'" placeholder="Phone" data-parsley-type="number" data-parsley-type="Enter the 10 digit phone number" data-parsley-required-message="Please enter Phone Number" class="form-control" data-parsley-maxlength="10"  data-parsley-notequalto="#phone" data-parsley-maxlength-message="Enter the 10 digit phone number" data-parsley-minlength="10" data-parsley-minlength="Enter the 10 digit phone number" data-required="true" data-parsley-required data-parsley-group="block1" data-parsley-errors-container="#phone'+prev+'-err"/>'*/

       //console.log($(".field"+prev));

        $(".fields").append(newIn);
  }

  function removeContact(field){
   //console.log(field);
    $(field).hide();
   //console.log("remove");
  }
</script>
<script>
  $('#product_offer').on('change', function(e) {
    e.stopPropagation();
    this.value = this.checked ? 'y' : 'n';
  });

  $('#stax').on('change', function(e) {
    e.stopPropagation();
    this.value = this.checked ? 'y' : 'n';
  });

  $('#sell_offer').on('change', function(e) {
    e.stopPropagation();
    this.value = this.checked ? 'y' : 'n';
  });
</script>
  <script>
   function chooseCert() {
      $("#certificates").click();
   }
   function chooseLic() {
      $("#licenses").click();
   }
</script>

<script>

// $(document).ready(function() {
    $('input[type=radio][name=billing_type]').change(function() {
        if (this.value == 'card') {
          $('#bank_details').find('*').removeAttr('data-parsley-group');
          $('#bank_details').find('*').removeAttr('data-parsley-required');
          $('#bank_details').find('*').removeAttr('required');
          $('#card_details').find('input').attr('data-parsley-group', 'block2');
          $('#card_details').find('input').attr('data-parsley-group', 'block2');
          $('#card_details').find('input').attr('data-parsley-required');
          $('#card_details').find('input').attr('required');

          // $("*", ).removeProp("data-parsley-group");
              $('#bank_details').hide();
              $('#card_details').show();
        }
        else if (this.value == 'bank') {
          $('#card_details').find('*').removeAttr('data-parsley-group');
          $('#card_details').find('*').removeAttr('data-parsley-required');
          $('#card_details').find('*').removeAttr('required');
          $('#bank_details').find('input').attr('data-parsley-group', 'block2');
          $('#bank_details').find('input').attr('data-parsley-required');
          $('#bank_details').find('input').attr('required');
          $('#bank_details').find('select').attr('data-parsley-group', 'block2');
          $('#bank_details').find('select').attr('data-parsley-required');
          $('#bank_details').find('select').attr('required');
              $('#bank_details').show();
              $('#card_details').hide();
        }
    });
// });



document.getElementById("licenses").onchange = function () {
    var reader = new FileReader();

    reader.onload = function (e) {
       //console.log(e);
        // get loaded data and render thumbnail.
        document.getElementById("license").src = e.target.result;
    };

    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
};

document.getElementById("certificates").onchange = function () {
    var reader = new FileReader();

    reader.onload = function (e) {
     //console.log(e);
        // get loaded data and render thumbnail.
        document.getElementById("certificate").src = e.target.result;
    };

    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
};

</script>
<script>
  window.ParsleyConfig = {
  validators: {
    notdefault: {
      fn: function (value, requirement) {
        return value !== requirement;
      },
      priority: 32
    }
  },
  i18n: {
    en: {
      notdefault: 'This value may not be equal to %s'
    }
  }
};

/* Preventing form submission on enter button while using input type text */
$(document).on('keyup keypress', 'form input[type="text"]', function(e) {
  if(e.keyCode == 13) {
    e.preventDefault();
    return false;
  }
});

/* for two way databinding for addresses */
var $shipping_city = $('#shipping_city');
var $shipping_country = $('#shipping_country');
var $shipping_address = $('#shipping_address');
var $shipping_state = $('#shipping_state');
var $shipping_zip = $('#shipping_zip');

$shipping_city.keyup(function(){
  if($('#check_address').prop("checked")){

      $('#billing_city').val($(this).val()).change();
      $('#billing_city').parsley().validate();
            // $('#registration_form').parsley().validate("block2");
    }
});
$shipping_zip.keyup(function(){
  if($('#check_address').prop("checked")){

      $('#billing_zip').val($(this).val()).change();
      $('#billing_zip').parsley().validate();
            // $('#registration_form').parsley().validate("block2");
    }
});

$shipping_address.keyup(function(){
  if($('#check_address').prop("checked")){
      $('#billing_address').val($(this).val()).change();
      $('#billing_address').parsley().validate();
            // $('#registration_form').parsley().validate("block2");
    }
});

$shipping_country.change(function(){
  if($('#check_address').prop("checked")){
    var data= $(this).val();
      $('#billing_country').val(data).change();
      $('#billing_country').parsley().validate();
            // $('#registration_form').parsley().validate("block2");
    }
});

$shipping_state.change(function(){
    if($('#check_address').prop("checked")){
      var data= $(this).val();
      $('#billing_state').val(data).change();
      $('#billing_state').parsley().validate();
      // $('#registration_form').parsley().validate("block2");
    }
});


var $billing_city = $('#billing_city');
var $billing_country = $('#billing_country');
var $billing_address = $('#billing_address');
var $billing_state = $('#billing_state');
var $billing_zip = $('#billing_zip');
  if($('#check_address').prop("checked")){
    $billing_city.keyup(function(){


          $('#shipping_city').val($(this).val()).change();
          $('#shipping_city').parsley().validate();
                // $('#registration_form').parsley().validate("block2");
        
    });
    $billing_zip.keyup(function(){
      // if($('#check_address').prop("checked")){

          $('#shipping_zip').val($(this).val()).change();
          $('#shipping_zip').parsley().validate();
                // $('#registration_form').parsley().validate("block2");
        // }
    });

    $billing_address.keyup(function(){
      // if($('#check_address').prop("checked")){
          $('#shipping_address').val($(this).val()).change();
          $('#shipping_address').parsley().validate();
                // $('#registration_form').parsley().validate("block2");
        // }
    });

    $billing_country.change(function(){
      // if($('#check_address').prop("checked")){
        var data= $(this).val();
          $('#shipping_country').val(data).change();
          $('#shipping_country').parsley().validate();
                // $('#registration_form').parsley().validate("block2");
        // }
    });

    $billing_state.change(function(){
        // if($('#check_address').prop("checked")){
          var data= $(this).val();
          $('#shipping_state').val(data).change();
          $('#shipping_state').parsley().validate();
          // $('#registration_form').parsley().validate("block2");
        // }
    });
  }



/* ids */
// shipping_address
// shipping_country
// shipping_state
// shipping_city
// shipping_zip

</script>

<!-- <script type="text/javascript">
  $('#phone').formatter({
 'pattern': '({{999}}) {{999}}.{{9999}}',
  'persistent': false
});
</script> -->

</body>
</html>
