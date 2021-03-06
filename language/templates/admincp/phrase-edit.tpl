{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">
                        
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-user"></i> {$pharse.users} <i class="fa fa-hand-o-right"></i> <i class="fa fa-settings"></i> 
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
                        <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="post" enctype="multipart/form-data" action="{$config.url}/admincp/language/save_phrase">  
                                 <div class="row">
                                 <div class="col-lg-12">
                                  <div class="col-lg-4">{$pharse.phrases_identifier}</div>
                                  <div class="col-lg-4">{$pharse.phrases_text}</div>
                                   
                                 </div>  
                                 </div>  
                                                       
                               	  
                                  <div class="row">                            
                                       <div class="col-lg-12">
                                        <div class="col-lg-4">{$phrase_name}</div>

                                        <div class="col-lg-4">
                                          <input type="hidden" value="{$phrase_name}" name="phrase_name" />
                                          <textarea class="form-control" name="phrase_value" rows="5" cols="5">{$phrase_value}</textarea>
                                        </div>
                                       </div>
                                    </div>   
                                  
                         
                          <div class="col-lg-12" style="margin-bottom:2%;">
                          <div class="col-lg-4">    
                             <input type="submit" value="Submit" name="id" class="btn-success btn" />
                          </div>    
                           </div>    
                           

                          
                        </form>

                    

                </div>	
                

               
                <!-- /.row -->
</div>
           
{include file="/admincp/footer.tpl" nocache}
