{include file="/admincp/header.tpl" nocache}
<style>
    .right-content .items-row .item-col {
        margin: 1%;
        width: 23%;
        background: #ffffff;
    }
    .shadow {
        box-shadow: 0px 0px 4px #cccccc;
    }
    .right-content .items-row .item-col ul {
        padding: 0;
    }
    .right-content .items-row .item-col ul .price-offer {
        display: inline-block;
        margin: 10px;
        margin-left: 0px;
        margin-right: 0;
        font-size: 13px;
    }
    .right-content .items-row .item-col ul .price-offer .price {
        color: #377522;
        font-size: 13px;
        font-weight: 600;
        font-style: inherit;
        text-transform: inherit;
        text-align: left;
        line-height: 28px;
    }
    .right-content .items-row .item-col .item-thumb {
        position: relative;
        max-height: 150px;
        min-height: 150px !important;
        overflow: hidden;
    }
    .right-content .items-row .item-col .item-thumb img {
        height: 150px;
        position: absolute;
        transform: translateX(-50%);
        left: 50%;
    }
    .margin-auto {
        margin: auto;
    }
    .right-content .items-row .item-col ul {
        padding: 0;
    }
    .right-content .items-row .item-col .item-details li {
        color: #2f2f2f;
        font-size: 14px;
        font-weight: 400;
        font-style: inherit;
        text-transform: inherit;
        text-align: left;
        line-height: 28px;
        display: inline-block;
        width: 100%;
        margin: 5px auto;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .ptitle {
        font-weight: bold !important;
        text-transform: capitalize !important;
    }
    .right-content .items-row .item-col .reccuring-purchase {
        text-align: center;
    }
    .right-content .items-row .item-col .btn-wrapper .btn-d {
        padding: 12px 15px !important;
        font-size: 14px;
        display: block;
    }
    .white, .btn-d.btn-d-hover, .btn-d:hover, .btn-d-b.btn-d-hover, .btn-d-b:hover, .bgBannerFluid .confLinkCol ul li, .bgBannerFluid .confLinkCol ul li i:before {
        color: #ffffff !important;
    }
    .black-g:hover {
        background-color: #2f2f2f;
    }
    .tab-content>.tab-pane {
        display: none !important;
    }
    .tab-content>.active {
        display: block !important;
    }
    .scrl {
        max-height: 150px;
        overflow-y: auto;
        text-align: justify;
        padding-right: 15px;
        border: 1px solid lightgray;
        padding: 10px;
        margin-top: 10px;
    }
    .checkbox, .radio {
        position: relative;
        display: block;
        margin-top: 10px;
        margin-bottom: 10px;
    }
    .checkbox label, .radio label {
        min-height: 20px;
        padding-left: 20px;
        margin-bottom: 0;
        font-weight: 400;
        cursor: pointer;
    }

    label {
        display: inline-block;
        max-width: 100%;
        margin-bottom: 5px;
        font-weight: 700;
    }
    .checkbox label input[type="checkbox"] {
        display: none;
    }
    .checkbox input[type=checkbox], .checkbox-inline input[type=checkbox], .radio input[type=radio], .radio-inline input[type=radio] {
        position: absolute;
        margin-top: 4px\9;
        margin-left: -20px;
    }
    input[type=checkbox], input[type=radio] {
        margin: 4px 0 0;
        margin-top: 1px\9;
        line-height: normal;
    }
    input[type=checkbox], input[type=radio] {
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        padding: 0;
    }
    .checkbox .cr, .radio .cr {
        position: relative;
        display: inline-block;
        border: 1px solid #a9a9a9;
        border-radius: 0;
        width: 1.3em;
        height: 1.3em;
        float: left;
        margin-right: .5em;
    }
    .checkbox label input[type="checkbox"] + .cr > .cr-icon {
        transform: scale(3) rotateZ(-20deg);
        opacity: 0;
        transition: all .3s ease-in;
    }
    .checkbox .cr .cr-icon, .radio .cr .cr-icon {
        position: absolute;
        font-size: .8em;
        line-height: 0;
        top: 50%;
        left: 20%;
    }
    .right-content .items-row .item-col .btn-wrapper img {
        display: inline-block;
        margin-left: 6px;
        text-shadow: 0 0 black;
        margin-top: -8px;
    }
</style>
<div class="container-fluid">
    <style>
        .open-bid-row {
            background: #ffffff;
            margin-bottom: 10px;
            /* box-shadow: 0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23); */
        }
    </style>
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active">
                    Purchase
                </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->

    <div role="tabpanel">
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" {if $action == ''} class="active" {/if}><a class="tab-menu" id="open_market">Open Buy Market</a></li>
            <li role="presentation" {if $action == 'inbox'} class="" {/if}><a class="tab-menu" id="direct_buy_market">Direct Buy Market</a></li>
        </ul>

        
        <div role="tabpanel" class="tab-pane active" id="open_market_pane">
            <br>
            <div class="row m-top-20">
                <div class="col-lg-12">
                    <div class="col-lg-2">
                        <div class="form-group">
                            <label>On Behalf</label>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="form-group"  id="submit_form123" data-parsley-validate>
                            <select class="form-control clracac" name="behalf_user" id="behalf_user" data-parsley-required-message="please select user." data-parsley-required required>
                                    <option value="">Select User</option>
                                {foreach $behalfUsers as $key => $val}
                                    <option value="{$val.id}_{$val.user_id}" {if $scid == $val.id} selected {/if}>{$val.name} ({$val.email})</option>
                                {/foreach}   
                            </select>
                        </div>
                    </div>
                </div>
                
                <div id="loading" class="col-lg-12">
                    <img src="{$config.url}/images/ripplez.gif" class="img-responsive" alt="ripplez.gif">
                </div>
    
                <div id="loadData" class="col-md-12 right-content" style="text-align : left">
                </div>
            </div>
        </div>

        <div role="tabpanel" class="tab-pane " id="direct_buy_market_pane" style="display:none;">
            <br>
            <div class="row m-top-20">
                <div class="col-lg-12">
                    <div class="col-lg-2">
                        <div class="form-group">
                            <label>On Behalf</label>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="form-group"  id="submit_form123" data-parsley-validate>
                            <select class="form-control clracac" name="behalf_user_direct" id="behalf_user_direct" data-parsley-required-message="please select user." data-parsley-required required>
                                    <!-- <option value="">Select User</option> -->
                                {foreach $behalfUsers as $key => $val}
                                    <option value="{$val.id}_{$val.user_id}_{$val.state}" {if $scid == $val.id} selected {/if}>{$val.name} ({$val.email})</option>
                                {/foreach}   
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12">
                        <div class="col-lg-2">
                            <div class="form-group">
                                <label>Store</label>
                            </div>
                        </div>
                        <div class="col-lg-5">
                        <div class="form-group"  id="submit_form456" data-parsley-validate>
                            <select class="form-control clracac" name="behalf_store" id="behalf_store" data-parsley-required-message="please select user." data-parsley-required required>
                                <option value="">Select Store</option>
                            </select>
                        </div>
                    </div>
                </div>
                
                <div id="loading_direct" class="col-lg-12">
                    <img src="{$config.url}/images/ripplez.gif" class="img-responsive" alt="ripplez.gif">
                </div>
    
                <div id="loadDataDirect" class="col-md-12 right-content" style="text-align : left">

                </div>
            </div>
        </div>
    </div>

</div>

<div class="container">
    <div class="modal fade reccuring-modal" id="myModal" role="dialog">
        <div class="modal-dialog reccuringpop">
            <input type="hidden" id="pdtid" class="pdtid" name="pdtid" value="">
            <input type="hidden" id="pdtcdb" class="pdtcdb" name="pdtcdb" value="">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
                    <div class="panel panel-success">
                        <div class="panel-heading green-bg">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h3>Make this a recurring purchase ?</h3>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-10 col-md-offset-1">
                            <ul class="nav nav-pills nav-justified">
                                <li class="active"><a data-toggle="pill" href="#yes" id="yespane">YES</a></li>
                                <li><a data-toggle="pill" href="#no" id="nopane">NO</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="tab-content">
                        <div id="yes" class="tab-pane fade in active" style="display:block;">
                            <div class="row">
                                <div class="col-md-10 col-md-offset-1">
                                    <!-- <div class="col-md-12 m20">
                                        <p class="description m10 text-center">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.</p>
                                    </div> -->
                                    <form name="recurpur" class="recurpur" id="recurpur" data-parsley-validate>
                                        <input type="hidden" name="recupur" class="recupur" id="recupur" value="1">
                                        <input type="hidden" name="project_id" class="project_id" id="project_id" value="">
                                        <input type="hidden" name="buserid" class="buserid" id="buserid" value="">
                                        <div class="col-md-12 m20">
                                            <div class="form-group">
                                                <div class="col-sm-6">
                                                    <select class="w100 p15 pb15 border1" name="frequency" id="frequency" data-parsley-required data-parsley-required-message="Please select units">
                                                        <option value>Frequency</option>
                                                        <option value="weekly">Weekly</option>
                                                        <option value="biweekly">Bi Weekly</option>
                                                        <option value="monthly">Monthly</option>
                                                        <option value="quaterly">Quarterly</option>
                                                        <option value="bianually">Bi annually</option>
                                                        <option value="anually">Annually</option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-6">
                                                    <input class="w100 p15 pb15 border1 rqty" type="text" id="rqty" placeholder="Quantity" name="rqty" data-parsley-trigger="change focusout" data-parsley-required-message="Please add quantity" data-parsley-required data-parsley-min="1" data-parsley-min-message="Please enter quantity 1 or more" data-parsley-type="number" data-parsley-type-message="please enter the quantity number" onkeyup="check_qty();">
                                                    <p class="tqtytext"></p>
                                                </div>
                                            </div>
                                        </div><div class="clearfix"></div>
                                        <div class="col-md-12 m10">
                                            <div class="form-group">
                                                <div class="col-sm-6">
                                                    <div class="inner-addon right-addon">
                                                        <i class="glyphicon glyphicon-calendar"></i>
                                                        <input class="w100 p15 pb15 border1" readonly type="text" id="sdate" placeholder="Start Date(Next Purchase)" name="sdate" data-parsley-required data-parsley-required-message="please enter Next Purchase">
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <input class="w100 p15 pb15 border1 reccurCount" type="text" id="reccurCount" placeholder="How Many Transactions" name="edate" data-parsley-required-message="Please enter the number of transaction" data-parsley-required data-parsley-min="1" data-parsley-min-message="Please enter 1 or more" data-parsley-type="number" data-parsley-type-message="Numbers allowed only">
                                                    <!-- <input class="w100 p15 pb15 border1" readonly type="text" id="edate" placeholder="End Date" name="edate" data-parsley-required data-parsley-required-message="please enter End Date"> -->
                                                </div>
                                            </div>
                                        </div><div class="clearfix"></div>
                                        <div class="col-md-12 m10">
                                            <div class="form-group">
                                                <div class="col-sm-6">
                                                    <span class="description"><i>Would you like cancellation insurance? </i></span>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="radio-con">
                                                        <div class="radio2">
                                                            <input id="radio-3" name="insurance" type="radio" value="1">
                                                            <label for="radio-3" class="radio-label">Yes</label>
                                                        </div>
                                                        <div class="radio2">
                                                            <input id="radio-4" name="insurance" type="radio" value="0" checked="">
                                                            <label for="radio-4" class="radio-label">No</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- <div class="col-md-12 testresult" style="display: none;">
                                                    <div class="pro-thumb grey-bg flex w100">
                                                    <img src="images/upload-img.png" class="img-responsive margin-auto" alt="">
                                                    </div>
                                                    <div class="margin-auto" style="margin-right:0px;">
                                                        <span class="f12 m5"><i>Upload Test Result</i></span>
                                                        <input name="test-result-name" type="file" id="filecount3" multiple="multiple" value="test" tabindex="-1" style="position: absolute; clip: rect(0px 0px 0px 0px);"><div class="bootstrap-filestyle input-group"><span class="group-span-filestyle " tabindex="0"><label for="filecount3" class="btn btn btn-default btn-d-b btn-d-g m5 w100 "><span class="icon-span-filestyle "></span> <span class="buttonText">UPLOAD</span></label></span></div>
                                                    </div>
                                                </div> -->
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                        <!-- <div class="col-md-12 m10 checkbox_insurance">
                                            <div class="checkbox">
                                                <label>
                                                    <input name="terms-name" id="tterms" type="checkbox" value="terms">
                                                    <span class="cr"><i class="cr-icon fa fa-check"></i></span> Set it up?
                                                </label>
                                                <span id="err_terms" class="red"></span>
                                            </div>
                                        </div> -->

                                        <div class="clearfix"></div>
                                        <div class="col-md-12 m10">
                                            <div class="col-md-12 pslr0 text-left mr-cklab mrbt10 scall">
                                                <div class="scrl terms" id="style-1">
                                                    <b> HERBEE FORWARD CONTRACT AND RECURRING PURCHASE POLICY </b> 
    
<p> From time to time as the case may be, you may choose to purchase product as a buyer (the “Buyer”) or to sell product as a seller (the “Seller”) on a recurring basis in accordance with certain defined <a target="_blank" href="{$config.url}/terms">terms and conditions</a> as allowed on HERBEE.  By accepting these terms, you herby agree to abide by the following <a target="_blank" href="{$config.url}/terms">terms and conditions</a> as part of any forward contracting or recurring purchase arrangement as a Buyer or a Seller:  
    
<ul>
    As part of the forward contract agreement, the parties agree to the following provisions:
    
<li>1)     Buyer will purchase certain agreed upon goods from Seller on an agreed upon date or series of dates for an agreed upon amount dsignated in US dollars.</li>
    
