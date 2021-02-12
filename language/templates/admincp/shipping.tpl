{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <ol class="breadcrumb">
        <li class="active"> <i class="fa fa-sitemap"></i> {$pharse.shipping_api}</li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
   <div class="row">
                       <div class="col-lg-12">
                        {if $error == 'saved'}
                         <div class="alert alert-success">
                              {$pharse.shipping_settings_updated_successfully}
                           </div>
                           {elseif $error == 'del'}  
                           <div class="alert alert-success">
                              {$pharse.shipping_service_deleted_successfully}
                           </div> 
                        {elseif $error != ''}   
                          <div class="alert alert-danger">
                               <strong>{$error}{$pharse.shipping_service_added_successfully}</strong> 
                           </div>
                        {/if}   
                        </div>
  <div class="col-md-12">
  
  <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingOne">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
         
<div class="col-sm-8 privacy4"><span class="glyphicon glyphicon-chevron-down"></span>  {$pharse.shipping_settings}</div>
        </a>
      
      </h4>
      <div class="clear"></div>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
      <div class="panel-body">
    
     <div class="table-responsive"> 
     <form method="post" enctype="multipart/form-data" action="{$config.url}/admincp/shipping/shipping" >
                            <table class="table  table-hover">
                                <thead>
                                    <tr>
                                     
                                        <th>{$pharse.description}</th>
                                        <th>{$pharse.value}</th>
                                        <th>{$pharse.sort}</th>
                                        </tr>
                                        </thead>
                                        <tr>
                                        <td>
                                       <div style="font-weight:bold">{$pharse.would_you_like_to_enable_the_shipping_api?}</div>

                                        </td>
                                        <td>
                                         {foreach $shipping as $key => $val}
                                        <label class="radio-inline">
  										<input type="radio"{if $val == 1}  checked="checked"{/if} value="1" name="shipping[enbled]"> Yes
										</label>
										<label class="radio-inline">
  										<input type="radio" value="0" {if $val == 0}  checked="checked"{/if} value="0" name="shipping[enbled]"> No
										</label>
                     {/foreach}</td>
                                        <td><input type="text" name="shippingsort['enabled']" class="form-control sortb1" value="90"></td>
                                        </tr>
                                       
                                        </table>
                                       
                                        </div> 
                                        
                                        <div class="col-md-12 form-group"> 
      
       								 	<button name="submit" class="btn btn-success">{$pharse.save}</button> 
      									</form>
     								  	</div>
    
    
      </div>
    </div>
  </div>
 
  
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingThree">
      <h4 class="panel-title">
        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
        
<div class="col-sm-8 privacy4"><span class="glyphicon glyphicon-chevron-up"></span> {$pharse.fedex_shipping_api}</div>
        </a>
      </h4>
        <div class="clear"></div>
    </div>
    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
      <div class="panel-body">
       
            <div class="table-responsive"> 
     <form method="post" enctype="multipart/form-data" action="{$config.url}/admincp/shipping/fedex">
                            <table class="table  table-hover">
                                <thead>
                                    <tr>
                                     
                                        <th>{$pharse.description}</th>
                                        <th>{$pharse.value}</th>
                                        <th>Sort</th>
                                        </tr>
                                        </thead>
                                         {foreach $fedex as $key => $val}
                                       <tr>
                                        <td>{$fedexquestions[$key]}</td>
                                        <td><input type="text" name="fedex[{$key}]"  class="form-control" value="{$val}"></td>
                                        <td><input type="text"  class="form-control sortb1" value="10"></td>
                                        </tr>
                                         {/foreach}
                                        
                                        </table>
                                        
                                        </div> 
                                        
                                        <div class="col-md-12 form-group"> 
      
       								 	<button name="submit" class="btn btn-success">{$pharse.save}</button> 
     									</form>
     								  	</div>
       
      </div>
    </div>
  </div>

<div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingFour">
      <h4 class="panel-title">
        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
        
<div class="col-sm-8 privacy4"><span class="glyphicon glyphicon-chevron-up"></span> {$pharse.ups_shipping_api}</div>
        </a>
      </h4>
        <div class="clear"></div>
    </div>
    <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
      <div class="panel-body">
        
        
            <div class="table-responsive"> 
     <form method="post" enctype="multipart/form-data" action="{$config.url}/admincp/shipping/ups">
                            <table class="table  table-hover">
                                <thead>
                                    <tr>
                                     
                                        <th>{$phaese.description}</th>
                                        <th>{$pharse.value}</th>
                                        <th>{$pharse.sort}</th>
                                        </tr>
                                        </thead>

                                         {foreach $ups as $key => $val}
                                       <tr>
                                        <td>{$upsquestions[$key]}</td>
                                        <td><input type="text" name="ups[{$key}]"  class="form-control" value="{$val}"></td>
                                        <td><input type="text"  class="form-control sortb1" value="10"></td>
                                        </tr>
                                         {/foreach}
                                        
                                        </table>
                                        
                                        </div> 
                                        
                                        <div class="col-md-12 form-group"> 
      
       								 	<button name="submit" class="btn btn-success">{$pharse.save}</button> 
     									</form>
     								  	</div>
        
      </div>
    </div>
  </div> 
  
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingFive">
      <h4 class="panel-title">
        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
         
<div class="col-sm-8 privacy4"><span class="glyphicon glyphicon-chevron-up"></span> {$pharse.usps_shipping_api}</div>
        </a>
      </h4>
        <div class="clear"></div>
    </div>
    <div id="collapseFive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFive">
      <div class="panel-body">
       
       
           <div class="table-responsive"> 
     <form method="post" enctype="multipart/form-data" action="{$config.url}/admincp/shipping/usps">
                            <table class="table  table-hover">
                                <thead>
                                    <tr>
                                     
                                        <th>{$phaese.description}</th>
                                        <th>{$pharse.value}</th>
                                        <th>{$pharse.sort}</th>
                                        </tr>
                                        </thead>
                                        {foreach $usps as $key => $val}
                                       <tr>
                                        <td>{$uspsquestions[$key]}</td>
                                        <td><input type="text" name="usps[{$key}]"  class="form-control" value="{$val}"></td>
                                        <td><input type="text"  class="form-control sortb1" value="10"></td>
                                        </tr>
                                         {/foreach}
                                        
                                        </table>
                                        
                                        </div>   
                                        
                                        <div class="col-md-12 form-group">  
      
       								 	<button name="submit" class="btn btn-success">{$pharse.save}</button> 
     									</form>
     								  	</div>
       
      </div>
    </div>
  </div>  
  
  
  
  </div> 
  
  <div class="col-md-12 reports2 sear">{$pharse.shipping_services_api}</div>
  <div class="col-lg-12 reports1">  
    
    {$pharse.below_you_can_manage_shipping_partners_which_sellers_can_choose_from_when_posting_product_auctions}
   </div>
   <div class="pull-left">
  <a href="javascript:void(0)" onclick="$('#snew').show()" class="btn btn-success"> {$pharse.add_new_shipping_service}</a>
  </div>
<div id="snew"  style="display:none" class="col-lg-12">
 <form method="post" enctype="multipart/form-data" action="{$config.url}/admincp/shippingnew/add" id="shipping_add" data-parsley-validate >
                            <table class="table  table-hover ship">
                                <thead>
                                    <tr>
                                       <th>{$pharse.title_/_tracking_url}</th>
                                        <th>{$pharse.carrier}</th>
                                        <th>{$pharse.carrier_code}</th>
                                        <th>{$pharse.domestic}</th>
                                         <th>{$pharse.intl}</th>
                                         
                                           <th>{$pharse.sort}</th>
                                         <th>{$pharse.action}</th>
                                    </tr>
                                </thead>
                                <tbody>
    <tr>
                                      <td><div class="marb"><input name="title" type="text" class="form-control" value="" required data-parsley-required-message="Enter tracking title"></div>
                                      <div><input type="text" name="trackurl" class="form-control trac" value="" required data-parsley-required-message="Enter tracking url" ></div></td>
                                    <td><select name="carrier" class="form-control" > <option value="fedex"> {$pharse.fedex}</option> <option value="ups"> {$pharse.ups}</option> <option value="usps"> {$pharse.usps}</option></select></td>
                                    <td><input type="text" name="shipcode" class="form-control" value="" required data-parsley-required-message="Enter carrier code"></td>
                                    <td align="center"><input name="domestic" type="checkbox" value="1" ></td>
                                    <td align="center"><input name="international" type="checkbox" value="1"> </td>
                                   
                                    <td ><input type="text" name="sort" class="form-control sortb1" value=""></td>
                                    <td align="center"> <button name="submit" id="save_shipping" class="btn btn-success">{$pharse.save}</button></td>
                                   </tr>
                                    
                               

                                </tbody>
                            </table>
                            </form>
                            </div>
  <div class="clear"></div>
  <div class="table-responsive">
                            <table class="table  table-hover ship">
                                <thead>
                                    <tr>
                                       <th>{$pharse.title_/_tracking_url}</th>
                                        <th>{$pharse.carrier}</th>
                                        <th>{$pharse.carrier_code}</th>
                                        <th>{$pharse.domestic}</th>
                                         <th>{$pharse.intl}</th>
                                         
                                           <th>{$pharse.sort}</th>
                                         <th>{$pharse.action}</th>
                                        
                                    </tr>
                                </thead>
                                <tbody>
                           {$item = 0}
                                 {foreach $shippers as $key => $val}  
                                 {$item = 1}
                                
                                        <tr>
                                      <td><div class="marb"><input name="title" type="text" class="form-control" value="{$val.title}"></div>
                                      <div><input type="text" name="trackurl" class="form-control trac" value="{$val.trackurl}"></div></td>
                                    <td><input type="text" name="carrier" class="form-control" value="{$val.carrier}"></td>
                                    <td><input type="text" name="shipcode" class="form-control" value="{$val.shipcode}"></td>
                                    <td align="center"><input name="domestic" type="checkbox" {if $val.domestic == 1} checked="checked" {/if}></td>
                                    <td align="center"><input name="international" type="checkbox" {if $val.international == 1} checked="checked" {/if}> </td>
                                    <td align="center"><a href="{$config.url}/admincp/shippingdel/{$val.shipperid}"><img src="{$config.url}/images/delet.png"></a></td>
                                    <td ><input type="text" class="form-control sortb1" value="{$val.sort}"></td>
                                   </tr>
                                    
                                 {/foreach}

                                </tbody>
                            </table>
                            
                            
                                 {$pagination_html}
                            
                        </div>
  
  </div>   
  
</div> 



{include file="/admincp/footer.tpl" nocache} 


<script>

$('.collapse').on('shown.bs.collapse', function(){
$(this).parent().find(".glyphicon-chevron-up").removeClass("glyphicon-chevron-up").addClass("glyphicon-chevron-down");
}).on('hidden.bs.collapse', function(){
$(this).parent().find(".glyphicon-chevron-down").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-up");
});
/*
$('#save_shipping').click(function (){
    console.log("Clicked");
    if($('input[name="title"]').val() == '' && $('input[name="trackurl"]').val() == ''){
        $('input[name="title"]').attr('data-parsley-required', 'true');
    }

})
*/

</script>


<style type="text/css">

td {
	border-top:none !important;
}
</style>