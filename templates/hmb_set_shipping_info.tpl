{include file="/common/header-1.tpl" nocache}

<!-- <div class="clearfix auth-container" style="padding-top: 100px !important;"> -->
<section class="db-wrapper db-iwrap">
    {include file="/common/header-2.tpl" nocache}
    <style>
    .cselec-wrap {
        background: #ffffff;
    }
    </style>
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <h3 class="acc-head">
                    Set Shipping Address
                </h3>
            </div> 
        </div>
        <div class="row col-sm-12">
            <div class="radio">
                <input type="radio" class="shipping_type" name="shipping_type" id="shipping_type1" value="1" {if $shipping_list.length < 1}disabled{/if}> <label for="shipping_type1">Select From list</label>
            </div>
            <div class="radio">
                <input type="radio" class="shipping_type" name="shipping_type" id="shipping_type2" value="2" checked> <label for="shipping_type2">Add new address</label>
            </div>
        </div>
        <div class="db-content">
            <div class="db-right-con">

                <form class="pp-form shipping_form" data-parsley-validate novalidate id="edit_new_form">
                    <div class="row" id="shipping_id_div" style="display: none;">
                        <div class="col-md-12 form-group">
                            <label class="sf-label">Select Address</label>
                            <div class="clearfix cselec-wrap">
                                <select class="custom-select" name="shipping_id" id="shipping_id">
                                    {foreach $shipping_list as $key => $val}
                                        <option value="{$val.id}">{$val.name} ({$val.email})</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label class="sf-label">Name</label>
                            <div class="icon-input">
                                <div class="icon-box">
                                    <img src="images/user.png" alt="" />
                                </div>
                                <input class="form-control" data-field="name" name="name" id="name" value="" placeholder="Name" required />
                            </div>                                    
                        </div>
                        <div class="col-md-6 form-group">
                            <label class="sf-label">Email</label>
                            <div class="icon-input">
                                <div class="icon-box">
                                    <img src="images/email.png" alt="" />
                                </div>
                                <input type="email" class="form-control" data-field="email" name="email" id="email" value="" placeholder="Email" required />
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label class="sf-label">Phone Number</label>
                            <div class="icon-input">
                                <div class="icon-box">
                                    <img src="images/flag.png" alt="" />
                                </div>
                                <input class="form-control phone_us" data-field="phone" name="phone" id="phone" value="" placeholder="Phone Number" required parsley-type="phone" data-parsley-trigger="change" data-parsley-minlength="17" data-parsley-minlength-message="Phone number is invalid." />
                            </div>
                        </div>
                        <div class="col-md-6 form-group">
                            <label class="sf-label">Street Address</label>
                            <div class="icon-input">
                                <div class="icon-box">
                                    <img src="images/marker.png" alt="" />
                                </div>
                                <input class="form-control" data-field="address" name="address" id="address" value="" placeholder="Street Address" required />
                            </div>
                        </div>
                    </div>
                        
                    <div class="row"> 
                        <div class="col-md-6 form-group">
                            <label class="sf-label">City</label>
                            <div class="icon-input">
                                <div class="icon-box">
                                    <img src="images/marker.png" alt="" />
                                </div>
                                <input class="form-control" data-field="city" name="city" id="city" value="" placeholder="City" required />
                            </div>
                        </div>
                        <div class="col-md-6 form-group">
                            <label class="sf-label">State</label>
                            <div class="clearfix cselec-wrap">
                                <select class="custom-select loc-selc" data-field="state" name="state" id="state" required>
                                    <option value="">Select State</option>
                                    {foreach $state_list as $key => $val}
                                        <option value="{$val.abbrev}">{$val.name} </option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row"> 
                        <div class="col-md-6 form-group">
                            <label class="sf-label">Country</label>
                            <div class="clearfix cselec-wrap">
                                <select class="custom-select loc-selc" data-field="country" name="country" id="country" required>
                                    <option value='United States' selected>United States</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6 form-group">
                            <label class="sf-label">Zipcode</label>
                            <div class="icon-input">
                                <div class="icon-box">
                                    <img src="images/marker.png" alt="" />
                                </div>
                                <input class="form-control" data-field="zipcode" name="zipcode" id="zipcode" placeholder="Zipcode" value="" required />
                            </div>
                        </div>
                    </div>
                    <div class="row"> 
                        <div class="col-md-12 form-group">
                            <label class="sf-label">Delivery Instruction</label>
                            <div class="icon-input">
                                <div class="icon-box">
                                    <img src="images/user.png" alt="" />
                                </div>
                                <textarea class="form-control" data-field="delivery_instruction" id="delivery_instruction" name="delivery_instruction" value="" placeholder="Delivery Instruction" required row="3"></textarea>
                            </div>
                        </div>
                    </div>
                        
                    <div class="pt-3">
                        <button class="btn btn-brown btn-lg save_add_new_form" type="submit">SET</button>
                        <span id="userInfoError" style="text-align: center; color: red;"></span>
                    </div>
                </form>

            </div>
        </div>
    </div>
</section>

