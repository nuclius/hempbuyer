{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-8" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active" style=" text-transform: capitalize;">
                {if $action == 'wire'}
                    Funds via Wire
                {/if}
                {if $action == 'check'}
                    Funds via Check
                {/if}
                {if $action == 'gateway'}
                    Funds via Payment Gateway
                {/if}
                {if $action == 'All'}
                    Funds Requests
                {/if}
                {if $action == 'refund'}
                    Reunds Requests
                {/if}
                </li>

            </ol>
        </div>
        <div class="col-lg-4" style="margin-top:2%;">
                {if $action == 'wire'}
                    You have {$wire_req} unverified payments
                {/if}
                {if $action == 'check'}
                    You have {$check_req} unverified payments
                {/if}
                {if $action == 'All'}
                    You have {$unverified_pay_count} unverified payments
                {/if}
                {if $action == 'refund'}
                    You have {$refund_req} unverified payments
                {/if}

        </div>
    </div>
    {if $action == 'all'}
    <div class="row">
      <div class="col-sm-12">
        <form enctype="multipart/form-data" class="admin_forms" method="get" enctype="multipart/form-data" action="{$config.url}/admincp/payments/all">
            <div class="row">
                <div class="col-lg-4">
                    <div class="form-group">
                        <label>{$phrases.from_date}</label>
                        <input class="form-control" value="{$search.from_date}" placeholder="Select From Date" name="from_date" id="from_date" class="date_picker">
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="form-group">
                        <label>{$phrases.to_date}</label>
                        <input class="form-control" value="{$search.to_date}" placeholder="Select To Date" name="to_date" id="to_date" class="date_picker">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="form-group">
                        <label>Country</label>
                        <select class="form-control" name="country" id="country_abbr">
                            <option value="{$search.country}">Select Country</option>
                        </select>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="form-group">
                        <label>State</label>
                        <select class="form-control" name="state" id="state_abbr">
                            <option value="{$search.state}">Select State</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="form-group">
                        <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$phrases.search}</button>
                    </div>
                </div>
            </div>
        </form>
        <div class="row">
            <div class="col-lg-4">
                <div class="form-group">
                    <br>
                    {if $limit > $fund_requests.length}
                        {(($page - 1) * $limit) +1} - {((($page - 1) * $limit)) + $fund_requests.length} of {$pagination} results showing
                    {/if}
                    {if $limit == $fund_requests.length}
                        {(($page - 1) * $limit) +1} - {((($page - 1) * $limit)) + $limit} of {$pagination} results showing
                    {/if}
                </div>
            </div>
        </div>
      </div>

    </div>
    {/if}
    {if $action == 'wire' || $action == 'check'}
    <div class="row">
      <div class="col-sm-12">
        <form enctype="multipart/form-data" class="admin_forms" method="get" enctype="multipart/form-data" action="{$config.url}/admincp/payments/{$action}">
            <div class="row">
                <div class="col-lg-4">
                    <div class="form-group">
                        <label>{$phrases.from_date}</label>
                        <input class="form-control" value="{$search.from_date}" placeholder="Select From Date" name="from_date" id="from_date" class="date_picker">
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="form-group">
                        <label>{$phrases.to_date}</label>
                        <input class="form-control" value="{$search.to_date}" placeholder="Select To Date" name="to_date" id="to_date" class="date_picker">
                    </div>
                </div>
                <div class="col-lg-4"> 
                    <div class="form-group">
                        <label>Status</label>
                        <select class="form-control req_status" name="req_status" id="req_status">
                            <option value="" {if $search.req_status==''}selected{/if}>Select Status</option>
                            <option value="unverified" {if $search.req_status=='unverified'}selected{/if}>unverified</option>
                            <option value="approve" {if $search.req_status=='approve'}selected{/if}>Approved</option>
                            <option value="reject" {if $search.req_status=='reject'}selected{/if}>rejected</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="form-group">
                        <button type="submit" class="btn btn-success centering"> <i class="fa fa-search"></i> {$phrases.search}</button>
                    </div>
                </div>
            </div>
            <div class="row">

                    <!-- <div class="col-lg-4">
                        <div class="form-group">
                            <label>Country</label>
                            <select class="form-control country_abbr" name="country" id="country_abbr">
                                <option value="">Select Country</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="form-group">
                            <label>State</label>
                            <select class="form-control state_abbr" name="state" id="state_abbr">
                                <option value="">Select State</option>
                            </select>
                        </div>
                    </div> -->
            </div>

        </form>
        <div class="row">
            <div class="col-lg-4">
                <div class="form-group">
                    <br>
                    {if $limit > $fund_requests.length}
                        {(($page - 1) * $limit) +1} - {((($page - 1) * $limit)) + $fund_requests.length} of {$pagination} results showing
                    {/if}
                    {if $limit == $fund_requests.length}
                        {(($page - 1) * $limit) +1} - {((($page - 1) * $limit)) + $limit} of {$pagination} results showing
                    {/if}
                </div>
            </div>
        </div>
      </div>

    </div>
    {/if}

    {if $action != 'all'}
        {include file="/admincp/gmoney_request_list.tpl" nocache}
    {/if}
    {if $action == 'all'}
        {include file="/admincp/gmoney_request_alllist.tpl" nocache}
    {/if}

