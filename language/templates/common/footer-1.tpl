</div>
</div>
<style type="text/css">
    .m-top-10 {
        margin-top: 10px;
    }

    .wid100 {
        width: 100%;
    }
</style>
<div class="modal fade" id="dispute" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="height: 320px;">
            <div class="modal-header" style="text-align: center;">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span id="closeafnt" class="sr-only">{$pharse.close}</span></button>
                <h4 class="modal-title" id="myModalLabel"><b> {$pharse.dispute} </b></h4>
            </div>
            <div class="modal-body">
                <form action="/profile_settings/address" id="dispute_submit" method="POST" data-parsley-validate enctype="multipart/form-data">

                    <div class="col-md-12">
                        <label>{$pharse.subject}</label>
                        <input type="text" class="form-control" name="subject" required  />
                    </div>
                    <div class="col-md-12" style="padding-top: 10px;">
                        <label>{$pharse.message_:}</label>
                        <textarea class="form-control" name="message" required></textarea>
                    </div>
                    <div class="col-md-12">
                        <input type="hidden" id="dispute_pid" name="dispute_pid"  />
                        <input type="button" class="btn btn-danger" id="save_dispute" value="Save" style="margin-top:10px;">&nbsp;&nbsp;

                    </div>
                </form>
            </div>

        </div>
    </div>

</div>

<footer>
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-5">
                <div class="footer_logo"><a href="{$config.url}">
                    <img src="{$config.url}/images/logoc.png" class="img-responsive" alt=""/></a>
                </div>
                <div class="copy_right">
                    <p class="footer_txt">{$config.title}&nbsp;<i class="fa fa-copyright"></i>&nbsp;2015.</p>

                    <div class="social_icons">
                        <span style="display: inline-block;float: left;">| {$pharse.follow_us}</span>

                        <div><a href="https://www.facebook.com/pages/Auctionsoftwarecom/1497910160481548?fref=nf"
                                target="_blank"><i class="fa fa-facebook"></i></a></div>
                        <div><a href="https://twitter.com/" target="_blank"><i class="fa fa-twitter"></i></a></div>
                    </div>
                </div>
            </div>
            <div class="col-md-offset-1 col-xs-12 col-sm-12 col-md-6">


                {if $mode neq 'yes'}

                <div class="footer_right">
                    <div><a href="{$config.url}/">{$pharse.home}</a></div>
                    <div><a href="{$config.url}/about">{$about_us}</a></div>
                    <div><a href="{$config.url}/about/buyers">{$pharse.buyers}</a></div>
                    <div><a href="{$config.url}/sellers">{$pharse.sellers}</a></div>
                    <div><a href="{$config.url}/blog">{$pharse.blog}</a></div>
                    <div style="border-right: 1px solid #fff;"><a href="{$config.url}/how_it">{$pharse.how_it_works}</a></div>
                    <div><a href="{$config.url}/about/contacts">{$pharse.contact_us}</a></div>
                    <div><a href="{$config.url}/privacy">{$pharse.privacy_policy}</a></div>
                    <div><a href="{$config.url}/terms">{$pharse.terms_conditions}</a></div>
                    <!--  {if $loged.userid > 0}
                   <div> <a href="{$config.url}/reviews">Review</a></div>
                    {else}
                     <div> <a href="{$config.url}/login">Review</a></div>
                    {/if}-->
                    <div><a href="{$config.url}/reviews">{$pharse.review}</a></div>
                </div>
                {/if}
            </div>
        </div>
    </div>
    <div style="clear:both"></div>
</footer>

{if $mode neq 'yes'}

