{include file="/common/header-1.tpl" nocache}
<!-- Page content -->
{include file="common/dashboard-navigation.tpl" nocache}
<div class="container-fluid grey-bg xs-pdlr">
    <div class="container dashboard-settings-con m50">
        <div class="row">
            <!-- common sidebar here -->
              <div class="col-md-3 sidebar  mb-25  mb-25">
                <div class="dropdown">
                  <a class="dropdown-toggle" data-toggle="dropdown">Payment Activity <i class="fa fa-angle-down"></i></a>
                  {include file="common/dashboard_settings_menu.tpl" nocache}
                </div>
              </div>
              <!-- / Sidebar -->
            <div class="col-md-9 content-area">
                <div class="row">
                    <div class="panel panel-success m5 m-t-0">
                        <div class="panel-heading green-bg">
                            <h3>Payment Activity</h3>
                        </div>
                    </div>
                    <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/dashboard/payments/">
                        <div class="row">
                          <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-12 p35">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-4 col-md-3">
                                            <div class="form-group">
                                                <label>Invoice Id</label>
                                                <input class="w100 p15 pb15 border-0" placeholder="Enter Invoice Id" value="{$search.invoice_id}" name="invoice_id">
                                            </div>

                                          </div>
                                        <div class="col-xs-6 col-sm-4 col-md-3">
                                            <div class="form-group">
                                                <label>Status</label>
                                                <select class="w100 p15 pb15 border-0" name="status">
                                                    <option value="" selected>All</option>
                                                    <option value="paid" {if $search.status == 'paid'} selected {/if}>Paid</option>
                                                    <option value="unpaid" {if $search.status == 'unpaid'} selected {/if}>Unpaid</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-xs-6 col-sm-4 col-md-3">
                                            <div class="form-group">
                                                <label>Type</label>
                                                <select class="w100 p15 pb15 border-0" name="type">
                                                    <option value="" {if $search.type == ''} selected {/if}>All</option>
                                                    <option value="wire_payment" {if $search.type == 'wire_payment'} selected {/if}>Wire Payments</option>
                                                    <option value="check_payment" {if $search.type == 'check_payment'} selected {/if}>Check Payments</option>
                                                    <option value="membership" {if $search.type == 'membership'} selected {/if}>Membership</option>
                                                    <option value="ad_payment" {if $search.type == 'ad_payment'} selected {/if}>Ads Payment</option>
                                                    <option value="bought" {if $search.type == 'bought'} selected {/if}>Products</option>
                                                    <option value="relationship" {if $search.type == 'relationship'} selected {/if}>Relationship</option>
                                                    <option value="refund_request" {if $search.type == 'refund_request'} selected {/if}>Refund</option>
                                                    <option value="manual_payment" {if $search.type == 'manual_payment'} selected {/if}>Edited By Admin</option>
                                            <!--
                                                    <option value="" selected>All</option>
                                                    <option value="bought" {if $search.type == 'bought'} selected {/if}>Bought</option>
                                                    <option value="refund_reserve_amount" {if $search.type == 'refund_reserve_amount'} selected {/if}>Refund Reserve Amount</option>
                                                    <option value="wire_payment" {if $search.type == 'wire_payment'} selected {/if}>Wire Payment</option> -->
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-xs-6 col-sm-4 col-md-3">
                                            <div class="form-group">
                                                <label>Invoice Status</label>
                                                <select class="w100 p15 pb15 border-0" name="istatus">
                                                    <option value="" selected>All</option>
                                                    <option value="debit" {if $search.istatus == 'debit'} selected {/if}>Debit</option>
                                                    <option value="credit" {if $search.istatus == 'credit'} selected {/if}>Credit</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-3 margin-auto">
                                            <label>Start Date</label>
                                            <div class="input-group">
                                                <input class="w100 p15 pb15 border-0" type="text" id="start_date1" placeholder="Start Date" name="start_date"  value="{$search.start_date}">
                                                <span class="input-group-addon" id="basic-addon2">
                                                  <i class="fa fa-calendar" aria-hidden="true"></i>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-md-3 margin-auto">
                                            <label>End Date</label>
                                            <div class="input-group">
                                                                <input class="w100 p15 pb15 border-0" type="text" id="start_date2" placeholder="End Date" name="end_date"  value="{$search.end_date}">
                                            <span class="input-group-addon" id="basic-addon2">
                                              <i class="fa fa-calendar" aria-hidden="true"></i>
                                            </span>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 jkm">
                                            <label style="visibility:hidden;">End Date</label>
                                            <div class="form-group">
                                              <button style="    height: 49px;" type="submit" class="btn btn-default btn-d-b green-b m0 f14"> <i class="fa fa-search"></i> Search</button>
                                              <a href="{$config.url}/dashboard/payments/download" class="btn btn-default btn-d-b green-b m0"> <i class="fa fa-download"></i> Download</a>
                                           </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                          </div>
                        </div>
                    </form>
                    <div class="col-md-12 white-bg-2 p35 shadow">
                        <div class="row">
                            <div class="col-xs-12 notifications  xs-pdlr">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="table-responsive">
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <td class="f700">Invoice Id</td>
                                                        <td class="f700">Description</td>
                                                        <!-- <td class="f700">Status</td> -->
                                                        <td class="f700">Sales Tax</td>
                                                        <td class="f700">Distribution Fee</td>
                                                        <td class="f700">Total Paid</td>
                                                        <td class="f700">Status</td>

                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    {foreach $payments as $key => $val}
                                                    <tr>
                                                        <td><a href="{$config.url}/dashboard/invoice/{$val.buynow_id}" ><strong>{$val.id}</strong></a></td>
                                                        <td>
                                                            {if $val.primary_id == 0}
                                                                <h4><b class="caption">{$val.type}</b></h4>
                                                            {/if}
                                                            {if $val.primary_id > 0}
                                                            <h4><b class="caption">{$val.description}</b></h4>
                                                            {/if}
                                                            <p class="description">Created at : {$val.i_date_added}
                                                                {if $val.type == "bought"}
                                                                        <br> <a href="{$config.url}/dashboard/invoice/{$val.buynow_id}" >More Details...</a>
                                                                {/if}
                                                                <!-- <br> {$val.istatus} -->
                                                                <br> {$val.tr_type}
                                                            </p>
                                                        </td>
                                                        <td>{if $val.stax_amt!=0}${$val.stax_amt}{/if}{if $val.stax_amt==0}-{/if}</td>
                                                        <td>{if $val.distribution_tax!=0}${$val.distribution_tax}{/if}{if $val.distribution_tax==0}-{/if}</td>
                                                        <!-- <td>{$val.status}</td> -->
                                                        <td>${$val.amount}</td>
                                                        <td>

                                                            {if $val.status == 'paid' && $val.tr_type == 'debit'}
                                                            <label>Paid</label>
                                                            {/if}

                                                            {if $val.status == 'paid' && $val.tr_type == 'credit'}
                                                            <label>Credited</label>
                                                            {/if}

                                                            <!-- {if $val.status == 'paid' && $val.istatus == 'debit'}
                                                            <label>Paid</label>
                                                            {/if}

                                                            {if $val.status == 'paid' && $val.istatus == 'credit'}
                                                            <label>Credited</label>
                                                            {/if} -->
                                                        </td>
                                                    </tr>
                                                    {/foreach}

                                                </tbody>
                                            </table>
                                        </div>
                                          {if $cnt < 1} <div class="row flex p15-0">
                                            <div class="col-sm-12 margin-auto p-r-0">
                                                <h2 class="text-center res-f12">No Records Found...!</h2>
                                            </div>
                                        </div>
                                    {/if}
                                        {$pagination_html}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <!-- / Content Area -->
</div>
    <!-- Parent Row -->
</div>
<!-- dashboard-settings-con -->
</div>
<!--/ Page content -->
{include file="/common/footer-1.tpl" nocache}
<script type="text/javascript">
    $("#start_date1").datetimepicker({
        timepicker:true,
        format:'Y-m-d H:m:s',
        step: 5,
        maxDate: 0,
        // minTime: 0,

    });
    $("#start_date2").datetimepicker({
        ttimepicker:true,
        format:'Y-m-d H:m:s',
        step: 5,
        maxDate: 0,
    });
</script>
