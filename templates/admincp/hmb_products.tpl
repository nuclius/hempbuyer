{include file="/admincp/header.tpl" nocache}
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<style>
.xdsoft_datetimepicker {
	z-index: 999999 !important;
}
</style>
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}jquery.datetimepicker.css" />
	<div class="container-fluid">
		<!-- Page Heading -->
		<div class="row">
			<div class="col-lg-12" style="margin-top:2%;">
				<ol class="breadcrumb">
					<li class="active">
						Products <i class="fa fa-angle-double-right"></i> Product List
					</li>
				</ol>
			</div>
		</div>
		<!-- /.row -->
		<div class="row">
			<div class="col-sm-12">
				<form id="product_search_form" enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" >
					<input type="hidden" name="page" id="page" value="1">
					<input type="hidden" name="action" id="action" value="{$action}">
					<input type="hidden" name="limit" id="limit" value="10">
					<div class="row">
						<div class="col-xs-6 col-sm-4 col-md-3 form-group"> 
								<label>Start {$phrases.from_date}</label>
								<input class="form-control" value="{$search.start_from_date}" placeholder="Select Start From Date" name="start_from_date" id="start_date1" class="date_picker" autocomplete="off"> 
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 form-group">
								<label>Start {$phrases.to_date}</label>
								<input class="form-control" value="{$search.start_to_date}" placeholder="Select Start To Date" name="start_to_date" id="start_date2" class="date_picker" autocomplete="off"> 
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 form-group">
								<label>End {$phrases.from_date}</label>
								<input class="form-control" value="{$search.end_from_date}" placeholder="Select End From Date" name="end_from_date" id="end_date1" class="date_picker" autocomplete="off"> 
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 form-group"> 
							<label>End {$phrases.to_date}</label>
							<input class="form-control" value="{$search.end_to_date}" placeholder="Select End To Date" name="end_to_date" id="end_date2" class="date_picker" autocomplete="off">
						</div>	 
					   <div class="col-xs-6 col-sm-4 col-md-3 form-group">
								<label>Product Title</label>
								<input class="form-control" placeholder="Title" value="{$search.title}" name="title"> 
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
								<label>{$phrases.type}</label>
								<select class="form-control" name="type">
									<option value="" {if $search.type==''} selected {/if}>All</option>
									<option value="fixed" {if $val.type=='fixed'}selected{/if}>Fixed</option>
	                                <option value="auction" {if $val.type=='auction'}selected{/if}>Auction</option>
									<option value="offer" {if $val.type=='offer'}selected{/if}>Offer</option>
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
		<div id="list_div"></div>
	</div>
</div>

<div class="modal fade hb-modal" id="featured_popup" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Select date to save Featured Auction</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="f_close_btn">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">
				<form id="save_featured_form" enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" >
					<input type="hidden" name="f_product_id" id="f_product_id" value="0">
					<div class="row">
						<div class="col-sm-6 form-group"> 
								<label>Start Date</label>
								<input class="form-control" value="" placeholder="Select Start Date" name="f_start_date" id="f_start_date" class="date_picker" autocomplete="off" required data-parsley-trigger="change">
						</div>
						<div class="col-sm-6 form-group">
								<label>End Date</label>
								<input class="form-control" value="" placeholder="Select End Date" name="f_end_date" id="f_end_date" class="date_picker" autocomplete="off" required data-parsley-trigger="change"> 
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<button type="submit" class="btn btn-prev pull-right m-0" id="thankYou">
								Save
							</button>
						</div>
					</div>
				</form>
            </div>
        </div>
    </div>
</div>

{include file="/admincp/footer.tpl" nocache}
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>

