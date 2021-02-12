{include file="/common/header-1.tpl" nocache}
<!-- <link rel="stylesheet" href="{$config['externalcss']}jquery.datetimepicker.css" type="text/css" /> -->
<!-- <style type="text/css">
  select {
            color: #aaa; /* default unselected color */
    }

    select:focus {
            color: red; /* color when focused */
    }

    select option:checked{
            color: red; /* color when selected but not focused */
    }
</style> -->
<!-- page content  -->
<style>
#filec22, #filec2, #filec55, #filec5 {
    width: 150px;
    height: 150px;
    float: left;
}
#filec22:not(:last-child), #filec2:not(:last-child), #filec55:not(:last-child), #filec5:not(:last-child) {
    margin-right: 10px;
}
.store-fluid .pro-thumb {
    display: flex;
    width: auto !important;
    overflow: auto;
    padding-bottom: 0px !important;
    height: auto;
}
.pt-0 {
    padding-top: 0px !important;
}
</style>
{include file="common/dashboard-navigation.tpl" nocache}

<div class="container-fluid store-fluid post-item-fluid grey-bg p0">
    <div class="row  m50"><div class="col-md-12 flex">

        <!-- ================loader===================== -->
        <div id="loader-new" class="margin-auto">
            <img src="{$config.url}/images/ripplez.gif" class="img-responsive" alt="ripplez.gif">
        </div>

        <div  id="loadData" class="col-lg-6 col-md-8 margin-auto white-bg-2 p35 shadow">
            {if $updation_status}
            <div class="alert alert-success">
                <strong>Success!</strong> &nbsp;&nbsp;"<span style="text-transform: capitalize;">{$projects.title}</span> updated successfully!"
            </div>
            {/if}

            <div class="row">
                <div class="col-md-12">
                    <ul class="nav nav-pills nav-justified m20 frxs-wd">
                        <li {if $projects.trading_type != 'sell'} class="active" {/if} ><a data-toggle="pill" href="#buy">I Want to Buy </a></li>
                        {if $loged.business_type != "dispensary"}<li {if $projects.trading_type == 'sell'} class="active" {/if} ><a data-toggle="pill" href="#sell">I Want to Sell</a></li>{/if}
                    </ul>
                    <div class="tab-content">
                        <div id="buy" class="tab-pane fade {if $projects.trading_type != 'sell'}active in{/if}">
                            {if !$projects.id}
                            <form method="POST" att-selected-cat='{$selected_cats}' enctype="multipart/form-data" class="form-horizontal add-product-buy" data-parsley-validate name="add-product" id="add-product" action="{$config.url}/product/openbid/save">
                            {/if}
                            {if $projects.id}
                            <form method="POST" att-selected-cat='{$selected_cats}' enctype="multipart/form-data" class="form-horizontal add-product-buy" data-parsley-validate name="add-product" id="add-product" action="{$config.url}/dashboard/openbid/product/save">
                            {/if}

                                    <input type="hidden" name="currency_type" id="currency_type" value="{$currencytype}">
                                    <input type="hidden" name="id" id="product_id" value="{$projects.id}">
                                    <input type="hidden" id="trading_type" name="trading_type" value="buy">
                                    <input type="hidden" name="cannabis_type" value="n">
                                    <input type="hidden" name="stax" value="0">
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            Product Name
                                            <!-- <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="project_title" placeholder="Product Name" name="title" value="{$projects.title}" data-parsley-required data-parsley-required-message="Please enter the Product title">
                                            -->
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="project_title" placeholder="Product Name" name="title" value="{$projects.title}" data-parsley-trigger="change" data-parsley-required data-parsley-required-message="Please enter the product title" {if $projects.id>0}readonly{/if}>
                                            <!-- data-parsley-pattern="^[A-Za-z0-9 ]*$" pattern="^[A-Za-z0-9 ]*$" data-parsley-pattern-message="Invalid project title"  -->
                                        </div>
                                       <!--  <div class="col-sm-6">
                                            METRC ID -->
                                            <input class="w100 p15 pb15 grey-bg border-0" type="hidden" class="form-control" id="metrc_id" name="metrc_id" value="">
                                        <!-- </div> -->
                                        <div class="col-sm-6">
                                            Target Price / Unit
                                            <!-- <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="target_price" data-parsley-type="number" data-parsley-type-message="please enter the target price" data-parsley-required data-parsley-required-message="Please enter the target price" placeholder="Target Price" name="target_price"> -->
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="target_price" data-parsley-type="number" data-parsley-type-message="please enter the target price" min="1" data-parsley-required data-parsley-required-message="Please enter the target price" placeholder="Target Price / Unit" name="target_price" value="{$projects.sprice}" data-parsley-trigger="change">
                                        </div>
                                        <!-- <div class="col-sm-4">
                                            Brand SKU
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="pkey" placeholder="Brand SKU" name="pkey"  value="{$projects.pkey}" {if $projects.id>0}readonly{/if}>
                                          {if $loged.business_type != "dispensary"} data-parsley-required data-parsley-required-message="Please enter the Brand SKU" {/if} 
                                          </div> -->
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-12 text-center">
                                                <span class="description"><i class="">How much product would you like to request?</i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <!-- ===================== start change by divyesh (changes) ===================== -->
                                        <div class="col-sm-{if $loged.business_type == "supplier"}4{else\}6{/if}">
                                             Quantity Requested
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="qty" placeholder="Quantity Requested" name="qty" data-parsley-required-message="Please add quantity" data-parsley-required data-parsley-min="1" data-parsley-min-message="Please enter quantity 1 or more" data-parsley-type="number" data-parsley-type-message="please enter the quantity number" value="{$projects.qty}" data-parsley-trigger="change" {if $projects.id>0}readonly{/if}>
                                        </div>
                                        {if $loged.business_type == "supplier"}
                                            {if $loged.is_consultant_fee=='y'}
                                            <div class="col-sm-4">
                                                Sales Consultant Fee(%)
                                                <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="consultant_fee" placeholder="Sales Consultant Fee(%)" name="consultant_fee" data-parsley-required-message="Please Enter sales tax" data-parsley-required data-parsley-min="0" data-parsley-trigger="change" data-parsley-min-message="Please enter sales tax percentage 1 or more" data-parsley-type="number" data-parsley-type-message="please enter sales tax %"
                                                {if $loged.is_consultant_fee=='y' && !$projects.consultant_fee}
                                                value="{$loged.consultant_fee}"
                                                {/if}
                                                {if $projects.consultant_fee}
                                                value="{$projects.consultant_fee}"
                                                {/if}
                                                {if $projects.id>0}readonly{/if}
                                                >
                                            </div>
                                            {else}
                                            <div class="col-sm-4">
                                                Sales Consultant Fee(%)
                                                <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="consultant_fee" placeholder="Sales Consultant Fee(%)" name="consultant_fee" data-parsley-required-message="Please Enter sales tax" data-parsley-min-message="Please enter sales tax percentage 1 or more" data-parsley-type="number" data-parsley-trigger="change" data-parsley-type-message="please enter sales tax %" 
                                                value="0" disabled
                                                >
                                            </div>
                                            {/if}
                                        {/if}
                                        <div class="col-sm-{if $loged.business_type == "supplier"}4{else\}6{/if}">
                                            Units of Measure
                                            <select class="w100 p15 pb15 grey-bg border-0" id="units" name="units" data-parsley-required data-parsley-required-message="Please select units" data-parsley-trigger="change" {if $projects.id>0}disabled{/if}>
                                                <option value="" selected>Units of Measure</option>
                                                <option value="ounces" {if $projects.units=='ounces'} selected {/if}>Ounces</option>
                                                <option value="pounds" {if $projects.units=='pounds'} selected {/if}>Pounds</option>
                                                <option value="grams" {if $projects.units=='grams'} selected {/if}>Grams</option>
                                                <option value="units" {if $projects.units=='units'} selected {/if}>Units</option>
                                            </select>
                                            {if $projects.id>0}<input type="hidden" name="units" value="{$projects.units}">{/if}
                                        </div>
                                        <!-- ===================== end change by divyesh (changes) ===================== -->
                                    </div>
                                    <div class="form-group">
                                          <div class="col-sm-6">
                                              Category
                                              <select class="w100 p15 pb15 grey-bg border-0" id="loadcategory" name="category" onchange="loadSubcategory(this)" data-parsley-required data-parsley-required-message="Please select category" data-parsley-trigger="change" {if $projects.id>0}disabled{/if}>
                                                  <option class="black" value="">Select Category</option>
                                                  {foreach $category as $key => $val}
                                                      {if $val.parent_id == 0 && $val.ob_market==1}
                                                          <option class="" value="{$val.id}"
                                                          {if $projects.parent_category_id == $val.id} selected {/if} >{$val.name}
                                                          </option>
                                                      {/if}
                                                  {/foreach}
                                              </select>
                                              {if $projects.id>0}<input type="hidden" name="category" value="{$projects.parent_category_id}">{/if}
                                          </div>
                                          <div class="col-sm-6">
                                              Sub Category
                                              <select class="w100 p15 pb15 grey-bg border-0" id="subcategories" min="1" name="subcategory" data-parsley-required data-parsley-required-message="Please select subcategory" data-parsley-min-message="Please select subcategory" data-parsley-trigger="change" {if $projects.id>0}disabled{/if}>
                                                 <option id="subcat" value="">Sub Category</option>
                                            <!--  {foreach $category as $key => $val}
                                                  {if $val.parent_id != 0  && $val.ob_market==1}
                                                  <option value="{$val.id}" pid="{$val.parent_id}" {if $projects.category_id == $val.id} selected {/if} >
                                                      {$val.name}</option>
                                                  {/if}
                                                  {/foreach} -->
                                              </select>
                                              {if $projects.id>0}<input type="hidden" name="subcategory" value="{$projects.subcategory}">{/if}
                                          </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            Date Requested
                                            <div class="inner-addon right-addon">
                                                <i class="glyphicon glyphicon-calendar"></i>
                                                <input class="w100 p15 pb15 grey-bg border-0" data-parsley-trigger="change" type="text" id="start_date1" placeholder="Date Requested" readonly="readonly" name="start_date" data-parsley-required data-parsley-required-message="Please select date" value="{$projects.date_add}" {if $projects.id>0}readonly{/if}>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                              Order Type
                                            <select class="w100 p15 pb15 grey-bg border-0" name="order_type" data-parsley-required data-parsley-required-message="please select order type" data-parsley-trigger="change" {if $projects.id>0}disabled{/if}>
                                                <option value="">Order Type</option>
                                                <option value="total" {if $projects.order_type == 'total'} selected {/if} >Total Orders Only</option>
                                                <option value="partial" {if $projects.order_type == 'partial'} selected {/if} >Partial Orders Allowed</option>
                                            </select>
                                            {if $projects.id>0}<input type="hidden" name="order_type" value="{$projects.order_type}">{/if}
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            Product Notes
                                            <textarea class="grey-bg w100 border-0 p15 pb15" placeholder="Please include desired products features, or specific needs you wants sellers to know (i.e desired cannabinoid profile, specific brand names, packaging needs). Or if you have no preferences insert the word None." name="description" data-parsley-required data-parsley-required-message="If you have no preferences please place the word 'None' in this box" rows="5" cols="80" data-parsley-trigger="change">{$projects.description}</textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <div class="text-center">
                                                <div>Example Image</div>
                                                <div class="pro-thumb grey-bg flex margin-auto">
                                                    {if $projects.avatar != ''}
                                                    <img id="filec2" src="{$config.imgpath}product/{$projects.avatar}" class="img-responsive margin-auto" alt="" accept="image/*">
                                                    {/if}
                                                    {if $projects.avatar == ''}
                                                    <img id="filec2" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="" accept="image/*">
                                                    {/if}
                                                    {foreach $image as $ikey => $ival}
                                                    {if $ikey!=0}
                                                        <img id="filec22" src="{$config.imgpath}/product/{$ival.avatar}" class="new_images img-responsive margin-auto" alt="" accept="image/*">
                                                    {/if}
                                                    {/foreach}
                                                </div>
                                            </div>
                                            <div class="flex">
                                                <div class="margin-auto">
                                                    <span class="f12 m5"><i>Upload Example Image of Requested Item (*.jpeg, *.jpg, *.png etc.) </i></span>
                                                    <input type="file" id="filecount2" data-parsley-trigger="change" name="product_image" multiple="multiple" {if !$projects.id} data-parsley-required data-parsley-required-message="Please upload an example image." {/if} accept="image/*" data-parsley-errors-container="#product_image-err" >
                                                    <!--                                                 <input type="file" id="filecount2" name="product_image" multiple="multiple"> -->
                                                </div>
                                            </div><span id="product_image-err" class="err-message"></span>
                                        </div>
                                    </div>
                                    <div class="row flex">
                                        <div class="col-sm-12 margin-auto pull-right">
                                            <button class="btn btn-default btn-d-b green-b pull-right btn-submit-buy centering" onclick="checkProductDetailsBuy()" type="submit">{if !$projects.id} POST {/if} {if $projects.id} Update {/if} </button>
                                        </div>
                                    </div>
                                </form>
                        </div>
                        <!-- Buy Close -->
                        <div id="sell" class="tab-pane fade {if $projects.trading_type == 'sell'}active in{/if}">
                            <!-- <form class="form-horizontal" action="/action_page.php"> -->
                            <!-- <form method="POST" enctype="multipart/form-data" class="form-horizontal" data-parsley-validate name="add-obproduct" id="add-obproduct" action="{$config.url}/product/openbid/save"> -->
                            {if !$projects.id}
                            <form method="POST" att-selected-cat='{$selected_cats}' enctype="multipart/form-data" class="form-horizontal  add-product-sell" data-parsley-validate name="add-product" id="add-product" action="{$config.url}/product/openbid/save">
                                {/if}
                                 {if $projects.id}
                                <form method="POST" att-selected-cat='{$selected_cats}' enctype="multipart/form-data" class="form-horizontal add-product-sell" data-parsley-validate name="add-product" id="add-product" action="{$config.url}/dashboard/openbid/product/save">
                                    {/if}
                                    <input type="hidden" id="sell_product" name="trading_type" value="sell">
                                    <input type="hidden" name="currency_type" id="currency_type" value="{$currencytype}">
                                    <input type="hidden" name="id" id="currency_type" value="{$projects.id}">
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            Product Name
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="project_title" placeholder="Product Name" name="title" value="{$projects.title}" data-parsley-required data-parsley-required-message="Please enter the product title" data-parsley-trigger="change" {if $projects.id>0}readonly{/if}>
                                            <!-- data-parsley-pattern="^[A-Za-z0-9 ]*$" pattern="^[A-Za-z0-9 ]*$" data-parsley-pattern-message="Invalid project title"  -->
                                        </div>
                                        <div class="col-sm-6">
                                            METRC ID
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="metrc_id" data-parsley-type-message="please enter the metrc id" data-parsley-required-message="Please enter the metrc id" placeholder="METRC-ID" name="metrc_id" value="{$projects.metrc_id}" data-parsley-trigger="change"  {if $projects.id>0}readonly{/if}>
                                            <!-- data-parsley-pattern="^[A-Za-z1-9]*$" pattern="^[A-Za-z0-9]*$" data-parsley-pattern-message="METRC-ID should be alphanumeric only"  -->
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            Target Price / Unit
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="target_price" data-parsley-type="number" data-parsley-type-message="please enter the target price" data-parsley-required data-parsley-required-message="Please enter the target price" min="1" placeholder="Target Price / Unit" name="target_price" value="{$projects.sprice}" data-parsley-trigger="change">
                                        </div>
                                        <div class="col-sm-6">
                                            Brand SKU
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="pkey" data-parsley-required data-parsley-required-message="Please enter the Brand SKU" placeholder="Brand SKU" name="pkey" value="{$projects.pkey}" data-parsley-trigger="change" {if $projects.id>0}readonly{/if}>
                                        </div>
                                    </div>
                                    <!-- <div class="form-group">
                                      <div class="col-sm-6">
                                        <span class="description"><i>Is the products price negotiable?</i></span>
                                      </div>
                                      <div class="col-sm-6">
                                          <div class="radio-con">
                                              <div class="radio2">
                                                  <input id="radio-1" name="radio" type="radio" checked>
                                                  <label for="radio-1" class="radio-label">Yes</label>
                                                </div>

                                                <div class="radio2">
                                                  <input id="radio-2" name="radio" type="radio">
                                                  <label  for="radio-2" class="radio-label">No</label>
                                               </div>
                                          </div>
                                      </div>
                                    </div> -->
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            <span class="description"><i>Is the product cannabis or cannabis-infused? </i></span>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="radio-con">
                                                <div class="radio2">
                                                    <input id="radio-5" name="cannabis_type" type="radio" value="y" {if $projects.cannabis_type == 'y'} checked {/if}>
                                                    <label for="{if $projects.id<1}radio-5{/if}" class="radio-label">Yes</label>
                                                </div>
                                                <div class="radio2">
                                                    <input id="radio-6" name="cannabis_type" type="radio" value="n" {if $projects.cannabis_type != 'y'} checked {/if}>
                                                    <label for="{if $projects.id<1}radio-6{/if}" class="radio-label">No</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12 testresult">
                                            Select the type of Test Result you are uploading above the menu
                                            <select class="w100 p15 pb15 grey-bg border-0" id="test_result_types" name="test_result_types" data-parsley-required-message="Please select units" data-parsley-trigger="change" {if $projects.id>0}disabled{/if}>
                                                <option value="" selected>Select Test Result Type</option>
                                                <option value="analysis_certificate" {if $projects.test_result_types=='analysis_certificate'} selected {/if}>Certificate of Analysis</option>
                                                <option value="interim_testing" {if $projects.test_result_types=='interim_testing'} selected {/if}>Interim Testing</option>
                                                <option value="none" {if $projects.test_result_types=='none'} selected {/if}>No Test Results</option>
                                            </select>
                                            {if $projects.id>0}<input type="hidden" name="test_result_types" value="{$projects.test_result_types}">{/if}
                                            <br/>
                                        </div>
                                        <div class="testresult">
                                            <div class="col-sm-12 test-result">
                                                <div class="pro-thumb grey-bg flex w100">
                                                {if $projects.cannabis_type == 'y'}
                                                <!-- certs_analysis_length -->
                                                    {if $testresults_length > 0}
                                                        <img id="filec4" src="{$config.imgpath}testresult/{$testresults.avatar}" class="img-responsive margin-auto" alt="{$testresults.image}" >
                                                    {/if}
                                                {/if}
                                                {if $projects.cannabis_type == 'n'}
                                                    <img id="filec4" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="" >
                                                {/if}
                                                {if !$projects.cannabis_type}
                                                    <img id="filec4" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="" >
                                                {/if}
                                                </div>
                                                <div class="margin-auto" style="margin-right:0px;">
                                                    <span class="f12 m5"><i>Upload Test Result (*.jpeg, *.jpg, *.png etc.)</i></span>
                                                    <!-- <input type="file" id="filecount4" data-parsley-trigger="change" name="test_results"
                                                    {if !$projects.id} data-parsley-required data-parsley-required-message="Please upload test results" {/if} {if $projects.id && ($projects.cannabis_type == 'n')}  data-parsley-required data-parsley-required-message="Please upload test results" {/if} multiple="multiple" data-parsley-errors-container="#password-register-err" accept="image/*"/> -->
                                                    <input type="file" id="filecount4" data-parsley-trigger="change" name="test_results" multiple="multiple" data-parsley-required data-parsley-errors-container="#password-register-err" accept="image/*"/>
                                                </div>
                                                <span id="password-register-err" class="err-message"></span>
                                            </div>
                                        </div>
                                         <div class="col-md-12 testresult2">
                                            <br>
                                            <div class="form-inline text-left">
                                                <label class="lab-clr">Do you need any testing services?</label>
                                                  <div class="radio radio-inline radio-primary pt-0">
                                                    <input data-parsley-trigger="change focudsout" type="radio" name="interim_testing_status" id="interim_testing_status1" value="y"  tabindex="8" data-parsley-required {if $projects.interim_testing_status=='y'} checked="true" {/if}>
                                                    <label for="{if $projects.id<1}interim_testing_status1{/if}"> Yes </label>
                                                    <input data-parsley-trigger="change focusout" type="radio" name="interim_testing_status" id="interim_testing_status2" value="n" tabindex="9" data-parsley-required {if $projects.interim_testing_status=='n'} checked="true" {/if}>
                                                    <label for="{if $projects.id<1}interim_testing_status2{/if}"> No </label>
                                                  </div>
                                            </div>
                                        </div>
                                        <div class="form-group {if !$projects.interim_testing_status} hide {/if}{if $projects.interim_testing_status=='n'} hide {/if}" id="interim_testing_status_desc">
                                            <div class="col-sm-6 form-inline text-left">
                                                <label class="lab-clr"></label>
                                                  <input type="text" class="w100 p15 pb15 grey-bg border-0" name="interim_testing_status_msg" value="{$projects.interim_testing_status_msg}" placeholder="Please enter the testing services you need and a Herbee Administrator will contact you shortly." {if $projects.id>0}readonly{/if}>
                                            </div>
                                            <div class="col-sm-6 form-inline text-left">
                                                <label class="lab-clr"></label>
                                                <select class="w100 p15 pb15 grey-bg border-0" name="distributor_id" id="distributor_id"  data-parsley-trigger="change" {if $projects.id>0}disabled{/if}>
                                                    <option class="black" value="">Select Distributor</option>
                                                    {foreach $distributors as $key => $val}
                                                        <option class="" value="{$val.id}"
                                                        {if $projects.distributor_id == $val.id} selected {/if} >{$val.first_name} {$val.last_name}
                                                        </option>
                                                    {/foreach}
                                                </select>
                                                <!-- data-parsley-required data-parsley-required-message="Please select Distributor" -->
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-12 text-center">
                                                <span class="description"><i class="">How much product do you have to offer?</i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- ===================== start change by divyesh (changes) ===================== -->
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                             Available Quantity
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="qty" placeholder="Available Quantity" name="qty" data-parsley-required-message="Please add quantity" data-parsley-required data-parsley-min="1" data-parsley-min-message="Please enter quantity 1 or more" data-parsley-type="number" data-parsley-type-message="please enter the quantity number" value="{$projects.qty}" data-parsley-trigger="change" {if $projects.id>0}readonly{/if}>
                                        </div>

                                        <div class="col-sm-6">
                                               Units of Measure
                                            <select class="w100 p15 pb15 grey-bg border-0" id="units" name="units" data-parsley-required data-parsley-required-message="Please select units" data-parsley-trigger="change" {if $projects.id>0}disabled{/if}>
                                                <option value="" selected>Units of Measure</option>
                                                <option value="ounces" {if $projects.units=='ounces'} selected {/if}>Ounces</option>
                                                <option value="pounds" {if $projects.units=='pounds'} selected {/if}>Pounds</option>
                                                <option value="grams" {if $projects.units=='grams'} selected {/if}>Grams</option>
                                                <option value="units" {if $projects.units=='units'} selected {/if}>Units</option>
                                            </select>
                                            {if $projects.id>0}<input type="hidden" name="units" value="{$projects.units}">{/if}
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        {if $loged.stax=='y'}
                                        <div class="col-sm-6">
                                               Local Sales Tax
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="stax" placeholder="Local Sales Tax(%)" name="stax" data-parsley-required-message="Please Enter Local Sales Tax" data-parsley-required data-parsley-min="1" data-parsley-trigger="change" data-parsley-min-message="Please enter local sales tax percentage 1 or more" data-parsley-type="number" data-parsley-type-message="please enter local sales tax %"
                                            {if $loged.stax=='y' && !$projects.stax}
                                            value="{$loged.stax_per}"
                                            {/if}
                                            {if $projects.stax}
                                            value="{$projects.stax}"
                                            {/if}
                                            disabled >
                                        </div>
                                        {else}
                                        <div class="col-sm-6">
                                                Local Sales Tax
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="stax" placeholder="Local Sales tax(%)" name="stax" data-parsley-required-message="Please Enter local sales tax" data-parsley-min-message="Please enter local sales tax percentage 1 or more" data-parsley-type="number" data-parsley-trigger="change" data-parsley-type-message="please enter local sales tax %" disabled
                                            value="0"
                                            >
                                        </div>
                                        {/if}

                                        {if $loged.is_consultant_fee=='y'}
                                        <div class="col-sm-6">
                                            Sales Consultant Fee(%)
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="consultant_fee" placeholder="Sales Consultant Fee(%)" name="consultant_fee" data-parsley-required-message="Please Enter sales tax" data-parsley-required data-parsley-min="0" data-parsley-trigger="change" data-parsley-min-message="Please enter sales tax percentage 1 or more" data-parsley-type="number" data-parsley-type-message="please enter sales tax %"
                                            {if $loged.is_consultant_fee=='y' && !$projects.consultant_fee}
                                            value="{$loged.consultant_fee}"
                                            {/if}
                                            {if $projects.consultant_fee}
                                            value="{$projects.consultant_fee}"
                                            {/if}
                                            {if $projects.id>0}readonly{/if}
                                             >
                                        </div>
                                        {else}
                                        <div class="col-sm-6">
                                            Sales Consultant Fee(%)
                                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="consultant_fee" placeholder="Sales Consultant Fee(%)" name="consultant_fee" data-parsley-required-message="Please Enter sales tax" data-parsley-min-message="Please enter sales tax percentage 1 or more" data-parsley-type="number" data-parsley-trigger="change" data-parsley-type-message="please enter sales tax %" 
                                            value="0" disabled
                                            >
                                        </div>
                                        {/if}
                                    </div>
                                    <!-- ===================== end change by divyesh (changes) ===================== -->
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                              Category
                                              <select class="w100 p15 pb15 grey-bg border-0" name="category" id="loadcategorys" onchange="loadSubcategory1(this)" data-parsley-required data-parsley-required-message="Please select category" data-parsley-trigger="change" {if $projects.id>0}disabled{/if}>
                                                  <option class="black" value="">Select Category</option>
                                                  {foreach $category as $key => $val}
                                                      {if $val.parent_id == 0 && $val.ob_market==1}
                                                          <option class="" value="{$val.id}"
                                                          {if $projects.parent_category_id == $val.id} selected {/if} >{$val.name}
                                                          </option>
                                                      {/if}
                                                  {/foreach}
                                              </select>
                                              {if $projects.id>0}<input type="hidden" name="category" value="{$projects.parent_category_id}">{/if}
                                          </div>
                                          <div class="col-sm-6">
                                              Sub Category
                                              <select class="w100 p15 pb15 grey-bg border-0" id="subcategoriess" min="1" name="subcategory" data-parsley-required data-parsley-required-message="Please select subcategory" data-parsley-min-message="Please select subcategory" data-parsley-trigger="change" {if $projects.id>0}disabled{/if}>
                                                  <option id="subcats" value="">Sub Category</option>
                                              </select>
                                              {if $projects.id>0}<input type="hidden" name="subcategory" value="{$projects.subcategory}">{/if}
                                          </div>
                                       
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            Date Available
                                            <div class="inner-addon right-addon">
                                                <i class="glyphicon glyphicon-calendar"></i>
                                                <!--                                             <input class="w100 p15 pb15 grey-bg border-0" type="text" id="start_date" placeholder="Date Available" name="start_date"> -->
                                                <input class="w100 p15 pb15 grey-bg border-0" type="text" id="{if $projects.id<1}start_date2{/if}" readonly="readonly" placeholder="Date Available" name="start_date" data-parsley-required data-parsley-required-message="Please select date" value="{$projects.date_add}" data-parsley-trigger="change" {if $projects.id>0}readonly{/if}>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                             Order Type
                                            <select class="w100 p15 pb15 grey-bg border-0" name="order_type" data-parsley-required data-parsley-required-message="Please select order type" data-parsley-trigger="change" {if $projects.id>0}disabled{/if}>
                                                <option value="">Order Type</option>
                                                <option value="total" {if $projects.order_type=='total'} selected {/if} >Total Orders Only</option>
                                                <option value="partial" {if $projects.order_type=='partial'} selected {/if} >Partial Orders Allowed</option>
                                            </select>
                                            {if $projects.id>0}<input type="hidden" name="order_type" value="{$projects.order_type}">{/if}
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            Product Notes
                                            <textarea class="grey-bg w100 border-0 p15 pb15" placeholder="Take the time to tell buyers about your product (i.e cannabinoid profile, brand names, packaging, etc.) If you have no product description please insert None in this box." name="description" data-parsley-required data-parsley-required-message="Please enter description" rows="5" cols="80" data-parsley-trigger="change">{$projects.description}</textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <div class="text-center">
                                                <div>Product image</div>
                                                <div class="pro-thumb grey-bg flex margin-auto">
                                                    {if $projects.avatar != ''}
                                                    <img id="filec5" src="{$config.imgpath}product/{$projects.avatar}" class="img-responsive margin-auto" alt="">
                                                    {/if}
                                                    {if $projects.avatar == ''}
                                                    <img id="filec5" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="">
                                                    {/if}
                                                    {foreach $image as $ikey => $ival}
                                                        {if $ikey!=0}
                                                            <img id="filec55" src="{$config.imgpath}/product/{$ival.avatar}" class="new_images img-responsive margin-auto" alt="" accept="image/*">
                                                        {/if}
                                                    {/foreach}
                                                </div>
                                            </div>
                                            <div class="flex">
                                                <div class="margin-auto">
                                                    <span class="f12 m5"><i>Upload Item Images (*.jpeg, *.jpg, *.png etc.)</i></span>
                                                    <input type="file" id="filecount5" data-parsley-trigger="change" name="product_image" {if !$projects.id} data-parsley-required-message="Please upload product images" required{/if} multiple="multiple" data-parsley-trigger="change"  data-parsley-errors-container="#product_image1-err" accept="image/*"/>
                                                </div>
                                            </div><span id="product_image1-err" class="err-message"></span>
                                        </div>
                                    </div>

                                    
                                    {if $loged.business_type != 'grower' && $loged.business_type != 'producer'}
                                    <div class="form-group">
                                        <div class="col-sm-12 form-inline text-left">
                                            <label class="lab-clr">Do you need Herbee to store the product and manage the inventory as you sell it?</label>
                                              <div class="radio radio-inline radio-primary ">
                                                <input data-parsley-trigger="change focudsout" type="radio" name="store_prdt" id="store_prdt1" value="y"  tabindex="8" data-parsley-required {if $projects.store_prdt=='y'} checked="true" {/if}>
                                                <label for="{if $projects.id<1}store_prdt1{/if}"> Yes </label>
                                                <input data-parsley-trigger="change focusout" type="radio" name="store_prdt" id="store_prdt2" value="n" tabindex="9" data-parsley-required {if $projects.store_prdt=='n'} checked="true" {/if}>
                                                <label for="{if $projects.id<1}store_prdt2{/if}"> No </label>
                                              </div>
                                        </div>
                                    </div>
                                    <div class="form-group {if !$projects.store_prdt} hide {/if} {if $projects.store_prdt=='n'} hide {/if}" id="store_prdt_desc">
                                        <div class="col-sm-12 form-inline text-left">
                                            <label class="lab-clr"></label>
                                              <input type="text" class="w100 p15 pb15 grey-bg border-0" name="store_prdt_msg" value="{$projects.store_prdt_msg}" placeholder="Enter the service description" {if $projects.id>0}readonly{/if}>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <div class="col-sm-12 form-inline text-left">
                                            <label class="lab-clr">Is there a Certificate of Analysis for this product?</label>
                                              <div class="radio radio-inline radio-primary ">
                                                <input data-parsley-trigger="change focudsout" type="radio" name="cert_analysis" id="cert_analysis1" value="y"  tabindex="8" data-parsley-required  {if $projects.cert_analysis=='y'} checked="true" {/if}>
                                                <label for="{if $projects.id<1}cert_analysis1{/if}"> Yes </label>
                                                <input data-parsley-trigger="change focusout" type="radio" name="cert_analysis" id="cert_analysis2" value="n" tabindex="9"  data-parsley-required {if $projects.cert_analysis=='n'} checked="true" {/if}>
                                                <label for="{if $projects.id<1}cert_analysis2{/if}"> No </label>
                                              </div>
                                        </div>
                                    </div>
                                    <div class="form-group {if !$projects.cert_analysis} hide {/if} {if $projects.cert_analysis=='n'} hide {/if}" id="cert_analysis_upload">
                                        <div class="col-sm-12 text">
                                            <div class="pro-thumb grey-bg flex">
                                                <!-- <img id="filec5" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt=""> -->
                                            <!-- certs_analysis_length -->
                                            {if $certs_analysis_length > 0}
                                                <img id="filec4" src="{$config.imgpath}certificates/{$certs_analysis.avatar}" class="img-responsive margin-auto" alt="{$certs_analysis.image}" >
                                            {/if}
                                            {if $certs_analysis_length < 0}
                                            <img id="filec6" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="">
                                            {/if}
                                                <!-- <img id="filec5" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt=""> -->
                                            </div>
                                            <div class="flex">
                                                <div class="margin-auto">
                                                    <span class="f12 m5"><i>Upload Item Images (*.jpeg, *.jpg, *.png etc.)</i></span>
                                                    <input type="file" id="filecount6" data-parsley-trigger="change" name="cert_analysis_img" {if !$projects.id} data-parsley-required-message="Please upload certificate analysis report" required{/if} multiple="multiple" data-parsley-trigger="change"  data-parsley-errors-container="#cert_analysis-err" accept="image/*"/>
                                                </div>
                                            </div><span id="cert_analysis-err" class="err-message"></span>
                                        </div>
                                    </div>
                                    {/if}
                                    {if $loged.business_type == 'grower' || $loged.business_type == 'producer'}
                                    <div class="form-group">
                                        <div class="col-sm-12 form-inline text-left">
                                            <label class="lab-clr">Is Herbee your distributor or transporter?</label>
                                              <div class="radio radio-inline radio-primary ">
                                                <input data-parsley-trigger="change focudsout" type="radio" name="default_distributor" id="default_distributor1" value="y"  tabindex="8" data-parsley-required {if $projects.default_distributor=='y'} checked="true" {/if}>
                                                <label for="{if $projects.id<1}default_distributor1{/if}"> Yes </label>
                                                <input data-parsley-trigger="change focusout" type="radio" name="default_distributor" id="default_distributor2" value="n" tabindex="9"  data-parsley-required {if $projects.default_distributor=='n'} checked="true" {/if}>
                                                <label for="{if $projects.id<1}default_distributor2{/if}"> No </label>
                                              </div>
                                        </div>
                                    </div>
                                    <div class="form-group" id="default_distributor_no">
                                        <div class="col-sm-12 form-inline text-left">
                                            <label class="lab-clr">You will be responsible for all distribution and transportation of this product.</label>
                                        </div>
                                    </div>
                                    <div class="form-group" id="default_distributor_yes">
                                        <div class="col-sm-12 form-inline text-left">
                                             <label class="lab-clr">Is your product at a Herbee facility?</label>
                                              <div class="radio radio-inline radio-primary ">
                                                <input data-parsley-trigger="change focudsout" type="radio" name="herbee_facility_status" id="herbee_facility_status1" value="y"  tabindex="8" data-parsley-required {if $projects.herbee_facility_status=='y'} checked="true" {/if}>
                                                <label for="{if $projects.id<1}herbee_facility_status1{/if}"> Yes </label>
                                                <input data-parsley-trigger="change focusout" type="radio" name="herbee_facility_status" id="herbee_facility_status2" value="n" tabindex="9"  data-parsley-required {if $projects.herbee_facility_status=='n'} checked="true" {/if}>
                                                <label for="{if $projects.id<1}herbee_facility_status2{/if}"> No </label>
                                              </div>
                                        </div>
                                    </div>
                                    <div class="form-group" id="additional_service_status">
                                        <div class="col-sm-12 form-inline text-left">
                                            <label class="lab-clr">Do you need any additional product-related services for your product (i.e. Manufacturing, Finishing Packaging, Sequencing, Labeling, etc.)?</label>
                                              <div class="radio radio-inline radio-primary ">
                                                <input data-parsley-trigger="change focudsout" type="radio" name="additional_service" id="additional_service1" value="y"  tabindex="8"  data-parsley-required {if $projects.additional_service=='y'} checked="true" {/if}>
                                                <label for="{if $projects.id<1}additional_service1{/if}"> Yes </label>
                                                <input data-parsley-trigger="change focusout" type="radio" name="additional_service" id="additional_service2" value="n" tabindex="9"  data-parsley-required {if $projects.additional_service=='n'} checked="true" {/if}>
                                                <label for="{if $projects.id<1}additional_service2{/if}"> No </label>
                                              </div>
                                        </div>
                                    </div>

                                    <div class="form-group" id="additional_service_types">
                                        <div class="col-sm-12 form-inline text-left">
                                            <label class="lab-clr"></label>
                                              <input type="text" class="w100 p15 pb15 grey-bg border-0" name="additional_service_type" value="{$projects.additional_service_type}" placeholder="Please describe the additional product-related services needed. A Herbee Administrator will contact you shortly." {if $projects.id>0}readonly{/if}>
                                        </div>
                                    </div>

