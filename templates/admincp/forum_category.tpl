{include file="/admincp/header.tpl" nocache} 
<script src="http://ckeditor.com/latest/ckeditor.js"></script>
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  
  <div class="row">
    <div class="col-lg-12">
      <ol class="breadcrumb">
        <li class="active"> <i class="icon flaticon-flower-with-leaves"></i> {$phrases.add_new_discussion_board} <i class="fa fa-angle-double-right"></i> <i class="fa fa-search"></i> </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  
  <div class="row">
    <div class="col-lg-12"> <a href="javascript: history.go(-1)" style="margin-bottom:10px" class="btn btn-success pull-right">&lt;&lt; Back</a> </div>
  </div>
 
  <form action="{$config.url}/admincp/addForumcats" method="post" id="pay_chk" data-parsley-validate>
    <input type="hidden"  value="{$category_id}" name="id" />
    <div class="form-group">
        <label>{$phrases.category_name}</label>

        <input name="cat_name" data-parsley-group="block1" data-parsley-required="true" data-parsley-required-message="This field is required" required id="cat_name" value="{$category_name}" maxlength="99" value="" type="text" class="form-control" >
    </div>
    <div class="form-group">
        <input type="submit" class="btn btn-success" value="Save" />
      </div>
  </form>
  
  <!-- /.row --> 
</div> 

{include file="/admincp/footer.tpl" nocache} 
