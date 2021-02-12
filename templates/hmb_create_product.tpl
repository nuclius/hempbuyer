{include file="/common/header-1.tpl" nocache}
<!-- page content  -->
<link  href="{$config.url}/css/cropper.css" rel="stylesheet">
<script src="{$config.url}/js/cropper.js"></script>
<script src="{$config.url}/js/jquery-cropper.min.js"></script>
{* <script src="https://cdnjs.cloudflare.com/ajax/libs/cropper/4.1.0/cropper.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-cropper@1.0.1/dist/jquery-cropper.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropper/4.1.0/cropper.css"> *}

<script src="{$config.url}/js/image-compressor.js"></script>
<script src="https://github.com/eligrey/canvas-toBlob.js/blob/master/canvas-toBlob.js"></script>
{* <script src="{$config.url}/js/cropzee.js"></script> *}
<!-- toggle Style starts -->
<style>
    .switch {
      position: relative;
      display: inline-block;
      width: 60px;
      height: 34px;
    }

    .switch input {
      opacity: 0;
      width: 0;
      height: 0;
    }

    .slider {
      position: absolute;
      cursor: pointer;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background-color: #ccc;
      -webkit-transition: .4s;
      transition: .4s;
    }

    .slider:before {
      position: absolute;
      content: "";
      height: 26px;
      width: 26px;
      left: 4px;
      bottom: 4px;
      background-color: white;
      -webkit-transition: .4s;
      transition: .4s;
    }

    input:checked + .slider {
      background-color: #5E9836;
    }

    input:focus + .slider {
      box-shadow: 0 0 1px #5E9836;
    }

    input:checked + .slider:before {
      -webkit-transform: translateX(26px);
      -ms-transform: translateX(26px);
      transform: translateX(26px);
    }

    /* Rounded sliders */
    .slider.round {
      border-radius: 34px;
    }

    .slider.round:before {
      border-radius: 50%;
    }
    .save_and_close {
        min-width: 132px !important;
        height: 32px !important;
        border-radius: 2px !important;
        font-size: 12px !important;
        line-height: 18px !important;
        text-align: center !important;
        color: #fff !important;
    }
    .remove_this {
        height: 48px;
        border-radius: 5px;
    }
    </style>

<!-- toggle Style end -->

<style>
.save_and_close {
    font-size: 12px;
    line-height: 11px;
    min-width: 132px;
}
.step_data {
    display: none;
}
.image-loader {
    color: #5e9836;
}
#certificateDocumentList, #productDocumentList {
    margin: 0px 0px 15px 10px;
    cursor: pointer;
}
.image-item .fa-trash {
    color: #ff0000;
}
		.image-previewer {
			height: 300px;
			width: 300px;
			display: flex;
			border-radius: 10px;
			border: 1px solid lightgrey;
		}
        .light-modal-content {
            width: 40vw !important;
        }

input[type=checkbox][disabled] {
    opacity: 0.7;
    cursor: not-allowed;
}
input[type=checkbox][disabled] ~ label {
    opacity: 0.7;
    cursor: not-allowed;
}
input[type=checkbox][disabled] ~ .checkmark {
    opacity: 0.7;
    cursor: not-allowed;
}
</style>
<div class="dashboard-container">
    {include file="/common/header-2.tpl" nocache}

    <div class="container">
        <h2 class="pp-head">POST YOUR PRODUCT</h2>
        <div class="steps-wrapper">
            <div class="clearfix step1">
                <div class="step-item active">1</div>
            </div>
            <div class="clearfix step2">
                <div class="step-item">2</div>
            </div>
            <div class="clearfix step3">
                <div class="step-item">3</div>
            </div>
            <div class="clearfix step4">
                <div class="step-item">4</div>
            </div> 
        </div>

        <!-- start step 1 -->
        <div id="step1_data" class="step_data active">
        <div class="container">
    <div class="row">
        <div class='col-sm-6'>
            <div class="form-group">
            <div class='col-sm-6'>
            </div>
                
            </div>
        </div>
        
    </div>