<!--                                     <div class="form-group" id="additional_service_types">
                                            <div class="col-sm-12 form-inline text-left">
                                                <label class="lab-clr"></label>
                                                  <input type="text" class="w100 p15 pb15 grey-bg border-0" name="interim_testing_status_msg" value="{$projects.interim_testing_status_msg}" placeholder="Enter the service description">
                                            </div>
                                        </div> -->

                                    
                                    {if $loged.business_type == 'grower' || $loged.business_type == 'producer'}
                                        <div class="form-group cultivation_tax_section {if !$projects.pc_name} hide {/if}{if $projects.pc_name=='Flower'} hide {/if}">
                                            <div class="col-sm-12 form-inline text-left">
                                                <label class="lab-clr">Has the cultivation tax been previously paid on this product?</label>
                                                  <div class="radio radio-inline radio-primary ">
                                                    <input data-parsley-trigger="change focudsout" type="radio" name="cultivation_tax_status" id="cult_tax_status1" value="y"  tabindex="8" {if $projects.cultivation_tax_status=='y'} checked="true" {/if}>
                                                    <label for="{if $projects.id<1}cult_tax_status1{/if}"> Yes </label>
                                                    <input data-parsley-trigger="change focusout" type="radio" name="cultivation_tax_status" id="cult_tax_status2" value="n" tabindex="9"  {if $projects.cultivation_tax_status=='n'} checked="true" {/if}>
                                                    <label for="{if $projects.id<1}cult_tax_status2{/if}"> No </label>
                                                  </div>
                                            </div>
                                        </div>
                                    {/if}
                                    {/if}
                                    <div class="row flex">
                                        <div class="col-sm-12 text-right" >
                                            <button id="post_submit" class="btn btn-default btn-d-b green-b post_submit_sell" type="button" onclick="checkProductDetails()">{if $projects.id}Update{/if}{if !$projects.id}Post{/if}</button>
                                        </div>
                                    </div>
                                </form>
                        </div>
                    </div>
                </div>
            </div>
                </div> </div>
    </div>