<script language="javascript" type="text/javascript">
	var action = '{$action}';
	$(document).ready(function() {
		$('#start_date1, #start_date2, #end_date1, #end_date2').datetimepicker({
			timepicker:false,
			format:'Y-m-d'
		});
		var logicStart = function (currentDateTime) {
            $('#f_end_date').val('');
            if (currentDateTime.getDate() == servertime.getDate()) {
                this.setOptions({
                    minTime: addZero(servertime.getHours()) + ':' + addZero(servertime.getMinutes()),
                    maxDate:$('#f_end_date').val()? new Date($('#f_end_date').val()):false
                });
            } else {
                this.setOptions({
                    minTime: '00:00',
                    maxDate:$('#f_end_date').val()? new Date($('#f_end_date').val()):false
                });
            }
        };
        var logicEnd = function (currentDateTime) {
            var buyNowChecks = $('#auction_check').is(":checked");
            var fixedPriceChecks = $('#fp-price_check').is(":checked");
            var setMaxEndDate = 89;
            if(buyNowChecks)
                setMaxEndDate = 9;

            if(fixedPriceChecks)
                setMaxEndDate = 29;

            var startDate = $('#f_start_date').val() ? new Date($('#f_start_date').val()) : new Date();
            if (currentDateTime && currentDateTime.getDate() == servertime.getDate()) {
                this.setOptions({
                    minTime: addZero(servertime.getHours()) + ':' + addZero(servertime.getMinutes()),
                    minDate:$('#f_start_date').val()? new Date($('#f_start_date').val()):false,
                    //maxDate : new Date(startDate.getTime() +  (89 * 24 * 60 * 60 * 1000))
                    maxDate : new Date(startDate.getTime() +  (setMaxEndDate * 24 * 60 * 60 * 1000))
                });
            } else {
                this.setOptions({
                    minTime: '00:00',
                    minDate:$('#f_start_date').val()? new Date($('#f_start_date').val()):false,
                    //maxDate : new Date(startDate.getTime() +  (89 * 24 * 60 * 60 * 1000))
                    maxDate : new Date(startDate.getTime() +  (setMaxEndDate * 24 * 60 * 60 * 1000))
                });
            }
        };
        $('#f_start_date').datetimepicker({
            format:'Y-m-d H:i',
            step: 5,
            onChangeDateTime:logicStart,
            onShow:logicStart,
            minDate:new Date()
        });

        $('#f_end_date').datetimepicker({
            format:'Y-m-d H:i',
            step: 5,
            onChangeDateTime:logicEnd,
            onShow:logicEnd,
            maxDate: new Date()
        });

		$(document).on("click", "#f_close_btn", function() {
				var product_id = $("#f_product_id").val();
				$("#is_featured__"+product_id).prop('checked', false);
		});

		$(document).on("change", ".is_featured", function() {
			var product_id = $(this).attr("id").split("__")[1];
			var end_date = $(this).attr("data-enddate");
			var checked = $(this).prop("checked");
			if(checked) {
				$('#f_start_date').val("");
				$('#f_end_date').val("");
				$("#f_product_id").val(product_id);

				// $('#f_end_date').datetimepicker({
				// 	format:'Y-m-d H:i',
				// 	step: 5,
				// 	// onChangeDateTime:logicEnd,
				// 	// onShow:logicEnd,
				// 	minDate: new Date(),
				// 	maxDate: new Date(end_date)
				// });
				$("#featured_popup").modal();
			} else {
				var Obj = {
					id: product_id,
					is_featured: 0
				};
				changeFeaturedStatus(Obj);
			}
			return true;
		});
		
		$(document).on("submit", "#save_featured_form", function(e) {
			e.preventDefault();

			var product_id = $("#f_product_id").val();
			var start_date = $("#f_start_date").val();
			var end_date = $("#f_end_date").val();
			var Obj = {
				id: product_id,
				start_date: start_date,
				end_date: end_date,
				is_featured: 1
			};
			changeFeaturedStatus(Obj);
		});

		getProducts();
	});
	function changeFeaturedStatus(Obj) {
		$.ajax({
			type: 'POST',
			url: '/admincp/update_isfeatured',
			data: Obj,
			// dataType: 'json',
			success: function(data) {
				if(data.success) {
					$("#featured_popup").modal('hide');
					if($("#is_featured__"+Obj['id']).prop('checked')) {
						$("#f_product_id").val(0);
						$("#f_start_date").val("");
						$("#f_end_date").val("");
						swal("SUCCESS", "Added in featured auction");
					} else {
						swal("SUCCESS", "Removed from featured auction");
					}
				}
			}
		});
	}
	$(document).on('submit', '#product_search_form', function(e) {
		e.preventDefault();
		$('#page').val(1);
		paginationData.currentPage=1;
		getProducts();
	});

	function getProducts() {
		var formArray = $("#product_search_form").serializeArray();
		var Obj = {};
		var productData = formArray ? formArray : [];
		if(productData.length) {
			for (var index = 0; index < productData.length; index++) {
				const element = productData[index];
				Obj[productData[index].name] = productData[index].value;
			}
		}
		$.ajax({
			type: 'POST',
			url: '/admincp/products/'+action,
			data: Obj,
			// dataType: 'json',
			success: function(data) {
				$("#list_div").html(data);
				$("#pagination_html").html(pagination(paginationData));
			}
		});
	}
</script>