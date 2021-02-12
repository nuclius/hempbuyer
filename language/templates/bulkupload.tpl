{include file="/common/header-1.tpl" nocache}
<div class="main_container">
<div class="row sellp1">
  
    
    <div class="panel panel-default">
  
      <div class="panel-body">
	  <div class="row">
        <div class="col-md-5">
        
		</div>
		
      </div>
     
      <div class="row shipping_container">
       

         <div class="row">
         
        <div class="col-md-8">
          <div class="form-group">
           
            <div class="alert alert-success"> <strong>{$pharse.csv!}</strong> {$pharse.was_successfully_parsed}</div>
            {if $errors neq ''}<div class="text-danger">{$pharse.rows} <strong>{$errors}<strong> {$pharse.have_errors.please_check_the_following_errors} <br>
            {foreach $details as $key => $val}
              At line {$key}: {$val}<br>

            {/foreach}

            </div>{/if}
            {if $errors eq ''}<div class="text-danger">{$pharse.successfully_added}</div>{/if}<br/>
            <a href="{$config.url}/dashboard/my">{$pharse.click_here_!!!}</a>
          </div>
          
        </div>
      </div>

      </div>
        </div>
    </div>
    
    <!--<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#boxx" data-whatever="@mdo">Pay with PayPal</button>-->
 
</div>

  </div>
{include file="/common/footer-1.tpl" nocache} 

