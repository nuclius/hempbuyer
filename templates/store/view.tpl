 {include file="common/header-1.tpl" nocache}
<link rel="stylesheet" href="{$config['externalcss']}jquery.datetimepicker.css" type="text/css" />
<style media="screen">
.loader_div .loader {
    height: 63px;
    margin-top: 20%;
    margin-left: 47%;
}

.loader_div {
    background: rgb(0, 0, 0);
    background: transparent;
    background: rgba(0, 0, 0, 0.5);
    /* FF3+,Saf3+,Opera 10.10+,Chrome,IE9*/
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#7f000000, endColorstr=#7f000000);
    /*IE 5.5-7*/
    -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#7f000000,endColorstr=#7f000000)";
    /*IE8*/
    zoom: 1;
    width: 100%;
    height: 100%;
    z-index: 104;
    position: fixed;
    display: block;
    top: 0;
    left: 0;
}

.category-heading img {
    display: inline-block;
    margin-right: 6px;
}

.activecat {
    font-weight: bold;
}

.tqtytext {
    color: red;
}
</style>

{include file="store/css-store.tpl" nocache}
<style>
.img-info {
    left: 0;
    position: absolute;
    top: 10%;
}

.bck-img {
    height: auto;
    width: 100%;
}

.carousel-control.right {
    background-image: none;
    top: 165px;
    right: -100px;
}

.carousel-control.left {
    background-image: none;
    top: 165px;
    left: -95px;
    ;
}

.gry_but span {
    background: rgba(0, 0, 0, 0) url("/images/home/textbutton.png") no-repeat scroll 0 -96px;
    color: #5d5f62;
    display: block;
    font-family: Arial, Helvetica, sans-serif !important;
    font-size: 11px !important;
    font-weight: bold;
    margin-right: 7px;
    padding: 8px 3px 9px 10px;
    text-align: center;
}

#fac_id {
    float: left;
    margin-top: 0;
    display: none;
}

#twi_id {
    float: left;
    margin-top: 0;
    display: none;
}

#goo_id {
    float: left;
    margin-top: 0;
    display: none;
}

#web_id {
    display: none;
    float: left;
    margin-top: 0;
}

.dropup {
    float: right;
}

.store-head .bt-info .btn-group .btn:focus {
    box-shadow: inset 0 3px 5px rgba(0, 0, 0, .125);
    border: 2px solid #ccc;
    background: #f9f8f8;
}

.store-head .bt-info .btn-group .btn.active:focus {
    background: #e5e5e5;
    box-shadow: inset 0 3px 5px rgba(0, 0, 0, .125);
    border: 2px solid rgba(85, 85, 85, 0.55);
}

.right {
    margin: 10px 0;
    float: right;
    cursor: pointer;
    display: inline-block;
}
</style>
<!-- store section design -->
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
                        <div id="yes" class="tab-pane fade in active">
                            <div class="row">
                                <div class="col-md-10 col-md-offset-1">
                                    <!-- <div class="col-md-12 m20">
                                        <p class="description m10 text-center">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.</p>
                                    </div> -->
                                    <form name="recurpur" class="recurpur" id="recurpur" data-parsley-validate>
                                        <input type="hidden" name="recupur" class="recupur" id="recupur" value="1">
                                        <input type="hidden" name="project_id" class="project_id" id="project_id" value="">
                                        <div class="col-md-12 m20">
                                            <div class="form-group">
                                                <div class="col-sm-6">
                                                    <select class="w100 p15 pb15 border1" name="frequency" id="frequency" data-parsley-required data-parsley-required-message="Please select units">
                                                        <option value>Frequency</option>
                                                        <option value="minutes">minutes</option>
                                                        <option value="hourly">Hourly</option>
                                                        <option value="daily">Daily</option>
                                                        
                                                        <option value="weekly">Weekly</option>
                                                        <option value="biweekly">Bi Weekly</option>
                                                        <option value="monthly">Monthly</option>
                                                        <option value="quaterly">Quarterly</option>
                                                        <option value="bianually">Bi annually</option>
                                                        <option value="anually">Annually</option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-6">
                                                    <input class="w100 p15 pb15 border1 rqty" type="text" id="rqty" placeholder="Quantity" name="rqty" data-parsley-trigger="change focusout" data-parsley-required-message="Please add quantity" data-parsley-required data-parsley-min="1" data-parsley-min-message="Please enter quantity 1 or more" data-parsley-type="number" data-parsley-type-message="please enter the quantity number" onkeyup="check_qty();" min="0" onchange="check_qty();">
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
                                        <div class="col-md-12 m10" style="display: none;">
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
                                                <b>• As part of the recurring purchase agreement, the parties agree to the following provisions:</b>
