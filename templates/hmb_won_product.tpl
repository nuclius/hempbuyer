{include file="/common/header-1.tpl" nocache}
<style>

.auction-won {
    width: 64px;
}
.auction-won .pp-txt {
    margin:auto -35px;
}
</style>
<!-- <div class="clearfix auth-container" style="padding-top: 100px !important;"> -->
<section class="db-wrapper db-iwrap">
    {include file="/common/header-2.tpl" nocache}
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <h3 class="acc-head">
                    MY AUCTION (AUCTIONS WON)
                </h3>
            </div>
            <div class="col-sm-6">
                <div class="form-inline wt-wrap">
                    <div class="clearfix cselec-wrap">
                        <select class="custom-select" name="sort_by" id="sort_by">
                            <option value="">Sort By</option>
                            <option value="price_asc">Price: Low - High</option>
                            <option value="price_desc">Price: High - Low</option>
                            <option value="startdate_asc">Start Date: Asc - Desc</option>
                            <option value="startdate_desc">Start Date: Desc - Asc</option>
                            <option value="enddate_asc">End Date: Asc - Desc</option>
                            <option value="enddate_desc">End Date: Desc - Asc</option>
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
                    <li><a href='/buyer/activeAuction' class="">Active</a></li>
                    <li><a href='/buyer/wonAuction' class="active">Auctions Won</a></li>
                    <li><a href='/buyer/lostAuction' class="">Auctions Lost</a></li>
                    <li><a href='/buyer/buyAuction' class="">Products Purchased</a></li>
                    <li><a href='/buyer/watchlist' class="">Watchlist</a></li>
                </ul>
            </div>
            <div class="db-right-con">
                <form action="{$config.url}/buyer/wonAuction" method="post">
                    <div id="wonProductSection">
                        {include file="hmb_won_product_template.tpl" nocache}
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

<script>
       $(document).ready(function (e) {
           console.log('called1')
            $(document).keypress(function (e) {
                if (e.which == 13) {
                    console.log('called')
                    if ($("#terms-accept").css("display") == "block") {
                        $("#terms-accept").modal('hide')
                    }
 
                }
            });
        });
    
</script>
<div class="modal fade hb-modal" id="terms-accept" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"> 
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body" style="max-height: 400px; overflow: auto;">
                <h4 class="text-center">I ACCEPT TERMS & CONDITIONS</h4>
                <div class="ss-txt">
                    "By creating an account, you acknowledge reading our User Privacy Notice."Terms of Use, will be
                    pages that registrants will be shown and they will need to digitally sign or acknowledge thru
                    checking or typing a initials that they have read the terms of use in specific areas of the
                    document.
                </div>
                <div class="ss-txt">
                    "By creating an account, you acknowledge reading our User Privacy Notice."Terms of Use, will be
                    pages that registrants will be shown and they will need to digitally sign or acknowledge thru
                    checking or typing a initials that they have read the terms of use in specific areas of the
                    document.
                </div>
                <div class="ss-txt">
                    "By creating an account, you acknowledge reading our User Privacy Notice."Terms of Use, will be
                    pages that registrants will be shown and they will need to digitally sign or acknowledge thru
                    checking or typing a initials that they have read the terms of use in specific areas of the
                    document.
                </div>
                <div class="ss-txt">
                    "By creating an account, you acknowledge reading our User Privacy Notice."Terms of Use, will be
                    pages that registrants will be shown and they will need to digitally sign or acknowledge thru
                    checking or typing a initials that they have read the terms of use in specific areas of the
                    document.
                </div>
                <div class="form-group clearfix text-center m-0">
                    <div class="cus-check " style="display: inline-block;">
                        <input type="checkbox" name="terms" id="checkTermCondition" required data-parsley-required="true"
                            data-parsley-trigger="click">
                        <span class="checkmark"></span><label for="checkTermCondition">I accept Terms & Conditions</label>
                        <div class="text-danger" id="term_error"></div>
                    </div>
                    <div class="col-sm-12">
                        <button class="btn btn-prev mt-3" onclick="gotoPayNow()">PAY</button>
                    </div>
                </div>
                <!-- <button class="btn btn-prev" data-dismiss="modal">
                    THANK YOU
                </button> -->
            </div>
        </div>
    </div>
</div>

