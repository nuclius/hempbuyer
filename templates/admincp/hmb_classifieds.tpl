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
                    Classifieds
                </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <form id="classifieds_form" enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data">
            <input type="hidden" name="page" id="page" value="1">
            <input type="hidden" name="action" id="action" value="{$action}">
            <input type="hidden" name="limit" id="limit" value="10">
              <div class="row">
                  <div class="col-xs-6 col-sm-3">
                      <div class="form-group">
                          <label>Created By</label>
                          <input class="form-control" value="{$search.created_by}" placeholder="Enter created by user" name="created_by" id="created_by" class="" autocomplete="off">
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-3">
                      <div class="form-group">
                          <label>Classified Name</label>
                          <input class="form-control" value="{$search.classified_name}" placeholder="Enter Ad name" name="classified_name" id="classified_name" class="" autocomplete="off">
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-3">
                      <div class="form-group m-0">
                          <label>State</label>
                          <select class="form-control m-0" name="state" id="state">
                                <option value="">All</option>
                                {foreach $states as $key => $val}
                                    <option value="{$val.abbrev}">{$val.name}</option>
                                {/foreach}
                          </select>
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-3">
                      <div class="form-group">
                          <label>City</label>
                          <input class="form-control" value="{$search.city}" placeholder="Enter city" name="city" id="city" class="" autocomplete="off">
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-3">
                      <div class="form-group">
                          <label>{$phrases.status}</label>
                          <select class="form-control" name="status">
                              <option value="" {if $search.status==''} selected {/if}>All</option>
                              <option value="unapproved" {if $search.status=='unapproved'}selected{/if}>Unapproved</option> 
                              <option value="active" {if $search.status=='active'}selected{/if}>Active</option>
                              <option value="pause" {if $search.status=='pause'}selected{/if}>InActive</option>
                              <option value="reject" {if $search.status=='reject'}selected{/if}>Rejected</option> 
                          </select>
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-4">
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
    
    getClassifieds();
    $(document).on('submit', '#classifieds_form', function(e) {
        e.preventDefault();
        getClassifieds();
    });

});

function getClassifieds() {
    /* var data = {

    } */
    var formArray = $("#classifieds_form").serializeArray();
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
        url: '/admincp/classifieds/all',
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
                getClassifieds();
                swal('Status updated successfully');
            }
        }
    });
}
</script>
