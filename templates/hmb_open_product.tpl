{include file="/common/header-1.tpl" nocache}
<style>
#share_btn_div {
    
}
#chat_message {
    width: calc(100% - 180px);
    border-radius: 0px;
}
.unread_count {
    float: right;
    background: #ff0000;
    color: #ffffff;
    padding: 5px;
    border-radius: 50%;
    font-size: 12px;
    min-width: 23px;
    text-align: center;
    position: absolute;
    right: -8px;
    top: -6px;
}
.unread_count_buyer {
    float: right;
    background: #ff0000;
    color: #ffffff;
    padding: 3px 5px;
    border-radius: 50%;
    font-size: 12px;
    min-width: 23px;
    text-align: center;
}
.product_title_as {
    width: 250px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    display: inline-block;
}
.product_duplicate_a, .product_edit_a {
    color: #5a9234 !important;
}
.product_type_offer {
    width: calc(100% - 90px) !important;
}
</style>
<!-- <div class="clearfix auth-container" style="padding-top: 100px !important;"> -->
<section class="db-wrapper db-iwrap">
    {include file="/common/header-2.tpl" nocache}
    <div class="container">
        <div class="row" style="display: inline-block; width: 100%;">
            <div class="col-sm-6 float-left">
                <h3 class="acc-head">
                    MY AUCTION (POSTED PRODUCTS)
                </h3>
            </div>
            <div class="float-right" id="share_btn_div" style="display: none;">
                <a class="social_tag" id="copy_social" title="Copy to clipboard of selected auction" onclick="copyCurrentPage()" data-toggle="tooltip"><i class="far fa-copy"></i></a>
                <input disabled id="url_input" style="position:fixed;top:-5rem;height:1px;width:10px;">
            </div>
            <div class="col-sm-5 float-right">
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
                    <li><a href='/seller/openAuction' class="active">Posted Products</a></li>
                    <li><a href='/seller/soldAuction'>Products Sold</a></li>
                    <li><a href='/seller/draftAuction'>Drafts</a></li>
                    <li><a href='/seller/closedAuction'>Closed Auctions</a></li> 
                </ul>
            </div>
            <div class="db-right-con">
                <form action="{$config.url}/seller/openAuction" method="post">
                    <div id="openProductSection">              
                        {include file="hmb_open_product_template.tpl" nocache}
                    </div>
                </form>
            </div>
         </div>
    </div>
</section> 
<!-- </div> -->
<div class="modal fade hb-modal" id="open-product-bid-history-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body bid-history-wrap"> 

                <h4 class="text-center">BID HISTORY</h4>  
                <table class="table table-hover bhis-table">
                    <thead class="d-none d-sm-block">
                        <tr>
                            <th>User Name</th>
                            <th>Date & Time</th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tbody id="open-product-bid-history-list">
                    </tbody>
                </table>
            </div> 
        </div>
    </div>
</div>

<input type="hidden" name="page" value="{$currentPage}" id="page">

<section class="search-content-wrap og-auc-wrap">
    <div class="container spl-wrap">
        <h2 class="on-ahead">ADVERTISEMENTS</h2>
        <div id="ads_list"></div>
    </div>
</section>

