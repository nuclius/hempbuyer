{include file="/common/header-1.tpl" nocache}
<script src="https://js.stripe.com/v3/"></script>

<!-- <div class="clearfix auth-container" style="padding-top: 100px !important;"> -->
<section class="db-wrapper db-iwrap">
    {include file="/common/header-2.tpl" nocache}

    <div class="container">
        <div class="row">
            <div class="col-md-4 form-group">
                <h3 class="acc-head">
                    Bank List
                </h3>
            </div>
            <div class="col-md-8 form-group">
                <div class="wt-wrap pay-acc">
                    <a class="btn btn-prev float-right" href="/bank">ADD BANK</a>
                </div>
            </div>
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
            <form id="list_form">
                <input type="hidden" id="page" name="page" value="1">
                <input type="hidden" id="limit" name="limit" value="10">
            </form>
            <div class="db-right-con transactions-wrap">
                <div id="list_div" style="margin-bottom: 30px;">
                </div>
            </div>
<br>
<br>

         </div>
    </div>
</section>

{include file="/common/footer-1.tpl" nocache}

<script language="javascript" type="text/javascript">
	var action = '';
    var config_url = '{$config.url}';

    $(document).ready(function() {
        getList();
    });

	function getList() {
		var formArray = $("#list_form").serializeArray();
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
			url: '/bank_list/'+action,
			data: Obj,
			// dataType: 'json',
			success: function(data) {
                $("#list_div").html(data);
                paginationData.recordPerPage = $("#limit").val();
                console.log('pagination(paginationData)', pagination(paginationData));
				$("#pagination_html").html(pagination(paginationData));
			}
		});
	}
    function set_primary_bank(bank_id) {
        var Obj = {
            id: bank_id
        };
        $.ajax({
			type: 'POST',
			url: '/set_primary_bank',
			data: Obj,
			// dataType: 'json',
			success: function(data) {
                swal({
                    title: 'SUCCESS',
                    text: 'Primary bank account changed',
                    type: 'success'
                });
                getList();
			}
		});
    }
    function delete_bank(bank_id) {
        var Obj = {
            id: bank_id
        };
        $.ajax({
			type: 'POST',
			url: '/delete_bank',
			data: Obj,
			// dataType: 'json',
			success: function(data) {
                swal({
                    title: 'SUCCESS',
                    text: 'Account deleted',
                    type: 'success'
                });
                getList();
			}
		});
    }
</script>