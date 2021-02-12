{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  
  <div class="row">
    <div class="col-lg-12">
      <ol class="breadcrumb">
        <li class="active"> <i class="icon flaticon-flower-with-leaves"></i> {$phrases.static_pages_list} </li>
      </ol>
    </div>
  </div>

  {if $success}
  <div class="alert alert-success"> <strong>{$error}!</strong> </div>
  {/if}
  {if $failure}
  <div class="alert alert-danger"> <strong>{$error}!</strong> </div>
  {/if}
  <form action="" method="post" id="pay_chk">
    <table class="table table-bordered table-hover">
        <thead>
          <tr>
            <th>{$phrases.page_title}</th>
            <th>{$phrases.action}</th>
          </tr>
        </thead>
        <tbody>
        
        {foreach $pages as $key => $val}
        <tr>
          <td>{$val.name}</td>
          <td><a href="{$config.url}/admincp/static/pages/{$val.id}">Edit</a></td>
        </tr>
        {/foreach}
          </tbody>        
      </table>
  </form>
  
  <!-- /.row --> 
</div>
{include file="/admincp/footer.tpl" nocache} 