<div class="modal fade hb-modal" id="offer_chat_popup" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog" style="max-width: 875px;">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body"> 
                <h4 class="text-center" id="common-msg-title">Chat with Buyer</h4>
                <div class="clearfix"></div>
                <div class="float-left" id="offer_chat_user_list">
                    <i class="fa fa-spinner fa-spin"></i>
                </div>
                <div class="float-right byr-msg" id="offer_message_send_div">
                    <div class="" id="offer_chat_list">
                        <i class="fa fa-spinner fa-spin"></i>
                    </div>
                    <div class="">
                        <textarea name="chat_message" id="chat_message" class="form-control float-left mr-2" value="" required rows="1"></textarea>
                    </div>
                    <div class="">
                        <button class="btn btn-prev float-left m-0" id="send_chat_message" onclick="send_chat_message()" disabled>Send</button>
                        <button class="btn btn-primary" id="accept_offer_btn" onclick="accept_offer()">Accept</button>
                    </div>
                </div>
                <div id="offer_submit_div" class="mt-4 row" style="display: none;">

                    <div class="col-md-2 form-group">
                    </div>
                    <div class="col-md-10 form-group">
                        <div class="m-auto"><b>Buyer Id:</b> <span id="buyer_name"></span></div>
                        <div class="row">
                            <div class="col-md-9 form-group text-secondary m-0">
                                <b>Note:</b> Enter amount and send offer to buyer
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 form-group pr-0">
                                <input type="text" class="form-control onlyNumber" name="offer_amount" id="offer_amount" value="" style="border-radius: 0px;" placeholder="Enter Amount">
                            </div>
                            <div class="col-md-7 form-group pl-1">
                                <button type="button" class="btn btn-prev m-0 float-left" name="submit_offer" id="submit_offer" style="height: 38px;">Submit</button>
                                <button type="button" class="btn btn-secondary ml-1 font-weight-bold" name="cancel_offer" id="cancel_offer" style="height: 38px;" onclick="cancel_offer()">Cancel</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-3 float-left" style="margin-left: 4%; margin-right: 4%;">
                    <p class="p-0" style="text-align: justify; color: red;">
                        <b>Note: </b>Please do <b>NOT</b> share any of your contact information. This includes name, phone, URLs, social media etc. We scan and analyze messages to identify potential fraud and policy violations. Failure to follow policies may trigger the termination of your membership to HempBuyerAuction. If you need additional assistance with correspondence/questions, please email support@hempbuyer.com. Be sure to include the item id you are referring to. We are here to help and support you in your success.
                    </p>
                </div>
                {* <button class="btn btn-prev" data-dismiss="modal">
                    Send
                </button> *}
            </div>
        </div>
    </div>
</div>

<div class="modal fade hb-modal" id="change_end_date_popup" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body dp-modal"> 
                <h4 class="text-center" id="common-msg-title">Change End Date</h4>
                <div class="col-sm-12">
                    <div class="form-group" id="cd-time">
                        <input type="text" class="form-control float-left col-sm-9" name="change_end_date" id="change_end_date" value="" readonly>
                    </div>
                    <div class="form-group">
                        <button type="button" class="btn btn-prev float-left m-0" name="change_end_date_btn" id="change_end_date_btn" style="height: 38px;" onclick="changeEndDate()">Change</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{include file="/common/footer-1.tpl" nocache}

{foreach $allProducts as $key => $val}
{include file="time-loader.tpl" nocache}
{/foreach}

