{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  
  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <ol class="breadcrumb">
        <li class="active"> <i class="icon flaticon-flower-with-leaves"></i> Banner <i class="fa fa-angle-double-right"></i> <i class="fa fa-search"></i> Update </li>
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
        <label>Name</label>
        <input class="form-control" name="name" type="text" value="{$banner.ad_name}" data-parsley-group="block1" required>
      </div>
 
      <div class="form-group">
        <label>Banner </label>
        <input type="file" name="banner_image" {if $banner.id == ''}required {/if}> <small>{$banner.o_image}</small>
      </div>
   
      <div class="form-group">
        <label>Offer Price</label>
        <input class="form-control" name="offer_price" type="text" value="{$banner.offer_price}" data-parsley-group="block1" >
      </div>

      <div class="form-group">
        <label>Enable</label>
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