{include file="/admincp/header.tpl" nocache} 
<script src="http://ckeditor.com/latest/ckeditor.js"></script>
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  
  <div class="row">
    <div class="col-lg-12">
      <ol class="breadcrumb">
        <li class="active"> <i class="icon flaticon-flower-with-leaves"></i> {$pharse.add_email_templates} <i class="fa fa-hand-o-right"></i> <i class="fa fa-search"></i> </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  
  <div class="row">
    <div class="col-lg-12"> <a href="javascript: history.go(-1)" style="margin-bottom:10px" class="btn btn-success pull-right">&lt;&lt; {$pharse.back}</a> </div>
  </div>
 
   <form action="{$config.url}/admincp/addetemps" method="post" id="pay_chk">
    <input type="hidden"  value="{$temp_details.id}" name="id" />
    <div class="form-group">
        <label>{$pharse.event_name}</label>

        <input name="email_name" data-parsley-group="block1" required id="email_name" value="{$temp_details.title}" maxlength="99" value="" onKeyUp="return limitlength(this,99,'info_label')" type="text" class="form-control" {if $temp_details.title != ''}readonly{/if}>
    </div>
    <div class="form-group">
        <label>{$pharse.subject}</label>
        <input name="email_suject" data-parsley-group="block1" required id="email_suject" value="{$temp_details.subject}" maxlength="99" value="" onKeyUp="return limitlength(this,99,'info_label')" type="text" class="form-control">
    </div>

    <div class="form-group">
        <label>{$pharse.type}</label>
        <select class="form-control" name="email_type">
            <option value="global" {if $temp_details.type == 'global'} selected {/if}>{$pharse.global}</option>
            <option value="product" {if $temp_details.type == 'product'} selected {/if}>{$pharse.product}</option>
            <option value="service" {if $temp_details.type == 'service'} selected {/if}>{$pharse.service}</option>
        </select>
    </div>
      <div>&nbsp;</div>
    <div class="form-group">
    <div class="table-responsive">
      <textarea name="editor1" required="required">{$temp_details.template}</textarea>
    </div>
    </div>
     <label>{$pharse.users_of_template}</label>
    <div class="checkbox chk12 newadmclr">

    <label class="newadmclr">
      <input type="checkbox" name="buyer" data-parsley-multiple="mymultiplelink" class="auction" data-parsley-mincheck="1" {if $temp_details.buyer} checked {/if}>
      {$pharse.buyer} </label>
    </div>
    <div class="checkbox chk12 newadmclr">
    <label class="newadmclr">
      <input type="checkbox" name="seller" data-parsley-multiple="mymultiplelink" class="auction"  data-parsley-mincheck="1" {if $temp_details.seller} checked {/if}>
      {$pharse.seller} </label>
    </div>
    <div class="checkbox chk12 newadmclr">
    <label class="newadmclr">
      <input type="checkbox" name="admin" data-parsley-multiple="mymultiplelink" class="auction"  data-parsley-mincheck="1" {if $temp_details.admin} checked {/if}>
      {$pharse.admin} </label>
    </div>
    <div class="checkbox chk12 newadmclr">
    <label class="newadmclr">
      <input type="checkbox" name="general" data-parsley-multiple="mymultiplelink" class="auction" data-parsley-mincheck="1" {if $temp_details.general} checked {/if}>
      {$pharse.general} </label>
    </div>

    <div class="form-group">
      <input type="submit" class="btn btn-success" value="Save" />
    </div>
  </form>
  
  <!-- /.row --> 
</div>

<script language="javascript" type="text/javascript">

var editor = CKEDITOR.replace( 'editor1', {
    allowedContent: true,
    required: true
});

editor.on( 'instanceReady', function() {
    console.log( editor.filter.allowedContent );
});

</script> 

{include file="/admincp/footer.tpl" nocache} 