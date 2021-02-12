{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <!-- <ol class="breadcrumb">
        <li class="active"> <i class="fa fa-sitemap"></i> Email Templates Management </li>
      </ol> -->
    </div>
  </div>
  <!-- /.row -->
  <div class="col-lg-12 padt2"> 
  
 <div class="col-md-12 reports2 sear">{$phrases.forum_category}</div>
  
  <div class="pull-left">
  <a href="{$config.url}/admincp/forum_cats/" class="btn btn-success">{$phrases.add_new_category}</a>
  </div>
 
  
 
   

  </div>
  <div class="col-lg-12">
  
  <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>{$phrases.category_name}</th>
                                        <th>{$phrases.number_of_post}</th>
                                        
                                        <th colspan="2" style="text-align:center">{$phrases.action}</th>
                                    </tr>
                                </thead>
                                <tbody>

                                {$reviewcount = 0}
                                  {foreach $categories as $key => $val}   
                                {$reviewcount = 1}
                                                            <tr>
                                                           
                                <td>{$val.catname}</td>
                                <td>{$val.total_post}</td>
                                
                                <td><a href="{$config.url}/admincp/forum_cats/edit/{$val.id}">Edit</a></td>
                                <td><a href="javascript:void(0);" onclick="PopupBox2('{$config.url}/admincp/forum_cats/delete/{$val.id}');">Delete</a></td>
                            </tr>
                             {/foreach}
                             {if $reviewcount ==0}
                                 <tr>
                                     <td colspan="9">
                                       {$phrases.no_categories_are_added}
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