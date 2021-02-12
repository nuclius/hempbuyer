{include file="/admincp/header.tpl" nocache}
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<style>
.fa-spinner {
	margin-left: 100px;
}
#main_div {
	background: #ffffff;
	display: inline-block;
    width: 100%;
	box-shadow: 0px 0px 2px 2px #ddd;
}
#product_list {
	width: 220px;
    float: left;
	border-right: 1px solid #e2e2e2;
    height: 65vh;
	overflow: auto;
}
#product_list .offer_product_item {
	display: inline-block;
    width: 100%;
    padding: 8px;
    border-bottom: 1px solid #e2e2e2;
	cursor: pointer;
	text-decoration: none;
	transition: all 0.2s ease;
}
#product_list .offer_product_item.active, #product_list .offer_product_item:hover {
	background: #5e9836;
    color: #fff;
}
#product_list .offer_product_item .product_title {
	line-height: 23px;
}
#product_list .offer_product_item .unread_count {
	float: right;
    background: #ff0000;
    color: #ffffff;
    padding: 3px 5px;
    border-radius: 50%;
    font-size: 12px;
    min-width: 23px;
    text-align: center;
}

#buyer_list {
	width: 220px;
    float: left;
	border-right: 1px solid #e2e2e2;
    height: 65vh;
	overflow: auto;
}
#buyer_list .offer_buyer_item {
	display: inline-block;
    width: 100%;
    padding: 8px;
    border-bottom: 1px solid #e2e2e2;
	cursor: pointer;
	text-decoration: none;
	transition: all 0.2s ease;
	float: left;
}
#buyer_list .offer_buyer_item.active, #buyer_list .offer_buyer_item:hover {
		background: #5e9836;
    color: #fff;
}
#buyer_list .offer_buyer_item .buyer_email {
    float: left;
    font-size: 12px;
}
#buyer_list .offer_buyer_item .unread_count {
	float: right;
    background: #ff0000;
    color: #ffffff;
    padding: 3px 5px;
    border-radius: 50%;
    font-size: 12px;
    min-width: 23px;
    text-align: center;
}
#offer_chat_list {
	width: calc(100% - 440px);
}
.text-secondary {
	color: grey;
}
.float-right {
	float: right !important;
}
.float-left {
	float: left !important;
}
#offer_chat_list .chat_item div {
	white-space: unset !important;
}
#offer_chat_list .chat_item div .msg {
	white-space: pre-line;
}
#offer_chat_list {
	height: 65vh;
    overflow: auto;
    margin: 0;
    float: left;
}
</style>
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}jquery.datetimepicker.css" />
	<div class="container-fluid">
		<!-- Page Heading -->
		{* <div class="row">
			<div class="col-lg-12" style="margin-top:2%;">
				<ol class="breadcrumb">
					<li class="active">
						Products <i class="fa fa-angle-double-right"></i> Offer Products
					</li>
				</ol>
			</div>
		</div> *}
		<!-- /.row -->
		<div class="row">
			<div class="col-sm-12">
				<form id="product_search_form" enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" >
					<input type="hidden" name="page" id="page" value="1">
					<input type="hidden" name="action" id="action" value="{$action}">
					<input type="hidden" name="limit" id="limit" value="10">
					<div class="row">
						<div class="col-xs-6 col-sm-4 col-md-3 form-group">
							<label>Seller</label>
							<select class="form-control" name="seller_id">
								<option value="">All</option>
								{foreach $sellerList as $key => $val}
	                            	<option value="{$val.id}">{$val.name} ({$val.email})</option>
								{/foreach}
							</select> 
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 form-group">
							<label>{$phrases.status}</label>
							<select class="form-control" name="market_status">
								<option value="" {if $search.market_status==''} selected {/if}>All</option>
								<option value="open" {if $val.market_status=='open'}selected{/if}>Open</option>
	                            <option value="closed" {if $val.market_status=='closed'}selected{/if}>Closed</option>
	                            <option value="sold" {if $val.market_status=='sold'}selected{/if}>Sold</option> 
							</select> 
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 form-group">
							<label>Type</label>
							<select class="form-control" name="product_type">
								<option value="">All</option>
								<option value="offer">Offer</option>
	                            <option value="fixed">Fixed</option>
	                            <option value="auction">Auction</option> 
							</select> 
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 form-group">
							<label style="visibility: hidden;">Height adjust</label>
							<div>
								<button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$phrases.search}</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		{if $error != ''}
			<div class="alert alert-danger"><strong>{$error}</strong></div>
		{/if}
		<div id="main_div">
			<div style="text-align: center; background: #5e9836; display: inline-block; width: 100%; color: #fff;">
				<div style="width: 220px; float: left; border-right: 1px solid #bbb; padding: 9px 0px;">Product Title</div>
				<div style="width: 220px; float: left; border-right: 1px solid #bbb; padding: 9px 0px;">Buyers</div>
				<div style="width: calc(100% - 440px);; float: left; padding: 9px 0px;">Chat</div>
			</div>
			<div id="product_list">
			</div>
			<div id="buyer_list">
			</div>
			<div id="offer_chat_list">
			</div>
		</div>
	</div>
