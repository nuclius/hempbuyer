{include file="common/header-1.tpl" nocache} 

<div class="row">
 <div class="col-md-12 m-top-40 m-bottom-20"> 
 <div class="bg bg-danger padding-20">  
  <i class="fa fa-warning"></i>
  {$pharse.some_error_occured.go_back_to_site} <a href="{$config.url}">{$pharse.click_here}</a>
  <br /><div class="font-12 text-danger">{$message}</div>
 </div>
</div>
</div>

{include file="common/footer-1.tpl" nocache} 
