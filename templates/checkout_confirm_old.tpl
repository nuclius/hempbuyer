{include file="/common/header-1.tpl" nocache}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}ds-forms.css" />
<script src="https://js.braintreegateway.com/v2/braintree.js"></script>
<script type="text/javascript">
  braintree.setup("{$clientTokens}", "custom", {
                id: "checkoutcc",
                hostedFields: {
                  number: {
                    selector: "#card-number",
                    placeholder: 'Card Number'
                  },
                  cvv: {
                   selector: "#security-code-field",
                   placeholder: 'CVV'
                  },
                  expirationDate: {
                    selector: "#expiration-date",
                    placeholder: 'MM/YYYY'
                  }
                },
                onPaymentMethodReceived: launchValidation,
                onError: list_error
            });
  function launchValidation(obj){

    if(obj.nonce){
      if(true === $('#paypal-form').parsley().validate())
        {
            $('#nounce').val( obj.nonce );
            $('#checkoutcc').submit();
        }
        else{
          alert('Something Went wrong ! Please try agin later');
        }

    }
    else{
       alert('Something Went wrong ! Please try agin later');
    }
  }
  function list_error(obj){
    alert(obj.message);
  }
</script>
<style>
.main_wrapper {
    margin: 20px auto 0px;
    min-height: 540px;
}
.ship_overlay1 {
  height: auto;
}
.hidediv
{
  display:none;
}
.final_step{
  display:none;
}
.sec_step{
  display:none;
}
.next_btn_wrap{
    margin: 20px auto;
    text-align: center;
}
</style>
{include file="common/dashboard-navigation.tpl" nocache}
<!-- 
<div class="container-fluid bgBannerFluid">
        <h1>Checkout</h1>
            <div class="row">
                <div class="col-md-12 confLinkCol">
                    <ul>
                       <a href="{$config.url}/market/selection"><li>
                        <i class="fa fa-home" aria-hidden="true"></i>
                        Welcome Page</li></a>
                        {if $loged.storeid >0} <a href="{$config.url}/stores/view/{$loged.storeid}"><li><img src="{$config.url}/images/manage.png" alt="">Manage Store</li></a> {/if}
                         {if $loged.storeid > 0}  <a href="{$config.url}/product/post/{$loged.storeid}"><li><i class="flaticon-business"></i>Post an item</li></a> {/if}
                        {if $loged.storeid == 0}  <a href="{$config.url}/stores/create"><li><i class="flaticon-business"></i>Create New Store</li></a> {/if}
                        <a href="{$config.url}/stores/show_adwords"><li><img src="{$config.url}/images/ads.png" alt="">Manage Ads</li></a>
                        <a href="#"><li><img src="{$config.url}/images/transaction.png" alt="">Recent Sales</li></a>

                        <a href="#"><li><img src="{$config.url}/images/reports.png" alt="">Reports</li></a>
                        <li style="position:relative">
                          <button class="dropdown-toggle" type="button" id="menu1" data-toggle="dropdown"><i class="flaticon-settings"></i>Settings
                          <span class="caret"></span></button>
                          <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">

                          <li role="presentation"><a role="menuitem" tabindex="-1" href="dashboard-profile.html">Profile</a></li>
                          <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Messages</a></li>
                          <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Payments</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Contact information</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Change Password</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Shipping address changes</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Billing and Account Information</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Notifications</a></li>
                          </ul>
                        </li>

                    </ul>
                </div>
            </div>
    </div>
 -->
 
    <div class="container-fluid p0">

      <div class="container m50">
        <div class="row flex">
        {$total=0}
          {foreach $loged.products as $key => $val}
          {$total=sumFloat($total,$val.qty_add)*sumFloat($val.bprice,$val.shipping_price)}
           {/foreach}
          <div class="col-md-5 margin-auto">
            <div class="checkbox">
               <label class="p0">
                  <input type="checkbox"  name="delivery_address_shipping" checked onclick="shipping_add(1)" />
                 <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                 Saved Shipping Address
               </label>
             </div>
            <ul class="lh-22 p0">
              <li class="p5"><b class="f16">{$shipping.first_name} {$shipping.last_name}</b></li>
              <li class="p5">{$shipping.address},{$shipping.city}</li>
              <li class="p5">{$shipping.state}, {$shipping.country}, {$shipping.zipcode}</li>
              <li class="p5">Email : {$shipping.email}</li>
            </ul>
