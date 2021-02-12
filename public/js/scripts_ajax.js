

	
    // /*
    //     Fullscreen background
    // */
    // $.backstretch("assets/img/backgrounds/1.jpg");
    
    // $('#top-navbar-1').on('shown.bs.collapse', function(){
    // 	$.backstretch("resize");
    // });
    // $('#top-navbar-1').on('hidden.bs.collapse', function(){
    // 	$.backstretch("resize");
    // });
    
    /*
        Form
    */

    var index = 1;
    $('.registration-form fieldset:first-child').fadeIn('slow');
    
    // $('.registration-form input[type="text"], .registration-form input[type="password"], .registration-form textarea').on('focus', function() {
    // 	$(this).removeClass('input-error');
    // });
    
    // next step
/*    $('.registration-form .btn-next').on('click', function() {
    	var parent_fieldset = $(this).parents('fieldset');
    	var next_step = true;
        if($('#registration_form').parsley().validate("block"+index)){
        	index++;
            console.log(index);
       	
        	if( next_step ) {
        		parent_fieldset.fadeOut(400, function() {
    	    		$(this).next().fadeIn();
    	    	});
        	}
    	}
    });*/
    
    $('.registration-form .btn-next').on('click', function() {
        
        if(index == 1){
            $.ajax({
                type : 'POST',
                url : '/register/check_email_exist',
                data:{
                    username : $("input[name=username]").val(),
                    email : $("input[name=email]").val()
                },
                dataType : 'json',
                success : function(data) {

                    if(data.email || data.username){
                        
                        if(data.email){
                            $('#email-register-err').text("Email id already exist");
                        } else {
                             $('#email-register-err').remove();
                        }

                        if(data.username){
                            $('#username-err').text("username already exist");
                        } else {
                            $('#username-err').remove();
                        }

                    } else {
                        console.log('page'+index);
                         $('#username-err').remove();
                         $('#email-register-err').remove();
                         console.log($(this));
                        var parent_fieldset = $(this).parents('fieldset');
                        var next_step = true;
                        if($('#registration_form').parsley().validate("block"+index)){
                            index++;
                            console.log(index);
                            if( next_step ) {
                                parent_fieldset.fadeOut(400, function() {
                                    $(this).next().fadeIn();
                                });
                            }
                        }
                    }

                }
            });
        } else {
            console.log('page'+index);
            var parent_fieldset = $(this).parents('fieldset');
            var next_step = true;
            if($('#registration_form').parsley().validate("block"+index)){
                index++;
                console.log(index);
                if( next_step ) {
                    parent_fieldset.fadeOut(400, function() {
                        $(this).next().fadeIn();
                    });
                }
            }
        }
        
    });

    // previous step
    $('.registration-form .btn-previous').on('click', function() {
    	$(this).parents('fieldset').fadeOut(400, function() {
    		$(this).prev().fadeIn();
            index--;
            console.log(index);
    	});
    });
    
    // submit
    $('.registration-form').on('submit', function(e) {
    	
    	// $(this).find('input[type="text"], input[type="password"], textarea').each(function() {
    	// 	if( $(this).val() == "" ) {
    	// 		e.preventDefault();
    	// 		$(this).addClass('input-error');
    	// 	}
    	// 	else {
    	// 		$(this).removeClass('input-error');
    	// 	}
    	// });
    	
    });
    
    

