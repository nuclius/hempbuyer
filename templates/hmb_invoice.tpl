{include file="/common/header-1.tpl" nocache}

<section class="db-wrapper db-iwrap mt-4">
    {* {include file="/common/header-2.tpl" nocache} *}

    <div class="container"  id="print_div">
        <h2 class="pp-head clearfix">
            <span class="mt-4 float-left">INVOICE {$invoice_data.id} </span>
            <img src="{$config.url}/images/logo.png" class="float-right print_only" />
            <button class="btn btn-prev float-right print_btn" onclick="printDiv('print_div')">PRINT</button>
        </h2>  

        <div class="invoice-panel">
            <div class="row">
                <div class="col-md-6">
                    <h3 class="amount-txt"><b>Amount:</b> US ${numberWithCommas($invoice_data.total_amount)}</h3>
                </div>
                <div class="col-md-6">
                    <p class="inv-note">{if $invoice_data.paid_date}This invoice has been paid in date of {$invoice_data.paid_date}{else /}Unpaid{/if}</p>
                </div>
            </div>

            <div class="address-wrapper row">
                <div class="col-md-6">
                    <h5><b>Customer Billing Information</b></h5>
                    <div>
                        <div>{$invoice_data.buyer_name}</div>
                        <div>{$invoice_data.buyer_address}</div>
                        <div>{$invoice_data.buyer_city}</div>
                        <div>{$invoice_data.buyer_state} {$invoice_data.buyer_zipcode}</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <h5><b>Transaction Partner</b></h5>
                    <div>
                        <div>{$invoice_data.seller_name}</div>
                        <div>{$invoice_data.seller_address}</div>
                        <div>{$invoice_data.seller_city}</div>
                        <div>{$invoice_data.seller_state} {$invoice_data.seller_zipcode}</div>
                    </div>
                </div>
            </div>
                <h5><b>Transaction Details</b></h5>

            <div class="row td-wrapper">
                <div class="col-md-6">
                    <div class="td-box">
                        <h6 class="td-head"><i>Transaction ID</i></h6>
                        <div>{$invoice_data.id}</div>
                        <div>Created: {$invoice_data.date_added}</div>
                        <div>TX 77380</div>
                        <h6 class="td-head mt-3"><i>Transaction Type</i></h6>
                        <div class="text-capitalize">{$invoice_data.gateway}</div> 
                        <div class="text-capitalize">Invoice status: {$invoice_data.status}</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="td-box">
                        <h6 class="td-head"><i>Generated by</i></h6>
                        <div>Billing and Payments</div>
                        <div>Created date: {$invoice_data.date_added}</div>
                        <div>TX 77380</div>
                        <h6 class="td-head mt-3"><i>To</i></h6>
                        <div>Richmond and Sage</div> 
                        <div>Paid date: {if $invoice_data.paid_date}{$invoice_data.paid_date}{else /}-{/if}</div>
                    </div>
                </div>
            </div>
            <div class="inv-lhead">Invoice</div>
            <div class="table-responsive">
                <table class="table table-stripped table-inverse">
                    <thead>
                        <tr>
                            <th>Quantity</th>
                            <th>Product Title</th>
                            <th>Shipping Charge</th>
                            <th>Transaction Fee ({$invoice_data.transaction_fee_per}%)</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>{$invoice_data.title}</td>
                            <td>${numberWithCommas($invoice_data.shipping_amount)}</td>
                            <td>${numberWithCommas($invoice_data.transaction_fee)}</td>
                            <td>${numberWithCommas($invoice_data.total_amount)}</td>
                        </tr>
                        <tr>
                            <td colspan="3"></td>
                            <td>
                                <h6 class="tp-lbl">Total Price</h6>
                            </td> 
                            <td>${numberWithCommas($invoice_data.total_amount)}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <style type="text/css">
                @media print {
                    .print_btn {
                        visibility: hidden;
                    }
                }
                

                .invoice-panel {
                    padding: 30px;
                    margin: 30px auto;
                    border: 1px solid #dbdbdb;
                }

                .address-wrapper {
                    margin:30px -15px;
                    border-top: 1px solid #dbdbdb;
                    border-bottom: 1px solid #dbdbdb;
                }

                .address-wrapper .col-md-6,
                .td-wrapper  .col-md-6 {
                    padding:30px 15px;
                    min-height:200px;
                }
                .address-wrapper .col-md-6 + .col-md-6 {
                    border-left: 1px solid #dbdbdb;
                }

                .td-wrapper  .td-box {
                    border: 1px solid #dbdbdb;
                    padding:30px;
                    margin:15px auto;
                }

                .inv-note {
                    padding: 10px 0;
                    line-height: 21px;
                    margin: 0;
                }

                .td-head {
                    font-weight:bold;
                }

                .inv-lhead {
                    border: 1px solid #5A9234;
                    padding: 10px 20px;
                    background: #5A9234;
                    color: #fff;
                    font-size: 28px;
                    text-align: center;
                    line-height: 1;
                    margin: 0 auto 25px;
                }

                .tp-lbl {
                    color:#5A9234;
                    font-weight:600; 
                }
                .pp-head .btn-prev {
                    line-height:17px;
                }
                .print_only {
                    display: none;
                }
                @media print {
                    .print_only {
                        display: block;
                    }
                }
                @media (max-width :425px){
                    .invoice-panel{
                        margin-top:25%!important;
                    }
                }
            </style>
        </div>
    
        <div class="row mb-4 print_only" style="width: 98%; position: absolute; bottom: 0px;">
            <div class="col-sm-12 text-center">
                <img src="{$config.url}/images/logo.png" />
            </div>
            <div class="col-sm-12 text-center">
                <div class="col-sm-12 text-center"><i>Transaction coordinated by the courtesy of HempBuyerAuction.</i></div>
                <div class="col-sm-12 text-center">1 Lucky Dog LLC, dba HempBuyerAuction, 555 N. El Camino  Real #A182, San Clemente, CA 92672, 800-420-4196, info@hempbuyer.com</div>
            </div>
        </div>

    </div>
</section>

{include file="/common/footer-1.tpl" nocache}

<script language="javascript" type="text/javascript">
    function printDiv(divName) {
        var printContents = document.getElementById(divName).innerHTML;
        var originalContents = document.body.innerHTML;

        document.body.innerHTML = printContents;

        window.print();

        document.body.innerHTML = originalContents;
    }

</script>