
{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">
    <style>
    .sortcol{
        cursor:pointer;
        position: relative;
        padding-right: 20px !important;
    }
    </style>
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active">
                    Reports <i class="fa fa-angle-double-right"></i> Sales Transactions
                </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->


    <div class="row m-top-20">
        <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/{$loged.adminUrl}/report/sales-transaction/search/{$market}">

                <div class="col-lg-4">
                    <div class="form-group">
                        <label>{$phrases.from_date}</label>
                        <input class="form-control"  value="{$search.from_date}" name="from_date" id="from_date" class="date_picker">
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="form-group">
                        <label>{$phrases.to_date}</label>
                        <input class="form-control"  value="{$search.to_date}" name="to_date" id="to_date" class="date_picker">
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="form-group">
                        <label>Invoice Id</label>
                        <input class="form-control"  value="{$search.invoice_id}" name="invoice_id">
                    </div>
                </div>

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
                <div class="col-lg-4">
                    <label style="visibility:hidden">Hight adjust</label>
                    <div class="form-group">
                        <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> Search</button>
                    </div>
                </div>
            </form>
    </div>
    <div class="row">
    <div class="col-md-6" style="margin-bottom:2%; margin-top:2%;"><a href="{$config.url}{$dlink}" class="text-blue">{$phrases.download_report}</a></div>
    </div>
        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th sort="date_add" class="sortcol {if $sort=='date_add'}sort_{$direction}{/if} {if $sort!='date_add'}sort{/if}">Transaction Date</th>
                        <th sort="seller_username" class="sortcol  {if $sort=='seller_username'}sort_{$direction}{/if} {if $sort!='seller_username'}sort{/if}">Client Member Name</th>
                        <th>Invoice Number</th>
                        <th>Sale Amount (<span class="curr_symbol">{$currency}</span>)</th>
                        <th>Sales Consultant Fee Paid (<span class="curr_symbol">{$currency}</span>)</th>
                        <th sort="buyer_username" class="sortcol  {if $sort=='buyer_username'}sort_{$direction}{/if} {if $sort!='buyer_username'}sort{/if}">Buyer Name</th>
                        <th sort="zone" class="sortcol {if $sort=='zone'}sort_{$direction}{/if} {if $sort!='zone'}sort{/if}" width="100">Zone</th>
                        <th>Action</th>
                        <!-- <th>{$phrases.product_title}</th> -->
                    </tr>
                </thead>
                <tbody>
                    {if $pagination>0}
                        {foreach $trans as $key => $val}	
                        <tr>
                            <td>{$val.date_add}</td>
                            <td>
                                {if $val.seller_username == ''} NA {/if}
                                {if $val.seller_username != ''} {$val.seller_username} {/if}
                            </td>
                            <td><a target="_blank" href="{$config.url}/dashboard/invoice/{$val.buynow_id}">{$val.transactionid}</a></td>
                            <td>{$val.i_amount}</td>
                            <td>{$val.consultant_fee_amount}</td>
                            <td>{$val.buyer_username}</td>
                            <td><input type="text" name="zone{$val.id}" id="zone{$val.id}" value="{$val.zone}" /></td>
                            <!-- <td>{$val.product_title}</td> -->
                            <td>
                                <button class="btn btn-success" id="inc_bal_btn" data-toggle="tooltip" title="update zone." onclick="updateZone({$val.ss_id}, '{$val.id}')">Submit</button>
                            </td>
                        </tr>
                        {/foreach}
                    {else}
                        <tr>
                            <td colspan="15">
                                No sales transactions found !!!
                            </td>
                        </tr>
                    {/if}
                </tbody>
            </table>
        </div>
        {$pagination_html}

        <a href="{$config.url}{$dlink}" class="btn btn-success btn-right" style="margin-top:2%;"> {$phrases.download_report} </a>
    <!-- /.row -->
</div>

{include file="/admincp/footer.tpl" nocache}
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
        timepicker:false,
            scrollMonth:false,
    scrollTime:false,
  scrollInput:false,
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
        timepicker:false,
            scrollMonth:false,
    scrollTime:false,
  scrollInput:false,
        format:'m/d/Y',
    });
});

$(document).ready(function() {
    $('#country_abbr').val('{$search.country}').change();
    if($('#country_abbr').val() != ''){
        $('#state_abbr').val('{$search.state}').change();
    }

})


function updateZone(ss_id, id) {
    if(ss_id == null) {
        swal(
            'Warning',
            'Buyer need to fill-up sales support detail',
            'warning'
        )
        return true;
    }
    var text_msg = '';
    var btn_msg = '';

    text_msg= "Update Zone";
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
                url: '/admincp/update/update_zone',
                data: {
                    ss_id: parseInt(ss_id),
                    zone: $('#zone' + id).val()
                },
                dataType: 'json',
                success: function(data) {
                    if(data.status == true) {
                        swal(
                            'Zone Updated...!',
                            'Zone Updated to users account..!',
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
var fquery = '{$fquery}';
var base = '{$config.url}';
$(document).ready(function() {
    $(document).on('click', '.sortcol', function(){
        var href = '';
        var sort_this = $(this).attr('sort');
        var direction_this = $(this).hasClass('sort_asc') ? 'desc' : 'asc';
        var params = [];
        var sorted = 0;
        if(fquery != '') {
            params = fquery.split('&');
            for (let index = 0; index < params.length; index++) {
                const element = params[index];
                const elements = element.split('=')[0];
                if(elements == 'sort') {
                    params[index] = 'sort=' + sort_this;
                    sorted = 1;
                } else if(elements == 'direction') {
                    params[index] = 'direction=' + direction_this;
                }
                if(params.length-1 == index) {
                    if(sorted == 0) {
                        sort=
                        href = base + '/{$loged.adminUrl}/report/sales-transaction/search/?sort=' + sort_this + '&direction=asc&' + params.join('&');
                    } else {
                        href = base + '/{$loged.adminUrl}/report/sales-transaction/search/?' + params.join('&');
                    }
                    window.location.href = href;
                }
            }
        } else {
            href = base + '/{$loged.adminUrl}/report/sales-transaction/search/?sort=' + sort_this + '&direction=asc';
            window.location.href = href;
        }
        console.log('href', href);
        console.log('params', params);
        
        // window.location.href = '';
    });
});
</script>
