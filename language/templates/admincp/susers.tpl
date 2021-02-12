{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">
<style type="text/css">
.jkm {
	padding-top:9%;
}
@media screen and (max-width:1200px) {
.jkm {
	padding-top:0%;
}	
}
</style>
                <!-- Page Heading -->
                
                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">
                        
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-user"></i>  <i class="fa fa-hand-o-right"></i> <i class="fa fa-search"></i> {$pharse.search_users}
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                   <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/admincp/users/search">
                        
                         <div class="col-lg-4"> 

                            <div class="form-group">
                                <label>{$pharse.email}</label>
                                <input class="form-control" name="email" value="{$search.email}">
                               
                            </div>
                             <div class="form-group">
                                <label>{$pharse.status
}</label>
                                <select class="form-control" name="status">
                                    <option value="" {if $search.status == ''} selected {/if}>{$pharse.all}</option>
                                    <option value="active"  {if $search.status == 'active'} selected {/if}>{$pharse.active}</option>
                                    <option value="moderate"  {if $search.status == 'moderate'} selected {/if}>{$pharse.moderate}</option>
                                    <option value="deactivate"  {if $search.status == 'deactivate'} selected {/if}>{$pharse.deactivate}</option>
                                    <option value="unsubscribe"  {if $search.status == 'unsubscribe'} selected {/if}>{$pharse.unsubscribe}</option>
                                    <option value="unverified"  {if $search.status == 'unverified'} selected {/if}>{$pharse.unverified}</option>
                                </select>
                            </div>
                         </div>   
                          <div class="col-lg-4">   
                            <div class="form-group">
                                <label>{$pharse.first_name}</label>
                                <input class="form-control" placeholder="Enter First Name" value="{$search.first_name}" name="first_name">
                            </div>

                         

                           
                            <div class="form-group">
                                <label>{$pharse.last_name}</label>
                                <input class="form-control" placeholder="Enter Last Name" value="{$search.last_name}" name="last_name">
                            </div>

                           

                          </div>   
                          <div class="col-lg-4 jkm">   
                            <div class="form-group">
                              <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$pharse.search}</button>
                           </div>

                         </div>
                           

                             
                        </form>
                 
                </div>    
                
                {include file="/admincp/user-list.tpl" nocache}

               
                <!-- /.row -->
</div>
           
{include file="/admincp/footer.tpl" nocache}