</div>
<!-- / page content  -->
{include file="/common/footer-1.tpl" nocache}
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>
<!-- loading subcategory -->
<script type="text/javascript">


function checkProductDetails(){
console.log('$(.add-product-sell).parsley().validate()', $('.add-product-sell').parsley().validate());
    if(true === $('.add-product-sell').parsley().validate())
    {

        $('.post_submit_sell').attr("disabled", true);
        $('.add-product-sell').submit();
    }else{
        return false;
    }
}

function checkProductDetailsBuy(){
    if(true === $('.add-product-buy').parsley().isValid())
    {

        $('.btn-submit-buy').attr("disabled", true);
        $('.add-product-buy').submit();
    }else{
        return false;
    }
}

var myVar;

  function myFunction() {
      myVar = setTimeout(showPage, 2000);
  }

  function showPage() {
    document.getElementById("loader-new").style.display = "none";
    document.getElementById("loadData").style.display = "block";
  }

  $('input[name=store_prdt]').on('change', function(e) {
    if($(this).val() == 'y'){
        $("#store_prdt_desc").removeClass('hide');
    } else {
        $("#store_prdt_desc").addClass('hide');
    }
  });

  $('input[name=interim_testing_status]').on('change', function(e) {
      console.log('$(this).val() == y', $(this).val() == 'y');
    if($(this).val() == 'y'){
        $("#interim_testing_status_desc").removeClass('hide');
    } else {
        $("#interim_testing_status_desc").addClass('hide');
    }
  });
  $('input[name=cert_analysis]').on('change', function(e) {
    if($(this).val() == 'y'){
        $("#cert_analysis_upload").removeClass('hide');
    } else {
        $("#cert_analysis_upload").addClass('hide');
    }
  });
  $('input[name=additional_service]').on('change', function(e) {
    if($(this).val() == 'y'){
        $("#additional_service_types").removeClass('hide');
        $("#additional_service_type").attr('data-parsley-required','true');
        
    } else {
        $("#additional_service_types").addClass('hide');
        $("#additional_service_type").removeAttr('data-parsley-required');

    }
  });

