{include file="/common/header-1.tpl" nocache}

<!-- <div class="clearfix auth-container" style="padding-top: 100px !important;"> -->
<section class="db-wrapper db-iwrap">
    {include file="/common/header-2.tpl" nocache}
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <h3 class="acc-head">
                    MY AUCTION (PRODUCTS SOLD)
                </h3>
            </div>
            <div class="col-sm-6">
                <div class="form-inline wt-wrap">
                    <div class="clearfix cselec-wrap">
                        <select class="custom-select" name="sort_by" id="sort_by">
                            <option value="">Sort By</option>
                            <option value="price_asc">Price: Low - High</option>
                            <option value="price_desc">Price: High - Low</option>
                            <option value="qty_asc">Qty: Asc - Desc</option>
                            <option value="qty_desc">Qty: Desc - Asc</option>
                            <option value="date_asc">Date: Asc - Desc</option>
                            <option value="date_desc">Date: Desc - Asc</option>
                            <option value="id_asc">Oldest</option>
                            <option value="id_desc" selected>Newest</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
         <div class="db-content">
            <div class="db-menu">
                <ul class="">
                    <li><a href='/seller/openAuction' class="">Posted Products</a></li>
                    <li><a href='/seller/soldAuction' class="active">Products Sold</a></li>
                    <li><a href='/seller/draftAuction'>Drafts</a></li>
                    <li><a href='/seller/closedAuction'>Closed Auctions</a></li> 
                </ul>
            </div>
            <div class="db-right-con">
                <form action="{$config.url}/seller/soldAuction" method="post">
                    <div id="soldProductSection">              
                        {include file="hmb_sold_product_template.tpl" nocache}
                    </div>
                </form>
            </div>
         </div>
    </div>
</section> 
<input type="hidden" name="page" value="{$currentPage}" id="page">

<section class="search-content-wrap og-auc-wrap">
    <div class="container spl-wrap">
        <h2 class="on-ahead">ADVERTISEMENTS</h2>
        <div id="ads_list"></div>
    </div>
</section>

<div class="modal fade hb-modal" id="shipping_amount_popup" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" /> 
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">
                <h4 class="text-center" id="common-msg-title">Set Shipping Amount</h4>
                <div class="col-sm-12">
                    <div class="form-group">
                        <label id="shipping_address_label"></label>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control float-left col-sm-9 numberOnly" name="shipping_amount" id="shipping_amount" value="">
                    </div>
                    <div class="form-group">
                        <button type="button" class="btn btn-prev float-left m-0" name="shipping_amount_btn" id="shipping_amount_btn" style="height: 38px;">Set</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{include file="/common/footer-1.tpl" nocache}

{include file="/common/hmb_send_feedback_popup.tpl" nocache}
{include file="/common/hmb_view_feedback_popup.tpl" nocache}

<div class="modal fade hb-modal" id="shipping-success" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" /> 
                {* <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button> *}
            </div>
            <div class="modal-body">  
                <h4 class="text-center">Shipping Amount set successfully</h4>
                <div class="lsc-msg">
                    <img src="{$config.url}/images/user-icon.png" alt="user">
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
<script language="javascript" type="text/javascript">
    var invoice_id = 0;
    getAds();
    function getAds() {
        var Obj = {
            page: 'dashboard'
        };
        $.ajax({
            type: "POST",
            url: "{$config.url}/get_ads",
            data: Obj,
            success: function (data) {
                $("#ads_list").html(data)
            }
        });
    }
    $(document).ready(function () {
        searchForm();

        $(document).on("click", "#shipping_amount_btn", function() {
            var shipping_amount = $("#shipping_amount").val();
            $.ajax({
                type : 'POST',
                url  : '/product/set_shipping_amount',
                data :  {
                    invoice_id, invoice_id,
                    shipping_amount: shipping_amount
                },
                dataType : 'json',
                success  : function(data) {
                    if(data.success) {
                        $("#shipping_amount_popup").modal('hide');
                        setTimeout(function() {
                            $("#shipping-success").modal();
                        }, 100);
                    }
                }
            });
        });
        $(document).on('click', '#close_modal', function() {
            window.location.reload();
        });
    });

    $('body').on('change', '#sort_by', function() {
        searchForm();
    });

    function searchForm() {
        $('#soldProductSection').html('');
        $.ajax({
            type : 'POST',
            url  : '/searchAuctionPage',
            data :  { page : $('#page').val(), status : "'sold'", sort_by : $('#sort_by').val() },
            dataType : 'json',
            success  : function(data) {
                $('#sort_by').val($('#sort_by').val());
                $('input[name="page"]').val(1);
                $('#soldProductSection').html(data.html);
            }
        });
    }
    function set_shipping_amount(b_id, shipping_id) {
        invoice_id = b_id;
        $("#shipping_amount_popup").modal();
        $.ajax({
            type : 'POST',
            url  : '/user/get_shipping_details',
            data :  { id: shipping_id },
            dataType : 'json',
            success  : function(data) {
                if(data.success) {
                    console.log('data', data);
                    var html = '<b>Address:</b> ' + data.result.address + ', ' + data.result.city + ', ' + data.result.state + ', ' + data.result.country + ', ' + data.result.zipcode;
                    $("#shipping_address_label").html(html);
                }
            }
        });
    }
    function confirm_payment(escrow_transaction_id, invoice_id, product_id) {
        swal({
            title: "Are you sure?",
            text: "You got payment",
            type: "info",
            confirmButtonClass: "btn-primary",
            cancelButtonClass: "btn-danger",
            confirmButtonText: "Yes",
            cancelButtonText: "No",
            showCancelButton: true,
            closeOnConfirm: false,
            showLoaderOnConfirm: true
        }, function (result) {
            if(result) {
                var Obj = {
                    invoice_id: invoice_id,
                    status: 'paid'
                };
                $.ajax({
                    type: "POST",
                    url: "{$config.url}/update_invoice_status",
                    data: Obj,
                    dataType: 'json',
                    success: function (data) {
                        if (data.status == 200) {
                            swal({
                                title: "Payment Confirmed",
                            }, function (result) {
                                window.location.href="/invoice/"+invoice_id;
                            });
                        }
                    }
                });
            }
        });
    }

</script>