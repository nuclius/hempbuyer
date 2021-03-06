{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

  <!-- Page Heading -->
  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <ol class="breadcrumb">
        <li class="active"> <i class="fa fa-sitemap"></i> {$pharse.plans} </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  <div class="row">
   <div class="col-lg-12">
    {if $saved}
      <div class="alert alert-success"> <strong>{$pharse.saved!}</strong> </div>
    {/if}
   </div>
   <form action="{$config.url}/admincp/membership/plan-create" data-parsley-validate method="post">
    <div class="col-md-12">
      <input type="hidden" name="id" value="{$id}" />
      <div class="row">
        <div class="col-sm-6">
          <div class="form-group">
        <label>{$pharse.plan_name}</label>
        <input type="text" class="form-control" value="{$name}" required name="name" />
      </div>
        </div>
        <div class="col-sm-6">
          <div class="form-group">
            <label>{$pharse.role}</label>
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
            <label>{$pharse.description}</label>
            <textarea class="form-control" value="" required name="description">{$description}</textarea>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-sm-6">
          <div class="form-group">
            <label>{$pharse.amount}</label>
            <input type="text" class="form-control floatingpoint" value="{$amount}" required name="amount" />
          </div>
        </div>
        <div class="col-sm-6">
          <div class="form-group">
            <label>{$pharse.length}</label>
            <input type="text" class="form-control numbers" value="{$length}" required name="length" />
          </div>
        </div>
      </div>

      <div class="row">
        <div class="col-sm-6">
          <div class="form-group">
            <label>{$pharse.length_type}</label>
            <select class="form-control" name="type">
              <option value="D" {if $format == 'D'}selected{/if} >{$pharse.days}</option>
              <option value="M" {if $format == 'M'}selected{/if}>{$pharse.months}</option>
              <option value="Y" {if $format == 'Y'}selected{/if}>{$pharse.years}</option>
            </select>
          </div>
        </div>
        <div class="col-sm-6">
          <div class="form-group">
            <label>{$pharse.permission}</label>
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
          <button name="submit" class="btn btn-success centering">  {if $id == 0} {$pharse.create_new} {else} {$pharse.update} {/if} {$pharse.plan} </button>  <!--</button><button name="submit" class="btn btn-success">Save Plan  </button>&nbsp;&nbsp;
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
         <th>{$pharse.name}</th>
         <th>{$pharse.description}</th>
         <th>{$pharse.amount}</th>
         <th>{$pharse.plan_duration}</th>
         <th>{$pharse.action}</th>
        </tr>
      </thead>
      <tbody>
       {foreach $plans as $key => $val}
         <tr>
          <td>{$val.name}</td>
          <td>{$val.description}</td>
          <td>{$val.amount}</td>
          <td>{$val.length} {$val.type}</td>
          <td><a href="{$config.url}/admincp/membership/plan-edit/{$val.id}">{$pharse.edit}</a> | <a  class="deletealert" onclick="return confirm('Are you sure that you want to delete this role?')" href="{$config.url}/admincp/membershipdelete/plan-delete/{$val.id}">{$pharse.delete}</a></td>
         </tr>
       {/foreach}
      </tbody>
    </table>
  </div>
 </div>
</div>

{include file="/admincp/footer.tpl" nocache}
