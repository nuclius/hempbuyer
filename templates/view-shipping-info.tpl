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

<div class="row">
 	<div class="col-md-12">
	  <div class="col-md-6">	
		<div class="form-group">
		      <label>{$phrase.shipping_user_info}:</label>
		      {$cart.first_name} {$cart.first_name} {$cart.email}
		</div>
		<div class="form-group">      
		      <label>Phone:</label>
		      {$cart.phone}
		</div>	
	  </div>
	  <div class="col-md-6">	
		<div class="form-group">
		      <label>{$phrase.shipping_address}: </label>
		      {$cart.state}, {$cart.city}, {$cart.country}, {$cart.zipcode}
		</div>
        <div class="form-group">
		<label>{$phrase.tracking_number}:</label>
        {$cart.shipping_id} 
        </div>
	  </div>	
	</div>	
		
	<div class="col-md-12"> 
    <div class="col-md-6">	 
    <div class="form-group">
		<label>{$phrase.tracking_service}:</label>
        {$cart.shipping_service} 
        </div>	
        </div>	
	</div>
	<div class="col-md-12"> 
    <div class="col-md-6">	
    <div class="form-group"> 
		<label>{$phrase.tracking_info}:</label>
        {$cart.shipping_info}
        </div>	 
        </div>	
	</div>
	<div class="col-md-12">
		<input type="submit" class="btn btn-danger" value="Close" onclick="$('.modal').modal('hide');">
	</div>
</div>      