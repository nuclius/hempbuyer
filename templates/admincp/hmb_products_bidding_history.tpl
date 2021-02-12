{include file="/admincp/header.tpl" nocache}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}jquery.datetimepicker.css" />
	<div class="container-fluid">
		<!-- Page Heading -->
		<div class="row">
			<div class="col-lg-12" style="margin-top:2%;">
				<ol class="breadcrumb">
					<li class="active">
						{if $id=="" || $id=="0"}
						Bidding List
						{else/}
						Products <i class="fa fa-angle-double-right"></i> Bidding List
						{/if}
					</li>
				</ol>
			</div>
		</div>
		<!-- /.row -->
		<form id="product_bid_search_form" enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" >
					<input type="hidden" name="page" id="page" value="1">
					<input type="hidden" name="productId" id="productId" value="{$id}">
					<input type="hidden" name="limit" id="limit" value="10">
					{if $id=="" || $id=='0'}
						<div class="row">
							<div class="col-xs-6 col-sm-4 col-md-2">
								<div class="form-group">
									<label>Start {$phrases.from_date}</label>
									<input class="form-control" value="{$search.start_from_date}" placeholder="Select Start From Date" name="start_from_date" id="start_date1" class="date_picker" autocomplete="off">
								</div>
							</div>
							<div class="col-xs-6 col-sm-4 col-md-2">
								<div class="form-group">
									<label>Start {$phrases.to_date}</label>
									<input class="form-control" value="{$search.start_to_date}" placeholder="Select Start To Date" name="start_to_date" id="start_date2" class="date_picker" autocomplete="off">
								</div>
							</div>
							<div class="col-xs-6 col-sm-4 col-md-2">
								<div class="form-group">
									<label>End {$phrases.from_date}</label>
									<input class="form-control" value="{$search.end_from_date}" placeholder="Select End From Date" name="end_from_date" id="end_date1" class="date_picker" autocomplete="off">
								</div>
							</div>
							<div class="col-xs-6 col-sm-4 col-md-2">
								<div class="form-group">
									<label>End {$phrases.to_date}</label>
									<input class="form-control" value="{$search.end_to_date}" placeholder="Select End To Date" name="end_to_date" id="end_date2" class="date_picker" autocomplete="off">
								</div>
							</div>
							<div class="col-xs-6 col-sm-4 col-md-2">
								<div class="form-group">
									<label>Product Title</label>
									<input class="form-control" placeholder="Title" value="{$search.title}" name="title">
								</div>
							</div>
						</div>
					{/if}

					<div class="row">
						{if $id=="" || $id=='0'}
						<div class="col-xs-6 col-sm-4 col-md-2">
							<div class="form-group">
								<label>{$phrases.status}</label>
								<select class="form-control" name="market_status">
									<option value="" {if $search.market_status==''} selected {/if}>All</option>
									<option value="open" {if $val.market_status=='open'}selected{/if}>Open</option>
	                                <option value="closed" {if $val.market_status=='closed'}selected{/if}>Closed</option>
	                                <option value="sold" {if $val.market_status=='sold'}selected{/if}>Sold</option>
	                                <option value="draft" {if $val.market_status=='draft'}selected{/if}>Draft</option>
								</select>
							</div>
						</div>
						<div class="col-xs-6 col-sm-4 col-md-2">
							<div class="form-group">
								<label>{$phrases.type}</label>
								<select class="form-control" name="type">
									<option value="" {if $search.type==''} selected {/if}>All</option>
									<option value="fixed" {if $val.type=='fixed'}selected{/if}>Fixed</option>
	                                <option value="auction" {if $val.type=='auction'}selected{/if}>Auction</option>
								</select>
							</div>
						</div>
						{/if}

						<div class="col-xs-6 col-sm-4 col-md-2">
							<div class="form-group">
								<label>Bid {$phrases.from_date}</label>
								<input class="form-control" value="{$search.bid_from_date}" placeholder="Select Bid From Date" name="bid_from_date" id="start_date3" class="date_picker" autocomplete="off">
							</div>
						</div>
						<div class="col-xs-6 col-sm-4 col-md-2">
							<div class="form-group">
								<label>Bid {$phrases.to_date}</label>
								<input class="form-control" value="{$search.bid_to_date}" placeholder="Select Bid To Date" name="bid_to_date" id="end_date3" class="date_picker" autocomplete="off">
							</div>
						</div> 
						<div class="col-xs-6 col-sm-4 col-md-2">
							<div class="form-group">
								<label>Bid Awarded</label>
								<select class="form-control" name="bid_awarded">
									<option value="" {if $search.purchase_type==''} selected {/if}>All</option>
									<option value="0" {if $val.purchase_type=='Buy'}selected{/if}>Not Awarded</option>
	                                <option value="1" {if $val.purchase_type=='Auction'}selected{/if}>Awarded</option>
								</select>
							</div>
						</div>

						<div class="col-xs-6 col-sm-4 col-md-2">
							<label style="visibility: hidden;">Height adjust</label>
							<div class="form-group">
								<button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$phrases.search}</button>
							</div>
						</div>
					</div>
				</form>
		{if $error != ''}
			<div class="alert alert-danger"><strong>{$error}</strong></div>
		{/if}
		<div id="list_div"></div>
	</div>
</div>
{include file="/admincp/footer.tpl" nocache}
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>

<script language="javascript" type="text/javascript">
	$(document).ready(function() {
		$('#start_date1, #start_date2, #start_date3, #end_date1, #end_date2, #end_date3').datetimepicker({
			timepicker:false,
			format:'Y-m-d'
		});
		getProductsBiddingHistory();
	});

	$(document).on('submit', '#product_bid_search_form', function(e) {
		e.preventDefault();
		$('#page').val(1);
		paginationData.currentPage=1;
		getProductsBiddingHistory();
	});

	function getProductsBiddingHistory() {
		var formArray = $("#product_bid_search_form").serializeArray();
		var Obj = {};
		var productData = formArray ? formArray : [];
		if(productData.length) {
			for (var index = 0; index < productData.length; index++) {
				const element = productData[index];
				Obj[productData[index].name] = productData[index].value;
			}
		}
		/*var productId = $('#productId').val();
		var ajaxUrl = '/admincp/productPurchaseHistory';
		if(productId && productId != "" && productId != "0")
			ajaxUrl = '/admincp/productPurchaseHistory';*/

		$.ajax({
			type: 'POST',
			url: '/admincp/productBiddingHistory',
			data: Obj,
			// dataType: 'json',
			success: function(data) {
				$("#list_div").html(data);
				$("#pagination_html").html(pagination(paginationData));
			}
		});
	}
</script>