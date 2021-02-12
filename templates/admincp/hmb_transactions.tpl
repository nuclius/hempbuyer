{include file="/admincp/header.tpl" nocache}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}jquery.datetimepicker.css" />
<style>
    .fa-pause-circle, .fa-play-circle, .fa-times-circle {
        font-size: 25px;
    }
    .mt-1 {
        margin-top: 1em;
    }
    th {
        white-space: nowrap;
    }
</style>
<div class="container-fluid">
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active">
                    Transactions
                </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <form id="search_form" enctype="multipart/form-data" class="admin_form" data-parsley-validate method="post" enctype="multipart/form-data" action="/admincp/transactions">
            <input type="hidden" name="page" id="page" value="1">
            <input type="hidden" name="action" id="action" value="{$action}">
            <input type="hidden" name="limit" id="limit" value="7">
            <input type="hidden" name="is_report" id="is_report" value="0">
              <div class="row">
                  <div class="col-xs-6 col-sm-3">
                      <div class="form-group">
                          <label>Product Title</label>
                          <input class="form-control" value="" placeholder="Enter Product Title" name="tr_title" id="tr_title" class="" autocomplete="off">
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-3">
                      <div class="form-group">
                          <label>User</label>
                          <input class="form-control" value="" placeholder="Enter User" name="tr_email" id="tr_email" class="" autocomplete="off">
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-3">
                      <div class="form-group">
                          <label>Transaction Id</label>
                          <input class="form-control" value="" placeholder="Enter Transaction Id" name="tr_transaction_id" id="tr_transaction_id" class="" autocomplete="off">
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-3">
                      <div class="form-group">
                          <label>From Date</label>
                          <input class="form-control" value="" placeholder="Enter From Date" name="tr_from_date" id="tr_from_date" class="" autocomplete="off">
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-3">
                      <div class="form-group">
                          <label>To Date</label>
                          <input class="form-control" value="" placeholder="Enter To Date" name="tr_to_date" id="tr_to_date" class="" autocomplete="off">
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-3">
                      <div class="form-group">
                          <label>Gateway</label>
                          <select class="form-control" value="" placeholder="Enter Gateway" name="tr_gateway" id="tr_gateway" class="" autocomplete="off">
                            <option value="">All</option>
                            <option value="escrow">Escrow</option>
                            <option value="card">Card</option>
                          </select>
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-3">
                        <div class="form-group">
                            <label>Escrow Choice</label>
                            <select class="form-control" value="" name="tr_escrow_choice" id="tr_escrow_choice" class="" autocomplete="off">
                                <option value="">All</option>
                                <option value="Ultimate Escrow">Ultimate Escrow</option>
                                <option value="EsGrow Services">EsGrow Services</option>
                                <option value="attorney">Your Attorney</option>
                                <option value="escrow_your_choice">Escrow - Your Choice</option>
                            </select>
                        </div>
                  </div>
                  <div class="col-xs-6 col-sm-3">
                      <div class="form-group">
                          <label>Status</label>
                          <select class="form-control" value="" placeholder="Enter Gateway" name="tr_status" id="tr_status" class="" autocomplete="off">
                            <option value="">All</option>
                            <option value="waiting_for_shipping_address">Waiting For Shipping Address</option>
                            <option value="waiting_for_shipping_amount">Waiting For Shipping Amount</option>
                            <option value="waiting_for_escrow_details">Waiting For Escrow Details</option>
                            <option value="waiting_for_escrow_payment">Waiting for Escrow Transaction Id</option>
                            <option value="waiting_for_seller_confirmation">Waiting for Seller Confirmation</option>
                            <option value="not_paid">Not Paid</option>
                            <option value="paid">Transaction Completed</option>
                          </select>
                      </div>
                  </div>
                
                  <div class="col-xs-6 col-sm-3">
                    <label style="visibility: hidden;">Height adjust</label>
                      <div class="form-group">
                          <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$phrases.search}</button>
                      </div>
                  </div>
                  <div class="col-xs-6 col-sm-3 text-right">
                    <label style="visibility: hidden;">Height adjust</label>
                    <div class="form-group">
                        <button onclick="generate_report()" class="btn btn-success"> <i class="fa fa-download"></i> Download Report</button>
                    </div>
                  </div>
              </div>
          </form>
          <div class="row col-sm-12">
            <b>Net Revenue: </b> $<span id="net_revenue"></span>
          </div>
          <br>
          <br>
     
    {if $error != ''}
    <div class="alert alert-danger"><strong>{$error}</strong></div>
    {/if}
    <div id="list_div" class="pull-left" style="overflow: auto; width: 100%;"></div> 
    <div class="row">
        <div class="col-xs-6 col-sm-3">
            <div class="form-group">
                <button onclick="generate_report()" class="btn btn-success"> <i class="fa fa-download"></i> Download Report</button>
            </div>
        </div>
    </div>
</div>
</div>
{include file="/admincp/footer.tpl" nocache}
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>

<script language="javascript" type="text/javascript">