if($('#loadcategory').val() == ''){
    $('#subcategories').html('');
    $('#subcategories').append( '<option value="0">Sub Category</option>' );
     /* $('#subcategories option').hide();
      $('#subcat').show();*/
}



function loadSubcategory(cur) {
       $('#subcategories').html('');
        $('#subcategories').append( '<option value="0">Sub Category</option>' );
    var pcid = $(cur).val();
  $.ajax({
      type : 'POST',
       dataType : 'json',
      url : '/getchildcat',
      data : 'catid='+$(cur).val(),
      success : function(data) {
        for (var i = 0; i < data.subcat.length; i++) {
            var catsid = data.subcat[i].id;
            var catname = data.subcat[i].name;
            if (data.subcat[i].parent_id == pcid) {
            $('#subcategories').append( '<option value="'+catsid+'" pid="'+pcid+'" {if $projects.category_id == "'+catsid+'"} selected {/if}>'+catname+'</option>' );
          }
        }
        $('#subcategories option[value="{$projects.category_id}"]').attr('selected','selected');


         }
      });
}

if($('#loadcategorys').val() == ''){
     $('#subcategoriess').html('');
        $('#subcategoriess').append( '<option value="0">Sub Category</option>' );
 /* $('#subcategoriess option').hide();
  $('#subcats').show();*/
}

