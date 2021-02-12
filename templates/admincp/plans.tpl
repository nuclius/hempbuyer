{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

  <!-- Page Heading -->
  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <ol class="breadcrumb">
        <li class="active"> <!-- <i class="fa fa-sitemap"></i> --> {$phrases.plans} </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  <div class="row">
   <div class="col-lg-12">
    {if $saved}
      <div class="alert alert-success"> <strong>Saved!</strong> </div>
    {/if}
   </div>
   <form action="{$config.url}/admincp/membership/plan-create" data-parsley-validate method="post">
    <div class="col-md-12">
      <input type="hidden" name="id" value="{$id}" />
      <div class="row">
        <div class="col-sm-6">
          <div class="form-group">
            <label>{$phrases.plan_name}</label>
            <input type="text" class="form-control" value="{$name}" required name="name" />
          </div>
        </div>
        <div class="col-sm-6">
          <div class="form-group">
            <label>{$phrases.roles}</label>
            <select class="form-control" name="plan">
              {foreach $roles as $key=>$val}
                <option value="{$val.id}" {if $plan == $val.id} selected {/if}>{$val.name}</option>
              {/foreach}
            </select>
          </div>
        </div>
      </div>

      <div class="row">
        <div class="col-sm-12">
          <div class="form-group">
            <label>{$phrases.description}</label>
            <textarea rows="5" class="form-control" value="" required name="description">{$description}</textarea>
          </div>
        </div>
      </div>

    <div class="row">
      <div class="col-sm-6">
        <div class="form-group">
          <label>{$phrases.amount}</label>
          <input type="text" class="form-control floatingpoint" value="{$amount}" required name="amount" />
        </div>
      </div>
      <div class="col-sm-6">
        <div class="form-group">
          <label>{$phrases.length_item}</label>
          <input type="text" class="form-control numbers" value="{$length}" required name="length" />
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-6">
        <div class="form-group">
          <label>{$phrases.length_type}</label>
          <select class="form-control" name="type">
            <option value="D" selected>Days</option>
            <!-- <option value="D" {if $format == 'D'}selected{/if} >Days</option> -->
            <!-- <option value="M" {if $format == 'M'}selected{/if}>Months</option> -->
            <!-- <option value="Y" {if $format == 'Y'}selected{/if}>Years</option> -->
          </select>
        </div>
      </div>
      <div class="col-sm-6">
        <div class="form-group">
          <label>{$phrases.permission}</label>
          <select class="form-control" name="permission">
            {foreach $permission as $key=>$val}
              <option value="{$val.id}" {if $permissions == $val.id} selected {/if}>{$val.name}</option>
            {/foreach}
          </select>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-12">
        <div class="form-group">
        <button name="submit" class="btn btn-success centering">  {if $id == 0} Create New {else} Update {/if} Plan </button>  <!--</button><button name="submit" class="btn btn-success">Save Plan  </button>&nbsp;&nbsp;
            <button name="button" class="btn btn-success" onclick="location.href='{$config.url}/admincp/membership/plans'">Create New Plan  </button>-->


        </div>
      </div>
    </div>







    </div>
   </form>
  </div>

   <div class="table-responsive">
    <table class="table table-bordered table-hover">
      <thead>
        <tr>
         <th>{$phrases.name}</th>
         <th>{$phrases.description}</th>
         <th>{$phrases.amount}(Monthly)</th>
         <th>Duration</th>
         <th>{$phrases.action}</th>
        </tr>
      </thead>
      <tbody>
       {foreach $plans as $key => $val}
         <tr>
          <td>{$val.name}</td>
          <td>{$val.description}</td>
          <td>{$val.amount}</td>
          <td>{$val.length} {$val.format}</td>
          <td><a href="{$config.url}/admincp/membership/plan-edit/{$val.id}">Edit</a> | <a  class="deletealert" onclick="return confirm('Are you sure that you want to delete this role?')" href="{$config.url}/admincp/membershipdelete/plan-delete/{$val.id}">Delete</a></td>
         </tr>
       {/foreach}
      </tbody>
    </table>
  </div>
 </div>
</div>

{include file="/admincp/footer.tpl" nocache}
