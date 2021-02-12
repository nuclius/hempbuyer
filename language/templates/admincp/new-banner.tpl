{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  
  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <ol class="breadcrumb">
        <li class="active"> <i class="icon flaticon-flower-with-leaves"></i> {$pharse.banner} <i class="fa fa-hand-o-right"></i> <i class="fa fa-search"></i> {$pharse.update} </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  
  <div class="row"> {if $success}
    <div class="alert alert-success"> <strong>{$success}!</strong> </div>
    {/if}
    {if $failure}
    <div class="alert alert-danger"> <strong>{$error}!</strong> </div>
    {/if}
    <form enctype="multipart/form-data" class="admin_form" data-parsley-validate id="admin_form" method="post" enctype="multipart/form-data" action="{$config.url}/admincp/banner/save">
      <input type="hidden" name="id" value="{$banner.id}" /> 
    <div class="col-lg-4">
      <div class="form-group">
        <label>{$pharse.name}</label>
        <input class="form-control" name="name" type="text" value="{$banner.title}" data-parsley-group="block1" required>
      </div>
      <div class="form-group">
        <label>{$pharse.sub_heading}</label>
        <input class="form-control" name="subtitle" type="text" value="{$banner.subtitle}" data-parsley-group="block1" required>
      </div>
      <div class="form-group">
        <label>{$pharse.banner} </label>
        <input type="file" name="banner_image" {if $banner.id == ''}required {/if}> <small>{$banner.o_image}</small>
      </div>
      <div class="form-group">
        <label>{$pharse.list_products}</label>
        <select name="pcat"  required data-parsley-mincheck="1" class="form-control"  required >
          {foreach $maincategory as $key => $val}
          <option value="{$val.id}" {if $val.id == $banner.cid} {$pharse.selected }{/if}>{$val.name}</option>
          {/foreach}

        </select>

      </div>
      <div class="form-group">
        <label>{$pharse.offer_price}</label>
        <input class="form-control" name="offer_price" type="text" value="{$banner.offer_price}" data-parsley-group="block1" >
      </div>

      <div class="form-group">
        <label>{$pharse.enable}</label>
        <input class="custom-checkbox"  {if $banner.enable} checked {/if} name="enable" data-parsley-group="block1" required type = "checkbox" >
      </div>
      <input type="submit" class="btn btn-success"> <i class="fa fa-save"></i>
    </div>
    </form>
  </div>
</div>
{include file="/admincp/footer.tpl" nocache} 
<script type="text/javascript">
$(document).ready(function()
{


 });  
</script>