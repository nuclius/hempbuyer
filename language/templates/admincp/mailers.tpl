{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <ol class="breadcrumb">
        <li class="active"> <i class="fa fa-sitemap"></i> {$pharse.email_/_sms_management} </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  <div class="col-lg-12 padt2"> 
 
 <div class="col-md-12 reports2 sear">{$pharse.email_/_sms_management}</div>
  
 
  </div>
  <div class="col-lg-12">
  
  <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>{$pharse.options}</th>
                                        <th>{$pharse.api_user}</th>
                                        <th>{$pharse.api_key}</th>
                                        <th>{$pharse.type}</th>
                                        <th colspan="2" style="text-align:center">{$pharse.action}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                   
                              <tr>
                                                       
                                <td>{$local_id}</td>
                                <td>{$local_user}</td>
                                <td>{$local_pwd}</td>
                                <td>{$local_type}</td>
                                <td><a href="{$config.url}/admincp/settings/localmail">{$pharse.edit}</a>   |
                                {if $local_status == 'no'}
                                <a href="javascript:void(0)" onclick="activate('{$local_id}','{$local_type}')">{$pharse.activate}</a>  
                                {/if}
                                
                                {if $local_status == 'yes'}
                                <a href="javascript:void(0)" onclick="deactivate('{$local_id}','{$local_type}')">{$pharse.deactivate}</a> 
                                {/if}

                               <!-- <a href="javascript:void(0);" onclick="PopupBox2('{$config.url}/admincp/addmailer/delete/{$val.id}');">Delete</a>-->
                               </td>
                               
                               </tr>


                            <tr>
                                                       
                                <td>{$customerio_id}</td>
                                <td>{$customerio_api}</td>
                                <td>{$customerio_key}</td>
                                <td>{$customerio_type}</td>
                                <td><a href="{$config.url}/admincp/settings/customeriomail">{$pharse.edit}</a>   |
                                {if $customerio_status == 'no'}
                                <a href="javascript:void(0)" onclick="activate('{$customerio_id}','{$customerio_type}')">{$pharse.activate}</a>  
                                {/if}
                                
                                {if $customerio_status == 'yes'}
                                <a href="javascript:void(0)" onclick="deactivate('{$customerio_id}','{$customerio_type}')">{$pharse.deactivate}</a> 
                                {/if}

                               <!-- <a href="javascript:void(0);" onclick="PopupBox2('{$config.url}/admincp/addmailer/delete/{$val.id}');">Delete</a>-->
                               </td>

                            </tr>


                            <tr>
                                                       
                                <td>{$smstwo_id}</td>
                                <td>{$smstwo_sid}</td>
                                <td>{$smstwo_token}</td>
                                <td>{$smstwo_type}</td>
                                <td><a href="{$config.url}/admincp/settings/twilliosms">{$pharse.edit}</a>   |
                                {if $smstwo_status == 'no'}
                                <a href="javascript:void(0)" onclick="activate('{$smstwo_id}','{$smstwo_type}')">{$pharse.activate}</a>  
                                {/if}
                                
                                {if $smstwo_status == 'yes'}
                                <a href="javascript:void(0)" onclick="deactivate('{$smstwo_id}','{$smstwo_type}')">{$pharse.deactivate}</a> 
                                {/if}

                               <!-- <a href="javascript:void(0);" onclick="PopupBox2('{$config.url}/admincp/addmailer/delete/{$val.id}');">Delete</a>-->
                               </td>

                            </tr>
                            
                            
                               
                                </tbody>
                            </table>
                            
                            
                            <div class="pull-right">
                            
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