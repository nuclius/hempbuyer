{include file="/common/header-1.tpl" nocache}
<script src="https://js.stripe.com/v3/"></script>

<!-- <div class="clearfix auth-container" style="padding-top: 100px !important;"> -->
<section class="db-wrapper db-iwrap">
    {include file="/common/header-2.tpl" nocache}

    <style>
        .wrapper1 {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            position: absolute;
            top: 0px;
            right: -60px;
        }
        .wrapper1 .file-upload {
            height: 50px;
            width: 50px;
            border-radius: 100px;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            border: 4px solid #FFFFFF;
            overflow: hidden;
            background-image: linear-gradient(to bottom, #DBE2EA 50%, #878B95 50%);
            background-size: 100% 200%;
            transition: all 1s;
            color: #adadad;
            font-size: 100px;
            box-shadow: 2px 2px 4px 0px #e6e6e6;
        }
        .wrapper1 .file-upload input[type='file'] {
            height: 200px;
            width: 100%;
            position: absolute;
            top: 0;
            left: 0;
            opacity: 0;
            cursor: pointer;
        }
        .wrapper1 .file-upload:hover {
            background-position: 0 -100%;
            color: #2F2E32;
        }
        .lakodama
        {
                font-size: 20px;
        }


        .StripeElement {
            height: 46px;
            padding: 15px 12px;
            width: 100%;
            color: #32325d;
            background-color: white;
            border-radius: 4px;
            box-shadow: 0 1px 3px 0 #e6ebf1;
            border: 1px solid #ced4da;
            -webkit-transition: box-shadow 150ms ease;
            transition: box-shadow 150ms ease;
        }
        .StripeElement--focus {
            box-shadow: 0 1px 3px 0 #cfd7df;
        }
        .StripeElement--invalid {
            border-color: #fa755a;
        }
        .StripeElement--webkit-autofill {
            background-color: #fefde5 !important;
        }
        .width-170 {
            width: 170px;
        }
    </style>
    <div class="container">
        <div class="row">
            <div class="col-md-4 form-group">
                <h3 class="acc-head">
                    PAYMENT (CARD){* {if $bid_details.total_amount > 2500}(WIRE TRANSFER){else /}(CARD){/if} *}
                </h3>
            </div>
            {* <div class="col-md-8 form-group">
                {if $bid_details.total_amount > 2500}
                <div class="form-inline wt-wrap pay-acc">
                    <div class="clearfix cselec-wrap">
                        <select class="custom-select" id="choose_account">
                            <option value="">Choose Account</option>
                            {foreach $bank_list as $key => $val}
                                <option value="{$val.id}">{$val.account_name}({$val.account_number})</option>
                            {/foreach}
                        </select>
                    </div>
                    <button class="btn btn-prev" id="add_more_bank">ADD MORE</button>
                </div>
                {/if}
            </div> *}
        </div>
         <div class="db-content">
            <div class="db-menu">
                <ul class="">
                    <li><a href="/profileInfo" class="">Profile Info</a></li>
                    <li><a href="/passwordInfo" class="">Change Password</a></li>
                    <li><a href="/paymentInfo" class="active">Payment</a></li>
                    <li><a href="/transactionsInfo" class="">Transactions</a></li> 
                    <li><a href="/bank_list" class="">Bank Details</a></li> 
                </ul>
            </div>
            <div class="db-right-con payment_div">
            {* {if $bid_details.total_amount > 2500}
                <form class="wtrans-form" id="bank_details_form" data-parsley-validate novalidate>
                    <input type="hidden" value="0" name="bank_id" id="bank_id">
                   <h4 class="sec-head">BANK INFO</h4>
                   <div class="row">
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">Bank Swift Code</label>
                           <input class="form-control" name="swift_code" id="swift_code" placeholder="Bank Swift Code" required data-parsley-trigger="change" />
                       </div> 
                   </div>
                   <h4 class="sec-head">ACCOUNT HOLDER INFO</h4>
                   <div class="row">
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">Account Number</label>
                           <input class="form-control" name="account_number" id="account_number" placeholder="Account Number" required data-parsley-trigger="change" />
                       </div>
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">Name on Account</label>
                           <input class="form-control" name="account_name" id="account_name" placeholder="Name on Account" required data-parsley-trigger="change" />
                       </div>
                   </div>
                   <div class="row">
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">Routing Number</label>
                           <input class="form-control" name="routing_number" id="routing_number" placeholder="Routing Number" required data-parsley-trigger="change" />
                       </div>
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">City</label> 
                           <input class="form-control" name="city" id="city" placeholder="City" required data-parsley-trigger="change" />
                       </div>
                   </div> 
                   <div class="row"> 
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">State</label> 
                           <div class="clearfix cselec-wrap">
                               <select class="custom-select" name="state" id="state" required data-parsley-trigger="change">
                                    <option value="">Select State</option>
                                    {foreach $states as $key => $val}
                                        <option value="{$val.abbrev}">{$val.name}</option>
                                    {/foreach}
                               </select>
                           </div>
                       </div>
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">Country</label> 
                           <div class="clearfix cselec-wrap">
                               <select class="custom-select" name="country" id="country" required data-parsley-trigger="change">
                                  <option value="us">United States</option>
                               </select>
                           </div>
                       </div> 
                   </div>
                   <div class="row">
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">Phone Number</label>
                           <input class="form-control" name="phone" id="phone" placeholder="Phone Number" required data-parsley-trigger="change" />
                       </div>
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">Remmitance Information</label>
                           <input class="form-control" name="remmitance_information" id="remmitance_information" placeholder="Remmitance Information" required data-parsley-trigger="change" />
                       </div>
                   </div> 
                   <div class="cus-check form-group">
                       <input type="checkbox" checked="checked" name="term" id="term" required>
                       <span class="checkmark"></span> I attest that I am the owner and have full authorization to this bank account.
                   </div>
                    <div class="col-sm-6">
                        <label class="sf-label width-170">Amount: </label>
                        <span>${numberWithCommas($bid_details.amount)}</span>
                    </div>
                    <div class="col-sm-6">
                        <label class="sf-label width-170">Shipping Charge: </label>
                        <span>${numberWithCommas($bid_details.shipping_amount)}</span>
                    </div>
                    <div class="col-sm-6">
                        <label class="sf-label width-170">Transaction fee ({$bid_details.transaction_fee_per}%): </label>
                        <span>${$bid_details.transaction_fee}</span>
                    </div>
                    <div class="col-sm-6">
                        <label class="sf-label width-170">Total Amount: </label>
                        <span>${numberWithCommas($bid_details.total_amount)}</span>
                    </div>
                   <div class="pp-btns-wrap">
                       <button class="btn btn-prev">CANCEL</button>
                       <button class="btn btn-primary" type="submit" id="save_bank_details">Pay > ${numberWithCommas($bid_details.total_amount)}</button>
                   </div> 
                </form>
            {else /} *}
                <div class="mb-4">
                    <div class="col-sm-12 pl-0">
                        <button type="button" class="btn btn-primary" style="width: 180px;">Stripe</button>
                        <button type="button" class="btn btn-primary" style="width: 180px;" disabled>Escrow</button>
                    </div>
                </div>

                <form id='payment-form' class="pp-form" data-parsley-validate novalidate>
                    <div class="col-sm-12 form-group">
                        <label class="sf-label">Card Holder Name</label>
                        <input class="form-control" name="c_name" id="c_name" placeholder="Card Holder Name" required data-parsley-trigger="change" />
                    </div>
                    <div class="col-sm-12 form-group">
                        <label class="sf-label">Card details</label>
                        <div id="card-element"></div>
                    </div>
                    <div class="col-sm-12">
                        <label class="sf-label width-170">Amount: </label>
                        <span>${numberWithCommas($bid_details.amount)}</span>
                    </div>
                    <div class="col-sm-12">
                        <label class="sf-label width-170">Shipping Charge: </label>
                        <span>${numberWithCommas($bid_details.shipping_amount)}</span>
                    </div>
                    <div class="col-sm-12">
                        <label class="sf-label width-170">Transaction fee ({$bid_details.transaction_fee_per}%): </label>
                        <span>${$bid_details.transaction_fee}</span>
                    </div>
                    <div class="col-sm-12">
                        <label class="sf-label width-170">Total Amount: </label>
                        <span>${numberWithCommas($bid_details.total_amount)}</span>
                    </div>
                    <div class="col-sm-12 form-group text-right">
                        <i class="fa fa-spinner fa-spin" style="display: none;" id="c_loader"></i>
                        <button class="btn btn-brown" type="submit" id="c_submit_button">Pay > ${numberWithCommas($bid_details.total_amount)}</button>
                    </div>
                </form>
            {* {/if} *}
           </div>

         </div>
    </div>
</section>

<script>
       $(document).ready(function (e) {
           console.log('called1')
            $(document).keypress(function (e) {
                if (e.which == 13) {
                    console.log('called')
                    if ($("#ps-success").css("display") == "block") {
                        $("#ps-success").modal('hide')
                    }
                }
            });
        });
    
</script>

<div class="modal fade hb-modal" id="ps-success" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                
                {* <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button> *}
            </div>
            <div class="modal-body"> 
                <h4 class="text-center">PAYMENT HAS BEEN SUCCESFULLY DONE !</h4> 
                <div class="lsc-msg">
                    <img src="./images/payment-success.png" alt="user">
                </div>
                <div class="ss-txt">TOTAL AMOUNT PAID</div>
                <div class="ss-txt1" id="paid_amount_div">
                    $3450.00
                </div>
                <button class="btn btn-prev" data-dismiss="modal" onclick="gotoTransaction()">
                    THANK YOU
                </button>
            </div> 
        </div>
    </div>
</div>

{include file="/common/footer-1.tpl" nocache}

<script language="javascript" type="text/javascript">
    var product_id = '{$product_id}';
    var invoice_id = '{$invoice_id}';
    var amount = +'{$bid_details.total_amount}';

    $(document).ready(function() {
        $('#phone').mask('+1 (000) 000-0000');

        /* $(document).on('change', '#choose_account', function() {
            var bank_id = +$(this).val();
            if(bank_id) {
                $("#bank_id").val(bank_id);
                var Obj = {
                    id: bank_id
                };
                $.ajax({
                    type: "POST",
                    url: "{$config.url}/get_bank_details",
                    data: Obj,
                    dataType: 'json',
                    success: function (data) {
                        console.log('data', data);
                        if (data.status == 200) {
                            var result = data.result;
                            $("#swift_code").val(result.swift_code);
                            $("#account_name").val(result.account_name);
                            $("#account_number").val(result.account_number);
                            $("#routing_number").val(result.routing_number);
                            $("#city").val(result.city);
                            $("#state").val(result.state);
                            $("#country").val(result.country);
                            $("#phone").val(result.phone);
                            $("#remmitance_information").val(result.remmitance_information);
                            $('#bank_details_form input, #bank_details_form select').each(function(){
                                $(this).trigger('change');
                            });
                        }
                    }
                });

            } else {
                resetBank();
            }
        });
        $(document).on('click', '#add_more_bank', function() {
            $('#choose_account').val("").trigger("change");
        });

        $('body').on('submit', '#bank_details_form', function (e) {
            e.preventDefault();
            $("#save_bank_details").attr('disabled', 'disabled');
            if($('#bank_details_form').parsley().validate()) {
                var formArr = $("#bank_details_form").serializeArray();
                var Obj = {};
                if (formArr.length) {
                    for (var index = 0; index < formArr.length; index++) {
                        const element = formArr[index];
                        Obj[formArr[index].name] = formArr[index].value;
                    }
                }
                $.ajax({
                    type: "POST",
                    url: "{$config.url}/add_edit_bank_details",
                    data: Obj,
                    dataType: 'json',
                    success: function (data) {
                        if (data.status == 200) {
                            make_transaction(data.bank_id);
                        } else {
                            $("#save_bank_details").attr('disabled', false);
                            swal({
                                title: 'ERROR',
                                text: data.error,
                                type: 'error',
                            })
                        }
                    }
                });
            }
        }); */
    });

    function resetBank() {
        $("#bank_id").val(0);
        $("#swift_code").val("");
        $("#account_name").val("");
        $("#account_number").val("");
        $("#routing_number").val("");
        $("#city").val("");
        $("#state").val("");
        $("#country").val("us");
        $("#phone").val("");
        $("#remmitance_information").val("");
    }

    /* function make_transaction(bank_id) {
        var Obj = {
            product_id: product_id,
            bank_id: bank_id,
            invoice_id: invoice_id
        };
        $.ajax({
            type: "POST",
            url: "{$config.url}/product/make_transaction",
            data: Obj,
            dataType: 'json',
            success: function (data) {
                if (data.status == 200) {
                    $("#paid_amount_div").html('$'+formatMoney(amount));
                    $('#ps-success').modal('show');
                    $("#save_bank_details").attr('disabled', false);
                }
            }
        });
    } */
    function gotoTransaction() {
        window.location.href = '/transactionsInfo';
    }


// start stripe card payment
    var stripe = Stripe('pk_test_W8PptjqH7xqQ7nzRSOH7cSGN00I7E49jZ4');
    var elements = stripe.elements();
    // Set up Stripe.js and Elements to use in checkout form
    var style = {
        base: {
            color: "#32325d",
            fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
            fontSmoothing: "antialiased",
            fontSize: "16px",
            "::placeholder": {
            color: "#aab7c4"
            }
        },
        invalid: {
            color: "#fa755a",
            iconColor: "#fa755a"
        },
    };

    var cardElement = elements.create('card', {style: style});
    cardElement.mount('#card-element');


    var form = document.getElementById('payment-form');
    form.addEventListener('submit', function(event) {
        $("#c_submit_button").attr("disabled", "disabled");
        $("#c_loader").show();
        var name = $("#c_name").val();
        // We don't want to let default form submission happen here,
        // which would refresh the page.
        event.preventDefault();
        stripe.createPaymentMethod({
            type: 'card',
            card: cardElement,
            billing_details: {
                // Include any additional collected billing details.
                name: name,
            },
        }).then(stripePaymentMethodHandler);
    });
    function stripePaymentMethodHandler(result) {
        if (result.error) {
            // Show error in payment form
        } else {
            var name = $("#c_name").val();
            // Otherwise send paymentMethod.id to your server (see Step 4)
            fetch('/product/pay', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    payment_method_id: result.paymentMethod.id,
                    amount: amount,
                    name: name,
                    product_id: product_id,
                    invoice_id: invoice_id
                })
            }).then(function(result) {
                // Handle server response (see Step 4)
                result.json().then(function(json) {
                    handleServerResponse(json);
                });
            });
        }
    }

    function handleServerResponse(response) {
        if (response.success == false) {
            $("#c_submit_button").attr("disabled", false);
            $("#c_loader").hide();
            swal('ERROR', response.message, 'warning');
            // Show error from server on payment form
        } else if (response.requires_action) {
            // Use Stripe.js to handle required card action
            stripe.handleCardAction(
            response.payment_intent_client_secret
            ).then(handleStripeJsResult);
        } else {
            // Show success message
            $("#c_submit_button").attr("disabled", false);
            $("#c_loader").hide();
            //swal('SUCCESS', "Payment has been success", 'success')
             //   .then(function(value) {
             //       gotoTransaction();
             //    });
            $("#paid_amount_div").html('$'+formatMoney(amount));
            $('#ps-success').modal('show');
        }
    }
    function handleStripeJsResult(result) {
        if (result.error) {
            // Show error in payment form
        } else {
            var name = $("#c_name").val();
            // The card action has been handled
            // The PaymentIntent can be confirmed again on the server
            fetch('/product/pay', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ 
                    payment_intent_id: result.paymentIntent.id,
                    amount: amount,
                    name: name,
                    product_id: product_id,
                    invoice_id: invoice_id
                })
            }).then(function(confirmResult) {
                return confirmResult.json();
            }).then(handleServerResponse);
        }
    }
// end stripe card payment


</script>