{if $loged.userid <= 0}
<div class="modal confirmbid  fade" id="registration" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog trans_bck">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <h2>{$pharse.registration}</h2>

                <div class="text-danger">{$register_error}</div>
                <form action="/register/save" method="POST" data-parsley-validate id="registerform"
                      enctype="multipart/form-data" onsubmit="return checkTerms();">
                    <input type="hidden" name="r_id" value="{$r_id}"/>
                    <input type="hidden" name="do" id="do" value="quickregister_popup"/>
                    <input type="hidden" name="email_exist" id="email_exist" value="0"/>
                    <input type="hidden" name="user_exist" id="user_exist" value="0"/>
                    <span id="form_proces_res" class="error_popup"></span>

                    <div class="form-group">
                        <input type="hidden" value="{$refers}" name="referals">
                        <input type="hidden" value="{$med}" name="medias">
                        <label>{$pharse.first_name}</label>
                        <input class="form-control" type="text" name="first_name"
                               data-parsley-required-message="Please enter First Name" placeholder="First Name"
                               class="form-control" data-required="true" data-parsley-pattern="^[A-Za-z]*$"
                               pattern="^[A-Za-z]*$" data-parsley-pattern-message="Invalid name!"
                               data-parsley-group="block1" data-parsley-required value="{$registerdata.first_name}"/>
                    </div>
                    <div class="form-group">
                        <label>{$pharse.last_name}</label>
                        <input class="form-control" type="text" name="last_name"
                               data-parsley-required-message="Please enter Last Name" Placeholder="Last Name"
                               class="form-control" data-required="true" data-parsley-pattern="^[A-Za-z]*$"
                               pattern="^[A-Za-z]*$" data-parsley-pattern-message="Invalid name!"
                               data-parsley-group="block1" data-parsley-required value="{$registerdata.last_name}"/>
                    </div>
                    <div class="form-group">
                        <label>{$pharse.email}</label>
                        <input class="form-control" type="email" name="email"
                               data-parsley-required-message="Please enter email address" placeholder="Email Id"
                               class="form-control" id="email_search" data-required="true" onkeyup=" check_userlist()"
                               data-parsley-group="block1" data-parsley-required value="{$registerdata.email}"/>
                    </div>
                    <div class="form-group">
                        <label>{$pharse.password}</label>
                        <input class="form-control" type="password" name="password"
                               data-parsley-required-message="Please enter Password" id="passwordp" class="gui-input"
                               placeholder="Password" data-parsley-minlength="6"
                               data-parsley-minlength-message="Please enter a minimum of 6 characters"
                               data-parsley-length-message="Please enter a minimum of 6 characters"
                               data-parsley-type-message="Password should be alphanumeric" data-parsley-type="alphanum"
                               data-parsley-group="block1" data-parsley-required value="{$registerdata.password}"/>
                    </div>
                    <div class="form-group">
                        <label>{$pharse.confirm_password}</label>
                        <input class="form-control" type="password" name="repassword" id="qpasswordp2" class="gui-input"
                               data-parsley-required-message="Please enter confirm password"
                               placeholder="Confirm Password" data-parsley-group="block1"
                               data-parsley-equalto="#passwordp" data-parsley-minlength="6" data-parsley-required
                               value="{$registerdata.password}"/>
                    </div>

                    <div class="form-group">
                        <label>{$pharse.country}</label>
                        <select id="country" name="country" class="form-control" required data-parsley-required-message="Please select country"></select>
                    </div>

                    <div class="form-group">
                        <label>{$pharse.state}</label>
                        <select id="state" name="state" class="form-control" required data-parsley-required-message="Please select state"></select>
                    </div>

                    <input type="hidden" name="hidden_country" id="hidden_country" value="{$registerdata.country}">
                    <input type="hidden" name="hidden_state" id="hidden_state" value="{$registerdata.state}">

                    <div class="form-group">
                        {$captchahtml}
                        <p style="color:red;width:100%;float:left;clear:both;"></p>

                    </div>

                    <div class="agree_terms register-toggle check_opt">
                        <input type="checkbox" class="pull-left" name="agree" value="1" id="agree"/>&nbsp;
                        <label for="agree" class="pull-left" style="padding-left: 10px;">{$pharse.i_agree_to_the} <a
                                href="{$config.url}/termcondition" target="_blank">{$pharse.terms_and_conditions}</a></label>
                    </div>
                    <button class="btn lg_bbtn">{$pharse.join_us}</button>
                    <div class="spacer-b30">
                        <div class="tagline"><span>{$pharse.or}</span></div>
                        <!-- .tagline -->
                    </div>
                </form>
                <a href="{$config.url}/facebook/auth/facebook">
                    <button class="field prepend-icon btn btn-primary fb_btn"><label for="lastname"
                                                                                     class="field-icon"><i
                            class="fa fa-facebook"></i></label>&nbsp;&nbsp;{$pharse.login_with_facebook}
                    </button>
                </a>

            </div>
        </div>
    </div>
