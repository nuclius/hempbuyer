
{include file="/admincp/header.tpl" nocache}
<style media="screen">
    .hidetd {
        display: none !important;
    }
</style>
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active"> Store Subscription</li>
            </ol>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="h4">
                Subscription List : &nbsp;&nbsp;
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#add_sub">
                    Add Subscription
                </button>
                <span type="button" class="pull-right">
                    Free Subscription :
                    <button type="button" class="btn btn-default" data-toggle="modal" data-target="#free_sub">
                        <span class="glyphicon glyphicon-pencil"></span>
                    </button>
                </span>
            </div>
            <div class="table_div">
                <table id="mytable" class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Amount</th>
                            <th>Store</th>
                            <th>Product</th>
                            <th>Category</th>
                            <th>Plan ID</th>
                            <th>Status</th>
                            <th>Action</th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                            <th class="hidetd"></th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $getSub as $key => $val}
                        <tr class="co_datas">
                            <td attr-getval="title">{$val.title}</td>
                            <td>{$val.amount}</td>
                            <td attr-getval="store">{$val.store}</td>
                            <td attr-getval="product">{$val.product}</td>
                            <td attr-getval="category">{$val.category}</td>
                            <td attr-getval="plan_id">{$val.plan_id}</td>
                            <td attr-getval="status">{$val.status}</td>

                            <td class="hidetd" attr-getval="desc">{$val.description}</td>
                            <td class="hidetd" attr-getval="online">{$val.online}</td>
                            <td class="hidetd" attr-getval="inperson">{$val.in_person}</td>
                            <td class="hidetd" attr-getval="live_auction">{$val.live_auction}</td>
                            <td class="hidetd" attr-getval="storage">{$val.file_storage}</td>
                            <td class="hidetd" attr-getval="storagetype">{$val.storage_type}</td>
                            <td class="hidetd" attr-getval="ship_station">{$val.ship_station_cost}</td>
                            <td class="hidetd" attr-getval="shipping_label">{$val.shipping_label}</td>
                            <td class="hidetd" attr-getval="support">{$val.hr_support}</td>
                            <td class="hidetd" attr-getval="fraud_analysis">{$val.fraud_analysis}</td>
                            <td class="hidetd" attr-getval="order_creation">{$val.manual_order_creation}</td>
                            <td class="hidetd" attr-getval="discount">{$val.discount_code}</td>
                            <td class="hidetd" attr-getval="website_blog">{$val.website_blog}</td>
                            <td class="hidetd" attr-getval="ssl">{$val.free_ssl}</td>
                            <td class="hidetd" attr-getval="gift_card">{$val.gift_card}</td>
                            <td class="hidetd" attr-getval="pro_reports">{$val.professinal_reports}</td>
                            <td class="hidetd" attr-getval="cart_recovery">{$val.cart_recovery}</td>
                            <td class="hidetd" attr-getval="report_builder">{$val.report_builder}</td>
                            <td class="hidetd" attr-getval="shipping_rates">{$val.shipping_rate_calc}</td>
                            <td class="hidetd" attr-getval="customization_hours">{$val.customization_hours}</td>
                            <td class="hidetd" attr-getval="add_coding">{$val.additional_coding}</td>
                            <td class="text-center">
                                <button class='btn btn-default btn-xs edit_sub' value="{$val.id}">
                                    <span class="glyphicon glyphicon-pencil"></span>
                                </button>
                                <button class='btn btn-default btn-xs' onclick="location.href='{$config.url}/admincp/deleteStoreSub/{$val.id}';">
                                    <span class="glyphicon glyphicon-trash"></span>
                                </button>
                            </td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="modal fade" id="add_sub" role="dialog">
        <div class="modal-dialog" style="width:90%">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Subscription</h4>
                </div>
                <div class="modal-body row">
                    <form id="addEditSubscription" method="post">
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label >Title: </label>
                                <div>
                                    <input type="text" class="form-control" name="title" attr-check="title">
                                    <span class="err err_title"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Description: </label>
                                <div >
                                    <input type="text" class="form-control" name="description" attr-check="desc">
                                    <span class="err err_desc"></span>
                                </div>
                            </div>
                            <!-- <div class="form-group">
                                <label>Amount: </label>
                                <div >
                                    <input type="text" class="form-control" name="amount" attr-check="amount" onkeypress="isNumber(event,this)">
                                    <span class="err err_amount"></span>
                                </div>
                            </div> -->
                            <div class="form-group">
                                <label>Online: (In precentage)</label>
                                <div >
                                    <input type="text" class="form-control" name="online" attr-check="online" onkeypress="isNumber(event,this)">
                                    <span class="err err_online"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>In person:  (In precentage)</label>
                                <div >
                                    <input type="text" class="form-control" name="inperson" attr-check="in_person" onkeypress="isNumber(event,this)">
                                    <span class="err err_in_person"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>No of Stores: </label>
                                <div >
                                    <input type="text" class="form-control" name="store" attr-check="store" onkeypress="isNumber(event,this)">
                                    <span class="err err_store"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>No of Products: </label>
                                <div >
                                    <input type="text" class="form-control" name="product" attr-check="product" onkeypress="isNumber(event,this)">
                                    <span class="err err_product"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>No of Categories: </label>
                                <div >
                                    <input type="text" class="form-control" name="category" attr-check="category" onkeypress="isNumber(event,this)">
                                    <span class="err err_category"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>No of Live Auction: </label>
                                <div >
                                    <input type="text" class="form-control" name="liveauction" attr-check="live_auction" onkeypress="isNumber(event,this)">
                                    <span class="err err_live_auction"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="title col-md-12">File storage: </label>
                                <div >
                                    <input type="text" style="width:70%;display: inline;" class="form-control" name="filestorage" attr-check="storage" onkeypress="isNumber(event,this)">
                                    <select type="text" class="form-control" style="width:20%;display: inline;" name="storagetype" value="mb" attr-check="storagetype">
                                        <option value="mb">MB</option>
                                        <option value="gb">GB</option>
                                        <option value="unlimited">Unlimited</option>
                                    </select>
                                    <span class="err err_storage" style="width:70%;"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label>Ship Station Integrated for weight 1 pound: </label>
                                <div >
                                    <input type="text" class="form-control" name="shipstation" attr-check="ship_station">
                                    <span class="err err_ship_station"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Print shipping labels: </label>
                                <div >
                                    <select class="form-control" name="shippinglabel" attr-check="shipping_label">
                                        <option value="">--SELECT--</option>
                                        <option value="no">No</option>
                                        <option value="yes">Yes</option>
                                    </select>
                                    <span class="err err_shipping_label"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>24/7 support: </label>
                                <div >
                                    <select  class="form-control" name="support" attr-check="support">
                                        <option value="">--SELECT--</option>
                                        <option value="no">No</option>
                                        <option value="yes">Yes</option>
                                    </select>
                                    <span class="err err_support"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Fraud analysis: </label>
                                <div >
                                    <select  class="form-control" name="fraudanalysis" attr-check="fraud_analysis">
                                        <option value="">--SELECT--</option>
                                        <option value="no">No</option>
                                        <option value="yes">Yes</option>
                                    </select>
                                    <span class="err err_fraud_analysis"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Manual order creation: </label>
                                <div >
                                    <select  class="form-control" name="ordercreation" attr-check="order_creation">
                                        <option value="">--SELECT--</option>
                                        <option value="no">No</option>
                                        <option value="yes">Yes</option>
                                    </select>
                                    <span class="err err_order_creation"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Discount codes: </label>
                                <div >
                                    <select  class="form-control" name="discount" attr-check="discount">
                                        <option value="">--SELECT--</option>
                                        <option value="no">No</option>
                                        <option value="yes">Yes</option>
                                    </select>
                                    <span class="err err_discount"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Website and blog: </label>
                                <div >
                                    <select  class="form-control" name="websiteblog" attr-check="website_blog">
                                        <option value="">--SELECT--</option>
                                        <option value="no">No</option>
                                        <option value="yes">Yes</option>
                                    </select>
                                    <span class="err err_website_blog"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Free SSL certificate: </label>
                                <div >
                                    <select  class="form-control" name="ssl" attr-check="ssl">
                                        <option value="">--SELECT--</option>
                                        <option value="no">No</option>
                                        <option value="yes">Yes</option>
                                    </select>
                                    <span class="err err_ssl"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label>Gift cards: </label>
                                <div >
                                    <select  class="form-control" name="giftcard" attr-check="gift_card">
                                        <option value="">--SELECT--</option>
                                        <option value="no">No</option>
                                        <option value="yes">Yes</option>
                                    </select>
                                    <span class="err err_gift_card"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Professional reports: </label>
                                <div >
                                    <select  class="form-control" name="proreports" attr-check="pro_reports">
                                        <option value="">--SELECT--</option>
                                        <option value="no">No</option>
                                        <option value="yes">Yes</option>
                                    </select>
                                    <span class="err err_pro_reports"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Abandoned cart recovery: </label>
                                <div >
                                    <select  class="form-control" name="cartrecovery" attr-check="cart_recovery">
                                        <option value="">--SELECT--</option>
                                        <option value="no">No</option>
                                        <option value="yes">Yes</option>
                                    </select>
                                    <span class="err err_cart_recovery"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Advanced report builder: </label>
                                <div >
                                    <select  class="form-control" name="reportbuilder" attr-check="report_builder">
                                        <option value="">--SELECT--</option>
                                        <option value="no">No</option>
                                        <option value="yes">Yes</option>
                                    </select>
                                    <span class="err err_report_builder"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Third-party calculated shipping rates: </label>
                                <div >
                                    <select  class="form-control" name="shippingrates" attr-check="shipping_rates">
                                        <option value="">--SELECT--</option>
                                        <option value="no">No</option>
                                        <option value="yes">Yes</option>
                                    </select>
                                    <span class="err err_shipping_rates"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Customization Hours: </label>
                                <div >
                                    <input type="text" class="form-control" name="customizationhours" attr-check="customization_hours">
                                    <span class="err err_customization_hours"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Status: </label>
                                <div >
                                    <select  class="form-control" name="status" attr-check="status">
                                        <option value="active">Active</option>
                                        <option value="inactive">Inactive</option>
                                    </select>
                                    <span class="err err_status"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Braintree Plan Id: </label>
                                <div >
                                    <input type="text" class="form-control" name="planid" attr-check="plan_id">
                                    <span class="err err_plan_id"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Additional coding: </label>
                                <div >
                                    <input type="text" class="form-control" name="addcoding" attr-check="add_coding">
                                    <span class="err err_add_coding"></span>
                                </div>
                            </div>


                            <!-- <div class="form-group">
                                <label>Date type: </label>
                                <div >
                                    <select  class="form-control" name="datetype" attr-check="datetype">
                                        <option value=""> SELECT</option>
                                        <option value="day">Day</option>
                                        <option value="month">Month</option>
                                        <option value="year">Year</option>
                                    </select>
                                    <span class="err err_datetype"></span>
                                </div>
                            </div> -->
                        </div>
                        <input type="hidden" name="subid" id="subid" value="0">
                        <div class="col-lg-12 text-center">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-success save_btn">Save</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="free_sub" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Free Subscription</h4>
                </div>
                <div class="modal-body row">
                    <form id="freeSubscription" method="post">
                        <div class="col-lg-9 col-lg-offset-1 form-horizontal">
                            <div class="form-group">
                                <label>Product: </label>
                                <div >
                                    <input type="text" class="form-control" name="product" value="{$config.freesubscription.product}" attr-chk-free="product" onkeypress="isNumber(event,this)">
                                    <span class="err err_product"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Store: </label>
                                <div >
                                    <input type="text" class="form-control" name="store" value="{$config.freesubscription.store}" attr-chk-free="store" onkeypress="isNumber(event,this)">
                                    <span class="err err_store"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Category: </label>
                                <div >
                                    <input type="text" class="form-control" name="category" value="{$config.freesubscription.category}" attr-chk-free="category" onkeypress="isNumber(event,this)">
                                    <span class="err err_category"></span>
                                </div>
                            </div>
                            <div class="col-lg-12 text-center">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-success save_free_sub">Save</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
{include file="/admincp/footer.tpl" nocache}
<style media="screen">
    .modal-body label{
        margin-top: 7px;
    }
    .h4,.table_div {
        margin-left:17px !important;
        margin-bottom: 16px !important;
    }
    .err {
        font-size: 12px;
        color: red;
    }
    .container-fluid {
        min-height: 602px !important;
    }