<!--  data-backdrop="static" data-keyboard="false" -->
<div class="modal fade hb-modal" id="send_message_popup" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                
                <button type="button" class="close closeMessagePopup" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">
                <h4 class="text-center">Send Message</h4>
                <form method="post" class="pp-form" id="message_form" data-parsley-validate novalidate>
                    <input type="hidden" name="m_product_id" id="m_product_id" value="">
                    <input type="hidden" name="m_seller_id" id="m_seller_id" value="">
                    <input type="hidden" name="m_seller_email" id="m_seller_email" value="">
                    <input type="hidden" name="m_seller_name" id="m_seller_name" value="">
                    <!-- <input type="hidden" name="dis" id="dis" value="">
                    <span name="dis" id="dis"></span> -->
                    <div class="row">
                        <div class="col-sm-12">
                            <label>Subject</label>
                            <input type="text" class="form-control" id="m_subject" name="m_subject" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <label>Message</label>
                            <textarea class="form-control" id="m_message" name="m_message" required></textarea>
                        </div>
                    </div>
                    <div class="row">&nbsp;</div>
                    <div class="row">
                        <div class="col-sm-12">
                            <button class="btn btn-primary float-right">Send</button>
                        </div>
                    </div>
                    
                </form>
                <div class="row">
                        <div class="col-sm-12" style="text-align: justify;">
                            <i style="color: red;"><b>Note: </b>If you are a buyer do NOT include your contact info or
                                ask for the seller’s contact info. We scan and analyze messages to identify potential
                                fraud and policy violations. Failure to follow policies may trigger the termination of
                                your membership to HempBuyerAuction.</i>
                        </div>
                    </div>
            </div>
        </div>
    </div>
</div>

{include file="/common/hmb_send_feedback_popup.tpl" nocache}
{include file="/common/hmb_view_feedback_popup.tpl" nocache}
{include file="/common/hmb_view_escrow_details_popup.tpl" nocache}
{include file="/common/hmb_add_escrow_transaction_id_popup.tpl" nocache}

{include file="/common/footer-1.tpl" nocache}

<script language="javascript" type="text/javascript">
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
    var product_id = 0;
    var invoice_id = 0;
    function openTermPopup(p_id, b_id) {
        product_id = p_id;
        invoice_id = b_id;
        $("#terms-accept").modal();
    }
    function gotoPayNow() {
        if($("#checkTermCondition").prop('checked')) {
            window.location.href = '{$config.url}/paymentInfo?id='+product_id+'&invoice_id='+invoice_id;
        } else {
            $("#term_error").html("Please check term & condition.");
        }
    }
    $(document).on('change', '#checkTermCondition', function() {
        $("#term_error").html("");
    });

    $(document).ready(function () {
        $('#carousel').flexslider({
            animation: "slide",
            controlNav: false,
            animationLoop: false,
            slideshow: false,
            itemWidth: 70,
            itemMargin: 10,
            asNavFor: '#slider'
        });

        $('#slider').flexslider({
            animation: "slide",
            controlNav: false,
            animationLoop: false,
            slideshow: false,
            sync: "#carousel"
        });

        searchForm();
    });

    $('body').on('change', '#sort_by', function() {
        searchForm();
    });

    function searchForm() {
        $('#wonProductSection').html('');
        $.ajax({
            type : 'POST',
            url  : '/buyerSearchWonAuctionPage',
            //data :  { page : $('#page').val(), status : "'open'" },
            data :  { page : $('#page').val(), status : "'won'", sort_by : $('#sort_by').val() },
            dataType : 'json',
            success  : function(data) {
                $('#sort_by').val($('#sort_by').val());
                $('input[name="page"]').val(1);
                $('#wonProductSection').html(data.html);
            }
        });
    }

    function openMessagePopup(id, seller_id, seller_email, seller_name, dis) {
        $("#m_product_id").val(id);
        $("#m_seller_id").val(seller_id);
        $("#m_seller_email").val(seller_email);
        $("#m_seller_name").val(seller_name);
    }

    $(document).on('submit', '#message_form', function (e) {
        e.preventDefault();
        if ($('#message_form').parsley().validate()) {
            var formArr = $(this).serializeArray();
            var obj = {};
            if (formArr.length) {
                for (var index = 0; index < formArr.length; index++) {
                    const element = formArr[index];
                    obj[formArr[index].name] = formArr[index].value;
                }
            }
            $.ajax({
                type: 'POST',
                url: '/sendMessage',
                data: obj,
                dataType: 'json',
                success: function (data) {
                    $("#send_message_popup").modal('hide');
                    swal('Message send successfully');
                    setTimeout(function () {
                        window.location.reload();
                    }, 1000);
                }
            });
        }
    });
</script>