{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}
<link rel="stylesheet" href="{$config.url}/css/jquery.datetimepicker.css" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/css/bootstrap-select.min.css">
<script src="{$config.url}/js/jquery.datetimepicker.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/bootstrap-select.min.js"></script>
<style media="screen">
    .dropdown-menu {
        margin-left: 39px;
    }
</style>
<div class="container-fluid my-funds">
    <div class="container">
        <div class="col-md-12 padlr tabbable tabs-left">
            <div class="col-sm-3">
                <div class="package2">
                    <!-- <div class="stripe"><img src="../images/home/portf1.jpg"> </div> -->
                    <!-- <div class="pheader2">Pamela Anderson</div> -->
                    <div class="col-md-12 pbody">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#Balances" data-toggle="tab"><i class="fa fa-balance-scale"></i> Account Balances</a></li>
                            <li><a href="#Income" data-toggle="tab">Income Summary</a></li>
                            <li><a href="#Purchase" onclick="purchaseSearchfields()" data-toggle="tab">Purchase History</a></li>
                            <li><a href="#transaction" onclick="transactionSearchfields()" data-toggle="tab">Transaction History</a></li>
                        </ul>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="col-sm-9">
                <div class="tab-content">
                    <div class="tab-pane active" id="Balances">
                        <h2>Manage My Funds  &#xbb; <strong class="ftn16">Account Balances</strong>

                            <a href="#" class="dmld"><i class="fa fa-download" aria-hidden="true"></i> Download Statement</a>

                        </h2>
                        <table class="table  custab">
                            <tbody>
                                <tr>
                                    <td class="text-left">My Receivables</td>
                                    <td class="txt-active">$4,250.12</td>
                                    <td class="text-center"> <a   class="btn btn-rmv btn-xs" href="withdraw.html"> Manage</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane" id="Income">
                        <h2>Manage My Funds  &#xbb; <strong class="ftn16">Income Summary</strong>

                        <a href="#" class="dmld"><i class="fa fa-download" aria-hidden="true"></i> Download Statement</a>
                        </h2>
                        <table class="table custab">
                            <tbody>
                                <tr>
                                    <td class="text-left">Sales revenue from my stores</td>
                                    <td>$0.00</td>
                                </tr>
                                <tr class="ftn600 bor-bot">
                                    <td class="text-left ">Net revenue from my stores</td>
                                    <td>$0.00</td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp; </td>
                                </tr>
                                <tr>
                                    <td class="text-left">Sales revenue from my products</td>
                                    <td class="revenuefromproduct">$0.00</td>
                                </tr>
                                <tr>
                                    <td class="text-left">Paid to stores</td>
                                    <td class="paidtostore">$0.00</td>
                                </tr>
                                <tr>
                                    <td class="text-left">Transaction fees</td>
                                    <td>$0.00</td>
                                </tr>
                                <tr class="ftn600 bor-bot">
                                    <td class="text-left ">Net revenue from my products</td>
                                    <td>$0.00</td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp; </td>
                                </tr>
                                <tr class="ftn600 bor-bot">
                                    <td class="text-left ">Total Net Revenue</td>
                                    <td>$0.00</td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp; </td>
                                </tr>
                                <tr>
                                    <td class="text-left">Paid to you for this period</td>
                                    <td>$0.00</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane" id="Purchase">
                        <h2>Manage My Funds  &#xbb; <strong class="ftn16">Purchase History</strong>
                        <a href="#" class="dmld">
                            <i class="fa fa-download" aria-hidden="true"></i> Download Statement</a>
                        </h2>
                        <div class="searchfields">
                            <div class="row">
                                <label class="col-md-2 text-right" style="margin-top: 8px;">
                                    <input type="radio" class='pull-left' id="range" name="optionsRadios" value="fixed" checked>
                                    Within:
                                </label>
                                <div class="col-md-3 form-group">
                                    <select name="rangepast" id="rangepast" class="form-control">
                                        <option value="day">The Past Day</option>
                                        <option value="week">The Past Week</option>
                                        <option value="month">The Past Month</option>
                                        <option value="year" selected>The Past Year</option>
                                    </select>
                                </div>
                                <label class="col-md-2 text-right" style="margin-top: 8px;">
                                    <input type="radio" class='pull-left' id="range" name="optionsRadios" value="range">
                                    From:
                                </label>
                                <div class="col-md-3 form-group">
                                    <input type="text" id="from_date" name="fromdate" class="form-control days date-picker" placeholder="2015-01-01" style="background-color: #fff !important;" >
                                </div>

                                <label class="col-md-2  text-right" style="margin-top: 8px;">To : </label>
                                <div class="col-md-3 form-group">
                                    <input type="text" id="to_date" name="todate" class="form-control days date-picker" style="background-color: #fff !important;" placeholder="2015-01-01" >
                                </div>

                                <label class="col-md-2 text-right" style="margin-top: 8px;">Store:</label>
                                <div class="col-md-3 form-group">
                                    <select name="rangepast" id="allstores" multiple class="form-control" data-selected-text-format="count" data-live-search="true">
                                        {foreach $store as $key => $val}
                                            <option value="{$val.id}">{$val.name}</option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="col-md-2 form-group pull-right">
                                    <button type="button" class='btn btn-success search_trans pull-right' name="submit">Search</button>
                                </div>
                                <input type="hidden" id="storeid" class="form-control" value="">
                            </div>
                        </div>
                        <table class="table custab">
                            <thead>
                                <tr style="background:#ccc;">
                                    <th>S.No</th>
                                    <th>Purchase Details</th>
                                    <th>Date</th>
                                    <th>Payment Type</th>
                                    <th>Amount</th>
                                </tr>
                            </thead>
                            <tbody class='get-data'>
                                <tr><td colspan='5' class='text-center'>No data</td></tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane" id="transaction">
                        <h2>Manage My Funds  &#xbb; <strong class="ftn16">Transaction History</strong></h2>
                        <div class="searchfields">
                        </div>
                        <table class="table custab">
                            <thead>
                                <tr style="background:#ccc;">
                                    <th>S.No</th>
                                    <th>Transaction Details</th>
                                    <th>Date</th>
                                    <th>Transaction Type</th>
                                    <th>Amount</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody class='get-data'>
                                <tr><td colspan='5' class='text-center'>No data</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- <div class="container">
    <div class="h3 col-md-12 text-center">
        Transaction of sales
    </div>

