{include file="/admincp/header.tpl" nocache}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}jquery.datetimepicker.css" />
<style>
    .fa-pause-circle, .fa-play-circle, .fa-times-circle {
        font-size: 25px;
        color: #5e9836;
    }
</style>
<div class="container-fluid">
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active">
                    Advertisements
                </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <form id="ads_form" enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data">
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
                          <label>Ad Name</label>
                          <input class="form-control" value="{$search.ad_name}" placeholder="Enter Ad name" name="ad_name" id="ad_name" class="" autocomplete="off">
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-3">
                      <div class="form-group">
                          <label>{$phrases.status}</label>
                          <select class="form-control" name="status">
                              <option value="" {if $search.status==''} selected {/if}>All</option>
                              <option value="unapproved" {if $search.status=='unapproved'}selected{/if}>Unapproved</option> 
                              <option value="active" {if $search.status=='active'}selected{/if}>Active</option>
                              <option value="pause" {if $search.status=='pause'}selected{/if}>Pause</option> 
                              <option value="reject" {if $search.status=='reject'}selected{/if}>Rejected</option> 
                          </select>
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
    
    getAds();
    $(document).on('submit', '#ads_form', function(e) {
        e.preventDefault();
        getAds();
    });

});

function getAds() {
    /* var data = {

    } */
    var formArray = $("#ads_form").serializeArray();
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
        url: '/admincp/ads/all',
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
    var formArray = $("#ads_form").serializeArray();
    var Obj = {
        id: id,
        status: status
    };
    $.ajax({
        type: 'POST',
        url: '/update_ad_status',
        data: Obj,
        // dataType: 'json',
        success: function(data) {
            if(data.success) {
                if(status == 'active') {
                    $("#add_play_"+id).hide();
                    $("#add_pause_"+id).show();
                    getAds();
                } else if(status == 'pause') {
                    $("#add_pause_"+id).hide();
                    $("#add_play_"+id).show();
                } else {
                    getAds();
                }
                swal('Status updated successfully');
            }
        }
    });
}

</script>
