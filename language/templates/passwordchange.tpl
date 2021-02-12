{include file="/common/header-1.tpl" nocache}
<style type="text/css">
.dvPreview img{
  margin:10px;
}
.category ul{
  display:none;
}
</style>

<div class="row shipwrap sellp1">
<div class="daashbrd_cngpswd"><a href="/dashboard/my">{$pharse.dashboard}</a> &gt;&gt; {$pharse.profile}</div>

<div class="col-md-3 txtfun3 padlef0 mobile_view">
{include file="left-profile-nav.tpl" nocache}
</div>
<div class="col-md-9 mobile_view">
  <form action="/dashboard/changepassword" method="post" id="change_password" name="change_password" accept-charset="utf-8" data-parsley-validate>
      {if $save}
        <div class="row">
             <div class="bg bg-success padding-20">  
                <i class="fa fa-warning"></i>
               {$pharse.password_successfully_changed!}
             </div>
        </div>  

      {/if}
<div class="panel panel-default">
  <div class="panel-heading ct_headt">{$pharse.change_password} </div>
  <div class="panel-body">
  <div class="row pd">
    <div class="col-md-7">
      <input type="password" id="old_password" name="old_password" title="Old Password" data-parsley-required-message="Please enter old password" data-parsley-group="block1" class="form-control" placeholder="Old Password"required="" >
    </div>
  </div>
  <div class="row pd">
    <div class="col-md-7">
      <input type="password" id="new_password" name="new_password" data-parsley-minlength="6" data-parsley-required-message="Please enter new password" data-parsley-minlength-message ="Please enter a minimum of 6 characters" data-parsley-length-message ="Please enter a minimum of 6 characters" data-parsley-type-message="Password should be alphanumeric"  data-parsley-type="alphanum" title="New Password" data-parsley-group="block1" maxlength="20" required="" placeholder="New Password" class="form-control" >
    </div>
  </div>
  <div class="row pd">
    <div class="col-md-7">
   <input type="password" id="new_password" name="confirm_password" placeholder="Confirm Password" title="Confirm Password" data-parsley-group="block1" maxlength="20" required="" data-parsley-equalto="#new_password" class="form-control" data-parsley-error-message="Password entered don't match">
    </div>
  </div>
 <button type="button" id="changepassword" class="btn btn-danger mbrm">{$pharse.save}</button>
</div>
</div>
    </form>        
</div>
</div>
</div>
{include file="/common/footer-1.tpl" nocache} 




{literal}
<script language="javascript" type="text/javascript">
          $(function() { $('.myp').addClass('act_class'); } );
      
      $('#changepassword').click(function()
      {
        
        if(true === $('#change_password').parsley().validate('block1'))
        {
      
        $.ajax(
        {
          type:'POST',
          url :'/dashboard/changepassword',
          data: {isajax:1,password:$('#old_password').val()},
          dataType:'json',
          success:function(data)
          {
           if(data == 1)
           $('#change_password').submit();
           else
           $('#old_password').next('ul').html('<li class="parsley-required">Old Password is in-correct</li>');
            
          }
          
        });
        }
       });
</script>
{/literal}

