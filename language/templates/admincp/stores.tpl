{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  
  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <ol class="breadcrumb">
        <li class="active"> <i class="fa fa-sitemap"></i> {$pharse.stores} <i class="fa fa-hand-o-right"></i> <i class="fa fa-list"></i> List </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  <div class="row">
   
  </div>
  <div class="row">
    <div class="col-lg-12">
      <div class="row">
      {if $error != ''}<div class="alert alert-success">{$error}</div>{/if}
                   <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/admincp/stores/">
                        
                         <div class="col-lg-4">
                            <div class="form-group">
                                <label>{$pharse.enable_store}</label>
                                <input  type="radio" {if $config.stores.enable == 1} checked {/if} name="enable" value="1">  Yes
                                
                                <input type="radio" {if $config.stores.enable == 0} checked {/if} name="enable" value="0">  {$pharse.no}                                      
                            </div> 
                            <div class="form-group">
                                <label>{$pharse.title}</label>
                                <input class="form-control" name="title" value="{$search.title}">                               
                            </div>
                            <div class="form-group">
                                <label>{$pharse.location}</label>
                                <input class="form-control"  value="{$search.location}" name="location">
                            </div>
                          </div>  

                          <div class="col-lg-4">   
                            <div class="form-group">
                                <label>{$pharse.status}</label>
                                 <select class="form-control" name="status">
                                    <option value="" {if $search.status == ''} selected {/if}>All</option>
                                    <option value="active"  {if $search.status == 'open'} selected {/if}>{$pharse.active}</option>
                                    <option value="inactive"  {if $search.status == 'closed'} selected {/if}>{$pharse.inactive}</option>
                                    
                                </select>
                            </div>
                             
                            <div class="form-group">
                                <br />
                              <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$pharse.save/search}</button>
                           </div>
                          </div>   
                          
                           

                             
                        </form>
                 
                </div>
      <div class="table-responsive">
        <table class="table table-bordered table-hover">
          <thead>
            <tr>
              <th>{$pharse.store}</th>
              <th>{$pharse.location}</th>
              <th>{$pharse.products}</th>
              <th>{$pharse.sold}</th>
              <th>{$pharse.status}</th>
              <th>{$pharse.action}</th>
            </tr>
          </thead>
          <tbody>
          {foreach $stores as $key => $val}
          <tr>
    
            <td>{$val.name}</td>
            <td>{$val.location}</td>
            <td>{$val.products}</td>
            <td>{if $val.saled == $nuller}0{else if $val.saled != $nuller}{$val.saled}{/if}</td>
            <td>{$val.status}</td>
            <td><a href="{$config.url}/admincp/stores/edit/{$val.id}">{$pharse.edit}</a>
            <a href="{$config.url}/admincp/stores/delete/{$val.id}">{$pharse.delete}</a>
            <a href="{$config.url}/stores/view/{$val.id}" target="_blank">{$pharse.view}</a></td>
          </tr>
          {/foreach}
         
            </tbody>
          
        </table>
        </div>
    </div>
  </div>
  
  <!-- /.row --> 
</div>
{include file="/admincp/footer.tpl" nocache} 