<br>
            <h4 class="green-text"><b>Total Amount to Be Paid - US $ {$hidamt}</b></h4>

            <h4 class="grey-text">Select Payment Method</h4>

  <br>

            <div class="row">
              <div class="col-md-12 form-group">
                  <div class="radio radio-inline radio-primary pull-left">
                    <input type="radio" name="radio1" id="radio1" value="yes">
                    <label for="radio1"> Credit / Debit Card </label>
                    </div>
                    <div class="radio radio-inline radio-primary">
                    <input type="radio" name="radio1" id="radio2" value="no"  checked="checked">
                    <label for="radio2"> Bank Account </label>
                    </div>
                </div>

    <div class="col-md-6">
      <div class="form-group">
        <div class="input-group w100">
            <input type="email" class="w100 p15 pb15 grey-bg border1" id="exampleInputEmail1" value="{$bankname}" placeholder="Bank Name">

        </div>
      </div>
    </div>

    <div class="col-md-6">
      <div class="form-group">
        <div class="input-group w100">
            <input type="email" class="w100 p15 pb15 grey-bg border1" id="exampleInputEmail1" value="{$bankno}" placeholder="Bank Account Number">

        </div>
      </div>
    </div>

  </div>

            <div class="row">

          <div class="col-md-6">
          <div class="form-group">
          <div class="input-group w100">
            <input type="email" class="w100 p15 pb15 grey-bg border1" id="exampleInputEmail1" value="{$banktname}" placeholder="Name on Account">

          </div>
          </div>
          </div>

          <div class="col-md-6">
          <div class="form-group">
          <div class="input-group w100">
            <select class="w100 p15 pb15 grey-bg border1" name="region" id="region" data-parsley-required="" data-parsley-required-message="Please select region" place-holder="Select Region">

                            <option value="">Account Type</option>
                            <option value="" selected>{$banktype}</option>
                            <option value="northwest">Check</option>
                            <option value="southwest">Savings</option>
                            <
                        </select>

          </div>
          </div>
          </div>

          </div>

          <button class="btn btn-default btn-d-b green-b m0" type="button">PAY</button>


          </div>


          <div class="col-md-2 margin-auto">
            <div class="or-circle margin-auto block">
              OR
            </div>
          </div>
          <div class="col-md-5">

            <div class="row">

              <div class="checkbox">
                 <label>
                   <input type="checkbox"  name="delivery_address" onclick="shipping_add(0);" {if $shipping.first_name == ''} checked {/if}  />
                   <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                   Adding new shipping address
                 </label>
               </div>
               <div class="col-md-6 form-group">



                  <div class="input-group w100">
                  <input type="text" class="w100 p15 pb15 grey-bg border1" id="f_name" name="f_name" placeholder="Username" value="" data-parsley-required tabindex="1" >

                  </div>
              </div>

              <div class="col-md-6 form-group">

                 <div class="input-group w100">
                 <!-- <input type="email" class="w100 p15 pb15 grey-bg border1" id="exampleInputEmail1" value="" placeholder="Email"> -->
                  <input type="email" class=" w100 p15 pb15 grey-bg border1" id="email" name="email" placeholder="E-Mail" value="" data-parsley-required def="{$shipping.email}" tabindex="3">

                 </div>


              </div>

              <div class="col-md-12 form-group">
                  <textarea class="w100 p15 pb15 grey-bg border1" rows="4" id="comment" placeholder="Address" ></textarea>
              </div>
              <div class="col-md-6">
                    <div class="form-group">
                      <!-- <select class="w100 p15 pb15 grey-bg border1" id="sel1"> -->
                       <select class="w100 p15 pb15 grey-bg border1" name="country" id="country" data-parsley-required-message="Please select country"  required>
                       <option value="">Country</option>
                        <option selected></option>
                        <option >USA</option>
                      </select>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                      <select class="w100 p15 pb15 grey-bg border1" id="sel1">
                      <option value="">State</option>
                        <option selected></option>
                        <option>Orlando</option>
                      </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                      <select class="w100 p15 pb15 grey-bg border1" id="sel1">
                      <option value="">City</option>
                        <option></option>
                        <option>Newyork city</option>
                      </select>
                    </div>
                </div>
                                    <div class="col-md-6">
                  <div class="form-group">
                    <select class="w100 p15 pb15 grey-bg border1" name="region" id="region"  data-parsley-required data-parsley-required-message="Please select region" place-holder="Select Region"  data-parsley-required>
                            <option value="">Region</option>
                            <option value="northwest">North West</option>
                            <option value="southwest">South West</option>
                            <option value="northeast">North East</option>
                            <option value="southeast">South East</option>
                        </select>
                  </div>
                </div>

            </div>
            <div class="row">

             <div class="col-md-6">

                <div class="input-group w100">
                <input type="text" class="w100 p15 pb15 grey-bg border1 zipcode" id="exampleInputEmail1" value="" placeholder="Zip Code">

                </div>
            </div>

            </div>

          </div>
        </div>
      </div>

    </div>
{include file="/common/footer-1.tpl" nocache}

