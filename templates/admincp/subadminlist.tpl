{include file="/admincp/header.tpl" nocache}

<div class="container-fluid">

    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;"> 
            <ol class="breadcrumb">
                <li class="active" style=" text-transform: capitalize;">
                    {$action} Subadmin
                </li>
            </ol>
        </div>
    </div>
    <form action="{$config.url}/admincp/subadmin/search" method="get">
        <div class="row"> 
            <div class="col-xs-6 col-sm-4 col-md-3 form-group">
                <input type="text" value="{$first_name}" name="first_name" placeholder="firstname">
            </div>
            <div class="col-xs-6 col-sm-4 col-md-3 form-group"> 
                <input type="text" value="{$last_name}"  name="last_name" placeholder="lastname">
            </div>
            <div class="col-xs-6 col-sm-4 col-md-3 form-group"> 
                <input type="text" value="{$email}" name="email" placeholder="email">
            </div>
            <div class="col-xs-6 col-sm-4 col-md-3 form-group">
                <input class="btn  btn-success" type="submit" value="Submit">
            </div> 
        </div>
    </form>
    <div class="table-responsive">
        <table class="table table-bordered table-hover" id="subadminlist">
            <thead>
            <tr> 
                <th>Name</th>
                <th>Email Address</th>
                <th>Type</th>
                <th>Address</th>
                <th>Region</th>
                <th width="100">Action</th>
            </tr>
            </thead>
            <tbody>
            {$usercount = 0}
            {foreach $users as $key => $val}
            {$usercount = 1}
            <tr> 
                <td>{$val.first_name} {$val.last_name}</td>
                <td>
                    <a class="w100 contact_modal" class="btn-link" data-toggle="modal" data-id="{$val.id}"
                       data-email="{$val.email}" data-target="#wireContact">{$val.email}</a>
                </td>
                <td>{if $val.role==2} Sub Admin {/if} {if $val.role==3} Sales Admin {/if}{if $val.role==4} Distributor {/if}</td>
                <td><span  id="bal_{$val.id}">{$val.address1},{$val.city},{$val.phone},{$val.state},{$val.country}-{$val.zip}</span></td>

                <td>{$val.region} </td>

                <td>
                    <a  title='View' href="{$config.url}/admincp/subadmin/edit?id={$val.id}">Edit</a>
                </td>

            </tr>
            {/foreach}
            {if $usercount == 0}
            <tr>
                <td colspan="10">
                    No {$userstatus} Users Found !
                </td>
            </tr>
            {/if}
            </tbody>
        </table>
    </div>
    <div class="row"> 
        <div class="col-sm-8">
            {$pagination_html}
        </div>
    </div>
</div>








  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Enter the message <small></small></h4>
        </div>
        <div class="modal-body">
            <textarea id="reject-message" name="rejectMessage" class="reject-message" style="width:100%"></textarea>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" id="submitreject">Submit</button>  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  {include file="/admincp/footer.tpl" nocache}
  <script type="text/javascript">
    function deleteUser(sid){
  $('#deleteUser').click(function(){
    return confirm('Are you sure want to continue?');
  });
};
    // $(function(){
    //     $(document).ready(function(){
    //         $('#subadminlist').DataTable();
    //     });
    // })
  </script>
