var index = 1;
$('.registration-form fieldset:first-child').fadeIn('slow');

// next step
$('.registration-form .btn-next').on('click', function () {
    var parent_fieldset = $(this).parents('fieldset');
    var next_step = true;
    $('#registration_form').parsley('destroy')
    $('#registration_form').parsley()
    if ($('#registration_form').parsley().validate("block" + index)) {
        index++;
        console.log(index);
        setRegistrationInstruction(index);
        if (next_step) {
            parent_fieldset.fadeOut(400, function () {
                $(this).next().fadeIn();
                setTitle();
            });
        }
    }
    
});

function setRegistrationInstruction(index){
    switch(index){
        case 1 :{
            $('#registrationInstructions').text('Enter your Business Name, Business Phone Number, and Business Email, as well as the username you will use in the marketplace. Most Herbee members use their business name or their Trade/DBA Name on the site!');
            break;
        }
        case 2 :{
            $('#registrationInstructions').text('Herbee distributes your product into the market! So that when you buy and sell on the platform, your deals get completed in real life. To help us help you, tell us where to pick up and deliver product below:');
            break;
        }
        case 3 :{
            $('#registrationInstructions').text('Growers, Producers, and Dispensaries all have different needs. To Herbee producers are any license holder that makes a cannabis product, that means manufacturers and microbusinesses. Only state licensed cannabis business can join the marketplace, to verify your business is registered you need to upload your cannabis license and business license or seller permit below:');
            break;
        }
        default :{
            $('#registrationInstructions').text('');
            break;
        }
    }
}
function setTitle() {
    if ($("#registration_form").find('fieldset:nth-child(4)').css('display') != 'none') {
        $('.registration_title').html('Sales Support Details');
    } else if ($("#registration_form").find('fieldset:nth-child(3)').css('display') != 'none') {
        $('.registration_title').html('Distribution/Transportation Details');
    } else if ($("#registration_form").find('fieldset:nth-child(2)').css('display') != 'none') {
        $('.registration_title').html('Address Details');
    } else {
        $('.registration_title').html('User Details');
    }
}
// previous step
$('.registration-form .btn-previous').on('click', function () {
    $(this).parents('fieldset').fadeOut(400, function () {
        $(this).prev().fadeIn();
        index--;
        console.log(index);
        setRegistrationInstruction(index);
        setTitle();
    });
});

// submit
$('.registration-form').on('submit', function (e) {

    // $(this).find('input[type="text"], input[type="password"], textarea').each(function() {
    //  if( $(this).val() == "" ) {
    //      e.preventDefault();
    //      $(this).addClass('input-error');
    //  }
    //  else {
    //      $(this).removeClass('input-error');
    //  }
    // });

});

var checkusername = 0;
var checkemail = 0;
var checksccode = 0;

$("#registration_form input[name=username]").focusout(function () {
    if($("#username").val().trim() == '') {
        $('#username-check-err').text("");
        return true;
    }
    $.ajax({
        type: 'POST',
        url: '/register/check_username_exist',
        data: {
            username: $("#username").val()
        },
        dataType: 'json',
        success: function (data) {
            // console.log(data)
            if (data == 1) {
                checkusername = 1;
                $('#username-check-err').text("Username already exist");
                $("input[name=username]").val('');
                $('.registration-form .btn-next').prop('disabled', true);
            } else if (data == 0) {
                checkusername = 0;
                $('#username-check-err').text('');
                //$('#username-check-err').empty();
                if (checkemail == 0) {
                    $('.registration-form .btn-next').prop('disabled', false);
                }
            }
        }
    });

});

/* ===================== start change by divyesh (changes) ===================== */
$(".registration-form input[name=email]").focusout(function () {
    $.ajax({
        type: 'POST',
        url: '/register/check_email_exist',
        data: {
            email: $("input[name=email]").val()
        },
        dataType: 'json',
        success: function (data) {
            // console.log(data)
            if (data == 1) {
                checkemail = 1;
                $('#email-check-err').text("Email id already exist");
                $("input[name=email]").val('');
                $('.registration-form .btn-next').prop('disabled', true);
            } else if (data == 0) {
                checkemail = 0;
                $('#email-check-err').text('');
                // $('#email-check-err').empty();
                if (checkusername == 0) {
                    $('.registration-form .btn-next').prop('disabled', false);
                }

            }
        }
    });

});
/* ===================== end change by divyesh (changes) ===================== */

/* ===================== start change by divyesh (added) ===================== */
$(".registration-form input[name=sccode], .registration-form input[name=csccode]").focusout(function () {
    $('#sccode-register-err').text("");

    if ($("input[name=csccode]").val().trim() === '' || $("input[name=sccode]").val().trim() === '') {
        if ($("input[name=sccode]").val().trim() === '') {
            $('#sccode-register-err').text("Please enter Sales Consultant Code");
        }
        return true;
    }
    if ($("input[name=csccode]").val().trim() !== $("input[name=sccode]").val().trim()) {
        return true;
    }
    console.log('$("input[name=old_sc_code]")', $("input[name=old_sc_code]").length);
    if ($("input[name=old_sc_code]").length) {
        if ($("input[name=csccode]").val() === $("input[name=old_sc_code]").val()) {
            return true;
        }
    }

    $.ajax({
        type: 'POST',
        url: '/register/check_sales_consultant_code_exist',
        data: {
            email: $("input[name=email]").val(),
            sccode: $("input[name=csccode]").val()
        },
        dataType: 'json',
        success: function (data) {
            console.log('data', data['exists']);
            if (data['exists'] == true) {
                checksccode = 0;
                $('#sccode-register-err').text("");
                if (checkusername == 0) {
                    $('.registration-form .btn-next').prop('disabled', false);
                }
            } else {
                checksccode = 1;
                $('#sccode-register-err').text("Sales consultant code is invalid");
                // $("input[name=sccode]").val('');
                // $("input[name=csccode]").val('');
                // $("input[name=sccode]").focus();
                // $('.registration-form .btn-next').prop('disabled', true);
            }
        }
    });

});
/* ===================== end change by divyesh (added) ===================== */



$(".registration-form input[name=phone]").focusout(function () {
    $.ajax({
        type: 'POST',
        url: '/register/check_phone_exist',
        data: {
            phone: $("input[name=phone]").val()
        },
        dataType: 'json',
        success: function (data) {
            // console.log(data) 
            if (data == 1) {
                checkemail = 1;
                $('#phone-check-err').text("This should be a different phone number than previously used.");
                $("input[name=email]").val('');
                $('.registration-form .btn-next').prop('disabled', true);
            } else if (data == 0) {
                checkemail = 0;
                $('#phone-check-err').text('');
                // $('#email-check-err').empty();
                if (checkusername == 0) {
                    $('.registration-form .btn-next').prop('disabled', false);
                }

            }
        }
    });

});