</div>
<div class="modal confirmbid  fade" id="Login" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog trans_bck">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <h2>{$pharse.login}</h2>

                <div class="text-danger">{$login_error}</div>

                <span id="form_proces_res_1" class="error_popup"></span>

                <form action="{$config['url']}/login/save" method="post" data-parsley-validate
                      enctype="multipart/form-data" id="loginform">
                    <div class="form-group">
                        <label>{$pharse.email}</label>
                        <input class="form-control" data-parsley-required-message="Email is required"
                               class="form-control gui-input email" type="email" name="username" id="u_name" size="30"
                               value="{$cookieemail}" autocomplete="off" required data-trigger="change"
                               placeholder="Email Address"/>
                    </div>
                    <div class="form-group">
                        <label>{$pharse.password}</label>
                        <input type="password" name="password" data-parsley-required-message="Password is required"
                               value="{$cookiepassword}" class="form-control" id="u_pass" size="30" autocomplete="off"
                               required data-trigger="change" class="gui-input" placeholder="Password"/>
                    </div>

                    <div class="agree_terms">
                        <div class="login_check wid100">
                            <input type="checkbox" name="remember" id="rememberme" value="1" checked="checked">

                            <p class="remeber"><label for="rememberme">{$pharse.remember_me}</label></p>
                            <label><a href="{$config['url']}/login/forgot_password" title="Forgot password">{$pharse.forgot_password?}</a></label>
                        </div>
                    </div>
                    <button class="btn lg_bbtn" onclick="encrLogin2()">{$pharse.member_login}</button>
                    <div class="spacer-b30">
                        <div class="tagline"><span>{$pharse.or}</span></div>
                        <!-- .tagline -->
                    </div>
                </form>
                <a href="{$config.url}/facebook/auth/facebook">
                    <button class="field prepend-icon btn btn-primary fb_btn"><label for="lastname"
                                                                                     class="field-icon"><i
                            class="fa fa-facebook"></i></label>&nbsp;&nbsp;{$pharse.login_with_facebook}
                    </button>
                </a>

            </div>
        </div>
    </div>
</div>
{/if}
</div>
<div class="modal fade" id="verifyinfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content phone-content">
            <div class="modal-header">
                <h3>{$pharse.verify_phone_number}</h3>
                <span class="text-danger font-15">{$pharse.add_the_country_code_with_the_phone_number_please_enter_the_following_6_digit_number_while_we_call_you}</span>
                 <div class="modal-body">
                        <span class="verification"></span>

                 </div>
            </div>
        </div>
    </div>
</div>
{if $loged.phonevalid == ''  and $phonecheckup == 1}
<div class="modal fade" id="phoneinfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content phone-content">
            <div class="modal-header">
                {$pharse.forward_auction_demo}
                <span class="text-danger font-10">{$pharse.either_we_will_call_or_sms_right_away_and_give_a_5_digit_code} </span>
            </div>
            <div class="modal-body">
                <form action="javascript:void(0);" id="phone_popup_form" method="POST" data-parsley-validate
                      enctype="multipart/form-data">
                    <div class="err_phne_label"></div>

                    <div class="row">
                        <div class="col-md-12 m-top-10">{$pharse.email}</div>
                        <div class="col-md-12 m-top-10"><input class="form-control" data-parsley-required name="email"
                                                               placeholder="Enter your Email"/></div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 m-top-10">{$pharse.first_name}</div>
                        <div class="col-md-12 m-top-10"><input class="form-control" data-parsley-required
                                                               name="first_name" placeholder="Enter your first name"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 m-top-10">{$pharse.last_name}</div>
                        <div class="col-md-12 m-top-10"><input class="form-control" data-parsley-required
                                                               name="last_name" placeholder="Enter your last name"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 m-top-10">{$pharse.phone_number}
                        </div>
                        <div class="col-md-12 m-top-10"><input class="form-control" data-parsley-required name="address"
                                                               placeholder="Enter your phone number"/></div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 m-top-10">{$pharse.country}</div>
                        <div class="col-md-12 m-top-10"></div>
                    </div>

            </div>

            <div class="row">
                <div class="col-md-offset-5 col-md-3">
                    <div type="submit" class="btn btn-danger" value="Save"
                         onclick="checkValidPhone('phone_popup_form',1)">{$pharse.save}

                    </div>
                </div>
            </div>
            </form>
        </div>

        <div class="modal-content code-content hide">
            <div class="modal-header">
                {$pharse.enter_your_code}
            </div>
            <div class="modal-body">
                <form action="javascript:void(0);" id="code_popup_form" method="POST" data-parsley-validate
                      enctype="multipart/form-data">
                    <div class="err_phne_label"></div>

                    <div class="row">
                        <div class="col-md-12"><input class="form-control" data-parsley-required name="key"
                                                      placeholder="Enter your code"/></div>
                    </div>

            </div>

            <div class="row">
                <div class="col-md-offset-5 col-md-3">
                    <div type="submit" class="btn btn-danger" value="Save"
                         onclick="checkValidCode('code_popup_form',1)">{$pharse.save}
                    </div>
                </div>
            </div>
            </form>
        </div>
    </div>