<p>
    <ul>
        
    
    <li>1. Buyer will purchase certain agreed upon goods from Seller on an agreed upon date or series of dates for an agreed upon amount designated in Herbee Credit</li>
    
    <li>2. Buyer agrees to have the amount for each order deducted from their Herbee account upon receipt of product at each agreed upon transaction date</li>    
    
    <li>3. Seller agrees to provide the Buyer with the agreed upon goods, via designated distributor, no later than 5 business days of the agreed upon date or series of dates for the agreed upon amount designated in Herbee Credit</li>
    
    <li>4. All parties agree that the agreed upon goods shall be transferred for the agreed upon amount at acceptance of the contract regardless of the appraised value of the goods on any future date after the agreement.</li>
    
    <li>5. All parties agree that goods being sold must be in excellent condition on delivery to the Buyer. If goods being sold are not in said condition, the Seller shall delivery, via designated distributor, replacement goods within 5 business days. If the Seller does not deliver the replacement goods, via designated distributor, within 5 business days the Buyer shall be entitled to a refund for the goods to be delivered on that date upon submitting a case to Herbee (See Dispute Resolution Process).</li>
    
    <li>6. In any instance where a Seller fails to provide the product agreed to in a recurring purchase transaction, Herbee will consider this a serious violation of the of the Seller’s responsibility to provide good business service and reserves the right to take disciplinary action, up to and including, removing the Seller from the Herbee platform</li> 
    
    </ul>