<script language="javascript" type="text/javascript">

    var change_product_id = 0;
    function addZero(item) {
        if(+item < 10) {
            return '0'+item
        } else {
            return item;
        }
    }
    var start_date = '';
    function openChangeEndDate(product_id, end_date, s_date) {
        start_date = new Date(s_date);
        change_product_id = product_id;
        var end_dates = new Date(end_date);
        console.log('end_dates', end_dates);
        var formated = addZero(end_dates.getMonth()+1) + '-' + addZero(end_dates.getDate()) + '-' + end_dates.getFullYear() + ' ' + addZero(end_dates.getHours()) + ':' + addZero(end_dates.getMinutes());
        console.log('formated', formated);
        $("#change_end_date_popup").modal();
        setTimeout(function(){ 
            $('#change_end_date').val(formated);
            $('#change_end_date').datetimepicker({
                parentID: "#cd-time",
                format:'m-d-Y H:i',
                step: 5,
                onChangeDateTime:logicEnd1,
                onShow:logicEnd1,
                minDate: new Date(servertime),
                defaultTime: new Date(formated),
                autoclose: true,
                keepOpen: false
            }).on('changeDate', function(ev){
                $(this).datetimepicker('hide');
            });
        }, 100);
    }
    var logicEnd1 = function (currentDateTime) {
        console.log('currentDateTime.getDate() == servertime.getDate()', currentDateTime.getDate() == servertime.getDate());
        if (currentDateTime && currentDateTime.getDate() == servertime.getDate()) {
            this.setOptions({
                minTime: addZero(servertime.getHours()) + ':' + addZero(servertime.getMinutes()),
                minDate:new Date(servertime),
                //maxDate : new Date(start_date.getTime() +  (89 * 24 * 60 * 60 * 1000))
                maxDate : new Date(start_date.getTime() +  (30 * 24 * 60 * 60 * 1000))
            });
        } else {
            this.setOptions({
                minTime: '00:00',
                minDate:new Date(servertime),
                //maxDate : new Date(start_date.getTime() +  (89 * 24 * 60 * 60 * 1000))
                maxDate : new Date(start_date.getTime() +  (30 * 24 * 60 * 60 * 1000))
            });
        }
    };
    function changeEndDate() {
        var Obj = {
            product_id: change_product_id,
            end_date: $("#change_end_date").val()
        };
        $.ajax({
            type: "POST",
            url: "{$config.url}/product/change_product_end_date",
            data: Obj,
            success: function (data) {
                $("#change_end_date_popup").modal('hide');
                swal({
                    title: 'SUCCESS',
                    text: 'End date changed success',
                    type: 'success',
                }, function() {
                    window.location.reload();
                });
                // searchForm();
            }
        });
    }

    function duplicatePost(product_id) {
        var Obj = {
            product_id: product_id
        };
        $.ajax({
            type: "POST",
            url: "{$config.url}/make_duplicate_product",
            data: Obj,
            success: function (data) {
                swal({
                    title: 'SUCCESS',
                    text: 'Duplicate listing created in your DRAFT listing box. \nPlease refresh your page and edit/proof your new listing to publish.',
                    type: 'success',
                }, function() {
                    window.location.href = '/seller/draftAuction';
                });
                // searchForm();
            }
        });
    }
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
    var share_checked = [];
    $(document).ready(function () {
        $(document).on('change', '.share_check', function() {
            var pid = $(this).attr("id").split("share_check__")[1];
            if($(this).prop("checked")) {
                share_checked.push(pid);
            } else {
                var index = share_checked.indexOf(pid)
                share_checked.splice(index, 1);
            }
            if(share_checked.length > 0) {
                $("#share_btn_div").show();
            } else {
                $("#share_btn_div").hide();
            }
        });
    
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

        var end_date = $('#countdown_timer').attr('data-enddate');
        end_date = new Date(end_date);
        $('#countdown_timer').countdown(end_date, { elapse: false })
        .on('update.countdown', function (event) {
            var $this = $(this);
            /* if (event.elapsed) {
                $this.html(event.strftime('%DD : %HH : %MM : %SS'));
            } else { */
            $this.html(event.strftime('%DD : %HH : %MM : %SS'));
            // }
        })
        .on('finish.countdown', function (event) {
            $(this).html('Closed').addClass('text-red');

        });

        $('body').on('click', '.open-product-bid-history', function() {
            var id = $(this).attr('data-id');
            var html = '';
            $('#open-product-bid-history-modal tbody#open-product-bid-history-list').html('');
            if(id && id != "" && id != 0) {
                $.ajax({
                    type : 'POST',
                    url  : '/getDetailBidHistory',
                    data : { id : id },
                    dataType : 'json',
                    success  : function(data) {
                        if(data.data.length > 0) {
                            $.each(data.data, function(i, v) {
                                html += '<tr>';
                                html += '<td class="clearfix bh-tcon" data-label="User Name">'+v.name.substr(0, 1)+'***'+v.name.substr(v.name.length - 1)+'</td>';
                                html += '<td class="clearfix bh-tcon" data-label="Date & Time">'+v.bidPlacedAt+'</td>';
                                html += '<td class="clearfix bh-tcon" data-label="Amount">$'+parseFloat(v.amount).toFixed(2)+'</td>';
                                html += '</tr>';
                            });
                        } else
                            html = '<tr class="text-center"><td colspan="3" class="text-center ceb no-bids"><h5 class="text-center">There is no bid.</h5></td></tr>';

                        $('#open-product-bid-history-modal #open-product-bid-history-list').html(html);
                        $('#open-product-bid-history-modal').modal('show');
                    }
                });
            } else {
                html = '<tr class="text-center"><td colspan="3" class="text-center"><h5 class="text-center no-bids">There is no bid.</h5></td></tr>';
                $('#open-product-bid-history-modal #open-product-bid-history-list').html(html);
            }
        });

        searchForm();

    });

    $('body').on('change', '#sort_by', function() {
        searchForm();
    });

    function searchForm() {
        $('#openProductSection').html('');
        $.ajax({
            type : 'POST',
            url  : '/searchMyAuction',
            //data :  { page : $('#page').val(), status : "'open'" },
            data :  { page : $('#page').val(), status : "'open'", sort_by : $('#sort_by').val() },
            dataType : 'json',
            success  : function(data) {
                $('#sort_by').val($('#sort_by').val());
                $('input[name="page"]').val(1);
                $('#openProductSection').html(data.html);
                $('[data-toggle="tooltip"]').tooltip();
                if('{$chat_popup}' != '') {
                    $("#open-offered-messages_{$chat_popup}").trigger('click');
                }
            }
        });
    }

    function copyCurrentPage() {
        var urls = [];
        for(var index=0; index < share_checked.length; index++) {
            urls.push('{$config.url}/product/view/'+share_checked[index]);
        }
        urls = urls.join("<br>");

        var $temp = $("<textarea>");
        var brRegex = /<br\s*[\/]?>/gi;
        $("body").append($temp);
        $temp.val(urls.replace(brRegex, "\r\n")).select();
        document.execCommand("copy");
        $temp.remove();

        /* var copyText = document.getElementById("url_input");
        copyText.disabled = false;
        copyText.value = urls;
        copyText.select();
        // copyText.setSelectionRange(0, 99999);
        document.execCommand("copy");
        copyText.disabled = true;
        */
        var text = 'Link copied';
        $("#copy_social").attr('tooltip', text);
        $("#copy_social").attr('data-original-title', text);
        $(".tooltip-inner").html(text);
        setTimeout(function() {
            var text = "Copy to clipboard";
            $("#copy_social").attr('tooltip', text);
            $("#copy_social").attr('data-original-title', text);
            $(".tooltip-inner").html(text);
        }, 5000)
        
    }
    
    var socketCreated = [];
    var chat_product_id = 0;
    var receiver_id = 0;
    function send_chat_message() {
        var message = $("#chat_message").val();
        if(message.trim() == '') {
            $("#chat_message").focus();
            return true;
        }
        var Obj = {
            product_id: chat_product_id,
            seller_id: '{$loged.userid}',
            sender_id: '{$loged.userid}',
            receiver_id: receiver_id,
            message: message
        };
        $.ajax({
            type: "POST",
            url: "{$config.url}/product/send_offer_message",
            data: Obj,
            success: function (data) {
                if(data.success) {
                    $("#chat_message").val("");
                }
            }
        });
    }
    function accept_offer() {
        $("#offer_message_send_div").hide();
        $("#offer_chat_user_list").hide();
        $("#offer_submit_div").show();
        $("#offer_amount").focus();
    }
    function cancel_offer() {
        $("#offer_submit_div").hide();
        $("#offer_message_send_div").show();
        $("#offer_chat_user_list").show();
        $("#chat_message").focus();
    }
    function getUserChat(r_id, buyer_name) {
        $("#buyer_name").html(buyer_name);
        receiver_id = r_id;
        $(".user_item_a").removeClass("active");
        $("#chat_user__"+r_id).addClass("active");
        $("#send_chat_message").attr('disabled', false);
        console.log('$("#unread_count__"+r_id).length', $("#unread_count__"+r_id).length);
        if($("#unread_count__"+r_id).length) {
            var unread_count = +$("#unread_count__"+r_id).html();
            console.log('unread_count', unread_count);
            $("#unread_count__"+r_id).remove();
            var total_u = +$("#unread_count_p__"+chat_product_id).html();
            console.log('total_u', total_u);
            if(unread_count) {
                var final_u = total_u-unread_count;
                $("#unread_count_p__"+chat_product_id).html(total_u-unread_count);
                if(final_u < 1) {
                    $("#unread_count_p__"+chat_product_id).html("0");
                    $("#unread_count_p__"+chat_product_id).hide();
                }
            }
        }

        var Obj = {
            product_id: chat_product_id,
            receiver_id: receiver_id
        };
        $.ajax({
            type: "POST",
            url: "{$config.url}/product/get_offer_chats",
            data: Obj,
            success: function (data) {
                $("#offer_chat_list").html(data);
                setTimeout(function() {
                    $("#chat_message").focus();
                    $('#offer_chat_list').animate({
                        scrollTop: $("#offer_chat_list").offset().top * 100
                    }, 0);
                }, 100);
            }
        });

        console.log('socketCreated', socketCreated);
        var index = socketCreated.findIndex(function(item){ return +item.product_id == +chat_product_id && +item.userid == +receiver_id });
        console.log('index', index);
        if(index == -1) {
            socketCreated.push({ userid: receiver_id, product_id: +chat_product_id });
            generateSocket();
        }
    }
    function generateSocket() {
            
    }

    socket.on('offer_message', function (data) {
        console.log('data', data);
        if(chat_product_id == data.product_id &&  (receiver_id == data.receiver_id || receiver_id == data.sender_id)) {
            $(".chat_other_div").remove();
            var message = data.message.replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '<br>');
            var html = '<div class="chat_item">'
                    +'<div class="'+(data.sender_id=='{$loged.userid}' ? 'sent' : 'received') +'">'+message
                    +'<span class="text-secondary float-right font-italic mt-2">'+data.created_date+'</span></div>'
                +'</div>';
            $("#offer_chat_list").append(html);
            var offset = $("#offer_chat_list").offset().top * 100;
            $('#offer_chat_list').animate({
                scrollTop: offset
            }, 1000);
        }

        console.log('chat_product_id != data.product_id', chat_product_id != data.product_id);
        console.log('!$("#offer_chat_popup").hasClass("show")', !$("#offer_chat_popup").hasClass("show"));
        console.log('$("#unread_count_p__"+data.product_id).length', $("#unread_count_p__"+data.product_id).length);
        if((chat_product_id != data.product_id || !$("#offer_chat_popup").hasClass("show")) && $("#unread_count_p__"+data.product_id).length) {
            var unread = +$("#unread_count_p__"+data.product_id).html();
            if(unread) {
                $("#unread_count_p__"+data.product_id).html(unread+1);
            } else {
                $("#unread_count_p__"+data.product_id).html(1);
            }
            $("#unread_count_p__"+data.product_id).show();
        }
    });
    