<div class="modal fade hb-modal" id="shipping-success" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"> 
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body"> 
                <h4 class="text-center">Shipping address set successfully</h4>
                <div class="lsc-msg">
                    <img src="./images/user-icon.png" alt="user">
                </div>
                <!-- <div class="ss-txt">
                    YOU HAVE BEEN SUCCESSFULLY UPDATED
                </div> -->
                <button class="btn btn-prev" type="button" id="close_modal" class="close" data-dismiss="modal" aria-hidden="true">
                    THANK YOU
                </button>
            </div> 
        </div>
    </div>
</div>
<script>
       $(document).ready(function (e) {
           console.log('called1')
            $(document).keypress(function (e) {
                if (e.which == 13) {
                    console.log('called')
                    if ($("#shipping-success").css("display") == "block") {
                        $("#shipping-success").modal('hide')
                    }
 
                }
            });
        });
    
</script>

{include file="/common/footer-1.tpl" nocache}

<script language="javascript" type="text/javascript">
    var product_id = '{$product_id}';
    var invoice_id = '{$invoice_id}';

    $(document).ready(function() {
        var shipping_list = '{$shipping_list_json}';
        shipping_list = shipping_list.replace(/\\n/g, "\\n")  
               .replace(/\\'/g, "\\'")
               .replace(/\\"/g, '\\"')
               .replace(/\\&/g, "\\&")
               .replace(/\\r/g, "\\r")
               .replace(/\\t/g, "\\t")
               .replace(/\\b/g, "\\b")
               .replace(/\\f/g, "\\f");
        // remove non-printable and other non-valid JSON chars
        shipping_list = shipping_list.replace(/[\u0000-\u0019]+/g,""); 
        shipping_list = JSON.parse(shipping_list);
        if(shipping_list.length) {
            $("#shipping_id").val(shipping_list[0].id).trigger('change');
        }
        $('.phone_us').mask('+1 (000) 000-0000');

        $(document).on('change', '.shipping_type', function(){
            var val = $(this).val();
            console.log('val', val);
            if(val == 1) {
                if(shipping_list.length) {
                    $("#shipping_id").val(shipping_list[0].id).trigger('change');
                }
                $("#shipping_id_div").show();
                $("#shipping_id").trigger('change');
                $("#edit_new_form input").attr('readonly', 'readonly');
                $("#country #state").attr('disabled', 'disabled');
            } else {
                $("#shipping_id_div").hide();
                $("#shipping_id").val("");
                $("#edit_new_form input").attr('readonly', false);
                $("#country #state").attr('disabled', false);
                resetForm();
            }
        });
        $(document).on('change', '#shipping_id', function() {
            var shipping_id = $(this).val();
            console.log('shipping_id', shipping_id);
            var index = shipping_list.findIndex(function(item) { return item.id == shipping_id; });
            if(index > -1) {
                var shipping_data = shipping_list[index];
                console.log('shipping_data', shipping_data);
                $("#name").val(shipping_data.name);
                $("#email").val(shipping_data.email);
                $("#address").val(shipping_data.address);
                $("#country").val(shipping_data.country);
                $("#zipcode").val(shipping_data.zipcode);
                $("#city").val(shipping_data.city);
                $("#state").val(shipping_data.state);
                $("#phone").val(shipping_data.phone);
                $("#delivery_instruction").val(shipping_data.delivery_instruction);
            } else {
                resetForm();
            }
        });
        $(document).on("submit", ".shipping_form", function(e) {
            e.preventDefault();
            if($("#shipping_type1").prop("checked")) {
                var shipping_id = $("#shipping_id").val();
                set_shipping_id(shipping_id);
            } else {
                $("#shipping_id").val(0);
                var formArr = $(this).serializeArray();
                var Obj = {};
                if(formArr.length) {
                    for (var index = 0; index < formArr.length; index++) {
                        const element = formArr[index];
                        Obj[formArr[index].name] = formArr[index].value;
                    }
                }
                $.ajax({
                    type: "POST",
                    url: "{$config.url}/user/set_shipping_info",
                    data: Obj,
                    dataType: 'json',
                    success: function (data) {
                        if(data.success) {
                            set_shipping_id(data.result.insertId);
                        }
                    }
                });
            }

        });

        $(document).on('click', '#close_modal', function() {
            window.history.back();
        });

    });

    function resetForm() {
        $("#name").val("");
        $("#email").val("");
        $("#address").val("");
        $("#zipcode").val("");
        $("#city").val("");
        $("#state").val("");
        $("#phone").val("");
        $("#delivery_instruction").val("");
    }
    function set_shipping_id(shipping_id) {
        console.log('shipping_id', shipping_id);
        var Obj = {
            shipping_id: shipping_id,
            product_id: product_id,
            invoice_id: invoice_id
        };
        $.ajax({
            type: "POST",
            url: "{$config.url}/product/set_shipping_id",
            data: Obj,
            dataType: 'json',
            success: function (data) {
                if(data.success) {
                    $("#shipping-success").modal();
                }
            }
        });
    }
</script>