<li>2)     Buyer agrees to have the amount for each order deducted from their Herbee account upon receipt of product from the Seller at each agreed upon transaction date   </li>    
    
<li>3)     Seller agreees to provide the Buyer with the agreed upon goods no later than 72 hours of the agreed upon date or serise of dates for the agreed upon amount designated in US dollars.</li>
    
<li>4)     All parties agree that the agreed upon goods shall be transferred for the agreed upon amount at acceptance of the contract regardless of the appraised value of the goods on any future date after the agreement.</li>
    
<li>5)     All parties agree that goods being sold must be in excellent condition on delivery to the Buyer. If goods being sold iare not in said condition, the Seller shall delivery replacement goods within 24 hours.  If the Seller does not deliver the replacement goods within 24 hours, the Buyer shall be entitled to a refund for the goods to be delivered on that date upon submitting a case (See Dispute Resolution Process).</li>
    
<li>6)     All parties agree that unless the Buyer elects to purchase cancellation insurance, a forward contract agreement cannot be cancelled be cancelled by the buyer.  </li> 
    
<li>7)     All parties agree that upon cancellation of a forward contract or recurring purchase prior to the final transaction wherein either party elected to purchase cancellation insurance as part of the agreed upon forward contract transaction, the canceling party shall have 25% of the remaining monetary value of the contract deducted from their account.  Should parties not elect to to have cancelation insurance, then the canceling party shall have 50% of the remaining monetary value of the contract deducted from their account. The deducted amount shall then be then awarded to the other party less any outstanding fees for the transaction.</li>
</ul></p>
                                                </div>
                                            </div>
                                        </div><div class="clearfix"></div>
                                        <div class="col-md-12 m10">
                                            <div class="checkbox1">
                                                <label>
                                                    <input type="checkbox" name="tcond" class="tcond" data-parsley-required data-parsley-required-message="please enter sdfsdf" required>
                                                     I have accepted the <a target="_blank" href="{$config.url}/terms">terms and conditions</a>
                                                </label>

                                            </div>
                                            <span id="err_terms" class="red"></span>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div id="no" class="tab-pane fade in">
                            <div class="row">
                                <div class="col-md-10 col-md-offset-1">
                                    <div class="row">
                                        <div class="col-md-5 col-md-offset-3 mble-arrow">
                                            <input class="w100 p15 pb15 grey-bg border-0 m10 qty_add" type="number" id="qty_add" data-parsley-trigger="change focusout" placeholder="Quantity Requested" name="email" data-parsley-required-message="Please add quantity" data-parsley-required data-parsley-min="1" data-parsley-min-message="Please enter quantity 1 or more" data-parsley-type="number" data-parsley-type-message="please enter the quantity number" onkeyup="check_qty2();">
                                            <p class="tqtytext"></p>
                                        </div>
                                        <div class="col-md-12 pslr0 text-left mr-cklab mrbt10 scall">
                                            <div class="scrl" id="style-1">
                                                {$terms}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                    <div class="col-md-12 m10">
                                        <div class="checkbox1">
                                            <label>
                                                <input type="checkbox" value="1" class="buynwchck">
                                                I have accepted the <a target="_blank" href="{$config.url}/terms">terms and conditions</a>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default btn-d-b green-b" type="button" onclick="addToCart()">BUY NOW</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Negotiable -->