$(document).ready(function() {
    $('#tr_from_date').datetimepicker({
        timepicker:false,
        format:'Y-m-d'
    });
    $('#tr_to_date').datetimepicker({
        timepicker:false,
        format:'Y-m-d'
    });

    get_list();
    $(document).on('submit', '#search_form', function(e) {
        paginationData.currentPage = 1;
        $("#page").val(1);
        if(is_report == 1) {
            is_report = 0;
            setTimeout(function() {
                $("#is_report").val(0);
            }, 1000);
        } else {
            e.preventDefault();
            get_list();
        }
    });

    $(document).on('change', 'input[name="transaction_contract"]', function(){
        var transaction_id = $(this).attr('id').split('__')[1];
        var files = $(this)[0].files;
        console.log('files', files);
        var formData = new FormData();
        var fileSizeCount = 0;
        formData.append('transaction_contract', files[0]);
        formData.append('transaction_id', transaction_id);
        $("#productDocumentLoader").show();
        $.ajax({
            url : '/admincp/update_transaction_contract/',
            type : 'POST',
            xhr: function() {
                var myXhr = $.ajaxSettings.xhr();
                return myXhr;
            },
            data : formData,
            processData: false,
            contentType: false,
            success : function(response) {
                if(response.productDocument.length) {
                    swal({
                        title: "Transaction document updated success",
                        type: "success"
                    }, function () {
                        get_list();
                    });
                }
                //console.log('response', response.productDocument);
                // $("#loading_images").hide();
            },
            error: function(e)
            {
                //console.log(e);
            },
        }).done(function() {
            $("#productDocumentLoader").hide();
        });
    })
});
var is_report = 0;
function generate_report() {
    is_report = 1;
    $("#is_report").val(1);
    $('#search_form').trigger('submit');
}
function get_list() {
    var formArray = $("#search_form").serializeArray();
    var Obj = {};
    var productData = formArray ? formArray : [];
    if(productData.length) {
        for (var index = 0; index < productData.length; index++) {
            const element = productData[index];
            Obj[productData[index].name] = productData[index].value;
        }
    }
    Obj.is_report = is_report;
    console.log('Obj', Obj);

    $.ajax({
        type: 'POST',
        url: '/admincp/transactions',
        data: Obj,
        // dataType: 'json',
        success: function(data) {
            // console.log('data', data);
            if(!is_report) {
                $("#list_div").html(data);
                paginationData.recordPerPage = $("#limit").val();
                $("#pagination_html").html(pagination(paginationData));
                setTimeout(function() {
                    $("#net_revenue").html(formatMoney($("#net_revenue_data").val()));
                }, 100);
            }
            is_report = 0;
        }

    });
}
function release_payment(id, amount) {
    console.log('id', id);
    swal({
        title: "Are you sure?",
        text: "You want to release the amount of $" + formatMoney(amount),
        type: "info",
        confirmButtonClass: "btn-primary",
        cancelButtonClass: "btn-danger",
        confirmButtonText: "Yes",
        cancelButtonText: "No",
        showCancelButton: true,
        closeOnConfirm: false,
        showLoaderOnConfirm: true
    }, function () {
        var Obj = {
            status: 'released',
            invoice_id: id
        };
        $.ajax({
            type: 'POST',
            url: '/admincp/update_invoice_release_status',
            data: Obj,
            // dataType: 'json',
            success: function(data) {
                console.log('data', data);
                if(data.success) {
                    swal({
                        title: "Release Success",
                        type: "success"
                    }, function () {
                        get_list();
                    });
                } else {
                    swal("Error", data.error);
                    swal({
                        title: data.error,
                        type: "warning"
                    });
                }
            }
        });
    });
}
function reject_payment(id) {
    swal({
        title: "Are you sure?",
        text: "You want to reject transaction",
        type: "info",
        confirmButtonClass: "btn-primary",
        cancelButtonClass: "btn-danger",
        confirmButtonText: "Yes",
        cancelButtonText: "No",
        showCancelButton: true,
        closeOnConfirm: false,
        showLoaderOnConfirm: true
    }, function () {
        var Obj = {
            status: 'rejected',
            invoice_id: id
        };
        $.ajax({
            type: 'POST',
            url: '/admincp/update_invoice_release_status',
            data: Obj,
            // dataType: 'json',
            success: function(data) {
                console.log('data', data);
                if(data.success) {
                    swal({
                        title: "Reject Success",
                        type: "success"
                    }, function () {
                        get_list();
                    });
                } else {
                    swal("Error", data.error);
                    swal({
                        title: data.error,
                        type: "warning"
                    });
                }
            }
        });
    });
}
function send_mail_to_seller_for_add_bank(seller_user_id) {
    swal({
        title: "Are you sure?",
        text: "You want to send mail to seller",
        type: "info",
        confirmButtonClass: "btn-primary",
        cancelButtonClass: "btn-danger",
        confirmButtonText: "Yes",
        cancelButtonText: "No",
        showCancelButton: true,
        closeOnConfirm: false,
        showLoaderOnConfirm: true
    }, function () {
        var Obj = {
            seller_user_id: seller_user_id
        };
        $.ajax({
            type: 'POST',
            url: '/admincp/send_mail_to_seller_for_add_bank',
            data: Obj,
            // dataType: 'json',
            success: function(data) {
                console.log('data', data);
                if(data.success) {
                    swal({
                        title: "Mail sent to seller",
                        type: "success"
                    }, function () {
                        // get_list();
                    });
                } else {
                    swal("Error", data.error);
                    swal({
                        title: data.error,
                        type: "warning"
                    });
                }
            }
        });
    });
}

</script>
