<div class="row">
 	<div class="col-md-12">
	  <div class="col-md-6">	
		<div class="form-group">
		      <label>{$seller_name:}</label>
		      {$feedback.name}
		</div>
		<div class="form-group">      
		      <label>{$pharse.average_review_point:}</label>
		      {$review.average} / 5
		</div>	
	  </div>
	  {foreach $review_type as $key=>$val}
      
	  
	   <div class="col-md-12">	
		<div class="form-group">
		      <label> {$val.field_name}:</label>
		      {$val.point}/5
		</div>
	  </div>
	  {/foreach}
	  <div class="col-md-6">	
		<div class="form-group">
		      <!-- <label>Review Level:</label> -->
		      {$review.stype}
		</div>
	  </div>
	  <div class="col-md-12"> 
		<label>{$pharse.content:}</label>
        {$review.content} 
	</div>		
	</div>	
	
	
	<div class="col-md-12">
		<div class="col-md-6">	<input type="submit" class="btn btn-danger" value="Close" onclick="$('.modal').modal('hide');"></div>
	</div>
</div>      