function loadSubcategory1(cur) {
     $('#subcategoriess').html('');
        $('#subcategoriess').append( '<option value="0">Sub Category</option>' );
    var pcid = $(cur).val();

        if($(cur).val() == '101' || $(cur).val() == '134'){
            $('.cultivation_tax_section').removeClass('hide');
            $('.cultivation_tax_section input').attr('data-parsley-required','true');
        } else {
             $('.cultivation_tax_section').addClass('hide');
             $('.cultivation_tax_section').attr('data-parsley-required','false');
        }

  $.ajax({
    
      type : 'POST',
       dataType : 'json',
      url : '/getchildcat',
      data : 'catid='+$(cur).val(),
      success : function(data) {
        for (var i = 0; i < data.subcat.length; i++) {
            var catsid = data.subcat[i].id;
            var catname = data.subcat[i].name;
            if (data.subcat[i].parent_id == pcid) {
            $('#subcategoriess').append( '<option value="'+catsid+'" pid="'+pcid+'" {if $projects.category_id == "'+catsid+'"} selected {/if}>'+catname+'</option>' );
          }
        }
        $('#subcategoriess option[value="{$projects.category_id}"]').attr('selected','selected');


         }
      });



   //console.log("subcategory");
    /*$('#subcategoriess option').hide();
    $('#subcategoriess').val("");
    $('#subcategoriess option[pid="' + $(cur).val() + '"]').show();*/
}
</script>
<script type="text/javascript">
/* jquery datepicker - Date available */

