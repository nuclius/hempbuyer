{include file="/common/header-1.tpl" nocache}
<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"
        async defer>
    </script>
<div class="home-container">
    <section class="clearfix top-banner contact-banner">
        <div class="container">
            <div class="tbcon-wrap">
                <h1>CONTACT HEMPBUYER AUCTION</h1>
                <p>We are committed to improving your industry sales experience our promise is to provide a membership based sales community platform based upon honesty, integrity and professionalism. Think of us as your personal sales and marketing team. Please contact us with your suggestions. We are always looking for ways to provide value to you and your business.</p>
            </div>
        </div>
    </section>
    <section class="contact-us-wrapper">
        <div class="container">
             <div class="row">
                <div class="col-md-6">
                    <div class="chead-wrap">
                        <h4>Question or Comments</h4>
                        <p>
                            Please get in touch.
                        </p>
                    </div>
                    <form class="contact_form" data-parsley-validate novalidate>
                        <div class="form-group">
                            <label class="sf-label">Name</label>
                            <div class="icon-input"> 
                                 <div class="icon-box">
                                     <img src="images/user.png" alt="" />
                                 </div>
                                 <input class="form-control" placeholder="Full Name" name="contact_name" id="contact_name" required />
                            </div> 
                        </div>
                        <div class="form-group">
                            <label class="sf-label">Email</label>
                            <div class="icon-input"> 
                                 <div class="icon-box pwd-box">
                                     <img src="images/email.png" alt="" />
                                 </div>
                                 <input type="email" class="form-control" placeholder="Email" name="contact_email" id="contact_email" required />
                            </div> 
                        </div>
                        <div class="form-group">
                            <label class="sf-label">Phone Number</label>
                            <div class="icon-input"> 
                                 <div class="icon-box pwd-box">
                                     <img src="images/mobile.png" alt="" />
                                 </div>
                                 <input class="form-control phone_us" placeholder="Phone Number" name="contact_phone" id="contact_phone" required parsley-type="phone" data-parsley-trigger="change" data-parsley-minlength="17" data-parsley-minlength-message="Phone number is invalid." />
                            </div> 
                        </div>

                       <div class="form-group">
                            <label class="sf-label">Subject</label>
                            <div class="icon-input"> 
                                 <div class="icon-box pwd-box">
                                     <img src="images/subject.png" alt="" />
                                 </div>
                                 <input class="form-control" placeholder="Subject" name="contact_subject" id="contact_subject" required />
                            </div> 
                        </div> 
                       <div class="form-group">
                            <label class="sf-label">Messages</label>
                            <textarea class="form-control" rows="4" name="contact_message" id="contact_message" required ></textarea>
                        </div>
                        <div class="form-group clearfix">
                            <div class="cus-check float-left">
                                <input type="checkbox" checked="checked" id="contact_email_notify">
                                <span class="checkmark"></span>I would like to receive email communications
                            </div> 
                        </div>
                        <div class="form-group clearfix">
                            <div id="html_element"></div>
                        </div>
                        <div class="pt-3">
                            <button type="button" class="btn btn-brown submit-contact">SUBMIT</button>
                            <span id="contactError" style="text-align: center;"></span>
                        </div>
                    </form>
                </div>
                <div class="col-md-6">
                    <div class="chead-wrap">
                        <h4>CONTACT ADDRESS</h4>
                    </div>
                    <address class="contactAddr">
                        <b>1 Lucky Dog LLC</b><br />
                        <a href="tel:1-800-420-4196" class="contactPhn"><i class="fas fa-phone-alt"></i><b>1-800-420-4196</b></a>
                        <span class="">San Clemente, CA 92672</span>
                        <br />

                        <p>For Technical Support:</p>
                        <a href="mailto:support@hempbuyer.com" class="text-du">support@hempbuyer.com</a>
                        <p>Shop Wholesale Hemp/CBD Products:</p>
                        <a href="https://hempbuyer.com/" target="_blank" class="text-du">www.hempbuyer.com</a>
                        <a href="https://www.hempbuyerauction.com/" target="_blank" class="text-du">www.hempbuyerauction.com</a>
                    </address>
                </div>
             </div>
        </div>
    </section> 
</div>

{include file="/common/footer-1.tpl" nocache}

<script type="text/javascript">
var captchaVerified = 0;
    var onloadCallback = function() {
        grecaptcha.render('html_element', {
          // 'sitekey' : '6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI',
          'sitekey' : '{$google_captcha}',
          'callback' : verifyCallback,
          'expired-callback': onRecaptchaExpired,
          'theme' : 'light'
        });
    };
    var verifyCallback = function(response) {
        console.log('response', response);
        if(response) {
            captchaVerified = 1;
        }
    };
    var onRecaptchaExpired = function () {
        // You can reset it automatically if you want
        // grecaptcha.reset();
        captchaVerified = 0;
    };

    $(document).ready(function() {
        $('#contact_phone').mask('+1 (000) 000-0000');

        $('body').on('click', '.submit-contact', function (e) {
            if ($('.contact_form').parsley().validate()) {
                if(!captchaVerified) {
                    alert("Please verifiy the captcha");
                    return true;
                }
                var dataobj = {
                    contact_name : $('#contact_name').val(),
                    contact_email : $('#contact_email').val(),
                    contact_phone : $('#contact_phone').val(),
                    contact_subject : $('#contact_subject').val(),
                    contact_message : $('#contact_message').val(),
                    contact_email_notify : $('#contact_email_notify').is(":checked") ? 1 : 0
                };
                console.log(dataobj);
                $.ajax({
                    type: "POST",
                    url: "{$config.url}/saveContactUs",
                    data: dataobj,
                    dataType: 'json',
                    success: function (data) {
                        if(data.status == 'success') {
                            $('#contact_name, #contact_email, #contact_phone, #contact_subject, #contact_message').val('');
                            $('#contactError').html(data.statusText).css('color', 'green');
                        } else {
                            $('#contactError').html(data.statusText).css('color', 'red');
                        }
                        window.location.reload();
                    }
                });
            }
        });
    });
</script>