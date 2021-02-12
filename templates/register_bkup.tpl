
{include file="common/header-1.tpl" nocache}

<style type="text/css">
  form.registration-form fieldset {
  display: none;
}
</style>
<!--Section1 start Here-->
<section class="reg-bg disflx">
   <div class="container mrato lgn-bx2 reg-bg-clr" data-aos="zoom-in">
      <h3>User Details</h3>
        <div class="ront-lin">
            <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
            <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
            <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
            <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
            <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
        </div>
        <br>
        <span class="err-message">{$error}</span>
        <div class="reg-instl">
            <form action="/register/save" method="POST" id="registration_form" class="registration-form" enctype="multipart/form-data" data-parsley-validate onsubmit="if($('#registration_form').parsley().validate('block2')) return checkTerms();">



<!-- Step 1 -->
<fieldset>
                  <div class="row">
                      <div class="col-md-6">

                      <!-- Business name -->

                            <div class="input-group">

                              <input data-parsley-trigger="change focusout"  class="form-control" type="text" name="business_name"
                                   data-parsley-required-message="Please enter Business Name" placeholder="Business Name" class="form-control" data-required="true"  data-parsley-pattern-message="Invalid business name." data-parsley-group="block1" data-parsley-required data-parsley-errors-container="#business_name-err" data-parsley-group="block1" tabindex="1" />

                              <span class="input-group-addon" id="basic-addon2"><i class="flaticon-bank-building"></i></span>
                            </div>
                            <span id="business_name-err" class="err-message"></span>
                        </div>
                        <div class="col-md-6">
                            <div class=" input-group">
                                   <input class="form-control" data-parsley-trigger="change focusout"  type="text" id="phone" data-mask="000-000-0000" name="phone" placeholder="Phone" data-parsley-minlength="12"  max-length='12' data-parsley-minlength-message="Enter the 10 digit phone number"
                                    data-parsley-required-message="Please enter Phone Number" class="form-control"
                                    data-required="true" data-parsley-required
                                    data-parsley-errors-container="#phone-err" data-parsley-group="block1" tabindex="2"/>
                              <span class="input-group-addon" id="basic-addon2"><i class="flaticon-auricular-phone-symbol-in-a-circle"></i></span>
                            </div>
                            <span id="phone-err" class="err-message"></span>
                        </div>
                    </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">

                        <input data-parsley-trigger="change focusout" class="form-control" type="text" id="username" name="username"
                               data-parsley-required-message="Please enter Username" placeholder="Username" class="form-control"
                               data-required="true" data-parsley-required
                               data-parsley-pattern="^(?=[a-zA-Z])[a-zA-Z0-9]*$"
                               pattern="^(?=[a-zA-Z])[a-zA-Z0-9]*$" data-parsley-pattern-message="Invalid username!"
                               data-parsley-group="block1"
                               data-parsley-errors-container="#username-err" data-parsley-group="block1" tabindex="3"/>
                          <span class="input-group-addon" id="basic-addon2"><i class="flaticon-user"></i></span>
                        </div>
                        <span id="username-err" class="err-message"></span>
                        <span id="username-check-err" class="err-message"></span>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                        <input data-parsley-trigger="change focusout" class="form-control" type="email" id="email" name="email"
                               data-parsley-required-message="Please enter Email ID" placeholder="Business Email" class="form-control"
                               data-required="true" data-parsley-required
                               data-parsley-group="block1"
                               data-parsley-errors-container="#email-register-err" data-parsley-group="block1" tabindex="4"/>
                          <span class="input-group-addon" id="basic-addon2"><i class="flaticon-email"></i></span>
                        </div>
                        <span id="email-register-err" class="err-message"></span>
                        <span id="email-check-err" class="err-message"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">
                        <input data-parsley-trigger="change focusout" type="password" class="form-control" id="password" name="password" placeholder="Password" value="" data-parsley-required-message="Please enter Password" data-parsley-minlength="6" data-parsley-minlength="Password should at least 6 characters"  data-required="true" data-parsley-required data-parsley-errors-container="#password-register-err" data-parsley-group="block1"  tabindex="5">
                          <span class="input-group-addon" id="basic-addon2"><i class="flaticon-key"></i></span>
                        </div>
                        <span id="password-register-err" class="err-message"></span>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                        <input data-parsley-trigger="change focusout" type="password" class="form-control" id="cpassword" name="cpassword" placeholder="Confirm Password" value="" data-parsley-required-message="Please enter Password to confirm" data-parsley-equalto="#password" data-required="true" data-parsley-required data-parsley-errors-container="#cpassword-err" data-parsley-group="block1" tabindex="6">
                          <span class="input-group-addon" id="basic-addon2"><i class="flaticon-confirm"></i></span>
                        </div>
                        <span id="cpassword-err" class="err-message"></span>
                    </div>
                </div>
                <!-- <input data-parsley-trigger="change focusout" type="hidden" name="count" id="count" value=1 /> -->
              <div class="row fields">
                <div id="field1" class="col-md-12 pos-rlt bg-add nw-fld1">

                    <a id="add-more" class="add-more" onclick="addContact()" ><i class="fa fa-plus-circle pos-rit"  aria-hidden="true"></i></a>

                    <div class="row">
                      <div class="col-md-6">
                          <div class="input-group">
                          <input data-parsley-trigger="change focusout" type="text" class="form-control" id="fname0" placeholder="First Name" name="contacts[0][fname]" data-parsley-minlength="3" data-parsley-minlength-message="please enter a minimum of 3 characters." data-parsley-pattern="^[A-Za-z]*$"
                                 pattern="^[A-Za-z0-9]*$" data-parsley-required-message="Please enter First Name" data-required="true" data-parsley-required data-parsley-errors-container="#fname0-err" data-parsley-group="block1" tabindex="7">
                            <span class="input-group-addon" id="basic-addon2"><i class="flaticon-user"></i></span>
                          </div>
                          <span id="fname0-err" class="err-message"></span>
                      </div>
                      <div class="col-md-6">
                          <div class="input-group">
                          <input data-parsley-trigger="change focusout" type="text" class="form-control" id="lname0" placeholder="Last Name"  name="contacts[0][lname]"  data-parsley-pattern="^[A-Za-z]*$"
                                 pattern="^[A-Za-z0-9]*$" data-parsley-required-message="Please enter Last Name" data-required="true" data-parsley-required data-parsley-errors-container="#lname0-err" data-parsley-group="block1" tabindex="8">
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
                                  data-mask="000-000-0000" max-length="12"
                                  data-parsley-minlength="12" data-parsley-minlength-message="Enter the 10 digit phone number"
                                  data-parsley-notequalto="#phone"
                                  data-required="true" data-parsley-required data-parsley-required-message="Please enter Phone Number"
                                  data-parsley-group="block1" data-parsley-errors-container="#phone0-err" tabindex="9"/>
                            <span class="input-group-addon" id="basic-addon2"><i class="flaticon-auricular-phone-symbol-in-a-circle"></i></span>
                          </div>
                          <span id="phone0-err" class="err-message"></span>
                       </div>
                      <div class="col-md-6">
                          <div class="input-group">
                          <input data-parsley-trigger="change focusout" type="email" class="form-control" id="email0" placeholder="Email" name="contacts[0][email]" data-parsley-required-message="Please enter valid Email" data-required="true" data-parsley-required data-parsley-errors-container="#email0-err" data-parsley-group="block1" tabindex="10">
                            <span class="input-group-addon" id="basic-addon2"><i class="flaticon-email"></i></span>
                          </div>
                          <span id="email0-err" class="err-message"></span>
                      </div>
                    </div>

                </div>
                </div>
                        <div class="clearfix"></div>
                        <div class="text-right" style="margin-top: 15px">
                            <button type="button" class="btn btn-next btn-grn" tabindex="11">Next <i class="fa flaticon-arrow-point-to-right"></i></button>
                        </div>
                    <div class="text-center">
                        <ul class="pagination">
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link btn-next" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item"><a class="page-link" href="#">4</a></li>
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
                      <textarea class="form-control" name="shipping_address" rows="4" id="shipping_address" placeholder="Address" data-parsley-required-message = "Shipping Address Required" data-parsley-required data-parsley-trigger="keyup" data-parsley-minlength="10" data-parsley-maxlength="100"  data-parsley-pattern="^[a-zA-Z0-9,\n ]*$" pattern="^[a-zA-Z0-9,\n ]*$" data-parsley-pattern-message="Invalid Address" data-parsley-minlength-message="Required minimum 10 characters" data-parsley-validation-threshold="10" data-parsley-group="block2" data-parsley-errors-container="#shipping_address-err"  tabindex="1"></textarea>
                      <span id="shipping_address-err" class="err-message"></span>
                      <!-- <textarea id="message" class="form-control" name="message" ></textarea> -->
                    </div>
                  <div class="col-md-6">
                        <div class="form-group">
                        <select class="form-control" name="shipping_country" id="shipping_country" data-parsley-required-message="Please select Country" place-holder="Select country" data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#shipping_country-err" tabindex="2">
                            <option value="">Select country</option>
                        </select>
                        <span id="shipping_country-err" class="err-message"></span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                        <select class="form-control" name="shipping_state" id="shipping_state"  data-parsley-required data-parsley-required-message="Please select State" place-holder="Select state"  data-parsley-required data-parsley-group="block2" tabindex="3">
                                <option value="">Select state</option>
                            </select>
                        <span id="shipping_state-err" class="err-message"></span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">

                        <input data-parsley-trigger="change focusout" class="form-control" placeholder="City" id="shipping_city" name="shipping_city" data-parsley-required class="form-control" type="text" data-parsley-required-message="Please enter City" data-parsley-pattern="^[A-Za-z]*$" pattern="^[A-Za-z]*$" class="form-control" data-required="true"  data-parsley-pattern="^[a-zA-Z ]*$" pattern="^[a-zA-Z ]*$" data-parsley-pattern-message="Invalid city"  data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#shipping_city-err" tabindex="4"/>
                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                         <span id="shipping_city-err" class="err-message"></span>
                    </div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <select class="form-control" name="shipping_region" id="shipping_region"  data-parsley-required data-parsley-required-message="Please select Region" place-holder="Select Region"  data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#shipping_region-err" tabindex="5">
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
                          data-parsley-maxlength="6" data-parsley-maxlength-message="Enter the 5-6 character Zip Code"
                          data-parsley-minlength="5" data-parsley-minlength-message="Enter the 5-6 character Zip Code" data-parsley-required-message="Please enter Zip Code" placeholder="Zip Code" class="form-control" data-required="true" data-parsley-group="block2" data-parsley-required data-parsley-errors-container="#shipping_zip-err" tabindex="6"/>

                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="shipping_zip-err" class="err-message"></span>
                    </div>
                </div>
                <div class="col-md-12 pdlr0 mrtp30">
                  <p class="ship-hed">Billing Info</p>
                </div>

                <div class="row text-left mr-cklab mrbt10">
                       <div class="checkbox">
                          <label>
                            <input data-parsley-trigger="change focusout" type="checkbox" id="check_address" name="check_address"  tabindex="7">
                            <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                            Same as shipping address
                          </label>
                        </div>
                </div>

                <div class="row">
                  <div class="col-md-12 form-group">
                        <textarea class="form-control" name="billing_address" rows="4" id="billing_address" placeholder="Address" data-parsley-required-message = "Billing Address Required" data-parsley-required data-parsley-trigger="keyup" data-parsley-minlength="10" data-parsley-maxlength="100" data-parsley-pattern="^[a-zA-Z0-9,\n ]*$" pattern="^[a-zA-Z0-9,\n ]*$" data-parsley-pattern-message="Invalid Address" data-parsley-minlength-message="Required minimum 10 characters" data-parsley-validation-threshold="10" data-parsley-group="block2" data-parsley-errors-container="#billing_address-err" tabindex="8"></textarea>
                        <span id="billing_address-err" class="err-message" ></span>
                    </div>
                  <div class="col-md-6">
                        <div class="form-group">

                          <select class="form-control" name="billing_country" id="billing_country" data-parsley-required-message="Please select Country" data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#billing_country-err" tabindex="9">
                              <option value="">Select country</option>
                          </select>
                          <span id="billing_country-err" class="err-message"></span>

                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                          <select class="form-control" name="billing_state" id="billing_state" data-parsley-required-message="Please select State" data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#billing_state-err" tabindex="10">
                                  <option value="">Select state</option>
                          </select>
                          <span id="billing_state-err" class="err-message"></span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">
                          <input data-parsley-trigger="change focusout" class="form-control" id="billing_city" name="billing_city" data-parsley-required class="form-control" type="text" placeholder="City" data-parsley-required-message="Please enter City" class="form-control" data-required="true"  data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#billing_city-err" tabindex="11"/>
                        <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="billing_city-err" class="err-message"></span>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                        <input data-parsley-trigger="change focusout" class="form-control" name="billing_zip" id="billing_zip"  data-parsley-required class="form-control" type="text" data-parsley-required-message="Please enter Zip Code" placeholder="Zip Code" class="form-control" data-required="true" data-parsley-required data-parsley-group="block2" data-parsley-errors-container="#billing_zip-err" data-parsley-maxlength="6" data-parsley-maxlength-message="Enter the 5-6 character Zip Code" maxlength="6"
                          data-parsley-minlength="5" data-parsley-minlength-message="Enter the 5-6 character Zip Code"  tabindex="12"/>
                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="billing_zip-err" class="err-message"></span>
                    </div>
                </div>
                    <div class="text-right">
                        <button type="button" class="btn btn-previous btn-grn" tabindex="13"><i class="fa flaticon-arrow-point-to-right fa-flip-horizontal"></i> Previous</button>
                        <button type="button" class="btn btn-next btn-grn"  tabindex="14">Next<i class="flaticon-arrow-point-to-right"></i></button>
                    </div>
                    <div class="text-center">
                        <ul class="pagination">
                            <li class="page-item"><a class="page-link btn-previous" onclick="">1</a></li>
                            <li class="page-item active"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link btn-next" href="#">3</a></li>
                            <li class="page-item"><a class="page-link btn-next" href="#">4</a></li>
                        </ul>
                    </div>
                    </fieldset>

                    <fieldset>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                          <select class="form-control" name="business_type" id="business_type" data-parsley-required-message="Please select Business type" place-holder="Business Type" data-parsley-required data-parsley-group="block3" data-parsley-errors-container="#business_type-err" tabindex="1">
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
                          <input data-parsley-trigger="change focusout" class="form-control" name="ein_number" data-parsley-required class="form-control" type="text" data-parsley-type="number" data-parsley-minlength="9" data-parsley-maxlength="9" data-parsley-required-message="Please enter EIN number" placeholder="EIN Number" class="form-control" data-required="true" data-parsley-group="block3" data-parsley-required data-parsley-errors-container="#ein_number-err" tabindex="2"/>
                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                        <span id="ein_number-err" class="err-message"></span>
                    </div>
                </div>

                <div class="row mrbt15 text-left">
                    <div class="col-md-6 text-center">
                      <label class="lab-clr"> Upload Licence Here (*.jpeg, *.jpg, *.png etc.)</label>
                        <div class="reg_file_upload">
                          <input data-parsley-trigger="change focusout" type="file" id="licenses" name="licenses" data-parsley-required-message="Please Upload License" data-parsley-errors-container="#lic_img-err" accept="image/*" data-parsley-fileextension='jpg jpeg gif png' required/>
                        </div>
                        <div style="overflow: hidden;" class="mt-15">
                        <img id="license" src="{$config.url}/images/no_img.png" height="100px" style="margin: auto; display: block;" />
                        </div>
                        <button type="button" class="btn btn-grn wid100 fnt14 mt-15" onclick="chooseLic();" tabindex="3">Upload</button>
                        <span id="lic_img-err" class="err-message"></span>
                    </div>

                    <div class="col-md-6 text-center">
                      <label class="lab-clr"> Upload Business Certificate Here (*.jpeg, *.jpg, *.png etc.)</label>
                        <div class="reg_file_upload">
                          <input data-parsley-trigger="change focusout" type="file" id="certificates" name="certificates" data-parsley-required-message="Please Upload Certificate"  data-parsley-errors-container="#cert_img-err" required accept="image/*" data-parsley-fileextension='jpg jpeg gif png' required/>
                        </div>
                        <div style="overflow: hidden;" class="mt-15">
                          <img id="certificate" src="{$config.url}/images/no_img.png" height="100px" style="margin: auto; display: block;"/>
                        </div>
                        <button type="button" class="btn btn-grn wid100 fnt14 mt-15" onclick="chooseCert();" tabindex="4">Upload</button>
                        <span id="cert_img-err" class="err-message"></span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">
                          <input data-parsley-trigger="change focusout" type="text" class="form-control" id="ref_code" placeholder="Referal Code (If Any)" value="" name="referals" tabindex="5">
                          <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                        </div>
                    </div>
                </div>

                <div class="row text-left mr-cklab mrbt10">
                        <div class="col-md-12 form-group form-inline text-left ">
                            <label class="lab-clr">Would you like to be notified of new product offers?</label>
                              <div class="radio radio-inline radio-primary ">
                                <input data-parsley-trigger="change focusout" type="radio" name="product_offer" id="product_offer1" value="y" tabindex="6">
                                <label for="product_offer1"> Yes </label>
                                <input data-parsley-trigger="change focusout" type="radio" name="product_offer" id="product_offer2" value="n" checked="true" tabindex="7">
                                <label for="product_offer2"> No </label>
                              </div>
                        </div>
                        <div class="col-md-12 form-group form-inline text-left ">
                            <label class="lab-clr">Would you like to add sales tax?</label>
                              <div class="radio radio-inline radio-primary ">
                                <input data-parsley-trigger="change focudsout" type="radio" name="stax" id="stax1" value="y"  tabindex="8">
                                <label for="stax1"> Yes </label>
                                <input data-parsley-trigger="change focusout" type="radio" name="stax" id="stax2" value="n" checked="true"  tabindex="9">
                                <label for="stax2"> No </label>
                              </div>
                        </div>
                        <div class="col-md-12 form-group form-inline text-left ">
                            <label class="lab-clr">Enter the sales tax</label>
                            <div class="input-group">
                              <input data-parsley-trigger="change focusout" class="form-control" name="stax_per" data-parsley-required class="form-control" type="text" data-parsley-min="1" data-parsley-min-message="please enter stax greater than 0" data-parsley-type="number" data-parsley-required-message="Please enter sales tax" placeholder="Sales tax (%) " class="form-control" data-required="true" data-parsley-group="block3" data-parsley-required data-parsley-group="block3" data-parsley-errors-container="#stax_per-err" tabindex="10"/>
                              <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                            </div>
                        <span id="stax_per-err" class="err-message"></span>
                        </div>
                </div>