</div> -->
{include file="common/footer-1.tpl" nocache}
<script type="text/javascript">
$(function () {
    if($("#allstores").length > 0) {
        $('#allstores').selectpicker({
            noneSelectedText: '0 stores selected'
        });
        var allstoreid = [];
        $('#allstores option').each(function() {
            allstoreid.push($(this).attr('value'));
        });
        $('#allstores').selectpicker('val',allstoreid);
    }

    $("#from_date").datetimepicker({
        formatDate  :'yyyy-mm-dd',
        pickTime    : false
    });
    $("#to_date").datetimepicker({
        formatDate  :'yyyy-mm-dd',
        pickTime    : false
    });
    $('body').on('click','.search_trans', function() {
        var temptype = $(this).closest('.tab-pane').attr("id").toLowerCase();
        var method   = $("input[name=optionsRadios]:checked").val();
        if($("#allstores").length > 0) {
            var storeid  = $('#allstores').selectpicker('val');
            if(storeid != null) {
                storeid = storeid.toString();
            } else {
                alert('Please select atleast anyone store');
                return false;
                storeid = '0';
            }
        } else {
            var storeid = $('#storeid').val();
        }
        var within      = $("#rangepast").val();
        var from_date   = $("#from_date").val();
        var to_date     = $("#to_date").val();
        var myKey = {
            'method'    : method,
            'within'    : within,
            'from_date' : from_date,
            'to_date'   : to_date,
            'storeid'   : storeid
        };
        $.ajax({
            type    :"POST",
            url     :"/stores/transactiondata",
            data    :myKey,
            dataType:"json",
            success:function(data) {
                $(".get-data").html('');
                var ress = data.res;
                var ress2 = data.res2;
                if(temptype == 'transaction') {
                    if(ress2.length > 0 ) {
                        for(j=0; j < ress2.length; j++) {
                            var html = '<tr>';
                                si = Number(j)+1;
                            html += "<td>"+si+"</td>";
                            html += "<td><b>"+ress2[j].name+"</b> (Store)</td>";
                            html += "<td>"+ress2[j].date+"</td>";
                            html += "<td>Credit</td>";
                            html += "<td>$"+ress2[j].amount+"</td>";
                            if(ress2[j].status == 'hold') {
                                html += "<td>Cancelled</span>\
                                </a></td>";
                            } else {
                                var tempid = '"'+ress2[j].subscription_id+'"';
                                html += "<td><a class='btn btn-danger btn-xs' onclick='ajaxCancelSub("+tempid+")'>\
                                Cancel\
                                </a></td>";
                            }
                            $(".get-data").append(html+"</tr>");
                        }
                    }
                } else if(temptype == 'purchase') {
                    if(ress.length > 0 ) {
                        for(j=0; j < ress.length; j++) {
                            var html = '<tr>';
                                si = Number(j)+1;
                            html += "<td>"+si+"</td>";
                            html += "<td><b>"+ress[j].title+"</b> (Product)</td>";
                            html += "<td>"+ress[j].date_added+"</td>";
                            html += "<td>Debit</td>";
                            html += "<td>$"+ress[j].amount+"</td>";
                            $(".get-data").append(html+"</tr>");
                        }
                    }
                }

                if(Number(ress2.length) <= 0 && Number(ress.length) <= 0 ) {
                    $(this).closest('.tab-pane').find(".get-data").html("<tr><td colspan='5' class='text-center'>No data</td></tr>");
                }
            }
        });
        $('.block-wrapper').fadeIn();
    });
    $('.search_trans').trigger('click');

});
$(window).load(function() {
    if($("#allstores").length > 0) {
        var storeid  = $('#allstores').selectpicker('val');
        if(storeid != null) {
            storeid = storeid.toString();
        } else {
            alert('Please select atleast anyone store');
            return false;
            storeid = '0';
        }
    } else {
        var storeid = $('#storeid').val();
    }
    var myKey = {
        'storeid'   : storeid
    };
    $.ajax({
        type    :"POST",
        url     :"/stores/incomesummary",
        data    :myKey,
        dataType:"json",
        success:function(data) {
            $('.revenuefromproduct').html("$"+data.res2)
            $('.paidtostore').html("$"+data.res)
        }
    });
});
function purchaseSearchfields() {
    if($('#transaction .searchfields .row').length > 0) {
        var html = $('#transaction .searchfields .row').detach();
        $('#Purchase .searchfields').html(html);
        $('.search_trans').trigger('click');
    }
}
function transactionSearchfields() {
    if($('#Purchase .searchfields .row').length > 0) {
        var html = $('#Purchase .searchfields .row').detach();
        $('#transaction .searchfields').html(html);
        $('.search_trans').trigger('click');
    }
}
function ajaxCancelSub(subid) {
    var myKey = {};
    $.ajax({
        type    :"POST",
        url     :"{$config.url}/stores/cancelsubscription/"+subid+"",
        data    :myKey,
        dataType:"json",
        success:function(data) {
            if(data.result == 'success') {
                location.reload();
            }
        }
    });
}
</script>
