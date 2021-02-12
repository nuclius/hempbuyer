{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <ol class="breadcrumb">
       <li class="active">
                                <a href="{$config.url}/admincp/relationship/"><i class="icon flaticon-flower-with-leaves"></i> <u>Relationship</u> <i class="fa fa-angle-double-right"></i></a> <i class="fa fa-search"></i> User Info
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
         <th>User Id</th>
         <th>Name</th>
         <th>Status</th>
         <th>Email</th>
        </tr>
      </thead>
      <tbody>
      {$plancount = 0}
       {foreach $plans as $key => $val}
       {$plancount = 1}
         <tr>
          <td>{$val.to_id}</td>
          <td>{$val.fname}</td>
          <td>{$val.to_status}{if $val.to_status eq 'open'}ed{elseif $val.to_status eq 'delete' || $val.to_status  eq 'archive'}d{/if}</td>
          <td>{$val.email}</td>
         </tr>
       {/foreach}
       {if $pagination == 0}
                                     <tr>
                                         <td colspan="3">
                                          <h3> No Details Dound!</h3>
                                         </td>
                                     </tr>
                                 {/if}
      </tbody>
    </table>   
     {$pagination_html}  
  </div>
 </div> 
</div> 

{include file="/admincp/footer.tpl" nocache} 
