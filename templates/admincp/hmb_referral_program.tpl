{include file="/admincp/header.tpl" nocache}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}jquery.datetimepicker.css" />
<style>
    .fa-pause-circle, .fa-play-circle, .fa-times-circle {
        font-size: 25px;
    }
</style>
<div class="container-fluid">
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active">
                    Referral Affiliate
                </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <form id="referral_program_form" enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data">
            <input type="hidden" name="page" id="page" value="1">
            <input type="hidden" name="action" id="action" value="{$action}">
            <input type="hidden" name="limit" id="limit" value="10">
              <div class="row">
                  <div class="col-xs-6 col-sm-3">
                      <div class="form-group">
                          <label>Full Name</label>
                          <input class="form-control" value="{$search.rf_name}" placeholder="Enter name" name="rf_name" id="rf_name" class="" autocomplete="off">
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-3">
                      <div class="form-group">
                          <label>Company</label>
                          <input class="form-control" value="" placeholder="Enter company name" name="rf_company" id="rf_company" class="" autocomplete="off">
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-3">
                      <div class="form-group">
                          <label>Email</label>
                          <input class="form-control" value="" placeholder="Enter email" name="rf_email" id="rf_email" class="" autocomplete="off">
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-3">
                    <label style="visibility: hidden;">Height adjust</label>
                      <div class="form-group">
                          <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$phrases.search}</button>
                      </div>
                  </div>
              </div>
          </form>
     
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
    get_referral_program();
    $(document).on('submit', '#referral_program_form', function(e) {
        e.preventDefault();
        get_referral_program();
    });

});

function get_referral_program() {
    /* var data = {

    } */
    var formArray = $("#referral_program_form").serializeArray();
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
        url: '/admincp/referral_program',
        data: Obj,
        // dataType: 'json',
        success: function(data) {
            // console.log('data', data);
            $("#list_div").html(data);
            $("#pagination_html").html(pagination(paginationData));

        }

    });
}

function changeStatus(id, status) {
    var Obj = {
        id: id,
        status: status
    };
    $.ajax({
        type: 'POST',
        url: '/update_classified_status',
        data: Obj,
        // dataType: 'json',
        success: function(data) {
            if(data.success) {
                get_referral_program();
                swal('Status updated successfully');
            }
        }
    });
}
</script>
