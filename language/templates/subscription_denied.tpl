{include file="common/header-1.tpl" nocache}
<style>
.fon{
	font-size: 20px;
    border: 1px solid #ccc;
    padding-top: 45px;
    padding-bottom: 45px;
    border-radius: 8px;
    background-color: #E0DFDF;
}
.main_container{
	height:360px;
}
</style>
<div class="main_container">
  <div class="row dashboard">
    
    <div class="col-md-12">
      
      
      <div class="col-md-12 text-center m-top-20 font-12 bg-alert fon">
          {$pharse.sorry,_you_don't_have_permission_to_access_this_page!_please_setup_membership} <a href="{$config.url}/membership/setup">{$pharse.click_here} </a>
      </div>
      
  </div>
</div>
{include file="common/footer-1.tpl" nocache} 