</style>
<script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.13/js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $('#mytable').DataTable();

        $('body').on('click', '.save_btn', function() {
            $("[attr-check]").each(function() {
                var value = $(this).val();
                if(value == '' || value == undefined) {
                    var text = $(this).parent().prev().text().replace(":","");
                    // $(".err_"+$(this).attr('attr-check')+"").text("Please fill the "+$(this).parent().prev().text()+"");
                    $(this).siblings('span').text("Please fill the "+text+"");
                }
            });
            if($('.err').text() == '') {
                var param = $('#addEditSubscription').serialize();
                $.ajax({
                    url : '/admincp/saveStoreSubscription',
                    type: 'POST',
                    data: param,
                    dataType: 'json',
                    success: function(response) {
                        if(response.status == 'true') {
                            if(response.planid == 'true') {
                                location.reload();
                            } else {
                                $(".err_plan_id").text("Please fill the valid Braintree Plan Id");
                            }
                        }
                    }
                });
            }
        }).on('keydown','input',function() {
            if($(this).val() != '' && $(this).val() != undefined) {
                $(this).siblings('span').text('');
            }
        }).on('change','select',function() {
            if($(this).val() != '' && $(this).val() != undefined) {
                $(this).siblings('span').text('');
            }
        }).on('click', '.edit_sub', function() {
            $('#subid').val($(this).val());
            $(this).closest('.co_datas').children('[attr-getval]').each(function() {
                var value = $(this).text();
                var input = $(this).attr('attr-getval');
                value     = value.trim();
                $('[attr-check="'+input+'"]').val(value);
            });
            $('#add_sub').modal('show');
        }).on('click', '.save_free_sub', function() {
            $("[attr-chk-free]").each(function() {
                var value = $(this).val();
                if(value == '' || value == undefined) {
                    $(".err_"+$(this).attr('attr-chk-free')+"").text("Please fill the "+$(this).attr('attr-chk-free')+" counts");
                }
            });
            if($('.err').text() == '') {
                var param = $('#freeSubscription').serialize();
                $.ajax({
                    url : '/admincp/saveFreeSubscription',
                    type: 'POST',
                    data: param,
                    dataType: 'json',
                    success: function(response) {
                        if(response.status == 'success') {
                            location.reload();
                        }
                    }
                });
            }
        });

        $('#add_sub').on('hidden.bs.modal',function functionName() {
            $('#add_sub input,#add_sub select').val('');
            $('.err').text('');
            $('#subid').val(0);
        });
    });
    function isNumber(event,ths) {
        if(
            (event.which != 8
            && isNaN(String.fromCharCode(event.which))
            && event.which != 0
            && event.which != 46)
            || ($(ths).val().indexOf('.') >= 0 && event.which == 46)
        ) {
            $(ths).siblings('span').text('Please enter valid number only');
            event.preventDefault();
        } else {
            $(ths).siblings('span').text('');
        }
    }
</script>