</div>
            <h3 class="ppf-title">PRODUCT AUCTION AND FIXED PRICE INFO</h3>
            <form class="pp-form product_form bg-gray" data-parsley-validate novalidate id="step1_form">
                <input type="hidden" id="product_id" value="{$product.id}">
                <div class="row">
                    <div class="col-sm-6 form-group">
                        <label class="pp-label">Category</label>
                        <div class="clearfix cselec-wrap-remove cselec-wrap">
                            <select class="custom-select" name="category_id" id="category_id" required data-parsley-errors-container="#category-err" data-parsley-required-message="Category is required.">
                                <option value="">Select Category</option>
                                {foreach $categories as $key => $val}
                                    <option value="{$val.id}" {if $product.category_id==$val.id} selected {/if}>{$val.name}</option>
                                {/foreach}
                            </select>
                        </div>
                        <span id="category-err" class="err-message"></span>
                    </div> 
                    <div class="col-sm-6 form-group">
                        <label class="pp-label">Subcategory</label>
                        <div class="clearfix cselec-wrap-remove cselec-wrap">
                            <select class="custom-select" name="subcategory_id" id="subcategory_id" >
                                <option value="" selected>Select Subcategory</option>
                            </select>
                        </div>
                        <span id="subcategory-err" class="err-message"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 form-group">
                        <label class="pp-label">Product Title</label>
                        <input class="form-control"
                            placeholder="Product Title - Use words your buyers will search for." name="title" id="title" required data-parsley-required-message="Product Title is required." value="{$product.title}" />
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-6 col-md-6 form-group suply">
                        <label class="pp-label">Unit of Measurement</label>
                        <div class="clearfix cselec-wrap-remove cselec-wrap">

                        <select class="custom-select" name="unit_of_measurement"  style="height: 47px;" id="unit_of_measurement" required data-parsley-required-message="Measurement is required.">
                            <option value="" >Select Measurement</option>
                            {if $product.productMeasurements.length > 0}
                                {foreach $product.productMeasurements as $key => $val}
                                    <option value="{$val.unit_name}" {if $product.unit_of_measurement==$val.unit_name} selected {/if}>{$val.unit_name}</option>
                                {/foreach}
                            {/if} 
                        </select>
                        </div>
                    </div>

                    <div class="col-sm-6 col-md-6 form-group suply" id="total_amount_available_div" style="{if $product.type=='offer'}display: none;{/if}">
                        <label class="pp-label">Total Amount Available</label> 
                        <input class="form-control" placeholder="Enter how many/total quantity being sold" name="amount_sold" id="amount_sold" required data-parsley-required-message="Amount is required."  onkeypress='return isNumberKey(event)' min="1" />
                    </div>

                    <!-- <div class="col-sm-6 col-md-4 form-group suply" id="moq_div" style="{if $product.type=='fixed' || $product.type=='offer'}display: none;{/if}">
                        <label class="pp-label">MOQ</label>
                            <input class="form-control moqqty"
                            placeholder="Minimum Order Quantity" name="moq" id="moq" required data-parsley-required-message="MOQ is required." value="{$product.moq}" onkeypress='return isNumberKey(event)' />
                    </div> -->
                </div> 
                <hr class="pp-divider" />
                <div class="form-inline check-group">
                    <div class="cus-check form-group">
                        <input type="checkbox" id="auction_check" name="type" class="typeCheckbox" {if $product.type=='auction' || !$product.id}checked{/if} value="auction">
                        <span class="checkmark"></span> <label for="auction_check">Auction</label>
                    </div> 
                    {*  {if $action == 'relist'}disaply: none;{/if} *}
                    <div class="cus-check form-group" style="width: 26%;">
                        <input type="checkbox" id="fp-price_check" name="type" class="typeCheckbox" value="fixed" {if $product.type=='fixed'}checked{/if} {if $action == 'relist'}disabled{/if}>
                        <span class="checkmark"></span> <label for="fp-price_check">Fixed Priced Product</label>
                    </div>
                    <div class="cus-check form-group" style="width: 26%;">
                        <input type="checkbox" id="ofr-price_check" name="type" class="typeCheckbox" value="offer" {if $product.type=='offer'}checked{/if} {if $action == 'relist'}disabled{/if}>
                        <span class="checkmark"></span> <label for="ofr-price_check">Make an Offer</label>
                    </div>
                </div>
                <hr class="pp-divider" />
                <div id="auction" class="typeDiv {if $product.type=='auction' || !$product.id}active{/if}">
                    <div class="row">
                        <div class="col-sm-6 form-group">
                            <label class="pp-label ppl_tool_tip">
                                Start Price 
                           <span class="reg-info"><img src="{$config.url}/images/info.png" alt=""></span>
                            <span class="reg_info_text"> 
                                <p>Start Price is the least amount a bidder is allowed to bid in an auction. If your reserve price is not met, your not obligated to sell your product.</p>
                            </span>
                            
                            
                            </label>
                            <input class="form-control" placeholder="Start Price" name="start_price" onkeypress='return isNumberKey(event)' id="start_price" required data-parsley-required-message="Start Price is required." value="{$product.start_price}" />
                            <span id="serror"></span>
                        </div>
                        <div class="col-sm-6 form-group">
                            <label class="pp-label ppl_tool_tip">
                                Reserve Price 
                            <span class="reg-info"><img src="{$config.url}/images/info.png" alt=""></span>
                            <span class="reg_info_text">
                                <p>A reserve price is the least amount you are willing to sell your item for.</p>
                            </span>
                            
                            </label>
                            <input class="form-control" onkeypress='return isNumberKey(event)' placeholder="Reserve Price" name="reserve_price" id="reserve_price" required data-parsley-required-message="Reserve Price is required." value="{$product.reserve_price}" />
                            <span id="rerror"></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 form-group" style="display: inline-flex;">
                            <div class="col-sm-2" style="padding-left: 0;">
                                <label class="pp-label">
                                    Buy Now
                                </label>
                            </div>
                            <div class="col-sm-10">
                                <label class="switch" >
                                    <input id="buy-now_check" class="typeCheckbox" name="is_buynow" value="1" {if $product.is_buynow=='1'}checked{/if} type="checkbox">
                                    <span style="cursor: pointer;" class="slider round"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="buy-now" class="typeDiv {if $product.type=='auction' && $product.is_buynow=='1'}active{/if}">
                    <div class="row">
                        <div class="col-sm-6 form-group">
                            <label class="pp-label ppl_tool_tip">Buy Now Price 
                                <span class="reg-info"><img src="{$config.url}/images/info.png" alt=""></span>
                                <span class="reg_info_text">
                                    <p>Buy Now Price is your price per unit of measurement. Example: $10 per lb or $2 per gram</p>
                                </span>
                            </label>
                            <input class="form-control" placeholder="Buy Now Price" name="buynow_price" id="buynow_price" required data-parsley-required-message="Buy Now Price is required." value="{$product.buynow_price}" onkeypress='return isNumberKey(event)' />
                            <span id="berror"></span>
                        </div>
                        <div class="col-sm-6 form-group">
                            <label class="pp-label">Quantity</label>
                            <input class="form-control qty" placeholder="Quantity" name="buynow_qty" id="buynow_qty" required data-parsley-required-message="Quantity is required." value="{$product.buynow_qty}" onkeypress='return isNumberKey(event)' />
                            <span id="buynowqty_error"></span>
                        </div>
                    </div>
                </div>
                <div id="fp-price" class="typeDiv {if $product.type=='fixed'}active{/if}">
                    <div class="row">
                        <div class="col-sm-6 form-group">
                            <label class="pp-label">Fixed price</label>
                            <input class="form-control" placeholder="Fixed price" name="fixed_price" id="fixed_price" required data-parsley-required-message="Fixed price is required." value="{$product.fixed_price}" onkeypress='return isNumberKey(event)' />
                            <span id="fixedprice_error"></span>
                        </div>
                        <div class="col-sm-6 form-group">
                            <label class="pp-label">Quantity</label>
                            <input class="form-control qty" placeholder="Quantity" name="fixed_qty" id="fixed_qty" required data-parsley-required-message="Quantity is required." value="{$product.fixed_qty}" onkeypress='return isNumberKey(event)' />
                            <span id="fixedqty_error"></span>
                        </div>
                    </div>
                </div>
                <div id="ofr-price" class="typeDiv {if $product.type=='offer'}active{/if}">
                    <div class="row">
                        <div class="col-sm-6 form-group">
                            <label class="pp-label">Offer price</label>
                            <input class="form-control" placeholder="Offer price" name="offer_price" id="offer_price" required data-parsley-required-message="Offer price is required." value="{$product.offer_price}" onkeypress='return isNumberKey(event)' />
                            <span id="offerprice_error"></span>
                        </div>
                        <div class="col-sm-6 form-group">
                            <label class="pp-label">MOQ Offer Qty</label>
                            <input class="form-control qty" placeholder="MOQ Offer Qty" name="offer_qty" id="offer_qty" required data-parsley-required-message="MOQ Offer Qty is required." value="{$product.offer_qty}" onkeypress='return isNumberKey(event)' />
                            <span id="offerqty_error"></span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 form-group">
                        <label class="pp-label">Description</label>
                        <textarea rows="4" class="form-control" name="description" id="description"
                            placeholder="Enter Description - Include anything that will help buyers make an informed purchase decision. Provide as much detail about your product as possible." required data-parsley-required-message="Description is required.">{$product.description}</textarea>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-md-4 form-group">
                        <label class="pp-label">Start Date</label>
                        <div class="cal-input">
                            <input style="background: white; cursor: pointer;" class="form-control" placeholder="Start Date" name="start_date" id="start_date" autocomplete="off" required data-parsley-required-message="Start Date is required." data-parsley-errors-container="#start_date-err" data-parsley-trigger="change" value="{if $product.start_date != '00-00-0000 00:00:00'}{$product.start_date}{/if}" />
                            <span class="cal-img">
                                <img src="{$config.url}/images/calendar.png" alt="calendar" />
                            </span>
                        </div>
                        <span id="start_date-err" class="text-danger"></span>
                    </div>
                    <div class="col-sm-6 col-md-4 form-group">
                        <label class="pp-label ppl_tool_tip">End Date  
                            <span class="reg-info auction" style="display: block;"><img src="{$config.url}/images/info.png" alt=""></span>
                            <span class="reg_info_text auction" style="display: block;">
                                <p>Maximum length of an auction is 10 days.</p>
                            </span>
                            <span class="reg-info fixedprice" style="display: none;"><img src="{$config.url}/images/info.png" alt=""></span>
                            <span class="reg_info_text fixedprice" style="display: none;">
                                <p>Maximum length of a fixed priced listing is 30 days.</p>
                            </span>
                        </label>
                        <div class="cal-input">
                            <input style="background: white; cursor: pointer;" class="form-control" placeholder="End Date" name="end_date" id="end_date" autocomplete="off" required data-parsley-required-message="End Date is required." data-parsley-errors-container="#end_date-err" data-parsley-trigger="change" value="{if $product.end_date != '00-00-0000 00:00:00'}{$product.end_date}{/if}" />
                            <span class="cal-img">
                                <img src="{$config.url}/images/calendar.png" alt="calendar" />
                            </span>
                        </div>
                        <span id="end_date-err" class="text-danger"></span>
                    </div>

                    <div class="col-sm-6 col-md-4 form-group">
                        <label class="pp-label">Automatically Renew</label>
                        <div class="cselec-wrap">
                            <select class="custom-select" name="product_renew" id="product_renew" style="height: 47px;"> 
                                <option value="0" {if $product.renew==0}selected{/if}>Automatically Renew Period</option>
                                {foreach $renewTime as $key => $val}
                                    <option value="{$val.id}" {if $product.renew==$val.id}selected{/if}>{$val.val}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12 form-group"> 
                        <label class="pp-label">Product Images
                            <i class="fa fa-spinner fa-spin image-loader" id="productDocumentLoader" style="display: none;"></i>
                            <a id="cancel_image_upload" href="javascript:void(0)" style="display: none;">Cancel</a>
                            <p class="note-txt doc1">
                                &nbsp;&nbsp;&nbsp;Upload product images ( JPEG, PNG )
                            </p>
                        </label>

                        <div class="upload-document">
                            <input type="file" class="form-control" name="productDocument" accept=".png, .jpeg, .jpg" id="cropzee-input" onchange="startCrop(this)">
                            <div class="btxt">UPLOAD IMAGE FILE</div>
                            {* <button class="btn btn-primary">
                                UPLOAD IMAGE FILE
                            </button>  *}
                            <div class=" text-center">Max Image File Size (5MB)</div>
                            <div id="pError" style="color:red">Please upload product image.</div>
                        </div>
                        <label style="color: red;" >*First Image will be set as primary thumbnail of product.</label>
                    </div>
                    <div id="productDocumentList" class="pro-img-list">
                        {if $product.productImages.length > 0}
                            {foreach $product.productImages as $key => $val}
                                <div class="image-item" id="proddoc_{$key+1}"><img src="{$config.url}/uploads/product/{$val.avatar}" alt="No Image Available" onerror="this.onerror=null;this.src='/no_image.png';" style="margin:0px;width:100px; height:70px;"> <a data-name="{$val.avatar}" href="javascript:void(0)" class="removeProductDocument">Remove</a></div>
                            {/foreach}
                        {/if}
                    </div>
                </div>

                <div class="row">
                    {if $product.id>0}
                        {if $product.productVideos.length>0}
                            <div class="col-12" id="appendVideoUrl">
                                {foreach $product.productVideos as $k => $v}
                                    {if $k==0}
                                        <label class="pp-label ppl_tool_tip">Vimeo / YouTube Video Link 
                                            <span class="reg-info auction" style="display: block;">
                                                <img src="{$config.url}/images/info.png" alt="">
                                            </span>
                                            <span class="reg_info_text" style="display: block;">
                                                <p class="p-2">1. YouTube link like https://www.youtube.com/watch?v=xyz</p>
                                                <p class="p-2">2. Vimeo link like https://player.vimeo.com/video/xyz</p>
                                                
                                            </span>
                                            {* <span style="color: red;">(Be sure to use the link NOT the share link.)</span> *}
                                        </label>
                                        <div class="row"> 
                                            <div class="col-md-10 col-sm-8 form-group pr-sm-0">
                                                <input type="url" class="form-control embed_video" placeholder="Vimeo / YouTube Video Link" name="embed_video[]" id="embed_video" value="{$v.avatar}" data-parsley-type="url" />
                                            </div>
                                            <div class="col-md-2 col-sm-2 form-group pl-sm-1">
                                                <button class="btn btn-info" type="button" id="append" name="append">Add Video Link</button>
                                            </div> 
                                        </div>
                                    {else/}
                                        <!-- <div class="col-12 form-group"> -->
                                            <div class="row">
                                                <div class="col-sm-10 form-group pr-sm-0">
                                                    <input type="url" class="form-control embed_video" placeholder="Vimeo / YouTube Video Link" name="embed_video[]" id="embed_video" value="{$v.avatar}" data-parsley-type="url" />
                                                </div>
                                                <div class="col-sm-2 form-group pl-sm-1">
                                                    <button class="btn btn-danger remove_this" type="button">Remove</button>
                                                </div>
                                            </div>
                                        <!-- </div> -->
                                    {/if}
                                {/foreach}
                            </div>
                        {else/}
                            <div class="col-12" id="appendVideoUrl">
                                <label class="pp-label ppl_tool_tip">Vimeo / YouTube Video Link 
                                    <span class="reg-info auction" style="display: block;">
                                        <img src="{$config.url}/images/info.png" alt="">
                                    </span>
                                    <span class="reg_info_text" style="display: block;">
                                        <p class="p-2">1. YouTube link like https://www.youtube.com/watch?v=xyz</p>
                                        <p class="p-2">2. Vimeo link like https://player.vimeo.com/video/xyz</p>
                                    </span>
                                    {* <span style="color: red;">(Be sure to use the link NOT the share link.)</span> *}
                                </label>
                                <div class="row"> 
                                    <div class="col-sm-10 form-group pr-sm-0">
                                        <input type="url" class="form-control embed_video" placeholder="Vimeo / YouTube Video Link" name="embed_video[]" id="embed_video" data-parsley-type="url" />
                                     </div>
                                    <div class="col-sm-2 form-group pl-sm-1">
                                    <button class="btn btn-info" type="button" id="append" name="append">Add Video Link</button>
                                    </div> 
                                </div>
                            </div>
                        {/if}
                    {else /}
                        <div class="col-12" id="appendVideoUrl">
                            <label class="pp-label ppl_tool_tip">Vimeo / YouTube Video Link 
                                <span class="reg-info auction" style="display: block;">
                                    <img src="{$config.url}/images/info.png" alt="">
                                </span>
                                <span class="reg_info_text" style="display: block;">
                                    <p class="p-2">1. YouTube link like https://www.youtube.com/watch?v=xyz</p>
                                    <p class="p-2">2. Vimeo link like https://player.vimeo.com/video/xyz</p>
                                </span>
                                {* <span style="color: red;">(Be sure to use the link NOT the share link.)</span> *}
                            </label>
                            <div class="row"> 
                                <div class="col-sm-10 form-group pr-sm-0">
                                    <input type="url" class="form-control embed_video" placeholder="Vimeo / YouTube Video Link" name="embed_video[]" id="embed_video" data-parsley-type="url" />
                                </div>
                                <div class="col-sm-2 form-group pl-sm-1">
                                    <button class="btn btn-info" type="button" id="append" name="append">Add Video Link</button>
                                </div>
                            </div>
                        </div>
                    {/if} 
                </div>
 
                {if $product.id=='' || $product.id=='0' || $draft!=''}
                    <div class="text-center mt-3"> 
                        <button class="sdp-link" type="button" id="saveToDraft">Save as draft</button>
                    </div>
                {/if}

                <div class="pp-btns-wrap">
                    <button class="btn btn-primary">NEXT</button>
                    {if $product.id > 0}
                        <button type="button" class="btn btn-info save_and_close">
                            {if $action == 'relist'}RELIST & CLOSE{else /}SAVE & CLOSE{/if}
                        </button>
                    {/if}
                </div>
                <div class="text-center">
                    <b>Note:</b><i>Your draft is automatically saved in the "Draft" section of your dashboard</i>
                </div>
            </form>
        </div>
        <!-- end step 1 -->

        <!-- start step 2 -->
        <div id="step2_data" class="step_data">
                <h3 class="ppf-title">MANUFACTURE AND PACKING INFO</h3>
                <form class="pp-form product_form bg-gray" data-parsley-validate novalidate id="step2_form">
                    <div class="row">
                        <div class="col-12 form-group">
                            <label class="pp-label">Packaging & Storage Description</label>
                            <textarea class="form-control" rows="4" placeholder="Packaging & Storage Description" name="packaging_description" id="packaging_description" required data-parsley-required-message="Packaging & Storage Description is required.">{$product.packaging_description}</textarea>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 form-group">
                            <label class="pp-label ppl_tool_tip">Keywords 
                                <span class="reg-info"><img src="{$config.url}/images/info.png" alt=""></span>
                                <span class="reg_info_text"> 
                                    <p>More than one keywords, keywords should be in comma(,) separated. Eg: Keyword1,Keyword2,etc...</p>
                                </span>
                            </label>
                            <textarea class="form-control" style="height: 70px;" rows="2" placeholder="Keywords" name="keywords" id="keywords" required data-parsley-required-message="Keywords">{$product.keywords}</textarea>
                        </div>
                    </div>
                    <div class="row"> 
                        <div class="col-sm-6 form-group suply1">
                            <label class="pp-label">
                               Date of Manufacture or Harvest
                           </label>
                           <div class="cal-input">
                                <input class="form-control" placeholder="Date of Manufacture or Harvest" name="manufacture_date" id="manufacture_date" autocomplete="off" required data-parsley-required-message="Date of Manufacture is required." data-parsley-errors-container="#manufacture_date-err" data-parsley-trigger="change" value="{if $product.manufacture_date != '00-00-0000'}{$product.manufacture_date}{/if}" />
                                <span class="cal-img">
                                    <img src="{$config.url}/images/calendar.png" alt="calendar" />
                                </span>
                            </div>
                            <span id="manufacture_date-err" class="err-message"></span>
                        </div>
                        <div class="col-sm-6 form-group doc2">
                            <label class="pp-label">
                                Quantity Available
                           </label>
                           <div class="cal-input">
                                <input class="form-control" placeholder="Quantity available" name="qty_available" onkeypress='return isNumberKey(event)' id="qty_available" required data-parsley-required-message="Quantity available is required" value="{$product.qty_available}" />
                                </div>
                            <span id="manufacture_date-err" class="err-message"></span>
                        </div>
                        <div class="col-sm-6 form-group">
                            <label class="pp-label">
                                Location of Product
                            </label>
                            <div class="clearfix cselec-wrap-remove cselec-wrap">
                                <select class="custom-select" name="product_place" id="product_place" required data-parsley-required-message="Location of product is required" style="height: 47px;">
                                    <option value="">Select Location of Product</option>
                                    {foreach $states as $key => $val}
                                    <option value="{$val.abbrev}" {if $product.product_place==$val.abbrev} selected {/if}>{$val.name}</option>
                                {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>
                    {if $product.id=='' || $product.id=='0' || $draft!=''}
                        <div class="text-center mt-3"> 
                            <button class="sdp-link" type="button" id="saveToDraft">Save as draft</button>
                        </div>
                    {/if}
                    <div class="pp-btns-wrap">
                        <button class="btn btn-prev previous_btn" type="button" onclick="gotoStep(1)">PREV</button>
                        <button class="btn btn-primary">NEXT</button>
                        {if $product.id > 0}
                            <button type="button" class="btn btn-info save_and_close">
                                {if $action == 'relist'}RELIST & CLOSE{else /}SAVE & CLOSE{/if}
                            </button>
                        {/if}
                    </div>
                    <div class="text-center">
                        <b>Note:</b><i>Your draft is automatically saved in the "Draft" section of your dashboard</i>
                    </div>
                </form>
        </div>
        <div id="step3_data" class="step_data">
            <h3 class="ppf-title">CERTIFICATE OF ANALYSIS (COA) & CERTIFICATIONS</h3>
            <form class="pp-form product_form bg-gray" data-parsley-validate novalidate id="step3_form">
                <div class="form-inline form-group check-group suply2" id="ctype_div">

                    <div class="w-100 text-left">
                        <label class="pp-label float-left">Click on your product Attributes</label><br><br>
                    </div>

                    <div class="form-group toggle_checkbox_div">
                        <input type="checkbox" name="ctype_certified_organic" id="ctype_certified_organic" value="certified_organic" {if $product.certificate_types[0]=='certified_organic'}checked{/if}>
                        <label for="ctype_certified_organic" class="toggle_checkbox">Certified Organic</label>
                    </div>
                    <div class="form-group toggle_checkbox_div">
                        <input type="checkbox" name="ctype_gmp" id="ctype_gmp" value="gmp" {if $product.certificate_types[1]=='gmp'}checked{/if}>
                        <label for="ctype_gmp" class="toggle_checkbox">GMP</label>
                    </div>
                    <div class="form-group toggle_checkbox_div">
                        <input type="checkbox" name="ctype_iso" id="ctype_iso" value="iso" {if $product.certificate_types[2]=='iso'}checked{/if}>
                        <label for="ctype_iso" class="toggle_checkbox">ISO</label>
                    </div>
                    <div class="form-group toggle_checkbox_div">
                        <input type="checkbox" name="ctype_kosher" id="ctype_kosher" value="kosher" {if $product.certificate_types[3]=='kosher'}checked{/if}>
                        <label for="ctype_kosher" class="toggle_checkbox">Kosher</label>
                    </div>

                    <div class="form-group toggle_checkbox_div">
                        <input type="checkbox" name="ctype_sqf" id="ctype_sqf" value="sqf" {if $product.certificate_types[4]=='sqf'}checked{/if}>
                        <label for="ctype_sqf" class="toggle_checkbox">SQF</label>
                    </div>
                    <div class="form-group toggle_checkbox_div">
                        <input type="checkbox" name="ctype_fda_registered" id="ctype_fda_registered" value="fda_registered" {if $product.certificate_types[5]=='fda_registered'}checked{/if}>
                        <label for="ctype_fda_registered" class="toggle_checkbox">FDA Registered</label>
                    </div>
                    <div class="form-group toggle_checkbox_div">
                        <input type="checkbox" name="ctype_outdoor" id="ctype_outdoor" value="outdoor" {if $product.certificate_types[6]=='outdoor'}checked{/if}>
                        <label for="ctype_outdoor" class="toggle_checkbox">Outdoor</label>
                    </div>
                    <div class="form-group toggle_checkbox_div">
                        <input type="checkbox" name="ctype_indoor" id="ctype_indoor" value="indoor" {if $product.certificate_types[7]=='indoor'}checked{/if}>
                        <label for="ctype_indoor" class="toggle_checkbox">Indoor</label>
                    </div>
                    <div class="form-group toggle_checkbox_div">
                        <input type="checkbox" name="ctype_greenhouse" id="ctype_greenhouse" value="greenhouse" {if $product.certificate_types[8]=='greenhouse'}checked{/if}>
                        <label for="ctype_greenhouse" class="toggle_checkbox">Greenhouse</label>
                    </div>
                    <div class="form-group toggle_checkbox_div">
                        <input type="checkbox" name="ctype_light_deprivation" id="ctype_light_deprivation" value="light_deprivation" {if $product.certificate_types[9]=='light_deprivation'}checked{/if}>
                        <label for="ctype_light_deprivation" class="toggle_checkbox">Light Deprivation</label>
                    </div>
                    <div class="form-group toggle_checkbox_div">
                        <input type="checkbox" name="ctype_co2" id="ctype_co2" value="co2" {if $product.certificate_types[10]=='co2'}checked{/if}>
                        <label for="ctype_co2" class="toggle_checkbox">CO2</label>
                    </div>
                    <div class="form-group toggle_checkbox_div">
                        <input type="checkbox" name="ctype_ethanol" id="ctype_ethanol" value="ethanol" {if $product.certificate_types[11]=='ethanol'}checked{/if}>
                        <label for="ctype_ethanol" class="toggle_checkbox">Ethanol</label>
                    </div>
                    <div class="form-group toggle_checkbox_div">
                        <input type="checkbox" name="ctype_hydrocarbon_extraction" id="ctype_hydrocarbon_extraction" value="hydrocarbon_extraction" {if $product.certificate_types[12]=='hydrocarbon_extraction'}checked{/if}>
                        <label for="ctype_hydrocarbon_extraction" class="toggle_checkbox">Hydrocarbon Extraction</label>
                    </div>
                    <div class="form-group toggle_checkbox_div">
                        <input type="checkbox" name="ctype_statement_of_origin_available" id="ctype_statement_of_origin_available" value="statement_of_origin_available" {if $product.certificate_types[13]=='statement_of_origin_available'}checked{/if}>
                        <label for="ctype_statement_of_origin_available" class="toggle_checkbox">Statement of origin available</label>
                    </div>
                    <div class="form-group toggle_checkbox_div">
                        <input type="checkbox" name="ctype_statement_of_compliance_available" id="ctype_statement_of_compliance_available" value="statement_of_compliance_available" {if $product.certificate_types[14]=='statement_of_compliance_available'}checked{/if}>
                        <label for="ctype_statement_of_compliance_available" class="toggle_checkbox">Statement of compliance available</label>
                    </div>
                    <div id="ctype_error" style="color:red; width: 100%; float: left; display: none;">Please click your product Attributes.</div>

                    <hr style="width: 100%; margin-top: 0px;"> 
                </div>
                <div class="row">
                    <div class="col-12 form-group suply2">
                        <label class="pp-label">
                            Date of Certificate of Analysis
                        </label>
                        <div class="cal-input">
                            <input class="form-control" placeholder="Date of Certificate of Analysis" name="certificate_date" id="certificate_date" required data-parsley-required-message="End Date is required." data-parsley-errors-container="#certificate_date-err" data-parsley-trigger="change" autocomplete="off" value="{if $product.certificate_date != '00-00-0000'}{$product.certificate_date}{/if}" />
                            <span class="cal-img">
                                <img src="{$config.url}/images/calendar.png" alt="calendar" />
                            </span>
                        </div>
                        <span id="certificate_date-err" class="err-message"></span>
                    </div>
                    <div class="col-12 form-group">
                        <label class="pp-label doc1">
                            Upload Certificate of Analysis (pdf, jpeg, png)
                            <i class="fa fa-spinner fa-spin image-loader" id="certificateDocumentLoader" style="display: none;"></i>
                        </label>

                        <label class="pp-label doc2">
                            Upload Supporting Documents
                            <i class="fa fa-spinner fa-spin image-loader" id="certificateDocumentLoader" style="display: none;"></i>
                        </label>
                        <div class="upload-document">
                            <input type="file" class="form-control" name="certificateDocument" onchange="editCertificateFileupload(this);" accept=".png, .jpeg, .jpg, .pdf" multiple> 
                            <div class="doc">DRAG DOCUMENT</div>
                            <button class="btn btn-primary doc">
                                UPLOAD DOCUMENT
                            </button>
                            <div id="cError" style="color:red">Please upload certificates.</div>
                        </div>
                        <div id="certificateDocumentList">
                            {if $product.productCertificate.length > 0}
                                {foreach $product.productCertificate as $key => $val}
                                    <div class="image-item" id="doc_{$key+1}"><a href="{$config.url}/uploads/certificates/{$val.certificate_name}" target="_blank">{$val.certificate_name}</a> <a data-name="{$val.certificate_name}" href="javascript:void(0)" class="removeCertificate"><i class="fa fa-trash"></i></a></div>
                                {/foreach}
                            {/if}
                        </div>
                        <p class="note-txt">
                            Please make sure your document is very clear. You must be able to read all letters and numbers clearly. Documents uploaded that are unclear may delay your listing going live. Customer identification must be redacted. All listings will be reviewed
                        </p>
                    </div>
                    <div class="col-12 form-group suply2" id="canalysis_div"> 
                        <div class="form-inline form-group">
                            <label class="pp-label">Certificate of Analysis - Click on your products test results</label>
                        </div>
                        
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" name="potency" id="potency" value="potency" {if $product.contaminant_screening_data[0]=='potency'}checked{/if}>
                            <label for="potency" class="toggle_checkbox">Potency</label>
                        </div>
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" name="prs" id="prs" value="prs" {if $product.contaminant_screening_data[1]=='prs'}checked{/if}>
                            <label for="prs" class="toggle_checkbox">Pesticide Residue Screening</label>
                        </div>
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" name="micro_ms" id="micro_ms" value="micro_ms" {if $product.contaminant_screening_data[2]=='micro_ms'}checked{/if}>
                            <label for="micro_ms" class="toggle_checkbox">Microbiology & Mycotoxin Screening</label>
                        </div>
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" name="hms" id="hms" value="hms" {if $product.contaminant_screening_data[3]=='hms'}checked{/if}>
                            <label for="hms" class="toggle_checkbox">Heavy Metals Screening</label>
                        </div>
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" name="srs" id="srs" value="srs" {if $product.contaminant_screening_data[4]=='srs'}checked{/if}>
                            <label for="srs" class="toggle_checkbox">Solvent Residue Screening</label>
                        </div>
                        <div class="form-group toggle_checkbox_div">
                            <input type="checkbox" name="terpene_profile" id="terpene_profile" value="terpene_profile" {if $product.contaminant_screening_data[5]=='terpene_profile'}checked{/if}>
                            <label for="terpene_profile" class="toggle_checkbox">Terpene Profile</label>
                        </div>
                        <div id="canalysis_error" style="color:red; width: 100%; float: left; display: none;">Please click Certificate of Analysis.</div>
                    </div>
                </div>
                {if $product.id=='' || $product.id=='0' || $draft!=''}
                    <div class="text-center mt-3"> 
                        <button class="sdp-link" type="button" id="saveToDraft">Save as draft</button>
                    </div>
                {/if}
                <div class="pp-btns-wrap">
                    <button class="btn btn-prev previous_btn" type="button" onclick="gotoStep(2)">PREV</button>
                    <button class="btn btn-primary">NEXT</button>
                    {if $product.id > 0}
                        <button type="button" class="btn btn-info save_and_close">
                            {if $action == 'relist'}RELIST & CLOSE{else /}SAVE & CLOSE{/if}
                        </button>
                    {/if}
                </div>
                <div class="text-center">
                    <b>Note:</b><i>Your draft is automatically saved in the "Draft" section of your dashboard</i>
                </div>
            </form> 
        </div>
        <div id="step4_data" class="step_data">
            <!-- <h3 class="ppf-title">Purchase, Payment & Proof of Life</h3> -->
            <h3 class="ppf-title">Purchase & Payment Information</h3>
            <form class="pp-form product_form bg-gray" data-parsley-validate novalidate id="step4_form">
                <div class="row">
                    <div class="col-12 form-group">
                        <label class="pp-label">SOPs – Standard Operating Procedures for Purchase 
                            <p class="note-txt doc1">
                                &nbsp;&nbsp;&nbsp;Describe your transaction SOPs once your listing has been purchased; Samples availability/purchase, quarantine, delivery/shipping options etc.
                            </p>
                            <p class="note-txt doc2">
                                &nbsp;&nbsp;&nbsp;Describe your transaction standard operating procedures, once your auction has been won; sample opportunities, testing, quarantine, pick up options, shipping etc.
                            </p>
                        </label>
                        <textarea rows="4" class="form-control" placeholder="SOPs – Standard Operating Procedures for Purchase" name="sops" id="sops" required data-parsley-required-message="SOPs – Standard Operating Procedures for Puchase is required.">{$product.sops}</textarea>
                    </div> 
                </div>
                <div class="row" style="display: none;">
                    <div class="col-12 form-group">
                        <label class="pp-label ppl_tool_tip">
                            Transaction Method 
                            <span class="reg-info"><img src="{$config.url}/images/info.png" alt=""></span>
                            <span class="reg_info_text">
                                <p>Utilizing an escrow or attorney is required for all transactions with a value of over $2501.00 for your safety</p>
                            </span>
                        </label> 
                        <div class="clearfix col-sm-12 p-0">
                            <div class="form-group toggle_checkbox_div">
                                <input type="radio" name="payment_method" id="HempEscrows" value="HempEscrows" {if $product.payment_method=='HempEscrows'}checked{/if}>
                                <label for="HempEscrows" class="toggle_checkbox">HempEscrows - Shannon Wright</label>
                            </div>
                            <div class="form-group toggle_checkbox_div">
                                <input type="radio" name="payment_method" id="EsGrowServices" value="EsGrowServices" {if $product.payment_method=='EsGrowServices'}checked{/if} disabled>
                                <label for="EsGrowServices" class="toggle_checkbox">EsGrowServices - Shelly Fischer</label>
                            </div>
                            <div class="form-group toggle_checkbox_div">
                                <input type="radio" name="payment_method" id="attorney_or_escrow" value="attorney_or_escrow" {if $product.payment_method=='attorney_or_escrow'}checked{/if}>
                                <label for="attorney_or_escrow" class="toggle_checkbox">Attorney or Escrow of my choice</label>
                            </div>
                            <div class="form-group toggle_checkbox_div">
                                <input type="radio" name="payment_method" id="other" value="other" {if $product.payment_method=='other'}checked{/if}>
                                <label for="other" class="toggle_checkbox">Other</label>
                            </div>
                            {* <div class="clearfix cselec-wrap-remove cselec-wrap">
                                <select class="custom-select" name="payment_method" id="payment_method" required data-parsley-required-message="Payment Method is required.">
                                    <option value="" {if $product.payment_method==''}selected{/if}>Select Transaction Method</option>
                                    <option value="escrow" {if $product.payment_method=='escrow'}selected{/if}>Escrow</option>
                                    <option value="a_to_a" {if $product.payment_method=='a_to_a'}selected{/if}>Attorney to Attorney</option>
                                    <option value="wire" {if $product.payment_method=='wire'}selected{/if}>Wire (For Transactions <$15,000)</option>
                                    <option value="other" {if $product.payment_method=='other'}selected{/if}>Other</option>
                                </select>
                            </div> *}
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 form-group" id="other_payment_method" style="{if $product.payment_method!='other'}display: none;{/if}">
                        <label class="pp-label">Other</label>
                        <textarea rows="4" class="form-control" placeholder="Description" name="payment_method_other" id="payment_method_other"  data-parsley-required-message="Description is required.">{$product.payment_method_other}</textarea>
                    </div> 
                </div>
                {if $product.id=='' || $product.id=='0' || $draft!=''}
                <div class="text-center"> 
                    <button class="sdp-link" type="button" id="saveToDraft">Save as draft</button>
                    <button class="sdp-link" type="button" onclick="previewProduct()">Preview</button>
                </div>
                {/if}
                <div class="pp-btns-wrap">
                    <button class="btn btn-prev previous_btn" type="button" onclick="gotoStep(3)">PREV</button>
                    <button type="reset" class="btn btn-prev" value='CANCEL' id="cancelPost" style="color:#fff">CANCEL</button>
                    <button type="submit" class="btn btn-primary" id="final_submit">
                        {if $action == 'relist'}RELIST{else /}SAVE{/if}
                    </button>
                    <button type="button" style="display: none;" id="success_btn" class="btn btn-primary" data-toggle="modal" data-target="#pp-success">Success</button>
                </div>
                <div class="text-center">
                    <b>Note:</b><i>Your draft is automatically saved in the "Draft" section of your dashboard</i>
                </div>
                <input type="hidden" name="action" id="action" value="{$action}" >
            </form>
        </div>

    </div>
</div>

<section class="search-content-wrap og-auc-wrap" style="background: unset;">
    <div class="container spl-wrap">
        <h2 class="on-ahead">ADVERTISEMENTS</h2>
        <div id="ads_list"></div>
    </div>
</section>

<div class="modal fade hb-modal" id="pp-success">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="closeSuccess">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body"> 
                <h4 class="text-center">PRODUCT HAS BEEN SUCCESFULLY SUBMITTED !</h4>
                <div class="success-check">
                    <i class="fa fa-check"></i>
                </div>
                <div class="ss-txt">
                    Succesfully Submitted
                </div>
                <button class="btn btn-prev" data-dismiss="modal" id="thankYou">
                    THANK YOU
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.js"></script>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.js"></script> 

<div class="modal fade hb-modal" id="crop_image_popup" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog" style="width: 550px;">
        <div class="modal-content">
            <div class="modal-header">
                Crop Image
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="closeCropPopup">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            {* <div class="modal-body"> 
                <div>
                    <img id="crop_image" src="" style="width: 100%; max-height: 350px;">
                </div>
                <button class="btn btn-prev mt-3 mb-0" data-dismiss="modal" onclick="compressAndUpdate()" type="button">
                    Save
                </button>
            </div> *}
            <div class="modal-body" style="text-align: center;">
                <div>
                    <img id="crop_image" src="" style="width: 100%; max-height: 350px;">
                </div> 

                <div class="row" id="actions">
                    <div class="docs-buttons" style="width: 100%;">
                        <div class="">
                            <div class="btn-group" style="margin-top: 10px; display: inline-flex;">
                                <button type="button" class="btn brwn-btn-lg wdp100" data-method="rotate" data-option="-90">
                                    <span class="docs-tooltip" data-toggle="tooltip">
                                        <span class="fas fa-undo"></span>
                                    </span>
                                </button>
                                <button type="button" class="btn brwn-btn-lg wdp100" data-method="rotate" data-option="90">
                                    <span class="docs-tooltip" data-toggle="tooltip">
                                        <span class="fas fa-redo"></span>
                                    </span>
                                </button>
                            </div>

                            <div class="btn-group" style="margin-top: 10px; display: inline-flex;">
                                <button type="button" class="btn brwn-btn-lg wdp100" data-method="zoom" data-option="0.1">
                                    <span class="docs-tooltip" data-toggle="tooltip" >
                                    <span class="fa fa-search-plus"></span>
                                    </span>
                                </button>
                                <button type="button" class="btn brwn-btn-lg wdp100" data-method="zoom" data-option="-0.1" >
                                    <span class="docs-tooltip" data-toggle="tooltip">
                                    <span class="fa fa-search-minus"></span>
                                    </span>
                                </button>
                            </div>
                        </div>
                        <hr />
                        <button type="button" style="" class="btn btn-prev mt-3 mb-0" data-dismiss="modal" data-method="getCroppedCanvas" data-option="{ &quot;minWidth&quot;: 900, &quot;minHeight&quot;: 600, &quot;maxWidth&quot;: 2560, &quot;maxHeight&quot;: 1152 }">
                            <span class="docs-tooltip" data-toggle="tooltip">
                                Save
                            </span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade hb-modal" id="draft-success">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="closeSuccess">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body"> 
                <h4 class="text-center">PRODUCT HAS BEEN SUCCESFULLY ADDED TO DRAFT !</h4>
                <div class="success-check">
                    <i class="fa fa-check"></i>
                </div>
                <div class="ss-txt">
                    Succesfully Submitted
                </div>
                <button class="btn btn-prev" data-dismiss="modal" id="thankYouDraft">
                    THANK YOU
                </button>
            </div>
        </div>
    </div>
</div>



<script>
       $(document).ready(function (e) {
           console.log('called1')
            $(document).keypress(function (e) {
                if (e.which == 13) {
                    console.log('called')
                    if ($("#draft-success").css("display") == "block") {
                        $("#draft-success").modal('hide')
                    }

                    if ($("#pp-success").css("display") == "block") {
                        $("#pp-success").modal('hide')
                    }
                }
            });
        });
    
</script>
<script type="text/javascript" src="http://www.pureexample.com/js/lib/jquery.ui.touch-punch.min.js"></script>

<!-- / page content  -->
{include file="/common/footer-1.tpl" nocache}

<script language="javascript" type="text/javascript">
    $("#start_date").mask('00-00-0000 00:00', { placeholder: 'MM-DD-YYYY HH:MM' });
    $("#end_date").mask('00-00-0000 00:00', { placeholder: 'MM-DD-YYYY HH:MM' });
    $("#certificate_date").mask('00-00-0000 00:00', { placeholder: 'MM-DD-YYYY' });
    $("#manufacture_date").mask('00-00-0000 00:00', { placeholder: 'MM-DD-YYYY' });
   
        $(document).on('change', '#category_id', function () {
            var category_id = $('#category_id').val();
            $('#unit_of_measurement').prop('required',true);
            $('#amount_sold').prop('required',true);
            $('#moq').prop('required',true);
            if(product_id < 1) {
                $('#amount_sold').val('');
                $('#moq').val('');
            }
            $('.suply').show();

            $('#subcategory_id').attr('disabled', 'disabled');
            $.ajax({
                type: 'GET',
                dataType: 'json',
                url: '/product/getCategories/' + category_id,
                data: {
                },
                success: function (data) {

                    $('#subcategory_id').find('option').not(':first').remove();
                    for (var i = 0; i < data.result.length; i++) {
                        var catsid = data.result[i].id;
                        var catname = data.result[i].name;
                        var selectedSub = '{$product.subcategory_id}';
                        var selected = '';
                        if(catsid.toString() == selectedSub.toString())
                            selected = 'selected'

                        var subHtml = '<option value="' + catsid + '" ' + selected + '>' + catname + '</option>';
                        $('#subcategory_id').append(subHtml);
                    }
                    if(storedData) {
                        var index = storedData.findIndex(function(item) {
                            return item.id == "subcategory_id";
                        });
                        if(index > -1 && storedData[index]) {
                            $('#subcategory_id').val(storedData[index].value);
                        }
                    }

                    if(data.result.length <= 0) {
                        $("#subcategory_id").val('');
                    } else {
                        var subCat = $("#subcategory_id").val();
                        if(subCat == '')
                            $("#subcategory_id").val($("#subcategory_id option:eq(1)").val());
                    }
                },
            }).done(function() {
                $('#subcategory_id').attr('disabled', false);
            });
        });

    
    var product_id = +'{$product.id}';
    //console.log('product_id', product_id);
    storedData = [];
    certificates = [];
    productDocument = [];
    productDocument = JSON.parse('{$product.productImages_json}');
    

    $(document).ready(function () {
        $(document).on("click", "#ctype_div input[type='checkbox']", function() {
            $("#ctype_error").hide();
        })
        $(document).on("click", "#canalysis_div input[type='checkbox']", function() {
            $("#canalysis_error").hide();
        })
        $("#step1_data").slideDown();
        if(product_id > 0) {
            setTimeout(function(){
                $("#category_id").trigger('change');
                $('#amount_sold').val('{$product.amount_sold}');
                $('#moq').val('{$product.moq}');
                if('{$product.type}' == 'auction') {
                    $("#auction_check").trigger("change");
                } else if('{$product.type}' == 'fixed') {
                    $("#fp-price_check").trigger("change");
                } else {
                    $("#ofr-price_check").trigger("change");
                }
            });

            if($('#fp-price_check').is(":checked")) {
                $("#product_renew").append('<option value="9">9 times</option><option value="10">10 times</option><option value="11">11 times</option><option value="12">12 times</option>');
            } else if($('#auction_check').is(":checked")) {
                $("#product_renew option[value='9']").remove();
                $("#product_renew option[value='10']").remove();
                $("#product_renew option[value='11']").remove();
                $("#product_renew option[value='12']").remove();
            } else if($('#ofr-price_check').is(":checked")) {
                $("#product_renew").append('<option value="9">9 times</option><option value="10">10 times</option><option value="11">11 times</option><option value="12">12 times</option>');
            }
            $("#product_renew").val('{$product.renew}');
        } else {
            fillLocalData();
        }

        var logicStart = function (currentDateTime) {
            debugger;
            $('#end_date').val('');
            if (currentDateTime.getDate() == servertime.getDate()) {
                this.setOptions({
                    minTime: addZero(servertime.getHours()) + ':' + addZero(servertime.getMinutes()),
                    maxDate:$('#end_date').val()? new Date($('#end_date').val()):false
                });
            } else {
                this.setOptions({
                    minTime: '00:00',
                    maxDate:$('#end_date').val()? new Date($('#end_date').val()):false
                });
            }
        };

        var logicEnd = function (currentDateTime) {
            debugger;
            var buyNowChecks = $('#auction_check').is(":checked");
            var fixedPriceChecks = $('#fp-price_check').is(":checked");
            var offerPriceChecks = $('#ofr-price_check').is(":checked");
            var setMaxEndDate = 89;
            if(buyNowChecks)
                setMaxEndDate = 7;

            if(fixedPriceChecks || offerPriceChecks)
                setMaxEndDate = 29;

            var startDates = $('#start_date').val() ? $('#start_date').val() : new Date();
            startDates = startDates.split(" ");
            var startDate = new Date(startDates[0].split("-")[2] + '/' + startDates[0].split("-")[0] + '/' + startDates[0].split("-")[1] + ' ' + startDates[1]);
            if (currentDateTime && currentDateTime.getDate() == servertime.getDate()) {
                var mindate = $('#start_date').val() ? true : false;
                if(mindate == true) {
                    var sdate = $('#start_date').val().split(" ");
                    mindate = new Date(sdate[0].split("-")[2] + '/' + sdate[0].split("-")[0] + '/' + sdate[0].split("-")[1] + ' ' + sdate[1]);
                }

                this.setOptions({
                    minTime: addZero(servertime.getHours()) + ':' + addZero(servertime.getMinutes()),
                    minDate: mindate,
                    //maxDate : new Date(startDate.getTime() +  (89 * 24 * 60 * 60 * 1000))
                    maxDate : new Date(startDate.getTime() +  (setMaxEndDate * 24 * 60 * 60 * 1000))
                });
            } else {
                var mindate = $('#start_date').val() ? true : false;
                if(mindate == true) {
                    var sdate = $('#start_date').val().split(" ");
                    mindate = new Date(sdate[0].split("-")[2] + '/' + sdate[0].split("-")[0] + '/' + sdate[0].split("-")[1] + ' ' + sdate[1]);
                }
                console.log('mindate', mindate);
                this.setOptions({
                    minTime: '00:00',
                    minDate: mindate,
                    //maxDate : new Date(startDate.getTime() +  (89 * 24 * 60 * 60 * 1000))
                    maxDate : new Date(startDate.getTime() +  (setMaxEndDate * 24 * 60 * 60 * 1000))
                });
            }
        };

        setTimeout(function(){
            $('#start_date').datetimepicker({
                format:'m-d-Y H:i',
                step: 5,
                onChangeDateTime:logicStart,
                onShow:logicStart,
                minDate:new Date(servertime),
                defaultTime: new Date(servertime)
            });

            $('#end_date').datetimepicker({
                format:'m-d-Y H:i',
                step: 5,
                onChangeDateTime:logicEnd,
                onShow:logicEnd,
                maxDate: new Date(servertime),
                defaultTime: new Date(servertime)
            });
        }, 3000);

        $('#manufacture_date').datetimepicker({
            //format:'Y-m-d H:i',
            format:'m-d-Y',
            timepicker:false,
            step: 5
        });
        $('#certificate_date').datetimepicker({
            //format:'Y-m-d H:i',
            format:'m-d-Y',
            timepicker:false,
            step: 5
        });
        
        $(document).on('change', '.typeCheckbox', function () {
            var divId = $(this).attr('id').split('_')[0];
            if(divId == 'auction') {
                $(this).prop('checked', 'checked');
                $('#fp-price').removeClass('active');
                $('#ofr-price').removeClass('active');
                $("#"+divId).addClass('active');

                //$('#fp-price').find('input').not('.qty').val('');

                $('#fp-price_check').prop('checked', false);
                $('#buy-now_check').attr('disabled', false);
                $('#ofr-price_check').prop('checked', false);

                $('.auction').css("display", "block");
                $('.fixedprice').css("display", "none");

                $("#product_renew option[value='9']").remove();
                $("#product_renew option[value='10']").remove();
                $("#product_renew option[value='11']").remove();
                $("#product_renew option[value='12']").remove();

                //$('#product_renew').val('8');
                if(product_id < 1 && localdata == 0) {
                    $('#end_date').val('').trigger('change');
                    $('#product_renew').val('0');
                }
                $("#moq_div").show();
                $("#total_amount_available_div").show();
            } else if(divId == 'buy-now') {
                $('#fp-price').removeClass('active');
                if($(this).prop("checked")) {
                    $("#"+divId).addClass('active');
                } else {
                    $("#"+divId).removeClass('active');
                }
              
                $('#product_renew').val('0');
            } else if(divId == 'fp-price') {
                $(this).prop('checked', 'checked');

                $('#auction').removeClass('active');
                $('#buy-now').removeClass('active');
                $('#ofr-price').removeClass('active');
                $("#"+divId).addClass('active');

              
                $('#auction_check').prop('checked', false);
                $('#buy-now_check').prop('checked', false);
                $('#buy-now_check').attr('disabled', 'disabled');
                $('#ofr-price_check').prop('checked', false);
                
                $('.auction').css("display", "none");
                $('.fixedprice').css("display", "block");

                $("#product_renew option[value='9']").remove();
                $("#product_renew option[value='10']").remove();
                $("#product_renew option[value='11']").remove();
                $("#product_renew option[value='12']").remove();
                $("#product_renew").append('<option value="9">9 times</option><option value="10">10 times</option><option value="11">11 times</option><option value="12">12 times</option>');

                //$('#product_renew').val('12');
                if(product_id < 1 && localdata == 0) {
                    $('#end_date').val('').trigger('change');
                    $('#product_renew').val('0');
                }
                $("#moq_div").hide();
                $("#total_amount_available_div").show();
            } else if(divId == 'ofr-price') {
                $(this).prop('checked', 'checked');

                $('#auction').removeClass('active');
                $('#buy-now').removeClass('active');
                $('#fp-price').removeClass('active');
                $("#"+divId).addClass('active');

                

                $('#auction_check').prop('checked', false);
                $('#buy-now_check').prop('checked', false);
                $('#buy-now_check').attr('disabled', 'disabled');
                $('#fp-price_check').prop('checked', false);
                
                $('.auction').css("display", "none");
                $('.fixedprice').css("display", "block");


                $("#product_renew option[value='9']").remove();
                $("#product_renew option[value='10']").remove();
                $("#product_renew option[value='11']").remove();
                $("#product_renew option[value='12']").remove();
                $("#product_renew").append('<option value="9">9 times</option><option value="10">10 times</option><option value="11">11 times</option><option value="12">12 times</option>');

                //$('#product_renew').val('12');
                if(product_id < 1 && localdata == 0) {
                    $('#end_date').val('').trigger('change');
                    $('#product_renew').val('0');
                }
                $("#moq_div").hide();
                $("#total_amount_available_div").hide();
            }
        });

        $(document).on('keypress change', '#start_date', function () {
            $("#start_date-err").html("");
        });
        $(document).on('keypress change', '#end_date', function () {
            $("#end_date-err").html("");
        });
        $(document).on('change', 'input[name="sold_lots"]', function () {
            if($(this).val() == 'no') {
                $("#sold_in_lot_dv").hide();
            } else {
                $("#sold_in_lot_dv").show();
            }
        });
        $(document).on('change', 'input[name="payment_method"]', function () {
            if($(this).val() == 'other') {
                $("#other_payment_method").slideDown();
            } else {
                $("#other_payment_method").slideUp();
            }
        });

        /* Start remove certificate */
        $(document).on('click', '.removeCertificate', function () {
            var id = $(this).closest('.image-item').attr('id').split("_")[1];
            $("#doc_"+id).remove();
            var name = $(this).attr('data-name');
            var certificate_id = 0;
            if(!$(this).closest('.image-item').hasClass('isNew')) {
                certificate_id = id;
            }
            var index = certificates.findIndex(function(item) { return item.name == name; });
            if(index > -1) {
                $.ajax({
                    method: "POST",
                    url: '/product/deletecertificate',
                    data: { name: name, certificate_id: certificate_id },
                    dataType: 'JSON',
                    cache: false,
                    success: function (data) {

                    }
                });
                certificates.splice(index, 1);
            }
        });
        /* End remove certificate */

        /* Start remove product document */
        $(document).on('click', '.removeProductDocument', function () {
            var id = $(this).closest('.image-item').attr('id').split("_")[1];
            $("#proddoc_"+id).remove();
            var name = $(this).attr('data-name');
            var document_id = 0;
            if(!$(this).closest('.image-item').hasClass('isNew')) {
                document_id = id;
            }
           
            var index = productDocument.findIndex(function(item) { return item.name == name || item.image == name; });
            
            if(index > -1) {
                $.ajax({
                    method: "POST",
                    url: '/product/deleteProductDocument',
                    data: { name: name, document_id: document_id },
                    dataType: 'JSON',
                    cache: false,
                    success: function (data) {

                    }
                });
                productDocument.splice(index, 1);
                localStorage.removeItem('drafedData_{$loged.userid}');
                storeLocalData(4);
            }
        });
        /* End remove product document */

        $(document).on('click', '.save_and_close', function (e) {
            $("#step1_form").trigger("submit");
            if($("#step1_form").parsley().validate()) {
                $("#step2_form").trigger("submit");
                if($("#step2_form").parsley().validate()) {
                    $("#step3_form").trigger("submit");
                    if($("#step3_form").parsley().validate()) {
                        $("#step4_form").trigger("submit");
                    }
                }
            }
        });
        $(document).on('submit', '.product_form', function (e) {
            var step = +($(this).attr('id').split('_')[0])[4];
            e.preventDefault();
            if(step == 1) {
                var moq = $('#moq').val();
                var fixed_qty = $('#fixed_qty').val();
                var buynow_qty = $('#buynow_qty').val();

                var auctionChecks = $('#auction_check').is(":checked");
                var fixedPriceChecks = $('#fp-price_check').is(":checked");
                if(auctionChecks) {
                    if( parseFloat(buynow_qty) < parseFloat(moq) ) {
                        $('#buynowqty_error').html('Buynow quantity should be equal or greater than MOQ').css('color', 'red').show();
                        return false;
                    } else
                        $('#buynowqty_error').html('').hide();

                    var startPrice = $('#start_price').val();
                    if(startPrice != "" && startPrice <= 0) {
                        $('#serror').html('Start price should be greater than 0').css('color', 'red').show();
                        return false;
                    } else 
                        $('#serror').html('').hide();

                    var reservePrice = $('#reserve_price').val();
                    if(reservePrice != "" && reservePrice <= 0) {
                        $('#rerror').html('Reserve price should be greater than 0').css('color', 'red').show();
                        return false;
                    } else 
                        $('#rerror').html('').hide();
                }

                if(fixedPriceChecks) {
                    if(parseFloat(fixed_qty) < parseFloat(moq)) {
                        $('#fixedqty_error').html('Fixed quantity should be equal or greater than MOQ').css('color', 'red').show();
                        return false;
                    } else
                        $('#fixedqty_error').html('').hide();

                    var fixedPrice = $('#fixed_price').val();
                    if(fixedPrice != "" && fixedPrice <= 0) {
                        $('#fixedprice_error').html('Fixed price should be greater than 0').css('color', 'red').show();
                        return false;
                    } else 
                        $('#fixedprice_error').html('').hide();
                }

                if($("#productDocumentList").find('.image-item').length <= 0) {
                    $('#pError').show();
                    return false;
                }

                if($('#start_date').val()) {
                    var sdate = $('#start_date').val().split(" ");
                    var startDate = new Date(sdate[0].split("-")[2] + '/' + sdate[0].split("-")[0] + '/' + sdate[0].split("-")[1] + ' ' + sdate[1]);
                } else {
                    var startDate = new Date();
                }
                if(startDate == 'Invalid Date') {
                    $("#start_date-err").html("Start date is invalid");
                    return false;
                }

                if($('#end_date').val()) {
                    var edate = $('#end_date').val().split(" ");
                    var endDate = new Date(edate[0].split("-")[2] + '/' + edate[0].split("-")[0] + '/' + edate[0].split("-")[1] + ' ' + edate[1]);
                } else {
                    var endDate = new Date();
                }
                if(endDate == 'Invalid Date') {
                    $("#end_date-err").html("End date is invalid");
                    return false;
                }
                if(endDate < startDate) {
                    $("#end_date-err").html("End date must have greater than start date");
                    return false;
                }
                
                var buyNowChecks = $('#auction_check').is(":checked");
                var fixedPriceChecks = $('#fp-price_check').is(":checked");
                var offerPriceChecks = $('#ofr-price_check').is(":checked");
                var setMaxEndDate = 89;
                if(buyNowChecks)
                    setMaxEndDate = 9;

                if(fixedPriceChecks || offerPriceChecks)
                    setMaxEndDate = 30;
                var maxDate = new Date(startDate.getTime() +  (setMaxEndDate * 24 * 60 * 60 * 1000));
                if(endDate > maxDate) {
                    $('#end_date').focus();
                    $("#end_date-err").html("End date must have in "+setMaxEndDate+" days from start date");
                    return false;
                }
                           
            }
            e.preventDefault();
            console.log('step', step);
            if($("#step"+step+"_form").parsley().validate()) {
                storeLocalData(step);
                if(step != 4) {
                    gotoStep(step+1);
                } else {
                    saveProduct();
                }
            } else {
                $("#step"+step+"_form").parsley().validate();
            }
        });

        $(document).on('click', '#thankYou, #closeSuccess, #cancelPost', function (e) {
            localStorage.removeItem('drafedData_{$loged.userid}');
            if(product_id != "" && product_id != 0)
                window.location.href = '/seller/openAuction';
            else
                window.location.reload();
        });
        $(document).on('click', '#thankYouDraft', function (e) {
            localStorage.removeItem('drafedData_{$loged.userid}');
                window.location.href = '/seller/draftAuction';
        });
        

        // Append New Video URL - Starts
        $(document).on('click', "#append", function(e) {
            e.preventDefault();
            var create = 1;
            $(".embed_video").each(function( index ) {
                console.log( index + ": " + $( this ).val() );
                if($(this).val() == '') {
                    create = 0;
                }
            });
            if(create) {
                $(this).after('<button class="btn btn-danger remove_this" type="button">Remove</button>');
                $(this).remove();
                $("#appendVideoUrl").append('<div class="row">\
                    <div class="col-sm-10 form-group pr-0">\
                        <input class="form-control embed_video" placeholder="Vimeo / YouTube Video Link" name="embed_video[]" id="embed_video" data-parsley-type="url" type="url" />\
                    </div>\
                    <div class="col-sm-2 form-group pl-1">\
                        <button class="btn btn-info" type="button" id="append" name="append">Add Video Link</button>\
                    </div>\
                </div>');
                return false;
            }
        });

        $('body').on('click', '.remove_this', function() {
            $(this).closest('.row').remove();
            return false;
        });
        // Append New Video URL - Ends
    });

    function validateURL(videoUrl) {
        var urlRegex = new RegExp("^(http:\/\/www.|https:\/\/www.|ftp:\/\/www.|www.){1}([0-9A-Za-z]+\.)");
        return urlRegex.test(videoUrl);
    }

    function saveProduct() {
        if($("#productDocumentList").find('.image-item').length <= 0){
            $('#pError').show();
            return;
        }

        if($("#certificateDocumentList").find('.image-item').length <= 0){
            $('#cError').show();
            return;
        }

        var formArray = []
        for (let index = 1; index <= 4; index++) {
            var formArr = $("#step"+index+"_form").serializeArray();
            formArray = formArray.concat(formArr);
        }

        var productObj = {};
        var productData = formArray ? formArray : [];
        if(productData.length) {
            for (var index = 0; index < productData.length; index++) {
                const element = productData[index];
                productObj[productData[index].name] = productData[index].value;
            }
        }
        console.log('productDocument', productDocument);
        productObj['productDocument'] = productDocument;
        productObj['certificatesDocument'] = certificates;
        var type = 'auction';
      
        var auctionChecks = $('#auction_check').is(":checked");
        var fixedPriceChecks = $('#fp-price_check').is(":checked");
        var offerPriceChecks = $('#ofr-price_check').is(":checked");
        if(auctionChecks) {
            type = 'auction';
        } else if(fixedPriceChecks) {
            type = 'fixed';
        } else if(offerPriceChecks) {
            type = 'offer';
        }

        productObj['type'] = type;

        productObj['videoUrl'] = [];
        if($('.embed_video').length > 0) {
            $('.embed_video').each(function(i, v) {
                if($(this).val() && $(this).val() != "" && $(this).val() != null && $(this).val() != 'undefined')
                    productObj['videoUrl'].push($(this).val());
            });
        }

        $("#final_submit").attr('disabled', 'disabled');

        productObj['product_id'] = $('#product_id').val();
        console.log(productObj,"productObj")

        $.ajax({
            method: "POST",
            url: '/product/save',
            data: productObj,
            dataType: 'JSON',
            cache: false,
            success: function (data) {
                if(data.success) {
                    localStorage.removeItem('drafedData_{$loged.userid}');
                    $("#success_btn").trigger('click');
                } else {
                    // window.location.reload();
                    window.location.href = '/market';
                }
                $("#final_submit").attr('disabled', false);
                //clearForm();
            }
        });
    }

    function clearForm() {
        localStorage.removeItem('drafedData_{$loged.userid}');
        setTimeout(function(){
            window.location.reload();
        },5000);
    }
    /* Start Upload Certificate of Analysis */
    function editCertificateFileupload(obj)
    {
        var files = $('input[name="certificateDocument"]')[0].files;
        var formData = new FormData();
        for (let index = 0; index < files.length; index++) {
            const element = files[index];
            formData.append('certificates', element);
        }
        $("#certificateDocumentLoader").show();
        var cntfle = $('input[name="certificateDocument"]')[0].files.length;
        $.ajax({
            url : '/product/postcertificates/'+cntfle,
            type : 'POST',
            xhr: function() {
                var myXhr = $.ajaxSettings.xhr();
                return myXhr;
            },
            data : formData,
            processData: false,
            contentType: false,
            success : function(response) {
                if(response.certificates.length) {
                    createCertificateHtml(response.certificates);
                }                
            },
            error: function(e)
            {
                console.log(e);
            },
        }).done(function() {
            $("#certificateDocumentLoader").hide();
        });
    }
   
    var fileName = '';
    var uploadCancelled = 0;
    function compressAndUpdate(){
        debugger;
        console.log('compressAndUpdate');
        // event.preventDefault();
        var image_cr = $('#crop_image');
        var cropper = image_cr.data('cropper');
        cropper.getCroppedCanvas().toBlob(function(blob) {
            blob.name = fileName
            console.log("blob", blob)
            editProductFileupload(blob);
        }/*, 'image/png' */);
        return false;
    }
    function showcropModal(){
        // $("#crop_image_popup").modal();
        $('#crop_image_popup').on('shown.bs.modal', function () {

            var image_cr = $('#crop_image');
            image_cr.cropper({
                multiple: true, 
                rotatable: true,
                // aspectRatio: 321 / 180,
                crop: function(event) {
                }
            });
        })
    }
    
    var actions = document.getElementById('actions');
    var Cropper = window.Cropper;
    actions.querySelector('.docs-buttons').onclick = function(event) {
        var image_cr = $('#crop_image');
        var cropper = image_cr.data('cropper');
        var e = event || window.event;
        var target = e.target || e.srcElement;
        var cropped;
        var result;
        var input;
        var data;

        if (!cropper) {
        return;
        }

        while (target !== this) {
        if (target.getAttribute('data-method')) {
            break;
        }

        target = target.parentNode;
        }

        if (target === this || target.disabled || target.className.indexOf('disabled') > -1) {
        return;
        }

        data = {
        method: target.getAttribute('data-method'),
        target: target.getAttribute('data-target'),
        option: target.getAttribute('data-option') || undefined,
        secondOption: target.getAttribute('data-second-option') || undefined
        };

        cropped = cropper.cropped;

        if (data.method) {
        if (typeof data.target !== 'undefined') {
            input = document.querySelector(data.target);

            if (!target.hasAttribute('data-option') && data.target && input) {
            try {
                data.option = JSON.parse(input.value);
            } catch (e) {
                console.log(e.message);
            }
            }
        }

        switch (data.method) {
            case 'rotate':
            if (cropped) {
                cropper.clear();
            }

            break;

            case 'getCroppedCanvas':
            try {
                data.option = JSON.parse(data.option);
            } catch (e) {
                console.log(e.message);
            }
            console.log('data.option', data.option);

            var uploadedImageType = 'image/jpeg';

            if (uploadedImageType === 'image/jpeg') {
                if (!data.option) {
                data.option = {};
                }

                data.option.fillColor = '#fff';
            }

            break;
        }

        result = cropper[data.method](data.option, data.secondOption);

        switch (data.method) {
            case 'rotate':
            if (cropped) {
                cropper.crop();
            }

            break;

            case 'scaleX':
            case 'scaleY':
            target.setAttribute('data-option', -data.option);
            break;

            case 'getCroppedCanvas':
            if (result) {
                // Bootstrap's Modal
                $('#getCroppedCanvasModal').modal().find('.modal-body').html(result);
                result.toBlob(blob =>{
                    // compressImage(blob, false, blob, 0);
                    editProductFileupload(blob, false, blob, 0);
                });
            }

            break;

            case 'destroy':
            cropper = null;

            if (uploadedImageURL) {
                URL.revokeObjectURL(uploadedImageURL);
                uploadedImageURL = '';
                image.src = originalImageURL;
            }

            break;
        }

        if (typeof result === 'object' && result !== cropper && input) {
            try {
            input.value = JSON.stringify(result);
            } catch (e) {
            console.log(e.message);
            }
        }
        }
    };
    function startCrop(obj) {
        if (obj.files && obj.files[0]) {
            if(obj.files[0].size > 5242880) {
                $("#cropzee-input").val(null);
                alert('Max file size found from your selection. Please select minimum 5MB files.');
            }
            var $image = $('#crop_image');
            $image.attr('src', '');

            fileName = obj.files[0].name
            var oFReader = new FileReader();
            oFReader.readAsDataURL(obj.files[0]);
            oFReader.onload = function (oFREvent) {
                // Replace url
                $image.attr('src', this.result);
                $image.cropper('destroy');
                $('#crop_image_popup').modal('show');
                showcropModal();
            }
        }
        //croppImage(obj);
    }

    var jqXHR = '';
    async function editProductFileupload(files, useWebWorker,input,i) {
        console.log('files', files);
        uploadCancelled = 0;
        $("#cancel_image_upload").show();

        $("#productDocumentLoader").show();

        var fileSizeCount = 0;
        var formData = new FormData();
        // if(files.size < 5242880) {
            var options = { maxSizeMB: 0.05, maxWidthOrHeight:675, useWebWorker: false };
            const output = await imageCompression(files, options);
            // const downloadLink = URL.createObjectURL(output)
            var fileName = Math.random().toString(36).substring(7);
            formData.append('product_image', new File([output], fileName));
        // } else {
        //    fileSizeCount++;
        // }
       
        if(uploadCancelled) {
            return true;
        }
       
        var cntfle = $('input[name="productDocument"]')[0].files.length;
       
            $("#cancel_image_upload").show();

        reader = new FileReader();
        reader.onload = (function(files){
            return function(e){
                jqXHR = $.ajax({
                    url : '/product/postProductDocument/'+cntfle,
                    type : 'POST',
                    xhr: function() {
                        var myXhr = $.ajaxSettings.xhr();
                        return myXhr;
                    },
                    data : {
                        image: this.result,
                        name: fileName
                    },
                    dataType:'json',
                    success : function(response) {
                        if(response.datumnew.name) {
                            createUploadProductDHtml(response.datumnew);
                            $('#pError').hide();
                        }
                    
                        $('input[name="productDocument"]').val('');
                    },
                    error: function(e)
                    {
                        console.log('editProductFileupload', e);
                        $('input[name="productDocument"]').val('');
                    },
                }).done(function() {
                    $("#productDocumentLoader").hide();
                    $("#cancel_image_upload").hide();
                });
            }
            // }
        })(files);
        // reader.readAsDataURL(file);
        reader.readAsDataURL(output);
    }
    $(document).on('click', '#cancel_image_upload', function(){
        uploadCancelled=1;
        $("#productDocumentLoader").hide();
        $("#cancel_image_upload").hide();
        jqXHR.abort();
    });
    
    $(document).on('click', '#closeCropPopup', function(){
        $("#cropzee-input").val(null);
    })
    /* End Product Document of Analysis */

    function createCertificateHtml(cer) {
        for (let index = 0; index < cer.length; index++) {
            const element = cer[index];

            if(element && element.mimetype){
                var isImage = element.mimetype.split('/')[0];
            }

            if(isImage == 'application') {
                isImage = 'pdf';
            }
            element.fileType = isImage;
            certificates.push(element);
            $('#cError').hide();
            var total = $("#certificateDocumentList").find('.image-item').length;

            var link = base_url+'/uploads/certificates/'+element.name;
            var html = '<div class="image-item isNew" id="doc_'+(total+1)+'"><a href="'+link+'" target="_blank">'+element.name+'</a> <a data-name="'+element.name+'" href="javascript:void(0)" class="removeCertificate"><i class="fa fa-trash"></i></a></div>';
            $("#certificateDocumentList").append(html);
        }
    }
    function createProductDHtml(cer) {
        if(cer.length > 0)
                $('#pError').hide();

        for (let index = 0; index < cer.length; index++) {
            const element = cer[index];
            console.log('element', element);
            if(element) {
                if(element && element.mimetype){
                    var isImage = element.mimetype.split('/')[0];
                }
                // var isImage = element.mimetype.split('/')[0];
                element.fileType = isImage;
                productDocument.push(element);
                var total = $("#productDocumentList").find('.image-item').length;
                var link = base_url+'/uploads/product/'+element.name;
                if (element.extension) {
                    if(element.extension.toString().toLowerCase() == 'jpeg' || element.extension.toString().toLowerCase() == 'jpg' || element.extension.toString().toLowerCase() == 'png'){
                    var html = '<div class="image-item isNew" id="proddoc_'+(total+1)+'"><img src="'+link+'" alt="pImg" style="margin:0px;width:100px; height:70px"> <a data-name="'+element.name+'" href="javascript:void(0)" class="removeProductDocument">Remove</a></div>';
                    }else{
                        var html = '<div class="image-item isNew" id="proddoc_'+(total+1)+'">  <video src="'+link+'" alt="pImg" style="margin:0px;width:100px; height:70px"></video>  <a data-name="'+element.name+'" href="javascript:void(0)" class="removeProductDocument">Remove</a></div>';
                    }
                }
                $("#productDocumentList").append(html);
            }
        }
    }
    function createUploadProductDHtml(cer) {
        if(cer.length > 0)
                $('#pError').hide();

        const element = cer;
        console.log('element', element);
        if(element) {
            var filetype = "";
            var isImage = "";
            if(element && element.name){
                isImage = element.name.split('.')[1];
                filetype = element.name.split('.')[1];
            }
            // var isImage = element.mimetype.split('/')[0];
            element.fileType = isImage;
            productDocument.push(element);
            var total = $("#productDocumentList").find('.image-item').length;
            var link = base_url+'/uploads/product/'+element.name;
            if (filetype) {
                if(filetype.toString().toLowerCase() == 'jpeg' || filetype.toString().toLowerCase() == 'jpg' || filetype.toString().toLowerCase() == 'png'){
                var html = '<div class="image-item isNew" id="proddoc_'+(total+1)+'"><img src="'+link+'" alt="pImg" style="margin:0px;width:100px; height:70px"> <a data-name="'+element.name+'" href="javascript:void(0)" class="removeProductDocument">Remove</a></div>';
                }else{
                    var html = '<div class="image-item isNew" id="proddoc_'+(total+1)+'">  <video src="'+link+'" alt="pImg" style="margin:0px;width:100px; height:70px"></video>  <a data-name="'+element.name+'" href="javascript:void(0)" class="removeProductDocument">Remove</a></div>';
                }
            }
            $("#productDocumentList").append(html);
        }
    }


    /* Start autofill of saved data */
    var localdata = 0;
    function fillLocalData() {
        localdata = 1;
        var localData = localStorage.getItem('drafedData_{$loged.userid}');
        if(localData) {
            localData = JSON.parse(localData);
            storedData = localData;
            var amount_sold = '';
            var moq = '';
            var product_renew = '';
            var embedVideoFlag = false;
            localData.forEach(function(element) {
                if(element.id != 'embed_video') {
                    if(element.type == 'checkbox' || element.type == 'radio') {
                        $("#"+element.id).prop('checked', element.value);
                        if(element.value) {
                            setTimeout(function(){
                                $("#"+element.id).trigger('change');
                            }, 0);
                        }
                    } else if(element.type == 'select') {
                        $("#"+element.id).val(element.value);
                        if(element.value) {
                            setTimeout(function(){
                                $("#"+element.id).trigger('change');
                            }, 10);
                        }
                    } else if(element.type == 'file') {
                        if(element.name == 'certificateDocument') {
                            createCertificateHtml(element.value);
                            certificates = element.value;
                        } else if(element.name == 'productDocument') {
                            createProductDHtml(element.value);
                            productDocument = element.value;
                        }
                    } else {
                        setTimeout(function(){
                            $("#"+element.id).val(element.value);
                        }, 10);
                    }
                } else if(element.id == 'embed_video') {
                    if(!embedVideoFlag) {
                       
                        embedVideoFlag = true;
                        var videoUrlLength = localData.filter(x => x.id === 'embed_video').length;
                        var videoUrlArray = localData.filter(x => x.id === 'embed_video');
                        if(videoUrlLength > 0) {
                            if(videoUrlLength == 1)
                                $('#embed_video').val(element.value);

                            if(videoUrlLength > 1) {
                                $.each(videoUrlArray, (i, v) => {
                                    if(i == 0)
                                        $('#embed_video').val(v.value);
                                    else {
                                        var html = `<div class="row"> 
                                            <div class="col-sm-9 form-group pr-0">
                                                <input type="url" class="form-control embed_video" placeholder="Vimeo / YouTube Video Link" name="embed_video[]" id="embed_video" value="`+v.value+`" data-parsley-type="url" />
                                            </div>
                                            <div class="col-sm-3 form-group pl-1">
                                                <button class="btn btn-danger remove_this" type="button">Remove</button>
                                            </div> 
                                        </div>`;
                                        $("#appendVideoUrl").append(html);
                                    }
                                });
                            }
                        }
                    }
                }
                if(element.id == 'amount_sold')
                    amount_sold = element.value;
                if(element.id == 'moq')
                    moq = element.value;
                if(element.id == 'product_renew')
                    product_renew = element.value;
            });
            $('#amount_sold').val(amount_sold);
            $('#moq').val(moq).trigger('change');
            $('#product_renew').val(product_renew).trigger('change');
            setTimeout(function(){
                for (let step = 1; step < 4; step++) {
                    if(step == 1) {
                        
                        $('.typeCheckbox:checked').trigger('change');
                    }
                    if($("#step"+step+"_form").parsley().isValid()) {
                        if(step == 1) {
                            $('#amount_sold').val(amount_sold);
                            $('#moq').val(moq).trigger('change');
                            $('#product_renew').val(product_renew).trigger('change');
                            if($("#productDocumentList").find('.image-item').length <= 0){
                                $('#pError').show();
                                return false;
                            }
                        }
                        $("#step"+step+"_form").trigger('submit');
                    } else {
                        break;
                    }
                }
            }, 1000);
        }
    }
    /* End autofill of saved data */

    /* Start save data to localStorage */
    function storeLocalData(step) {
        var elements = [];

        $('.product_form input, .product_form select, .product_form textarea').each(
            function(index) {
                var input = $(this);
                var name = input.attr('name');
                var type = input.attr('type') ? input.attr('type') : (input[0].selectedIndex!=undefined ? 'select' : 'text');
                var val = input.val();
                if(type == 'checkbox' || type == 'radio') {
                    val = input.prop('checked');
                } else if(type == 'file') {
                    if(name == 'certificateDocument') {
                        val = certificates;
                    } else if(name == 'productDocument') {
                        val = productDocument;
                    }
                }
                var obj = {
                    type: type,
                    id: input.attr('id'),
                    name: name,
                    value: val
                };
                if(name == 'payment_method') {
                    if(input.prop('checked')) {
                        obj.value = input.val();
                        elements.push(obj);
                    }
                } else {
                    elements.push(obj);
                }
            }
        );
        
        localStorage.setItem('drafedData_{$loged.userid}', JSON.stringify(elements));
        
    }
    /* End save data to localStorage */

    $('body').on('click', '#saveToDraft', function() {
        storeLocalData(4);
        saveProductToDraft();
    });

    /* Start Save Product to Draft */
    function saveProductToDraft() {
        // if($("#step4_form").parsley().validate()) {
            /* if($("#productDocumentList").find('.image-item').length <= 0) {
                $('#pError').show();
                return;
            }

            if($("#certificateDocumentList").find('.image-item').length <= 0) {
                $('#cError').show();
                return;
            } */

            var formArray = []
            for (let index = 1; index <= 4; index++) {
                var formArr = $("#step"+index+"_form").serializeArray();
                formArray = formArray.concat(formArr);
            }

            var productObj = {};
            var productData = formArray ? formArray : [];
            if(productData.length) {
                for (var index = 0; index < productData.length; index++) {
                    const element = productData[index];
                    productObj[productData[index].name] = productData[index].value;
                }
            }
            productObj['productDocument'] = productDocument;
            productObj['certificatesDocument'] = certificates;
            
            var type = 'auction';
            var auctionChecks = $('#auction_check').is(":checked");
            var fixedPriceChecks = $('#fp-price_check').is(":checked");
            var offerPriceChecks = $('#ofr-price_check').is(":checked");
            if(auctionChecks) {
                type = 'auction';
            } else if(fixedPriceChecks) {
                type = 'fixed';
            } else if(offerPriceChecks) {
                type = 'offer';
            }

            productObj['type'] = type;

            productObj['videoUrl'] = [];
            if($('.embed_video').length > 0) {
                $('.embed_video').each(function(i, v) {
                    if($(this).val() && $(this).val() != "" && $(this).val() != null && $(this).val() != 'undefined')
                        productObj['videoUrl'].push($(this).val());
                });
            }

            productObj['product_id'] = $('#product_id').val();
            
            $.ajax({
                method: "POST",
                url: '/product/saveProductToDraft',
                data: productObj,
                dataType: 'JSON',
                cache: false,
                success: function (data) {
                    
                    if(data.success) {
                        localStorage.removeItem('drafedData_{$loged.userid}');
                        $('#draft-success').modal('show');
                    } else
                        window.location.reload();
                }
            });
        // }
    }
    /* End Save Product to Draft */

    /* Start Next-Previous step of product post */
    function gotoStep(step) {
        $('#cError').hide();
        $('#pError').hide();
        var category_id = $('#category_id').val();
        if(step == 2){
            var category_id = $('#category_id').val();
           
            $('.suply1').show()
            $('.doc2').hide()
            $('#qty_available').val('0')
        }
        if(step == 3 || step == 4){
            if(category_id == 15){
                $('.suply2').hide();
                $('.doc2').show();
                $('.doc1').hide();
            }else{
                $('.suply2').show()
                $('.doc1').show();
                $('.doc2').hide()
            }
        }
        
        if(step == 4){
            if(category_id != 15) {
                if($("#ctype_div").find('input[type="checkbox"]:checked').length <= 0){
                    $('#ctype_error').show();
                    return;
                }
                if($("#canalysis_div").find('input[type="checkbox"]:checked').length <= 0){
                    $('#canalysis_error').show();
                    return;
                }
            }
        }
        if(step == 4){
            if($("#certificateDocumentList").find('.image-item').length <= 0){
                $('#cError').show();
                return;
            }
        }
        $(".step-item").removeClass('active');
        $(".steps-wrapper").find('div').removeClass('active');
        $(".step_data").hide();
        for (let index = 1; index <= step; index++) {
            
            $("#step"+(index-1)+"_data").hide();
            $("#step"+index+"_data").show();
            $(".step"+(index-1)).addClass('active');
            $(".step"+index).find('div').addClass('active');
            setTimeout(function() {
                window.scrollTo({ top: 0, behavior: 'smooth' });
            })
        }
        window.scrollTo();
    }
    /* End Next-Previous step of product post */

    /* Start Preview of product post */
    function previewProduct() {
        if($("#step"+4+"_form").parsley().validate() && $("#productDocumentList").find('.image-item').length > 0) {
        $('input[name="productDocument"]').val();
        storeLocalData(4);
        var localData = localStorage.getItem('drafedData_{$loged.userid}');
        localData = JSON.parse(localData);
        storedData = localData;

        $.ajax({
            method: "POST",
            url: '/product/saveDraftData',
            data: { draftData: storedData },
            dataType: 'JSON',
            cache: false,
            success: function (data) {
                window.open('/product/preview', '_new');

            }
        });
        }else{
            alert('Please make sure, all required fields are entered!')
        }
    }
    /* End Preview of product post */

    function isNumberKey(evt)
       {
          var charCode = (evt.which) ? evt.which : evt.keyCode;
          if (charCode != 46 && charCode > 31
            && (charCode < 48 || charCode > 57))
             return false;

          return true;
       }

    $('#buynow_price').change(function(){
        var bprice = parseFloat( $('#buynow_price').val());
        var sprice = parseFloat($('#start_price').val());
        var rprice = parseFloat($('#reserve_price').val());
        
        if(bprice <= sprice) {
            $('#berror').html('Buy now price should be greater than start price').css('color', 'red');
            $('#buynow_price').val('');
            $('#berror').show();
        } else if(bprice < rprice && rprice>0) {
            $('#berror').html('Buy now price should be greater than or equal to reserve price').css('color', 'red');
            $('#buynow_price').val('');
            $('#berror').show();
        } else {
            $('#berror').hide();
        }
    })

    $('#reserve_price').change(function(){
    var sprice = parseFloat($('#start_price').val());
    var rprice = parseFloat($('#reserve_price').val());
     var bprice = parseFloat( $('#buynow_price').val());
            if( rprice <= sprice && rprice>0   )
            {
            $('#rerror').html('Reserve price should be greater than start price ').css('color', 'red');
            $('#reserve_price').val('');
            $('#rerror').show();
            }
            else if(rprice > bprice && bprice > 0){
                $('#rerror').html('Reserve price should be less than Buy now price ').css('color', 'red');
                $('#reserve_price').val('');
                $('#rerror').show();
            }
            else{
                $('#rerror').hide();
            }
   })

   $('#start_price').change(function(){
    var bprice = parseFloat( $('#buynow_price').val());
   var sprice = parseFloat($('#start_price').val());
   var rprice = parseFloat($('#reserve_price').val());
        if( rprice <=sprice || (bprice <= sprice && $("#buy-now_check").prop("cheked"))  && sprice>0)
         {
        $('#serror').html('Start price should be less than reserve price').css('color', 'red');
         $('#serror').show()
        $('#start_price').val('');
        }else{
            $('#serror').hide();
        }
   });

    $('body').on('keyup', '.moqqty', function() {
        $('body .qty').val($(this).val());
    });

    $('body').on('change', '#unit_of_measurement', function() {
        $('#amount_sold').val('');
        $('#moq').val('');
    });
</script>
<script src="{$config.url}/js/jquery-ui.js"></script>
<script>
    getAds();
    function getAds() {
        var Obj = {
            page: 'product_post'
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
    
    $( function() {
      $( "#productDocumentList" ).sortable({
        
        start: function(event, ui) {
        var start_pos = ui.item.index();
        ui.item.data('start_pos', start_pos);
       ui.item.toggleClass("highlight");
    },
        update: function (event, ui) {
        var start_pos = ui.item.data('start_pos');
        var end_pos = ui.item.index();
        var b = productDocument[start_pos];
        productDocument.splice(start_pos,1);
        productDocument.splice(end_pos, 0, b);
        localStorage.removeItem('drafedData_{$loged.userid}');
        storeLocalData(4);
       
    },
    stop: function (event, ui) {
			ui.item.toggleClass("highlight");
			}
    });
    } );
    </script>

    <style>
        .removeProductDocument{
            margin-left: -3px;
            /* margin-top: -10px; */
            color: white;
            /* zoom: 1.2; */
            font-size: 12px;
            cursor: pointer;
            margin-top: 0;
            width: 148px;
            padding: 0;
            background: red;
            /* height: 20px; */
            padding: 11px;
            padding-right: 32px;
            top: -61px;
            border-right: 1px solid gray;
            border-bottom: 1px solid gray;
            padding-left: 31px;
            padding-top: 11px;
            border-left: 1px solid gray;
        }


        #productDocumentList .image-item {
            font-size: 30px;
            text-align: center;
            cursor: pointer;
            font-family: Geneva,Arial,Helvetica,sans-serif;
            border: 1px solid gray;
            width:109px;
            height: 80px;
            margin-top: 10px;
            margin-bottom: 50px !important;
        }

        #productDocumentList .ui-selected {
            background: red;
            color: white;
            font-weight: bold;
        }

        #productDocumentList {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

        #productDocumentList div {
            float: left;
            margin: 2px;
            padding: 2px;
            width: 110px;
            height: 110px;
            line-height: 50px;
        }

        .highlight {
            border: 2px solid red;
            font-weight: bold;
            font-size: 50px;
            background-color: lightblue;
        }

        #productDocumentList a:hover{
            color:#fff;
            background-color: black;
            transition: 0.5s;
        }

    </style>