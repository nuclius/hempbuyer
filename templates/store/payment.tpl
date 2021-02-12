{include file="common/header-1.tpl" nocache}
<style media="screen">
    .card_details .form-group label {
        text-align:right;
    }
</style>
<div class="container col-md-12">
    <div class="container col-md-6 col-md-offset-3">
        <div class="row col-md-12 text-center h4" style="margin-bottom:20px;">
            Store plan
        </div>
        <form action="{$config.url}/stores/makepayment" method="POST" id="checkoutcc1" data-parsley-validate enctype="multipart/form-data">
    	    <div class="card_details">
                <div class="form-group clearfix">
                    <label class="col-md-4" style="margin-top:7px;">Select plan: </label>
    				<div class="col-md-8">
    					<select class="form-control" name="plan_val" id="planid" required/>
                            {foreach $plans as $key => $val}
                            <option value="{$val.id}">{$val.title}</option>
                            {/foreach}
                        </select>
    				</div>
    				<span class="err-msg err-plan"></span>
    			</div>
    			<div class="form-group clearfix">
    			    <label class="col-md-4" style="margin-top:7px;">Card Name: </label>
    				<div class="col-md-8">
    					<input type="text" class="form-control" name="cardholder_name" data-braintree-name="cardholder_name"  value="" required />
    				</div>
    				<span class="err-msg err-cardname"></span>
    			</div>
    			<div class="form-group clearfix">
    				<label class="col-md-4" style="margin-top:7px;">Card Number: </label>
    				<div class="col-md-8">
    					<input type="text" class="form-control" name="number" data-braintree-name="number"  value="" required />
    				</div>
    				<span class="err-msg err-cardnum"></span>
    			</div>
    			<div class="form-group clearfix">
    				<label class="col-md-4" style="margin-top:7px;">CVV:</label>
    				<div class="col-md-8">
    					<input type="text" class="form-control" name="cvv" id="cvv" data-braintree-name="cvv"  value="" required />
    				</div>
    				<span class="err-msg err-cvv"></span>
    			</div>
    			<div class="form-group clearfix">
    			    <label class="col-md-4" style="margin-top:7px;">Expiry Year:</label>
    				<div class="col-md-8">
    					<div class="row">
    						<div class="col-xs-6">
    							<input type="text" class="form-control" name="expiration_month" data-braintree-name="expiration_month" placeholder="mm" value="" required  />
    						</div>
    						<div class="col-xs-6">
    							<input type="text" class="form-control" name="expiration_year" data-braintree-name="expiration_year" placeholder="yy" value="" required  />
    						</div>
    					</div>
                        <input type="hidden" name="storeid" value="{$storeid}">
    				</div>
    				<span class="err-msg err-exyear"></span>
    			</div>
    			<div class="form-group clearfix text-center">
                    <button type="button" onclick="location.href='{$config.url}/stores/edit/{$storeid}';" class="btn btn-orange w-240">Cancel</button>
    				<button type='submit' class="btn btn-success w-240">Submit</button>
    			</div>
    		</div>
    	</form>
    </div>
</div>
{include file="common/footer-1.tpl" nocache}
<script src="https://js.braintreegateway.com/v2/braintree.js"></script>
<script type="text/javascript">
    $(function() {
        $('form#checkoutcc1').submit(function(){
           $(this).find('input[type=submit]').attr('disabled', 'disabled');
        });
        braintree.setup("{$clientToken}", "custom", {
            id: "checkoutcc1"
        });
    });
</script>