</p>
                                                </div>
                                            </div>
                                        </div><div class="clearfix"></div>
                                        <div class="col-md-12 m10">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="tcond" class="tcond" data-parsley-required data-parsley-required-message="please enter sdfsdf" required>
                                                    <span class="cr"><i class="cr-icon fa fa-check"></i></span> I have accepted the <a target="_blank" href="{$config.url}/terms">terms and conditions</a>
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
                                            <input class="w100 p15 pb15 grey-bg border-0 m10 qty_add" type="number" id="qty_add" data-parsley-trigger="change focusout" placeholder="Quantity Requested" name="email" data-parsley-required-message="Please add quantity" data-parsley-required data-parsley-min="1" data-parsley-min-message="Please enter quantity 1 or more" data-parsley-type="number" data-parsley-type-message="please enter the quantity number" onkeyup="check_qty2();" onchange="check_qty2();" pattern="^\d+$" min="0">
                                            <p class="tqtytext"></p>
                                        </div>
                                        <div class="col-md-12 pslr0 text-left mr-cklab mrbt10 scall">
                                            <div class="scrl" id="style-1">
                                               {$terms}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" value="1" class="buynwchck">
                                            <span class="cr"><i class="cr-icon fa fa-check"></i></span> I have accepted the <a target="_blank" href="{$config.url}/terms">terms and conditions</a>
                                        </label>
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
                        <input class="w100 p15 pb15 grey-bg border-0 priceoffer" type="text" id="priceoffer" placeholder="Price Offer" name="priceoffer" data-parsley-required data-parsley-required-message="Please Enter Price Offer">
                        <input class="w100 p15 pb15 grey-bg border-0 m10 qtyreq" type="text" id="qtyreq" placeholder="Quantity Requested" name="qtyreq" data-parsley-required-message="Please add quantity" data-parsley-required data-parsley-min="1" data-parsley-min-message="Please enter quantity 1 or more" data-parsley-type="number" data-parsley-type-message="please enter the quantity number" onkeyup="check_qty3();">
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
{include file="common/dashboard-navigation.tpl" nocache}
<div class="container-fluid store-view-fluid grey-bg">
    <div class="container store-view-con">
        <div class="page-caption m50">
            <h1>{$store.name}</h1>
        </div>
        <div class="row store-details-row">
            <div class="col-md-12 white-bg shadow p35-15 xs-pdlr">
                <div class="col-md-12">
                      {if $loged.userid == $store.user_id}
                    <div style="text-align:right" class="col-md-3 col-sm-6 pull-right">
                        <a href="{$config.url}/stores/edit/{$store.id}" class="black"><i class="fa fa-pencil icon f12"></i></a>
                    </div>
                    {/if}
                    <div class="col-md-2 col-sm-4 margin-auto">
                        <div class="store-thumb res-centering">
                            {if $store.logo != ''}<img src="{$config.url}/uploads/store/{$store.logo}" class="" alt=""> {else} <img src="{$config.url}/images/no_imf.png" class="img-responsive w100"> {/if}
                            <!--  <img src="images/pro-thumb.png" class="img-responsive" alt=""> -->
                        </div>
                    </div>
                    <div class="col-md-7 col-sm-8 margin-auto text-center-xs">
                        <p class="description" style="padding:30px 0px;">{$store.description}</p>
                        <div class="rating green-text">
                            Seller Rating: <span class="stars" align="left">{$store.store_rating}</span>
                        </div>
                    </div>
                  
                </div>
                <!-- <div class="col-md-3 store-details margin-auto">
                    <ul>
                        <li><i class="icon fa fa-user" aria-hidden="true"></i> Jhon Doe</li>
                        <li><i class="icon fa fa-phone" aria-hidden="true"></i> +1 2534 235 145</li>
                        <li><i class="icon fa fa-location-arrow" aria-hidden="true"></i>
                            Skinny Pvt Ltd.
                            260 Valley View Lane,
                            Dallas, Texas 75234
                        </li>
                    </ul>
                </div> -->
                <div class="col-md-12">
                    <div class="col-md-12">
                        <input type="hidden" name="storeid" class="storeid" id="storeid" value="{$store.id}"> {if $loged.userid == $store.user_id}
                        <ul class="nav nav-pills page-link page-link-store">
                            <li class=""><a class="" href="{$config.url}/product/post/{$store.id}">Post an item</a></li>
                            <!--<li><a class="" href="{$config.url}/stores/ads">Advertise Store</a></li>
                        <li><a class="" href="{$config.url}/stores/product/ads">Advertise Product</a></li>-->
                            <li><a class="" href="{$config.url}/dashboard/seller/negotiation">Manage Purchases</a></li>
                            <li><a class="" href="{$config.url}/dashboard/seller/recuring">Review Open Invoices</a></li>
                            <li><a class="" href="{$config.url}/dashboard/seller/sold">Review Closed Invoices</a></li>
                            <li><a class="" href="{$config.url}/stores/sales/report">Sales Reports</a></li>
                            <li><a class="" href="{$config.url}/stores/reviews/{$store.id}">View My Reviews &amp; Ratings</a></li>
                        </ul>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
        <!-- / store-details-row -->
        <div class="row store-content-row white-bg shadow p35-15">
            <div class="col-md-12 xs-pdlr">
                <div class="row">
                    <div class="col-sm-4 col-md-3 sidebar  mb-25">
                        <ul class="sidebar-menu">
                            <li>
                                <a class="maincat">
                                      <span class="catcap"><b>CATEGORIES</b></span> 
                                  </a>
                            </li>
                            <li>
                                <div class="maincat">
                                    <input type="hidden" name="cathid" class="cathid" id="cathid" value="0">
                                    <input type="hidden" name="page" value="1">
                                    <i class="icon flaticon-research-work"></i>
                                    <span style="cursor: pointer;" class="cat" id="0" data-cat="All">All</span>
                                    <!-- <i class="fa fa-angle-left pull-right"></i> -->
                                </div>
                            </li>
                            {foreach $category as $key => $val}
                            <li>
                                {if $val.parent_id == 0}
                                <a class="maincat" href="#">
                                 {if $val.name == 'Flower'}
                                  <i class="icon flaticon-flower-with-leaves"></i>
                                 {elseif $val.name == 'Dry Concentrates'}
                                 <i class="icon flaticon-medicine-bottle"></i>
                                 {elseif $val.name == 'Oil Concentrates'}
                                 <i class="icon flaticon-oil-drum"></i>
                                 {elseif $val.name == 'Topicals'}
                                  <img src="/images/topicals.png" class="img-responsive" alt="">
                                 {elseif $val.name == 'Edibles'}
                                  <i class="icon flaticon-muffin"></i>
                                  {elseif $val.name != ''}
                                  <i class="icon flaticon-research-work"></i>
                                  {/if}

                                <span class="{$val.id} cat" id="{$val.id}" data-cat="{$val.name}" data-pcid="{$val.id}">{$val.name}</span><i class="fa fa-angle-left pull-right"></i>

                              </a> {/if}
                                <ul class="sidebar-submenu" style="display: none;">
                                    {foreach $category as $key2 => $val2} {if $val2.parent_id == $val.id}
                                    <li>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <i class="fa fa-angle-double-right" aria-hidden="true"></i>
                                                <a class="{$val.id} cat" id="{$val2.id}" data-pcid="{$val.id}" data-cat="{$val.name} >> {$val2.name}"> {$val2.name} </a>
                                            </div>
                                        </div>
                                    </li>
                                    {/if} {/foreach}
                                </ul>
                            </li>
                            {/foreach}
                            <li>
                                <a class="maincat">
                                    <span class="catcap"><b>TYPE</b></span> 
                                </a>
                                <li>
                        </ul>
                        <ul class="sidebar-submenu2 p0">
                            <li>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" value="1" id="buynow" class="buynow">
                                                <span class="cr"><i class="cr-icon fa fa-check"></i></span> Buy Now
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" value="2" id="nego" class="nego">
                                                <span class="cr"><i class="cr-icon fa fa-check"></i></span> Negotiable
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul> 
                    </div>
                    <div class="col-sm-8 col-md-9 right-content right-store">
                        <div class="row top-bar-row">
                            <div class="col-md-12 flex main-col">
                                <div class="col-md-8 margin-auto text-center">
                                    <div class="category-heading" id="categoryicon">
                                        <span class="icon flaticon-research-work"></span>All
                                    </div>
                                </div>
                                <div class="col-md-4 margin-auto">
                                    <input class="w80 p5-15 border1 input-radius search-input" placeholder="Search" id="srchtxt" type="text" name="" value="">
                                    <button type="button" name="button" class="input-radius green-b b search-btn srchtxt">
                                        <i class="fa fa-search white" aria-hidden="true"></i>
                                    </button>
                                </div>
                                <!-- <div class="col-md-3 margin-auto text-right">
                                    <select class="p15 grey-bg border-0 sort" name="">
                                        <option value="">Sort by price: Low to High</option>
                                    </select>
                                </div> -->
                                <!-- <div class="col-md-3">
                                  <h5 class="green-text">1-48 <span class="grey">of 100 results</span></h5>
                                </div> -->
                            </div>
                        </div>
                        <div class="ajaxappend">
                        </div>
                        
                        
                    </div>
                </div>
            </div>
            <!-- <div class="row">
            <div class="">
                <ul class="pagination-ul flex">
                    <a href="#"><li class="inactive"><span class="fa fa-angle-left"></span></li></a>
                    <a href="#"><li class="active">1</li></a>
                    <a href="#"><li>2</li></a>
                    <a href="#"><li>3</li></a>
                    <a href="#"><li>4</li></a>
                    <a href="#"><li><span class="fa fa-angle-right"></li></a>
                </ul>
            </div>
        </div> -->
        </div>
    </div>
    <!-- / page content  -->
    <!--/ header -->
