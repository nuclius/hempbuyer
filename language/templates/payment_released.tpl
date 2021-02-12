{include file="common/header-1.tpl" nocache}
<div class="main_container">
  <div class="row dashboard">
  	<div class="dash_brd">{$pharse.payment}  &gt;&gt;</div>
     <div class="check_wrapper">
       <div class="prdt  gray_box">{$pharse.confirmation}</div>
        <div class="row total_shipin">
         {$pharse.payment_was_successfully_released} 
        </div> 
      </div>    
  </div>
</div>
{include file="common/footer-1.tpl" nocache} 