<!--                 <div class="col-md-12 pslr0 text-left mr-cklab mrbt10 scall">
                <div class="scrl" id="style-1">
                  {$terms}
                </div>
                </div>
                <div class="clearfix"></div>
                <div class="row text-left mr-cklab mrbt10 ">
                  <div class="agree_terms check_opt">
                   <div class="checkbox">
                      <label>
                        <input data-parsley-trigger="change focusout" type="checkbox" name="agree" value="1" id="agree" tabindex="11"/>&nbsp;
                        <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                        I have accepted the <a target="_blank" href="{$config.url}/terms">terms and conditions</a>
                      </label>
                    </div>
                    </div>
                </div> -->
                        <div class="text-right">
                            <button type="button" class="btn btn-previous btn-grn" tabindex="36"><i class="fa flaticon-arrow-point-to-right fa-flip-horizontal"></i> Previous</button>
                            <button type="button" class="btn btn-next btn-grn"  tabindex="14">Next<i class="flaticon-arrow-point-to-right"></i></button>
                        </div>
                    <div class="text-center">
                        <ul class="pagination">
                            <li class="page-item"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link btn-previous" href="#">2</a></li>
                            <li class="page-item active"><a class="page-link" href="#">3</a></li>
                            <li class="page-item"><a class="page-link btn-next" href="#">4</a></li>
                        </ul>
                    </div>
                    </fieldset>

                    <fieldset>
                <div class="row text-left mr-cklab mrbt10">
                        <div class="col-md-12 form-group form-inline text-left ">
                            <label class="lab-clr">Do you want to use Herbee as the default provider for your distribution needs?</label>
                              <div class="radio radio-inline radio-primary ">
                                <input data-parsley-trigger="change focusout" type="radio" name="default_provider" id="default_provider1" value="y" tabindex="6">
                                <label for="default_provider1"> Yes </label>
                                <input data-parsley-trigger="change focusout" type="radio" name="default_provider" id="default_provider2" value="n" checked="true" tabindex="7">
                                <label for="default_provider2"> No </label>
                              </div>
                              <div id="default_provider_yes" style="display: none">
                                Herbee is set to your default distribution service provider on transactions that require a distributor.  Herbee’s low-cost fees will be charged to these transactions.  You will always have the opportunity to confirm your purchase.
                              </div>
                              <div id="default_provider_no" style="display: none">
                                By clicking No, you will have to either get distribution services from another provider or you will have to select Herbee on a case-by-case basis.  To change Herbee to your default distribution services provider in the future, come back to this page and change this answer to “Yes”.  Please confirm your answer.  Click Yes or No.
                              </div>
                        </div>
                        <div class="col-md-12 form-group form-inline text-left ">
                            <label class="lab-clr">Would you like to select Herbee as your default transport service provider?</label>
                              <div class="radio radio-inline radio-primary ">
                                <input data-parsley-trigger="change focusout" type="radio" name="default_transport" id="default_transport1" value="y" tabindex="6">
                                <label for="default_transport1"> Yes </label>
                                <input data-parsley-trigger="change focusout" type="radio" name="default_transport" id="default_transport2" value="n" checked="true" tabindex="7">
                                <label for="default_transport2"> No </label>
                              </div>

                              <div id="default_transport_yes" style="display: none">
                                Herbee is set to your default distribution service provider on transactions that require a distributor.  Herbee’s low-cost fees will be charged to these transactions.  You will always have the opportunity to confirm your purchase.
                              </div>
                              <div id="default_transport_no" style="display: none">
                               By clicking No, you will have to either get transport services from another provider or you will have to select Herbee on a case-by-case basis.  To change Herbee to your default transport service provider in the future, come back to this page and change this answer to “Yes”.  Please confirm your answer.  Click Yes or No.
                              </div>
                        </div>
                        <div class="col-md-12 form-group form-inline text-left ">
                            <label class="lab-clr">Would you like to be notified of new product offers?</label>
                              <div class="radio radio-inline radio-primary ">
                                <input data-parsley-trigger="change focusout" type="radio" name="product_offer" id="product_offer1" value="y" tabindex="6">
                                <label for="product_offer1"> Yes </label>
                                <input data-parsley-trigger="change focusout" type="radio" name="product_offer" id="product_offer2" value="n" checked="true" tabindex="7">
                                <label for="product_offer2"> No </label>
                              </div>
                        </div>
                        <div class="col-md-12 form-group form-inline text-left ">
                            <label class="lab-clr">Would you like to add sales tax?</label>
                              <div class="radio radio-inline radio-primary ">
                                <input data-parsley-trigger="change focudsout" type="radio" name="stax" id="stax1" value="y"  tabindex="8">
                                <label for="stax1"> Yes </label>
                                <input data-parsley-trigger="change focusout" type="radio" name="stax" id="stax2" value="n" checked="true"  tabindex="9">
                                <label for="stax2"> No </label>
                              </div>
                        </div>
                        <div class="col-md-12 form-group form-inline text-left ">
                            <label class="lab-clr">Enter the sales tax</label>
                            <div class="input-group">
                              <input data-parsley-trigger="change focusout" class="form-control" name="stax_per" data-parsley-required class="form-control" type="text" data-parsley-min="1" data-parsley-min-message="please enter stax greater than 0" data-parsley-type="number" data-parsley-required-message="Please enter sales tax" placeholder="Sales tax (%) " class="form-control" data-required="true" data-parsley-group="block3" data-parsley-required data-parsley-group="block3" data-parsley-errors-container="#stax_per-err" tabindex="10"/>
                              <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                            </div>
                        <span id="stax_per-err" class="err-message"></span>
                        </div>
                </div>


                <div class="col-md-12 pslr0 text-left mr-cklab mrbt10 scall">
                <div class="scrl" id="style-1">
                  {$terms}
                </div>
                </div>
                <div class="clearfix"></div>
                <div class="row text-left mr-cklab mrbt10 ">
                  <div class="agree_terms check_opt">
                   <div class="checkbox">
                      <label>
                        <input data-parsley-trigger="change focusout" type="checkbox" name="agree" value="1" id="agree" tabindex="11"/>&nbsp;
                        <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                        I have accepted the <a target="_blank" href="{$config.url}/terms">terms and conditions</a>
                      </label>
                    </div>
                    </div>
                </div>

                        <div class="text-right">
                            <button type="button" class="btn btn-previous btn-grn" tabindex="36"><i class="fa flaticon-arrow-point-to-right fa-flip-horizontal"></i> Previous</button>
                            <button type="submit" class="btn btn-grn" tabindex="37">Submit<i class="flaticon-arrow-point-to-right"></i></button>
                        </div>
                        <div class="text-center">
                            <ul class="pagination">
                                <li class="page-item"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link " href="#">2</a></li>
                                <li class="page-item"><a class="page-link btn-previous" href="#">3</a></li>
                                <li class="page-item active"><a class="page-link" href="#">4</a></li>
                            </ul>
                        </div>
                    </fieldset>

                </form>
        </div>
    </div>
