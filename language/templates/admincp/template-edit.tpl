{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-file"></i> {$_phrase.templates} <i class="fa fa-hand-o-right"></i> <i class="fa fa-settings"></i> 
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
                <div class="row">
                       <div class="col-lg-12">
                          {if $error == 'saved'}
                           <div class="alert alert-success"> <strong>{$pharse.saved!}</strong> {$pharse.phrases_was_successfully_changed} </div>
                          {elseif $error != ''}
                           <div class="alert alert-danger"> <strong>{$error}</strong> </div>
                          {/if}
                        </div>
                         <div class="alert alert-danger"> 
                          <strong>{$pharse.please_careful_in_template.site_will_be_broken_if_you_misused_template.we_using_smarty_template_so_if_you_have_smarty_knowdledge_please_edit_this...}<br />
                          For phrases use like this inside template $_phrase.template_identifier_name (eg:{literal}{$_phrase.register}{/literal})
                          </strong>
                         </div>

                        <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="post" enctype="multipart/form-data" action="{$config.url}/admincp/template/save">  
                                 <div class="row">
                                 <div class="col-lg-12">
                                  <div class="col-lg-4">{$pharse.template_name}</div>
                                  <div class="col-lg-4"><b>{$template_name}</b></div>
                                   
                                 </div>  
                                 </div>  
                                                       
                               	  
                                  <div class="row">                            
                                       <div class="col-lg-12">
                                       
                                          <input type="hidden" value="{$template_name}" name="tmp" />
                                          <textarea class="form-control" name="template_value" rows="55" cols="55">{$template_value}</textarea>
                                        
                                       </div>
                                    </div>   
                                  
                         
                          <div class="col-lg-12">
                          <div class="col-lg-4">    
                             <input type="submit" value="Submit" name="id" class="btn-success btn" />
                          </div>    
                           </div>    
                           

                          
                        </form>

                    

                </div>	
                

               
                <!-- /.row -->
</div>
           
{include file="/admincp/footer.tpl" nocache}
