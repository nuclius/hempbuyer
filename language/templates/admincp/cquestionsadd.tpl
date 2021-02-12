{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  <div class="row">
    <div class="col-lg-12">
      <ol class="breadcrumb">
        <li class="active"> <i class="fa fa-sitemap"></i> {$pharse.category_questions_of} {$ctitle} </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  <div class="row">
    <div class="col-lg-12"> {if $error == 'saved'}
      <div class="alert alert-success"> <strong>Saved!</strong> {$categories.name} {$pharse.categories_was_successfully_changed} </div>
      {elseif $error != ''}
      <div class="alert alert-danger"> <strong>{$error}</strong> </div>
      {/if}</div>
      <div class="row">
         
      </div>
      <div class="row">
        <div class="col-md-12 m-top-20">
          <form method="POST" enctype="multipart/form-data" class="admin_form" data-parsley-validate name="add-product" id="add-product" action="/admincp/cquestions/save">   
            <input type="hidden" value="{$cid}" name="cid" />  
            <input type="hidden" value="{$id}" name="id" /> 
            <div class="form-group">
              <label>{$pharse.category_name}</label>
              {$ctitle}
            </div>
             <div class="form-group">
              <label>{$pharse.question_name}</label>
              <input name="name" data-parsley-group="block1" data-parsley-required  value="{$questions.name}"  type="text" class="form-control">
            </div>
             <div class="form-group">
              <label>{$pharse.question_type}</label>
              <select name="type" data-parsley-group="block1" data-parsley-required  class="form-control">
                <option value="int" {if $questions.type == 'int'} selected {/if}>{$pharse.int}</option>
                <option value="float" {if $questions.type == 'float'} selected {/if}>{$pharse.float}</option>
                <option value="input" {if $questions.type == 'input'} selected {/if}>{$pharse.input}</option>
                <option value="textarea" {if $questions.type == 'textarea'} selected {/if}>{$pharse.textarea}</option>
                <option value="dropdown" {if $questions.type == 'dropdown'} selected {/if}>{$pharse.dropdown}</option>
                <option value="checkbox" {if $questions.type == 'checkbox'} selected {/if}>{$pharse.checkbox}</option>
                <option value="radio" {if $questions.type == 'radio'} selected {/if}>{$pharse.radio}</option>
              </select>
            </div>
            <div class="form-group">
              <label>{$pharse.multiple_values(use_|_to_seperate_multiple_values_(eg_:_cake|icecream|fruits))}</label>
              <input name="value" data-parsley-group="block1" value="{$questions.value}"  type="text" class="form-control">
            </div>
            <div class="form-group">
              <label>{$pharse.default_value}</label>
              <input name="default" data-parsley-group="block1" value="{$questions.default}"  type="text" class="form-control">
            </div>
             <div class="form-group">
              <label>{$pharse.required}</label>
              <input name="required" data-parsley-group="block1" value="1"  type="radio" {if $questions.required == 1} checked {/if}> {$pharse.yes}
              <input name="required" data-parsley-group="block1" value="0"  type="radio" {if $questions.required != 1} checked {/if}> {$pharse.no}
            </div>
           <input name="submit_user_profile" class="btn btn-warning" value="Reset" title="Reset" class="fl" type="reset">
           <input name="admin_product_add" class="btn btn-success" value="Save" title="Add" class="fl" type="submit">
         </form>
        </div>  
      </div>  

    </div>
    
  </div>
 </div> 

{include file="/admincp/footer.tpl" nocache} 