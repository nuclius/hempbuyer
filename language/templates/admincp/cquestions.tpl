{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  <div class="row">
    <div class="col-lg-12">
      <ol class="breadcrumb">
        <li class="active"> <i class="fa fa-sitemap"></i> {$pharse.category_questions_of} {$ctitle} </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  <div class="row">
    <div class="col-lg-12"> {if $error == 'saved'}
      <div class="alert alert-success"> <strong>{$pharse.saved!}</strong> {$categories.name} {$pharse.categories_was_successfully_changed} </div>
      {elseif $error != ''}
      <div class="alert alert-danger"> <strong>{$error}</strong> </div>
      {/if}</div>
      <div class="row">
          <div class="col-lg-12">
            <a href="{$config.url}/admincp/cquestionadd/{$id}" class="btn btn-success">{$pharse.add_questions}</a>
          </div>
      </div><br>
      <div class="row">
        <div class="col-md-12 m-top-20">
          
           <table class="table table-bordered table-hover">
              <thead><td>{$pharse.name}</td><td>{$pharse.value}</td><td>{$pharse.type}</td><td>{$pharse.default}</td><td>{$pharse.required}</td><td>{$pharse.edit}</td></thead>
              {foreach $questions as $key=>$val}
                <tr><td>{$val.name}</td><td>{$val.value}</td><td>{$val.type}</td><td>{$val.default}</td><td>{if $val.required == 1}{$pharse.yes} {else if $val.required == 0} {$pharse.no} {/if}</td><td><a href="{$config.url}/admincp/cquestionedit/{$val.cid}/{$val.id}">Edit</a></td></tr>
              {/foreach}
           </table>
        </div>  
      </div>  

    </div>
    
  </div>
 </div> 

{include file="/admincp/footer.tpl" nocache} 