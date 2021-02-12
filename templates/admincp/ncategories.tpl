{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  <div class="row">
    <div class="col-lg-12">
      <ol class="breadcrumb">
        <li class="active"> <!-- <i class="fa fa-sitemap"></i> -->  <i class="fa fa-angle-double-right"></i> <!-- <i class="fa fa-edit"></i> --> {if $categories.id == 0 or $categories.id == ''} Add {else} Edit {/if} Category <i class="fa fa-angle-double-right"></i> {$projects.title} </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  <div class="row">
    <div class="col-lg-12"> {if $error == 'saved'}
      <div class="alert alert-success"> <strong>Saved!</strong> {$categories.name} categories was successfully changed. </div>
      {elseif $error != ''}
      <div class="alert alert-danger"> <strong>{$error}</strong> </div>
      {/if}</div>
      <div class="col-lg-6">
   <form method="POST" enctype="multipart/form-data" class="admin_form" data-parsley-validate name="add-product" id="add-product" action="/admincp/categories/save">   
     <input type="hidden" value="{$categories.id}" name="id" />  
      <div class="form-group">
        <label>{$phrases.category_title}</label>
        <input name="title" data-parsley-group="block1" required id="product_name" maxlength="99" value="{$categories.name}" onKeyUp="return limitlength(this,99,'info_label')" type="text" class="form-control">
      </div>
    
     <div class="form-group">
        <label>{$phrases.parent_category}</label>

        <select name="categories" class="form-control">

               <option value="0">- Select Parent -</option> 
           {foreach $pcategories as $key => $val}
              {if  $val.id != $categories.id}
              {$i = 1}
               {while $i <= $val.depth}
  --&nbsp;&nbsp;
  {$i= $i+1}
{/while}<option value="{$val.id}"  {if $val.id == $categories.parent_id}selected{/if}>{$val.name}</option> 
              {/if} 
            {/foreach}
        </select> 
      </div>

     <div class="form-group">
      <div class="checkbox chk12 newadmclr">
        <label class="newadmclr">
          <input type="checkbox" value=1 name="ob_market" data-parsley-multiple="mymultiplelink" class="auction" required data-parsley-mincheck="1" {if $categories.ob_market == 1} checked {/if}>
           {$phrases.openbid_market}</label>

        <label class="newadmclr">
          <input type="checkbox" value=1 name="db_market" data-parsley-multiple="mymultiplelink" class="auction" required data-parsley-mincheck="1" {if $categories.db_market == 1} checked {/if}>
           {$phrases.directbuy_market}</label>
           <!--   -->
      </div>
     </div>

      <div class="form-group">
        <label>{$phrases.category_description}</label>
        <textarea class="form-control" name="description" id="product_info"  value="" onkeyup="limitlengths(this, 500,'product_info_label')" required> {$categories.description}
        </textarea>
      </div>
      
      <input name="submit_user_profile" class="btn btn-warning" value="Reset" title="Reset" class="fl" type="reset">
      <input name="admin_product_add" class="btn btn-success" value="Save" title="Add" class="fl" type="submit">
    </form>
    </div>
    
  </div>
 </div> 

{include file="/admincp/footer.tpl" nocache} 
<script language="javascript" type="text/javascript">

$(function()
{
   Date.dayNames = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    Date.format = 'mm/dd/yyyy';
    $("#date_added").datePicker({ clickInput: false, 
        createButton: false, 
        showYearNavigation: false, 
        showHeader:2
    }).bind(
        'focus click keydown',
        function()
        {
          $("#date_added").dpRerenderCalendar();
          $("#date_added").dpSetStartDate($("#date_added").val());
            //$(obj).dpSetStartDate($("#funddater_"+curid).val());
            $("#date_added").dpDisplay();
      }
   );
   
    $("#date_closed").datePicker({ clickInput: false, 
        createButton: false, 
        showYearNavigation: false, 
        showHeader:2
    }).bind(
        'focus click keydown',
        function()
        {
          $("#date_closed").dpRerenderCalendar();
          $("#date_closed").dpSetStartDate($("#date_added").val());
            //$(obj).dpSetStartDate($("#funddater_"+curid).val());
            $("#date_closed").dpDisplay();
      }
   );
   
});
     </script>