<!-- ===================== end change by divyesh (added) ===================== -->
{include file="/admincp/header.tpl" nocache}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}jquery.datetimepicker.css" />
<div class="container-fluid">
    <style type="text/css">
    .jkm {
        padding-top: 10.7%;
    }
    .to_uppercase {
        text-transform: uppercase;
    }

    @media screen and (max-width:1200px) {
        .jkm {
            padding-top: 0%;
        }
    }
    </style>
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active">
                    Reports <i class="fa fa-angle-double-right"></i> Client Report
                </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-sm-12">
          <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/{$loged.adminUrl}/report/clients/search">
              <div class="row">
                  <div class="col-lg-4">
                      <div class="form-group">
                          <label>{$phrases.from_date}</label>
                          <input class="form-control" value="{$search.from_date}" placeholder="Select From Date" name="from_date" id="start_date1" class="date_picker" autocomplete="off">
                      </div>
                  </div>
                  <div class="col-lg-4">
                      <div class="form-group">
                          <label>{$phrases.to_date}</label>
                          <input class="form-control" value="{$search.to_date}" placeholder="Select To Date" name="to_date" id="start_date2" class="date_picker" autocomplete="off">
                      </div>
                  </div>
                  <div class="col-lg-4">
                    <div class="form-group">
                        <label>Business Name</label>
                        <input class="form-control" name="business_name" placeholder="Business Name" value="{$search.business_name}">
                    </div>
                  </div>
              </div>
              <div class="row">
                  <div class="col-lg-4">
                      <div class="form-group">
                          <label>{$phrases.email}</label>
                          <input class="form-control" name="email" placeholder="Email Address" value="{$search.email}">
                      </div>
                  </div>
                    
                  <div class="col-lg-4">
                      <div class="form-group">
                          <label>Country</label>
                          <select class="form-control" name="country" id="country_abbr">
                              <option value="">Select Country</option>
                          </select>
                      </div>
                  </div>
                  <div class="col-lg-4">
                    <div class="form-group">
                        <label>State</label>
                        <select class="form-control" name="state" id="state_abbr">
                            <option value="">Select State</option>
                        </select>
                    </div>
                  </div>
              </div>
              <div class="row">
                
                  <div class="col-lg-4">
                      <div class="form-group">
                          <label>{$phrases.status}</label>
                          <select class="form-control" name="status">
                              <option value="" {if $search.status==''} selected {/if}>All</option>
                              <option value="active" {if $search.status=='active'} selected {/if}>Active</option>
                              <option value="moderate" {if $search.status=='moderate'} selected {/if}>Rejected</option>
                              <option value="deactivate" {if $search.status=='deactivate'} selected {/if}>Suspended</option>
                              <option value="unverified" {if $search.status=='unverified'} selected {/if}>Pending</option>
                          </select>
                      </div>
                  </div>
                  <div class="col-lg-4">
                    <label style="visibility: hidden;">Height adjust</label>
                      <div class="form-group">
                          <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$phrases.search}</button>
                          <a class="btn btn-success" href="{$config.url}/{$loged.adminUrl}/report/clients/search"> <i class="fa fa-times"></i> Clear</a>
                      </div>
                  </div>
              </div>
          </form>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-4">
            <div class="form-group">
                <br>
                {if $limit > $members.length}
                    {(($page - 1) * $limit) +1} - {((($page - 1) * $limit)) + $members.length} of {$pagination} results showing
                {/if}
                {if $limit == $members.length}
                    {(($page - 1) * $limit) +1} - {((($page - 1) * $limit)) + $limit} of {$pagination} results showing
                {/if}
            </div>
        </div>
    </div>
    {if $error != ''}
    <div class="alert alert-danger"><strong>{$error}</strong></div>
    {/if}
    <div class="row">
        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th width="30">No.</th>
                        <th>Business Name</th>
                        <th>Contact Name</th>
                        <th>Contact Phone Number</th>
                        <th>Contact Email</th>
                        <th width="100">Sales Consultant Code</th>
                        <th width="100">Zone</th>
                        <th width="100">Commission percentage</th>
                        <th>Status</th>
                        <th width="100">Action</th>
                    </tr>
                </thead>
                <tbody>
                 {$usercount = 0}
                 {foreach $members as $key => $val}
                 {$usercount = 1}
                    <tr>
                        <td>{($members.length * ($page-1)) + ($key + 1)}</td>
                        <td>{$val.business_name}</td>
                        <td>{$val.first_name} {$val.last_name}</td>
                        <td>{$val.phone}</td>
                        <td>
                          <a class="w100 contact_modal" class="btn-link" data-toggle="modal" data-id="{$val.id}"
                          data-email="{$val.email}" data-target="#wireContact">{$val.email}</a>
                        </td>
                        <td><input type="text" name="sc_code{$val.ss_id}" id="sc_code{$val.ss_id}" value="{$val.sc_code}" class="to_uppercase" /></td>
                        <td><input type="text" name="zone{$val.ss_id}" id="zone{$val.ss_id}" value="{$val.zone}" /></td>
                        <td><input type="text" name="consultant_fee{$val.ss_id}" id="consultant_fee{$val.ss_id}" data-value="{$val.consultant_fee}" value="{$val.consultant_fee}" /></td>
                        
                        <td>
                          <div class="form-group">
                             <select  data-id="{$val.id}" data-status="{$val.status}" class="form-control status_{$val.id}" id="status" name="status">
                                 {if $val.status=='unverified'}
                                  <option value="unverified" {if $val.status=='unverified'} selected {/if}>Pending</option>
                                  <option value="active"><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Activate</a></option>
                                  <option value="moderate"><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Reject</a></option>
                                 {/if}
                                 {if $val.status=='active'}
                                  <option value="active" selected>Activated</option>
                                  <option value="deactivate"><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Suspend</a></option>
                                  <option value="delete"><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Purge</a></option>
                                 {/if}
                                 {if $val.status=='deactivate'}
                                  <option value="deactivate" selected>Suspended</option>
                                  <option value="active"><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Activate</a></option>
                                  <option value="delete"><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Purge</a></option>
                                 {/if}
                                 {if $val.status=='moderate'}
                                  <option value="moderate" selected>Rejected</option>
                                  <option value="active"><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Activate</a></option>
                                  <option value="delete"><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Purge</a></option>
                                 {/if}
                              </select>
                          </div>
                        </td>
                        <!-- <td>
                            <div class="form-group baln-inpt">
                                <b><input type="text" name="inc_bal{$val.id}" id="inc_bal{$val.id}" /></b>
                            </div>
                        </td> -->
                        <td>
                            <a  title='View' href="{$config.url}/{$loged.adminUrl}/users/view/{$val.id}">View</a>
                            
                            <br>
                              <button class="btn btn-success" id="inc_bal_btn" data-toggle="tooltip" title="update sales setting." onclick="updateCodeFee({$val.ss_id}, '{$val.email}')">Submit</button>
                        </td>
        
                    </tr>
                 {/foreach}
                 {if $usercount == 0}
                     <tr>
                         <td colspan="12">
                         No {$userstatus} Users Found !
                         </td>
                     </tr>
                 {/if}
                </tbody>
            </table>
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
        
    </div>
    <div class="row">
        <div class="col-sm-8">
          {$pagination_html}
        </div>
    </div>
