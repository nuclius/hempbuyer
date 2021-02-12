{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <ol class="breadcrumb">
        <li class="active"> <i class="fa fa-sitemap"></i> {$pharse.sms_templates_management} </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  <div class="col-lg-12 padt2"> 
  <form name="emailtemp" method="get" action="{$config.url}/admincp/smstemplate/search" class="form-horizontal">
 
   <div class="col-md-8 reports2 padlef sear">{$pharse.search_sms_templates}</div>
   
   <div class="clear"></div>
   
   <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.subject}</label>
        <div class="col-sm-6">
        <input type="text" name="subjects" value="{$search.subjects}" placeholder="" class="form-control">
        </div>
        </div>
   
   <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.user_type}</label>
        <div class="col-sm-8">
        <label class="radio-inline">
  		<input type="radio" checked name="users" value=""> {$pharse.search_all} 
		</label>
		<label class="radio-inline">
  		<input type="radio" name="users" value="buyer" {if $search.users == 'buyer'}checked{/if}> {$pharse.buyers_only}
		</label>
        <label class="radio-inline">
  		<input type="radio" name="users" value="seller" {if $search.users == 'seller'}checked{/if}> {$pharse.sellers_only}
		</label>
        <label class="radio-inline"> 
  		<input type="radio" name="users" value="admin" {if $search.users == 'admin'}checked{/if}> {$pharse.admin_only}
		</label>
        <label class="radio-inline">
  		<input type="radio" name="users" value="general" {if $search.users == 'general'}checked{/if}> {$pharse.general_only}
		</label>
        </div>
        </div>
   
   <!-- <div class="form-group">
        <label class="col-sm-2 control-label">Product</label>
        <div class="col-sm-4">
         <select class="form-control" >
          <option value="ilance">Auctionsoftware</option>
          <option value="lancekb">Knowledge Base</option>
          <option value="ioffer">IOffer</option>
          <option value="lanceads">IAdvertiser</option>
          <option value="stores">Stores</option>
        </select>
        </div>
      </div> -->
      
      <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.type}</label>
        <div class="col-sm-4">
         <select class="form-control" name="types">
         <option value="">All</option>
         <option value="global" {if $search.types == 'global'}selected{/if}>{$pharse.global}</option>
         <option value="product" {if $search.types == 'product'}selected{/if}>{$pharse.product}</option>
         <option value="service" {if $search.types == 'service'}selected{/if}>{$pharse.service}</option>
        </select>
        
         </div>
      </div>
      
      <div class="col-md-12 form-group">
      <label class="col-sm-2 control-label"></label>
      <div class="col-sm-4">
       <button type="submit" class="btn btn-success">{$pharse.search}</button> 
       </div>
      </div>
   </form>
 <div class="col-md-12 reports2 sear">{$pharse.sms_templates}</div>
  
  <div class="pull-left">
  <a href="{$config.url}/admincp/addsmstemplate" class="btn btn-success"> {$pharse.add_new_sms_template}</a>
  </div>
 
  <div class="pull-right padt1">
   <a href="{$config.url}/admincp/templateexport" style="margin-bottom:10px" class="btn btn-success pull-right">{$pharse.export}</a>

  </div>
 
   <div class="pull-right padt1">
   
  
   <a href="{$config.url}/admincp/templateimport?temptype=sms" style="margin-bottom:10px" class="btn btn-success pull-right">{$pharse.import}</a>


  </div>

  </div>
  <div class="col-lg-12">
  
  <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                       
                                        <th>{$pharse.event}</th>
                                        <th>{$pharse.subject}</th>
                                        <th>{$pharse.buyer}</th>
                                         <th>{$pharse.seller}</th>
                                          <th>{$pharse.admin}</th>
                                           <th>{$pharse.general}</th>
                                        <th>Type</th>
                                        <th colspan="2" style="text-align:center">{$pharse.action}</th>
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
                                <td><a href="{$config.url}/admincp/stemps/edit/{$val.id}">{$pharse.edit}</a></td>
                                <td><a href="javascript:void(0);" onclick="PopupBox2('{$config.url}/admincp/stemps/delete/{$val.id}');">{$pharse.delete}</a></td>
                            </tr>
                             {/foreach}
                             {if $reviewcount ==0}
                                 <tr>
                                     <td colspan="9">
                                       {$pharse.no_email_templates_found_!!!}
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
</div> 

{include file="/admincp/footer.tpl" nocache} 


<style type="text/css">

.form-horizontal .control-label {

  text-align: left;
}

</style>