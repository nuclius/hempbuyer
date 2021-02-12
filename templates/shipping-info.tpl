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
		      <label>{$phrase.first_name}:</label>
		      {$cart.first_name}
		</div>
		<div class="form-group">
		      <label>{$phrase.last_name}:</label>
		      {$cart.last_name}
		</div>
		<div class="form-group">
		      <label>{$phrase.email}:</label>
		      {$cart.email}
		</div>
		<div class="form-group">
		      <label>{$phrase.phone}:</label>
		      {$cart.phone}
		</div>
		<div class="form-group">
		      <label>{$phrase.address}:</label>
		      {$cart.address}
		</div>
	  </div>
	  <div class="col-md-6">	
		<div class="form-group">
		      <label>{$phrase.state}:</label>
		      {$cart.state}
		</div>
		<div class="form-group">
		      <label>{$phrase.city}:</label>
		      {$cart.city}
		</div>
		<div class="form-group">
		      <label>{$phrase.state}:</label>
		      {$cart.country}
		</div>
		<div class="form-group">
		      <label>{$phrase.zipcode}:</label>
		      {$cart.zipcode}
		</div>
	  </div>	
	</div>	
	<div class="col-md-12 text-center">      
		<input type="submit" class="btn btn-danger" value="Close" onclick="$('.modal').modal('hide');">
	</div>
</div>      