</div>
<!-- /.row -->
</div>
{include file="/admincp/footer.tpl" nocache}
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>

<script>


function sendResetPwdLink(sid) {
    $.ajax({
        type: 'GET',
        url: '{$config.url}/admincp/reset_password/' + sid,
        success: function(data) {
           //console.log(data);
            if (data.status) {
                swal("Success","Reset password link sent successfully",'success');
            } else {
                swal("Error Occured..!","Please try again later..!",'failure');
            }
        }

    });
};

function ajaxStatus(userid, changeTo, msg) {

    $.ajax({
        type: 'POST',
        url: '/{$loged.adminUrl}/update/status',
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
                    $('.status_' + userid + ' option:selected').text('Activated');
                }
                if (changeTo == 'moderate') {
                    swal(
                        'Rejected access..!',
                        'Selected user\'s account registration rejected.',
                        'success'
                    )
                    $('.status_' + userid + ' option:selected').text('Rejected');
                }
                if (changeTo == 'deactivate') {
                    swal(
                        'Suspended access..!',
                        'Selected user\'s account registration Suspended.',
                        'success'
                    )

                    $('.status_' + userid + ' option:selected').text('Suspended');
                }

            }
        }

    });
}

$(document).ready(function() {
    $("#submitreject").click(function() {
        ajaxStatus($("#myModal").find("#reject-message").data('id'), $("#myModal").find("#reject-message").data('status'), $("#myModal").find("#reject-message").val());
        $('#myModal').modal('toggle');
    });
});


