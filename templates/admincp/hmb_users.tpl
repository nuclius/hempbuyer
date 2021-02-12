{include file="/admincp/header.tpl" nocache}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}jquery.datetimepicker.css" />
<div class="container-fluid">
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active">
                    Users <i class="fa fa-angle-double-right"></i> {$phrases.search_users}
                </li>
            </ol>
        </div>

    </div>
    <!-- /.row -->
    <form id="user_search_form" enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/{$loged.adminUrl}/{if $loged.adminUrl=='admincp'}users{/if}{if $loged.adminUrl=='salesadmin'}salesusers{/if}/search">
            <input type="hidden" name="page" id="page" value="1">
            <input type="hidden" name="action" id="action" value="{$action}">
            <input type="hidden" name="limit" id="limit" value="10">
              <div class="row">
                  <div class="col-xs-6 col-sm-3 form-group"> 
                          <label>Username</label>
                          <input class="form-control" placeholder="Username" value="{$search.username}" name="username"> 
                  </div>
                  <div class="col-xs-6 col-sm-3 form-group">
                          <label>{$phrases.email}</label>
                          <input class="form-control" name="email" placeholder="Email Address" value="{$search.email}"> 
                  </div>
                  <div class="col-xs-6 col-sm-3 form-group">
                          <label>Account Status</label>
                          <select class="form-control" name="status">
                              <option value="" {if $search.status==''} selected {/if}>All</option>
                              <option value="pending" {if $search.status=='pending'}selected{/if}>Pending</option>
                              <option value="active" {if $search.status=='active'}selected{/if}>Active</option>
                              <option value="inactive" {if $search.status=='inactive'}selected{/if}>Inactive</option> 
                          </select> 
                  </div>
                  <div class="col-xs-6 col-sm-3 form-group">
                          <label>Referral Status</label>
                          <select class="form-control" name="r_status">
                              <option value="" {if $search.rstatus==''} selected {/if}>All</option>
                              <option value="normal" {if $search.rstatus=='normal'}selected{/if}>Normal</option>
                              <option value="h_referral" {if $search.rstatus=='h_referral'}selected{/if}>Hempbuyer Referral</option>
                              <option value="r_affiliate" {if $search.rstatus=='r_affiliate'}selected{/if}>Referral Affiliate</option> 
                          </select> 
                  </div>
                  <div class="col-xs-6 col-sm-2 form-group pull-right text-right">
                    {* <label style="visibility: hidden; display: block;">Height adjust</label>  *}
                          <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$phrases.search}</button> 
                  </div>
              </div>
          </form> 
    {if $error != ''}
    <div class="alert alert-danger"><strong>{$error}</strong></div>
    {/if}
    <div id="list_div">
    </div> 
</div>
</div>
{include file="/admincp/footer.tpl" nocache}
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>

<script language="javascript" type="text/javascript">

$(document).ready(function() {
    $('#start_date1').datetimepicker({
        timepicker:false,
        format:'Y-m-d'
    });
    $('#start_date2').datetimepicker({
        timepicker:true,
        format:'Y-m-d'
    });

    $("#country_abbr").val('United States');
    $("#country_abbr").trigger('change');
    getUsers();

    $(document).on('submit', '#user_search_form', function(e) {
        e.preventDefault();
        getUsers();
    });

    
    $(document).on('change', '.change_user_status', function() {
        $th = $(this);
        var changeTo = $(this).val();
        var userid = $(this).data("id");
        var prev_status = $(this).data("status");
        var self = this;
        
        swal({
            title: 'Are you sure? You want to move on '+ changeTo,
            text: "",
            type: 'info',
            confirmButtonClass: "btn-primary",
            cancelButtonClass: "btn-danger",
            confirmButtonText: "Yes",
            cancelButtonText: "No",
            showCancelButton: true,
            closeOnConfirm: false,
            showLoaderOnConfirm: true
        }, function(result) {
        //console.log(result);
            if (result) {
                ajaxStatus(userid, changeTo, '');
                $(self).attr("data-status", changeTo);
            } else {
                $(self).val(prev_status);
                // $(self).trigger("change");
            }
        })
    });
});
function getUsers() {
    /* var data = {

    } */
    var formArray = $("#user_search_form").serializeArray();
    var Obj = {};
    var productData = formArray ? formArray : [];
    if(productData.length) {
        for (var index = 0; index < productData.length; index++) {
            const element = productData[index];
            Obj[productData[index].name] = productData[index].value;
        }
    }
    console.log('Obj', Obj);

    $.ajax({
        type: 'POST',
        url: '/admincp/users/all',
        data: Obj,
        // dataType: 'json',
        success: function(data) {
            // console.log('data', data);
            $("#list_div").html(data);
            $("#pagination_html").html(pagination(paginationData));

        }

    });
}
function ajaxStatus(userid, changeTo, msg) {

$.ajax({
    type: 'POST',
    url: '/admincp/update/status',
    data: {
        id: userid,
        status: changeTo,
        rej_msg : msg
    },
    dataType: 'json',
    success: function(data) {
        if (data == 1) {
            if (changeTo == 'active') {
                swal(
                    'Activated',
                    'Selected user\'s account has been activated.',
                    'success'
                )
                // $('.status_' + userid + ' option:selected').text('Activated');
            }
            if (changeTo == 'pending') {
                swal(
                    'Pending',
                    'Selected user\'s account put on pending.',
                    'success'
                )
                // $('.status_' + userid + ' option:selected').text('Rejected');
            }
            if (changeTo == 'inactive') {
                swal(
                    'Inactivated access..!',
                    'Selected user\'s account has been Inactivated.',
                    'success'
                )
                // $('.status_' + userid + ' option:selected').text('Suspended');
            }

        }
    }

});
}
</script>

 