<script>

    function paywithpaypal()
    {

        if(true === $('#paypal-form').parsley().validate())
        {
            $('#paypal-form').submit();
            /*var params = $('#paypal-form').serialize();
            //console.log(params);
             $.ajax({
             type:'POST',
             url:'/product/updateshippinginfobid?'+params,
             data:params,
             dataType:'json',
             success: function (data)
             {
             alert(data.insid)
             //$('#submitBtn').trigger('click');
             }
             });*/
        }
    }

    /*function submitwithcard(event){

      if(true === $('#paypal-form').parsley().validate())
        {
            $('#checkoutcc').submit();
        }
        else{
          event.preventDefault();
        }

    }*/

    function submitwithvp(event){

       if(true === $('#paypal-form').parsley().validate())
       {
          $.ajax({
             type:'POST',
             url:'{$config.url}/product/addship_to_sess',
             data : { fnames : $('#fname').val(),
                      lnames : $('#lname').val(),
                      emails : $('#emails').val(),
                      phoneno : $('#phoneno').val(),
                      countries : $('#countries').val(),
                      states : $('#states').val(),
                      cities : $('#cities').val(),
                      addresses : $('#addresses').val(),
                      zips : $('#zips').val(),

                        },
             success: function (data)
             {

               $('#vpcheckout').submit();
             }

          });
         // $('#vpcheckout').submit();
       }
       else{

        event.preventDefault();

       }


    }

    function paywithcard(){

        if( $('.credit-drp').hasClass('hide') ){

          $('.credit-drp').removeClass('hide');
           if( $('.stripe-drp').hasClass('hide') || !$('.stripe-drp').hasClass('hide') ){
             $('.stripe-drp').addClass('hide');
          }
          if( $('.auth-drp').hasClass('hide') || !$('.auth-drp').hasClass('hide') ){
             $('.auth-drp').addClass('hide');
          }


          }
        else{ $('.credit-drp').addClass('hide'); }

    }

    function paywithstripe(){

        if( $('.stripe-drp').hasClass('hide') ){

          $('.stripe-drp').removeClass('hide');
          if( $('.auth-drp').hasClass('hide') || !$('.auth-drp').hasClass('hide') ){
             $('.auth-drp').addClass('hide');
          }
          if( $('.credit-drp').hasClass('hide') || !$('.credit-drp').hasClass('hide')  ){

            $('.credit-drp').addClass('hide');


          }



        }
        else{ $('.stripe-drp').addClass('hide'); }

    }

    function paywithauth(){

      if( $('.auth-drp').hasClass('hide') ){

          $('.auth-drp').removeClass('hide');
          if( $('.stripe-drp').hasClass('hide') || !$('.stripe-drp').hasClass('hide') ){
             $('.stripe-drp').addClass('hide');
          }
           if( $('.credit-drp').hasClass('hide') || !$('.credit-drp').hasClass('hide')  ){

            $('.credit-drp').addClass('hide');


          }


        }
        else{ $('.auth-drp').addClass('hide'); }


    }

function cardSubmit(){
  $('#checkoutcc').submit();
}


/*function cardSubmit()
{

  intializeForm('');
  if(true === $('#paypal-form').parsley().validate())
      {

		  $('#cardprocesstwo,#cardprocessone').html('processing...');
        /!*intializeForm(function(){
          $('.submit-card').click();
        });*!/

          $('.submit-card').click();

        //setTimeout(function(){  $('#paypal-form').submit(); }, 3000);
      }
}*/
/*braintree.setup("{$clientToken}", "custom", {
  id: "paypal-form"
  });*/