<div class="container">
    <!-- Modal -->
    <div class="modal reccuring-modal fade" id="negotiable" role="dialog">
        <div class="modal-dialog modal-sm" style="width: 35% !important;">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span style="background:none;border:none;padding:9px; margin-top: 2px; display: inline-block;">X</span></button>
                    <div class="panel panel-success">
                        <div class="panel-heading green-bg">
                            <h3>NEGOTIABLE <img src="/images/negotiable.png" class="img-responsive" alt="negotiable"></h3>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <h3 class="primary-blue text-center m20">Suggested Price:<span class="green-text">$<span class="mprice"></span>/Unit</span></h3>
                    <form name="negoform" class="negoform" id="negoform" data-parsley-validate>
                        <input class="w100 p15 pb15 grey-bg priceoffer" type="text" id="priceoffer" placeholder="Price Offer" name="priceoffer" data-parsley-required data-parsley-required-message="Please Enter Price Offer">
                        <input class="w100 p15 pb15 grey-bg m10 qtyreq" type="text" id="qtyreq" placeholder="Quantity Requested" name="qtyreq" data-parsley-required-message="Please add quantity" data-parsley-required data-parsley-min="1" data-parsley-min-message="Please enter quantity 1 or more" data-parsley-type="number" data-parsley-type-message="please enter the quantity number" onkeyup="check_qty3();">
                        <p class="tqtytext"></p>
                        <input type="hidden" id="userid" class="userid" name="userid" value="">
                        <input type="hidden" id="pdtid1" class="pdtid" name="pdtid" value="">
                        <input type="hidden" id="mpriceval" class="mpriceval" name="mpriceval" value="">
                        <input type="hidden" id="pdtcd" class="pdtcd" name="pdtcd" value="">
                    </form>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default btn-d black-g btnnego" type="button" name="button">Submit </button>
                </div>
            </div>
        </div>
    </div>
