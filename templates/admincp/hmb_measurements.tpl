{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active">
                    Measurements <i class="fa fa-angle-double-right"></i> {$phrases.search_measurements}
                </li>
            </ol>
        </div>

    </div>
    <!-- /.row -->
    <div class="row">
      <form id="add_measurement_form" data-parsley-validate>
        <div class="col-md-3">
          <div class="form-group">
            <label>Measurement Name</label>
            <input class="form-control" placeholder="Measurement Name" name="measurement_name" id="measurement_name" required>
          </div>
        </div>
        <div class="col-md-2">
          <div class="form-group">
            <label>{$phrases.status}</label>
            <select class="form-control" name="measurement_status" id="measurement_status" required>
              <option value="Active">Active</option>
              <option value="Inactive">Inactive</option>
            </select>
          </div>
        </div>
        <div class="col-md-1">
          <label style="visibility: hidden;">Height adjust</label>
          <div class="form-group">
            <button type="button" class="btn btn-success addMeasurement"> <i class="fa fa-plus-circle"></i> Add</button>
          </div>
        </div>
      </form>
    </div>
    <div class="row">
      <div class="col-md-12">
        <span id="merror"></span>
      </div>
    </div>
      <hr>
      <div class="row">
        <div class="col-sm-12">
          <form id="measurement_search_form" enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/{$loged.adminUrl}/{if $loged.adminUrl=='admincp'}users{/if}{if $loged.adminUrl=='salesadmin'}salesusers{/if}/search">
            <input type="hidden" name="page" id="page" value="1">
            <input type="hidden" name="action" id="action" value="{$action}">
            <input type="hidden" name="limit" id="limit" value="10">
              <div class="row">
                  <div class="col-xs-6 col-sm-4 col-md-3">
                      <div class="form-group">
                          <label>Measurement Name</label>
                          <input class="form-control" placeholder="Measurement Name" value="{$search.measurementname}" name="measurementname">
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-4 col-md-3">
                      <div class="form-group">
                          <label>{$phrases.status}</label>
                          <select class="form-control" name="status">
                              <option value="" {if $search.status==''} selected {/if}>All</option>
                              <option value="Active" {if $search.status=='Active'}selected{/if}>Active</option>
                              <option value="Inactive" {if $search.status=='Inactive'}selected{/if}>Inactive</option>
                          </select>
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-4 col-md-3">
                    <label style="visibility: hidden;">Height adjust</label>
                      <div class="form-group">
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
{include file="/admincp/footer.tpl" nocache}
<script language="javascript" type="text/javascript">
  $(document).ready(function() {
    getMeasurements();    
  });

  $(document).on('submit', '#measurement_search_form', function(e) {
    e.preventDefault();
    getMeasurements();
  });

  $(document).on('click', '.addMeasurement', function(e) {
    e.preventDefault();
    if($('#add_measurement_form').parsley().validate()) {
      $.ajax({
        type: 'POST',
        url: '/admincp/create/measurement',
        data: {
          measurement_name : $('#measurement_name').val().trim(),
          measurement_status : $('#measurement_status').val()
        },
        dataType: 'json',
        success: function(data) {
          if (data.status == 'success') {
            $('#merror').html(data.message).css('color', 'green').show();
            setTimeout(function() {
              window.location.reload();
            }, 1000);
          } else
            $('#merror').html(data.message).css('color', 'red').show();
        }
      });
    }
  });

  $(document).on('change', '.change_measurement_status', function() {
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
      if (result) {
        ajaxStatus(userid, changeTo, '');
        $(self).attr("data-status", changeTo);
      } else {
        $(self).val(prev_status);
      }
    });
  });
  function getMeasurements() {
    var formArray = $("#measurement_search_form").serializeArray();
    var Obj = {};
    var productData = formArray ? formArray : [];
    if(productData.length) {
      for (var index = 0; index < productData.length; index++) {
        const element = productData[index];
        Obj[productData[index].name] = productData[index].value;
      }
    }
    $.ajax({
      type: 'POST',
      url: '/admincp/measurements/all',
      data: Obj,
      success: function(data) {
        $("#list_div").html(data);
        $("#pagination_html").html(pagination(paginationData));
      }
    });
  }
  function ajaxStatus(userid, changeTo, msg) {
    $.ajax({
      type: 'POST',
      url: '/admincp/update/measurement/status',
      data: {
        id: userid,
        status: changeTo,
        rej_msg : msg
      },
      dataType: 'json',
      success: function(data) {
        if (data == 1) {
          if (changeTo == 'Active') {
            swal(
              'Activated',
              'Selected measurement has been activated.',
              'success'
            )
          }
          if (changeTo == 'Inactive') {
            swal(
              'Inactivated access..!',
              'Selected measurement has been Inactivated.',
              'success'
            )
          }
        }
      }
    });
  }
</script>