</div>
</div>

</div>


{/if}
{if $loged.userid > 0 and $loged.zipcode == ''}


<div class="modal fade" id="userinfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                {$pharse.user_information}
            </div>
            <div class="modal-body">
                <form action="/profile_settings/address" id="address_popup_form" method="POST" data-parsley-validate
                      enctype="multipart/form-data">
                    <div class="update_lbl">{$pharse.please_update_your_information_thank_you_for_choosing}</div>
                    <div class="usr_inf_img">
                        <img src="{$config.url}/images/logoc.png" class="img-responsives"/>
                    </div>
                    <div class="row">
                        <div class="col-md-3 usr_info_lbl">{$pharse.address1}</div>
                        <div class="col-md-6"><input class="form-control" data-parsley-required name="address"
                                                     placeholder="Enter your address"/></div>
                    </div>
                    <div class="row">
                        <div class="col-md-3 usr_info_lbl">{$pharse.address2}</div>
                        <div class="col-md-6"><input class="form-control" name="address2" placeholder="Optional"/></div>
                    </div>
                    <div class="row">
                        <div class="col-md-3 usr_info_lbl">{$pharse.zip_code}</div>                        <div class="col-md-6">
                            <div><input class="form-control" data-parsley-required name="zipcode"
                                        placeholder="Enter Zip Code" id="zipcode"
                                        onblur="checkStateCity('address_popup_form',0)"/></div>
                            <input type="hidden" name="state" id="state" value="{$user.state}"/>
                            <input type="hidden" name="country" id="country" value="{$user.country}"/>
                            <input type="hidden" name="city" id="city" value="{$user.city}"/>
                            <br/>

                            <div class="form-group addresscity font-14">

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-offset-5 col-md-3">
                            <div type="submit" class="btn btn-danger" value="Save"
                                 onclick="checkStateCity('address_popup_form',1)">{$pharse.save}
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

</div>
{/if}
<script src="{$config['externaljs']}owl.carousel.js"></script>
<script src='https://www.google.com/recaptcha/api.js'></script>

<!--<script src="{$config['externaljs']}common.js" type="text/javascript"></script>-->
<script type="text/javascript" language="javascript" src="{$config['externaljs']}bootstrap.js"></script>
<script type="text/javascript" language="javascript" src="{$config['externaljs']}register.js"></script>
<script>
    function view_dispute(id)
    {
        $('#dispute_submit').find("input[type=text], textarea").val("");
        $('#dispute_pid').val(id);
        $('#dispute').modal('show');
    }
    $('#save_dispute').click(function(){
        if(true === $('#dispute_submit').parsley().validate()) {
            var params = $('#dispute_submit').serialize();
            $.ajax({
                type: "POST",
                url: "/product/save_dispute",
                data: params,
                dataType: 'json',
                success: function (data) {
                    if (data.success) {
                        alert("Dispute has been added successfully");
                        $('#dispute').modal('hide');
                    }

                }
            });
        }else{
            return false;
        }

    });

</script>
{if $loged.phonevalid == '' and $phonecheckup == 1}
<script type="text/javascript">
    $(function () {
        $('#phoneinfo').modal('show');

    });
    function checkValidCode(id, r) {
        var params = $('#' + id).serialize();
        $.ajax({
            type: "POST",
            url: "/phone_setup_code?cmd=3",
            data: params,
            dataType: 'json',
            success: function (data) {
                if (data.success) {
                    $('#phoneinfo').modal('show');
                }
                else {
                    window.location.href = '{$config.url}'
                }
            }
        });
    }
    function checkValidPhone(id, r) {
        var params = $('#' + id).serialize();

        $.ajax({
            type: "POST",
            url: "/phone_setup?cmd=2",
            data: params,
            dataType: 'json',
            success: function (data) {
                if (data.error) {
                    alert(data.message);
                }
                else {
                    $('.phone-content').addClass('hide');
                    $('.code-content').removeClass('hide');
                }
            }
        });

    }