</div>
<div class="modal fade" id="storeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="downPopUpArrow">&nbsp;</div>
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel"><b>{$phrase.add_products_to_store} </b></h4>
                <button type="button" onclick="window.location='{$config.url}/product/post/{$store.id}'" class="btn btn-default" style="font-size: 12px;">{$phrase.add_new_products} </button>
            </div>
            <div class="modal-body">
                <div class="col-md-12 viewaddproducts" style="height:600px;overflow-y:scroll;"> </div>
            </div>
            <div class="modal-footer" style="clear:both;"> </div>
        </div>
    </div>
</div>
{if $loged.userid > 0}
<div class="modal fade edit_crop_store">
    <div class="modal-dialog">
        <div class="modal-content" style="width:900px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">{$phrase.edit_banner}</h4>
            </div>
            <div class="modal-body">
                <div style="width:850px;overflow:hidden;height:300px;"><img src="{$config.url}/uploads/store/{$store.banner}" id="jcrop_target" /></div>
                <div class="modal-footer">
                    <form action="{$config.url}/stores/resize/banner" method="post" onsubmit="return checkCoords();">
                        <input type="hidden" id="x" name="x" />
                        <input type="hidden" id="id" name="id" value="{$store.id}" />
                        <input type="hidden" id="y" name="y" />
                        <input type="hidden" id="w" name="w" />
                        <input type="hidden" id="h" name="h" />
                        <input type="submit" value="Crop Image" style="float:left; width: 98px;" />
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade sendMessage">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">{$phrase.send_message}</h4>
            </div>
            <div class="modal-body">
                <p>
                    <form id="send-store-message" method="post" data-parsley-validate>
                        <input type="hidden" name="id" value="{$store.id}" />
                        <textarea name="message" rows="10" required class="form-control" data-parsley-required="true"></textarea>
                    </form>
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">{$phrase.close}</button>
                <button type="button" class="btn btn-primary" onclick="sendThis();">{$phrase.send}</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<div class="clear"></div>
{include file="common/footer-1.tpl" nocache}
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>
<script src="{$config.url}/js/mtree.js"></script>
<script src="{$config.url}/js/jcrop.js"></script>
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}/jcrop.css" />
<script type="text/javascript" src="{$config.url}/js/owl.carousel.js"></script> 
<!-- <script src="https://auctionsoftwaremarketplace.com:2002/js/owl.carousel.js"></script> -->
<script>
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