$("#start_date1").datetimepicker({
    // timepicker:false,
    format:'m/d/Y H:m',
    step: 5,
    minDate: 0,
    minTime: 0
});
$("#start_date2").datetimepicker({
    // ttimepicker:false,
    format:'m/d/Y H:m',
    step: 5,
    minDate: 0,
    minTime: 0
});
// $("#start_date2").datetimepicker({minDate:'0'});

$(function() {

    /* if cannabis type is already checked */
    if ($('input[name=cannabis_type]:checked').val() == "y") {
            $('.testresult').show();
            $('input[name=test_result_types]').attr('data-parsley-required', 'true');
            $('input[name=test_results]').attr('data-parsley-required', 'true');
    } else{ 
            $('.testresult').hide();
            $('input[name=test_result_types]').attr('data-parsley-required', 'false');
            $('input[name=test_results]').attr('data-parsley-required', 'false');
    }


    /* if cannabis_type is checked or not */
    $("input[name=cannabis_type]:radio").click(function() {
        if ($('input[name=cannabis_type]:checked').val() == "y") {
            $('.testresult').show();
            $('input[name=test_result_types]').attr('data-parsley-required', 'true');

        } else if ($('input[name=cannabis_type]:checked').val() == "n") {
            $('.testresult').hide();
            $('input[name=test_result_types]').attr('data-parsley-required', 'false');
        }
    });



    /* Checking for input[name=test_result_types] */
    if ($('select[name=test_result_types]').val() == "none") {
            $('.testresult2').show();
            $('input[name=interim_testing_status]').attr('data-parsley-required', 'true');
    } else {
            $('.testresult2').hide();
            $('input[name=interim_testing_status]').attr('data-parsley-required', 'false');
    }

    $("select[name=test_result_types]").change(function() {
        console.log($('select[name=test_result_types]').val());
        if ($('select[name=test_result_types]').val() == "none") {
                $('.testresult2').show();
                $('input[name=interim_testing_status]').attr('data-parsley-required', 'true');
                $(".testresult").find('.test-result').hide();
        } else {
                $('.testresult2').hide();
                $('input[name=interim_testing_status]').attr('data-parsley-required', 'false');
                $(".testresult").find('.test-result').show();
        }
    });



    /* if input[name=additional_service] is already checked or not */
    if ($('input[name=additional_service]:checked').val() == "y") {
        $('#additional_service_types').show();
    } else {
        $('#additional_service_types').hide();
    }

    /* if input[name=additional_service] is checked or not */
    $("input[name=additional_service]:radio").click(function() {
        if ($('input[name=additional_service]:checked').val() == "y") {
            $('#additional_service_types').show();

        } else if ($('input[name=additional_service]:checked').val() == "n") {
            $('#additional_service_types').hide();
        }
    });

    /* Checking for input[name=herbee_facility_status] */
    if ($('input[name=herbee_facility_status]:checked').val() == "y") {
            $('#additional_service_status').show();
        } else $('#additional_service_status').hide();


    $("input[name=herbee_facility_status]:radio").click(function() {
        if ($('input[name=herbee_facility_status]:checked').val() == "y") {
            $('#additional_service_status').show();

        } else if ($('input[name=herbee_facility_status]:checked').val() == "n") {
            $('#additional_service_status').hide();
        }
    });


    /* Checking for input[name=default_distributor] */
    if ($('input[name=default_distributor]:checked').val() == "y") {
        $('#default_distributor_no').hide()
        $('#default_distributor_yes').show()
    } else if ($('input[name=default_distributor]:checked').val() == "n") {
         $('#default_distributor_yes').hide()
        $('#default_distributor_no').show()
    } else {
        $('#default_distributor_no').hide()
        $('#default_distributor_yes').hide()
    }


    $("input[name=default_distributor]:radio").click(function() {
        if ($('input[name=default_distributor]:checked').val() == "y") {
            $('#default_distributor_no').hide()
            $('#default_distributor_yes').show()
        } else if ($('input[name=default_distributor]:checked').val() == "n") {
             $('#default_distributor_no').show()
            $('#default_distributor_yes').hide()
        }
    })
    // alert($("#mydatepickertime").length);
});
</script>
<script>
$('#filecount6').filestyle({
    input: false,
    buttonName: 'btn btn-default btn-d-b btn-d-g m5',
    iconName: '',
    buttonText: 'UPLOAD'
});