</script>
{/if}
<script type="text/javascript">

    var formFunction = '';
    function closeAll() {
        $.ajax({
            type: "GET",
            url: "{$config.url}/product/closeall",
            data: '',
            success: function (data) {


            }
        });

    }
    $(function () {
        try {
            if (performance.navigation.type !== performance.navigation.TYPE_BACK_FORWARD) {

            } else {
                console.log("Back button pressed");
                if ($('.timer_cnt .cnter').html() != '0') {

                    location.reload();
                    console.log("With timer back button pressed");
                }

            }
        }catch(e){
            console.log(e);
        }
        populateCountries("country", "state");

        closeAll();
        if (typeof(startDate) !== 'undefined')
            $("#date_added").datepicker({minDate: startDate});

    });
    function intializeForm(form) {
        formFunction = form;
    }
    function checkStateCity(form, id) {
        var params = {};
        if (window.XDomainRequest) {
            if (window.XDomainRequest) {
                var xdr = new XDomainRequest();
                var query = "//maps.googleapis.com/maps/api/geocode/json?address=" + $('#' + form + ' #zipcode').val();
                if (xdr) {
                    xdr.onload = function () {

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
                url: "//maps.googleapis.com/maps/api/geocode/json?address=" + $('#' + form + ' #zipcode').val(),
                data: params,

                success: function (data) {
                    sZipcode(data, form, id);


                }
            });
        }
    }
    function sZipcode(data, form, id) {

        if (data['results'].length > 0) {
            var m = data['results'][0]['address_components'].length;
            if (typeof(data['results'][0]['address_components'][m - 3]) === 'undefined') {
                alert('Invalid Zipcode');
                //$('#'+form+' #zipcode').focus();
                $('#' + form + ' .addresscity').html('Invalid Zipcode');
                return false;
            }
            $('#' + form + ' #city').val(data['results'][0]['address_components'][m - 3]['long_name']);
            $('#' + form + ' #state').val(data['results'][0]['address_components'][m - 2]['long_name']);
            $('#' + form + ' #country').val(data['results'][0]['address_components'][m - 1]['long_name']);
            $('#' + form + ' .addresscity').html($('#city').val() + ',' + $('#state').val() + ',' + $('#country').val());
            if (id == 1) {
                $('#' + form).submit();
            }
            if (id == 2) {
                formFunction();
            }
        }
        else {
            alert('Invalid Zipcode');
            //$('#'+form+' #zipcode').focus();
            $('#' + form + ' .addresscity').html('Invalid Zipcode');
            return false;
        }
    }

</script>
{foreach $external2js as $key => $val}
<script src="{$config['externaljs']}{$val}.js" type="text/javascript"></script>
{/foreach}
{if $register_fail == 1}
<script type="text/javascript">
    $(function () {
        $('#registration').modal('show');
        $('#country').val('{$registerdata.country}');
        populateStates("country", "state");
        $('#state').val('{$registerdata.state}');
    });
</script> {/if}
{if $login_fail == 1}
<script type="text/javascript">
    $(function () {
        $('#Login').modal('show');
    });
</script> {/if}
{if $timer > 0}
<script type="text/javascript">
    $(function () {
        runTimer();
    });
</script>
{else}
<script type="text/javascript">
    $(function () {
        removeAllItems();
    });
</script>
{/if}
<script type="text/javascript">
    $(function () {
        $('.cart').on('click', function () {
            var k = parseInt($(this).html());
            if (k == 0) {
                return false;
            }
           /* else {
                window.location = '{$config.url}/product/checkout/cart/'
            }*/
        });
    });
</script>
{if $loged.userid > 0 and $loged.zipcode == '' and $disable_zip_popup != 1}
<script type="text/javascript">
    $(document).ready(function () {
        //loadCity();

        $(function () {
            $('#country').on('change', function () {
                var m = $('#country option[value="' + $(this).val() + '"]').attr('attr');

                //$('#state').html('');
                loadLocation('country', m, '', '');
                $('#states').parent().find('ul li.parsley-required').hide();
                $('#cities').parent().find('ul li.parsley-required').hide();


            });
            $('#states').on('change', function () {
                var m = $('#states option[value="' + $(this).val() + '"]').attr('attr');

                //$('#state').html('');
                loadLocation('state', m, '', '');
                $('#cities').parent().find('ul li.parsley-required').hide();

            });
        });
        /* $('#userinfo').modal({
         show: true,
         })*/


    });

</script>
{/if}

{/if}
<div style="clear:both"></div>
</body>
</html>
