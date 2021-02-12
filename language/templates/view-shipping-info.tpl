<div class="row">
 	<div class="col-md-12">
	  <div class="col-md-6">	
		<div class="form-group">
		      <label>{$pharse.shipping_user_info:}</label>
		      {$cart.first_name} {$cart.first_name} {$cart.email}
		</div>
		<div class="form-group">      
		      <label>{$pharse.phone:}</label>
		      {$cart.phone}
		</div>	
	  </div>
	  <div class="col-md-6">	
		<div class="form-group">
		      <label>{$pharse.shipping_address:} </label>
		      {$cart.state}, {$cart.city}, {$cart.country}, {$cart.zipcode}
		</div>
        <div class="form-group">
		<label>{$pharse.tracking_number:}</label>
        {$cart.shipping_id} 
        </div>
	  </div>	
	</div>	
		
	<div class="col-md-12"> 
    <div class="col-md-6">	 
    <div class="form-group">
		<label>{$pharse.tracking_service:}</label>
        {$cart.shipping_service} 
        </div>	
        </div>	
	</div>
	<div class="col-md-12"> 
    <div class="col-md-6">	
    <div class="form-group"> 
		<label>{$pharse.tracking _info:}</label>
        {$cart.shipping_info}
        </div>	 
        </div>	
	</div>
	<div class="col-md-12">
		<input type="submit" class="btn btn-danger" value="Close" onclick="$('.modal').modal('hide');">
	</div>
</div>      