$('#filecount2').filestyle({
    input: false,
    buttonName: 'btn btn-default btn-d-b btn-d-g m5',
    iconName: '',
    buttonText: 'UPLOAD'
});

$('#filecount3').filestyle({
    input: false,
    buttonName: 'btn btn-default btn-d-b btn-d-g m5 w100',
    iconName: '',
    buttonText: 'UPLOAD'
});

$('#filecount4').filestyle({
    input: false,
    buttonName: 'btn btn-default btn-d-b btn-d-g m5',
    iconName: '',
    buttonText: 'UPLOAD'
});

$('#filecount5').filestyle({
    input: false,
    buttonName: 'btn btn-default btn-d-b btn-d-g m5 w100',
    iconName: '',
    buttonText: 'UPLOAD'
});
</script>

{if $loged.business_type == 'grower' || $loged.business_type == 'producer'} 
<script>
/* For certificate analysis */
document.getElementById("filecount6").onchange = function() {
    console.log('file uploading --- filecount6 -- ');
     if(projectLoad2(this)){
        document.getElementById("filec6").src = '';
        var reader = new FileReader();

        reader.onload = function(e) {
            // get loaded data and render thumbnail.
            document.getElementById("filec6").src = e.target.result;
        };
        $("#filecount6").parent().find('ul').hide();
        // read the image file as a data URL.
        reader.readAsDataURL(this.files[0]);
    } else {
        $(this).val('');
        $(this).parents().find(".badge").remove();
        document.getElementById("filec6").src = "{$config.url}/images/upload-img.png"
        // error message here
        // alert("not an image");
    }
}
</script>
{/if}

