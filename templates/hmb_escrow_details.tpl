{include file="/common/header-1.tpl" nocache}
<script src="https://js.stripe.com/v3/"></script>

<!-- <div class="clearfix auth-container" style="padding-top: 100px !important;"> -->
<section class="db-wrapper db-iwrap">
    {include file="/common/header-2.tpl" nocache}

<style>
</style>

    <div class="container">
        {* <div class="row">
            <div class="col-md-4 form-group">
                <h3 class="acc-head">
                    Add Escrow Details
                </h3>
            </div>
        </div> *}
         <div class="db-content">
            {* <div class="db-menu">
                <ul class="">
                    <li><a href='/seller/openAuction' class="">Posted Products</a></li>
                    <li><a href='/seller/soldAuction' class="active">Products Sold</a></li>
                    <li><a href='/seller/draftAuction'>Drafts</a></li>
                    <li><a href='/seller/closedAuction'>Closed Auctions</a></li> 
                </ul>
            </div> *}
            <div class="db-right-con">
                <form class="wtrans-form m-auto pp-form" id="data_form" data-parsley-validate novalidate>
                    <input type="hidden" value="{$invoice_id}" name="invoice_id" id="invoice_id">

                    <h4 class="sec-head text-center">Please choose an escrow service or provide contact details of your transaction attorney/escrow service. Your transactions details will be sent to the service of your choice after final negotiations are completed.</h4>
                    <br>
                    <h4 class="sec-head">Escrow Company</h4>
                    <hr />
                    <div class="row">
                        <div class="col-sm-12 form-group mb-2">
                            <div class="radio col-sm-4">
                                <input id="ultimate_escrow" type="radio" name="escrow_company" value="Ultimate Escrow" checked>
                                <label for="ultimate_escrow">Ultimate Escrow</label>
                            </div>
                            <div class="radio col-sm-5">
                                <input id="escrow_services" type="radio" name="escrow_company" value="EsGrow Services" disabled>
                                <label for="escrow_services">EsGrow Services</label>
                            </div>
                        </div>
                    </div>
                    {* <h4 class="sec-head">Your Attorney/Escrow - Your Choice</h4>
                    <hr /> *}
                    <div class="row">
                        <div class="col-sm-12 form-group">
                            <div class="radio col-sm-4">
                                <input id="attorney" type="radio" name="escrow_company" value="attorney">
                                <label for="attorney">Your Attorney</label>
                            </div>
                            <div class="radio col-sm-5">
                                <input id="escrow_your_choice" type="radio" name="escrow_company" value="escrow_your_choice">
                                <label for="escrow_your_choice">Escrow - Your Choice</label>
                            </div>
                        </div>
                    </div>

                    <div id="userinfo_div" style="display: none;">
                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <label class="sf-label">Full Name</label>
                                <input class="form-control" name="user_name" id="user_name" placeholder="Full Name" required data-parsley-trigger="change" value="{$bank_detail.user_name}" />
                            </div>
                            <div class="col-sm-6 form-group">
                                <label class="sf-label">Company Name</label>
                                <input class="form-control" name="user_company" id="user_company" placeholder="Company Name" required data-parsley-trigger="change" value="{$bank_detail.user_company}" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <label class="sf-label">Email</label>
                                <input class="form-control" type="email" name="user_email" id="user_email" placeholder="Email" required data-parsley-trigger="change" value="{$bank_detail.user_email}" />
                            </div>
                            <div class="col-sm-6 form-group">
                                <label class="sf-label">Phone Number</label>
                                <input class="form-control" name="user_phone" id="user_phone" placeholder="Phone Number" required data-parsley-trigger="change" value="{$bank_detail.user_phone}" />
                            </div>
                        </div>
                    </div>

                    <div id="bankinfo_div">
                        <h4 class="sec-head">BANK INFO</h4>
                        <hr />
                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <label class="sf-label">Bank Name</label>
                                <input class="form-control" name="bank_name" id="bank_name" placeholder="Bank Name" required data-parsley-trigger="change" value="{$bank_detail.bank_name}" />
                            </div>
                            <div class="col-sm-6 form-group">
                                <label class="sf-label">Name on Account</label>
                                <input class="form-control" name="account_name" id="account_name" placeholder="Name on Account" required data-parsley-trigger="change" value="{$bank_detail.account_name}" />
                            </div>
                        </div> 
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
                        <div class="cus-check form-group">
                            <input type="checkbox" name="term" id="term" required>
                            <span class="checkmark"></span> <label for="term">I attest that I am the owner and have full authorization to this bank account.</label>
                            <br>
                        <label id="checkBoxErr" class="text-danger" style="display:none">This value is required</label>
                        </div>
                    </div>
                    <div class="pp-btns-wrap">
                        <a class="btn btn-prev" href="/seller/soldAuction">CANCEL</a>
                        <button class="btn btn-primary" type="submit" id="save_button">SAVE &nbsp; <i class="fa fa-spinner fa-spin" id="save_loader" style="display: none;"></i></button>{*  data-toggle="modal" data-target="#ps-success" *}
                    </div> 
                </form>
           </div>

         </div>
    </div>
</section>

{include file="/common/footer-1.tpl" nocache}

<script language="javascript" type="text/javascript">
    var invoice_id = '{$invoice_id}';
    $(document).ready(function() {
        $('#phone').mask('+1 (000) 000-0000');

        $(document).on("change", "input[name='escrow_company']", function() {
            var val = $(this).val();
            if(val == 'attorney' || val == 'escrow_your_choice') {
                $("#bankinfo_div").hide();
                $("#userinfo_div").show();
            } else {
                $("#userinfo_div").hide();
                $("#bankinfo_div").show();
            }
        })

        $('body').on('submit', '#data_form', function (e) {
            e.preventDefault();
           $("#checkBoxErr").hide();
             

            if(!$("#term").prop('checked')) {
                $("#checkBoxErr").show()
                return false;
            }
            $("#save_button").attr('disabled', 'disabled');
            if($('#data_form').parsley().validate()) {
                $("#save_loader").show();
                var formArr = $("#data_form").serializeArray();
                var Obj = {};
                if (formArr.length) {
                    for (var index = 0; index < formArr.length; index++) {
                        const element = formArr[index];
                        Obj[formArr[index].name] = formArr[index].value;
                    }
                }
                $.ajax({
                    type: "POST",
                    url: "{$config.url}/add_edit_escrow_details",
                    data: Obj,
                    dataType: 'json',
                    success: function (data) {
                        if (data.status == 200) {
                            swal({
                                title: 'SUCCESS',
                                text: 'Saved Success',
                                type: 'success',
                            }, function() {
                                window.location.href='/seller/soldAuction';
                            })
                        } else {
                            $("#save_button").attr('disabled', false);
                            swal({
                                title: 'ERROR',
                                text: data.error,
                                type: 'error',
                            })
                        }
                        $("#save_loader").hide();
                    }
                });
            }
        });
    });
</script>