</div>
{include file="/admincp/footer.tpl" nocache}

<script>
$.fn.stars = function () {
    return $(this).each(function () {
        // Get the value
        var val = parseFloat($(this).html());
        // Make sure that the value is in 0 - 5 range, multiply to get width
        var size = Math.max(0, (Math.min(5, val))) * 16;
        // Create stars holder
        var $span = $('<span />').width(size);
        // Replace the numerical value with stars
        $(this).html($span);
    });
}

/* jquery datepicker - Date available */
today = new Date();
var tomorrow = new Date(today.getTime() + 24 * 60 * 60 * 1000);
$("#sdate").datetimepicker({
    // step: 5,
    minDate: tomorrow,
    // ,
    // minTime: tomorrow,
    onChangeDateTime: function(dp, $input) {
       startDate = $("#sdate").val();
    }
});

var buser_id = 0;

$(document).ready(function() {
    $(document).on('click', '.tab-menu', function() {
        var tab = $(this).attr('id');
        $(".tab-menu").closest('li').removeClass('active');
        $("#"+tab).closest('li').addClass('active');

        $(".tab-pane").removeClass('active');
        $(".tab-pane").hide();
        $("#"+tab+"_pane").addClass('active');
        $("#"+tab+"_pane").show();
    });

    loadMore();
    var loadmore = 0;
    function loadMore(){
        $("#loading").show();
        if($("#finish_prod").val() != '0'){
            loadmore++;
            $.ajax({
                type: 'post',
                url: '/openbid/products',
                data : {
                    cat : 'all',
                    type : 'recent',
                    page : loadmore,
                    sortType : 'undefined'
                },
                dataType: 'json',
                success: function(data) {
                    $("#loading").hide();
                    $("#loadData").show();

                    $("#loadData").append(data.html);
                }
            });

        } else {
            $("#load_more").hide();
        }
    }


    $(document).on('change', '#behalf_user_direct', function() {
        getStores();
    })

    getStores();
    function getStores(){
            var values = $('#behalf_user_direct').val().split('_');
            var cc_id = values[0];
            buser_id = values[1];
            var state = values[2];

            $.ajax({
                type: 'post',
                url: '/{$loged.adminUrl}/getStores',
                data : {
                    user_id : buser_id,
                    state: state
                },
                dataType: 'json',
                success: function(data) {
                    // $("#loading_direct").hide();
                    // $("#loadDataDirect").show();

                    $('#behalf_store').find('option').remove().end();
                    var stores = data.data;
                    for (let index = 0; index < stores.length; index++) {
                        const element = stores[index];
                        var newOption = new Option(element.name, element.id, false, index==0);
                        $('#behalf_store').append(newOption);

                        if(stores.length == (index+1)) {
                            setTimeout(() => {
                                $('#behalf_store').trigger('change');
                            }, 1000);
                        }
                    }
                    // loadMoreDirect();
                }
            });

    }

    $(document).on("change", "#behalf_store", function(){
        setTimeout(() => {
            loadMoreDirect();
        });
    });

    var loadmoreDirect = 0;
    function loadMoreDirect(){
        var values = $('#behalf_user_direct').val().split('_');
        var cc_id = values[0];
        buser_id = values[1];
        var state = values[2];
        
        $("#loading_direct").show();
        if($("#finish_prod_direct").val() != '0'){
            loadmoreDirect++;
            $("#loadDataDirect").html("");

            var id = $('#behalf_store').val();
            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: '/searchstorepdts',
                data: 'ajax=1&cid=0&id=' + id,
                success: function(data) {
                    $("#loading_direct").hide();
                    $("#loadDataDirect").show();

                    $("#loadDataDirect").html(data.html);

                    var totalNego = $(".buy_nego_btn");
                    for (let index = 0; index < totalNego.length; index++) {
                        console.log('$(".buy_nego_btn:eq("+index+")").attr("data-user-id")', $(".buy_nego_btn:eq("+index+")").attr("data-user-id"));
                        if($(".buy_nego_btn:eq("+index+")").attr("data-user-id") == buser_id) {
                            $(".buy_nego_btn:eq("+index+")").attr("disabled", "disabled");
                        }
                    }
                }
            });

        } else {
            $("#load_more").hide();
        }
    }

    

    $('#negotiable').on('show.bs.modal', function(e) {
        var data = $(e.relatedTarget).data();
        $('.mprice', this).text(data.recordPrice);
        $('.userid', this).val(data.recordUserid);
        $('.mpriceval', this).val(data.recordPrice);
        $('.pdtid', this).val(data.recordPdt);
        $('.pdtcd', this).val(data.recordPdtc);
    });

    $('#myModal').on('show.bs.modal', function(e) {
        $(".tab-pane:first-child").addClass("active");
        $("#yespane").trigger("click");
        var data = $(e.relatedTarget).data();
        $('.pdtid', this).val(data.recordPdt);
        $('.project_id', this).val(data.recordPdt);
        $('.pdtcdb', this).val(data.recordPdtc);
    });
    $('#yespane').click(function() {
        $('.recupur').val(1);
    });

    $('#nopane').click(function() {
        $('.recupur').val(0);
    });
    $('.btnnego').click(function() {
        var vali2 = $('#negoform').parsley().validate();
        if (vali2 === false) { 
            return false; 
        }
        var mprice = $('.mprice').val();
        var userid = $('.userid').val();
        var pdtid = $('#pdtid1').val();
        var priceoffer = $('.priceoffer').val();
        var qtyreq = parseInt($('.qtyreq').val());
        var pdtcd = parseInt($('.pdtcd').val());
        if (qtyreq > pdtcd) {
            qtyreq = pdtcd;
            $('.tqtytext').html("Available quantity is:" + pdtcd);
            return false;
        }
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: '/bidplace',
            data: $('.negoform').serialize(),
            success: function(data) {
                if (data.success == 1) {
                   //console.log("sfsdfsdf" + pdtid);
                    $('#negotiable').modal('hide');
                    $("#" + pdtid).find("button").prop("disabled", true);
                }
                 if(data.error){
                     if(!data.membership_status){
                     window.location = '{$config.url}/package'    
                     } else if(!data.bid_count > 0){
                     swal("Bid placed already..!")
                     }
                }
            }
        });
    });
});