</script>
<script>
 $.sidebarMenu($('.sidebar-menu'));
$(document).ready(function() {

    var id = $('#storeid').val();
    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: '/searchstorepdts',
        data: 'ajax=1&cid=0&id=' + id,
        success: function(data) {
            $('.ajaxappend').html(data.html);
            //changeSubCategory

        }
    });

    $('.cat').click(function() {
        var cid = this.id;
        $('.cathid').val(cid);
        $('.activecat').removeClass('activecat');
        $('#' + cid).addClass('activecat');
        var catname = $(this).data('cat');
        var pcid = $(this).data('pcid') ? $(this).data('cat') : 'all';
        var buynow = $("#buynow").prop("checked") ? 1 : 0;
       //console.log('buynow', buynow);
        var nego = $("#nego").prop("checked") ? 2 : 0;
       //console.log(pcid);
        if (pcid == 102) {
            var bread = '<span class="icon flaticon-medicine-bottle"></span>' + catname;
        } else if (pcid == 101) {
            var bread = '<span class="icon flaticon-flower-with-leaves"></span>' + catname;
        } else if (pcid == 120) {
            var bread = '<span class="icon flaticon-muffin"></span>' + catname;
        } else if (pcid == 103) {
            var bread = '<span class="icon flaticon-oil-drum"></span>' + catname;
        } else if (pcid == 104) {
            var bread = '<img class="img-responsive" alt="" src="/images/topicals.png">' + catname;
        } else {
           //console.log("else");
            var bread = '<span class="icon flaticon-research-work"></span>' + catname;
        }


        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: '/searchstorepdts',
            data: 'ajax=1&cid=' + cid + '&id=' + id + '&buynow=' + buynow + '&nego=' + nego,
            success: function(data) {
               //console.log(bread);
                $('#categoryicon').html('');
                $('#categoryicon').html(bread);
                $('.ajaxappend').html(data.html);
                //changeSubCategory

            }
        });
    });



    $('.checkbox input:checkbox').click(function() {
       //console.log('running');
        var cathid = $('.cathid').val();
        var buynow = $("#buynow").prop("checked") ? 1 : 0;
        var nego = $("#nego").prop("checked") ? 2 : 0;
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: '/searchstorepdts',
            data: 'ajax=1&id=' + id + '&buynow=' + buynow + '&nego=' + nego + '&cid=' + cathid,
            success: function(data) {
               //console.log('data', data);
                $('.ajaxappend').html(data.html);
                //changeSubCategory

            }
        });
    });

    $('#negotiable').on('show.bs.modal', function(e) {
        var data = $(e.relatedTarget).data();
        $('.mprice', this).text(data.recordPrice);
        $('.userid', this).val(data.recordUserid);
        $('.mpriceval', this).val(data.recordPrice);
        $('.pdtid', this).val(data.recordPdt);
        $('.pdtcd', this).val(data.recordPdtc);
        //$('.btn-ok', this).data('recordId', data.pdt);
        //$('.btn-ok', this).data('recordId', data.userid);
    });

    $('#myModal').on('show.bs.modal', function(e) {
        var data = $(e.relatedTarget).data();

        $('.pdtid', this).val(data.recordPdt);
        $('.project_id', this).val(data.recordPdt);
        $('.pdtcdb', this).val(data.recordPdtc);
        //$('.btn-ok', this).data('recordId', data.pdt);
        //$('.btn-ok', this).data('recordId', data.userid);
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
            //$('.qtyreq').val(pdtcd);
            $('.tqtytext').html("Available quantity is:" + pdtcd);
            return false;
        }
        /* if(priceoffer == ''){
           //$('.priceoffer').css('border','1px solid red');
           return false;
         }
         if(qtyreq == ''){
            //$('.qtyreq').css('border','1px solid red');
           return false;
         }*/
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: '/bidplace',
            data: $('.negoform').serialize(),
            success: function(data) {
                //$('.ajaxappend').html(data.html);
                //changeSubCategory
                if (data.success == 1) {
                   //console.log("sfsdfsdf" + pdtid);
                    $('#negotiable').modal('hide');
                    $("#" + pdtid).find("button").prop("disabled", true);
                    // $("#"+pdtid).prop("disabled",true);
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

function searchForm() {
    var buynow = $("#buynow").prop("checked") ? 1 : 0;
    var nego = $("#nego").prop("checked") ? 2 : 0;
    var id = $('#storeid').val();
    var cidh = $('.cathid').val();
    var page = $('input[name="page"]').val();
    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: '/searchstorepdts',
        data: 'ajax=1&cid=' + cidh + '&id=' + id + '&buynow=' + buynow + '&nego=' + nego + '&page=' + page,
        success: function(data) {
            //$('.category-heading').html(bread);
            $('.ajaxappend').html(data.html);
            //changeSubCategory

        }
    });
}

function check_qty() {
    var rqtys1, tpdtc1 = '';
    $('.rqty').val($('.rqty').val().replace(/\D/g,''));
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
    
    $('.qty_add').val($('.qty_add').val().replace(/\D/g,''));
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
            var transaction_count = parseInt($("#reccurCount").val());
            var vali = $('#recurpur').parsley().validate();
            if (vali === false) { return false; }


            if (rqtys > tpdtc) {
                //console.log("hjhjhjh");
                rqtys = tpdtc;
                //$('.rqty').val(tpdtc);
                $('.tqtytext').html("Available quantity is:" + tpdtc);
                return false;
            }
            if((rqtys*(transaction_count+1)) > tpdtc) {
                $('.tqtytext').html("Requested quantity exceeding the available quantity, please enter a lower value.");
                return false;
            }
            

            var params = $('.recurpur').serialize();
            $.ajax({
                type: 'GET',
                dataType: 'json',
                url: '/product/cartrecurring/' + pdid + '?qty=' + $('.rqty').val(),
                data: params,
                success: function(data) {

                    $('#myModal').modal('hide');

                    if (data.success) {
                       //console.log(data)
                         if (data.add) {

                            window.location = '{$config.url}/product/checkout/cart/'

                        } else if (!data.membership_status) {

                            window.location = '{$config.url}/package'

                        }else if (!data.login) {

                            window.location = '{$config.url}/login'

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


$(document).ready(function() {
    $(window).load(function() {
        if ($('.banimg').length > 0) {
            var height = $('.banimg').css('height');
            height = Number(height.replace('px', '')) / 195;
            height = Math.round(height) - 1;
            var ratio = (height * 2) + 1;
            var fheight = ratio * 195;
            var lheight = height * -195;
            $('#dvPreview3').css('height', fheight);
            $('#dvPreview3').css('top', lheight);
            // $('.loader_div').hide();
        } else {
            //$('.loader_div').hide();
        }
    });
    if ($('[attr-selected-cat]').length > 0) {
        var selected_ids = $('[attr-selected-cat]').attr('attr-selected-cat');
        selected_ids = selected_ids.split(",");
        if (selected_ids.length > 0) {
            var temp_html = '';
            for (var i = 0; i < selected_ids.length; i++) {
                temp_html += '<div class="col-md-12 bestseller_block">\
                        <div class="panel panel-default">\
                            <div class="panel-heading clearfix featured_heading" style="font-weight: bold;">\
                                <div class="pull-left category_title ftnclr">' + selected_ids[i] + ' </div>\
                            </div>\
                            <div class="panel-body" catid="' + selected_ids[i] + '">\
                            </div>\
                        </div>\
                    </div>';
            }
            $('.product_append_div').html(temp_html);

            $('[catid]').each(function() {
                var tempval = $('[attr-pcat-id="' + $(this).attr('catid') + '"]').detach();
                $(this).html(tempval);
            });
            $('[attr-pcid]').each(function() {
                var pcid = $(this).attr('attr-pcid');
                if (selected_ids.indexOf(pcid) < 0) {
                    $(this).remove();
                }
            });

            if ($('.order_details').length > 0) {
                $('.order_details').each(function() {
                    var ids = $(this).attr('order-pro-ids');
                    ids = ids.split(',');
                    if ($(this).attr('order-catid') == 0) {
                        var html = '';
                        for (pid in ids) {
                            html = $('#owlfdemo [attr-product-id="' + ids[pid] + '"]').detach();
                            $('#owlfdemo').append(html);
                        }
                    } else if ($(this).attr('order-catid') != 0) {
                        var cid = $(this).attr('order-catid');
                        var html = '';
                        for (pid in ids) {
                            html = $('[catid="' + cid + '"] [attr-product-id="' + ids[pid] + '"]').detach();
                            $('[catid="' + cid + '"]').append(html);
                        }
                    }
                });
            }
            $('[catid]').each(function() {
                var cid = $(this).attr('catid');
                $('[catid="' + cid + '"]').owlCarousel({
                    autoPlay: false,
                    items: 5,
                    navigation: true
                    // navigationText: [
                    //     "<img src='{$config.url}/images/b_arrow.png' class='img-responsive'/>",
                    //     "<img src='{$config.url}/images/f_arrow.png' class='img-responsive'/>"
                    // ]
                });
            });
            $("#owlfdemo").owlCarousel({
                autoPlay: false,
                items: 5,
                navigation: true
                // navigationText: [
                //     "<img src='{$config.url}/images/b_arrow.png' class='img-responsive'/>",
                //     "<img src='{$config.url}/images/f_arrow.png' class='img-responsive'/>"
                // ]
            });
            $('.bestseller_block .panel-body').each(function() {
                if ($(this).find('[attr-product-id]').length == 0) {
                    $(this).css('opacity', '10');
                    $(this).html('<div class="text-center ftn600 ftn18">No products</div>');
                }
            });
            $('.tempappend').remove();
        }
    }
    $(".category_title").each(function() {
        var cat = Number($(this).text());
        var title = '';
        $('.selected_categories option').each(function() {
            if (Number($(this).val()) == cat) {
                title = $(this).text();
            }
        });
        if (title.trim() == '') {
            $(this).closest('.bestseller_block').remove();
        } else {
            $(this).text(title);
        }
    });
    //--------------------------------------------------------------------//
    if ($('[attr-selected-cat]').length > 0) {
        var selected_ids = $('[attr-selected-cat]').attr('attr-selected-cat');
        selected_ids = selected_ids.split(",");
        if (selected_ids.length > 0) {
            var html = '';
            $('.selected_categories option').each(function() {
                if (Number($(this).attr('parentid')) == 0) {
                    if (selected_ids.indexOf($(this).val()) > -1) {
                        html += '<button type="button" class="btn btn-default" value=' + $(this).val() + '>' + $(this).html() + '</button>';
                    }
                }
            });
            if (html == '') {
                $('.added_categories').html('No categories');
            } else {
                $('.added_categories').html('<button type="button" class="btn btn-default" value="0">All</button>' + html);
            }
            $('.selected_categories').remove();
        }
    }

    $("body").on('keyup', '#ssearch', function() {
        var s_txt = $(this).val().trim().toLowerCase();
        if (s_txt != '') {
            $('.pro_head').each(function() {
                var val = $(this).text().trim().toLowerCase();
                if (val.indexOf(s_txt) > -1) {
                    $(this).closest('[attr-product-id]').css('display', 'block');
                } else {
                    $(this).closest('[attr-product-id]').css('display', 'none');
                }
            });
        } else {
            $('[attr-product-id]').css('display', 'block');
        }
    }).on('click', '.added_categories button', function() {
        if ($(this).val() == 0) {
            if ($(this).hasClass('active') == true) {
                $('.added_categories button').removeClass('active');
            } else {
                $('.added_categories button').addClass('active');
            }
        } else {
            if ($(this).hasClass('active') == true) {
                $(this).removeClass('active');
            } else {
                $(this).addClass('active');
            }
            var i = 0;
            $('.added_categories button').each(function() {
                if ($(this).hasClass('active') == true && $(this).val() != 0) {
                    i++;
                }
            });
            if (i == $('.added_categories button').length - 1) {
                $('.added_categories button').addClass('active');
            } else {
                $('.added_categories button').first().removeClass('active');
            }
        }
        $('.added_categories button').each(function() {
            if ($(this).hasClass('active') == true) {
                $('[catid="' + $(this).val() + '"]').closest('.bestseller_block').css('display', 'block');
            } else {
                $('[catid="' + $(this).val() + '"]').closest('.bestseller_block').css('display', 'none');
            }
        });
    });

    $('.owl-prev').removeClass('fa').removeClass('fa-chevron-left');
    $('.owl-next').removeClass('fa').removeClass('fa-chevron-right');
});
</script>
<script language="javascript" type="text/javascript">
function view_store() {
    window.location = confurl + '/stores/view/' + storeid;
}

function paginationStore(page) {
    $('#page').val(page);
    searchStoreProduct();
}

function restrictCategory(cid) {
   //console.log(cid);
    $('#cid').val(cid);
    searchStoreProduct();
}

function searchStoreProduct() {

    var params = $('.searchform').serialize();
    $.ajax({
        type: 'GET',
        url: '/stores/view/ajax/{$store.id}',
        data: params,
        success: function(data) {
           //console.log(data);
            $('.store-inner').html(data);
            //changeSubCategory

        }
    });

}

function addProducts() {

    $.ajax({
        type: 'GET',
        url: '/stores/add/{$store.id}',
        dataType: 'JSON',
        success: function(data) {
           //console.log(data);
            $('.viewaddproducts').html(data.html);
            $('#storeModal').modal('show');
            addFProducts();
            //changeSubCategory



        }
    });
}

function addFProducts() {

    $.ajax({
        type: 'GET',
        url: '/stores/feature/{$store.id}',
        success: function(data) {
            $('.carousel_content').html(data);
        }
    });
}

function addStore(id, sid) {
    $.ajax({
        type: 'GET',
        url: '/stores/addproduct/' + id + '/' + sid,
        success: function(data) {
            $('.product_add_' + id).remove();
            showCategory();

        }
    });

}

function showCategory() {
    $.ajax({
        type: 'GET',
        url: '/stores/category/{$store.id}',
        success: function(data) {
           //console.log(data);
            $('.storecategory').html(data);
            searchStoreProduct();
            mtree();
        }
    });

}
$(function() {
    mtree();
   //console.log(5);
    $('#myCarousel').carousel({
        interval: 3000
    });

});
</script>
<div id="fb-root"></div>
<!-- <script>
(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s);
    js.id = id;
    js.src = "//connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v2.4";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
</script> -->

{/if}
<script>
$('#filecount').filestyle({
    input: true,
    buttonName: '',
    iconName: 'fa fa-pencil',
    buttonText: ''
});
</script>
<script type="text/javascript">
/*$(function() {
    $('.checkbox_insurance').hide();

    $("input[name=insurance]:radio").click(function() {

        if ($('input[name=insurance]:radio').val() == 1) {
            $('.checkbox_insurance').toggle();
        } 
        
    });
});*/
$(function() {
    // $('.terms').hide();

    $("input[name=terms-name]:checkbox").click(function() {

        if ($('input[name=terms-name]:checkbox').val() == "terms") {
            // $('.terms').toggle();

        } else if ($('<input type="text" name="radio" />').val() == "terms") {
            $('.testresult').hide();


        }
    });
});
$('.modal').on('hidden.bs.modal', function () {
   $("#myModal input").val("");
   $(".tqtytext").text("");
   // $(".text-error").hide();
});  


</script>