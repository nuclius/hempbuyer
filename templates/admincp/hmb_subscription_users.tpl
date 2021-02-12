{include file="/admincp/header.tpl" nocache}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}jquery.datetimepicker.css" />
<div class="container-fluid">
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active">
                    Subscription Users
                </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-sm-12">
          <form id="user_search_form" enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/{$loged.adminUrl}/{if $loged.adminUrl=='admincp'}users{/if}{if $loged.adminUrl=='salesadmin'}salesusers{/if}/search">
            <input type="hidden" name="page" id="page" value="1">
            <input type="hidden" name="action" id="action" value="{$action}">
            <input type="hidden" name="limit" id="limit" value="10">
              <div class="row">
                  <div class="col-xs-6 col-sm-4 form-group">
                          <label>{$phrases.from_date}</label>
                          <input class="form-control" value="{$search.from_date}" placeholder="Select From Date" name="from_date" id="start_date1" class="date_picker" autocomplete="off"> 
                  </div>
                  <div class="col-xs-6 col-sm-4 form-group"> 
                    <label>{$phrases.to_date}</label>
                    <input class="form-control" value="{$search.to_date}" placeholder="Select To Date" name="to_date" id="start_date2" class="date_picker" autocomplete="off"> 
                  </div>
                  <div class="col-xs-6 col-sm-4 form-group">
                        <label>{$phrases.email}</label>
                        <input class="form-control" name="email" placeholder="Email Address" value="{$search.email}"> 
                  </div> 
                  <div class="col-xs-6 col-sm-4 form-group"> 
                          <label>Existing User</label>
                          <select class="form-control" name="existing_user">
                              <option value="" {if $search.status==''} selected {/if}>All</option>
                              <option value="1" {if $search.status=='1'}selected{/if}>Yes</option>
                              <option value="0" {if $search.status=='0'}selected{/if}>No</option>
                          </select> 
                  </div>
                  <div class="col-xs-6 col-sm-4 form-group">
                    <label style="visibility: hidden;">Height adjust</label>
                      <div>
                          <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$phrases.search}</button>
                      </div>
                  </div>
              </div>
          </form>
        </div>
    </div>
    {if $error != ''}
    <div class="alert alert-danger"><strong>{$error}</strong></div>
    {/if}
    <div id="list_div"></div>
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

    getUsers();
    $(document).on('submit', '#user_search_form', function(e) {
        e.preventDefault();
        getUsers();
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
        url: '/admincp/subscription_users/all',
        data: Obj,
        // dataType: 'json',
        success: function(data) {
            // console.log('data', data);
            $("#list_div").html(data);
            $("#pagination_html").html(pagination(paginationData));

        }

    });
}
</script>
