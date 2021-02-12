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

<section class="reg-bg disflx">

	<div class="container mrato reg-bg-clr" data-aos="zoom-in">

      {if $step3}
        <div class="myClass">
          {if $textStatus != ''}
          <div class="clearfix dash_heads">
              <div class="m0" id="messagedisplay">
                  <ul id="message" class="alert alert-success m0 m20 bg-transparent border-0">
                      <li>
                          <p>{$textStatus}</p>
                      </li>
                  </ul>
              </div>
          </div>
          {/if}
        </div>
        {/if}
        <div class="reg-instl">

          {if $step1}
            <div class="myClass">
            {if $textStatus != ''}
            <div class="clearfix dash_heads">
                <div class="m0" id="messagedisplay">
                    <ul id="message" class="alert alert-success m0 m20 bg-transparent border-0">
                        <li>
                            <p>{$textStatus}</p>
                        </li>
                    </ul>
                </div>
            </div>
            {/if}
          </div>
          <h3>{$phrase.forgot_password}</h3>
           <div class="ront-lin">
               <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
               <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
               <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
               <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
               <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
           </div>
        	<form action="/login/forgot_password" method="post" accept-charset="utf-8" data-parsley-validate required>
                <div class="row">

                	<div class="col-md-12">
                    <label>{$phrase.your_email} <span class="red">*</span>:</label>
                        <div class="input-group">

                          <input class="form-control" type="email" id="email" name="email" placeholder="Enter your email" value="" data-parsley-required-message="Email Address Required" maxlength="55" class="form-control" required/>
                          <span class="input-group-addon" id="basic-addon2"><i class="flaticon-user"></i></span>
                        </div>
                    </div>

                </div>

              	<div class="text-right mrtp20">
              		<input type="submit" name="submit_forgot_password" value="Send" title="Send" class="btn btn-grn" />
                </div>
            </form>
            {/if}


            {if $step2}
            <h3>{$phrase.enter_new_password}</h3>
             <div class="ront-lin">
                 <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
                 <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
                 <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
                 <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
                 <span><i class="fa fa-circle-o" aria-hidden="true"></i></span>
             </div>
          	<form action="/login/changepassword" method="post" id="change_password" name="change_password" accept-charset="utf-8" data-parsley-validate>
              <input type="hidden" name="id" value="{$id}" />

                  <div class="row">
<!-- <h3>{$phrase.enter_new_password}</h3> -->
                  	<div class="col-md-12">
                      <label>{$phrase.new_password} <span class="red">*</span>:</label>
                          <div class="input-group">

                            <input type="password" id="new_password" name="new_password" data-parsley-minlength="6" data-parsley-minlength-message="Please enter a minimum of 6 characters" data-parsley-length-message="Please enter a minimum of 6 characters" data-parsley-type-message="Password should be alphanumeric" data-parsley-type="alphanum" title="New Password" data-parsley-required-message="Enter new password" maxlength="20" class="form-control" required>
                            <span class="red"> </span>
                            <span class="input-group-addon" id="basic-addon1"><i class="flaticon-key"></i></span>

                          </div>
                      </div>


                      <div class="col-md-12">
                            <label>{$phrase.confirm_password} <span class="red">*</span>:</label>
                            <div class="input-group">

                              <input type="password" id="new_password" name="confirm_password" title="Confirm Password" data-parsley-required-message="Confirm new password" class="form-control" maxlength="20" required data-parsley-equalto="#new_password" data-parsley-error-message="Password entered don't match">
                              <span class="red"> </span>
                              <span class="input-group-addon" id="basic-addon3"><i class="flaticon-key"></i></span>

                            </div>
                        </div>

                  </div>

                	<div class="text-right mrtp20">
                		<input type="submit" name="submit_change_pass" value="SAVE" class="btn btn-grn">
                  </div>
              </form>
              {/if}
              <div class="user" style="display:none;"></div>

        </div>
    </div>



</section>

{include file="common/footer-1.tpl" nocache}
