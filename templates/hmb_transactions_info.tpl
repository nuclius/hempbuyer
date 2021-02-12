{include file="/common/header-1.tpl" nocache}

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
        figure {
            margin: 5px 0 5px;
        }
        .product_title {
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap!important;
        }
    </style>
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <h3 class="acc-head">
                    TRANSACTIONS
                </h3>
            </div>
        </div>
         <div class="db-content">
            <div class="db-menu">
                <ul class="">
                    <li><a href="/profileInfo" class="">Profile Info</a></li>
                    <li><a href="/passwordInfo" class="">Change Password</a></li>
                    <li><a href="/paymentInfo" class="">Payment</a></li>
                    <li><a href="/transactionsInfo" class="active">Transactions</a></li> 
                    <li><a href="/bank_list" class="">Bank Details</a></li> 
                </ul>
            </div>
            <form id="transaction_list_form">
                <input type="hidden" id="page" name="page" value="1">
                <input type="hidden" id="limit" name="limit" value="10">
            </form>

            

            <div class="db-right-con transactions-wrap">
                <div class="bhis-box header">
                    <div class="row">
                        <div class="col-3">
                            Product Title
                        </div>
                        <div class="col-2 p-0">
                            Payment Method
                        </div>
                        <div class="col-2">
                            Total Amount
                        </div>
                        <div class="col-2">
                            Status
                        </div>
                        <div class="col-3">
                            Action
                        </div>
                    </div>
                </div>
                <div id="list_div">
                    
                    <nav class="text-right">
                        <ul class="pagination"> 
                            <li class="page-item active"><a href="#" class="page-link">01</a></li>
                            <li class="page-item"><a href="#" class="page-link">02</a></li>
                            <li class="page-item"><a href="#" class="page-link">03</a></li>
                            <li class="page-item"><a href="#" class="page-link">04</a></li>
                            <li class="page-item"><a href="#" class="page-link">05</a></li>
                            <li class="page-item"><a href="#" class="page-link">...</a></li>
                            <li class="page-item"><a href="#" class="page-link">99</a></li>
                        </ul>
                    </nav>
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
		var formArray = $("#transaction_list_form").serializeArray();
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
			url: '/transaction_list/'+action,
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
</script>