$(document).ready(function(){
    $(document).on('click', '.open-offered-messages', function() {
        var product_id = +$(this).attr('data-id');
        var product_type = $(this).attr('data-type');
        console.log('product_type', product_type);
        if(product_type == 'offer') {
            $("#accept_offer_btn").show();
            $("#chat_message").removeClass("product_type_offer");
        } else {
            $("#accept_offer_btn").hide();
            $("#chat_message").addClass("product_type_offer");
        }
        chat_product_id = product_id;
        console.log('product_id', product_id);
        $("#offer_chat_popup").modal("show");
        $("#send_chat_message").attr('disabled', 'disabled');
        var loader = '<i class="fa fa-spinner fa-spin"></i>';
        var Obj = {
            product_id: product_id
        };
        $("#offer_chat_popup").find(".modal-body1").remove();
        $("#offer_chat_list").html("");
        $("#offer_chat_user_list").html(loader);
        $.ajax({
            type: "POST",
            url: "{$config.url}/product/get_offer_user_chats",
            data: Obj,
            success: function (data) {
                if(data.trim() != '') {
                    $("#offer_chat_popup").find(".modal-body").show();
                    $("#offer_chat_user_list").html(data);
                    console.log('$("#offer_chat_user_list").find("user_item:first-child")', $("#offer_chat_user_list").find(".user_item:first-child"));
                    setTimeout(function() {
                        var offer_buyer_id = +$("#offer_buyer_id").val();
                        if(offer_buyer_id > 0) {
                            $("#accept_offer_btn").attr("disabled", "disabled");
                        } else {
                            $("#accept_offer_btn").attr("disabled", false);
                        }
                        $("#offer_chat_user_list").find(".user_item").first().find("a").trigger("click");
                    }, 100);
                } else {
                    $("#offer_chat_popup").find(".modal-body").hide();
                    $("#offer_chat_popup").find(".modal-body").after('<div class="modal-body1 m-4">No data found</div>');
                }
            }
        });
    });
    
    $(document).on('keypress', '.onlyNumber', function(evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode != 46 && charCode > 31
        && (charCode < 48 || charCode > 57))
            return false;

        return true;
    });
    $(document).on('keypress', '#offer_amount', function(e) {
        var keycode = (e.keyCode ? e.keyCode : e.which);
        if(keycode == '13'){
            $("#submit_offer").trigger("click");
        }
    });
    $(document).on('click', '#submit_offer', function() {
        var amount = $("#offer_amount").val();
        if(amount.trim() == "") {
            $("#offer_amount").focus();
            return true;
        }

        var Obj = {
            product_id: chat_product_id,
            amount: amount,
            offer_buyer_id: receiver_id
        };
        $.ajax({
            type: "POST",
            url: "{$config.url}/product/submit_final_offer",
            data: Obj,
            success: function (data) {
                $("#accept_offer_btn").attr("disabled", "disabled");
                var msg = "Congratulation! your offer $"+amount+" is accepted and click Buy Now button to buy this auction";
                $("#chat_message").val(msg);
                send_chat_message();
                cancel_offer();
            }
        });


    });
    $(document).on('keydown', '#chat_message', function(e) {
        if (e.ctrlKey && e.keyCode == 13) {
            // Ctrl-Enter pressed
            send_chat_message();
        }
    });
    
});
</script>