<script>
/* For cannabis test results */
document.getElementById("filecount4").onchange = function() {
    if(projectLoad2(this)){
        document.getElementById("filec4").src = '';
        var reader = new FileReader();

        reader.onload = function(e) {
            // get loaded data and render thumbnail.
            document.getElementById("filec4").src = e.target.result;
        };
        $("#filecount4").parent().find('ul').hide();
        // read the image file as a data URL.
        reader.readAsDataURL(this.files[0]);
    } else {
        $(this).val('');
        $(this).parents().find(".badge").remove();
        document.getElementById("filec4").src = "{$config.url}/images/upload-img.png"
        // error message here
        // alert("not an image");
    }
}


$(document).ready(function (){    
    $("#checkfields").click(function (){
        //var modelname=$("#inputmodelname").val();
    });
});


document.getElementById("filecount5").onchange = function() {
  // console.log($(this).get(0).files);
  //   console.log("before for");
  //   console.log(projectLoad1(this));

  if(projectLoad1(this)){
        /* document.getElementById("filec5").src = '';
        var reader = new FileReader();

        reader.onload = function(e) {
            // get loaded data and render thumbnail.
            document.getElementById("filec5").src = e.target.result;
        };
        $("#filecount5").parent().find('ul').hide();
        // read the image file as a data URL.
        reader.readAsDataURL(this.files[0]);
        console.log("com");
        console.log("after for"); */

        $(".new_images").remove();
        for (let index = 0; index < this.files.length; index++) {
            const element = this.files[index];
            
            document.getElementById("filec5").src = '';
            var reader = new FileReader();
            reader.onload = function(e) {
            if(index == 0) {
                document.getElementById("filec5").src = e.target.result;
            } else {
                var img = '<img id="filec55" src="'+e.target.result+'" class="new_images img-responsive margin-auto" alt="" accept="image/*">';
                $("#filec5").after(img);
            }
            };
            reader.readAsDataURL(element);
        }
        $("#filecount2").parent().find('ul').hide();
    } else {
        $(this).val('');
        $(this).parents().find(".badge").remove();
        document.getElementById("filec5").src = "{$config.url}/images/upload-img.png"
        // error message here
        // alert("not an image");
    }
                
};
</script>
<script>
document.getElementById("filecount2").onchange = function() {

    if(projectLoad1(this)){

        /* document.getElementById("filec2").src = '';
        var reader = new FileReader();

        reader.onload = function(e) {
            // get loaded data and render thumbnail.
            document.getElementById("filec2").src = e.target.result;
        };
        $("#filecount2").parent().find('ul').hide();
        // read the image file as a data URL.
        reader.readAsDataURL(this.files[0]); */

        $(".new_images").remove();
        for (let index = 0; index < this.files.length; index++) {
            const element = this.files[index];
            
            document.getElementById("filec2").src = '';
            var reader = new FileReader();
            reader.onload = function(e) {
            if(index == 0) {
                document.getElementById("filec2").src = e.target.result;
            } else {
                var img = '<img id="filec22" src="'+e.target.result+'" class="new_images img-responsive margin-auto" alt="" accept="image/*">';
                $("#filec2").after(img);
            }
            };
            reader.readAsDataURL(element);
        }
        $("#filecount2").parent().find('ul').hide();
        
    } else {
        $(this).val('');
        $(this).parents().find(".badge").remove();
        document.getElementById("filec2").src = "{$config.url}/images/upload-img.png"
    }

};

// $("input[type=file]").change(function() {

//     var val = $(this).val();

//     switch(val.substring(val.lastIndexOf('.') + 1).toLowerCase()){
//         case 'gif': case 'jpg': case 'png': case 'jpeg':
//         $('#post_submit').prop('disabled',false);
//             break;
//         default:
//             $(this).val('');
//             // error message here
//             $('#post_submit').prop('disabled','true');
//             alert("not an image");
//             break;
//     }
// });
</script>

{if $projects.id > 0}
<script>
$('#loadcategory').val({$projects.parent_category_id}).change();
$('#loadcategorys').val({$projects.parent_category_id}).change();
</script>
{/if}

</body>

</html>