function placeBid(prodId){

    $("#submit_form123").parsley().validate()
    if($("#submit_form"+prodId).parsley().validate() && $("#submit_form123").parsley().validate()){
        var values = $('#behalf_user').val().split('_');
        var cc_id = values[0];
        var user_id = values[1];
        var qty = $('#submit_form'+prodId).find('#qty').val();

        var myFormData = new FormData();
        myFormData.append( 'purchase_behalf_documents', $('#submit_form'+prodId).find('#purchase_proof')[0].files[0] );
        myFormData.append( 'id', prodId );
        myFormData.append( 'offer_price', $('#submit_form'+prodId).find('#offer_price').val() );
        myFormData.append( 'qty', qty );
        myFormData.append( 'behalf_cc_id', cc_id );
        myFormData.append( 'behalf_user_id', user_id );
        myFormData.append( 'is_on_behalf', 1 );

        $('#submit_form'+prodId).find('.btn-default').attr('disabled', true);
        $.ajax({
            url: '/product/request/save',
            data: myFormData,
            type: 'POST',
            contentType: false,
            processData: false,
        
        /* $.ajax({
            type: 'POST',
            url: '/product/request/save',
            data: {
                id : prodId,
                offer_price : $('#submit_form'+prodId).find('#offer_price').val(),
                qty : qty,
                behalf_cc_id: cc_id,
                behalf_user_id: user_id,
                is_on_behalf: 1
            },
            dataType: 'json', */
            success: function(data) {
                if(data.status == 1){
                    /* $("#accept_form").remove();
                    $('<form id="accept_form" method="post" action="{$config.url}/product/request/accept/'+prodId+'"><input type="hidden" name="req_id" value="'+data.data.insertId+'" /></form>').appendTo('body').submit(); */

                    $.ajax({
                        type: 'POST',
                        url: '/product/request/accept/'+prodId,
                        data: {
                            req_id : data.data.insertId
                        },
                        dataType: 'json',
                        success: function(data) {
                            $('#submit_form'+prodId).find('.btn-default').attr('disabled', false);
                        },
                        error: function(data) {
                            $('#submit_form'+prodId).find('.btn-default').attr('disabled', false);
                        }
                    });
                    
                    $('#submit_form'+prodId).find('#purchase_proof').val('');
                    $('#submit_form'+prodId).find('#proof_name').html('');
                    $('#submit_form'+prodId).find('#offer_price').val('');
                    if($('#submit_form'+prodId).find('#qty').attr('data-parsley-min') != undefined){
                        $('#submit_form'+prodId).find('#qty').val('');
                        var old_qty = $('#submit_form'+prodId).find('#prod_qty').html().trim();
                        $('#submit_form'+prodId).find('#prod_qty').html(old_qty - qty);
                    }
                    $.toaster({ settings : { 'toaster' : { 'css' : { 'position' : 'fixed', 'top' : '10px','right' : '10px','max-width' : '600px', 'zIndex' : 50000 } }, 'timeout' : 15000} });

                    $.toaster({ message : 'Your order has been successfully purchased.', title : '<i class="fa fa-info-circle" aria-hidden="true"></i> Info', priority : 'success'});
                } else if(data.status == 0) {
                    $.toaster({ message : data.msg });
                }
            }
        });
    }
}

