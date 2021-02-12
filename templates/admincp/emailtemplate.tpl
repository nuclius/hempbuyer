{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  <style>
  input[type="radio"] {
    position: unset !important;
    opacity: 1;
    float: left;
  }
  </style>
  <!-- Page Heading -->
  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <ol class="breadcrumb">
        <li class="active"> <!-- <i class="fa fa-sitemap"></i> --> {$phrases.email_templates_management} </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  <div class="padt2"> 
  <form name="emailtemp" method="get" action="{$config.url}/admincp/emailtemplate/search" class="form-horizontal" id="search_form">
            <input type="hidden" name="is_export" id="is_export" value="0">
 
   <div class="col-md-8 reports2 padlef sear">{$phrases.search_email_templates}</div>
   
   <div class="clear"></div>
   
   <div class="form-group">
        <label class="col-sm-2 control-label">{$phrases.subject}</label>
        <div class="col-sm-6">
        <input type="text" name="subjects" value="{$search.subjects}" placeholder="" class="form-control">
        </div>
        </div>
   
   <div class="form-group">
        <label class="col-sm-2 control-label">{$phrases.user_type}</label>
        <div class="col-sm-8 usr-stxt">
        <label class="radio-inline">
  		<input type="radio" checked name="users" value=""> {$phrases.search_all}
		</label>
		<label class="radio-inline">
  		<input type="radio" name="users" value="buyer" {if $search.users == 'buyer'}checked{/if}> {$phrases.buyers_only}
		</label>
        <label class="radio-inline">
  		<input type="radio" name="users" value="seller" {if $search.users == 'seller'}checked{/if}> {$phrases.sellers_only}
		</label>
        <label class="radio-inline"> 
  		<input type="radio" name="users" value="admin" {if $search.users == 'admin'}checked{/if}> {$phrases.admin_only}
		</label>
        <label class="radio-inline">
  		<input type="radio" name="users" value="general" {if $search.users == 'general'}checked{/if}> {$phrases.general_only}
		</label>
        </div>
        </div>
          
      <div class="form-group">
        <label class="col-sm-2 control-label">{$phrases.type}</label>
        <div class="col-sm-4">
         <select class="form-control" name="types">
         <option value="">All</option>
         <option value="global" {if $search.types == 'global'}selected{/if}>Global</option>
         <option value="product" {if $search.types == 'product'}selected{/if}>Product</option>
         <option value="service" {if $search.types == 'service'}selected{/if}>Service</option>
        </select>
        
         </div>
      </div>
      
      <div class="form-group">
      <label class="col-sm-2 control-label hidden-xs"></label>
      <div class="col-sm-4">
         <button type="submit" class="btn btn-success">Search</button> 
       </div>
      </div>
   </form>
 <div class="col-md-12 reports2 sear">{$phrases.email_templates}</div>
  
  <div class="pull-left">
  <a href="{$config.url}/admincp/addemailtemplate" class="btn btn-success"> {$phrases.add_new_email_template}</a>
  </div>
 
  <div class="pull-right padt1">
   {* <a href="{$config.url}/admincp/templateexport" style="margin-bottom:10px" class="btn btn-success pull-right">{$phrases.export}</a> *}
  <a class="btn btn-success" onclick="exportTemplate()"> {$phrases.export}</a>

  </div>
 
   <div class="pull-right padt1">
   
  
   <a href="{$config.url}/admincp/templateimport?temptype=email" style="margin-bottom:10px" class="btn btn-success pull-right">{$phrases.import}</a>


  </div>

  </div> 
  <div class="table-responsive" style="float: left; width: 100%;">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                       
                                        <th>{$phrases.event}</th>
                                        <th>{$phrases.subject}</th>
                                        <th>{$phrases.buyer}</th>
                                         <th>{$phrases.seller}</th>
                                          <th>{$phrases.admin}</th>
                                           <th>{$phrases.general}</th>
                                        <th>{$phrases.type}</th>
                                        <th colspan="2" style="text-align:center">{$phrases.action}</th>
                                    </tr>
                                </thead>
                                <tbody>

                                {$reviewcount = 0}
                                 {foreach $templates as $key => $val}   
                                {$reviewcount = 1}
                                                            <tr>
                                                           
                                <td>{$val.title}</td>
                                <td>{$val.subject}</td>
                                <td align="center"><input type="checkbox" {if $val.buyer == 1}checked="checked"{/if} disabled readonly /></td>
                                <td align="center"><input type="checkbox" {if $val.seller == 1}checked="checked"{/if} disabled readonly/></td>
                                <td align="center"><input type="checkbox" {if $val.admin == 1}checked="checked"{/if} disabled readonly/></td>
                                <td align="center"><input type="checkbox" {if $val.general == 1}checked="checked"{/if} disabled readonly/></td>
                                <td>{$val.type}</td>
                                <td><a href="{$config.url}/admincp/etemps/edit/{$val.id}">Edit</a></td>
                                <td><a href="javascript:void(0);" onclick="PopupBox2('{$config.url}/admincp/etemps/delete/{$val.id}');">Delete</a></td>
                            </tr>
                             {/foreach}
                             {if $reviewcount ==0}
                                 <tr>
                                     <td colspan="9">
                                       {$phrases.no_email_templates_found}
                                     </td>
                                 </tr>
                             {/if}
                                </tbody>
                            </table>
                            
                            
                            <div class="pull-right">
                              {$pagination_html}
                            </div>
                            
                        </div>
  
  </div>  
</div> 

{include file="/admincp/footer.tpl" nocache} 


<style type="text/css">

.form-horizontal .control-label {

  text-align: left;
}

</style>
<script>

var is_export = 0;
function exportTemplate() {
    is_export = 1;
    $("#is_export").val(1);
    $('#search_form').trigger('submit');
    $("#is_export").val(0);
}
</script>