/*$(function(){
  $('#paymentmethod').on('change',function(){

    if($(this).val() == 'paypal')
    {
      $('.paypal-drp').removeClass('hide');
      $('.credit-drp').addClass('hide');
      $('.saved-drp').addClass('hide');
      $('#future').attr('checked',false);
    }
    else if($(this).val() == 'cc')
    {
      $('.credit-drp').removeClass('hide');
      $('.paypal-drp').addClass('hide');
      $('.saved-drp').addClass('hide');
      $('#futurepal').attr('checked',false);
    }
    else
    {
      $('.paypal-drp').addClass('hide');
      $('.credit-drp').addClass('hide');
      $('.saved-drp').removeClass('hide');
       $('#future').attr('checked',false);
       $('#futurepal').attr('checked',false);
    }
  });

  braintree.setup('{$clientToken}', "paypal", {
    container: "paypal-button",
    paymentMethodNonceInputField : "paymentMethodNonceInputField",
    onSuccess : function(){

      $('#overlay').fadeIn(800);
      $('.cart').addClass('waitfewsec');
      if(true === $('#paypal-form').parsley().validate())
      {
        setTimeout(function(){ $('#paypal-form').submit(); }, 3000);
        $('#paypal-buttons').removeClass('hide');
          $('#paypal-button').addClass('hide');
      }
      else
      {
          $('#paypal-buttons').on('click',function() { $('#paypal-form').submit() });
          $('#paypal-buttons').removeClass('hide');
          $('#paypal-button').addClass('hide');
      }
     },
     onCancelled: function(){
      $('#paypal-buttons').addClass('hide');
     },
     singleUse : false
  });


});*/
function clicked(ob)
{
  ob.on('click',function()
  {
   //console.log(52);
  });
}
function shipping_add(id)
{
  if(id == 1)
  {
    if($('input[name="delivery_address_shipping"]').is(":checked"))
    {
      $('input[name="delivery_address"]').prop('checked',false);
      $('input').each(function()
      {
          //$(this).val($(this).attr('def'));
      });
        $('#country').val('{$shipping.country}');
        loadState();
      /*$('#country').val($('#country').attr('def'));
      loadLocation('country',$('#country option[value="{$shipping.country}"]').attr('attr'),'{$shipping.state}','{$shipping.city}');*/

      $('.ship_overlay').removeClass('hide');
    }
    else
    {
      $('input[name="delivery_address"]').prop('checked',true);
      $('.ship_overlay').addClass('hide');
    }
  }
  if(id == 0)
  {
    $('#f_name').val('');
    $('#email').val('');
    $('#comment').val('');
    $('.zipcode').val('');
    $('#sel1 option[value=""]').attr('selected','selected');
    $('#country option[value=""]').attr('selected','selected');
    $('#region option[value=""]').attr('selected','selected');
    
    
    
    //$('#country').find('option:selected').remove();
    if($('input[name="delivery_address"]').is(":checked"))
    {
      $('input[name="delivery_address_shipping"]').prop('checked',false);
      $('.ship_overlay').addClass('hide');
    }
    else
    {
      $('input[name="delivery_address_shipping"]').prop('checked',true);
      $('input').each(function()
      {
         // $(this).val($(this).attr('def'));
      });
      /*$('#country').val($('#country').attr('def'));
      loadLocation('country',$('#country option[value="{$shipping.country}"]').attr('attr'),'{$shipping.state}','{$shipping.city}');
      $('.ship_overlay').removeClass('hide');*/
    }
  }

}
  //braintree.setup("CLIENT-TOKEN-FROM-SERVER", "<integration>", options);

