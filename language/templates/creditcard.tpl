{include file="/common/header-1.tpl" nocache}
<script src="https://js.braintreegateway.com/v2/braintree.js"></script> 
<script type="text/javascript">

  


</script> 

<div class="container">
<div class="row">

<div class="col-sm-3"></div>
<div class="col-sm-9 titl"><strong>{$pharse.enter_credit_card_details}</strong></div>

<div class="col-md-3 txtfun3 padlef0 mobile_view">
    {include file="payments-menu.tpl"}
  </div>
<div class="ds npayment col-md-9 mobile_view">


<div class="col-md-11 cbor">
    <form action="{$config.url}/dashboard/cc"   enctype="multipart/form-data"  data-parsley-validate method="post" name= "cc" id="checkout">
    	<div class="row">
         <div class="col-md-12" style="color:#C8191F;">{$error}</div>
         <div class="col-md-12">
        <div class="col-xs-12 col-sm-3 pad10 texr">
        	<strong>{$pharse.card_holder_name}</strong>
        </div>
        <div class="col-xs-12 col-sm-5 pad10">
        	<input type="text" name="cardholder_name" data-braintree-name="cardholder_name" class="form-control col-md-4" required value=""  data-parsley-required-message="Card Holder Name missing" id="cn"  />
        </div>
        </div>
        <div class="col-md-12">
        <div class="col-xs-12 col-sm-3 pad10 texr">
        	<strong>{$pharse.card_number}</strong> <span class="sred">*</span>
        </div>
        <div class="col-xs-12 col-sm-5 pad10">
        	<input type="text" name="number" data-braintree-name="number" class="form-control" value="" required  data-parsley-required-message="Credit Card Number" id="ccn"    />
        </div>
        </div>
        <div class="col-md-12">
        <div class="col-xs-6 col-sm-3 pad10 texr">
        	<strong>{$pharse.expiration_date}</strong> <span class="sred">*</span>
        </div>
        <div class="col-xs-3 col-sm-2 pad10">
        	<input type="text" name="expiration_month" data-braintree-name="expiration_month" class="form-control col-md-3" placeholder="mm" value="" required id="em"  />
            <!--div class="sml">mm</div-->
        </div>
        <div class="col-xs-3 col-sm-2 pad10">
        	<input type="text" name="expiration_year" data-braintree-name="expiration_year" class="form-control col-md-3" placeholder="yy" value="" required  id="ey" />
            <!--div class="sml">yy</div-->
        </div>
        </div>
        <div class="col-md-12">
        <div class="col-xs-12 col-sm-3 pad10 texr">
        	 <strong> {$pharse.cvv}</strong> <span class="sred">*</span>
        </div>
        <div class="col-xs-12 col-sm-2 pad10">
        	<input type="text" name="cvv" data-braintree-name="cvv" class="form-control col-md-3" value="" required  id="ccv"  placeholder="3 or 4 digits on the back"/>
        	<!--div class="sml">3 digits on the back</div-->
        </div>	
        </div>
        <div class="col-md-12">
        <div class="col-xs-12 col-sm-3 pad10"></div>
       
        <div class="col-xs-12 col-sm-2 pad10">
          <button type="button" class="btn btn-success" value="Submit" id="submit_btn" > {$pharse.submit} </button>

            <input type="submit" class="btn btn-success hide submit-card" value="Submit"  />
        </div>
         <div class="col-xs-12 col-sm-3 padding-20 mand"><span class="sred">*</span> {$pharse.mandatory_fields}</div> 
         </div>
		</div>
    </form>	
    </div>
    
  </div> 	
</div></div>

<script type="text/javascript">

    $('#submit_btn').click(function(){
        if(true === $('#checkout').parsley().validate()){
            $('.submit-card').click();
        } else{
            return false;
        }
    });

    $('form#checkout').submit(function(){
        $(this).find('input[type=submit]').attr('disabled', 'disabled');
    });
  

    braintree.setup("{$clientToken}", "custom", {
    id: "checkout"
  });
      

</script>
{include file="/common/footer-1.tpl" nocache}

