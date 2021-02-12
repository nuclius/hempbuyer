{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  <style type="text/css">
  .table>thead>tr>th {
	  background:#999;
	  color:#fff;
	  
  }
  .form-horizontal .control-label {
	  text-align:left !important;
  }
  </style>
  <!-- Page Heading -->
  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <ol class="breadcrumb">
        <li class="active"> <i class="fa fa-sitemap"></i> {$pharse.payment_modules_management}</li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  
  <div class="col-md-12">
  
  <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingOne">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
         
<div class="col-sm-8 privacy4"><span class="glyphicon glyphicon-chevron-down"></span>  {$pharse.authorize.net_gateway_configuration}</div>
        </a>
      
      </h4>
      <div class="clear"></div>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
      <div class="panel-body">
    
      
      <form class="form-horizontal">
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enable_sandbox}</label>
    <div class="col-sm-6">
      <label class="radio-inline">
  										<input type="radio" checked="checked" name="apay"> {$pharse.yes}
										</label>
										<label class="radio-inline">
  										<input type="radio" name="apay"> {$pharse.no}
										</label>
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_your_authorize.net_address}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_preapproval_key}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control"  placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_api_id}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_api_password}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control"  placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_authorize.net_api_signature}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
   <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_username}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
      
      
                                        
                                        <div class="col-md-12 form-group"> 
      
       								 	<button name="submit" class="btn btn-success">{$pharse.submit}</button> 
      									</form>
     								  	</div>
    
    
      </div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingTwo">
      <h4 class="panel-title">
        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
         
<div class="col-sm-8 privacy4"><span class="glyphicon glyphicon-chevron-right"></span> {$pharse.paypal_gateway_configuration}</div>
        </a>
       
      </h4>
        <div class="clear"></div>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
      <div class="panel-body">
       
           
                                       <form class="form-horizontal">
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enable_sandbox}</label>
    <div class="col-sm-6">
      <label class="radio-inline">
  										<input type="radio" checked="checked" name="ppay"> {$pharse.yes}
										</label>
										<label class="radio-inline">
  										<input type="radio" name="ppay"> {$pharse.no}
										</label>
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_your_paypal_address}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_preapproval_key}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control"  placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_api_id}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_api_password}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control"  placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_paypal_api_signature}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
   <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_username}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
      
      
                                        
                                        <div class="col-md-12 form-group"> 
      
       								 	<button name="submit" class="btn btn-success">{$pharse.submit}</button> 
      									</form>
     								  	</div>
       
       
      </div>
    </div>
  </div>
  
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingThree">
      <h4 class="panel-title">
        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
        
<div class="col-sm-8 privacy4"><span class="glyphicon glyphicon-chevron-right"></span> {$pharse.paypal_payments_pro_gateway_configuration}</div>
        </a>
      </h4>
        <div class="clear"></div>
    </div>
    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
      <div class="panel-body">
       
             
                                        
                                      <form class="form-horizontal">
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enable_sandbox}</label>
    <div class="col-sm-6">
     <label class="radio-inline">
  										<input type="radio" checked="checked" name="prpay"> {$pharse.yes}
										</label>
										<label class="radio-inline">
  										<input type="radio" name="prpay"> {$pharse.no}
										</label>
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_your_paypal_payments_pro_address}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_preapproval_key}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control"  placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_api_id}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_api_password
}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control"  placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_paypal_payments_pro_api_signature}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
   <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_username}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
      
      
                                        
                                        <div class="col-md-12 form-group"> 
      
       								 	<button name="submit" class="btn btn-success">{$Pharse.submit}</button> 
      									</form>
     								  	</div>
    
       
      </div>
    </div>
  </div>

<div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingFour">
      <h4 class="panel-title">
        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
        
<div class="col-sm-8 privacy4"><span class="glyphicon glyphicon-chevron-right"></span> {$pharse.braintree_payment_gateway_configuration}</div>
        </a>
      </h4>
        <div class="clear"></div>
    </div>
    <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
      <div class="panel-body">
        
        
                                            <form class="form-horizontal">
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enable_sandbox}</label>
    <div class="col-sm-6">
    <label class="radio-inline">
  										<input type="radio" checked="checked" name="brpay"> {$pharse.yes}
										</label>
										<label class="radio-inline">
  										<input type="radio" name="brpay"> {$pharse.no}
										</label>
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_your_braintree_payment_address
}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_preapproval_key}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control"  placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_api_id}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_api_password}
</label>
    <div class="col-sm-6">
      <input type="text" class="form-control"  placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_braintree_payment_api_signature}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
   <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_username}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
      
      
                                        
                                        <div class="col-md-12 form-group"> 
      
       								 	<button name="submit" class="btn btn-success">{$pharse.submit}</button> 
      									</form>
     								  	</div>
        
      </div>
    </div>
  </div> 
  
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingFive">
      <h4 class="panel-title">
        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
         
<div class="col-sm-8 privacy4"><span class="glyphicon glyphicon-chevron-right"></span> {$pharse.voguepay_payment_gateway_configuration}</div>
        </a>
      </h4>
        <div class="clear"></div>
    </div>
    <div id="collapseFive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFive">
      <div class="panel-body">
       
       
                            <form class="form-horizontal">
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enable_sandbox}</label>
    <div class="col-sm-6">
     <label class="radio-inline">
  										<input type="radio" checked="checked" name="vpay"> {$pharse.yes}
										</label>
										<label class="radio-inline">
  										<input type="radio" name="vpay"> {$pharse.no}
										</label>
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_your_voguepay_payment_address}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_preapproval_key}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control"  placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_api_id}
</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_api_password}
</label>
    <div class="col-sm-6">
      <input type="text" class="form-control"  placeholder="">
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_voguepay_payment_api_signature}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
   <div class="form-group">
    <label  class="col-sm-3 control-label">{$pharse.enter_username}</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" placeholder="">
    </div>
  </div>
      
      
                                        
                                        <div class="col-md-12 form-group"> 
      
       								 	<button name="submit" class="btn btn-success">{$pharse.submit}</button> 
      									</form>
     								  	</div>
       
      </div>
    </div>
  </div>  
  
  
  
  </div> 
  
  </div>   
  
</div> 



{include file="/admincp/footer.tpl" nocache} 


<script>

$('.collapse').on('shown.bs.collapse', function(){
$(this).parent().find(".glyphicon-chevron-right").removeClass("glyphicon-chevron-right").addClass("glyphicon-chevron-down");
}).on('hidden.bs.collapse', function(){
$(this).parent().find(".glyphicon-chevron-down").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-right");
});

</script>
