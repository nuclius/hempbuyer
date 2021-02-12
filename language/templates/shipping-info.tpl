<div class="row">
	<div class="col-md-12">
	  <div class="col-md-6">	
		<div class="form-group">
		      <label>{$pharse.first_name:}</label>
		      {$cart.first_name}
		</div>
		<div class="form-group">
		      <label>{$pharse.last_name:}</label>
		      {$cart.last_name}
		</div>
		<div class="form-group">
		      <label>{$pharse.email:}</label>
		      {$cart.email}
		</div>
		<div class="form-group">
		      <label>{$pharse.phone:}</label>
		      {$cart.phone}
		</div>
		<div class="form-group">
		      <label>{$pharse.address:}</label>
		      {$cart.address}
		</div>
	  </div>
	  <div class="col-md-6">	
		<div class="form-group">
		      <label>{$pharse.state:}</label>
		      {$cart.state}
		</div>
		<div class="form-group">
		      <label>{$pharse.city:}</label>
		      {$cart.city}
		</div>
		<div class="form-group">
		      <label>{$pharse.country:}</label>
		      {$cart.country}
		</div>
		<div class="form-group">
		      <label>{$pharse.zipcode:}</label>
		      {$cart.zipcode}
		</div>
	  </div>	
	</div>	
	<div class="col-md-12 text-center">      
		<input type="submit" class="btn btn-danger" value="Close" onclick="$('.modal').modal('hide');">
	</div>
</div>      