</script>
<script>
$(function()
{
 /* var ctry = '{$shipping.country}';
 //console.log(ctry);
  if(ctry !='')
  {

    $('#country').val(ctry);
    if($('#country option[value="{$shipping.country}"]').length > 0)
    {
    loadLocation('country',$('#country option[value="{$shipping.country}"]').attr('attr'),'{$shipping.state}','{$shipping.city}');
    }
  }*/
  /*$('#country').on('change',function()
    {
      var m = $('#country option[value="'+$(this).val()+'"]').attr('attr');

      //$('#state').html('');
      loadLocation('country',m,'','');
      $('#states').parent().find('ul li.parsley-required').hide();
      $('#cities').parent().find('ul li.parsley-required').hide();

    });
    $('#states').on('change',function()
    {
      var m = $('#states option[value="'+$(this).val()+'"]').attr('attr');

      //$('#state').html('');
      loadLocation('state',m,'','');
      $('#cities').parent().find('ul li.parsley-required').hide();


    });
*/
    $('#pay_chooser').change(function(){
        if($(this).is(":checked")) {
          $('.card_details').addClass('hide');
          $('.saved_cards').removeClass('hide');
        }
        else{
          $('.saved_cards').addClass('hide');
          $('.card_details').removeClass('hide');
        }
    });
    $('#country').on('change',function()
    {
        loadState();
    });

    var ctry = '{$shipping.country}';

    if(ctry !='')
    {
        $('#country').val(ctry);

        loadState();

    }
    //loadLocation('state',$('#states option[value="{$users.state}"]').val(),'{$users.city}');

  });</script>
  <script>
    $(document).ready(function(){

    $('#fname').val($('#f_name').val());
    $('#lname').val($('#l_name').val());
    $('#emails').val($('#email').val());
    $('#phoneno').val($('#phone').val());
    $('#countries').val($('#country').val());
    $('#states').val($('#state').val());
    $('#cities').val($('#city').val());
    $('#addresses').val($('#address').val());
    $('#zips').val($('#zipcode').val());

    $('#hidden_countries').val($('#hidden_country').val());
    $('#hidden_states').val($('#hidden_state').val());



   $('#f_name').change(function() {
      $('#fname').val($(this).val());
  });
    $('#l_name').change(function() {
      $('#lname').val($(this).val());
  });
     $('#email').change(function() {
      $('#emails').val($(this).val());
  });
    $('#phone').change(function() {
      $('#phoneno').val($(this).val());
  });
    $('#country').change(function() {
      $('#countries').val($(this).val());
  });
    $('#state').change(function() {
      $('#states').val($(this).val());
  });
    $('#city').change(function() {
      $('#cities').val($(this).val());
  });
    $('#address').change(function() {
      $('#three').val($(this).val());
  });

    $('#zipcode').change(function() {
      $('#zips').val($(this).val());
  });




});


  </script>
  <script type="text/javascript" src="https://js.stripe.com/v2/"></script>
  <script>
  $(document).ready(function(){

    $('#next_step').click(function(){

      if($(this).hasClass('address')){
          if(true === $('#paypal-form').parsley().validate()){
           //console.log( $('#paypal-form').serialize() );
            var datas = $('#paypal-form').serialize();
            $.ajax({
               type:'GET',
               url:'{$config.url}/product/validate_ups_address',
               data: datas,
               success: function (data)
               {

                  $( this ).text('');
                  $( this ).removeClass( "address");
                  $('.sec_step').css('display','block');
                  $( this ).addClass( "payments");
                  $( '.checkt_wrapper' ).fadeTo( "slow", 0.33 );
                  $( this ).text('Previous Step');
                  $('body').scrollTop( $(document).height() );
               }
            });

          }
      }
      else if($(this).hasClass('payments')){

          $( this ).text('');
          $ ( this ).removeClass( "payments");
          $('.sec_step').css('display','none');
          $( this ).addClass( "address");
          $( '.checkt_wrapper' ).fadeTo( "slow", 1 );
          $( this ).text('Next Step');
          $('body').scrollTop( 0 );


      }
      else{

          $( this ).text('');
          $ ( this ).removeClass( "payments");
          $('.sec_step').css('display','none');
          $( this ).addClass( "address");
          $( '.checkt_wrapper' ).fadeTo( "slow", 1 );
          $( this ).text('Next Step');
          $('body').scrollTop( 0 );

      }


    });


    $('#stripe_button').click(function(e){

      e.preventDefault();

      if(true === $('#paypal-form').parsley().validate())
       {
          $.ajax({
             type:'POST',
             url:'{$config.url}/product/addship_to_sess',
             data : { fnames : $('#fname').val(),
                      lnames : $('#lname').val(),
                      emails : $('#emails').val(),
                      phoneno : $('#phoneno').val(),
                      countries : $('#countries').val(),
                      states : $('#states').val(),
                      cities : $('#cities').val(),
                      addresses : $('#addresses').val(),
                      zips : $('#zips').val(),

                        },
             success: function (data)
             {

               Stripe.setPublishableKey('{$pkey}');

                Stripe.card.createToken({
                  number: $('#card_number').val(),
                  cvc: $('#cvv').val(),
                  exp_month: $('#expiry_month').val(),
                  exp_year: $('#expiry_year').val()
                }, stripeResponseHandler);
             }

          });
         // $('#vpcheckout').submit();
       }

       else{
         //console.log('Somehing Went Wrong');

          return false;
       }





      function stripeResponseHandler(status,response) {


         if (response.error) {
          alert( response.error.message )
          e.preventDefault();
         }
         else {

            $('#stripe_token').val( response.id );
            $('#stripe_form').submit();
         }

      }

    });



    $('#authorize_button').click(function(e){

      e.preventDefault();

      if(true === $('#paypal-form').parsley().validate())
       {
          $.ajax({
             type:'POST',
             url:'{$config.url}/product/addship_to_sess',
             data : { fnames : $('#fname').val(),
                      lnames : $('#lname').val(),
                      emails : $('#emails').val(),
                      phoneno : $('#phoneno').val(),
                      countries : $('#countries').val(),
                      states : $('#states').val(),
                      cities : $('#cities').val(),
                      addresses : $('#addresses').val(),
                      zips : $('#zips').val(),

                        },
             success: function (data)
             {
                $('#authorize_form').submit();
             }
          });
        }
        else{

          //console.log('Somehing Went Wrong');

          return false;

        }
    });




  });



  </script>
