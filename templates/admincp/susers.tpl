{include file="/admincp/header.tpl" nocache}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}jquery.datetimepicker.css" />
<div class="container-fluid">
    <style type="text/css">
    .jkm {
        padding-top: 10.7%;
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
                    Users <i class="fa fa-angle-double-right"></i> {$phrases.search_users}
                </li>
            </ol>
        </div>

    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-sm-12">
          <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/{$loged.adminUrl}/{if $loged.adminUrl=='admincp'}users{/if}{if $loged.adminUrl=='salesadmin'}salesusers{/if}/search">
              <div class="row">
                  <div class="col-lg-4">
                      <div class="form-group">
                          <label>{$phrases.from_date}</label>
                          <input class="form-control" value="{$search.from_date}" placeholder="Select From Date" name="from_date" id="start_date1" class="date_picker">
                      </div>
                  </div>
                  <div class="col-lg-4">
                      <div class="form-group">
                          <label>{$phrases.to_date}</label>
                          <input class="form-control" value="{$search.to_date}" placeholder="Select To Date" name="to_date" id="start_date2" class="date_picker">
                      </div>
                  </div>
                  <div class="col-lg-4">
                      <div class="form-group">
                          <label>Username</label>
                          <input class="form-control" placeholder="Username" value="{$search.username}" name="username">
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
                    {if $limit > $users.length}
                        {(($page - 1) * $limit) +1} - {((($page - 1) * $limit)) + $users.length} of {$pagination} results showing
                    {/if}
                    {if $limit == $users.length}
                        {(($page - 1) * $limit) +1} - {((($page - 1) * $limit)) + $limit} of {$pagination} results showing
                    {/if}
                </div>
            </div>

        </div>
    {if $error != ''}
    <div class="alert alert-danger"><strong>{$error}</strong></div>
    {/if}
    <div class="row">
        {include file="/admincp/user-list.tpl" nocache}
    </div>
    <div class="row">
        {if $users|count >0}
        <div class="col-lg-4">
            <div class="form-group">
                <button type="button" class="btn btn-default centering" data-toggle="tooltip" title="Select multiple users and then click to delete" onclick="deleteUsers()"> <i class="fa fa-trash"></i> Delete </button>
            </div>
        </div>
        {/if}
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

/* selecting the multiple user ids by id's */
var urr = [];

function selectUsers(sid) {
    if ($('#checkuser_' + sid).prop("checked") == true) {
        urr.push(sid);
    } else {
        urr.splice(urr.indexOf(sid), 1);
    }
};
/* end here */

/* to Delete the selected users*/
function deleteUsers() {
console.log(urr)
if (urr.length<1) {
  swal({
        text: "Please Select Users......",
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
             // window.location = "{$config.url}/admincp/users/expel/" + urr;
           //console.log("result ",result);

            $.ajax({
                type: 'POST',
                url: '/admincp/delete/users',
                data: {
                    ids: urr,
                },
                dataType: 'json',
                success: function(data) {
                 //console.log(data);
                    if (data.success) {

                            swal({
                                title: 'Deleted',
                                text: "Selected user has been deleted.",
                                type: 'success',
                            }, function (result) {
                                location.reload();
                            });
                    }

                }

            });
        }
    })

}
}

/* delete section end here*/

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
                window.location = "{$config.url}/admincp/users/expel/" + userid;
                swal({
                    title: 'Deleted',
                    text: "Selected user has been deleted.",
                    type: 'success',
                }, function(result) {
                    window.location = "{$config.url}/admincp/users/search";
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


    /* $("#from_date").datePicker({

         clickInput: false,
         createButton: false,
         showYearNavigation: false,
         showHeader: 2
     }).bind(
         'focus click keydown',
         function() {
             $("#from_date").dpRerenderCalendar();
             $("#from_date").dpSetStartDate('01/02/2012');
             $("#from_date").dpDisplay();
         }
     );

     $("#to_date").datePicker({
         clickInput: false,
         createButton: false,
         showYearNavigation: false,
         showHeader: 2
     }).bind(
         'focus click keydown',
         function() {
             $("#to_date").dpRerenderCalendar();
             $("#to_date").dpSetStartDate($("#from_date").val());
             $("#to_date").dpDisplay();
         }
     );
 */
});
</script>
<script language="javascript" type="text/javascript">
function updateBalance(userid) {
var bal = $('#inc_bal' + userid).val();
console.log('bal here' + bal);
var text_msg = '';
var btn_msg = '';

        if(bal>0){
            text_msg= "Add funds to user's account";
            btn_msg= "Yes, add fund..!";
        }else if(bal<0){
            text_msg= "Deduct funds from user's account";
            btn_msg= "Yes, deduct fund..!"
        }
        if(bal != '' && (bal > 0 || bal < 0)){
            swal({
                title: 'Are you sure?',
                text: text_msg,
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: 'green',
                cancelButtonColor: '#d33',
                confirmButtonText: btn_msg
            }, function(result) {
               //console.log(result);
                if (result) {

                    $.ajax({
                        type: 'POST',
                        url: '/admincp/update/balance',
                        data: {
                            id: userid,
                            add_bal: $('#inc_bal' + userid).val()
                        },
                        dataType: 'json',
                        success: function(data) {
                            if (data == 1) {
                                $('#bal_' + userid).text(parseFloat($('#bal_' + userid).text()) + parseFloat($('#inc_bal' + userid).val()))
                                $('#inc_bal' + userid).val('');
                                if (bal>0) {
                                   swal(
                                    'Funds Added...!',
                                    'Funds added to users account..!',
                                    'success'
                                )
                               }else{
                                    swal(
                                    'Funds Deducted...!',
                                    'Funds deducted from users account..!',
                                    'success'
                                )
                               }

                                // alert(1);
                            } else {
                                // alert(0);
                               //console.log('err occured...!');
                                swal(
                                    'Error occured...!',
                                    'Please try again...!',
                                    'failure'
                                )
                            }
                        }

                    });

                }
            })
        } else {
          swal('Please enter balance first...!');
        }
}
$(document).ready(function() {
    $('#country_abbr').val('{$search.country}').change();
    if($('#country_abbr').val() != ''){
        $('#state_abbr').val('{$search.state}').change();
    }

})
</script>