</section>
<!--Section1 end Here-->


{include file="common/footer-1.tpl" nocache}
<script src="{$config['externaljs']}scripts.js" type="text/javascript"></script>

<script>
     $('input[type=text][name=stax_per]').prop('disabled', true);
        $('input[type=text][name=stax_per]').prop('data-toggle','tooltip');
        $('input[type=text][name=stax_per]').removeAttr("data-parsley-required-message data-parsley-required");
        $('input[type=text][name=stax_per]').prop('title','Select yes to enable...!');
        $('#stax_per-err').hide();
    /* sales tax */
    $('input[type=radio][name=stax]').change(function() {
      if (this.value == 'y') {
        $('input[type=text][name=stax_per]').prop('disabled', false);
        $('input[type=text][name=stax_per]').prop('data-toggle','tooltip');
        $('input[type=text][name=stax_per]').attr({ "data-parsley-required-message" : "Please enter sales tax" , "data-parsley-required":true });
        $('input[type=text][name=stax_per]').prop('title','Enter the sales tax(%)...!');
        $('#stax_per-err').show();

        // alert('stax1 selected');
      }
      if (this.value == 'n') {
        $('input[type=text][name=stax_per]').prop('disabled', true);
        $('input[type=text][name=stax_per]').prop('data-toggle','tooltip');
        $('input[type=text][name=stax_per]').removeAttr("data-parsley-required-message data-parsley-required");
        $('input[type=text][name=stax_per]').prop('title','Select yes to enable...!');
        $('#stax_per-err').hide();
        // alert('stax2 selected');
      }
    });
    /* end */

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

    ////console.log("add-more clicked");

        next = parseInt($("#count").val());
        next = next + 1;

        ////console.log($("#count").val(next));

        prev = next-1;
        nprev = prev - 1;

        ////console.log("next"+next);
        ////console.log("prev"+prev);

        var field = "\#field"+next;

        var newIn = '<div id="field'+next+'" class="col-md-12 pos-rlt bg-add"><a id="remove-contact" class="remove-contact" onclick=removeContact(\"'+field+'\")><i class="fa fa-minus-circle pos-rit" aria-hidden="true"></i></a><div class="col-md-6 pdlf0"><div class="input-group"> <input data-parsley-trigger="change focusout" type="text" class="form-control" id="fname'+prev+'" placeholder="First Name" name="contacts['+prev+'][fname]"  data-parsley-required-message="Please enter First Name" data-parsley-pattern="^[A-Za-z]*$" pattern="^[A-Za-z]*$" data-required="true" data-parsley-required data-parsley-group="block1" data-parsley-errors-container="#fname'+prev+'-err"> <span class="input-group-addon" id="basic-addon2"><i class="flaticon-user"></i></span></div><span id="fname'+prev+'-err" class="err-message"></span></div> <div class="col-md-6 pdrt0"> <div class="input-group"> <input data-parsley-trigger="change focusout" type="text" class="form-control" id="lname'+prev+'" placeholder="Last Name"  name="contacts['+prev+'][lname]"  data-parsley-required-message="Please enter Last Name" data-required="true" data-parsley-required  data-parsley-group="block1" data-parsley-errors-container="#lname'+prev+'-err"><span class="input-group-addon" id="basic-addon2"><i class="flaticon-user"></i></span> </div> <span id="lname'+prev+'-err" class="err-message"></span></div> <div class="col-md-6 pdlf0"><div class="input-group"><input data-parsley-trigger="change focusout" class="form-control" type="text" data-mask="000-000-0000" data-parsley-minlength="12" data-parsley-minlength-message="Enter the 10 digit phone number" name="contacts['+prev+'][phone] id="phone'+prev+'" placeholder="Phone" max-length="12" data-parsley-type="number" data-parsley-required-message="Please enter Phone Number" class="form-control" data-parsley-notequalto="#phone" data-required="true" data-parsley-required data-parsley-group="block1" data-parsley-errors-container="#phone'+prev+'-err"/> <span class="input-group-addon" id="basic-addon2"><i class="flaticon-auricular-phone-symbol-in-a-circle"></i></span> </div><span id="phone'+prev+'-err" class="err-message"></span></div><div class="col-md-6 pdrt0"><div class="input-group"><input data-parsley-trigger="change focusout" type="email" class="form-control" id="email'+prev+'" placeholder="Email" name="contacts['+prev+'][email]" data-parsley-notequalto="#email" data-parsley-required-message="Please enter valid Email" data-required="true" data-parsley-required data-parsley-group="block1" data-parsley-errors-container="#email'+prev+'-err"><span class="input-group-addon" id="basic-addon2"><i class="flaticon-email"></i></span></div><span id="email'+prev+'-err" class="err-message"></span></div></div>';

        /*'<input data-parsley-trigger="change focusout" class="form-control" type="text" data-mask="000-000-0000" maxlength="10"  name="contacts['+prev+'][phone] id="phone'+prev+'" placeholder="Phone" data-parsley-type="number" data-parsley-type="Enter the 10 digit phone number" data-parsley-required-message="Please enter Phone Number" class="form-control" data-parsley-maxlength="10"  data-parsley-notequalto="#phone" data-parsley-maxlength-message="Enter the 10 digit phone number" data-parsley-minlength="10" data-parsley-minlength="Enter the 10 digit phone number" data-required="true" data-parsley-required data-parsley-group="block1" data-parsley-errors-container="#phone'+prev+'-err"/>'*/

        ////console.log($(".field"+prev));

        $(".fields").append(newIn);
  }

  function removeContact(field){
    ////console.log(field);
    $(field).hide();
    ////console.log("remove");
  }
</script>
<script>
  $('#product_offer').on('change', function(e) {
    e.stopPropagation();
    this.value = this.checked ? 'y' : 'n';
  });
  $('#product_offer').on('change', function(e) {
    e.stopPropagation();
    this.value = this.checked ? 'y' : 'n';
  });
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
        ////console.log(e);
        // get loaded data and render thumbnail.
        document.getElementById("license").src = e.target.result;
    };

    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
};

document.getElementById("certificates").onchange = function () {
    var reader = new FileReader();

    reader.onload = function (e) {
      ////console.log(e);
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

</script>
<script type="text/javascript">

console.log(location.search);

  function getSearchParams(k){
     var p={};
     location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi,function(s,k,v){ p[k]=v });
     return k?p[k]:p;
  }


  console.log(getSearchParams("ref"));
  console.log(location);
 $(document).ready(function() {
    $("#ref_code").val(getSearchParams("ref"));
 })  
  

</script>
</body>
</html>
