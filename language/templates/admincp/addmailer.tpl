{include file="/admincp/header.tpl" nocache} 
<script src="http://ckeditor.com/latest/ckeditor.js"></script>
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  
  <div class="row">
    <div class="col-lg-12">
      <ol class="breadcrumb">
        <li class="active"> <i class="icon flaticon-flower-with-leaves"></i> {$pharse.add_email_/_sms_management}<i class="fa fa-hand-o-right"></i> <i class="fa fa-search"></i> </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  
  <div class="row">
    <div class="col-lg-12"> <a href="javascript: history.go(-1)" style="margin-bottom:10px" class="btn btn-success pull-right">&lt;&lt; {$pharse.back}</a> </div>
  </div>
 
  <form name="emailtemp" method="post" action="{$config.url}/admincp/addmanagement" class="form-horizontal">
 
   
   
   <div class="clear"></div>
   
   <div class="form-group">
    <input type="hidden"  value="{$content.id}" name="id" />
        <label class="col-sm-2 control-label">{$pharse.option_name}</label>
        <div class="col-sm-6">
        <input type="text" name="opt_name" value="{$content.name}" placeholder="" class="form-control" data-parsley-required-message="Please enter name" required>
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.api_username/_email_id}</label>
        <div class="col-sm-6"> 
        <input type="text" name="apiuser" value="{$content.user}" placeholder="" class="form-control" data-parsley-required-message="Please enter userkey" required>
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.api_key/password}</label>
        <div class="col-sm-6">
        <input type="text" name="apikey" value="{$content.pass}" placeholder="" class="form-control" data-parsley-required-message="Please enter key" required>
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.type}</label>
        <div class="col-sm-6">
        <select class="form-control" name="type">
            <option value="email" {if $content.type == 'email'} selected {/if}>{$pharse.email}</option>
            <option value="sms" {if $content.type == 'sms'} selected {/if}>{$pharse.sms}</option>
        </select>
        </div>
    </div>

    <div class="col-md-12 form-group">
      <label class="col-sm-2 control-label"></label>
      <div class="col-sm-4">
       <button type="submit" class="btn btn-success">{$pharse.save}</button> 
       </div>
    </div>

</form>
  
  <!-- /.row --> 
</div>


{include file="/admincp/footer.tpl" nocache} 