</div>

{include file="/admincp/footer.tpl" nocache}
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>

<script language="javascript" type="text/javascript">
	var product_id = 0;
	var buyer_id = 0;
	$(document).ready(function() {

		$(document).on('submit', '#product_search_form', function(e) {
			e.preventDefault();
			get_offer_product_list()
		});

		$(document).on('click', '.offer_product_item', function(e) {
			e.preventDefault();
			product_id = $(this).attr("id").split("productid_")[1];
			buyer_id = 0;
			
			$('.offer_product_item').removeClass("active");
			$(this).addClass("active");
			get_offer_product_buyer_list();
		});
		$(document).on('click', '.offer_buyer_item', function(e) {
			e.preventDefault();
			buyer_id = $(this).attr("id").split("buyerid_")[1];
			
			$('.offer_buyer_item').removeClass("active");
			$(this).addClass("active");
			get_offer_product_chat_list();
		});

		get_offer_product_list()
	});

	function get_offer_product_list() {

		var formArray = []
        for (let index = 1; index <= 4; index++) {
            var formArr = $("#product_search_form").serializeArray();
            formArray = formArray.concat(formArr);
        }
        var productObj = {};
        if(formArray.length) {
            for (var index = 0; index < formArray.length; index++) {
                const element = formArray[index];
                productObj[formArray[index].name] = formArray[index].value;
            }
        }

		$("#buyer_list").html("");
		$("#offer_chat_list").html("");
		$("#product_list").html('<i class="fa fa-spinner fa-spin"></i>');
        $.ajax({
            type: "POST",
            url: "{$config.url}/admincp/get_offer_product_list",
            data: productObj,
            success: function (data) {
				$("#product_list").html(data);
				// $("#chat_message").val("");
				var total_products = +$("#product_length").val();
				console.log('total_products', total_products);
				if(total_products > 0) {
					$(".offer_product_item").first().trigger("click");
				}
            }
        });
	}
	function get_offer_product_buyer_list() {

        var productObj = {
			product_id: product_id
		};

		$("#offer_chat_list").html("");
		$("#buyer_list").html('<i class="fa fa-spinner fa-spin"></i>');
        $.ajax({
            type: "POST",
            url: "{$config.url}/admincp/get_offer_buyer_list",
            data: productObj,
            success: function (data) {
				$("#buyer_list").html(data);
				var buyer_length = +$("#buyer_length").val();
				console.log('buyer_length', buyer_length);
				if(buyer_length > 0) {
					// $(".offer_buyer_item").first().trigger("click");
				}
            }
        });
	}
	function get_offer_product_chat_list() {

        var productObj = {
			product_id: product_id,
			buyer_id: buyer_id
		};

		$("#offer_chat_list").html('<i class="fa fa-spinner fa-spin"></i>');
        $.ajax({
            type: "POST",
            url: "{$config.url}/admincp/get_offer_product_chat_list",
            data: productObj,
            success: function (data) {
				$("#offer_chat_list").html(data);
				var unread = +$("#unread_buyer_count_"+buyer_id).html();
				if(unread > 0) {
					var prod_unread = $("#unread_product_count_"+product_id).html();
					var final_unread = prod_unread-unread;
					if(final_unread > 0) {
						$("#unread_product_count_"+product_id).html(final_unread);
					} else {
						$("#unread_product_count_"+product_id).remove();
					}
					$("#unread_buyer_count_"+buyer_id).remove();
				}
				setTimeout(function() {
                    $("#chat_message").focus();
                    $('#offer_chat_list').animate({
                        scrollTop: $("#offer_chat_list").offset().top * 100
                    }, 0);
                }, 100);
            }
        });
	}

</script>