<div class="modal fade hb-modal" id="relist-modal" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto"/>
                
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">
                <h4 class="text-center" id="common-msg-title"></h4>
                <form action="{$config.url}/product/relistProductToAuction" method="POST" id="RelistForm" data-parsley-validate >
                    <div class="form-group" style="margin-left: 0%;">
                        <input name="id" name="relistProjectId" id="relistProjectId" class="form-control" value="" hidden required>
                        <label style="font-weight: bold;">Please Enter New Qty:</label>
                        <input type="number" min="0" step="1" id="modalRelistInput" name="newQty" class="form-control onlyNumber" value="" required>

                        <label style="font-weight: bold;" class="mt-3">Please Enter New Start Price:</label>
                        <input type="number" min="0" step="1" id="modalPriceInput" name="startPrice" class="form-control onlyNumber" value="" required>

                        <label style="font-weight: bold;" class="mt-3">Please Enter New Reserve Price:</label>
                        <input type="number" min="0" step="1" id="modalReserverPriceInput" name="reservePrice" class="form-control onlyNumber" value="" required>

                        {* <div class="modal_buynow_div">
                            <label style="font-weight: bold;" class="mt-3">Please Enter New BuyNow Price:</label>
                            <input type="number" min="0" step="1" id="modalBuyNowPriceInput" name="buynowPrice" class="form-control onlyNumber" value="" required>

                            <label style="font-weight: bold;" class="mt-3">Please Enter New BuyNow MOQ:</label>
                            <input type="number" min="0" step="1" id="modalBuyNowMOQInput" name="buynowMoqPrice" class="form-control onlyNumber" value="" required>
                        </div> *}
                    </div>
                    <!-- <div class="ss-txt cus-check"><input type="checkbox" id="confirmationChk" class="typeCheckbox"/></div> -->
                    
                    <button type="Submit" class="btn btn-prev" id="submitRelistBtn" onclick="submitRelistForm()">
                        Relist!
                    </button>
                    </form>
            </div>
        </div>
    </div>
</div>

<script>



</script>