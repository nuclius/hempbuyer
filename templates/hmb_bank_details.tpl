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
                    Bank Details
                </h3>
            </div>
            {* <div class="col-md-8 form-group">
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
            </div> *}
        </div>
         <div class="db-content">
            <div class="db-menu">
                <ul class="">
                    <li><a href="/profileInfo" class="">Profile Info</a></li>
                    <li><a href="/passwordInfo" class="">Change Password</a></li>
                    <li><a href="/paymentInfo" class="">Payment</a></li>
                    <li><a href="/transactionsInfo" class="">Transactions</a></li> 
                    <li><a href="/bank_list" class="active">Bank Details</a></li> 
                </ul>
            </div>
            <div class="db-right-con">
                <form class="wtrans-form pp-form" id="bank_details_form" style="max-width: unset;" data-parsley-validate novalidate>
                    <input type="hidden" value="{$bank_detail.id}" name="bank_id" id="bank_id">
                    {if $bank_detail.id}
                        <input type="hidden" value="{$bank_detail.stripe_account_id}" name="account_id" id="account_id">
                    {/if}
                   <h4 class="sec-head">BANK INFO</h4>
                   <input type="hidden" name="swift_code" id="swift_code" placeholder="Bank Swift Code" value="{$bank_detail.swift_code}" />
                   {* <div class="row">
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">Bank Swift Code</label>
                           <input class="form-control" name="swift_code" id="swift_code" placeholder="Bank Swift Code" required data-parsley-trigger="change" value="{$bank_detail.swift_code}" />
                       </div> 
                   </div> *}
                   <h4 class="sec-head">ACCOUNT HOLDER INFO</h4>
                   <div class="row">
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">Account Number</label>
                           <input class="form-control" name="account_number" id="account_number" placeholder="Account Number" required data-parsley-trigger="change" value="{$bank_detail.account_number}" />
                       </div>
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">Confirm Account Number</label>
                           <input class="form-control" name="account_number1" id="account_number1" placeholder="Confirm Account Number" required data-parsley-trigger="change" value="{$bank_detail.account_number}" data-parsley-equalto="#account_number" data-parsley-equalto-message="Account Number do not match." />
                       </div>
                   </div>
                   <div class="row">
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">Routing Number</label>
                           <input class="form-control" name="routing_number" id="routing_number" placeholder="Routing Number" required data-parsley-trigger="change" value="{$bank_detail.routing_number}" />
                       </div>
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">Confirm Routing Number</label>
                           <input class="form-control" name="routing_number1" id="routing_number1" placeholder="Confirm Routing Number" required data-parsley-trigger="change" value="{$bank_detail.routing_number}" data-parsley-equalto="#routing_number" data-parsley-equalto-message="Routing Number do not match." />
                       </div>
                   </div>
                   <div class="row">
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">Name on Account</label>
                           <input class="form-control" name="account_name" id="account_name" placeholder="Name on Account" required data-parsley-trigger="change" value="{$bank_detail.account_name}" />
                       </div>
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">City</label> 
                           <input class="form-control" name="city" id="city" placeholder="City" required data-parsley-trigger="change" value="{$bank_detail.city}" />
                       </div>
                   </div> 
                   <div class="row"> 
                       <div class="col-sm-6 form-group">
                           <label class="sf-label">State</label> 
                           <div class="clearfix cselec-wrap">
                               <select class="custom-select" name="state" id="state" required data-parsley-trigger="change">
                                    <option value="">Select State</option>
                                    {foreach $states as $key => $val}
                                        <option value="{$val.abbrev}" {if $bank_detail.state == $val.abbrev}selected{/if}>{$val.name}</option>
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
                           <input class="form-control" name="phone" id="phone" placeholder="Phone Number" required data-parsley-trigger="change" value="{$bank_detail.phone}" />
                       </div>
                       <div class="col-sm-6 form-group" style="display: none;">
                           <label class="sf-label">Remmitance Information</label>
                           <input class="form-control" name="remmitance_information" id="remmitance_information" placeholder="Remmitance Information" required data-parsley-trigger="change" value="{$bank_detail.remmitance_information}" />
                       </div>
                   </div> 
                   <div class="cus-check form-group">
                       <input type="checkbox" name="term" id="term" data-parsley-checkmin="1">
                       <span class="checkmark"></span> <label for="term">I attest that I am the owner and have full authorization to this bank account.</label>
                       <br>
                       <label id="checkBoxErr" class="text-danger" style="display:none">This value is required</label>
                   </div>
                   <div class="pp-btns-wrap">
                       <a class="btn btn-prev" href="/bank_list">CANCEL</a>
                       <button class="btn btn-primary" type="submit" id="save_bank_details">SAVE &nbsp; <i class="fa fa-spinner fa-spin" id="add_bank_loader" style="display: none;"></i></button>{*  data-toggle="modal" data-target="#ps-success" *}
                   </div> 
                </form>
           </div>

         </div>
    </div>
</section>

{include file="/common/footer-1.tpl" nocache}

<script language="javascript" type="text/javascript">
    var product_id = '{$product_id}';
    var buynow_id = '{$buynow_id}';
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
        }); */

        $(document).on('change', '#add_more_bank', function() {
            if(!$(this).prop("chacked")) {
                $("#save_bank_details").attr('disabled', 'disabled');
            } else {
                $("#save_bank_details").attr('disabled', false);
            }
        });
        $('body').on('submit', '#bank_details_form', function (e) {
            e.preventDefault();
            $("#checkBoxErr").hide();
             

            if(!$("#term").prop('checked')) {
                $("#checkBoxErr").show()
                return false;
            }
            $("#save_bank_details").attr('disabled', 'disabled');
            if($('#bank_details_form').parsley().validate()) {
                $("#add_bank_loader").show();
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
                            swal({
                                title: 'SUCCESS',
                                text: 'Bank detail saved',
                                type: 'success',
                            }, function() {
                                window.location.href='/bank_list';
                            })
                            resetBank();
                        } else {
                            $("#save_bank_details").attr('disabled', false);
                            swal({
                                title: 'ERROR',
                                text: data.error,
                                type: 'error',
                            })
                        }
                        $("#add_bank_loader").hide();
                    }
                });
            }
        });
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


</script>