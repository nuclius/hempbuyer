{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

                <!-- Page Heading -->
                
                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">
                        
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-user"></i> Users <i class="fa fa-angle-double-right"></i> <i class="fa fa-edit"></i> Dispute
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                  
                 
                </div>    
                
               <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>{$phrases.name}</th>
                                        <th>{$phrases.subject}</th>
                                        <th>{$phrases.messages}</th>
                                        <th>{$phrases.date_added}</th>
                                        
                                    </tr>
                                </thead>
                                <tbody>
                                  {$reviewcount = 0}
                                 {foreach $review as $key => $val}   
                                   {$reviewcount = 1}
                                    <tr>
                                        <td>{$val.first_name} {$val.last_name}</td>
                                        <td>{$val.subject}</td>
                                        <td>${$val.message}</td>
                                        <td>{$val.date_add}</td>
                                        
                                    </tr>
                                 {/foreach}
                                 {if $reviewcount ==0}
                                  	 <tr>
                                         <td colspan="4">
                                        	 No dispute request found !!!
                                         </td>
                                     </tr>
                                 {/if}
                                </tbody>
                            </table>
                            {$pagination_html}
                        </div>

               
                <!-- /.row -->
</div>
           
{include file="/admincp/footer.tpl" nocache}
