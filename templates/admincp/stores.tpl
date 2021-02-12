{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

  <!-- Page Heading -->

  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <ol class="breadcrumb">
        <li class="active"> <!-- <i class="fa fa-sitemap"></i> --> {$phrases.stores_list}</li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  <div class="row">

  </div>
  <div class="row">
    <div class="col-lg-12">
      <div class="row">
      {if $error != ''}<div class="alert alert-success">{$error}</div>{/if}
                   <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/admincp/stores/">
                          <div class="form-group">
                                <label>{$phrases.enable_store}</label>
                                <input  type="radio" {if $enabled == 'yes'} checked {/if} name="enable" value="yes">  Yes
                                <input type="radio" {if $enabled == 'no'} checked {/if} name="enable" value="no">  No
                          </div>
                         <div class="col-lg-4">
                            <div class="form-group">
                                <label>{$phrases.title}</label>
                                <input class="form-control" name="title" value="{$search.title}">
                            </div>
                            <div class="form-group">
                                <label>{$phrases.location}</label>
                                <input class="form-control"  value="{$search.location}" name="location">
                            </div>
                          </div>
                          <div class="col-lg-4">
                             <div class="form-group">
                                <label>Country</label>
                                  <select class="form-control" name="country" id="country_abbr">
                                    <option value="{$search.country}">Select Country</option>
                                  </select>
                            </div>

                            <div class="form-group">
                                <label>State</label>
                                  <select class="form-control" name="state" id="state_abbr">
                                    <option value="{$search.state}">Select State</option>
                                  </select>
                            </div>
                          </div>

                          <div class="col-lg-4">
                            <div class="form-group">
                                <label>{$phrases.status}</label>
                                 <select class="form-control" name="status">
                                    <option value="" {if $search.status == ''} selected {/if}>All</option>
                                    <option value="active"  {if $search.status == 'active'} selected {/if}>Active</option>
                                    <option value="inactive"  {if $search.status == 'inactive'} selected {/if}>Inactive</option>

                                </select>
                            </div>

                            <div class="form-group">
                                <br />
                              <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$phrases.save_search}</button>
                           </div>
                          </div>
                        </form>
                </div>
      <div class="table-responsive">
        <table class="table table-bordered table-hover">
          <thead>
            <tr>
            {if !$loged.roleid==4}
              <th>Select</th>
            {/if}
              <th>Date Added</th>
              <th>Store Name</th>
              <th>User Email Address</th>
              <th>{$phrases.location}</th>
              <th># of Product</th>
              <th>Transaction</th>
              <th>{$phrases.status}</th>
              <th>{$phrases.action}</th>
            </tr>
          </thead>
          <tbody>
          {if $paginaton>0}
          {foreach $stores as $key => $val}
          <tr>
            {if !$loged.roleid==4}
            <td><input type="checkbox" name="checkUser" id="checkuser_{$val.id}" onchange="selectUsers({$val.id})"></td>
            {/if}
            <td>{$val.date_added}</td>
            <td>{$val.name}</td>
            <td><a class="w100 contact_modal" class="btn-link" data-toggle="modal" data-id="{$val.id}" data-email="{$val.email}" data-target="#wireContact">{$val.email}</a></td>
            <td>{$val.address}</td>
            <td>{$val.products}</td>
            <td>{if $val.saled == $nuller}0{else if $val.saled != $nuller}{$val.saled}{/if}</td>
            <td>{$val.status}</td>
            <td>
            {if !$loged.roleid==4}
            <a href="{$config.url}/admincp/stores/edit/{$val.id}">Edit</a>
            <a href="javascript:void(0);" onclick="PopupBox2('{$config.url}/admincp/stores/delete/{$val.id}');">Delete</a>
            {/if}
            <a href="{$config.url}/stores/view/{$val.id}" target="_blank">View</a></td>
          </tr>
          {/foreach}
          {else}
         <tr>
             <td colspan="9">
                {$phrases.no_stores_are_added}
             </td>
         </tr>
        {/if}
            </tbody>

        </table>
        <div class="pull-right">
              {$pagination_html}
        </div>
        {if !$loged.roleid==4}
        <div class="col-lg-12">
            <div class="form-group">
                <button type="button" class="btn btn-danger centering" data-toggle="tooltip" title="Select multiple users and then click to delete" onclick="deleteUsers()"> <i class="fa fa-trash"></i> Delete </button>
            </div>
        </div>
        {/if}
        </div>
    </div>
  </div>

  <!-- /.row -->
