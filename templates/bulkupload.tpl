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

{include file="/common/header-1.tpl" nocache}
<div class="main_container">
<div class="container row sellp1">
  
    
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
           
            <div class="alert alert-success"> <strong>{$phrase.csv}!</strong>{$phrase.was_successfully_parsed}</div>
            {if $errors neq ''}<div class="text-danger">{$phrase.rows} <strong>{$errors}<strong> please_check_the_following_errors <br>
            {foreach $details as $key => $val}
              {$phrase.at_line} {$key}: {$val}<br>

            {/foreach}

            </div>{/if}
            {if $errors eq ''}<div class="text-danger">{$phrase.successfully_added}</div>{/if}<br/>
            <a href="{$config.url}/dashboard/my">Click Here !!!</a>
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

