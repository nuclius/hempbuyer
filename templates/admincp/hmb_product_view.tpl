{include file="/admincp/header.tpl" nocache}
<style>
.tab-content {
    background: #fff;
    display: inline-block;
    padding: 40px 10px;
    width: 100%;
}

.nav-tabs .nav-item {
    margin-bottom: -1px;
}
.nav-tabs {
    border-bottom: 1px solid #ddd;
    margin: 0;
}
.nav>li>a {
    position: relative !important;
    display: block !important;
    padding: 10px 15px !important;
}
.nav-tabs .nav-link {
    padding: .5rem 0;
    margin: 0;
    font-weight: 600;
    color: #868686;
    cursor: pointer;
    border: 1px solid transparent;
}
.nav-tabs .nav-link.active, .nav-tabs .nav-link:hover {
    color: #5a9234;
    background-color: transparent;
    border-bottom: unset;
    cursor: pointer;
}
.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover {
    color: #5a9234;
    cursor: default;
    background-color: #fff;
    border: 1px solid #ddd;
    border-bottom-color: transparent;
}
.nav-tabs .nav-link:hover {
    background-color: #efefef;
}
.tooltip {
    box-shadow: 0px 0px 4px #CCC;
}
input[type=radio] + label {
    display: inline-block;
    cursor: pointer;
    line-height: 20px;
    padding-left: 30px !important;
    margin-right: 15px;
    position: relative;
    font-size: 15px;
}
.radio_list .radio {
    width: 50%;
    float: left;
    margin: 7px 0px;
}
.radio_list .parsley-errors-list {
    display: none;
}

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
.slider.round {
    border-radius: 34px;
}
input:checked + .slider {
    background-color: #5E9836;
}
.slider.round:before {
    border-radius: 50%;
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
input:checked + .slider:before {
    -webkit-transform: translateX(26px);
    -ms-transform: translateX(26px);
    transform: translateX(26px);
}

#productDocumentList .image-item {
    font-size: 30px;
    text-align: center;
    object-fit:cover;
    cursor: pointer;
    font-family: Geneva,Arial,Helvetica,sans-serif;
    border: 1px solid gray;
    width: 110px;
    margin-top: 10px;
    margin-bottom: 50px !important;
}
#productDocumentList div {
    float: left;
    margin: 2px;
    padding: 2px;
    width: 110px;
}
.removeProductDocument {
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
.mt-10 {
    margin-top: 10px !important;
}
.check-group .cus-check:last-child {
    max-width: 25%;
}
.form-inline.form-group > label {
    min-width: 240px;
    justify-content: left;
}
</style>

<div class="container-fluid">
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li class="active"> Product <i class="fa fa-angle-double-right"></i> {if $product.id == 0 or $product.id == ''} Add {else} View {/if} Product <i class="fa fa-angle-double-right"></i> {$product.title} </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
        {if $error != ''}
            <div class="alert alert-danger"><strong>{$error}</strong></div>
        {/if}   
    </div>

    <input type="hidden" value="{$users.id}" name="id"/>
    <ul class="nav nav-tabs mb-3" id="pills-tab" role="tablist" style="background: #fff; font-size: 16px;">
        <li class="nav-item active">
            <a class="nav-link " id="pills-product-tab" data-toggle="pill" href="#pills-product" role="tab" aria-controls="pills-product" aria-selected="true">PRODUCT INFO</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="pills-manufacture-tab" data-toggle="pill" href="#pills-manufacture" role="tab" aria-controls="pills-manufacture" aria-selected="false">MANUFACTURE</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="pills-certificate-tab" data-toggle="pill" href="#pills-certificate" role="tab" aria-controls="pills-certificate" aria-selected="false">CERTIFICATE</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="pills-payment-tab" data-toggle="pill" href="#pills-payment" role="tab" aria-controls="pills-payment" aria-selected="false">PURCHASE & PAYMENT INFORMATION</a>
        </li>
    </ul>
        <div class="tab-content" id="pills-tabContent">
        <div class="tab-pane fade active in" id="pills-product" role="tabpanel" aria-labelledby="pills-product-tab">
            <form enctype="multipart/form-data" class="admin_form" data-parsley-validate id="formstep_1" method="post" enctype="multipart/form-data" action="{$config.url}/{$loged.adminUrl}/users/save">
                <input type="hidden" name="product_id" id="product_id" value="{$product.id}">
                <input type="hidden" name="market_status" id="market_status" value="{$product.market_status}">

                <div class="col-sm-1"></div>
                <div class="col-sm-10">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="">Category</label>
                                <div class="clearfix cselec-wrap-remove ">
                                    <select class="custom-select" name="category_id" id="category_id" required data-parsley-errors-container="#category-err" data-parsley-required-message="Category is required.">
                                        <option value="">Select Category</option>
                                        {foreach $categories as $key => $val}
                                            <option value="{$val.id}" {if $product.category_id==$val.id} selected {/if}>{$val.name}</option>
                                        {/foreach}
                                    </select>
                                </div>
                                <span id="category-err" class="err-message"></span>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="">Subcategory</label>
                                <div class="clearfix cselec-wrap-remove ">
                                    <select class="custom-select" name="subcategory_id" id="subcategory_id" >
                                        <option value="" selected>Select Subcategory</option>
                                    </select>
                                </div>
                                <span id="subcategory-err" class="err-message"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="">Product Title</label>
                                <input class="form-control" placeholder="Product Title - Use words your buyers will search for." name="title" id="title" required data-parsley-required-message="Product Title is required." value="{$product.title}" />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="">Unit of Measurement</label>
                                <div class="clearfix cselec-wrap-remove ">
                                    <select class="custom-select" name="unit_of_measurement"  style="height: 47px;" id="unit_of_measurement" required data-parsley-required-message="Measurement is required.">
                                        {if $product.productMeasurements.length > 0}
                                            {foreach $product.productMeasurements as $key => $val}
                                                <option value="{$val.unit_name}" {if $product.unit_of_measurement==$val.unit_name} selected {/if}>{$val.unit_name}</option>
                                            {/foreach}
                                        {/if}
                                       <!--  <option value="" >Select Measurement</option>
                                        <option value="Grams" {if $product.unit_of_measurement=='Grams'}selected{/if}>Grams</option>
                                        <option value="Kilos" {if $product.unit_of_measurement=='Kilos'}selected{/if}>Kilos</option>
                                        <option value="Liters" {if $product.unit_of_measurement=='Liters'}selected{/if}>Liters</option>
                                        <option value="Pounds" {if $product.unit_of_measurement=='Pounds'}selected{/if}>Pounds</option> -->
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="">Total Amount Available</label>
                                <input class="form-control" placeholder="Enter how many/total quantity being sold" name="amount_sold" id="amount_sold" required data-parsley-required-message="Amount is required." value="{$product.amount_sold}" onkeypress='return isNumberKey(event)' />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="">MOQ</label>
                                <input class="form-control moqqty" placeholder="Minimum Order Quantity" name="moq" id="moq" required data-parsley-required-message="MOQ is required." value="{$product.moq}" onkeypress='return isNumberKey(event)' />
                            </div>
                        </div>
                    </div>


                    <hr class="pp-divider" />
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-inline check-group">
                                <div class="cus-check form-group">
                                    <input type="checkbox" id="auction_check" name="type" class="typeCheckbox" {if $product.type=='auction' || !$product.id}checked{/if} value="auction">
                                    <span class="checkmark"></span> <label for="auction_check">Auction</label>
                                </div>
                                <div class="cus-check form-group">
                                    <input type="checkbox" id="fp-price_check" name="type" class="typeCheckbox" value="fixed" {if $product.type=='fixed'}checked{/if}>
                                    <span class="checkmark"></span> <label for="fp-price_check">Fixed Priced Product</label>
                                </div>
                                <div class="cus-check form-group" style="width: 26%;">
                                    <input type="checkbox" id="ofr-price_check" name="type" class="typeCheckbox" value="offer" {if $product.type=='offer'}checked{/if}>
                                    <span class="checkmark"></span> <label for="ofr-price_check">Offer Priced Product</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-sm-12">
                            <div id="auction" class="typeDiv {if $product.type=='auction' || !$product.id}active{/if}">
                                <div class="row">
                                    <div class="col-sm-12 form-group" style="display: inline-flex;">
                                        <div class="col-sm-2" style="padding-left: 0;">
                                        <label class="">
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
                                    <div class="col-sm-6 form-group">
                                        <label class="pp-label ppl_tool_tip">
                                            Start Price
                                            <span class="reg-info"><img src="./images/info.png" alt=""></span>
                                            <span class="reg_info_text">
                                            <p>Start Price is the least amount a bidder is allowed to bid in an auction. If your reserve price is not met, your not obligated to sell your product.</p></span>
                                        </label>
                                        <input class="form-control" placeholder="Start Price" name="start_price" onkeypress='return isNumberKey(event)' id="start_price" required data-parsley-required-message="Start Price is required." value="{$product.start_price}" />
                                        <span id="serror"></span>
                                    </div>
                                    <div class="col-sm-6 form-group">
                                        <label class="pp-label ppl_tool_tip">
                                            Reserve Price
                                            <span class="reg-info"><img src="./images/info.png" alt=""></span>
                                            <span class="reg_info_text">
                                                <p>A reserve price is the least amount you are willing to sell your item for.</p>
                                            </span>
                                        </label>
                                        <input class="form-control" onkeypress='return isNumberKey(event)' placeholder="Reserve Price" name="reserve_price" id="reserve_price" required data-parsley-required-message="Reserve Price is required." value="{$product.reserve_price}" />
                                        <span id="rerror"></span>
                                    </div>
                                </div>
                            </div>
                            <div id="buy-now" class="typeDiv {if $product.type=='auction' && $product.is_buynow=='1'}active{/if}">
                                <div class="row">
                                    <div class="col-sm-6 form-group">
                                        <label class="pp-label ppl_tool_tip">Buy Now Price
                                            <span class="reg-info"><img src="./images/info.png" alt=""></span>
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
                                    </div>
                                    <div class="col-sm-6 form-group">
                                        <label class="pp-label">Offer quantity</label>
                                        <input class="form-control qty" placeholder="Offer quantity" name="offer_qty" id="offer_qty" required data-parsley-required-message="Offer quantity is required." value="{$product.offer_qty}" onkeypress='return isNumberKey(event)' />
                                        <span id="offerqty_error"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr class="pp-divider" />

                    <div class="row">
                        <div class="col-sm-12 form-group">
                            <label class="pp-label">Description</label>
                            <textarea rows="4" class="form-control" name="description" id="description"
                                placeholder="Enter Description - Include anything that will help buyers make an informed purchase decision. Provide as much detail about your product as possible." required data-parsley-required-message="Description is required.">{$product.description}</textarea>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-4 form-group">
                            <label class="pp-label">Start Date</label>
                            <div class="cal-input">
                                <input readonly="readonly" style="background: white; cursor: pointer;" class="form-control" placeholder="Start Date" name="start_date" id="start_date" autocomplete="off" required data-parsley-required-message="Start Date is required." data-parsley-errors-container="#start_date-err" data-parsley-trigger="change" value="{$product.start_date}" />
                                <span class="cal-img">
                                    <img src="{$config.url}/images/calendar.png" alt="calendar" />
                                </span>
                            </div>
                            <span id="start_date-err" class="err-message"></span>
                        </div>
                        <div class="col-sm-4 form-group">
                            <label class="pp-label ppl_tool_tip">
                                End Date
                                <span class="reg-info auction" style="display: block;"><img src="./images/info.png" alt=""></span>
                                <span class="reg_info_text auction" style="display: block;">
                                    <p>Maximum length of an auction is 10 days.</p>
                                </span>
                                <span class="reg-info fixedprice" style="display: none;"><img src="./images/info.png" alt=""></span>
                                <span class="reg_info_text fixedprice" style="display: none;">
                                    <p>Maximum length of a fixed priced listing is 30 days.</p>
                                </span>
                            </label>
                            <div class="cal-input">
                                <input  readonly="readonly" style="background: white; cursor: pointer;" class="form-control" placeholder="End Date" name="end_date" id="end_date" autocomplete="off" required data-parsley-required-message="End Date is required." data-parsley-errors-container="#end_date-err" data-parsley-trigger="change" value="{$product.end_date}" />
                                <span class="cal-img">
                                    <img src="{$config.url}/images/calendar.png" alt="calendar" />
                                </span>
                            </div>
                            <span id="end_date-err" class="err-message"></span>
                        </div>
    
                        <div class="col-sm-4 form-group">
                            <label class="pp-label">Automatically Renew</label>
                            <div class="">
                                <select class="custom-select" name="product_renew" id="product_renew" style="height: 47px;">
                                    <!-- <option value="" selected>Select Renew Period</option> -->
                                    <option value="0" {if $product.renew=='0'}selected{/if}>Automatically Renew Period</option>
                                    {foreach $renewTime as $key => $val}
                                        <option value="{$val.id}" {if $product.renew==$val.id}selected{/if}>{$val.val}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <span id="end_date-err" class="err-message"></span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12 form-group">
                            <!-- <label class="pp-label">
                                Upload product images ( JPEG, PNG ) and or video ( MP4, WMV, MOV, MPEG )
                                <i class="fa fa-spinner fa-spin image-loader" id="productDocumentLoader" style="display: none;"></i>
                            </label> -->
                            <label class="pp-label">Product Images
                                <p class="note-txt doc1">
                                    &nbsp;&nbsp;&nbsp;Upload product images ( JPEG, PNG )
                                </p>
                                <i class="fa fa-spinner fa-spin image-loader" id="productDocumentLoader" style="display: none;"></i>
                            </label>
                            <div class="upload-document">
                                <input type="file" class="form-control" name="productDocument" onchange="editProductFileupload(this);" accept=".png, .jpeg, .jpg" multiple id="productDocument">
                                <div>DRAG IMAGE FILE</div>
                                <button class="btn btn-primary" type="button" onclick="$('#productDocument').trigger('click');">
                                    UPLOAD IMAGE FILE
                                </button>
                                <!-- <div class="btxt">Image size (500x500), Video time limit (1 - 2min), Max File Size (5MB)</div> -->
                                <div class="btxt text-center">Max Image File Size (5MB)</div>
                                <!-- <div id="pError" style="color:red">Please upload product image.</div> -->
                            </div>
                            <!-- <label style="color: red;" >*First Image will be set as primary thumbnail of product.</label> -->
                        </div>
                        <div id="productDocumentList" class="pro-img-list" style="padding:0 15px;">
                            {if $product.productImages.length > 0}
                                {foreach $product.productImages as $key => $val}
                                    <div class="image-item proddocupp" id="proddoc_{$key+1}"><img onload="pushInDocument('{$val.avatar}')" src="{$config.url}/uploads/product/{$val.avatar}" alt="No Image Available" onerror="this.onerror=null;this.src='/no_image.png';" style="margin:0px;width:100px; height:80px"> <a data-name="{$val.avatar}" href="javascript:void(0)" class="removeProductDocument">Remove</a></div>
                                {/foreach}
                            {/if}
                        </div>
                    </div>
    
                    <div class="row">
                        {if $product.id>0}
                            {if $product.productVideos.length>0}
                                <div class="col-sm-12">
                                    <div class="form-group" id="appendVideoUrl">
                                    {foreach $product.productVideos as $k => $v}
                                        {if $k==0}
                                                <label class="pp-label">Embed Vimeo / YouTube Video Link</label>
                                            <div class="mt-10">
                                                <button class="btn btn-info col-3" type="button" id="append" name="append" style="width: 25%; float: right;">Add Video Link</button>
                                                <input class="form-control col-9 embed_video" placeholder="Embed Vimeo / YouTube Video Link" name="embed_video[]" id="embed_video" value="{$v.avatar}" style="width: 75%;" />
                                            </div>
                                        {else/}
                                            <!-- <div class="col-sm-12 form-group"> -->
                                                <div class="mt-10">
                                                    <button class="btn btn-danger col-3 remove_this" type="button" style="width: 25%; float: right;">Remove</button>
                                                    <input class="form-control col-9 embed_video" placeholder="Embed Video / YouTube Video Link" name="embed_video[]" id="embed_video" value="{$v.avatar}" style="width: 75%;" />
                                                </div>
                                            <!-- </div> -->
                                        {/if}
                                    {/foreach}
                                    </div>
                                </div>
                            {else/}
                            <div class="col-sm-12">
                                <div class="form-group" id="appendVideoUrl">
                                    <label class="pp-label">Embed Vimeo / YouTube Video Link</label>
                                    <div class="">
                                        <div class="col-sm-12 mt-10">
                                            <button class="btn btn-info col-3" type="button" id="append" name="append" style="width: 25%; float: right;">Add Video Link</button>
                                            <input class="form-control col-9 embed_video" placeholder="Embed Vimeo / YouTube Video Link" name="embed_video[]" id="embed_video" style="width: 75%;" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            {/if}
                        {else/}
                        <div class="col-sm-12">
                            <div class="form-group" id="appendVideoUrl">
                                <label class="pp-label">Embed Vimeo / YouTube Video Link</label>
                                <div class="">
                                    <div class="col-sm-12">
                                        <button class="btn btn-info col-3" type="button" id="append" name="append" style="width: 25%; float: right;">Add Video Link</button>
                                        <input class="form-control col-9 embed_video" placeholder="Embed Vimeo / YouTube Video Link" name="embed_video[]" id="embed_video" style="width: 75%;" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        {/if}
                    </div>

                    <div class="row">
                        <div class="col-sm-4">
                            <button id="adminsub_button" type="submit" class="btn btn-success">Save</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <div class="tab-pane fade" id="pills-manufacture" role="tabpanel" aria-labelledby="pills-manufacture-tab">
            <form enctype="multipart/form-data" class="admin_form" data-parsley-validate id="formstep_2" method="post" enctype="multipart/form-data" action="{$config.url}/{$loged.adminUrl}/users/save">
                <input type="hidden" name="product_id" id="product_id" value="{$product.id}">
                <input type="hidden" name="market_status" id="market_status" value="{$product.market_status}">

                <div class="col-sm-1"></div>
                <div class="col-sm-10">
                        
                    <div class="row">
                        <div class="col-sm-6 form-group">
                            <label class="pp-label">Packaging & Storage Description</label>
                            <textarea class="form-control" rows="4" placeholder="Packaging & Storage Description" name="packaging_description" id="packaging_description" required data-parsley-required-message="Packaging & Storage Description is required.">{$product.packaging_description}</textarea>
                        </div>
                        <div class="col-sm-6 form-group">
                            <label class="pp-label ppl_tool_tip">Keywords
                                <!-- <a class="info-wrap" data-toggle="tooltip" data-placement="right"
                                    title="Enter in searchable words your buyer might look for. Examples would be a particular cultivar/strain like “Lifter” or Cherry Wine. Or perhaps your product is high in minors, put “minors” or high minors">
                                    <i class="fa fa-info-circle"></i>
                                </a> -->
                                <!-- <span class="reg-info"><img src="{$config.url}/images/info.png" alt=""></span>
                                <span class="reg_info_text">
                                    <p>Enter in searchable words your buyer might look for. Examples would be a particular cultivar/strain like “Lifter” or Cherry Wine. Or perhaps your product is high in minors, put “minors” or high minors</p>
                                </span> -->
                            </label>
                            <textarea class="form-control" style="height: 70px;" rows="4" placeholder="Keywords" name="keywords" id="keywords" required data-parsley-required-message="Keywords">{if $product.keywords}{$product.keywords}{/if}</textarea>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 form-group suply1">
                            <label class="pp-label">
                                Date of Manufacture or Harvest
                            </label>
                            <div class="cal-input">
                                <input class="form-control" placeholder="Date of Manufacture or Harvest" name="manufacture_date" id="manufacture_date" autocomplete="off" required data-parsley-required-message="Date of Manufacture is required." data-parsley-errors-container="#manufacture_date-err" data-parsley-trigger="change" value="{$product.manufacture_date}" />
                                <span class="cal-img">
                                    <img src="{$config.url}/images/calendar.png" alt="calendar" />
                                </span>
                            </div>
                            <span id="manufacture_date-err" class="err-message"></span>
                        </div>
                        <div class="col-sm-6 form-group">
                            <label class="pp-label">
                                Location of Product
                            </label>
                            <div class="clearfix cselec-wrap-remove">
                                <select class="custom-select" name="product_place" id="product_place" required data-parsley-required-message="Location of product is required" style="height: 47px;">
                                    <option value="">Select Location of Product</option>
                                    {foreach $states as $key => $val}
                                    <option value="{$val.abbrev}" {if $product.product_place==$val.abbrev} selected {/if}>{$val.name}</option>
                                {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row doc2">
                        <div class="col-sm-6 form-group doc2">
                            <label class="pp-label">
                                Quantity Available
                            </label>
                            <div class="cal-input">
                                <input class="form-control" placeholder="Quantity available" name="qty_available" onkeypress='return isNumberKey(event)' id="qty_available" required data-parsley-required-message="Quantity available is required" value="{$product.qty_available}" />
                            </div>
                            <span id="manufacture_date-err" class="err-message"></span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-4">
                            <button id="adminsub_button" type="submit" class="btn btn-success">Save</button>
                        </div>
                    </div>

                </div>
            </form>
        </div>

        <div class="tab-pane fade" id="pills-certificate" role="tabpanel" aria-labelledby="pills-certificate-tab">
            <form enctype="multipart/form-data" class="admin_form" data-parsley-validate id="formstep_3" method="post">
            <!-- <form data-parsley-validate id="formstep_3" method="post"> -->
            <!-- <div data-parsley-validate id="formstep_3"> -->
                <input type="hidden" name="product_id" id="product_id" value="{$product.id}">
                <input type="hidden" name="market_status" id="market_status" value="{$product.market_status}">

                <div class="col-sm-1"></div>
                <div class="col-sm-10">
                    <div class="row suply2">
                        <div class="col-sm-12">
                            <div class="form-inline form-group check-group">
                                <div class="w-100 text-left">
                                    <label class="pp-label float-left">Attributes</label><br><br>
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
                                <hr style="width: 100%; margin-top: 20px; float: left;">

                                <!-- <div class="cus-check form-group">
                                    <input type="checkbox" name="ctype_certified_organic" id="ctype_certified_organic" value="certified_organic" {if $product.certificate_types[0]=='certified_organic'}checked{/if}>
                                    <span class="checkmark"></span> Certified Organic
                                </div>
                                <div class="cus-check form-group">
                                    <input type="checkbox" name="ctype_gmp" id="ctype_gmp" value="gmp" {if $product.certificate_types[1]=='gmp'}checked{/if}>
                                    <span class="checkmark"></span> GMP
                                </div>
                                <div class="cus-check form-group">
                                    <input type="checkbox" name="ctype_iso" id="ctype_iso" value="iso" {if $product.certificate_types[2]=='iso'}checked{/if}>
                                    <span class="checkmark"></span> ISO
                                </div>
                                <div class="cus-check form-group">
                                    <input type="checkbox" name="ctype_kosher" id="ctype_kosher" value="kosher" {if $product.certificate_types[3]=='kosher'}checked{/if}>
                                    <span class="checkmark"></span> Kosher
                                </div>
            
                                <hr style="width: 100%; margin-top: 20px;">
            
                                <div class="cus-check form-group">
                                    <input type="checkbox" name="ctype_sqf" id="ctype_sqf" value="sqf" {if $product.certificate_types[4]=='sqf'}checked{/if}>
                                    <span class="checkmark"></span> SQF
                                </div>
                                <div class="cus-check form-group">
                                    <input type="checkbox" name="ctype_fda_registered" id="ctype_fda_registered" value="fda_registered" {if $product.certificate_types[5]=='fda_registered'}checked{/if}>
                                    <span class="checkmark"></span> FDA Registered
                                </div>
                                <div class="cus-check form-group">
                                    <input type="checkbox" name="ctype_statement_of_origin" id="ctype_statement_of_origin" value="statement_of_origin" {if $product.certificate_types[6]=='statement_of_origin'}checked{/if}>
                                    <span class="checkmark"></span> Statement of Origin available
                                </div>
                                <div class="cus-check form-group">
                                    <input type="checkbox" name="ctype_statement_of_compliance" id="ctype_statement_of_compliance" value="statement_of_compliance" {if $product.certificate_types[7]=='statement_of_compliance'}checked{/if}>
                                    <span class="checkmark"></span> Statement of Compliance available
                                </div> -->
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 form-group suply2">
                            <label class="pp-label">
                                Date of Certificate of Analysis
                            </label>
                            <div class="cal-input">
                                <input class="form-control" placeholder="Date of Certificate of Analysis" name="certificate_date" id="certificate_date" required data-parsley-required-message="End Date is required." data-parsley-errors-container="#certificate_date-err" data-parsley-trigger="change" autocomplete="off" value="{$product.certificate_date}" />
                                <span class="cal-img">
                                    <img src="{$config.url}/images/calendar.png" alt="calendar" />
                                </span>
                            </div>
                            <span id="certificate_date-err" class="err-message"></span>
                        </div>
                        <div class="col-sm-12 form-group">
                            <label class="pp-label doc1">
                                Upload Certificate of Analysis (pdf, jpeg, png)
                                <i class="fa fa-spinner fa-spin image-loader" id="certificateDocumentLoader" style="display: none;"></i>
                            </label>
    
                            <label class="pp-label doc2">
                                Upload Supporting Documents
                                <i class="fa fa-spinner fa-spin image-loader" id="certificateDocumentLoader" style="display: none;"></i>
                            </label>
                            <div class="upload-document">
                                <input type="file" class="form-control" name="certificateDocument" onchange="editCertificateFileupload(this);" accept=".png, .jpeg, .jpg, .pdf" id="certificateDocument">
                                <!-- <div class="doc1">DRAG CERTIFICATE</div>
                                <button class="btn btn-primary doc1">
                                    UPLOAD CERTIFICATE
                                </button>-->
                                <!-- <div class="doc">DRAG DOCUMENT</div>
                                <input type="submit" class="btn btn-primary doc" value="UPLOAD DOCUMENT"> -->

                                <div class="doc">DRAG DOCUMENT</div>
                                <button class="btn btn-primary doc" type="button" onclick="$('#certificateDocument').trigger('click');">
                                    UPLOAD DOCUMENT
                                </button>
                                <!-- <div id="cError" style="color:red">Please upload certificates.</div> -->
                            </div>
                            <div id="certificateDocumentList">
                                {if $product.productCertificate.length > 0}
                                    {foreach $product.productCertificate as $key => $val}
                                        <div class="image-item isNew" id="doc_{$key+1}" onload="pushInCertificate('{$val.certificate_name}')"><a class="old_certificates" href="{$config.url}/uploads/certificates/{$val.certificate_name}" target="_blank">{$val.certificate_name}</a> <a data-name="{$val.certificate_name}" href="javascript:void(0)" class="removeCertificate"><i class="fa fa-trash"></i></a></div>
                                    {/foreach}
                                {/if}
                            </div>
                            <p class="note-txt" style="margin-top: 10px;">
                                Please make sure your document is very clear. You must be able to read all letters and numbers clearly. Documents uploaded that are unclear may delay your listing going live. Customer identification must be redacted. All listings will be reviewed
                            </p>
                        </div>
                        <div class="col-sm-12 form-group suply2">
                            <!-- <div class="cus-check form-group">
                                <input type="checkbox" name="contaminant_screening" id="contaminant_screening" value="1" {if $product.contaminant_screening=='1'}checked{/if}>
                                <span class="checkmark"></span> Contaminant Screening
                            </div> -->
                            <div class="form-inline form-group">
                                <h5 class="">Contaminant Screening</h5>
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
                            
                            <!-- {if $product.id != '' && $product.id != '0'}
                                <div class="cs-wrap">
                                    <div class="form-inline form-group">
                                        <label>a. Heavy Metals Screening</label>
                                        <div class="radio">
                                            <input type="radio" name="hms" id="hms_passed" value="1" {if $product.contaminant_screening_data[0]=='1'}checked{/if}>
                                            <label for="hms_passed">Tested Passed</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="hms" id="hms_failed" value="2" {if $product.contaminant_screening_data[0]=='2'}checked{/if}>
                                            <label for="hms_failed">Tested Failed</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="hms" id="hms_na" value="3" {if $product.contaminant_screening_data[0]=='3'}checked{/if}>
                                            <label for="hms_na">N/A</label>
                                        </div>
                                    </div>
                                    <div class="form-inline form-group">
                                        <label>b. Microbiology & Mycotoxin Screening </label>
                                        <div class="radio">
                                            <input type="radio" name="micro_ms" id="micro_ms_passed" value="1" {if $product.contaminant_screening_data[1]=='1'}checked{/if}>
                                            <label for="micro_ms_passed">Tested Passed</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="micro_ms" id="micro_ms_failed" value="2" {if $product.contaminant_screening_data[1]=='2'}checked{/if}>
                                            <label for="micro_ms_failed">Tested Failed</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="micro_ms" id="micro_ms_na" value="3" {if $product.contaminant_screening_data[1]=='3'}checked{/if}>
                                            <label for="micro_ms_na">N/A</label>
                                        </div>
                                    </div>
                                    <div class="form-inline form-group">
                                        <label>c. Pesticide Residue Screening</label>
                                        <div class="radio">
                                            <input type="radio" name="prs" id="prs_passed" value="1" {if $product.contaminant_screening_data[2]=='1'}checked{/if}>
                                            <label for="prs_passed">Tested Passed</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="prs" id="prs_failed" value="2" {if $product.contaminant_screening_data[2]=='2'}checked{/if}>
                                            <label for="prs_failed">Tested Failed</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="prs" id="prs_na" value="3" {if $product.contaminant_screening_data[2]=='3'}checked{/if}>
                                            <label for="prs_na">N/A</label>
                                        </div>
                                    </div>
                                    <div class="form-inline form-group">
                                        <label>d. Solvent Residue Screening</label>
                                        <div class="radio">
                                            <input type="radio" name="srs" id="srs_passed" value="1" {if $product.contaminant_screening_data[3]=='1'}checked{/if}>
                                            <label for="srs_passed">Tested Passed</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="srs" id="srs_failed" value="2" {if $product.contaminant_screening_data[3]=='2'}checked{/if}>
                                            <label for="srs_failed">Tested Failed</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="srs" id="srs_na" value="3" {if $product.contaminant_screening_data[3]=='3'}checked{/if}>
                                            <label for="srs_na">N/A</label>
                                        </div>
                                    </div>
                                </div>
                            {else/}
                                <div class="cs-wrap">
                                    <div class="form-inline form-group">
                                        <label>a. Heavy Metals Screening</label>
                                        <div class="radio">
                                            <input type="radio" name="hms" id="hms_passed" value="1">
                                            <label for="hms_passed">Tested Passed</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="hms" id="hms_failed" value="2">
                                            <label for="hms_failed">Tested Failed</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="hms" id="hms_na" value="3" checked='checked'>
                                            <label for="hms_na">N/A</label>
                                        </div>
                                    </div>
                                    <div class="form-inline form-group">
                                        <label>b. Microbiology & Mycotoxin Screening </label>
                                        <div class="radio">
                                            <input type="radio" name="micro_ms" id="micro_ms_passed" value="1">
                                            <label for="micro_ms_passed">Tested Passed</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="micro_ms" id="micro_ms_failed" value="2">
                                            <label for="micro_ms_failed">Tested Failed</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="micro_ms" id="micro_ms_na" value="3" checked='checked'>
                                            <label for="micro_ms_na">N/A</label>
                                        </div>
                                    </div>
                                    <div class="form-inline form-group">
                                        <label>c. Pesticide Residue Screening</label>
                                        <div class="radio">
                                            <input type="radio" name="prs" id="prs_passed" value="1">
                                            <label for="prs_passed">Tested Passed</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="prs" id="prs_failed" value="2">
                                            <label for="prs_failed">Tested Failed</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="prs" id="prs_na" value="3" checked='checked'>
                                            <label for="prs_na">N/A</label>
                                        </div>
                                    </div>
                                    <div class="form-inline form-group">
                                        <label>d. Solvent Residue Screening</label>
                                        <div class="radio">
                                            <input type="radio" name="srs" id="srs_passed" value="1">
                                            <label for="srs_passed">Tested Passed</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="srs" id="srs_failed" value="2">
                                            <label for="srs_failed">Tested Failed</label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" name="srs" id="srs_na" value="3" checked='checked'>
                                            <label for="srs_na">N/A</label>
                                        </div>
                                    </div>
                                </div>
                            {/if} -->
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-4">
                            <button id="adminsub_button" type="submit" class="btn btn-success">Save</button>
                            <!-- <button id="admincertificate_button" type="button" class="btn btn-success updateProduct" data-id="1">Save</button> -->
                        </div>
                    </div>
                </div>
            <!-- </div> -->
            </form>

        </div>

        <div class="tab-pane fade" id="pills-payment" role="tabpanel" aria-labelledby="pills-payment-tab">
            <form enctype="multipart/form-data" class="admin_form" data-parsley-validate id="formstep_4" method="post" enctype="multipart/form-data" action="{$config.url}/{$loged.adminUrl}/users/save">
                <input type="hidden" name="product_id" id="product_id" value="{$product.id}">
                <input type="hidden" name="market_status" id="market_status" value="{$product.market_status}">

                <div class="col-sm-1"></div>
                <div class="col-sm-10">
                    <div class="row">
                        <div class="col-sm-12 form-group">
                            <label class="pp-label">SOPs – Standard Operating Procedures for Purchase
                                <p class="note-txt doc1">
                                    &nbsp;&nbsp;&nbsp;Describe your transaction standard operating procedures once your auction has been won; testing, quarantine, pick up options, shipping etc.
                                </p>
                                <!-- <p class="note-txt doc2">
                                    &nbsp;&nbsp;&nbsp;Describe your transaction standard operating procedures, once your auction has been won; sample opportunities, testing, quarantine, pick up options, shipping etc.
                                </p> -->
                            </label>
                            <textarea rows="4" class="form-control" placeholder="SOPs – Standard Operating Procedures for Purchase" name="sops" id="sops" required data-parsley-required-message="SOPs – Standard Operating Procedures for Puchase is required.">{$product.sops}</textarea>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 form-group">
                            <label class="pp-label ppl_tool_tip">
                                Transaction Method
                                <!-- <span class="reg-info"><img src="{$config.url}/images/info.png" alt=""></span>
                                <span class="reg_info_text">
                                    <p>Utilizing an escrow or attorney is required for all transactions with a value of over $15,000 for your safety</p>
                                </span> -->
                            </label>
                            <div class="clearfix col-6 p-0">
                                <div class="clearfix cselec-wrap-remove">
                                    <select class="custom-select" name="payment_method" id="payment_method" required data-parsley-required-message="Payment Method is required.">
                                        <option value="escrow" {if $product.payment_method=='escrow'}selected{/if}>Escrow</option>
                                        <option value="a_to_a" {if $product.payment_method=='a_to_a'}selected{/if}>Attorney to Attorney</option>
                                        <option value="wire" {if $product.payment_method=='wire'}selected{/if}>Wire (For Transactions <$15,000)</option>
                                        <option value="other" {if $product.payment_method=='other'}selected{/if}>Other</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 form-group" id="other_payment_method" style="{if $product.payment_method!='other'}display: none;{/if}">
                            <label class="pp-label">Other</label>
                            <textarea rows="4" class="form-control" placeholder="Description" name="payment_method_other" id="payment_method_other"  data-parsley-required-message="Description is required.">{$product.payment_method_other}</textarea>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-sm-4">
                            <button id="adminsub_button" type="submit" class="btn btn-success">Save</button>
                        </div>
                    </div>

                </div>
            </form>
        </div>
    </div>
    
</div>
{include file="/admincp/footer.tpl" nocache}
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>

<script src="{$config['externaljs']}scripts.js" type="text/javascript"></script>
<script>
    var product_id = '{$product.id}';
    certificates = [];
    productDocument = [];
    $(document).ready(function() {
        if(product_id > 0) {
            setTimeout(() => {
                $("#category_id").trigger('change');
                $('#amount_sold').val('{$product.amount_sold}');
                $('#moq').val('{$product.moq}');
            });

            if($('#fp-price_check').is(":checked")) {
                $("#formstep_1 #product_renew").append('<option value="9">9 times</option><option value="10">10 times</option><option value="11">11 times</option><option value="12">12 times</option>');
            }
            else if($('#auction_check').is(":checked")) {
                $("#formstep_1 #product_renew option[value='9']").remove();
                $("#formstep_1 #product_renew option[value='10']").remove();
                $("#formstep_1 #product_renew option[value='11']").remove();
                $("#formstep_1 #product_renew option[value='12']").remove();
            }
            $("#product_renew").val('{$product.renew}');
        }

        var logicStart = function (currentDateTime) {
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
            var buyNowChecks = $('#auction_check').is(":checked");
            var fixedPriceChecks = $('#fp-price_check').is(":checked");
            var setMaxEndDate = 89;
            if(buyNowChecks)
                setMaxEndDate = 9;

            if(fixedPriceChecks)
                setMaxEndDate = 29;

            var startDate = $('#start_date').val() ? new Date($('#start_date').val()) : new Date();
            if (currentDateTime && currentDateTime.getDate() == servertime.getDate()) {
                this.setOptions({
                    minTime: addZero(servertime.getHours()) + ':' + addZero(servertime.getMinutes()),
                    minDate:$('#start_date').val()? new Date($('#start_date').val()):false,
                    //maxDate : new Date(startDate.getTime() +  (89 * 24 * 60 * 60 * 1000))
                    maxDate : new Date(startDate.getTime() +  (setMaxEndDate * 24 * 60 * 60 * 1000))
                });
            } else {
                this.setOptions({
                    minTime: '00:00',
                    minDate:$('#start_date').val()? new Date($('#start_date').val()):false,
                    //maxDate : new Date(startDate.getTime() +  (89 * 24 * 60 * 60 * 1000))
                    maxDate : new Date(startDate.getTime() +  (setMaxEndDate * 24 * 60 * 60 * 1000))
                });
            }
        };
        $('#start_date').datetimepicker({
            format:'m-d-Y H:i',
            step: 5,
            onChangeDateTime:logicStart,
            onShow:logicStart,
            minDate:new Date()
        });

        $('#end_date').datetimepicker({
            format:'m-d-Y H:i',
            step: 5,
            onChangeDateTime:logicEnd,
            onShow:logicEnd,
            maxDate: new Date()
        });
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

                $('#end_date').val('').trigger('change');

                $("#product_renew option[value='9']").remove();
                $("#product_renew option[value='10']").remove();
                $("#product_renew option[value='11']").remove();
                $("#product_renew option[value='12']").remove();

                //$('#product_renew').val('8');
            } else if(divId == 'buy-now') {
                $('#fp-price').removeClass('active');
                $("#"+divId).toggleClass('active');
                //$('#buy-now').find('input').not('.qty').val('');
                
                //$('#product_renew').val('8');
            } else if(divId == 'fp-price') {
                $(this).prop('checked', 'checked');

                $('#auction').removeClass('active');
                $('#buy-now').removeClass('active');
                $('#ofr-price').removeClass('active');
                $("#"+divId).addClass('active');

                //$('#auction').find('input').not('.qty').val('');
                //$('#buy-now').find('input').not('.qty').val('');

                $('#auction_check').prop('checked', false);
                $('#buy-now_check').prop('checked', false);
                $('#buy-now_check').attr('disabled', 'disabled');
                $('#ofr-price_check').prop('checked', false);
                
                $('.auction').css("display", "none");
                $('.fixedprice').css("display", "block");

                $('#end_date').val('').trigger('change');

                $("#product_renew option[value='9']").remove();
                $("#product_renew option[value='10']").remove();
                $("#product_renew option[value='11']").remove();
                $("#product_renew option[value='12']").remove();
                $("#product_renew").append('<option value="9">9 times</option><option value="10">10 times</option><option value="11">11 times</option><option value="12">12 times</option>');

                //$('#product_renew').val('12');
            } else if(divId == 'ofr-price') {
                $(this).prop('checked', 'checked');

                $('#auction').removeClass('active');
                $('#buy-now').removeClass('active');
                $('#fp-price').removeClass('active');
                $("#"+divId).addClass('active');

                //$('#auction').find('input').not('.qty').val('');
                //$('#buy-now').find('input').not('.qty').val('');

                $('#auction_check').prop('checked', false);
                $('#buy-now_check').prop('checked', false);
                $('#buy-now_check').attr('disabled', 'disabled');
                $('#fp-price_check').prop('checked', false);
                
                $('.auction').css("display", "none");
                $('.fixedprice').css("display", "block");

                $('#end_date').val('').trigger('change');

                $("#product_renew option[value='9']").remove();
                $("#product_renew option[value='10']").remove();
                $("#product_renew option[value='11']").remove();
                $("#product_renew option[value='12']").remove();
                $("#product_renew").append('<option value="9">9 times</option><option value="10">10 times</option><option value="11">11 times</option><option value="12">12 times</option>');

                //$('#product_renew').val('12');
                $('#product_renew').val('0');
            }
        });

        $(document).on('change', '#category_id', function () {
            var category_id = $('#category_id').val();
            console.log(' CATEGORY ID ' + category_id);
            if(category_id == 15){
                $('#unit_of_measurement').prop('required',false);
                //$('#unit_of_measurement').val('Grams');
                $('#amount_sold').prop('required',false);
                $('#amount_sold').val('0');
                $('#moq').prop('required',false);
                $('#moq').val('0');
                $('#formstep_1').parsley().reset();
                $('.suply').hide();
                //$('.suply2').css('display', 'block');
                $('.suply2').css('display', 'none');
                $('.doc2').css('display', 'none');
            }else{
                $('#unit_of_measurement').prop('required',true);
                //$('#unit_of_measurement').val('Grams');
                $('#amount_sold').prop('required',true);
                $('#amount_sold').val('');
                $('#moq').prop('required',true);
                $('#moq').val('');
                //$('.suply').show();
                $('.suply').hide();
                $('.suply2').css('display', 'block');
                //$('.doc2').css('display', 'block');
                $('.doc2').css('display', 'none');
            }

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
                    /* if(storedData) {
                        var index = storedData.findIndex(function(item) {
                            return item.id == "subcategory_id";
                        });
                        if(index > -1 && storedData[index]) {
                            $('#subcategory_id').val(storedData[index].value);
                        }
                    } */
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

        $(document).on('change', '#payment_method', function () {
            if($(this).val() == 'other') {
                $("#other_payment_method").slideDown();
            } else {
                $("#other_payment_method").slideUp();
            }
        });

        // Append New Video URL - Starts
        $("#append").click( function(e) {
            e.preventDefault();
            $("#appendVideoUrl").append('<div class="row" style="margin-top: 10px;"><div class="col-sm-12">\
                <button class="btn btn-danger col-3 remove_this" type="button" style="width: 25%; float: right;">Remove</button>\
                <input class="form-control col-9 embed_video" placeholder="Embed Video / YouTube Video Link" name="embed_video[]" id="embed_video" style="width: 75%;" />\
            </div></div>');
            return false;
        });

        $('body').on('click', '.remove_this', function() {
            $(this).closest('div').remove();
            return false;
        });
        // Append New Video URL - Ends

        /* Start remove product document */
        $(document).on('click', '.removeProductDocument', function () {
            var id = $(this).closest('.image-item').attr('id').split("_")[1];
            $("#proddoc_"+id).remove();
            var name = $(this).attr('data-name');
            var document_id = 0;
            if(!$(this).closest('.image-item').hasClass('isNew')) {
                document_id = id;
            }
            var index = productDocument.findIndex(function(item) { return item.name == name; });
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
            }
        });
        /* End remove product document */

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

        $(".old_certificates").each( function(index) {
            var name = $(this).html();
            certificates.push({
                fieldname: "certificates",
                originalname: name,
                name: name
            });
        });
        
        $(document).on("submit", ".admin_form", function(e) {
            var step = $(this).attr("id").split("_")[1];
            console.log('$(this).parsley().validate()', $(this).parsley().validate());
            if ($(this).parsley().validate()) {
                var formArr = $(this).serializeArray();
                console.log('formArr', formArr);
                var productObj = {};
                if (formArr.length) {
                    for (var index = 0; index < formArr.length; index++) {
                        const element = formArr[index];
                        productObj[formArr[index].name] = formArr[index].value;
                    }
                }
                console.log('productObj', productObj);

                var method = 'saveProductInfo';
                if(step == 1) {
                    productObj['productDocument'] = productDocument;
                    productObj['videoUrl'] = [];
                    if($('.embed_video').length > 0) {
                        $('.embed_video').each(function(i, v) {
                            if($(this).val() && $(this).val() != "" && $(this).val() != null && $(this).val() != 'undefined')
                                productObj['videoUrl'].push($(this).val());
                        });
                    }
                    method = 'saveProductInfo';
                } else if(step == 2) {
                    method = 'saveManufactureInfo';
                } else if(step == 3) {
                    productObj['certificatesDocument'] = certificates;
                    method = 'saveCertificateInfo';
                } else if(step == 4) {
                    method = 'savePaymentInfo';
                }
                e.preventDefault();
                $.ajax({
                    method: "POST",
                    url: '/admincp/'+method,
                    data: productObj,
                    dataType: 'JSON',
                    cache: false,
                    success: function (data) {
                        console.log('data', data);
                        if (data.status == 200) {
                            // document.getElementById('userDetailForm').reset();
                            swal('Updated successfully.');
                        }
                    }
                });
            }
        });

    });
    
    /* Start Product Document of Analysis */
    function editProductFileupload(obj)
    {
        var files = $('input[name="productDocument"]')[0].files;
        var formData = new FormData();
        var fileSizeCount = 0;
        for (let index = 0; index < files.length; index++) {
            if(files[index].size < 5242880) {
                const element = files[index];
                formData.append('product_image', element);
            } else
                fileSizeCount++;
        }
        $("#productDocumentLoader").show();
        var cntfle = $('input[name="productDocument"]')[0].files.length;
        if(fileSizeCount > 0) {
            alert('Max file size found from your selection. Please select minimum 5MB files.');
        } else {
            $.ajax({
                url : '/product/postProductDocument/'+cntfle,
                type : 'POST',
                xhr: function() {
                    var myXhr = $.ajaxSettings.xhr();
                    return myXhr;
                },
                data : formData,
                processData: false,
                contentType: false,
                success : function(response) {
                    if(response.productDocument.length) {
                        createProductDHtml(response.productDocument);
                        $('#pError').hide();
                    }
                    //console.log('response', response.productDocument);
                    // $("#loading_images").hide();
                    $('input[name="productDocument"]').val('');
                },
                error: function(e)
                {
                    //console.log(e);
                    $('input[name="productDocument"]').val('');
                },
            }).done(function() {
                $("#productDocumentLoader").hide();
            });
        }
    }
    /* End Product Document of Analysis */
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
                // $("#loading_images").hide();
            },
            error: function(e)
            {
                console.log(e);
            },
        }).done(function() {
            $("#certificateDocumentLoader").hide();
        });
    }
    /* End Upload Certificate of Analysis */

    function createProductDHtml(cer) {
        if(cer.length > 0)
                $('#pError').hide();

        for (let index = 0; index < cer.length; index++) {
            const element = cer[index];
            var isImage = element.mimetype.split('/')[0];
            element.fileType = isImage;
            productDocument.push(element);
            console.log('productDocument', productDocument);
            var total = $("#productDocumentList").find('.image-item').length;
            var link = base_url+'/uploads/product/'+element.name;
            var html = '';
            if(element.extension.toString().toLowerCase() == 'jpeg' || element.extension.toString().toLowerCase() == 'jpg' || element.extension.toString().toLowerCase() == 'png'){
                html = '<div class="image-item isNew" id="proddoc_'+(total+1)+'"><img src="'+link+'" alt="pImg" style="margin:0px;width:100px; height:80px"> <a data-name="'+element.name+'" href="javascript:void(0)" class="removeProductDocument">Remove</a></div>';
            } else {
                html = '<div class="image-item isNew" id="proddoc_'+(total+1)+'">  <video src="'+link+'" alt="pImg" style="margin:0px;width:100px; height:80px"></video>  <a data-name="'+element.name+'" href="javascript:void(0)" class="removeProductDocument">Remove</a></div>';
            }
            $("#productDocumentList").append(html);
        }
    }
    function createCertificateHtml(cer) {
        for (let index = 0; index < cer.length; index++) {
            const element = cer[index];
            var isImage = element.mimetype.split('/')[0];
            if(isImage == 'application') {
                isImage = 'pdf';
            }
            element.fileType = isImage;
            certificates.push(element);
            $('#cError').hide();
            var total = $("#certificateDocumentList").find('.image-item').length;

            var link = base_url+'/uploads/certificates/'+element.name;
            var html = '<div class="image-item isNew" id="doc_'+(total+1)+'"><a href="'+link+'" target="_blank">'+element.originalname+'</a> <a data-name="'+element.name+'" href="javascript:void(0)" class="removeCertificate"><i class="fa fa-trash"></i></a></div>';
            $("#certificateDocumentList").append(html);
        }
    }

    function pushInDocument(item) {
        productDocument.push({
            fieldname: "product_image",
            originalname: item,
            name: item
        });
    }

    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;
    }

    $(document).on('click', '.updateProduct', function() {
            var id = $(this).attr('data-id');
            if ($('#formstep_'+id).parsley().validate()) {
                var formArr = $(this).serializeArray();
                console.log('formArr', formArr);
                var productObj = {};
                if (formArr.length) {
                    for (var index = 0; index < formArr.length; index++) {
                        const element = formArr[index];
                        productObj[formArr[index].name] = formArr[index].value;
                    }
                }
                console.log('productObj', productObj);

                var method = 'saveProductInfo';
                if(id == 1) {
                    productObj['productDocument'] = productDocument;
                    productObj['videoUrl'] = [];
                    if($('.embed_video').length > 0) {
                        $('.embed_video').each(function(i, v) {
                            if($(this).val() && $(this).val() != "" && $(this).val() != null && $(this).val() != 'undefined')
                                productObj['videoUrl'].push($(this).val());
                        });
                    }
                    method = 'saveProductInfo';
                } else if(id == 2) {
                    method = 'saveManufactureInfo';
                } else if(id == 3) {
                    productObj['certificatesDocument'] = certificates;
                    method = 'saveCertificateInfo';
                } else if(id == 4) {
                    method = 'savePaymentInfo';
                }
                $.ajax({
                    method: "POST",
                    url: '/admincp/'+method,
                    data: productObj,
                    dataType: 'JSON',
                    cache: false,
                    success: function (data) {
                        console.log('data', data);
                        if (data.status == 200) {
                            // document.getElementById('userDetailForm').reset();
                            swal('Updated successfully.');
                        }
                    }
                });
            }
        });

</script>
