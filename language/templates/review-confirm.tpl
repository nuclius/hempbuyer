{include file="common/header-1.tpl" nocache}
<style type="text/css">
.pdbut .btn
{
  margin:10px;
}
</style>
<div class="main_container">
  <div class="row dashboard">
    <div class="dash_brd">{$pharse.feedback_completed} </div>
     <div class="check_wrapper">
       <div class="prdt  gray_box">{$pharse.confirmation}</div>
        <div class="row total_shipin">
         {$pharse.your_feedback_submitted_successfully}
        </div> 
      </div>    
  </div>
</div>
<div style="height:50px;"></div>
<script language="javascript" type="text/javascript">
          $(function() { $('.myp').addClass('act_class'); } );
     </script> 
<script type="text/javascript">
$(function()
{
  projectLoad();
});</script>
{include file="common/footer-1.tpl" nocache}

