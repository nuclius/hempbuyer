<!--============================================================================*\
|| ########################################################################## ||
|| # Auction Software Marketplace[*]version[*] Build [*]build[*]
|| # ---------------------------------------------------------------------- # ||
|| # Customer License # [*]license[*]
|| # ---------------------------------------------------------------------- # ||
|| # Copyright ©2014–[*]year[*] Develop Scripts LLC. All Rights Reserved    # ||
|| # This file may not be redistributed in whole or significant part.       # ||
|| # ------------- AUCTION SOFTWARE IS NOT FREE SOFTWARE ------------------ # ||
|| # http://www.auctionsoftwaremarketplace.com|support@auctionsoftware.com  # ||
|| # ---------------------------------------------------------------------- # ||
|| ########################################################################## ||
\*============================================================================ -->
{include file="common/header-1.tpl" nocache}
<div >
    <div class="main_container">
        <link rel="stylesheet" href="{$config['externalcss']}print.css" type="text/css" media="print" />
        <style>
        .cust {
            font-size: 22px;
            color: #555555;
            padding: 3px 21px;
            font-weight: bold;
        }

        .amt_paid {
            font-size: 20px;
            color: #555555;
            margin: 0px auto;
            padding: 14px 32px;
            font-weight: bold;
        }

        .trans_dtls {
            font-size: 22px;
            padding: 10px;
            color: #555555;
            font-weight: bold;
        }

        .order {
            margin: 11px 28px;
            font-size: 22px;
            color: #555555;
            font-weight: bold;
        }

        @media print {
            body {
                font-family: arial !important;
                background: none;
                color: black;
            }

            .order_details {
                margin: 10px auto;
                min-height: 119px;
                height: auto;
                padding-bottom: 15px;
                background-color: #e5e5e5;
            }

            .pull-right {
                float: right !important;
            }

            .col-md-1,
            .col-md-2,
            .col-md-3,
            .col-md-4,
            .col-md-5,
            .col-md-6,
            .col-md-7,
            .col-md-8,
            .col-md-9,
            .col-md-10,
            .col-md-11,
            .col-md-12 {
                float: left;
                width: auto;
            }
            .row.tranc_details .col-md-3,
            .row.tranc_details .col-md-4,
            .row.tranc_details .col-md-2,
            .col-md-6 {
                width: 50%;
            }

            .row.amt_invoice1 {
                min-height: inherit;
                height: auto;
            }
            .amt_paid {
                padding: 5px 32px;
            }
            .trans_dtls,
            .order,
            .cust {
                font-size: 15px;
            }
            .tgray_box {
                min-height: 200px;
            }
            .col-md-4.logo_container,
            .col-md-4.logo_container a {
                margin: 10px auto;
                display: inline-block;
                float: none;
                text-align: center;
                width: 100%;
            }
            .customer_service_block,
            .print_hide {
                display: none;
            }
        }
        </style>
        {include file="common/dashboard-navigation.tpl" nocache}
        <div class="container-fluid grey-bg xs-pdlr">
            <div class="container">
              <!-- <button class="btn btn-default btn-d-b green-b" onClick="window.location='{$config.url}/dashboard/mypurchase'">Back</button> -->
              <button class="btn btn-default btn-d-b green-b" onClick="window.location='{$last_url}'">Back</button>
              <ol class="breadcrumb white-bg mt-15" style="color: black;">
                <li onClick="window.location='{$config['url']}/dashboard/my'">{$phrase.dashboard}</li>
                <li onClick="window.history.back();">{$phrase.accounting}</li>
                {$phrase.transaction}
                  <li style="float:right" class="noaftr"> <a id="print_invoice" href="#" ><input type="button" class="btn btn-danger btn-print" value="Print" style="visibility:visible;"></a></li>
              </ol>
                <div class="invoice_print">
                          <div class="row amt_invoice1 white-bg">
                              <div class="amt_paid">{$phrase.amount}: <span class="curr_symbol">{$currency} </span>{$invoice_total_amount}</div>
                              <div class="invoice">{$phrase.this_invoice_has_been_paid_in_date_of} {$invoice.pay_date}</div>
                              
                              {if $invoice.behalf_cc_id>0}
                                <div class="invoice">This is a cash transaction. Payment shall be required upon delivery. No Herbee Coins were used in this transaction.</div>
                              {/if}
                          </div>

                          <div class="row">
                              <div class="col-md-6">
                                  <div class="tgray_box white-bg">
                                      <div class=" cust">{$phrase.shipping} {$phrase.address}</div>
                                      <div class="cacell">{$invoice.buyer_name}
                                          <br /> {$checkoutData.email}
                                      </div>
                                      <div class="cacell">{$checkoutData.address}, {$checkoutData.city}, {$checkoutData.state}, {$checkoutData.country}</div>
                                      <div class="cacell">{$checkoutData.phone}</div>
                                      {if $checkoutData.delivery_instruction != ''}
                                        <div class="cacell"><b>Delivery Instruction:</b> {$checkoutData.delivery_instruction}</div>
                                      {/if}
                                  </div>
                              </div>
                              <div class="col-md-6">
                                  <div class="tgray_box white-bg">
                                      <div class=" cust">{$phrase.transaction_trading_partner}</div>
                                      <!--<div class="cacell">{$invoice.name}
                             </div>
                  <div class="cacell">{if $invoice.uaddress != NULL}{$invoice.uaddress}{/if}</div>-->
                                      <div class="cacell">{$invoice.seller_name}
                                          <br /> {$invoice.seller_email}
                                      </div>
                                      <div class="cacell">{if $invoice.seller_address} {$invoice.seller_address} ,{/if} {if $invoice.seller_city} {$invoice.seller_city},{/if} {$invoice.seller_state}, {$invoice.seller_country}</div>
                                      <div class="cacell">{if $invoice.seller_phone} {$invoice.seller_phone} {/if}</div>
                                  </div>
                              </div>
                          </div>
                          <div class="row tranc_details white-bg">
                              <h5 class="trans_dtls">{$phrase.transaction_details}</h5>
                              <div class="col-md-3 padright">
                                  <h6 class="trans">{$phrase.transaction_id}</h6>
                                  <h6 class="value easp1">{$invoice.i_transaction_id}</h6>
                                  <h6 class="value">{$phrase.created}: {$invoice.create_date}</h6>
                              </div>
                              <div class="col-md-2">
                                  <h6 class="trans">{$phrase.transaction_type}</h6>
                                  <h6 class="value easp1">{$phrase.debit}</h6>
                                  <h6 class="value">{$phrase.invoice_status}: {if $invoice.b_paid_status == 1}Paid{/if}{if $invoice.b_paid_status == 0}<b>UnPaid</b>{/if}</h6>
                              </div>
                              <div class="col-md-4">
                                  <h6 class="trans">{$phrase.generated_by} </h6>
                                  <h6 class="value easp1">{$phrase.billing_and_payments}</h6>
                                  <h6 class="value">{$phrase.created_date}: {$invoice.create_date}</h6>
                              </div>
                              {if $invoice.b_paid_status == 1}
                              <div class="col-md-3 padle" style="padding-right: 1px;">
                                  <h6 class="trans">{$phrase.to}</h6>
                                  <h6 class="value easp1">{$invoice.name}</h6>
                                  <h6 class="value">{$phrase.paid_date}: {$invoice.pay_date}</h6>
                              </div>
                              {/if}
                          </div>
                          <div class="row order_details white-bg">
                              <div class="order">{$phrase.order_details}</div>
                              {if $invoice.b_negotiable_status == 1}
                                <div class="order" align="right">Negotiable</div>  
                              {/if}
                              {if $invoice.p_auction == 1}
                                <div class="order" align="right">Auction Product</div>  
                              {/if}
                              {if $invoice.p_auction == 0 and $invoice.p_negotiable == 0}
                                {if $invoice.buserid == $loged.userid}
                                    <div class="order" align="right">Buynow Product</div>
                                {/if}
                                {if $invoice.buserid != $loged.userid}
                                    <div class="order" align="right">Sold Product</div>
                                {/if}
                              {/if}
                              {if $invoice.b_recurring_status == 1}
                                <div class="order" align="right">Recurring payment: <span>{$invoice.current_position} of {$invoice.count}</span></div>  
                              {/if}
                              <div class="paid"><b>Product</b> - {$invoice.title}</div>
                              <div class="paid">Product unit price - ${$invoice.b_amount} / {$invoice.short_unit}</div>
                              <div class="paid">Requested Quantity - {$invoice.b_qty} {$invoice.short_unit}</div>
                            
                              <div class="paid">Herbee Commission Fee({$invoice.b_commission_per}%) - ${$invoice.b_commission}</div>

                            {if $invoice.buserid == $loged.userid}
                              <div class="paid">Excise Tax({$invoice.b_excise_tax_per}%) - ${$invoice.b_excise_tax_amt}</div>
                            {/if}

                            {* {if $invoice.buserid != $loged.userid} *}
                                <div class="paid">Distribution Fee({$invoice.b_distribution_tax_per}% or $150 which is higher) - ${$invoice.b_distribution_tax}</div>

                                <div class="paid">Sales tax({$invoice.b_stax_per}%) - ${$invoice.b_stax_amt}</div>
                                <div class="paid">Cultivation Tax (If product category is flower or trim) (${$invoice.b_cultivation_tax_per} / {$invoice.short_unit}) - ${$invoice.b_cultivation_tax}</div>
                                <!-- <div class="paid">Distribution tax and cultivation tax will be deducted at sellers side</div> -->
                            {* {/if} *}
                              
                              <!-- ===================== end change by divyesh (changes) ===================== -->
                              {if $invoice.b_recurring_status == 1}
                                {if $invoice.b_cancel_amt > 0}
                                <div class="order">Cancellation Insurance Fee({$invoice.b_cancel_ins_per}%) - ${$invoice.b_cancel_ins_amt}</div>  

                                {/if}
                                <div class="order">Reserve Amount - ${$invoice.b_reserve_amt}</div>  
                              {/if}
<br/>
                              {if $loged.userid == '1'}
                              <div class="paid">Total amount paid to seller : <span class="curr_symbol">{$currency} </span>{$invoice.b_seller_paid_amt}</div>
                              <div class="paid">Total amount paid to admin : <span class="curr_symbol">{$currency} </span>{$invoice.b_admin_paid_amt}</div>
                              {/if}

                            {if $invoice.buserid == $loged.userid}
                                <div class="prices">{$phrase.total}: <span class="curr_symbol">{$currency} </span>{$invoice.total_amount}</div>
                            {/if}
                            {if $invoice.buserid != $loged.userid}
                                <div class="prices">Total Amount: <span class="curr_symbol">{$currency} </span>{($invoice.b_amount * $invoice.b_qty) - $invoice.b_commission - $invoice.b_distribution_tax - $invoice.b_stax_amt - $invoice.b_cultivation_tax}</div>
                            {/if}




                          </div>
                        </div>
            </div>
        </div>
        {literal}
        <script>
        $(function() {
            $("#print_invoice").click(function() {
                createPopup($('.invoice_print').html());
            })
        });
        </script>
        {/literal}
    </div>
    {include file="common/footer-1.tpl" nocache}
