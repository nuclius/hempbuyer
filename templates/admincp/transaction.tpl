
{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

                <!-- Page Heading -->

                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-user"></i> 
                                {if $market == 'open'} Open Bid Transactions{/if}
                                {if $market == 'direct'} Direct Buy Transactions{/if}
                                {if $market == 'recurring'} Recurring Transactions{/if}
                                {if $market == ''}ALL Transactions{/if}
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->


                <div class="row m-top-20">
                   <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/admincp/transaction/{if $productsearch}product{else\}list{/if}/{$market}">

                         <div class="col-lg-4">
                            <!-- <div class="form-group">
                                <label>Type</label>
                                <input class="form-control" name="type" value="{$search.type}">
                            </div> -->
                             <div class="form-group">
                                <label>Invoice Id</label>
                                <input class="form-control"  value="{$search.invoice_id}" name="invoice_id">
                            </div>
                            <div class="form-group">
                                <label>Product Title</label>
                                <input class="form-control"  value="{$search.projecttit}" name="projecttit">
                            </div>
                            <div class="form-group">
                                <label>Type</label>
                                <select class="form-control" name="type">
                                    <option value="" {if $search.type == ''} selected {/if}>All</option>
                                    <option value="wire_payment" {if $search.type == 'wire_payment'} selected {/if}>Wire Payments</option>
                                    <option value="check_payment" {if $search.type == 'check_payment'} selected {/if}>Check Payments</option>
                                    <option value="membership" {if $search.type == 'membership'} selected {/if}>Membership</option>
                                    <option value="ad_payment" {if $search.type == 'ad_payment'} selected {/if}>Ads Payment</option>
                                    <option value="refund_ad_payment" {if $search.type == 'refund_ad_payment'} selected {/if}>Ads Payment</option>
                                    <option value="bought" {if $search.type == 'bought'} selected {/if}>Products</option>
                                    <option value="relationship" {if $search.type == 'relationship'} selected {/if}>Relationship</option>
                                    <option value="refund_request" {if $search.type == 'refund_request'} selected {/if}>Refund</option>
                                    <option value="manual_payment" {if $search.type == 'manual_payment'} selected {/if}>Edited By Admin</option>
                                    <option value="refer_promo" {if $search.type == 'refer_promo'} selected {/if}>Referal Bonus</option>
                                </select>
                            </div>
                         </div>

                          <div class="col-lg-4">
                            <div class="form-group">
                                <label>{$phrases.from_date}</label>
                                <input class="form-control"  value="{$search.from_date}" name="from_date" id="from_date" class="date_picker">
                            </div>
                            <div class="form-group">
                                <label>{$phrases.to_date}</label>
                                <input class="form-control"  value="{$search.to_date}" name="to_date" id="to_date" class="date_picker">
                            </div>
                             <div class="form-group">
                                <label>{$phrases.status}</label>
                                <select class="form-control" name="status">
                                    <option value="" {if $search.status == ''} selected {/if}>All</option>
                                    <option value="debit"  {if $search.status == 'debit'} selected {/if}>debit</option>
                                    {if $market != 'open' && $market !='direct'}<option value="credit"  {if $search.status == 'credit'} selected {/if}>Credit</option>{/if}
                                 <!--    <option value="winner"  {if $search.status == 'winner'} selected {/if}>Winner</option>
                                    <option value="sold"  {if $search.status == 'sold'} selected {/if}>Sold</option> -->
                                </select>
                            </div>
                          </div>

                          <div class="col-lg-4">
                             <div class="form-group">
                                <label>Country</label>
                                  <select class="form-control" name="country" id="country_abbr">
                                    <option value="{$search.country}">Select Country</option>
                                  </select>
                            </div>

                            <div class="form-group">
                                <label>State</label>
                                  <select class="form-control" name="state" id="state_abbr">
                                    <option value="{$search.state}">Select State</option>
                                  </select>
                            </div>

                            <div class="form-group">
                                <label>Filter by taxes</label>
                                  <select class="form-control" name="tax_filter" id="tax_filter">
                                    <option {if $search.tax_filter == ''} selected {/if} value="">Select tax</option>
                                    <option {if $search.tax_filter == 'cultivation'} selected {/if} value="cultivation">Cultivation</option>
                                    <option {if $search.tax_filter == 'distribution'} selected {/if} value="distribution">Distribution</option>
                                    <option {if $search.tax_filter == 'excise'} selected {/if} value="excise">Excise</option>
                                  </select>
                            </div>

                            <label style="visibility:hidden">Hight adjust</label>
                            <div class="form-group">
                              <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> Search</button>
                           </div>
                          </div>


                        </form>

                </div>
                 <div class="row">
                  <div class="col-md-6"><label>{$phrases.net_revenue}</label> : ${$total}</div>
                  <div class="col-md-6"><label>Revenue to Herbee</label> : ${$comm_rev}</div>
                  <div class="col-md-6" style="margin-bottom:2%; margin-top:2%;"><a href="{$config.url}{$dlink}" class="text-blue">{$phrases.download_report}</a></div>
                 </div>
                {include file="/admincp/transaction-list.tpl" nocache}

                  <a href="/admincp/transaction/download?{$fquery}" class="btn btn-success btn-right" style="margin-top:2%;"> {$phrases.download_report} </a>
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
     </script>