</div>
<div class="container">
    <!-- Modal -->
    <div class="modal fade" id="viewMessage" role="dialog">
        <div class="modal-dialog modal-sm" style="width:50% !important;">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header p0">
                    <div class="panel panel-success border-0">
                        <div class="panel-heading green-bg">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h3>Message</h3>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-offset-1 col-md-10">
                            <p id="rej_msg" class="description mess123">
                            </p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default btn-d-b green-b m0" type="button" data-dismiss="modal">CLOSE</button>
                </div>
            </div>
        </div>
    </div>
</div>

{include file="/admincp/footer.tpl" nocache}

<!-- update users balance -->
<script language="javascript" type="text/javascript">



function updateBalance(userid) {

    swal({
            title: 'Are you sure?',
            text: "Add funds to user's account",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: 'green',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, add fund..!'
        }).then(function(result) {
           //console.log(result);
            if (result) {
                var bal = $('#inc_bal' + userid).val();
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
                            swal(
                                'Added!',
                                'Funds added to users account..!',
                                'success'
                            )
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

}
</script>
<!-- END update users balance -->
<script type="text/javascript">

        function viewMessage(rejtxt){
        $("#rej_msg").text(rejtxt);
        $("#viewMessage").modal();
    };
</script>
<script type="text/javascript">
        function viewContact(rejtxt){
        $("#body_msg").text(rejtxt);
        $("#wireContact").modal();
    };
</script>

<script language="javascript" type="text/javascript">
$(function() {
    Date.dayNames = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    Date.format = 'mm/dd/yyyy';


    var dt = '{$serverdate}';


    var logic1 = function( currentDateTime ){
        var  begD  = new Date(currentDateTime)
        var  endD = new Date($("#to_date").val());
        if(begD =='Invalid Date'){
            alert('Please Select Start Date');
            $("#to_date").val('');
        }else if (endD !='Invalid Date' && begD > endD) {
            alert('Start Date Must Be less Than End date');
            $("#from_date").val('');
        }
    };
    $("#from_date").datetimepicker({
        inline:false,
        step:01,
        onChangeMonth:logic1,
        onSelectDate:logic1,
        maxDate:dt,
        format:'m/d/Y',

    });
    var logic = function( currentDateTime ){
        var  begD  = new Date($("#from_date").val());
        var  endD = new Date(currentDateTime);
        if(begD =='Invalid Date'){
            alert('Please Select Start Date');
            $("#to_date").val('');
        }else if (begD > endD) {
            alert('End Date Must Be Greater Than Start date');
            $("#to_date").val('');
        }

    };
    $("#to_date").datetimepicker({
        step:01,
        onChangeMonth:logic,
        onSelectDate:logic,
        showHeader:2,
        maxDate:dt,
        format:'m/d/Y',
    });
});
</script>


<script type="text/javascript">
        function ajaxStatus(id, changeTo, msg){
        $.ajax({
            type: 'POST',
            url: '/admincp/payment/update/status',
            data: {
                id : id,
                status: changeTo,
                rej_msg: msg
            },
            dataType: 'json',
            success: function(data) {
               //console.log(data);
                if (data == 1){
                    if(changeTo == 'approve'){
                        $('.status_'+id + ' option:selected').text('Approved');
                       $('.status_'+id ).prop('disabled', true);
                       $('.status_'+id ).prop('data-toggle', 'tooltip');
                       $('.status_'+id ).prop('title', 'Payment approved. Cannot change again.');
                       $('.status_'+id ).prop('style','');
                       var prebal = parseFloat($('#bal_'+id).find('span').text())
                        $('#bal_'+id).find('span').text( prebal + parseFloat($('#amt_'+id).find('span').text()))
                   }

                    if(changeTo == 'reject')
                        $('.status_'+id + ' option:selected').text('Rejected');

                    if(changeTo == 'unverified')
                        $('.status_'+id + ' option:selected').text('Unverified');
                    swal('Funds added successfully...');
                }
            }
        });
    }

    function refajaxStatus(id, changeTo, msg){
        $.ajax({
            type: 'POST',
            url: '/admincp/payment/update/refstatus',
            data: {
                id : id,
                status: changeTo,
                rej_msg: msg
            },
            dataType: 'json',
            success: function(data) {
               //console.log(data);
                if (data == 1){
                    if(changeTo == 'approve'){
                        $('.status_'+id + ' option:selected').text('Approved');
                       $('.status_'+id ).prop('disabled', true);
                       $('.status_'+id ).prop('data-toggle', 'tooltip');
                       $('.status_'+id ).prop('title', 'Payment approved. Cannot change again.');
                       $('.status_'+id ).prop('style','');
                       var prebal = parseFloat($('#bal_'+id).find('span').text())
                        $('#bal_'+id).find('span').text( prebal - parseFloat($('#amt_'+id).find('span').text()))
                   }

                    if(changeTo == 'reject')
                        $('.status_'+id + ' option:selected').text('Rejected');

                    if(changeTo == 'unverified')
                        $('.status_'+id + ' option:selected').text('Unverified');
                    swal('User status Changed');
                }
            }
        });
    }

    $(document).ready(function(){
        $("#submitreject").click(function(){
            ajaxStatus($("#myModal").find("#reject-message").data('id'), $("#myModal").find("#reject-message").data('status'), $("#myModal").find("#reject-message").val());
            $('#myModal').modal('toggle');
        });
    });


    $(document).on('change','#status',function(){

        var changeTo = $(this).val();
        var id = $(this).data("id");
        if(changeTo  == 'reject'){
                $rej_field = $("#myModal").find("#reject-message");
                // $rej_field.data('id');
                $rej_field.attr('data-id' , id);
                $rej_field.attr('data-status' , changeTo);
                $("#myModal").modal();
        } else {
            ajaxStatus(id, changeTo, '');
        }

    });

    $(document).on('change','#refstatus',function(){

        var changeTo = $(this).val();
        var id = $(this).data("id");
        if(changeTo  == 'reject'){
                $rej_field = $("#myModal").find("#reject-message");
                // $rej_field.data('id');
                $rej_field.attr('data-id' , id);
                $rej_field.attr('data-status' , changeTo);
                $("#myModal").modal();
        } else {
            refajaxStatus(id, changeTo, '');
        }

    });

$(document).ready(function() {
    $('.country_abbr').val('{$search.country}').change();
    if($('.country_abbr').val() != ''){
        $('.state_abbr').val('{$search.state}').change();
    }

    $('#req_status').val('{$search.req_status}').change();

})

</script>