</div>
{include file="/admincp/footer.tpl" nocache}


<div class="modal fade" id="wireContact" role="dialog">
        <div class="modal-dialog modal-sm" style="width:50% !important;">
            <!-- Modal content-->
            <div id="contact_form" class="modal-content">
                <div class="modal-header p0">
                    <div class="panel panel-success border-0">
                        <div class="panel-heading green-bg">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h3>Enter the message...!</h3>
                        </div>
                    </div>
                </div>
                <div class="modal-body form-horizontal">
                       <input type="hidden" value="0" name="r_id" id="r_id">
                     <div class="form-group">
                      <label class="col-sm-3 col-md-2 control-label">Email-ID* :</label>
                      <div class="col-sm-9 col-md-10">
                       <input type="email" name="users" id="to_email" disabled=""  class="form-control"/>
                      </div>
                    </div>
                      <div class="form-group">
                        <label class="col-sm-3 col-md-2 control-label">Subject : </label>
                        <div class="col-sm-9 col-md-10">
                       <input type="sub_msg" name="subject" id="sub_msg" data-parsley-required data-parsley-required-message = "Please enter subject"  class="form-control"/>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-3 col-md-2 control-label">Message : </label>
                        <div class="col-sm-9 col-md-10">
                      <textarea name="message" id="body_msg" rows="6" data-parsley-required-message = "Please enter message to proceed..."></textarea>
                        </div>
                      </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default btn-d-b green-b m0" type="button" onclick="sendMessage()">SEND</button>
                    <button class="btn btn-default btn-d-b green-b m0" type="button" data-dismiss="modal">CLOSE</button>
                </div>

            </div>
        </div>
    </div>
<script type="text/javascript">

$(document).on("click", ".contact_modal", function () {
     var uid = $(this).data('id');
     var to_email = $(this).data('email');
     $(".modal-body #uid").val(uid);
     $(".modal-body #to_email").val(to_email);
     $(".modal-body #sub_msg").val('');
     $(".modal-body #body_msg").val('');
});

function sendMessage(){
        $.ajax({
            type: 'POST',
            url: '{$config.url}/admincp/payment/sendmsg',
            data: {
                r_id : $('#contact_form').find('#r_id').val(),
                id : $('#contact_form').find('#uid').val(),
                users: $('#contact_form').find('#to_email').val(),
                subject: $('#contact_form').find('#sub_msg').val(),
                message: $('#contact_form').find('#body_msg').val()
            },
            dataType: 'json',
            success: function(data) {
                if (data.data==1) {
                  alert('Message Sent');
                }else{
                  alert('Message Failed');
                }
            }
        });
   $('#wireContact').modal('hide');
}




var urr = [];

function selectUsers(sid) {
    if ($('#checkuser_' + sid).prop("checked") == true) {
        urr.push(sid);
    } else {
        urr.splice(urr.indexOf(sid), 1);
       //console.log(urr.indexOf(sid));
    }
   //console.log(urr);
};
/* end here */

/* to Delete the selected users*/
function deleteUsers() {
if (urr.length<1) {
  swal({
        text: "please select stores......",
        type: 'warning',
        confirmButtonColor: 'green',
    });
}else{
    swal({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: 'green',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    }, function(result) {
           //console.log(result);
            if (result) {
                $.ajax({
                type: 'POST',
                url: '/admincp/stores/delete/multiple',
                data: {
                    ids: urr,
                },
                dataType: 'json',
                success: function(data) {
                    if (data.success == true) {
                        swal(
                            'Deleted!',
                            'Selected user has been deleted.',
                            'success'
                        )
                    }
                    window.location = '{$config.url}/admincp/stores';
                }

            });
    }
});


}
}

/* delete section end here*/

$(document).ready(function() {
    $('#country_abbr').val('{$search.country}').change();
    if($('#country_abbr').val() != ''){
        $('#state_abbr').val('{$search.state}').change();
    }

})
</script>