function check_qty() {
    var rqtys1, tpdtc1 = '';
    rqtys1 = parseInt($('.rqty').val());
    tpdtc1 = parseInt($('.pdtcdb').val());
    if (rqtys1 > tpdtc1) {
        //console.log("hjhjhjh");
        rqtys1 = tpdtc1;
        //$('.rqty').val(tpdtc1);
        $('.tqtytext').html("Available quantity is:" + tpdtc1);
        return false;
    } else {
        $('.tqtytext').html("");
    }
}

function check_qty2() {
    var qty_add = parseInt($('.qty_add').val());
    var pdtcdb = parseInt($('.pdtcdb').val());
    if (qty_add > pdtcdb) {
        qty_add = pdtcdb;
        //$('.qty_add').val(pdtcdb);
        $('.tqtytext').html("Available quantity is:" + pdtcdb);
        return false;
    } else {
        $('.tqtytext').html("");
    }
}

function check_qty3() {
    var qtyreq = parseInt($('.qtyreq').val());
    var pdtcd = parseInt($('.pdtcd').val());
    if (qtyreq > pdtcd) {
        qtyreq = pdtcd;
        //$('.qtyreq').val(pdtcd);
        $('.tqtytext').html("Available quantity is:" + pdtcd);
        return false;
    } else {
        $('.tqtytext').html("");
    }
}