$(document).on('change', '#status', function() {
    $th = $(this);
    var changeTo = $(this).val();
    var userid = $(this).data("id");
    var prev_status = $(this).data("status");
    if (changeTo == 'deactivate') {
        $rej_field = $("#myModal").find("#reject-message");
        // $rej_field.data('id');
        $rej_field.attr('data-id', userid);
        $rej_field.attr('data-status', changeTo);
        $("#myModal").modal();
    } else if (changeTo == 'delete') {
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
                window.location = "{$config.url}/{$loged.adminUrl}/users/expel/" + userid;
                swal({
                    title: 'Deleted',
                    text: "Selected user has been deleted.",
                    type: 'success',
                }, function(result) {
                    window.location = "{$config.url}/{$loged.adminUrl}/users/search";
                });
            }
        })
    } else {
        swal({
            title: 'Are you sure?',
            text: "",
            type: 'info',
            showCancelButton: true,
            confirmButtonColor: 'green',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, Activate!'
        }, function(result) {
           //console.log(result);
            if (result) {
                ajaxStatus(userid, changeTo, '');
            }
        })

    }

});
</script>
<script language="javascript" type="text/javascript">
$(function() {
    Date.dayNames = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    Date.format = 'mm/dd/yyyy';
    var dt = '{$serverdate}';
    var logic1 = function( currentDateTime ){
        var  begD  = new Date(currentDateTime)
        var  endD = new Date($("#start_date2").val());
        if(begD =='Invalid Date'){
            alert('Please Select Start Date');
            $("#start_date2").val('');
        }else if (endD !='Invalid Date' && begD > endD) {
            alert('Start Date Must Be less Than End date');
            $("#start_date1").val('');
        }
    };
    $("#start_date1").datetimepicker({
        inline:false,
        step:01,
        onChangeMonth:logic1,
        onSelectDate:logic1,
        maxDate:dt,
        format:'m/d/Y h:m',

    });
    var logic = function( currentDateTime ){
        var  begD  = new Date($("#start_date1").val());
        var  endD = new Date(currentDateTime);
        if(begD =='Invalid Date'){
            alert('Please Select Start Date');
            $("#start_date2").val('');
        }else if (begD > endD) {
            alert('End Date Must Be Greater Than Start date');
            $("#start_date2").val('');
        }

    };
    $("#start_date2").datetimepicker({
        step:01,
        onChangeMonth:logic,
        onSelectDate:logic,
        showHeader:2,
        maxDate:dt,
        format:'m/d/Y h:m',
    });
});
</script>
<script language="javascript" type="text/javascript">
function updateCodeFee(ss_id, email) {
    var sc_code = $('#sc_code' + ss_id).val();
    if(sc_code.length != 5) {
        swal('Sales Consultant Code must be 5 characters').then(function(result){
            $('#sc_code' + ss_id).focus();
        });
        return true;
    }
    sc_code = sc_code.toUpperCase();
    var consultant_fee = $('#consultant_fee' + ss_id).val();
    if(isNaN(consultant_fee)) {
        swal('Sales Consultant Fee must be numeric').then(function(result){
            $('#consultant_fee' + ss_id).focus();
        });
        return true;
    }
    

    var text_msg = '';
    var btn_msg = '';

    text_msg= "Update Sales Setting";
    btn_msg= "Yes, change..!";
    swal({
        title: 'Are you sure?',
        text: text_msg,
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: 'green',
        cancelButtonColor: '#d33',
        confirmButtonText: btn_msg
    }, function(result) {
        if (result) {
            $.ajax({
                type: 'POST',
                url: '/{$loged.adminUrl}/update/consultant_code_fee',
                data: {
                    ss_id: parseInt(ss_id),
                    email: email,
                    sc_code: sc_code,
                    consultant_fee: $('#consultant_fee' + ss_id).val(),
                    zone: $('#zone' + ss_id).val()
                },
                dataType: 'json',
                success: function(data) {
                    if(data.status == true) {
                        swal(
                            'Sales Setting Updated...!',
                            'Sales Setting Updated to users account..!',
                            'success'
                        )
                    } else {
                        swal(
                            'Error occured...!',
                            data.message,
                            'failure'
                        )
                    }
                }

            });
        }
    })
}
$(document).ready(function() {
    $('#country_abbr').val('{$search.country}').change();
    if($('#country_abbr').val() != ''){
        $('#state_abbr').val('{$search.state}').change();
    }

})
</script>
<!-- ===================== end change by divyesh (added) ===================== -->