function addToCart() {
    console.log("addto cart here");
    var rqtys, tpdtc = '';
    var recur = $('.recupur').val();
    var rqty = $('.rqty').val();
    //var pdtcdb  = $('.pdtcdb').val();
    if (recur == 1) {
        console.log("addto cart here2");
        var pdid = $('.pdtid').val();
        if ($(".tcond").prop('checked') == true) {
            console.log("addto cart here3");
            $("#err_terms").text("");
            rqtys = parseInt($('.rqty').val());
            tpdtc = parseInt($('.pdtcdb').val());
            var vali = $('#recurpur').parsley().validate();
            if (vali === false) { return false; }


            if (rqtys > tpdtc) {
                //console.log("hjhjhjh");
                rqtys = tpdtc;
                //$('.rqty').val(tpdtc);
                $('.tqtytext').html("Available quantity is:" + tpdtc);
                return false;
            }

            $("#buserid").val(buser_id);
            var params = $('.recurpur').serialize();
            $.ajax({
                type: 'GET',
                dataType: 'json',
                url: '/cartrecurring/' + pdid + '?qty=' + $('.rqty').val(),
                data: params,
                success: function(data) {

                    $('#myModal').modal('hide');

                    if (data.success) {
                       //console.log(data)
                         if (data.add) {
                            window.location = '{$config.url}/product/checkout/cart/'
                        } else if (!data.membership_status) {
                            // window.location = '{$config.url}/package'
                            alert('This user have no balance amount');
                        }else if (!data.login) {
                            window.location = '{$config.url}/{$loged.adminUrl}/login'
                        } else {
                            window.location = '{$config.url}/{$loged.adminUrl}/login'
                        }

                    } else {
                        if (data.error == '') {
                            window.location = '{$config.url}/{$loged.adminUrl}/login';
                        } else {
                            alert(data.error);
                        }
                    }

                }
            });
        } else {

                $("#err_terms").text("please check the recurring terms and condtions");      
            return false;
        }
    } else {
        if ($(".buynwchck").prop('checked') == true) {

            var id = $('.pdtid').val();
            var qty_add = parseInt($('.qty_add').val());
            var pdtcdb = parseInt($('.pdtcdb').val());
            if (qty_add > pdtcdb) {
                qty_add = pdtcdb;
                //$('.qty_add').val(pdtcdb);
                $('.tqtytext').html("Available quantity is:" + pdtcdb);
                return false;
            }
            //console.log(parseInt($('#qty_add').val()));
            //console.log($('.addcart').find('span').html().indexOf("Add"));
            if ((parseInt($('#qty_add').val()) <= 0 || $('#qty_add').val() == '')) {
                alert('Please select atleast one quantity');
                return false;
            }
            $.ajax({
                type: 'GET',
                url: '/product/cart/' + id + '?qty=' + $('#qty_add').val(),
                data: {},
                dataType: 'json',
                success: function(data) {
                   //console.log(data);

                    if (data.success) {
                        if (data.add) {

                            window.location = '{$config.url}/product/checkout/cart/'

                        } else {
                            alert("eerror");
                        }


                    } else {
                        if (data.error == '') {
                            window.location = '{$config.url}/login';
                        } else {
                            alert(data.error);
                        }
                    }
                }

            });
        } else {
            alert("please check the terms and condtions");
        }

    }
}
</script>